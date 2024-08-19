package com.utez.edu.almacen.controllers.user;

import com.google.gson.Gson;
import com.utez.edu.almacen.models.user.BeanLoggedUser;
import com.utez.edu.almacen.models.user.DaoLoggedUser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ServletGetLoggedUser", value = "/ServletGetLoggedUser")
public class ServletGetLoggedUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        long id = Long.parseLong(idParam);

        DaoLoggedUser daoLoggedUser = new DaoLoggedUser();
        BeanLoggedUser loggedUser = daoLoggedUser.findUserById(id);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (loggedUser != null) {
            Gson gson = new Gson();
            String json = gson.toJson(loggedUser);
            response.getWriter().write(json);
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
