package com.utez.edu.almacen.controllers.metric;

import com.google.gson.Gson;
import com.utez.edu.almacen.models.metric.BeanMetric;
import com.utez.edu.almacen.models.metric.DaoMetric;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ServletGetMetric", value = "/ServletGetMetric")
public class ServletGetMetric extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        Long id = Long.parseLong(request.getParameter("id"));
        BeanMetric metric = new DaoMetric().listOne(id);
        String json = new Gson().toJson(metric);
        response.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}