
package com.utez.edu.almacen.controllers.storage;

import com.utez.edu.almacen.models.storage.BeanEntry;
import com.utez.edu.almacen.models.storage.BeanExit;
import com.utez.edu.almacen.models.storage.DaoEntry;
import com.utez.edu.almacen.models.storage.DaoExit;
import com.utez.edu.almacen.models.user.BeanLoggedUser;
import com.utez.edu.almacen.models.user.DaoLoggedUser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet(name = "ServletExit", urlPatterns = {
        "/storage/list-Exits",
        "/storage/save-Exit"
})
public class ServletExit extends HttpServlet {
    private String action;
    private String redirect = "/storage/list-Exits";
    private BeanLoggedUser loggedUser;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        action = request.getServletPath();
        switch (action) {
            case "/storage/list-Exits":

                String currentUserEmail = (String) request.getSession().getAttribute("user");

                if (currentUserEmail != null) {
                    loggedUser = new DaoLoggedUser().findUserByEmail(currentUserEmail);

                    if (loggedUser != null) {
                        request.setAttribute("user", loggedUser);
                    } else {
                        request.setAttribute("errorMessage", "Usuario no encontrado.");
                    }
                } else {
                    request.setAttribute("errorMessage", "Usuario no autenticado.");
                }

                List<BeanExit> salidas = new DaoExit().listAll();
                request.setAttribute("exits2", salidas);
                redirect = "/views/storage/outbounds.jsp";
                break;
            default:
                System.out.println(action);
        }
        request.getRequestDispatcher(redirect).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        action = request.getServletPath();
        switch (action) {
            case "/storage/save-Exit":
                BeanExit exit = new BeanExit(
                        request.getParameter("folioNumber"),
                        request.getParameter("invoiceNumber"),
                        Integer.parseInt(request.getParameter("id_user")),
                        Integer.parseInt(request.getParameter("id_area")),
                        request.getParameter("buyerName"),
                        Integer.parseInt(request.getParameter("id_product")),
                        Integer.parseInt(request.getParameter("quantity")),
                        Double.parseDouble(request.getParameter("unitPrice")));

                Boolean message = new DaoExit().registerExit(exit);
                response.getWriter().println(message);
                if (message) {
                    redirect = "/storage/list-Exits?result=" + true + "&message=" +
                            URLEncoder.encode("¡Salida registrada con éxito!", StandardCharsets.UTF_8);
                } else {
                    redirect = "/storage/list-Exits?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al registrar la Salida!", StandardCharsets.UTF_8);
                }
                break;
            default:
                System.out.println(action);
                break;
        }
        response.sendRedirect(request.getContextPath() + redirect);
    }
}
