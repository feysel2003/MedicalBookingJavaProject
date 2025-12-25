package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Doctor;
import dao.DBConnection;
public class DoctorDAO {

    // --- LOGIN METHOD ---
    public Doctor login(String email, String password) {
        Doctor doc = null;
        String sql = "SELECT * FROM doctors WHERE email = ? AND password = ? AND is_active = true";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    doc = new Doctor();
                    doc.setId(rs.getInt("id"));
                    doc.setFullName(rs.getString("full_name"));
                    doc.setEmail(rs.getString("email"));
                    doc.setSpecialization(rs.getString("specialization"));
                    doc.setPhone(rs.getString("phone"));
                    doc.setActive(rs.getBoolean("is_active"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doc;
    }

    // --- ADD DOCTOR METHOD (Updated with Password) ---
    public void addDoctor(Doctor doctor) {
        // Ensure column names (full_name vs fullName) match your database table exactly
        String sql = "INSERT INTO doctors (full_name, email, specialization, phone, password, is_active) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, doctor.getFullName());
            ps.setString(2, doctor.getEmail());
            ps.setString(3, doctor.getSpecialization());
            ps.setString(4, doctor.getPhone());
            ps.setString(5, doctor.getPassword()); // Sets the default password from Admin
            ps.setBoolean(6, true); // Sets doctor as active by default

            ps.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // --- GET ALL DOCTORS ---
    public List<Doctor> getAllDoctors() {
        List<Doctor> doctors = new ArrayList<>();
        String sql = "SELECT * FROM doctors";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Doctor d = new Doctor();
                d.setId(rs.getInt("id"));
                d.setFullName(rs.getString("full_name"));
                d.setEmail(rs.getString("email"));
                d.setSpecialization(rs.getString("specialization"));
                d.setPhone(rs.getString("phone"));
                d.setActive(rs.getBoolean("is_active"));
                doctors.add(d);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doctors;
    }

    // --- GET DOCTOR BY ID ---
    public Doctor getDoctorById(int id) {
        Doctor d = null;
        String sql = "SELECT * FROM doctors WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    d = new Doctor();
                    d.setId(rs.getInt("id"));
                    d.setFullName(rs.getString("full_name"));
                    d.setEmail(rs.getString("email"));
                    d.setSpecialization(rs.getString("specialization"));
                    d.setPhone(rs.getString("phone"));
                    d.setActive(rs.getBoolean("is_active"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return d;
    }

    // --- DELETE (DEACTIVATE) DOCTOR ---
    public boolean deleteDoctor(int id) {
        String sql = "UPDATE doctors SET is_active = false WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // --- SET ACTIVE STATUS ---
    public boolean setDoctorActiveStatus(int doctorId, boolean isActive) {
        String sql = "UPDATE doctors SET is_active=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setBoolean(1, isActive);
            ps.setInt(2, doctorId);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}