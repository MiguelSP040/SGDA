package com.utez.edu.almacen.controllers.storage;

import com.google.gson.Gson;
import com.utez.edu.almacen.models.storage.BeanEntry;
import com.utez.edu.almacen.models.storage.BeanExit;
import com.utez.edu.almacen.models.storage.DaoEntry;
import com.utez.edu.almacen.models.storage.DaoExit;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "ServletGetExit", value = "/ServletGetExit")
public class ServletGetExit extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        List<BeanExit> exit = new DaoExit().listOne(id);
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            int count = 1;
            for (BeanExit salida : exit) {
                out.println("<tr>");
                out.println("<th scope='row'>" + count + "</th>");
                out.println("<td><input class='form-control w-100' value='" + salida.getProductName() + "' readonly disabled></td>");
                out.println("<td><input class='form-control w-100' value='" + salida.getMetricName() + "' readonly disabled></td>");
                out.println("<td><input class='form-control' type='number' value='" + salida.getUnitPrice() + "' readonly disabled></td>");
                out.println("<td><input class='form-control' type='number' value='" + salida.getQuantity() + "' readonly disabled></td>");
                out.println("<td><input class='form-control' type='number' value='" + salida.getTotalPrice() + "' readonly disabled></td>");
                out.println("</tr>");
                count++;
            }
        }
    }
}
