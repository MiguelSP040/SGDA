package com.utez.edu.almacen.controllers.provider;

import com.google.gson.Gson;
import com.utez.edu.almacen.models.provider.BeanProvider;
import com.utez.edu.almacen.models.provider.DaoProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ServletGetProvider", value = "/ServletGetProvider")
public class ServletGetProvider extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        Long id = Long.parseLong(request.getParameter("id"));
        BeanProvider provider = new DaoProvider().listOne(id);
        String json = new Gson().toJson(provider);
        response.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}