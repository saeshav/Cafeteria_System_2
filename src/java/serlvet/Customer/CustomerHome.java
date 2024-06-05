package controller.Customer;

import facade.MenuFacade;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Menu;


@WebServlet(urlPatterns = {"/CustomerHome"})
public class CustomerHome extends HttpServlet {
    @EJB
    MenuFacade menuFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String itemId = request.getParameter("itemId");
        if(itemId != null) {
            Menu menu = menuFacade.find(Long.parseLong(itemId));
            String jsonResponse = "{"
                + "\"itemId\":\"" + menu.getId() + "\","
                + "\"itemName\":\"" + menu.getItem() + "\","
                + "\"itemPrice\":\"" + menu.getPrice() + "\","
                + "\"itemImage\":\"" + menu.getImage() + "\""
                + "}";

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse);
            return;
        }
        List<Menu> menus = menuFacade.findAll();
        request.setAttribute("menus", menus);
        request.getRequestDispatcher("WEB-INF/Customer/customer_home.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String itemId = request.getParameter("id");
        HttpSession session = request.getSession(false);
        List<Menu> cart = (List<Menu>) session.getAttribute("cartItems");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cartItems", cart);
        }
        
        Menu menuSelected = menuFacade.find(Long.parseLong(itemId));

        cart.add(menuSelected);
        
        response.sendRedirect("CustomerHome");
    }


}
