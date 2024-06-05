package serlvet.Manager;

import facade.StallFacade;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Stall;

@WebServlet(urlPatterns = {"/ManagerStallStaff"})
public class ManagerStallStaff extends HttpServlet {
    @EJB
    StallFacade stallFacade;
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchUsername = request.getParameter("search");
        List<Stall> users = stallFacade.findAll();
        if(searchUsername != null && !searchUsername.isEmpty()) {
            List<Stall> filteredUsers = filterStaffList(users, searchUsername);
            request.setAttribute("staffList", filteredUsers);
        } else {
            request.setAttribute("staffList", users);
        }
        System.out.println("Search is: " + users.toString());
        request.getRequestDispatcher("WEB-INF/Manager/manager_stall.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null && !action.isEmpty()) {
            switch (action) {
                case "update":
                    updateStaff(request, response);
                    break;
                case "delete":
                    deleteStaff(request, response);
                    break;
                default:
                    response.sendRedirect("Error");
                    break;
            }
        }
    }
    
    private void updateStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String accname = request.getParameter("accname");
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String contact_number = request.getParameter("contact_number");
        String password = request.getParameter("password");
        String status = request.getParameter("status");
        Stall stallToUpdate = stallFacade.findByAccname(accname);
        stallToUpdate.setName(name);
        stallToUpdate.setAge(age);
        stallToUpdate.setGender(gender);
        stallToUpdate.setContact_number(contact_number);
        stallToUpdate.setPassword(password);
        stallToUpdate.setStatus(status);
        stallFacade.edit(stallToUpdate);
        response.sendRedirect("ManagerStallStaff");
    }

    private void deleteStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the accname of the staff to be deleted
        String accname = request.getParameter("accname");
        Stall stallToDelete =  stallFacade.findByAccname(accname);
        stallFacade.remove(stallToDelete);
        response.sendRedirect("ManagerStallStaff");
    }

    private List<Stall> filterStaffList(List<Stall> users, String searchUsername) {
        List<Stall> filteredList = new ArrayList<>();
        users.stream().filter((user) -> (user.getAccname().contains(searchUsername))).forEachOrdered((user) -> {
            filteredList.add(user);
        });
        return filteredList;
    }


}
