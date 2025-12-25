package controller;

import dao.AppointmentDAO;
import model.Patient;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class RescheduleAppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Patient patient = (Patient) session.getAttribute("currentPatient");
        if (patient == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get appointment id from request
        int appointmentId = Integer.parseInt(request.getParameter("id"));
        request.setAttribute("appointmentId", appointmentId);

        // Forward to reschedule page
        request.getRequestDispatcher("rescheduleAppointment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Patient patient = (Patient) session.getAttribute("currentPatient");
        if (patient == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
            String newDateStr = request.getParameter("appointmentDate"); // get from form
            String newTime = request.getParameter("timeSlot");

            // --- Validate date ---
            LocalDate newDate = LocalDate.parse(newDateStr);
            LocalDate today = LocalDate.now();

            if (newDate.isBefore(today)) {
                // Stop rescheduling and redirect with error
                response.sendRedirect("appointmentHistory.jsp?error=pastDate");
                return;
            }

            // --- Update in database ---
            AppointmentDAO dao = new AppointmentDAO();
            boolean success = dao.rescheduleAppointment(appointmentId, newDateStr, newTime);

            if (success) {
                response.sendRedirect("appointmentHistory.jsp?msg=rescheduled");
            } else {
                response.sendRedirect("appointmentHistory.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("appointmentHistory.jsp?error=1");
        }
    }
}
