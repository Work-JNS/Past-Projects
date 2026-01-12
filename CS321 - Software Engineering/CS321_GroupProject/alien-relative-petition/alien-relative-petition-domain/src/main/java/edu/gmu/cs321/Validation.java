package edu.gmu.cs321;

import java.sql.Date;
import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;

public class Validation {
    private Validation(){}      // Private Constructor

    /**
     * Validates all info about petitioner and dependent when starting from data entry.
     * Dependent must not exist but petitioner may already be within the system
     * 
     * @param petitionerFirstName
     * @param petitionerLastName
     * @param petitionerDOB
     * @param petitionerANum
     * @param dependentFirstName
     * @param dependentLastName
     * @param dependentDOB
     * @param dependentANum
     * @return a list of any validation errors
     */
    public static ArrayList<String> validateInfo(String petitionerFirstName, String petitionerLastName,
            Date petitionerDOB, String petitionerANum, String dependentFirstName, String dependentLastName, Date dependentDOB, String dependentANum) {

        ArrayList<String> errMsgs = new ArrayList<>();

        // Validates all info adds error messages to a list if that validation fails.
        if (!validateName(petitionerFirstName, petitionerLastName)) { errMsgs.add("Invalid petitioner name."); }
        if (!validateName(dependentFirstName, dependentLastName)) { errMsgs.add("Invalid dependent name."); }
        if (!validateDOB(petitionerDOB, false)) { errMsgs.add("Invalid petitioner Date of Birth."); }
        if (!validateDOB(dependentDOB, true)) { errMsgs.add("Invalid dependent Date of Birth."); }
        if (!validateANum(dependentANum)) {errMsgs.add("Invalid dependent A-Number."); }
        if (!validateANum(petitionerANum)) {errMsgs.add("Invalid petitioner A-Number."); }

        return errMsgs;
    }

    /**
     * Validates all info about petitioner and dependent when sent from a review step
     * 
     * @param petitionerFirstName
     * @param petitionerLastName
     * @param petitionerDOB
     * @param petitionerANum
     * @param dependentFirstName
     * @param dependentLastName
     * @param dependentDOB
     * @param dependentANum
     * @return a list of any validation errors
     */
    public static ArrayList<String> validateReviewedInfo(String petitionerFirstName, String petitionerLastName,
            Date petitionerDOB, String petitionerANum, String dependentFirstName, String dependentLastName, Date dependentDOB, String dependentANum) {

        ArrayList<String> errMsgs = new ArrayList<>();

        // Validates all info adds error messages to a list if that validation fails.
        if (!validateName(petitionerFirstName, petitionerLastName)) { errMsgs.add("Invalid petitioner name."); }
        if (!validateName(dependentFirstName, dependentLastName)) { errMsgs.add("Invalid dependent name."); }
        if (!validateDOB(petitionerDOB, false)) { errMsgs.add("Invalid petitioner Date of Birth."); }
        if (!validateDOB(dependentDOB, true)) { errMsgs.add("Invalid dependet Date of Birth."); }
        if (!validateReviewedANum(dependentANum)) {errMsgs.add("Invalid dependent A-Number."); }
        if (!validateReviewedANum(petitionerANum)) {errMsgs.add("Invalid petitioner A-Number."); }

        return errMsgs;
    }

    /***
     * Validates the first and last name provided.
     * @param firstName The first name of the immigrant.
     * @param lastName The last name of the immigrant.
     * @return Boolean stating that the name is valid or not.
     */
    private static boolean validateName(String firstName, String lastName) {
        // Ensures name only contains alphabetical characters
        return firstName != null && lastName != null && 
               firstName.matches("[A-Za-z]+") && lastName.matches("[A-Za-z]+");
    }

    /***
     * Validates the Date of Birth provided.
     * @param DOB The Date of Birth
     * @return Boolean stating that DOB is valid or not.
     */
    private static boolean validateDOB(Date DOB, boolean isDep) {
        if (DOB == null) return false;

        LocalDate birthDate = DOB.toLocalDate();
        LocalDate today = LocalDate.now();

        if (birthDate.isAfter(today)) {
            return false; // can't be born in the future
        }

        int age = Period.between(birthDate, today).getYears();

        if(isDep){return age >= 0;} // Min Dependent Age
        return (age >= 18);         // Min Petitioner Age
    }

    /***
     * Validates the A-Number provided.
     * @param aNumm The A-Number
     * @return Boolean stating that A-Number is valid or not.
     */
    private static boolean validateANum(String aNumm) {
        // Ensures aNumm only contains numerical characters and is not already in the database
        // Or, if it is, the aNumm is not associated with a dependent.
        return aNumm != null && aNumm.matches("[0-9]+") && (!Database.immigrantExists(aNumm) || !Database.getImmigrant(aNumm).getIsDependent()); 
    }

    /***
     * Validates the A-Number provided by the review process.
     * @param aNumm The A-Number
     * @return Boolean stating that A-Number is valid or not.
     */
    private static boolean validateReviewedANum(String aNumm) {        
        // Ensures aNumm only contains numerical characters
        // As this validation occurs during the reviewed step,
        // it should exist in the database
        return aNumm != null && aNumm.matches("[0-9]+") && Database.immigrantExists(aNumm); 
    }

}
