package controller;

import dao.AdminDAO;
import model.Admin;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Security Check: Fix the variable initialization
        HttpSession session = request.getSession(false);
        Admin admin = (session != null) ? (Admin) session.getAttribute("currentAdmin") : null;

        if (admin == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        // 2. Initialize DAO
        AdminDAO adminDao = new AdminDAO();

        try {
            // 3. Fetch data
            int totalDoctors = adminDao.getTotalCount("doctors");
            int totalPatients = adminDao.getTotalCount("patients");
            int totalAppointments = adminDao.getTotalCount("appointments");

            // 4. Set attributes
            request.setAttribute("totalDoctors", totalDoctors);
            request.setAttribute("totalPatients", totalPatients);
            request.setAttribute("totalAppointments", totalAppointments);

            // 5. Forward to JSP
            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Dashboard loading failed.");
        }
    }
}