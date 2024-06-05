package serlvet.Customer;

import facade.CustomerFacade;
import facade.CustomerProfileFacade;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CustomerProfile;

@WebServlet("/Balance")
public class Balance extends HttpServlet {
    @EJB
    CustomerFacade customerFacade;
    @EJB
    CustomerProfileFacade customerProfileFacade;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String accname = (String) session.getAttribute("accname");
        double balance = fetchBalanceFromDatabase(accname); 
        request.setAttribute("balance", balance);
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(Double.toString(balance));
    }
    
    // Method to fetch balance from the database (replace this with your logic)
    private double fetchBalanceFromDatabase(String accname) {
        return customerFacade.findByAccname(accname).getCustomerRelation().getBalance();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String accname = (String) session.getAttribute("accname");
        String balance = req.getParameter("balance");
        CustomerProfile customerProfile = customerFacade.findByAccname(accname).getCustomerRelation();
        customerProfile.setBalance(Double.parseDouble(balance));
        customerProfileFacade.edit(customerProfile);
    }
    
    
}
