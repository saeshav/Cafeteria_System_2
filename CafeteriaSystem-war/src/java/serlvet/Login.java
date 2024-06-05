package serlvet;

import facade.UserFacade;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;

@WebServlet(urlPatterns = {"/Login"})
public class Login extends HttpServlet {
    
    @EJB
    UserFacade userFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/login.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String accname = req.getParameter("accname");
        String password = req.getParameter("password");
        
        User found = userFacade.findByAccname(accname);
        
        if(found != null && found.getPassword().equals(password)) {
            HttpSession session = req.getSession();
            session.setAttribute("accname", accname);
            String status = found.getStatus();
            session.setAttribute("status", status);
            String redirectURL = determineRedirectURL(status);
            resp.sendRedirect(redirectURL);
        } else {
            req.setAttribute("success", "false");
            doGet(req,resp);
        }
    }
    
    private String determineRedirectURL(String status) {
        switch (status) {
            case "customer":
                return "CustomerHome";
            case "manager":
                return "ManagerHome";
            default:
                return "StallStaffHome";
        }
    }

}
