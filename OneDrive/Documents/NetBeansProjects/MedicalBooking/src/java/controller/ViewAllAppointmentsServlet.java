package controller;

import dao.AppointmentDAO;
import model.Appointment;
import model.Admin;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ViewAllAppointmentsServlet")
public class ViewAllAppointmentsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Security Check
        HttpSession session = request.getSession(false);
        Admin admin = (session != null) ? (Admin) session.getAttribute("currentAdmin") : null;
        if (admin == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        AppointmentDAO dao = new AppointmentDAO();
        // We use the DAO to get all appointments in the system
        List<Appointment> allAppointments = dao.getAllAppointments(); 
        
        request.setAttribute("appointments", allAppointments);
        request.getRequestDispatcher("manageAppointments.jsp").forward(request, response);
    }
}