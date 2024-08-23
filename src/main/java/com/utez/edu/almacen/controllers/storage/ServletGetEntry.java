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
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "ServletGetEntry", value = "/ServletGetEntry")
public class ServletGetEntry extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        List<BeanEntry> entry = new DaoEntry().listOne(id);
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            int count = 1;
            for (BeanEntry entrada : entry) {
                out.println("<tr>");
                out.println("<th scope='row'>" + count + "</th>");
                out.println("<td><input class='form-control w-100' value='" + entrada.getProductName() + "' readonly></td>");
                out.println("<td><input class='form-control w-100' value='" + entrada.getMetricName() + "' readonly></td>");
                out.println("<td><input class='form-control' type='number' value='" + entrada.getUnitPrice() + "' readonly></td>");
                out.println("<td><input class='form-control' type='number' value='" + entrada.getQuantity() + "' readonly></td>");
                out.println("<td><input class='form-control' type='number' value='" + entrada.getTotalPrice() + "' readonly></td>");
                out.println("</tr>");
                count++;
            }
        }
    }
}
