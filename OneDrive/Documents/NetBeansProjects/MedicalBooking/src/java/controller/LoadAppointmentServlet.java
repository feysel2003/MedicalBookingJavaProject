package controller;

import dao.DoctorDAO;
import model.Doctor;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoadAppointmentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        DoctorDAO dao = new DoctorDAO();
        List<Doctor> list = dao.getAllDoctors();
        
        // This attribute name MUST match the JSP
        request.setAttribute("doctors", list);
        
        // Forward to the JSP page
        request.getRequestDispatcher("bookAppointment.jsp").forward(request, response);
    }
}