package controller;

import dao.DoctorDAO;
import model.Doctor;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditDoctorPageServlet")
public class EditDoctorPageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            DoctorDAO dao = new DoctorDAO();
            Doctor doctor = dao.getDoctorById(id);
            
            request.setAttribute("doctor", doctor);
            
            request.getRequestDispatcher("editDoctor.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ManageDoctorsServlet");
        }
    }
}