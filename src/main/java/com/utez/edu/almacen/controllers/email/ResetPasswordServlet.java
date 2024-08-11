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
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        if (email != null && !email.isEmpty()) {
            CustomerService customerService = new CustomerService();
            String resetToken = UUID.randomUUID().toString();
            String resetLink = request.getRequestURL().toString().replace(request.getRequestURI(), request.getContextPath() + "/newPassword.jsp?token=" + resetToken);

            // Send email with resetLink
            try {
                EmailUtility.sendResetPasswordEmail(email, resetLink);
            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }

            // Save resetToken to database associated with user email
            customerService.saveResetToken(email, resetToken);

            response.sendRedirect("resetPasswordConfirmation.jsp"); // A page that confirms the email was sent
        } else {
            response.sendRedirect("error.jsp"); // Handle error case
        }
    }
}