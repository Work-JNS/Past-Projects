// TODO: Setup DB on ubuntu
// TODO: write Tests on alien petition
// TODO: move all to new VM(w/ more cores & mem)
// TODO: place dummy forms & imms, then test w/ workflow.



package com.example;
import java.sql.*;

public class db {
    
 
    final static String USERNAME = "ImmSys_User";
    final static String PASSWORD = "password";
    final static String DB_URL = "jdbc:mysql://localhost:3306/cs321_g19";

    public static Connection getConnection(){
        try {
            Connection conn = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
            return conn;
        } catch (Exception e) {System.err.println("ConnectionError: "+ e);}
        return null;
    }

    // Write Form
    public static int createImmigrant(Immigrant newImm) {
        String insertQuery = "INSERT INTO Immigrant (firstName, lastName, DOB, A_Number, Is_Dep) VALUES (?, ?, ?, ?, ?)";
        int id = 0;

        try {
            Connection conn = getConnection();
            PreparedStatement stmt = conn.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, newImm.getFirstName());
            stmt.setString(2, newImm.getLastName());
            stmt.setDate(3, newImm.getDateOfBirth());
            stmt.setString(4, newImm.getA_NumberString());
            stmt.setBoolean(5, newImm.getIsDependent());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Immigrant added successfully.\n");
                
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) id = rs.getInt(1);
            } else {
                System.out.println("Error adding immigrant.\n");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }

        return id;
    }

    // Write Imm
    public static int createImmForm(NewImmForm immForm) {
        String insertQuery = "INSERT INTO ImmForm (petitionerANumm, depANumm, dateCreated) VALUES (?, ?, ?)";
        int id = 0;

        try {
            Connection conn = getConnection();
            PreparedStatement stmt = conn.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, immForm.getPetitionerANumm());
            stmt.setString(2, immForm.getDependentString());
            stmt.setDate(3, immForm.getDate());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Form added successfully.\n");
                
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) id = rs.getInt(1);
            } else {
                System.out.println("Error adding form.\n");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }

        return id;

    }

    

    // Read Form(FormID)
    public static NewImmForm getNewImmForm(int formID) {
        String selectQuery = "SELECT * FROM ImmForm WHERE id = ?";

        try {
            Connection conn = getConnection();
            PreparedStatement stmt = conn.prepareStatement(selectQuery);
            stmt.setInt(1, formID);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String petitionerANumm = rs.getString("petitionerANumm");
                String depANumm = rs.getString("depANumm");
                Date dateCreated = rs.getDate("dateCreated");

                return NewImmForm.formatNewImmForm(formID, petitionerANumm, depANumm, dateCreated);
            } else {
                System.out.println("No form found with ID: " + formID);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            
        }
        return null;
    }

    // Write Imm(Anumbr)



    public static Immigrant getImmigrant(String Anum) {
        String selectQuery = "SELECT * FROM Immigrant WHERE A_Number = ?";
        try {
            Connection conn = getConnection();
            PreparedStatement stmt = conn.prepareStatement(selectQuery);
            stmt.setString(1, Anum);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String aNumber = rs.getString("A_Number");
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                Date dob = rs.getDate("DOB");
                int personId = Integer.parseInt(aNumber);
                boolean isDep = rs.getBoolean("Is_Dep");
                return Immigrant.addImmigrant(aNumber, firstName, lastName, personId, dob, isDep);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    
}
