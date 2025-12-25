package controller;

import dao.DoctorDAO;
import model.Admin;
import model.Doctor;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ManageDoctorsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Session Security
        HttpSession session = request.getSession(false);
        Admin admin = (session != null) ? (Admin) session.getAttribute("currentAdmin") : null;

        if (admin == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        DoctorDAO dao = new DoctorDAO();

        // 2. THE DELETE LOGIC (MUST BE AT THE TOP)
        String deleteIdStr = request.getParameter("deleteId");
        if (deleteIdStr != null && !deleteIdStr.isEmpty()) {
            try {
                int id = Integer.parseInt(deleteIdStr);
                // Execute the delete in the database
                boolean success = dao.deleteDoctor(id);
                
                if (success) {
                    session.setAttribute("message", "Doctor ID " + id + " has been deleted.");
                } else {
                    session.setAttribute("message", "Error: Doctor has appointments and cannot be deleted.");
                }
                
                // IMPORTANT: Redirect refreshes the database data on the screen
                response.sendRedirect("ManageDoctorsServlet");
                return; 
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // 3. FETCH DATA (This only runs if NO delete happened)
        List<Doctor> doctors = dao.getAllDoctors();
        request.setAttribute("doctors", doctors);
        request.getRequestDispatcher("manageDoctors.jsp").forward(request, response);
    }
}