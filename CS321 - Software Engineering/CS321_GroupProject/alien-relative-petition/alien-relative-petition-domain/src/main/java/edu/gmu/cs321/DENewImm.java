package edu.gmu.cs321;

import java.sql.Date;
import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DENewImmForm", urlPatterns ="/DEnewImmForm")
public class DENewImm extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) 
    throws ServletException, IOException {

        /* Petitioner's Information */
        String petitionerFirstName = req.getParameter("petitionerFirstName");
        String petitionerLastName = req.getParameter("petitionerLastName");
        Date petitionerDOB = Date.valueOf(req.getParameter("petitionerDOB"));
        String petitionerANumm = req.getParameter("petitionerANumm");

        /* Dependent's Information */
        String dependentFirstName = req.getParameter("dependentFirstName");
        String dependentLastName = req.getParameter("dependentLastName");
        Date dependentDOB = Date.valueOf(req.getParameter("dependentDOB"));
        String dependentANumm = req.getParameter("dependentANumm");

        System.out.println("Started immigrant creation process.\n");

        /* Validates the info provided in data entry. */
        ArrayList<String> errMsgs = Validation.validateInfo(petitionerFirstName, petitionerLastName,
                                    petitionerDOB, petitionerANumm, dependentFirstName, dependentLastName, 
                                    dependentDOB, dependentANumm);

        if (errMsgs.size() == 0) {
            /* Creates an immigrant and adds them to the database. */
            Immigrant newDep = Immigrant.addImmigrant(dependentANumm, dependentFirstName, dependentLastName, 
                                    1, dependentDOB, true);

            Immigrant newPetitioner = Immigrant.addImmigrant(petitionerANumm, petitionerFirstName, petitionerLastName, 
                                                             1, petitionerDOB, false);

            int newImmID = Database.createImmigrant(newDep);
            newDep.setPersonID(newImmID); // Changes placeholder to the database's given ID.

            Database.createImmigrant(newPetitioner);
            
            if (newImmID >= 0) {
                /* Creates a form and adds it to the database. */
                NewImmForm immForm = NewImmForm.addNewImmForm(1, newPetitioner, newDep);
                int formID = Database.createImmForm(immForm);
                immForm.setFormID(formID); // Changes placeholder to the database's given ID.

                if (formID > 0) {
                    Integer wf_code = WFUtil.addformtoWF (formID, "Review",  19);
                    if (wf_code == 0) {
	    	            resp.getWriter().println("<h1>Form successfully added!</h1>");
		            } else {
                        //in a real system, the code would be translated to an error message
                        resp.getWriter().println("<h1>Form not added to Workflow with error code " + wf_code + "! If -3 and using sample code, manually delete from workflow table per instructions</h1>");
                    }
                } else {
                    resp.getWriter().println("<h1>Immigrant form create failed.</h1>");
                }
		    } else {
                resp.getWriter().println("<h1>Create immigrant failed.</h1>");
                
            }
        } else {
            resp.getWriter().println("Validation failed:");

            // Prints out all the error messages found after validation.
            for (int i = 0; i < errMsgs.size(); i++) {
                resp.getWriter().println("ERROR: " + errMsgs.get(i));
            }
        }
    }

}
