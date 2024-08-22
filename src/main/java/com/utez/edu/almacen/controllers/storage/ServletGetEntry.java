package com.utez.edu.almacen.controllers.storage;

import com.google.gson.Gson;
import com.utez.edu.almacen.models.storage.BeanEntry;
import com.utez.edu.almacen.models.storage.DaoEntry;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ServletGetEntry", value = "/ServletGetEntry")
public class ServletGetEntry extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        int id = Integer.parseInt(request.getParameter("id"));
        BeanEntry entry = new DaoEntry().listOne(id);
        System.out.println("BeanEntry: " + entry); // Verifica aquí
        String json = new Gson().toJson(entry);
        response.getWriter().write(json);
    }
}
