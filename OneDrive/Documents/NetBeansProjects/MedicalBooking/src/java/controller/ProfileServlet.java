package controller;

import dao.PatientDAO;
import model.Patient;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Patient patient = (Patient) session.getAttribute("currentPatient");

        if (patient == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.setAttribute("patient", patient);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
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

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        patient.setFullName(fullName);
        patient.setEmail(email);
        patient.setPhone(phone);

        PatientDAO dao = new PatientDAO();
        boolean success = dao.updatePatient(patient);

        if (success) {
            session.setAttribute("currentPatient", patient);
            response.sendRedirect("profile.jsp?msg=updated");
        } else {
            response.sendRedirect("profile.jsp?error=1");
        }
    }
}
