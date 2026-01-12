// TODO: implement check formID

package edu.gmu.cs321;

import java.sql.Date;
import java.time.LocalDate;

public class NewImmForm {
    private int formID;
    private String petitioner_ANum;
    private String dependent_ANum;
    private Date creationDate;
    
    /***
     * Constructor
     * @param ID
     * @param petitioner
     * @param dep
     * @param date
     */
    private NewImmForm(int ID, Immigrant petitioner, Immigrant dep, Date date) {
        formID = ID;
        petitioner_ANum = petitioner.getA_Number();
        dependent_ANum = dep.getA_Number();
        creationDate = date;
    }
    /**
     * Constructor.
     * @param formID
     * @param petitionerANumm
     * @param depANumm
     * @param date
     */
    private NewImmForm(int formID, String petitionerANumm, String depANumm, Date date) {
        this.formID = formID;
        this.petitioner_ANum = petitionerANumm;
        this.dependent_ANum = depANumm;
        this.creationDate = date;
    }
    
    /***
     * Creates a form associated with a given immigrants.
     * @param imm
     * @return The form ID.
     */
    public static NewImmForm addNewImmForm(int ID, Immigrant petitioner, Immigrant dep) {
        return new NewImmForm(ID, petitioner, dep, Date.valueOf(LocalDate.now()));
    }

    /***
     * Creates Immform from Immigrant references
     * @param formID
     * @param petitionerANumm
     * @param depANumm
     * @param date
     * @return
     */
    public static NewImmForm formatNewImmForm(int formID, String petitionerANumm, String depANumm, Date date) {
        return new NewImmForm(formID, petitionerANumm, depANumm, date);
        
    }

    /**
     * Getter
     * @return formID
     */
    public int getFormID() {return formID;}
    /**
     * Setter.
     * @param id to set
     */
    public void setFormID(int id) {formID = id;}

    /***
     * Getter
     * @return Creation Date
     */
    public Date getDate() {return creationDate;}

    /***
     * Getter.
     * @return petitioner reference
     */
    public String getPetitionerANum() {return petitioner_ANum;}
    /***
     * Getter.
     * @return dependent reference
     */
    public String getDependentANum() {return dependent_ANum;}

    
}
