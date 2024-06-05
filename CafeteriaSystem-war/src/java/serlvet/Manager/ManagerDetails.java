package controller.Manager;

import facade.ManagerFacade;
import facade.ManagerProfileFacade;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Manager;
import model.ManagerProfile;


@WebServlet(urlPatterns = {"/ManagerDetails"})
public class ManagerDetails extends HttpServlet {
    
    @EJB
    ManagerFacade managerFacade;
    @EJB
    ManagerProfileFacade managerProfileFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchUsername = request.getParameter("search");
        List<Manager> managers = managerFacade.findAll();

        if (searchUsername != null && !searchUsername.isEmpty()) {
            managers = filterManagerList(managers, searchUsername);
        }

        request.setAttribute("managers", managers);
        request.getRequestDispatcher("WEB-INF/Manager/manager_detail.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("action: " +action);
        if ("add".equals(action)) {
            addManager(request);
        } else if ("update".equals(action)) {
            updateManager(request);
        } else if ("delete".equals(action)) {
            deleteManager(request);
        }

        response.sendRedirect("ManagerDetails");
    }

    private void addManager(HttpServletRequest request) throws NumberFormatException {
        String accname = request.getParameter("accname");
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String contact_number = request.getParameter("contact_number");
        String password = request.getParameter("password");
        
        ManagerProfile managerProfile = new ManagerProfile();
        managerProfileFacade.create(managerProfile);
        Manager manager = new Manager(managerProfile, accname, age, gender, name, password, contact_number);
        managerFacade.create(manager);
    }

    private void deleteManager(HttpServletRequest request) {
        // Delete operation
        String accname = request.getParameter("accname");
        Manager managerToDelete = managerFacade.findByAccname(accname);
        managerFacade.remove(managerToDelete);
    }

    private void updateManager(HttpServletRequest request) throws NumberFormatException {
        String accname = request.getParameter("accname");
        String contact_number = request.getParameter("contact_number");
        String password = request.getParameter("password");
        
        Manager updatedManager = managerFacade.findByAccname(accname);

        updatedManager.setContact_number(contact_number);
        updatedManager.setPassword(password);
        managerFacade.edit(updatedManager);
    }
    
    private List<Manager> filterManagerList(List<Manager> managers, String searchUsername) {
        List<Manager> filteredList = new ArrayList<>();
        managers.stream().filter((manager) -> (manager.getAccname().contains(searchUsername))).forEachOrdered((manager) -> {
            filteredList.add(manager);
        });
        return filteredList;
    }
}
