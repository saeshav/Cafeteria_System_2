
import facade.ManagerProfileFacade;
import facade.UserFacade;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Manager;
import model.ManagerProfile;
import model.User;

@WebServlet(urlPatterns = {"/ManagerRegister"})
public class ManagerRegister extends HttpServlet {
    
    @EJB
    UserFacade userFacade;
    @EJB
    ManagerProfileFacade managerProfileFacade;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/Manager/manager_register.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("Name");
        int age = Integer.parseInt(request.getParameter("Age"));
        String gender = request.getParameter("Gender");
        String contact_number = request.getParameter("contact_number");
        String accname = request.getParameter("accname");
        String password = request.getParameter("password");
        
        // Check if accname already exists
        User found = userFacade.findByAccname(accname);
        if(found != null) {
            request.setAttribute("success", "false");
            doGet(request,response);
            return;
        }
        
        
        ManagerProfile managerProfile = new ManagerProfile();

        managerProfileFacade.create(managerProfile);
        Manager newManager = new Manager(managerProfile, accname, age, gender, name, password, contact_number);
        userFacade.create(newManager);
        response.sendRedirect("Login");
    }


}
