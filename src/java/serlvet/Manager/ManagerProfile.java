package serlvet.Manager;

import facade.ManagerFacade;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Manager;

@WebServlet(urlPatterns = {"/ManagerProfile"})
public class ManagerProfile extends HttpServlet {
    @EJB
    ManagerFacade managerFacade;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accname = (String)session.getAttribute("accname");
        Manager manager = managerFacade.findByAccname(accname);
        request.setAttribute("manager", manager);
        request.getRequestDispatcher("WEB-INF/Manager/manager_profile.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data from the request
        String accname = request.getParameter("accname");
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String contact_number = request.getParameter("contact_number");
        String password = request.getParameter("password");
        Manager updatedManager = managerFacade.findByAccname(accname);
        updatedManager.setName(name);
        updatedManager.setAge(age);
        updatedManager.setGender(gender);
        updatedManager.setContact_number(contact_number);
        updatedManager.setPassword(password);
        managerFacade.edit(updatedManager);
        
        response.sendRedirect("ManagerProfile");
    }


}
