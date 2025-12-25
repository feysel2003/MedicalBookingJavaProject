package controller;

import dao.AppointmentDAO;
import model.Doctor;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class UpdateAppointmentStatusServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Doctor doctor = (session != null) ? (Doctor) session.getAttribute("currentDoctor") : null;

        if (doctor == null) {
            response.sendRedirect("doctorLogin.jsp");
            return;
        }

        String idParam = request.getParameter("id");
        String status = request.getParameter("status");

        if (idParam != null && status != null) {
            try {
                int appointmentId = Integer.parseInt(idParam);
                
              
                AppointmentDAO dao = new AppointmentDAO();

           
                dao.updateAppointmentStatus(appointmentId, status); 

                response.sendRedirect("DoctorDashboardServlet");
                

            } catch (NumberFormatException e) {
                response.getWriter().println("Invalid Appointment ID format.");
            }
        } else {
            response.sendRedirect("DoctorDashboardServlet");
        }
    }
}