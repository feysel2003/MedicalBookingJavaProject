package dao;

import model.Appointment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    private Connection conn;

    // Constructor
    public AppointmentDAO() {
        conn = DBConnection.getConnection(); // Make sure DBConnection.java works
    }

    public List<Appointment> getAppointmentsByDoctor(int doctorId) {
    List<Appointment> list = new ArrayList<>();

    try {
        String sql =
            "SELECT a.*, p.full_name AS patient_name " +
            "FROM appointments a " +
            "JOIN patients p ON a.patient_id = p.id " +
            "WHERE a.doctor_id = ?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, doctorId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Appointment a = new Appointment();
            a.setId(rs.getInt("id"));
            a.setPatientName(rs.getString("patient_name"));
            a.setAppointmentDate(rs.getString("appointment_date"));
            a.setTimeSlot(rs.getString("time_slot"));
            a.setSymptoms(rs.getString("symptoms"));
            a.setStatus(rs.getString("status"));
            list.add(a);
        }

        rs.close();
        ps.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}

    
    
 
    
    
    public boolean bookAppointment(Appointment appointment) {
        
        
        try {
            String sql = "INSERT INTO appointments (patient_id, doctor_id, appointment_date, time_slot, symptoms) "
                       + "VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, appointment.getPatientId());
            ps.setInt(2, appointment.getDoctorId());
            ps.setString(3, appointment.getAppointmentDate());
            ps.setString(4, appointment.getTimeSlot());
            ps.setString(5, appointment.getSymptoms());

            int rows = ps.executeUpdate();
            ps.close();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean cancelAppointment(int appointmentId) {
    try {
        String sql = "UPDATE appointments SET status='CANCELLED' WHERE id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, appointmentId);
        int rows = ps.executeUpdate();
        ps.close();
        return rows > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}


public boolean rescheduleAppointment(int appointmentId, String newDate, String newTime) {
    try {
        String sql = "UPDATE appointments SET appointment_date=?, time_slot=? WHERE id=? AND status != 'CANCELLED'";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, newDate);
        ps.setString(2, newTime);
        ps.setInt(3, appointmentId);

        int rows = ps.executeUpdate();
        ps.close();
        return rows > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

    // Optional: example method to get appointments by patient
    public List<Appointment> getAppointmentsByPatient(int patientId) {
        List<Appointment> list = new ArrayList<>();
        try {
            String sql = "SELECT a.*, d.full_name AS doctor_name " +
                         "FROM appointments a " +
                         "JOIN doctors d ON a.doctor_id = d.id " +
                         "WHERE a.patient_id = ? " +
                         "ORDER BY a.appointment_date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, patientId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Appointment a = new Appointment();
                a.setId(rs.getInt("id"));
                a.setPatientId(rs.getInt("patient_id"));
                a.setDoctorId(rs.getInt("doctor_id"));
                a.setAppointmentDate(rs.getString("appointment_date"));
                a.setTimeSlot(rs.getString("time_slot"));
                a.setSymptoms(rs.getString("symptoms"));
                a.setDoctorName(rs.getString("doctor_name")); 
                a.setStatus(rs.getString("status"));
                list.add(a);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    
  public boolean updateAppointmentStatus(int appointmentId, String status) {
    try {
        String sql = "UPDATE appointments SET status=? WHERE id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, appointmentId);

        int rows = ps.executeUpdate();
        System.out.println("Rows updated = " + rows);

        ps.close();
        return rows > 0;

    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}

 
 public List<Appointment> getAllAppointments() {
    List<Appointment> list = new ArrayList<>();
    // SQL joining tables to get Patient and Doctor names for the Admin to see
    String sql = "SELECT a.*, p.full_name as p_name, d.full_name as d_name " +
                 "FROM appointments a " +
                 "JOIN patients p ON a.patient_id = p.id " +
                 "JOIN doctors d ON a.doctor_id = d.id " +
                 "ORDER BY a.appointment_date DESC";
    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        while (rs.next()) {
            Appointment app = new Appointment();
            app.setId(rs.getInt("id"));
            app.setPatientName(rs.getString("p_name"));
            app.setDoctorName(rs.getString("d_name"));
            app.setAppointmentDate(rs.getString("appointment_date"));
            app.setTimeSlot(rs.getString("time_slot"));
            app.setStatus(rs.getString("status"));
            list.add(app);
        }
    } catch (Exception e) { e.printStackTrace(); }
    return list;
}
 
 public List<Appointment> getAppointmentsByDoctorId(int doctorId) {
        List<Appointment> list = new ArrayList<>();
        // Query to join appointments with patients to get the patient's name
        String sql = "SELECT a.*, p.full_name AS patient_name " +
                     "FROM appointments a " +
                     "JOIN patients p ON a.patient_id = p.id " +
                     "WHERE a.doctor_id = ? " ;
                     

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, doctorId);
            ResultSet rs = ps.executeQuery();

        // Inside AppointmentDAO.java
while (rs.next()) {
    Appointment app = new Appointment();
    app.setId(rs.getInt("id"));
    app.setPatientId(rs.getInt("patient_id"));
    app.setDoctorId(rs.getInt("doctor_id"));
    app.setStatus(rs.getString("status"));
    app.setSymptoms(rs.getString("symptoms"));
    
    // USE THESE EXACT NAMES FROM YOUR MODEL:
    app.setPatientName(rs.getString("patient_name")); 
    app.setAppointmentDate(rs.getString("appointment_date"));
    app.setTimeSlot(rs.getString("time_slot"));
    
    list.add(app);
}
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}

