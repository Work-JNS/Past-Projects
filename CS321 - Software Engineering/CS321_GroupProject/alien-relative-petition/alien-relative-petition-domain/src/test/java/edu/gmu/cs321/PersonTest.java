package edu.gmu.cs321;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.Date;

import org.junit.jupiter.api.Test;

public class PersonTest {
    private final String fname = "Jon";
    private final String lname = "Doe";
    private final int personID = 1235778;
    private final Date DOB = new Date(personID);

    private Person setupPerson(){
        
        Person tester = new Person(fname, lname, personID, DOB);
        return tester;
    }

    @Test
    public void testPerson(){
        Person tester = setupPerson();
        assertTrue(tester != null);
    }

    @Test
    public void testGetFname(){
        Person tester = setupPerson();
        assertTrue(tester.getFirstName().equals(fname));
    }
    @Test
    public void testSetFname(){
        Person tester = setupPerson();
        tester.setFirstName("name");
        assertFalse(tester.getFirstName().equals(fname));
    }


    @Test
    public void testGetLname(){
        Person tester = setupPerson();
        assertTrue(tester.getLastName().equals(lname));
    }
    @Test
    public void testSetLname(){
        Person tester = setupPerson();
        tester.setLastName("name");
        assertFalse(tester.getLastName().equals(lname));
    }

    @Test
    public void testGetPersonID(){
        Person tester = setupPerson();
        assertTrue(tester.getPersonID() == personID);
    }
    @Test
    public void testSetPersonID(){
        Person tester = setupPerson();
        tester.setPersonID(personID+10);
        assertFalse(tester.getPersonID() == personID);
    }


    @Test
    public void testGetDOB(){
        Person testPerson = setupPerson();
        assertTrue(testPerson.getDateOfBirth().equals(DOB));
    }
    public void testSetDOB(){
        Person testPerson = setupPerson();
        testPerson.setDateOfBirth(new Date(10));
        assertFalse(testPerson.getDateOfBirth().equals(DOB));
    }
    
}
