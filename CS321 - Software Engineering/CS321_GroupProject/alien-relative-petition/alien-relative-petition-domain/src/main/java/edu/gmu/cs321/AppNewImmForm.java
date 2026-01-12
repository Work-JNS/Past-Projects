//TODO: Overall testing after integration

//TODO: add return to getWork after no work notfication


package edu.gmu.cs321;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//to-do update for your class 
@WebServlet(name = "AppNewImmForm", urlPatterns ="/appNewImmForm")
public class AppNewImmForm extends HttpServlet {
	@Override
  	public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException {

	

    //to-do replace 10 with your group number
    Integer formid = WFUtil.getformfromWF("Approve",  19);
	System.out.println("Got formID: "+formid);

	try{
		if (formid > 0){
			NewImmForm form = Database.getNewImmForm(formid);
			Immigrant petitioner = Database.getImmigrant(form.getPetitionerANum());
			Immigrant dependent = Database.getImmigrant(form.getDependentANum());

			
			if(form == null || petitioner == null || dependent == null){
				response.getWriter().println("ALL NULL.");
			}
			
			//sample data
			String pFname = petitioner.getFirstName();
			String pLname = petitioner.getLastName();
			String pDOB = petitioner.getDateOfBirth().toString();
			
			String dFname = dependent.getFirstName();
			String dLname = dependent.getLastName();
			String dDOB = dependent.getDateOfBirth().toString();

			
			//recreate the entire review form here as a getWriter using this sample code
			// Note the backslash in front of the quotes
			response.getWriter().println("<!DOCTYPE html>");
			response.getWriter().println("<html>");
			response.getWriter().println("<head>");
			response.getWriter().println("<title>Approve Dependent Petition Form</title>");
			response.getWriter().println(
				"  <style>"
				+ " body { background-color: #222; color: #eee; font-family: Arial; text-align: center; }"
				+ " h1, h2 { color: #fff; }"
				+ " .container { width: 50%; margin: auto; }"
				+ " input[type='text'] { width: 80%; padding: 10px; font-size: 18px; margin: 8px 0; }"
				+ " input[type='submit'] { padding: 12px 20px; font-size: 18px; }"
				+ "</style>"
			);
			response.getWriter().println("</head>");

			response.getWriter().println("<body>");
			response.getWriter().println("<h1>Approve Form Data</h1>");

			response.getWriter().println("<div class='container'>");
			response.getWriter().println("<form action=\"/alien-relative-petition-domain/appNewImmForm\" method=\"POST\">");

			response.getWriter().println("<input type=\"hidden\" id=\"formid\" name=\"formid\" value=\"" + formid + "\">");

			response.getWriter().println("<h2>Petitioner Data</h2>");
			response.getWriter().println("<input type=\"text\" name=\"pFname\" value=\"" + pFname + "\" readonly>");
			response.getWriter().println("<input type=\"text\" name=\"pLname\" value=\"" + pLname + "\" readonly>");
			response.getWriter().println("<input type=\"text\" name=\"pDOB\" value=\"" + pDOB + "\" readonly>");

			response.getWriter().println("<h2>Dependent Data</h2>");
			response.getWriter().println("<input type=\"text\" name=\"dFname\" value=\"" + dFname + "\" readonly>");
			response.getWriter().println("<input type=\"text\" name=\"dLname\" value=\"" + dLname + "\" readonly>");
			response.getWriter().println("<input type=\"text\" name=\"dDOB\" value=\"" + dDOB + "\" readonly>");

			response.getWriter().println("<br><br>");
			response.getWriter().println("<input type=\"submit\" name=\"action\" value=\"Approve\">");
			response.getWriter().println("&nbsp;&nbsp;");
			response.getWriter().println("<input type=\"submit\" name=\"action\" value=\"Reject\">");

			response.getWriter().println("</form>");
			response.getWriter().println("</div>");

			response.getWriter().println("</body>");
			response.getWriter().println("</html>");
		}else{response.getWriter().println("No forms to be approved.");}

	}catch(IOException e){System.err.println(e);}
}



	private void PostHelper(HttpServletResponse response, String action, String formid)throws IOException{
		int formID;
		try{formID = Integer.parseInt(formid);}
		catch(NumberFormatException e){
			response.getWriter().println("Error:"+formid+" is not a valid form");
			return;
		}


		if (action == null || formid == null){
			response.getWriter().println("<h1>request parameters are null</h1>");
			return;
		}else{
			
			response.getWriter().println(formid);

			if("Approve".equals(action)){
				response.getWriter().println("Form Approved");
			}else if ("Reject".equals(action)){
				response.getWriter().println("Form Rejected");
				WFUtil.addformtoWF(formID, "Review", 19);
			}
		}

		response.sendRedirect("/approver.html");

	}

	@Override
  	public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException {
		String action = request.getParameter("action");
		String formid = request.getParameter("formid");
		try{PostHelper(response, action, formid);}
		catch(IOException e){System.err.println(e);}
	}

}
