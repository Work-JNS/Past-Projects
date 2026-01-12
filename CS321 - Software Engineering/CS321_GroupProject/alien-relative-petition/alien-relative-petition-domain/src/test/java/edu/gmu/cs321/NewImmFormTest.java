package edu.gmu.cs321;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.Date;

import org.junit.jupiter.api.Test;

public class NewImmFormTest {

    private final int formID = 1;
    private final Date creationDate = new Date(10000);
    private final String pAnum = "1";
    private final String dAnum = "2";
    private final Immigrant petitioner = Immigrant.addImmigrant(
        pAnum, 
        "pet", 
        "ition", 
        Integer.parseInt(pAnum), 
        new Date(100), 
        false
    );
    private final Immigrant dependent = Immigrant.addImmigrant(
        dAnum, 
        "dep", 
        "end", 
        Integer.parseInt(dAnum), 
        new Date(200), 
        true
    );



    private NewImmForm setupForm(){
        return NewImmForm.formatNewImmForm(formID, pAnum, dAnum, creationDate);
    }


    @Test
    public void testAddNewImmForm(){
        NewImmForm form = NewImmForm.addNewImmForm(formID, petitioner, dependent);
        assertTrue(form != null);
    }
    @Test
    public void testFormatImmForm(){
        NewImmForm form = NewImmForm.formatNewImmForm(formID, pAnum, dAnum, creationDate);
        assertTrue(form != null);
    }

    //TODO: Write test after database delpoyment
    public void testCheckFormID(){
        
    }

    @Test
    public void testGetFormID(){
        NewImmForm form = setupForm();
        assertTrue(form.getFormID() == formID);
    }
    


    @Test
    public void testGetDate(){
        NewImmForm form = setupForm();
        assertTrue(form.getDate().equals(creationDate));
    }

    @Test
    public void testGetPetAnum(){
        NewImmForm form = setupForm();
        assertTrue(form.getPetitionerANum().equals(pAnum));
    }
    @Test
    public void testGetDepAnum(){
        NewImmForm form = setupForm();
        assertTrue(form.getDependentANum().equals(dAnum));
    }
   
}
