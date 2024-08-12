package com.utez.edu.almacen.controllers.area;

import com.google.gson.Gson;
import com.utez.edu.almacen.models.area.BeanArea;
import com.utez.edu.almacen.models.area.DaoArea;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ServletGetArea", value = "/ServletGetArea")
public class ServletGetArea extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        Long id = Long.parseLong(request.getParameter("id"));
        BeanArea area = new DaoArea().listOne(id);
        String json = new Gson().toJson(area);
        response.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}