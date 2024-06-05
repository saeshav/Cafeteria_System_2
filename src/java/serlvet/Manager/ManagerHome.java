package serlvet.Manager;
import facade.CustomerFacade;
import facade.ManagerFacade;
import facade.MenuFacade;
import facade.MyorderFacade;
import facade.StallFacade;
import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Myorder;

@WebServlet(urlPatterns = {"/ManagerHome"})
public class ManagerHome extends HttpServlet {
    @EJB
    ManagerFacade managerFacade;
    @EJB
    CustomerFacade customerFacade;
    @EJB
    StallFacade stallFacade;
    @EJB
    MenuFacade menuFacade;
    @EJB
    MyorderFacade myorderFacade;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Myorder> orders = myorderFacade.findAll();
        int[] starCounts = new int[5];
        int totalRatings = 0;
        int numberOfOrders = orders.size();
        
        for (Myorder order : orders) {
            int rating = Integer.parseInt(order.getRating());
            switch (rating) {
                case 1:
                    starCounts[0]++;
                    break;
                case 2:
                    starCounts[1]++;
                    break;
                case 3:
                    starCounts[2]++;
                    break;
                case 4:
                    starCounts[3]++;
                    break;
                case 5:
                    starCounts[4]++;
                    break;
            }
        }


        for(int i=0; i<starCounts.length; i++) {
            totalRatings += (i+1) * starCounts[i];
        }
        System.out.println(totalRatings);

        double averageRating = (double) totalRatings / numberOfOrders;
        request.setAttribute("starCounts", starCounts);
        request.setAttribute("averageRating",averageRating);
        request.setAttribute("ordersCount",myorderFacade.count());
        request.setAttribute("customersCount",customerFacade.count());
        request.setAttribute("managersCount",managerFacade.count());
        request.setAttribute("stallStaffCount",stallFacade.count());
        request.setAttribute("menusCount",menuFacade.count());
        request.getRequestDispatcher("WEB-INF/Manager/manager_home.jsp").forward(request,response);
    }

}
