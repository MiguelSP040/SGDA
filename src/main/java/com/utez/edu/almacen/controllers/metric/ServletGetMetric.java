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

        String idParam = request.getParameter("id");

        // Validar que el parámetro no sea nulo o vacío
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "El ID es requerido.");
            return;
        }

        Long id;
        try {
            id = Long.parseLong(idParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "El ID no es válido.");
            return;
        }

        BeanMetric metric = new DaoMetric().listOne(id);

        // Validar si el objeto metric es nulo
        if (metric == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Métrica no encontrada.");
            return;
        }

        String json = new Gson().toJson(metric);
        response.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Aquí puedes implementar la lógica para manejar las solicitudes POST si es necesario
    }
}
