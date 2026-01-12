package edu.gmu.cs321;

import java.sql.Date;

public class Immigrant extends Person {
    private String a_Number;
    private Boolean is_dependent;

    /***
     * Constructs an Immigrant with all data fields
     * @param aNum
     * @param fname
     * @param lname
     * @param personId
     * @param DOB
     */
    private Immigrant(String aNum, String fname, String lname, int personId, Date DOB, boolean isDep){
        super(fname, lname, personId, DOB);
        a_Number = aNum;
        is_dependent = isDep;
    }

    /***
     * Creates a modifiable immigrant from input data
     * @param aNum The immigrant's A-Number
     * @param fname The immigrant's first name
     * @param lname The immigrant's last name
     * @param personId
     * @return The immigrant's ID in the database.
     */
    public static Immigrant addImmigrant(String aNum, String fname, String lname, int personId, Date DOB, boolean isDep){
        if (aNum == null || fname == null || lname == null || personId < 1 || DOB == null) {
            return null;
        }
        try{Integer.parseInt(aNum);}
        catch(NumberFormatException e){return null;}

        return new Immigrant(aNum, fname, lname, personId, DOB, isDep);
    }

    /***
     * Gets the Immigrant's A-Number.
     * @return The Immigrant's A-Number
     */
    public String getA_Number() {return a_Number;}

    /***
     * Gets whether or not immigrant is a dependent.
     * @return Boolean stating whether immigrant is a dependent.
     */
    public boolean getIsDependent() { return is_dependent; }

    /***
     * Updates the immigrant's information after validating the new data.
     * @param fname First name
     * @param lname Last name
     * @param DOB Date of Birth
     */
    public void updateImmigrant(String fname, String lname, String DOB) {
        Date newDOB;
        try {
            newDOB = Date.valueOf(DOB);
            if(fname == null  || !fname.matches("[a-zA-Z]+")){return;}
            if(lname == null || !lname.matches("[a-zA-Z]+")){return;}

            this.setFirstName(fname);
            this.setLastName(lname);
            this.setDateOfBirth(newDOB);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        }
    }

}