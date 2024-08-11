package com.utez.edu.almacen.controllers.email;

import com.utez.edu.almacen.models.user.BeanUser;
import com.utez.edu.almacen.models.user.DaoUser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebServlet("/updatePassword")
public class UpdatePasswordServlet extends HttpServlet {
    private CustomerService customerService = new CustomerService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        String password1 = request.getParameter("password1");
        String password2 = request.getParameter("password2");

        if (!password1.equals(password2)) {
            request.setAttribute("message", "Las contraseñas no coinciden.");
            request.getRequestDispatcher("/path/to/reset-password.jsp").forward(request, response);
            return;
        }

        try {
            BeanUser user = customerService.validateResetToken(token);
            if (user == null) {
                request.setAttribute("message", "Token inválido o expirado.");
                request.getRequestDispatcher("/path/to/reset-password.jsp").forward(request, response);
                return;
            }

            boolean isUpdated = customerService.resetCustomerPassword(user.getEmail(), password1, token);
            if (isUpdated) {
                request.setAttribute("message", "Contraseña actualizada exitosamente.");
            } else {
                request.setAttribute("message", "Error al actualizar la contraseña.");
            }
            request.getRequestDispatcher("/path/to/reset-password.jsp").forward(request, response);
        } catch (RuntimeException e) {
            e.printStackTrace(); // Imprime la traza del error
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error updating password");
        }
    }
}
