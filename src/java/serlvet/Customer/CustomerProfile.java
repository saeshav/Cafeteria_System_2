package serlvet.Customer;

import facade.CustomerFacade;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;

@WebServlet(urlPatterns = {"/CustomerProfile"})
public class CustomerProfile extends HttpServlet {
    @EJB
    CustomerFacade customerFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accname = (String) session.getAttribute("accname");
        Customer customer = customerFacade.findByAccname(accname);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("WEB-INF/Customer/customer_profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accname = request.getParameter("accname");
        String contact_number = request.getParameter("contact_number");
        String password = request.getParameter("password");
        
        Customer updatedCustomer = customerFacade.findByAccname(accname);
        updatedCustomer.setContact_number(contact_number);
        updatedCustomer.setPassword(password);
        
        customerFacade.edit(updatedCustomer);
        
        response.sendRedirect("CustomerProfile");
    }
}
