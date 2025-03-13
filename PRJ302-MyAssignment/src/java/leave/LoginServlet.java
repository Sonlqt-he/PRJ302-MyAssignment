/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package leave;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
/**
 *
 * @author LTSon
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        User user = DBUtil.getUserDB().login(username, password);
        
        System.out.println(user);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user_id", user.getId());
            session.setAttribute("full_name", user.getFullName());
            session.setAttribute("role", user.getRole());
            
            if ("manager".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("manage-leave.jsp");
            } else {
                response.sendRedirect("dashboard.jsp");
            }
        } else {
            response.sendRedirect("login.html?error=1");
        }
    }
}

   