package com.example;

import static org.junit.Assert.assertTrue;

import java.sql.Connection;
import java.sql.Date;

import org.junit.Test;

/**
 * Unit test for simple App.
 */
public class dbTest 
{
    @Test
    public void testConnection(){
        Connection c = db.getConnection();
        assertTrue(c != null);
    }

    @Test
    public void testFormWrite(){
        Immigrant pet = Immigrant.addImmigrant(
            "100",
            "pat",
            "tish",
            1,
            new Date(10),
             false
        );
        Immigrant dep = Immigrant.addImmigrant(
            "110",
            "pat",
            "tish",
            2,
            new Date(15),
             true
        );
        NewImmForm form = NewImmForm.formatNewImmForm(
            0,pet.getA_NumberString(),
            dep.getA_NumberString(),
            new Date(3)
        );

        int a = db.createImmForm(form);
        

        assertTrue(a != -1);

    }

    @Test
    public void testImmWrite(){
        Immigrant imm = Immigrant.addImmigrant(
            "1000",
            "fname",
            "lname",
            100, 
            new Date(10), 
            false
        );
        int a = db.createImmigrant(imm);
        assertTrue(a != -1);
    }

    @Test
    public void testFormRead(){
        NewImmForm form = db.getNewImmForm(1);

        boolean valid = true;

        if(form == null){valid = false;}
        assertTrue(valid);
        if(!form.getPetitionerANumm().equals("100")){valid = false;}
        assertTrue(valid);
        if(!form.getDependentString().equals("110")){valid = false;}
        assertTrue(valid);

        
    }

    @Test
    public void testImmRead(){
        Immigrant imm = db.getImmigrant("1000");
        boolean valid = true;
        if(imm == null){valid = false;}
        else if (!imm.getFirstName().equals("fname")){valid = false;}
        assertTrue(valid);
    }

}
