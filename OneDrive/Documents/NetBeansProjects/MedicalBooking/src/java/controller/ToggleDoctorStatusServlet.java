package controller;

import dao.DoctorDAO;
import model.Admin;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class ToggleDoctorStatusServlet extends HttpServlet {

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    int id = Integer.parseInt(request.getParameter("id"));
    String action = request.getParameter("action");
    
    DoctorDAO dao = new DoctorDAO();
    boolean success = false;

    if ("activate".equals(action)) {
        success = dao.setDoctorActiveStatus(id, true);
    } else if ("deactivate".equals(action)) {
        success = dao.setDoctorActiveStatus(id, false);
    }

    // IMPORTANT: Redirect to the SERVLET that loads the doctors list
    response.sendRedirect("ManageDoctorsServlet"); 
}
}
