package serlvet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("accname") != null);

        String loginURI = httpRequest.getContextPath() + "/Login";
        // Allow static files
        String requestURI = httpRequest.getRequestURI().toLowerCase();
        boolean isResource = requestURI.endsWith(".css") || 
                             requestURI.endsWith(".png") || 
                             requestURI.endsWith(".jpg") || 
                             requestURI.endsWith(".jpeg") ||
                             requestURI.endsWith(".gif") ||
                             requestURI.contains("register");
        
        if (!isLoggedIn && !httpRequest.getRequestURI().endsWith("/Login")&& !isResource ) {
            httpResponse.sendRedirect(loginURI);
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
       
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        
    }

    
}
