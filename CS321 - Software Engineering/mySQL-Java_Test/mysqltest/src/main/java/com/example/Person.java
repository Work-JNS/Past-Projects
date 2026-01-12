package com.example;

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
    protected String getFirstName() {return firstName;}
    protected void setFirstName(String firstName) {this.firstName = firstName;}

    protected String getLastName() {return lastName;}
    protected void setLastName(String lastName) {this.lastName = lastName;}

    protected int getPersonID() {return personID;}
    protected void setPersonID(int personID) {this.personID = personID;}

    protected Date getDateOfBirth() {return dateOfBirth;}
    protected void setDateOfBirth(Date dateOfBirth) {this.dateOfBirth = dateOfBirth;}

    /***
     * Constructs a blank person class
     */
    protected Person(){}
}
