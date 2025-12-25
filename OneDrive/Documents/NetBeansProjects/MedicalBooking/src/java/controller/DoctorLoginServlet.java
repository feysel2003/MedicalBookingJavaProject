package controller;

import dao.DoctorDAO;
import model.Doctor;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class DoctorLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            DoctorDAO dao = new DoctorDAO();
            Doctor doctor = dao.login(email, password); 

            if (doctor != null) {
                HttpSession session = request.getSession();
                
                session.setAttribute("currentDoctor", doctor);
                
                if ("doc123".equals(password)) {
                    response.sendRedirect("DoctorDashboardServlet");
                } else {
                    response.sendRedirect("DoctorDashboardServlet");
                }
                return; 
                
            } else {
                System.out.println("DEBUG: Login failed for email: " + email);
                HttpSession session = request.getSession();
                session.setAttribute("errorMsg", "Invalid Email or Password");
                response.sendRedirect("doctorLogin.jsp");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("doctorLogin.jsp?error=server");
        }
    }
}