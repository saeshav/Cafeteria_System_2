package serlvet.Stall;

import facade.MenuFacade;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Menu;

@WebServlet(urlPatterns = {"/StallStaffMenu"})
public class StallStaffMenu extends HttpServlet {

    @EJB
    MenuFacade menuFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchItem = request.getParameter("search");
        List<Menu> menuItems = menuFacade.findAll();

        if (searchItem != null && !searchItem.isEmpty()) {
            menuItems = filterMenuList(menuItems, searchItem);
        }

        request.setAttribute("menuItems", menuItems);
        request.getRequestDispatcher("WEB-INF/Stall/stall_menu.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addMenuItem(request);
        } else if ("update".equals(action)) {
            updateMenuItem(request);
        } else if ("delete".equals(action)) {
            deleteMenuItem(request);
        }

        response.sendRedirect("StallStaffMenu");
    }

    private void addMenuItem(HttpServletRequest request) {
        String item = request.getParameter("item");
        double price = Double.parseDouble(request.getParameter("price"));
        String image = request.getParameter("image");

        Menu newMenuItem = new Menu(item, price, image);
        menuFacade.create(newMenuItem);
    }

    private void deleteMenuItem(HttpServletRequest request) {
        long id = Long.parseLong(request.getParameter("id"));
        Menu menuToDelete = menuFacade.find(id);
        menuFacade.remove(menuToDelete);
    }

    private void updateMenuItem(HttpServletRequest request) {
        long id = Long.parseLong(request.getParameter("id"));
        String item = request.getParameter("item");
        double price = Double.parseDouble(request.getParameter("price"));
        String image = request.getParameter("image");

        Menu menuToUpdate = menuFacade.find(id);
        menuToUpdate.setItem(item);
        menuToUpdate.setPrice(price);
        menuToUpdate.setImage(image);

        menuFacade.edit(menuToUpdate);
    }

    private List<Menu> filterMenuList(List<Menu> menuItems, String searchItem) {
        List<Menu> filteredMenu = new ArrayList<>();
        menuItems.stream().filter((menu) -> (menu.getItem().contains(searchItem))).forEachOrdered((manager) -> {
            filteredMenu.add(manager);
        });
        return filteredMenu;
    }
}
