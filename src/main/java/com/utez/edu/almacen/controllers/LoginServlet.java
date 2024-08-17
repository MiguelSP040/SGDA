package com.utez.edu.almacen.controllers;

import com.utez.edu.almacen.models.DaoLogin;
import com.utez.edu.almacen.models.LoginResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        DaoLogin daoLogin = new DaoLogin();
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        LoginResult result = daoLogin.findUser(email, password);

        PrintWriter out = response.getWriter();

        if (result.isSuccess()) {
            if (request.getSession(false) == null) {
                request.getSession(true);
            }
            request.getSession(false).setAttribute("user", email);
            // Envía una respuesta JSON con la URL de redirección
            out.write("{\"success\": true, \"redirectUrl\": \"/views/product/checkStock.jsp\"}");
        } else {
            out.write("{\"success\": false, \"errorMessage\": \"" + result.getMessage() + "\"}");
        }

        out.flush();
        out.close();
    }
}

