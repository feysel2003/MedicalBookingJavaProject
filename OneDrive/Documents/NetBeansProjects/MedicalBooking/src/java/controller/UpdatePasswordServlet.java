package controller;

import model.Doctor;
import dao.DBConnection; // Corrected package import

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UpdatePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Ensure "doctorObj" matches what you set during login
        Doctor currentDoc = (Doctor) session.getAttribute("doctorObj"); 
        
        if (currentDoc == null) {
            response.sendRedirect("doctorLogin.jsp");
            return;
        }

        String currentInput = request.getParameter("currentPassword");
        String newPass = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmPassword");

        // Validate new passwords match
        if (newPass == null || !newPass.equals(confirmPass)) {
            session.setAttribute("errorMsg", "New passwords do not match!");
            response.sendRedirect("changePassword.jsp");
            return;
        }

        try (Connection con = DBConnection.getConnection()) { 
            
            // Querying 'doctors' table using 'id' from the session object
            String checkSql = "SELECT password FROM doctors WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(checkSql);
            ps.setInt(1, currentDoc.getId());
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");
                
                // Compare input current password with database password
                if (dbPassword.equals(currentInput)) {
                    String updateSql = "UPDATE doctors SET password = ? WHERE id = ?";
                    PreparedStatement psUpdate = con.prepareStatement(updateSql);
                    psUpdate.setString(1, newPass);
                    psUpdate.setInt(2, currentDoc.getId());
                    
                    int i = psUpdate.executeUpdate();
                    if (i == 1) {
                        session.setAttribute("succMsg", "Password updated successfully!");
                        response.sendRedirect("doctorDashboard.jsp");
                    } else {
                        session.setAttribute("errorMsg", "Update failed. Please try again.");
                        response.sendRedirect("changePassword.jsp");
                    }
                } else {
                    session.setAttribute("errorMsg", "Current password is incorrect!");
                    response.sendRedirect("changePassword.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Database Error: " + e.getMessage());
            response.sendRedirect("changePassword.jsp");
        }
    }
}