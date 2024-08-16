package com.utez.edu.almacen.controllers.product;

import com.google.gson.Gson;
import com.utez.edu.almacen.models.product.BeanProduct;
import com.utez.edu.almacen.models.product.DaoProduct;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ServletGetProduct", value = "/ServletGetProduct")
public class ServletGetProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

            long id = Long.parseLong(request.getParameter("id"));
            BeanProduct product = new DaoProduct().listOne(id);
            String json = new Gson().toJson(product);

            response.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}