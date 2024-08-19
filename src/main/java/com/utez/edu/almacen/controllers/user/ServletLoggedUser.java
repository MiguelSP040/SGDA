package com.utez.edu.almacen.controllers.user;

import com.utez.edu.almacen.models.user.BeanLoggedUser;
import com.utez.edu.almacen.models.user.DaoLoggedUser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "ServletLoggedUser",
        urlPatterns = {
                "/user/profile-user",      // GET
                "/user/profile-update",    // POST
                "/user/password-update",   // POST
                "/user/email-update"       // POST
        })
public class ServletLoggedUser extends HttpServlet {
    private String action;
    private String redirect = "/user/profile-user";
    private BeanLoggedUser loggedUser;
    private String id, name, surname, lastname, phone,role, email, password;
    private boolean status;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        action = request.getServletPath();

        switch (action) { // Switch por si se agregan más opciones
            case "/user/profile-user":
                // Obtener el email del usuario
                String currentUserEmail = (String) request.getSession().getAttribute("user");

                if (currentUserEmail != null) {
                    loggedUser = new DaoLoggedUser().findUserByEmail(currentUserEmail); // Obtener el usuario desde la base de datos usando el email

                    if (loggedUser != null) { // Si el usuario existe, establece los atributos en el request
                        request.setAttribute("user", loggedUser);
                    } else {
                        request.setAttribute("errorMessage", "Usuario no encontrado.");
                    }
                } else {
                    request.setAttribute("errorMessage", "Usuario no autenticado.");
                }
                redirect = "/views/user/userProfile.jsp";
            break;

            default:
                System.out.println(action);
            break;
        }
        request.getRequestDispatcher(redirect).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        action = request.getServletPath();

        switch (action) {
            case "/user/profile-update":
                id = request.getParameter("id");
                name = request.getParameter("name");
                surname = request.getParameter("surname");
                lastname = request.getParameter("lastname");
                phone = request.getParameter("phone");
                email = request.getParameter("email");
                password = request.getParameter("password");
                role = request.getParameter("role");
                status = Boolean.parseBoolean(request.getParameter("status"));

                loggedUser = new BeanLoggedUser(Long.parseLong(id), name, surname, lastname, phone, null, null, null, true);

                boolean profileUpdated  = new DaoLoggedUser().updateProfile(loggedUser);
                redirect = "/user/profile-user?result=" + profileUpdated  + "&message=" + URLEncoder.encode(profileUpdated  ?
                        "¡Perfil actualizado con éxito!" : "¡ERROR al actualizar el perfil!", StandardCharsets.UTF_8);
            break;

            case "/user/password-update":
                id = request.getParameter("id");
                String currentPassword = request.getParameter("currentPassword"); // Contraseña actual proporcionada por la BD
                String newPassword = request.getParameter("password"); // Nueva contraseña proporcionada por el usuario

                BeanLoggedUser userFromDB = new DaoLoggedUser().findUserById(Long.parseLong(id));

                if (userFromDB != null) {
                    String storedPassword = userFromDB.getPassword();

                    // Verificar si la nueva contraseña coincide con la contraseña almacenada
                    if (storedPassword.equals(currentPassword)) {
                        boolean isPasswordUpdated = new DaoLoggedUser().updatePassword(Long.parseLong(id), newPassword);
                        redirect = "/LogoutServlet?result=" + isPasswordUpdated + "&message=" +
                                URLEncoder.encode(isPasswordUpdated ? "¡Contraseña actualizada con éxito!" : "¡ERROR al actualizar la contraseña!", StandardCharsets.UTF_8);

                    } else {
                        redirect = "/user/profile-user?result=false&message=" + URLEncoder.encode("La contraseña actual es incorrecta.", StandardCharsets.UTF_8);
                    }

                } else {
                    redirect = "/user/profile-user?result=false&message=" + URLEncoder.encode("Usuario no encontrado.", StandardCharsets.UTF_8);
                }
                break;

            case "/user/email-update":
                id = request.getParameter("id");
                name = request.getParameter("name");
                surname = request.getParameter("surname");
                lastname = request.getParameter("lastname");
                phone = request.getParameter("phone");
                email = request.getParameter("email");
                password = request.getParameter("password");
                role = request.getParameter("role");
                status = Boolean.parseBoolean(request.getParameter("status"));

                loggedUser = new BeanLoggedUser(Long.parseLong(id), name, surname, lastname, phone, email, password, role, true);

                boolean isEmailUpdated = new DaoLoggedUser().updateEmail(Long.parseLong(id), email);
                redirect = "/LogoutServlet?result=" + isEmailUpdated + "&message=" +
                        URLEncoder.encode(isEmailUpdated ? "¡Correo actualizado con éxito!" : "¡ERROR al actualizar el correo electrónico!", StandardCharsets.UTF_8);
            break;

            default:
                System.out.println(action);
                break;
        }
        response.sendRedirect(request.getContextPath() + redirect);
    }
}