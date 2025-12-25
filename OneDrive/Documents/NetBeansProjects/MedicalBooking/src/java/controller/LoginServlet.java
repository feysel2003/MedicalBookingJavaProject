package controller;

import dao.PatientDAO;
import model.Patient;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        PatientDAO dao = new PatientDAO();
        Patient patient = dao.loginPatient(email, password);

        if (patient != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentPatient", patient);
            response.sendRedirect("patientDashboard.jsp");
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }
}
