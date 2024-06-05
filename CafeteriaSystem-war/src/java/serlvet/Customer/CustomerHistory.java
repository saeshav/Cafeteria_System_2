package controller.Customer;

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

@WebServlet(urlPatterns = {"/CustomerHistory"})
public class CustomerHistory extends HttpServlet {
    @EJB
    CustomerFacade customerFacade;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accname = (String) session.getAttribute("accname");
        Customer customer = customerFacade.findByAccname(accname);
        request.setAttribute("customer", customer);
        request.setAttribute("orderHistory", customer.getOrder());
        request.getRequestDispatcher("WEB-INF/Customer/customer_history.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

}
