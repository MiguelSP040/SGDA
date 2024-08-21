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
import java.io.PrintWriter;

@WebServlet(name = "ServletGetMetric", value = "/ServletGetMetric")
public class ServletGetMetric extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        Long id = Long.parseLong(request.getParameter("id_product"));
        BeanMetric metric = new DaoMetric().showMetric(id);

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        if (metric != null) {
            out.println(metric.getName());
        } else {
            out.println("No hay métricas disponibles.");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}