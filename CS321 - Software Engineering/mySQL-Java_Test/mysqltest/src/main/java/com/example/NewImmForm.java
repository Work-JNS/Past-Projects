package com.example;

import java.sql.Date;
import java.time.LocalDate;


public class NewImmForm {
    private int formID;
    private String petitioner_ANumm;
    private String dependent_ANumm;
    private Date creationDate;

    private NewImmForm(int ID, Immigrant petitioner, Immigrant dep, Date date) {
        formID = ID;
        petitioner_ANumm = petitioner.getA_NumberString();
        dependent_ANumm = dep.getA_NumberString();
        creationDate = date;
    }
    private NewImmForm(int formID, String petitionerANumm, String depANumm, Date date) {
        this.formID = formID;
        this.petitioner_ANumm = petitionerANumm;
        this.dependent_ANumm = depANumm;
        this.creationDate = date;
    }

    
    /***
     * Creates a form associated with a given immigrant.
     * 
     * @param imm
     * @return The form ID.
     */
    public NewImmForm addNewImmForm(int ID, Immigrant petitioner, Immigrant dep) {
        NewImmForm newImmForm = new NewImmForm(ID, petitioner, dep, Date.valueOf(LocalDate.now()));
        return newImmForm;
    }

    public static NewImmForm formatNewImmForm(int formID, String petitionerANumm, String depANumm, Date date) {
        NewImmForm newImmForm = new NewImmForm(formID, petitionerANumm, depANumm, date);
        return newImmForm;
    }

    public boolean checkFormID(int formID) {
        return true;
    }

    public int getFormID() {
        return formID;
    }

    public Date getDate() {
        return creationDate;
    }

    public String getPetitionerANumm() {
        return petitioner_ANumm;
    }
    
    public String getDependentString() {
        return dependent_ANumm;
    }

    public void setFormID(int id) {
        formID = id;
    }
}
