package com.utez.edu.almacen.controllers.email;

import com.utez.edu.almacen.models.user.BeanUser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updatePassword")
public class UpdatePasswordServlet extends HttpServlet {
    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        String password1 = request.getParameter("password1");
        String password2 = request.getParameter("password2");

        // Check if passwords match
        if (!password1.equals(password2)) {
            request.setAttribute("message", "Las contraseñas no coinciden.");
            request.getRequestDispatcher("new-password.jsp").forward(request, response);
            return;
        }

        try {
            // Validate the reset token
            BeanUser user = customerService.validateResetToken(token);
            if (user == null) {
                request.setAttribute("message", "Token inválido o expirado.");
                request.getRequestDispatcher("new-password.jsp").forward(request, response);
                return;
            }

            // Update the password
            boolean isUpdated = customerService.resetCustomerPassword(user.getEmail(), password1, token);
            if (isUpdated) {
                response.sendRedirect("updatePassword.jsp"); // Redirect to login page or success page
            } else {
                request.setAttribute("message", "Error al actualizar la contraseña.");
                request.getRequestDispatcher("new-password.jsp").forward(request, response);
            }
        } catch (RuntimeException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al actualizar la contraseña");
        }
    }
}
