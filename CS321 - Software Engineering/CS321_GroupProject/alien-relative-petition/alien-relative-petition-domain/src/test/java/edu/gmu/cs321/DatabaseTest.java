package edu.gmu.cs321;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.Connection;
import java.sql.Date;

import org.junit.jupiter.api.Test;

public class DatabaseTest {

    private final String pAnum = "100";
    private final String dAnum = "200";

    private final Immigrant immigrant = Immigrant.addImmigrant(
        pAnum, 
        "null", 
        "null", 
        Integer.parseInt(pAnum), 
        new Date(1000), 
        false
    );
    private final Immigrant dependent = Immigrant.addImmigrant(
        dAnum, 
        "nil", 
        "nil", 
        Integer.parseInt(dAnum), 
        new Date(2000), 
        true
    );
    private final NewImmForm exForm = NewImmForm.formatNewImmForm(0, pAnum, dAnum, new Date(1000));

    @Test
    void testConnection() {
        Connection connection = Database.getConnection();
        assertNotNull(connection);
    }

    @Test
    void testAddImmigrantPass() {
        Database.truncateTables();
        int immID = Database.createImmigrant(immigrant);
        assertTrue(immID >= 0);
        Database.truncateTables();
    }

    @Test
    void testAddImmigrantFail() {
        Database.truncateTables();
        try{
            int immID = Database.createImmigrant(null);
            assertFalse(immID >= 0);
        }catch(Exception exception){assertTrue(true);}
        Database.truncateTables();
    }

    @Test
    void testAddImmFormPass() {
        Database.truncateTables();
        NewImmForm form = NewImmForm.addNewImmForm(0, immigrant, dependent);
        int formID = Database.createImmForm(form);
        assertNotEquals(formID, -1);
        Database.truncateTables();
    }

    @Test
    void testAddImmFormFail() {
        Database.truncateTables();
        try{
            int formID = Database.createImmForm(null);
            assertFalse(formID >= 0);
        }catch(Exception exception){assertTrue(true);}
        Database.truncateTables();
    }

    @Test
    void testReadImmigrant(){
        Database.truncateTables();
        Database.createImmigrant(immigrant);
        Immigrant retImm = Database.getImmigrant(pAnum);
        boolean valid = true;
        if (!retImm.getA_Number().equals(immigrant.getA_Number())){valid = false;}
        assertTrue(valid);
        Database.truncateTables();

    }
    @Test
    void testReadDependent(){
        Database.truncateTables();
        Database.createImmigrant(dependent);
        Immigrant retDep = Database.getImmigrant(dAnum);
        assertEquals(retDep.getA_Number(), dAnum);
        assertTrue(retDep.getIsDependent());
    }
    
    @Test
    void testReadImmForm(){
        Database.truncateTables();                          // clear tables
        int formID = Database.createImmForm(exForm);        // make form entry
        NewImmForm rForm = Database.getNewImmForm(formID);  // get form entry
        boolean valid = true;
        assertNotNull(rForm);
        if(formID != rForm.getFormID()){valid = false;}
        if(!rForm.getPetitionerANum().equals(pAnum)){valid = false;}
        if(!rForm.getDependentANum().equals(dAnum)){valid = false;}
        assertTrue(valid);
        Database.truncateTables();

        
    }
    
}
