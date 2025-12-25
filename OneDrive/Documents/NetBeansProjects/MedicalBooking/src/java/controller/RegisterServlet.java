package controller;

import dao.PatientDAO;
import model.Patient;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");

        Patient patient = new Patient();
        patient.setFullName(fullName);
        patient.setEmail(email);
        patient.setPassword(password); // (we’ll hash later)
        patient.setPhone(phone);
        patient.setAddress(address);
        patient.setGender(gender);
        patient.setDateOfBirth(Date.valueOf(dob));

        PatientDAO dao = new PatientDAO();
        boolean success = dao.registerPatient(patient);

        if (success) {
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("register.jsp?error=1");
        }
    }
}
