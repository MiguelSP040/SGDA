package com.utez.edu.almacen.controllers.email;

import com.utez.edu.almacen.utils.EmailUtility;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.mail.MessagingException;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/resetPassword")
public class ResetPasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");

        if (email != null && !email.isEmpty()) {
            CustomerService customerService = new CustomerService();
            boolean emailExists = customerService.doesEmailExist(email);

            if (!emailExists) {
                request.setAttribute("message", "Correo no registrado.");
                request.getRequestDispatcher("/recoverPassword.jsp").forward(request, response);
                return;
            }

            String resetToken = UUID.randomUUID().toString();
            String resetLink = request.getRequestURL().toString().replace(request.getRequestURI(), request.getContextPath() + "/newPassword.jsp?token=" + resetToken);

            try {
                EmailUtility.sendResetPasswordEmail(email, resetLink);
            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }

            customerService.saveResetToken(email, resetToken);
            response.sendRedirect("resetPasswordConfirmation.jsp");
        } else {
            request.setAttribute("message", "Por favor, ingrese un correo electrónico.");
            request.getRequestDispatcher("/recoverPassword.jsp").forward(request, response);
        }
    }
}