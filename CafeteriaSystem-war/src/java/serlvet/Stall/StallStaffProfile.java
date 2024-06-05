package serlvet.Stall;

import facade.StallFacade;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Stall;

@WebServlet(urlPatterns = {"/StallStaffProfile"})
public class StallStaffProfile extends HttpServlet {
    @EJB
    StallFacade stallStaffFacade;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accname = (String)session.getAttribute("accname");
        Stall stallStaff = stallStaffFacade.findByAccname(accname);
        request.setAttribute("stallStaff", stallStaff);
        request.getRequestDispatcher("WEB-INF/Stall/stall_profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data from the request
        String accname = request.getParameter("accname");
        String contact_number = request.getParameter("contact_number");
        String password = request.getParameter("password");
        
        Stall updatedStall = stallStaffFacade.findByAccname(accname);
        updatedStall.setContact_number(contact_number);
        updatedStall.setPassword(password);
        
        stallStaffFacade.edit(updatedStall);
        
        response.sendRedirect("StallStaffProfile");
    }
}
