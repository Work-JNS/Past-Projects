package edu.gmu.cs321;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ReviewImmForm", urlPatterns = "/reviewImmForm")
public class ReviewImmForm extends HttpServlet {
        private final static int groupID = 19;

        private void setupTest() {

                Database.truncateTables();

                Immigrant petitioner = Immigrant.addImmigrant("123", "pet", "ition", 123, new Date(100), false);

                Immigrant dep = Immigrant.addImmigrant("321", "dep", "end", 321, new Date(200), true);
                Database.createImmigrant(petitioner);
                Database.createImmigrant(dep);
                NewImmForm form = NewImmForm.addNewImmForm(1, petitioner, dep);
                int formID = Database.createImmForm(form);

                WFUtil.addformtoWF(formID, "Review", 19);
        }

        @Override
        public void doGet(HttpServletRequest request, HttpServletResponse response)
                        throws IOException {

                // to-do option - in case data entry is not done, this adds a record to workflow
                // to retrieve
                // then manually add the formid and ImmigrantID to your forms table to get data
                // for the
                // not in sample sequence diagram as temporary code
                // Integer wf_code = WFUtil.addformtoWF(12, "Review", groupID);
                //setupTest();

                Integer formid = WFUtil.getformfromWF("Review", groupID);

                if (formid > 0) {
                        NewImmForm form = Database.getNewImmForm(formid);
                        Immigrant petitioner = Database.getImmigrant(form.getPetitionerANum());
                        Immigrant dep = Database.getImmigrant(form.getDependentANum());

                        if (form == null || petitioner == null || dep == null) {
                                response.getWriter().println("No forms to be approved.");
                        }

                        String petFName = petitioner.getFirstName();
                        String petLName = petitioner.getLastName();
                        String petDOB = petitioner.getDateOfBirth().toString();

                        String depFName = dep.getFirstName();
                        String depLName = dep.getLastName();
                        String depDOB = dep.getDateOfBirth().toString();

                        response.getWriter().println("");
                        response.getWriter().println("<!DOCTYPE html>");
                        response.getWriter().println("<html lang=\"en\">");
                        response.getWriter().println(" <head>");
                        response.getWriter().println("<meta charset=\"UTF-8\">");
                        response.getWriter().println(
                                        "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");

                        response.getWriter().println("   <title>Review Submitted Petition" + formid + "</title>");
                        response.getWriter().println(
                                        "<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600' rel='stylesheet' type='text/css'>");
                        response.getWriter().println(
                                        "<link href=\"https://fonts.googleapis.com/css?family=Roboto:300,400,500,700\" rel=\"stylesheet\">");
                        response.getWriter().println("<style>\n" +
                                        "        html,\n" +
                                        "        body {\n" +
                                        "            height: 100%;\n" +
                                        "            margin-left: 1%;\n" +
                                        "            font-family: Roboto, Arial, sans-serif;\n" +
                                        "            font-size: 16px;\n" +
                                        "            color: #eee;\n" +
                                        "            background-color: #2d2d2d;\n" +
                                        "        }\n" +
                                        "        input[type=\"submit\"] {\n" +
                                        "            font-size: 16px;\n" +
                                        "            font-weight: 600;\n" +
                                        "            color: #fff;\n" +
                                        "            background-color: #1c87c9;\n" +
                                        "            border: none;\n" +
                                        "            border-radius: 8px;\n" +
                                        "            cursor: pointer;\n" +
                                        "            transition: background-color 0.3s, transform 0.2s;\n" +
                                        "            display: inline-block;\n" +
                                        "            white-space: nowrap;\n" +
                                        "        }\n" +
                                        "        input[type=\"submit\"]:hover {\n" +
                                        "            background-color: #095484;\n" +
                                        "            transform: translateY(-2px);\n" +
                                        "        }\n" +
                                        "        input[type=\"text\"],\n" +
                                        "        input[type=\"date\"] {\n" +
                                        "            padding: 10px 0px 10px 10px;\n" +
                                        "        }\n" +
                                        "        .form-container {\n" +
                                        "            width: 75%;\n" +
                                        "            background: rgba(0, 0, 0, 0.9);\n" +
                                        "            padding: 25px;\n" +
                                        "            border-radius: 10px;\n" +
                                        "            margin: auto;\n" +
                                        "            box-shadow: 0 0 10px rgba(0, 0, 0, 0.7);\n" +
                                        "            justify-content: left;\n" +
                                        "        }\n" +
                                        "        .input {\n" +
                                        "            display: flex;\n" +
                                        "            flex-direction: column;\n" +
                                        "            gap: 10px;\n" +
                                        "        }\n" +
                                        "        input {\n" +
                                        "            padding: 10px;\n" +
                                        "            background: transparent;\n" +
                                        "            border: none;\n" +
                                        "            border-bottom: 2px solid #eee;\n" +
                                        "            width: 100%;\n" +
                                        "            color: #eee;\n" +
                                        "        }\n" +
                                        "    </style>");

                        response.getWriter().println("  </head>");
                        response.getWriter().println("  <body>");
                        response.getWriter().println("    <h1>Review Immigrant Form Data:</h1>");

                        response.getWriter().println(
                                        "    <form action=\"/alien-relative-petition-domain/reviewImmForm\" method=\"POST\">");
                        response.getWriter().println("    <div class=\"form-container\">");
                        response.getWriter().println("      <label for=\"pANum\">Petitoner ANum [read-only]:</label>");
                        response.getWriter().println("      <input type=\"text\" id=\"pANum\" name=\"pANum\" value=\""
                                        + petitioner.getA_Number() + "\" readonly><br><br>");

                        response.getWriter().println("      <label for=\"pFirstName\">Petitioner First Name:</label>");
                        response.getWriter().println(
                                        "      <input type=\"text\" id=\"pFirstName\" name=\"pFirstName\" value="
                                                        + petFName + "><br><br>");
                        response.getWriter().println("      <label for=\"pLastName\">Petitioner Last Name:</label>");
                        response.getWriter().println(
                                        "      <input type=\"text\" id=\"pLastName\" name=\"pLastName\" value="
                                                        + petLName + "><br><br>");

                        response.getWriter().println("      <label for=\"pDOB\">Petitioner DOB:</label>");
                        response.getWriter().println(
                                        "      <input type=\"date\" id=\"pDOB\" name=\"pDOB\" value=" + petDOB
                                                        + "><br><br>");

                        response.getWriter().println("<br>");

                        response.getWriter().println("      <label for=\"dANum\">Dependent ANum [read-only]:</label>");
                        response.getWriter().println("      <input type=\"text\" id=\"dANum\" name=\"dANum\" value=\""
                                        + dep.getA_Number() + "\" readonly><br><br>");

                        response.getWriter().println("      <label for=\"dFirstName\">Dependent First Name:</label>");
                        response.getWriter().println(
                                        "      <input type=\"text\" id=\"dFirstName\" name=\"dFirstName\" value="
                                                        + depFName + "><br><br>");
                        response.getWriter().println("      <label for=\"dLastName\">Dependent Last Name:</label>");
                        response.getWriter().println(
                                        "      <input type=\"text\" id=\"dLastName\" name=\"dLastName\" value="
                                                        + depLName + "><br><br>");

                        response.getWriter().println("      <label for=\"dDOB\">Dependent DOB:</label>");
                        response.getWriter().println(
                                        "      <input type=\"date\" id=\"dDOB\" name=\"dDOB\" value=" + depDOB
                                                        + "><br><br>");

                        response.getWriter().println(
                                        "      <input type=\"hidden\" id=\"formid\" name=\"formid\" value=\"" + formid
                                                        + "\"><br><br>");

                        response.getWriter().println("      <input type=\"submit\" value=\"Submit\">");
                        response.getWriter().println("      </div>");
                        response.getWriter().println("    </form>");
                        response.getWriter().println("  </body>");
                        response.getWriter().println("</html>");
                } else {
                        response.getWriter().println("No forms for review found.");
                }
        }

        @Override
        public void doPost(HttpServletRequest request, HttpServletResponse response)
                        throws IOException {

                // if you need to add debugging statements, use this command below and these
                // will show up in the Tomcat console
                // concatenate the string to include variable values
                //System.out.println("Started reviewing an ImmForm");
                response.getWriter().println("<h1>Form Reviewed</h1>");
                response.getWriter().println("<h1>.</h1>");
                response.getWriter().println("<h1>.</h1>");
                response.getWriter().println("<h1>.</h1>");

                String petFName = request.getParameter("pFirstName");
                String petLName = request.getParameter("pLastName");
                String pDOB = request.getParameter("pDOB");
                Date petDOB = Date.valueOf(pDOB);

                String depFName = request.getParameter("dFirstName");
                String depLName = request.getParameter("dLastName");
                String dDOB = request.getParameter("dDOB");
                Date depDOB = Date.valueOf(dDOB);

                String fID = request.getParameter("formid");
                int formID;
                try {
                        formID = Integer.parseInt(fID);
                } catch (NumberFormatException e) {
                        System.out.println("Error:" + fID + " is not a valid formID");
                        return;
                }

                NewImmForm form = Database.getNewImmForm(formID);
                String petANum = form.getPetitionerANum();
                String depANum = form.getDependentANum();

                // start validation
                ArrayList<String> validationErrors = Validation.validateReviewedInfo(petFName, petLName, petDOB,
                                petANum,
                                depFName, depLName, depDOB, depANum);

                // If there are validation errors, print them out and add the form back to the review workflow
                if (!validationErrors.isEmpty()) {
                        response.getWriter().println("<h1>Validation failed.</h1>");
                        for (String e : validationErrors) {
                                response.getWriter().println("<h1>" + e + "</h1>");
                        }
                        WFUtil.addformtoWF(formID, "Review", groupID);
                } else {
                        Immigrant petitioner = Database.getImmigrant(form.getPetitionerANum());
                        petitioner.updateImmigrant(petFName, petLName, pDOB);
                        Database.updateImmigrant(petitioner);
                        Immigrant dep = Database.getImmigrant(form.getDependentANum());
                        dep.updateImmigrant(depFName, depLName, dDOB);
                        Database.updateImmigrant(dep);
                        response.getWriter().println("<h1>Validation passed!</h1>");
                         
                        Integer wf_code = WFUtil.addformtoWF(formID, "Approve", groupID);
                        if (wf_code == 0) {
                                response.getWriter().println("<h1>Form successfully sent for approval!</h1>");
                        } else {
                                // in a real system, the code would be translated to an error message
                                response.getWriter().println("<h1>Form not added to Workflow with error code " + wf_code
                                                + "! If -3 and using sample code, manually delete from workflow table per instructions</h1>");
                        }
                }
                //Return to reviewer.html after either validation success or failure
                response.getWriter().println("<style>\n" +
                                                "  a {\n" +
                                                "    color: #000;\n" +
                                                "  }\n" +
                                                "  a:visited {\n" +
                                                "    color: #000;\n" +
                                                "  }\n" +
                                                "</style>");
                response.getWriter().println("<a href=\"/reviewer.html\" style=\"display:inline-block; padding:5px 10px; background-color:#CBCACE; text-decoration:none; border-radius:4px;\">Next</a>");
        }
}