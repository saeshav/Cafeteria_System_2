package serlvet.Manager;

import facade.CustomerFacade;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Customer;

@WebServlet(urlPatterns = {"/ManagerCustomer"})
public class ManagerCustomer extends HttpServlet {
    
    @EJB
    CustomerFacade customerFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchUsername = request.getParameter("search");
        List<Customer> users = customerFacade.findAll();

        if (searchUsername != null && !searchUsername.isEmpty()) {
            users = filterCustomerList(users, searchUsername);
        }

        request.setAttribute("users", users);
        request.getRequestDispatcher("WEB-INF/Manager/manager_customer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("action: " + action);
        
        if ("update".equals(action)) {
            updateCustomer(request);
        } else if ("delete".equals(action)) {
            deleteCustomer(request);
        }
        
        response.sendRedirect("ManagerCustomer");
    }
    
    private void deleteCustomer(HttpServletRequest request) {
        // Delete operation
        String accname = request.getParameter("accname");
        Customer customerToDelete = customerFacade.findByAccname(accname);
        customerFacade.remove(customerToDelete);
    }

    private void updateCustomer(HttpServletRequest request) throws NumberFormatException {
        String accname = request.getParameter("accname");
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String contact_number = request.getParameter("contact_number");
        String password = request.getParameter("password");
        
        Customer customerToUpdate = customerFacade.findByAccname(accname);
        customerToUpdate.setAccname(accname);
        customerToUpdate.setName(name);
        customerToUpdate.setAge(age);
        customerToUpdate.setGender(gender);
        customerToUpdate.setContact_number(contact_number);
        customerToUpdate.setPassword(password);
        customerFacade.edit(customerToUpdate);
    }
    private List<Customer> filterCustomerList(List<Customer> users, String searchUsername) {
        List<Customer> filteredList = new ArrayList<>();
        users.stream().filter((user) -> (user.getAccname().contains(searchUsername))).forEachOrdered((user) -> {
            filteredList.add(user);
        });
        return filteredList;
    }
}
