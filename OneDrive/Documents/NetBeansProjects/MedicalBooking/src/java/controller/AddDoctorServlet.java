package controller;

import dao.DoctorDAO;
import model.Doctor;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class AddDoctorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String specialization = request.getParameter("specialization");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password"); // Added this line

        Doctor doctor = new Doctor();
        doctor.setFullName(fullName);
        doctor.setEmail(email);
        doctor.setSpecialization(specialization);
        doctor.setPhone(phone);
        doctor.setPassword(password); // Ensure your Doctor model has a setPassword method

        DoctorDAO dao = new DoctorDAO();
        dao.addDoctor(doctor);

        HttpSession session = request.getSession();
        session.setAttribute("msg", "Doctor added successfully!");

        response.sendRedirect("ManageDoctorsServlet");
    }
}