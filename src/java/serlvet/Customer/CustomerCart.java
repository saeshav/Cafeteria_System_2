package serlvet.Customer;

import facade.CustomerFacade;
import facade.CustomerProfileFacade;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Customer;
import model.Menu;
import model.Myorder;

@WebServlet(urlPatterns = {"/CustomerCart"})
public class CustomerCart extends HttpServlet {

    @EJB
    CustomerFacade customerFacade;
    @EJB
    CustomerProfileFacade customerProfileFacade;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/Customer/customer_cart.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String itemId = request.getParameter("itemId");
         String menus = request.getParameter("menu");
        String quantity = request.getParameter("quantity");
        String rating = request.getParameter("rating");
        String feedback = request.getParameter("feedback");
        String totalPrice = request.getParameter("totalPrice");
        String balance = request.getParameter("balance");

        if(itemId != null) {
            List<Menu> menuList = (List<Menu>) request.getSession().getAttribute("cartItems");

            if (menuList != null) {
                Iterator<Menu> iterator = menuList.iterator();
                while (iterator.hasNext()) {
                    Menu menu = iterator.next();
                    if (menu.getId() == Long.parseLong(itemId)) {
                        iterator.remove();
                        break;
                    }
                }
            }

            request.getSession().setAttribute("cartItems", menuList);
            request.setAttribute("cartItems", menuList);
            response.sendRedirect("CustomerCart");
            return;
        }
        
        // When payment done
        if(menus != null) {
            // Use the retrieved data as needed
            System.out.println("Menu: " + menus);
            System.out.println("Quantity: " + quantity);
            System.out.println("Rating: " + rating);
            System.out.println("Feedback: " + feedback);
            System.out.println("Total Price: " + totalPrice);
    
            String currentUser = (String)request.getSession(false).getAttribute("accname");
            Customer currentCustomer = customerFacade.findByAccname(currentUser);
            List<Myorder> newOrder = currentCustomer.getOrder();
            Date date = new Date();
            double price = Double.parseDouble(totalPrice);
            int qt = Integer.parseInt(quantity);
            Myorder myOrder = new Myorder(menus, rating, feedback, date, price,qt);
            newOrder.add(myOrder);
            currentCustomer.setOrder(newOrder);
            System.out.println(Double.parseDouble(balance) - price);
            currentCustomer.getCustomerRelation().setBalance(Double.parseDouble(balance) - price);
            customerFacade.edit(currentCustomer);
            customerProfileFacade.edit(currentCustomer.getCustomerRelation());
            request.getSession().setAttribute("cartItems", new ArrayList<>());
        }
        
    }


}
