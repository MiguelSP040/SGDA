package com.utez.edu.almacen.controllers;

import com.utez.edu.almacen.models.DaoLogin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean flag = (boolean) request.getAttribute("flag");
        request.setAttribute("errorMessage", flag);
        request.getRequestDispatcher(flag ? "/views/product/checkStock.jsp" : "/index.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        DaoLogin daoLogin = new DaoLogin();
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        if (daoLogin.findUser(email,password)){
            if (request.getSession(false) == null) {
                request.getSession(true);
            }
            request.getSession(false).setAttribute("user",email);
            request.setAttribute("flag",true);
        }else{
            request.setAttribute("flag",false);
        }

        doGet(request,response);
    }
}