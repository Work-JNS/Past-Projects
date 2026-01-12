package edu.gmu.cs321;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.sql.Date;
import java.util.ArrayList;

import org.mockito.Mockito;
import org.mockito.MockedStatic;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class ValidationTest {
    private final String validName = "Jand";
    private final String invalidName = "123Jane";
    private final Date petitionerDOB = java.sql.Date.valueOf("2000-01-01");
    private final Date dependentDOB = java.sql.Date.valueOf("2007-01-01");
    private final String testPetANum = "123456789";
    private final String testDepANum = "12345678";
    private final String invalidANum = "$123456789";

    // Mock the static Database class
    private MockedStatic<Database> databaseMock;

    @BeforeEach
    public void setUp() {
        // Mock the static database before each test
        databaseMock = Mockito.mockStatic(Database.class);
    }

    @Test
    void testValidateInfo_ValidData() {
        // Mock the database returning that neither immigrant exists
        databaseMock.when(() -> Database.immigrantExists(testPetANum)).thenReturn(false);
        databaseMock.when(() -> Database.immigrantExists(testDepANum)).thenReturn(false);

        // Test with all valid data
        ArrayList<String> errors = Validation.validateInfo(validName, validName, petitionerDOB, testPetANum, validName, validName, dependentDOB, testDepANum);

        assertTrue(errors.isEmpty());
    }

    @Test
    void testValidateInfo_InvalidPetitionerName() {
        // Mock the database returning that neither immigrant exists
        databaseMock.when(() -> Database.immigrantExists(testPetANum)).thenReturn(false);
        databaseMock.when(() -> Database.immigrantExists(testDepANum)).thenReturn(false);

        // Test invalid name (non-alphabetical character)
        ArrayList<String> errors = Validation.validateInfo(invalidName, validName, petitionerDOB, testPetANum, validName, validName, dependentDOB, testDepANum);

        assertFalse(errors.isEmpty());
        assertTrue(errors.contains("Invalid petitioner name."));
    }

    @Test
    void testValidateInfo_InvalidDependentName() {
        // Mock the database returning that neither immigrant exists
        databaseMock.when(() -> Database.immigrantExists(testPetANum)).thenReturn(false);
        databaseMock.when(() -> Database.immigrantExists(testDepANum)).thenReturn(false);

        // Test invalid dependent name (non-alphabetical character)
        ArrayList<String> errors = Validation.validateInfo(validName, validName, petitionerDOB, testPetANum, invalidName, validName, dependentDOB, testDepANum);

        assertFalse(errors.isEmpty());
        assertTrue(errors.contains("Invalid dependent name."));
    }

    @Test
    void testValidateInfo_InvalidPetitionerDOB() {
        // Mock the database returning that neither immigrant exists
        databaseMock.when(() -> Database.immigrantExists(testPetANum)).thenReturn(false);
        databaseMock.when(() -> Database.immigrantExists(testDepANum)).thenReturn(false);

        Date invalidDOB = java.sql.Date.valueOf("2050-01-01"); // A date too far in the future

        // Test invalid petitioner date of birth
        ArrayList<String> errors = Validation.validateInfo(validName, validName, invalidDOB, testPetANum, validName, validName, dependentDOB, testDepANum);

        assertFalse(errors.isEmpty());
        assertTrue(errors.contains("Invalid petitioner Date of Birth."));
    }

    @Test
    void testValidateInfo_InvalidDependentDOB() {
        // Mock the database returning that neither immigrant exists
        databaseMock.when(() -> Database.immigrantExists(testPetANum)).thenReturn(false);
        databaseMock.when(() -> Database.immigrantExists(testDepANum)).thenReturn(false);

        Date invalidDOB = java.sql.Date.valueOf("2050-01-01"); // A date too far in the future

        // Test invalid dependent date of birth
        ArrayList<String> errors = Validation.validateInfo(validName, validName, petitionerDOB, testPetANum, validName, validName, invalidDOB, testDepANum);

        assertFalse(errors.isEmpty());
        assertTrue(errors.contains("Invalid dependet Date of Birth."));
    }

    @Test
    void testValidateInfo_NullPetitionerANum() {
        // mock database returning dependent does not exist
        databaseMock.when(() -> Database.immigrantExists(testDepANum)).thenReturn(false);

        // Test invalid petitioner A-Number (already exists in the database)
        ArrayList<String> errors = Validation.validateInfo(validName, validName, petitionerDOB, null, validName, validName, dependentDOB, testDepANum);

        assertFalse(errors.isEmpty());
        assertTrue(errors.contains("Invalid petitioner A-Number."));
    }

    @Test
    void testValidateInfo_ExistingPetitionerANum() {
        // mock database returning petitioner exists
        Immigrant petitionerMock = mock(Immigrant.class);
        databaseMock.when(() -> Database.immigrantExists(testPetANum)).thenReturn(true);
        databaseMock.when(() -> Database.getImmigrant(testPetANum)).thenReturn(petitionerMock);
        when(petitionerMock.getIsDependent()).thenReturn(false);

        // mock database returning dependent does not exist
        databaseMock.when(() -> Database.immigrantExists(testDepANum)).thenReturn(false);

        // Test invalid petitioner A-Number (already exists in the database)
        ArrayList<String> errors = Validation.validateInfo(validName, validName, petitionerDOB, testPetANum, validName, validName, dependentDOB, testDepANum);

        assertTrue(errors.isEmpty());
    }

    @Test
    void testValidateInfo_InvalidPetitionerANum() {
        // mock database returning dependent does not exist
        databaseMock.when(() -> Database.immigrantExists(testDepANum)).thenReturn(false);

        // Test invalid petitioner A-Number (already exists in the database)
        ArrayList<String> errors = Validation.validateInfo(validName, validName, petitionerDOB, invalidANum, validName, validName, dependentDOB, testDepANum);

        assertFalse(errors.isEmpty());
        assertTrue(errors.contains("Invalid petitioner A-Number."));
    }

    @Test
    void testValidateInfo_NullDependentANum() {
        // Mock the database returning there is not a petitioner with that ANum
        databaseMock.when(() -> Database.immigrantExists(testPetANum)).thenReturn(false);

        // Test invalid dependent A-Number (null)
        ArrayList<String> errors = Validation.validateInfo(validName, validName, petitionerDOB, testPetANum, validName, validName, dependentDOB, null);

        assertFalse(errors.isEmpty());
        assertTrue(errors.contains("Invalid dependent A-Number."));
    }

    @Test
    void testValidateInfo_InvalidDependentANum() {
        // Mock the database returning there is not a petitioner with that ANum
        databaseMock.when(() -> Database.immigrantExists(testPetANum)).thenReturn(false);

        // Test invalid dependent A-Number (has non-numerical values)
        ArrayList<String> errors = Validation.validateInfo(validName, validName, petitionerDOB, testPetANum, validName, validName, dependentDOB, invalidANum);

        assertFalse(errors.isEmpty());
        assertTrue(errors.contains("Invalid dependent A-Number."));
    }

    @Test
    void testValidateInfo_DuplicateDependentANum() { 
        // Mock returning there is no petitioner that exists within the database
        databaseMock.when(() -> Database.immigrantExists(testPetANum)).thenReturn(false);
        // Mock the database returning that there exists an immigrant with the dependent's ANum
        Immigrant dependentMock = mock(Immigrant.class);
        databaseMock.when(() -> Database.immigrantExists(testDepANum)).thenReturn(true);
        databaseMock.when(() -> Database.getImmigrant(testDepANum)).thenReturn(dependentMock);
        when(dependentMock.getIsDependent()).thenReturn(true);


        // Test invalid dependent A-Number (null)
        ArrayList<String> errors = Validation.validateInfo(validName, validName, petitionerDOB, testPetANum, validName, validName, dependentDOB, testDepANum);

        assertFalse(errors.isEmpty());
        assertTrue(errors.contains("Invalid dependent A-Number."));
    }

    @AfterEach
    public void cleanUp(){
        databaseMock.close();
    }
}
