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
                "/user/register", //get
                "/user/update-view", //get
                "/user/update", //post
                "/user/delete", //post
                "/user/search", //get
                "/user/save" //post
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
                List<BeanUser> users = new DaoUser().listAll();
                request.setAttribute("users", users);
                redirect = "/views/user/userQuery.jsp";
                break;

            case "/user/register":
                redirect = "/views/user/userRegistration.jsp";
                break;

            case "/user/update-view":
                id = request.getParameter("id");
                user = new DaoUser().listOne((id != null) ? (Long.parseLong(id)) : (0));
                if (user != null){
                    request.setAttribute("user", user);
                    redirect = "/user/list-users";
                }else {
                    redirect = "/user/list-users?result= " + false + "&message=" +
                            URLEncoder.encode("¡ERROR!", StandardCharsets.UTF_8);
                }
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
                        user = new BeanUser(Long.parseLong(id), name, surname, lastname, phone, email,
                                password, role, status);
                        if (new DaoUser().update(user)){
                            redirect = "/user/list-users?result= " + true + "&message=" +
                                    URLEncoder.encode("¡Modificación al usuario realizada con éxito!", StandardCharsets.UTF_8);
                        }else {
                            redirect = "/user/list-users?result= " + false + "&message=" +
                                    URLEncoder.encode("¡ERROR al modificar este usuario!", StandardCharsets.UTF_8);
                        }
                        break;
        }
        response.sendRedirect(request.getContextPath() + redirect);
    }
}