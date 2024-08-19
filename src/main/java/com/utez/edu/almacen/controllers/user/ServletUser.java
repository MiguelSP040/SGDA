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
        urlPatterns = { // urlPatterns funge como directorio para relacionar funciones con vistas
                "/user/list-users", // GET
                "/user/search", // GET
                "/user/save", // POST
                "/user/update", // POST
                "/user/delete" // POST
        })
public class ServletUser extends HttpServlet {
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
                List<BeanUser> users = new DaoUser().listAll();
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
            case "/user/save":
                name = request.getParameter("name");
                surname = request.getParameter("surname");
                lastname = request.getParameter("lastname");
                phone = request.getParameter("phone");
                email = request.getParameter("email");
                password = request.getParameter("email");
                user = new BeanUser(0L, name, surname, lastname, phone, email, password, "Almacenista", true);
                boolean result = new DaoUser().save(user);
                if (result) {
                    redirect = "/user/list-users?result=" + true + "&message=" +
                            URLEncoder.encode("¡Usuario registrado con éxito!", StandardCharsets.UTF_8);
                } else {
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

                String currentUserEmail = (String) request.getSession().getAttribute("user");
                DaoUser daoUser = new DaoUser();
                BeanUser currentUser = daoUser.getUserByEmail(currentUserEmail);

                BeanUser user = new BeanUser(Long.parseLong(id), name, surname, lastname, phone, email, password, role, status);

                // Verifica si el usuario está tratando de actualizar su propio correo electrónico
                if (currentUser != null && currentUser.getId().equals(Long.parseLong(id))) {
                    if (!currentUser.getEmail().equals(email)) {
                        redirect = "/user/list-users?result=" + false + "&message=" +
                                URLEncoder.encode("¡ERROR! No puedes cambiar tu propio correo electrónico desde aquí, para ello dirígete a tu perfil.", StandardCharsets.UTF_8);
                        break;
                    }
                }
                if (daoUser.update(user)) {
                    redirect = "/user/list-users?result=" + true + "&message=" +
                            URLEncoder.encode("¡Modificación al usuario realizada con éxito!", StandardCharsets.UTF_8);
                } else {
                    redirect = "/user/list-users?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al modificar este usuario!", StandardCharsets.UTF_8);
                }
                break;

            case "/user/delete":
                id = request.getParameter("id");
                 currentUserEmail = (String) request.getSession().getAttribute("user");
                 daoUser = new DaoUser();
                 currentUser = daoUser.getUserByEmail(currentUserEmail); // Obtén el usuario logueado por su email
                if (currentUser != null && currentUser.getId().equals(Long.parseLong(id))) {
                    redirect = "/user/list-users?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR NO puedes desactivarte a ti mismo!", StandardCharsets.UTF_8);
                } else {
                    if (daoUser.changeStatus(Long.parseLong(id))) {
                        redirect = "/user/list-users?result=" + true + "&message=" +
                                URLEncoder.encode("¡Estado del usuario cambiado con éxito!", StandardCharsets.UTF_8);
                    } else {
                        redirect = "/user/list-users?result=" + false + "&message=" +
                                URLEncoder.encode("¡ERROR al cambiar el estado!", StandardCharsets.UTF_8);
                    }
                }
                break;

            default:
                System.out.println(action);
                break;
        }
        response.sendRedirect(request.getContextPath() + redirect);
    }
}
