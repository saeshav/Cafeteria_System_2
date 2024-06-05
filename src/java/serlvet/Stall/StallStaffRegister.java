package serlvet.Stall;

import facade.StaffProfileFacade;
import facade.UserFacade;
import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.StaffProfile;
import model.Stall;
import model.User;

@WebServlet(urlPatterns = {"/StallStaffRegister"})
public class StallStaffRegister extends HttpServlet {

    @EJB
    UserFacade userFacade;
    @EJB
    StaffProfileFacade stallProfileFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/Stall/stall_register.jsp").forward(request, response);
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
        List<User> accnames = userFacade.findAll();
        for (User user : accnames) {
            if (accname.equals(user.getAccname())) {
                request.setAttribute("error", "Username :" + accname + " already exists");
                doGet(request, response);
                break;
            }
        }

        StaffProfile stallProfile = new StaffProfile();

        stallProfileFacade.create(stallProfile);
        Stall newStall = new Stall(stallProfile, accname, age, gender, name, password, contact_number);
        userFacade.create(newStall);
        response.sendRedirect("Login");
    }

}
