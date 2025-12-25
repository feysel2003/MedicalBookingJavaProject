package controller;

import dao.AppointmentDAO;
import model.Appointment;
import model.Doctor;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class DoctorDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get the session
        HttpSession session = request.getSession(false);
        Doctor doctor = (session != null) ? (Doctor) session.getAttribute("currentDoctor") : null;

        // 2. Debugging: Print to console to see if the doctor exists
        if (doctor == null) {
            System.out.println("DEBUG: No doctor found in session. Redirecting to login.");
            response.sendRedirect("doctorLogin.jsp");
            return;
        }

        System.out.println("DEBUG: Loading dashboard for Dr. " + doctor.getFullName());

        try {
            // 3. Fetch data
            AppointmentDAO appDao = new AppointmentDAO();
            List<Appointment> list = appDao.getAppointmentsByDoctorId(doctor.getId());
            
            // 4. Pass data to JSP
            request.setAttribute("appointments", list);
            
            // 5. FORWARD to the JSP file
            // Make sure the filename matches exactly!
            request.getRequestDispatcher("doctorDashboard.jsp").forward(request, response);
            
      } catch (Exception e) {
    System.out.println("DEBUG: Error in Dashboard Servlet: " + e.getMessage());
    e.printStackTrace();
    
    // Set content type so the browser knows to show text
    response.setContentType("text/html");
    response.getWriter().println("<html><body>");
    response.getWriter().println("<h3>Dashboard Error: " + e.getMessage() + "</h3>");
    response.getWriter().println("<p>Check your console/server logs for details.</p>");
    response.getWriter().println("</body></html>");
    return; // CRITICAL: Stop the servlet here so it doesn't try to forward
}
    }
}