package dao;

import model.Patient;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {

   public List<Patient> getAllPatients() {
    List<Patient> list = new ArrayList<>();
    String sql = "SELECT * FROM patients ORDER BY id DESC";

    try (Connection conn = DBConnection.getConnection()) {
        if (conn == null) {
            System.out.println("DATABASE CONNECTION FAILED IN DAO!");
            return list;
        }
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Patient p = new Patient();
                p.setId(rs.getInt("id"));
                p.setFullName(rs.getString("full_name"));
                p.setEmail(rs.getString("email"));
                p.setPhone(rs.getString("phone"));
                // ... rest of your setters ...
                list.add(p);
            }
        }
    } catch (Exception e) {
        System.out.println("Error in getAllPatients: " + e.getMessage());
        e.printStackTrace();
    }
    return list;
}

    // 2. Register Patient
    public boolean registerPatient(Patient patient) {
        String sql = "INSERT INTO patients "
                   + "(full_name, email, password, phone, address, date_of_birth, gender) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, patient.getFullName());
            ps.setString(2, patient.getEmail());
            ps.setString(3, patient.getPassword());
            ps.setString(4, patient.getPhone());
            ps.setString(5, patient.getAddress());
            ps.setDate(6, patient.getDateOfBirth());
            ps.setString(7, patient.getGender());

            return ps.executeUpdate() > 0;

        } catch (SQLIntegrityConstraintViolationException e) {
            System.out.println("Email already registered.");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 3. Update Patient
    public boolean updatePatient(Patient patient) {
        String sql = "UPDATE patients SET full_name=?, email=?, phone=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, patient.getFullName());
            ps.setString(2, patient.getEmail());
            ps.setString(3, patient.getPhone());
            ps.setInt(4, patient.getId());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 4. Login Patient
    public Patient loginPatient(String email, String password) {
        String sql = "SELECT * FROM patients "
                   + "WHERE email = ? AND password = ? AND is_active = true";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Patient p = new Patient();
                p.setId(rs.getInt("id"));
                p.setFullName(rs.getString("full_name"));
                p.setEmail(rs.getString("email"));
                p.setPhone(rs.getString("phone"));
                p.setAddress(rs.getString("address"));
                p.setDateOfBirth(rs.getDate("date_of_birth"));
                p.setGender(rs.getString("gender"));
                p.setActive(rs.getBoolean("is_active"));
                return p;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}