package serlvet.Stall;

import facade.MenuFacade;
import facade.MyorderFacade;
import facade.StallFacade;
import facade.UserFacade;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Menu;
import model.Myorder;
import model.Stall;

@WebServlet(urlPatterns = {"/StallStaffHome"})
public class StallStaffHome extends HttpServlet {

    @EJB
    MyorderFacade myorderFacade;
    @EJB
    UserFacade userFacade;
    @EJB
    MenuFacade menuFacade;

    @EJB
    MyorderFacade orderFacade;
    @EJB
    StallFacade stallStaffFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Myorder> orders = myorderFacade.findAll();
        int totalRatings = 0;
        int numberOfOrders = orders.size();

        totalRatings = orders.stream().map((order) -> Integer.parseInt(order.getRating())).reduce(totalRatings, Integer::sum);

        double averageRating = (double) totalRatings / numberOfOrders;
        request.setAttribute("averageRating", averageRating);
        request.setAttribute("ordersCount", myorderFacade.count());
        request.setAttribute("femaleCount", userFacade.countGender("Female"));
        request.setAttribute("maleCount", userFacade.countGender("Male"));
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("accname");
        Stall currentUser = stallStaffFacade.findByAccname(username);
        List<Myorder> stallOrders = findOrdersForStall(currentUser.getAccname());

        request.setAttribute("orderHistory", stallOrders);
        request.getRequestDispatcher("WEB-INF/Stall/stall_home.jsp").forward(request, response);

    }

    private List<Myorder> findOrdersForStall(String username) {
        List<Myorder> stallOrders = new ArrayList<>();
        List<Myorder> orders = orderFacade.findAll();
//        List<Menu> allmenu = menuFacade.findAll();
//        for (Myorder order : orders) {
//            List<String> menus = null;
//            menus.add(order.getMenu());
//            for (String menu : menus) {
//                if (allmenu.getStall().getUsername().equals(username)) {
//                    stallOrders.add(order);
//                    break;
//                }
//            }
//        }
        return orders;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
