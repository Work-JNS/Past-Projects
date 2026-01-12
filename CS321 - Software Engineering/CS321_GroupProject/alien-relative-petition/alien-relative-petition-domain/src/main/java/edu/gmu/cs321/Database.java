package edu.gmu.cs321;

import java.sql.*;

public class Database {
    // JDBC URL, username, and passwod of MySQL server
    static final String USERNAME = "ImmSys_User";
    static final String PASSWORD = "password";
    static final String DB_URL = "jdbc:mysql://localhost:3306/cs321_g19";
    static final String IMM_TABLE = "Immigrant";
    static final String FORM_TABLE = "ImmForm";

    private Database(){}        // Empty Private constructor for organization

    /***
     * Connects to Database
     * @return Connection
     */
    public static Connection getConnection(){
        try {
            return DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);            
        } catch (Exception e) {System.err.println("ConnectionError: "+ e);}
        return null;
    }

    /***
     * Connects to Database and clears all tables
     */
    public static void truncateTables(){
        String sqlString = "TRUNCATE TABLE ";
        try{
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            stmt.execute(sqlString+IMM_TABLE);
            stmt.execute(sqlString+FORM_TABLE);
        }catch(Exception e){
            System.out.println("Tables not cleared");
            System.err.println(e);
        }
        
    }

    /***
     * Writes Immigrant to database
     * @param newImm Immigrant to store in database
     * @return int error code
     */
    public static int createImmigrant(Immigrant newImm) {
        String insertQuery = "INSERT INTO Immigrant (firstName, lastName, DOB, A_Number, Is_Dep) VALUES (?, ?, ?, ?, ?)";
        int id = 0;

        try {
            Connection conn = getConnection();  // Get connection
            PreparedStatement stmt = conn.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, newImm.getFirstName());   // prepare statment arguments
            stmt.setString(2, newImm.getLastName());
            stmt.setDate(3, newImm.getDateOfBirth());
            stmt.setString(4, newImm.getA_Number());
            stmt.setBoolean(5, newImm.getIsDependent());

            int rowsAffected = stmt.executeUpdate();    // execute statement
            if (rowsAffected > 0) {                
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) id = rs.getInt(1);
            } else {return -2;}
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }

        return id;
    }

    // Update Immigrant
    /***
     * 
     * @param Imm Immigrant to store in database
     */
    public static void updateImmigrant(Immigrant Imm) {
        String updateQuery = "UPDATE Immigrant SET firstName = ?, lastName =?, DOB= ?, Is_Dep=? WHERE A_Number = " + Imm.getA_Number();
        //int id = 0;

        try {
            Connection conn = getConnection();
            PreparedStatement stmt = conn.prepareStatement(updateQuery, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, Imm.getFirstName());
            stmt.setString(2, Imm.getLastName());
            stmt.setDate(3, Imm.getDateOfBirth());
            //stmt.setString(4, Imm.getA_Number());
            stmt.setBoolean(4, Imm.getIsDependent());

            stmt.executeUpdate();
            // if (rowsAffected > 0) {                
            //     ResultSet rs = stmt.getGeneratedKeys();
            //     if (rs.next()) id = rs.getInt(1);
            // } else {return -2;}
        } catch (SQLException e) {
            e.printStackTrace();
            //return -1;
        }

        //return id;
    }

    /***
     * Writes NewImmForm object to DB.
     * @param immForm NewImmForm Object to write
     * @return int error code
     */
    public static int createImmForm(NewImmForm immForm) {
        String insertQuery = "INSERT INTO ImmForm (petitionerANumm, depANumm, dateCreated) VALUES (?, ?, ?)";
        int id = 0;

        try {
            Connection conn = getConnection();
            PreparedStatement stmt = conn.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, immForm.getPetitionerANum());
            stmt.setString(2, immForm.getDependentANum());
            stmt.setDate(3, immForm.getDate());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {                         // Form Creation Success
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) id = rs.getInt(1);
            }else{return -1;}                               // Form Creation failed
        } catch (SQLException e) {                          // Form Creation failed
            e.printStackTrace();
            return -1;
        }

        return id;                                          // Return formID

    }

    

    /***
     * Retrieves Immigrant from DB based on A_number
     * @param Anum  Immigrant to get
     * @return Immigrant on Succsess & null on fail
     */
    public static Immigrant getImmigrant(String Anum) {
        String selectQuery = "SELECT * FROM Immigrant WHERE A_Number = ?";
        try {
            Connection conn = getConnection();  // Get connection
            PreparedStatement stmt = conn.prepareStatement(selectQuery);
            stmt.setString(1, Anum);            // Prepare statment
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {                    // extract data from result
                String aNumber = rs.getString("A_Number");
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                Date dob = rs.getDate("DOB");
                int personId = Integer.parseInt(aNumber);
                boolean isDep = rs.getBoolean("Is_Dep");
                return Immigrant.addImmigrant(aNumber, firstName, lastName, personId, dob, isDep);
            }
        } catch (SQLException e) {e.printStackTrace();}
        return null;
    }

    /***
     * Retrieves Form from DB based on formID
     * @param formID  Form to get
     * @return NewImmForm on Succsess & null on fail
     */
    public static NewImmForm getNewImmForm(int formID) {
        String selectQuery = "SELECT * FROM ImmForm WHERE id = ?";

        try {
            Connection conn = getConnection();  // Get connection
            PreparedStatement stmt = conn.prepareStatement(selectQuery);
            stmt.setInt(1, formID);             // Prepare Statement
            ResultSet rs = stmt.executeQuery(); // Execute Request
            if (rs.next()) {                    // Extract Data from result
                String petitionerANumm = rs.getString("petitionerANumm");
                String depANumm = rs.getString("depANumm");
                Date dateCreated = rs.getDate("dateCreated");
                return NewImmForm.formatNewImmForm(formID, petitionerANumm, depANumm, dateCreated);
            } else {
                System.out.println("No form found with ID: " + formID);
            }
        } catch (SQLException e) {e.printStackTrace();}
        return null;
    }


    /***
     * Checks to see if an immigrant with the provided A-Number already exists within the database.
     * @param aNumm The A-Number being searched for in the database.
     * @return A boolean stating whether the immigrant does or does not exist.
     */
    public static boolean immigrantExists(String aNumm) {return getImmigrant(aNumm) != null;}
}
