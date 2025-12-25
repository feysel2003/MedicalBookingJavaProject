package controller;

import dao.PatientDAO;
import model.Patient;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ManagePatientsServlet")
public class ManagePatientsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        PatientDAO dao = new PatientDAO();
        List<Patient> list = dao.getAllPatients();
        
        request.setAttribute("patients", list);
        
        request.getRequestDispatcher("managePatients.jsp").forward(request, response);
    }
}