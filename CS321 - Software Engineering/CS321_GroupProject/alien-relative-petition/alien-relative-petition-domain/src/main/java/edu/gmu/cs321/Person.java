package edu.gmu.cs321;

import java.sql.Date;

public class Person {
    private String firstName;
    private String lastName;
    private int personID;
    private Date dateOfBirth;

    /***
     * Constructs a Person and fills all data
     * @param firstName
     * @param lastName
     * @param personId
     * @param dateOfBirth
     */
    protected Person(String firstName, String lastName, int personId, Date dateOfBirth){
        this.firstName = firstName;
        this.lastName = lastName;
        this.personID = personId;
        this.dateOfBirth = dateOfBirth;
    }
    
    /***
     * Getter.
     * @return first name
     */
    protected String getFirstName() {return firstName;}
    /***
     * Setter.
     * @param firstName to Set
     */
    protected void setFirstName(String firstName) {this.firstName = firstName;}

    /***
     * Getter.
     * @return Last Name
     */
    protected String getLastName() {return lastName;}
    /***
     * Setter.
     * @param lastName to Set
     */
    protected void setLastName(String lastName) {this.lastName = lastName;}

    /***
     * Getter.
     * @return PersonID
     */
    protected int getPersonID() {return personID;}
    /***
     * Setter.
     * @param personID to Set
     */
    protected void setPersonID(int personID) {this.personID = personID;}

    /***
     * Getter.
     * @return date of birth
     */
    protected Date getDateOfBirth() {return dateOfBirth;}
    /***
     * Setter.
     * @param dateOfBirth to Set
     */
    protected void setDateOfBirth(Date dateOfBirth) {this.dateOfBirth = dateOfBirth;}

    /***
     * Constructs a blank person class
     */
    protected Person(){}
}
