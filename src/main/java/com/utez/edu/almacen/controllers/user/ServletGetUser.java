package com.utez.edu.almacen.controllers.user;


import com.google.gson.Gson;
import com.utez.edu.almacen.models.user.BeanUser;
import com.utez.edu.almacen.models.user.DaoUser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ServletGetUser", value = "/ServletGetUser")
public class ServletGetUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        if (request.getSession(false) != null && request.getSession(false).getAttribute("user")!= null){
            long id = Long.parseLong(request.getParameter("id"));
            BeanUser user = new DaoUser().listOne(id);
            String json = new Gson().toJson(user);

            response.getWriter().write(json);
        }else {
            String forbidden = "{" +
                    "\"error\":403," +
                    "\"message\":\"Acceso no autorizado\"" +
                    "}";
            response.getWriter().write(forbidden);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}