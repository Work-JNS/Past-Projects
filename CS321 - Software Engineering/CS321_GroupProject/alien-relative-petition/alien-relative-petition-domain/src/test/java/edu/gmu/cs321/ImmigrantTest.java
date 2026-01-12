package edu.gmu.cs321;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.Date;

import org.junit.jupiter.api.Test;

public class ImmigrantTest {
    
    private final String anum1 = "1";
    private final String anumInvalid = "anum";

    private final String fname1 = "jon";
    private final String fname2 = "jan";

    private final String lname1 = "doe";
    private final String lname2 = "don";

    private final int personID1 = 1;

    private final Date DOB1 = new Date(100);
    private final Date DOB2 = new Date(200);

    private Immigrant setupImmigrant(){
        return Immigrant.addImmigrant(anum1, fname1, lname1, personID1, DOB1, false);

    }

    @Test
    public void testAddImmigrantPass(){
        Immigrant immigrant = setupImmigrant();
        assertTrue(immigrant != null);
    }
    @Test
    public void testAddImmigrantFail(){
        Immigrant immigrant = Immigrant.addImmigrant(anumInvalid, fname1, lname1, personID1, DOB1, false);
        assertTrue(immigrant == null);
    }

    @Test
    public void testGetAnum(){
        Immigrant immigrant = setupImmigrant();
        assertTrue(immigrant.getA_Number().equals(anum1));
    }

    @Test
    public void testGetIsDependent(){
        Immigrant immigrant = setupImmigrant();
        assertFalse(immigrant.getIsDependent());
    }

    @Test
    public void testUpdateImmigrant(){
        Immigrant immigrant = setupImmigrant();
        immigrant.updateImmigrant(fname2, lname2, DOB2.toString());
        boolean valid = true;
        if(!immigrant.getFirstName().equals(fname2)){valid = false;}
        if(!immigrant.getLastName().equals(lname2)){valid = false;}
        if(!immigrant.getDateOfBirth().toString().equals(DOB2.toString())){valid = false;}
        assertTrue(valid);
    }







    
}
