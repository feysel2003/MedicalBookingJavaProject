package controller;

import dao.DoctorDAO;
import model.Doctor;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class EditDoctorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        DoctorDAO dao = new DoctorDAO();
        Doctor doctor = dao.getDoctorById(id);

        request.setAttribute("doctor", doctor);
        request.getRequestDispatcher("editDoctor.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Here you will update doctor info from the form
    }
}
