package controller;

import dao.AppointmentDAO;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class CancelAppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentPatient") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int appointmentId = Integer.parseInt(request.getParameter("id"));

        AppointmentDAO dao = new AppointmentDAO();
        boolean success = dao.cancelAppointment(appointmentId);

        if (success) {
            response.sendRedirect("appointmentHistory.jsp?msg=cancelled");
        } else {
            response.sendRedirect("appointmentHistory.jsp?error=1");
        }
    }
}
