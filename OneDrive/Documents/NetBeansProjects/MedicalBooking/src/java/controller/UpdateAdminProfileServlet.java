package controller;

import dao.AdminDAO;
import model.Admin;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/UpdateAdminProfileServlet")
public class UpdateAdminProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Admin admin = (Admin) session.getAttribute("currentAdmin");
        
        if (admin == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String newPass = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmPassword");

        if (newPass != null && newPass.equals(confirmPass)) {
            AdminDAO dao = new AdminDAO();
            if (dao.updateAdminPassword(admin.getId(), newPass)) {
                session.setAttribute("message", "Password updated successfully!");
            } else {
                session.setAttribute("error", "Database error occurred.");
            }
        } else {
            session.setAttribute("error", "Passwords do not match.");
        }
        
        response.sendRedirect("AdminDashboardServlet");
    }
}