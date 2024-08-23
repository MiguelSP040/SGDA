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

@WebServlet(name = "ServletPutMetric", value = "/ServletPutMetric")
public class ServletPutMetric extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        String idProductParam = request.getParameter("id_product");

        if (idProductParam == null || idProductParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "El ID del producto es requerido.");
            return;
        }

        Long idProduct;
        try {
            idProduct = Long.parseLong(idProductParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "El ID del producto no es válido.");
            return;
        }

        BeanMetric metric = new DaoMetric().listOne(idProduct);

        if (metric != null) {
            String json = new Gson().toJson(metric);
            response.getWriter().write(json);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Métrica no encontrada.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // No se utiliza en este caso.
    }
}
