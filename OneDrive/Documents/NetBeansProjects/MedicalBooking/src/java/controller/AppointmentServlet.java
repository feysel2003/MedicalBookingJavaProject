package controller;

import dao.AppointmentDAO;
import dao.DoctorDAO;
import model.Appointment;
import model.Doctor;
import model.Patient;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class AppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if patient is logged in
        HttpSession session = request.getSession(false);
        Patient patient = (session != null) ? (Patient) session.getAttribute("currentPatient") : null;

        if (patient == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Fetch all active doctors
        DoctorDAO doctorDAO = new DoctorDAO();
        List<Doctor> doctors = doctorDAO.getAllDoctors();
        request.setAttribute("doctors", doctors);

        // Forward to booking JSP
        request.getRequestDispatcher("bookAppointment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if patient is logged in
        HttpSession session = request.getSession(false);
        Patient patient = (session != null) ? (Patient) session.getAttribute("currentPatient") : null;

        if (patient == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Read form parameters
            int doctorId = Integer.parseInt(request.getParameter("doctorId"));
            String date = request.getParameter("appointmentDate");
            String timeSlot = request.getParameter("timeSlot");
            String symptoms = request.getParameter("symptoms");

            String dateStr = request.getParameter("appointmentDate");
            LocalDate appointmentDate = LocalDate.parse(dateStr);
            LocalDate today = LocalDate.now();

            // Check if the selected date is in the past
            if (appointmentDate.isBefore(today)) {
             response.sendRedirect("AppointmentServlet?error=pastDate");
            return;
            }


            // Create appointment object
            Appointment appointment = new Appointment();
            appointment.setPatientId(patient.getId());
            appointment.setDoctorId(doctorId);
            appointment.setAppointmentDate(date);
            appointment.setTimeSlot(timeSlot);
            appointment.setSymptoms(symptoms);

            // Save appointment
            AppointmentDAO dao = new AppointmentDAO();
            boolean success = dao.bookAppointment(appointment);

            // Redirect based on success
            if (success) {
                response.sendRedirect("appointmentHistory.jsp");
            } else {
                response.sendRedirect("AppointmentServlet?error=1");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("AppointmentServlet?error=1");
        }
    }
}
