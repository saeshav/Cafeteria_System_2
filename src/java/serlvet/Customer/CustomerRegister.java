package serlvet.Customer;

import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;
import model.CustomerProfile;
import facade.CustomerProfileFacade;
import facade.UserFacade;
import model.Customer;

@WebServlet(urlPatterns = {"/CustomerRegister"})
public class CustomerRegister extends HttpServlet {

    @EJB
    private CustomerProfileFacade cusproFacade;

    @EJB
    private UserFacade userFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/Customer/customer_register.jsp").forward(request,response);
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
        
        CustomerProfile customerProfile = new CustomerProfile();
        customerProfile.setBalance(0);
        cusproFacade.create(customerProfile);
        Customer newCustomer = new Customer( accname, name, age, gender, contact_number, password);
        newCustomer.setCustomerRelation(customerProfile);
        userFacade.create(newCustomer);
        response.sendRedirect("Login");

    }

}

