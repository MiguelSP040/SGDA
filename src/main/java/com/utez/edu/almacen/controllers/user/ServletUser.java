package com.utez.edu.almacen.controllers.user;

import com.utez.edu.almacen.models.user.BeanUser;
import com.utez.edu.almacen.models.user.DaoUser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet(name = "ServletUser",
        urlPatterns = { //urlPatterns funge como directorio para relacionar funciones con vistas
                "/user/list-users", //get
                "/user/update", //post
                "/user/delete", //post
                "/user/search", //get
                "/user/save", //post
                "/user/find-logged-in-user", //get
                "/user/updatePassword", //post
                "/user/updateEmail" //post
        })
public class ServletUser extends HttpServlet {
    //Declaración de variables locales
    private String action;
    private String redirect = "/user/list-users";
    private BeanUser user;
    private String id, name, surname, lastname, phone, email, password, role;
    private boolean status;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        action = request.getServletPath();
        switch (action) {
            case "/user/list-users":
                String currentUserEmail = (String) request.getSession().getAttribute("user");
                List<BeanUser> users = new DaoUser().listAllExcept(currentUserEmail);
                request.setAttribute("users", users);
                redirect = "/views/user/userQuery.jsp";
            break;

            case "/user/search":
                name = request.getParameter("name");
                surname = request.getParameter("name");
                lastname = request.getParameter("name");
                role = request.getParameter("role");
                email = request.getParameter("email");
                String status2 = request.getParameter("status");
                request.setAttribute("searchName", name);
                request.setAttribute("searchEmail", email);
                users = new DaoUser().search(name, role, email, status2);
                request.setAttribute("users", users);
            break;

            case "/user/find-logged-in-user":
                email = request.getParameter("email");
                password = request.getParameter("password");
                user = new DaoUser().findLoggedInUser(email, password);
                if (user != null) {
                    request.setAttribute("id", user.getId());
                    request.setAttribute("name", user.getName());
                    request.setAttribute("surname", user.getSurname());
                    request.setAttribute("lastname", user.getLastname());
                    request.setAttribute("phone", user.getPhone());
                    request.setAttribute("email", user.getEmail());
                    request.setAttribute("password", user.getPassword());
                    request.setAttribute("role", user.getRole());
                    request.setAttribute("status", user.getStatus());
                }
                redirect = "/views/user/userProfile.jsp";
                break;

            default:
                System.out.println(action);
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
            case "/user/delete":
                id = request.getParameter("id");
                // Cambiar el estado
                if (new DaoUser().changeStatus(Long.parseLong(id))) {
                    redirect = "/user/list-users?result=" + true + "&message=" +
                            URLEncoder.encode("¡Estado del usuario cambiado con éxito!", StandardCharsets.UTF_8);
                } else {
                    redirect = "/user/list-users?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al cambiar el estado!", StandardCharsets.UTF_8);
                }
            break;

            case "/user/save":
                name = request.getParameter("name");
                surname = request.getParameter("surname");
                lastname = request.getParameter("lastname");
                phone = request.getParameter("phone");
                email = request.getParameter("email");
                password = request.getParameter("email");
                user = new BeanUser(0L, name, surname, lastname, phone, email, password, "Administrador", true);
                boolean result = new DaoUser().save(user);
                if (result){
                    redirect = "/user/list-users?result=" + true + "&message=" +
                            URLEncoder.encode("¡Usuario registrado con éxito!", StandardCharsets.UTF_8);
                }else {
                    redirect = "/user/list-users?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al crear el registro de este usuario!", StandardCharsets.UTF_8);
                }
            break;

            case "/user/update":
                id = request.getParameter("id");
                name = request.getParameter("name");
                surname = request.getParameter("surname");
                lastname = request.getParameter("lastname");
                phone = request.getParameter("phone");
                email = request.getParameter("email");
                password = request.getParameter("password");
                role = request.getParameter("role");
                status = Boolean.parseBoolean(request.getParameter("status"));
                user = new BeanUser(Long.parseLong(id), name, surname, lastname, phone, email, password, role, true);
                if (new DaoUser().update(user)){
                    redirect = "/user/list-users?result=" + true + "&message=" +
                            URLEncoder.encode("¡Modificación al usuario realizada con éxito!", StandardCharsets.UTF_8);
                }else {
                    redirect = "/user/list-users?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al modificar este usuario!", StandardCharsets.UTF_8);
                }
            break;

            case "/user/updateLogged":
                id = request.getParameter("id");
                name = request.getParameter("name");
                surname = request.getParameter("surname");
                lastname = request.getParameter("lastname");
                phone = request.getParameter("phone");
                status = Boolean.parseBoolean(request.getParameter("status"));
                user = new BeanUser(Long.parseLong(id), name, surname, lastname, phone, null, null, null, status);
                if (new DaoUser().updateLogged(Long.parseLong(id), name, surname, lastname, phone)) {
                    redirect = "/user/updateLogged?result=" + true + "&message=" +
                            URLEncoder.encode("¡Modificación a tu perfil realizada con éxito!", StandardCharsets.UTF_8);
                } else {
                    redirect = "/user/updateLogged?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al modificar tu perfil!", StandardCharsets.UTF_8);
                }
            break;

            case "/user/updatePassword":
                id = request.getParameter("id");
                password = request.getParameter("password");
                status = Boolean.parseBoolean(request.getParameter("status"));
                user = new BeanUser(Long.parseLong(id), null, null, null, null, null, password, null, status);
                if (new DaoUser().updatePassword(Long.parseLong(id), password)) {
                    redirect = "/user/list-users?result=" + true + "&message=" +
                            URLEncoder.encode("¡Modificación a tu contraseña realizada con éxito!", StandardCharsets.UTF_8);
                } else {
                    redirect = "/user/list-users?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al modificar tu contraseña!", StandardCharsets.UTF_8);
                }
                break;

            case "/user/updateEmail":
                id = request.getParameter("id");
                email = request.getParameter("email");
                status = Boolean.parseBoolean(request.getParameter("status"));
                user = new BeanUser(Long.parseLong(id), null, null, null, null, email, null, null, status);
                if (new DaoUser().updateEmail(Long.parseLong(id), email)) {
                    redirect = "/user/list-users?result=" + true + "&message=" +
                            URLEncoder.encode("¡Modificación a tu correo realizada con éxito!", StandardCharsets.UTF_8);
                } else {
                    redirect = "/user/list-users?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al modificar tu correo!", StandardCharsets.UTF_8);
                }
                break;
        }
        response.sendRedirect(request.getContextPath() + redirect);
    }
}