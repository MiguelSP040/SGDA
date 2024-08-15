package com.utez.edu.almacen.controllers.metric;

import com.utez.edu.almacen.models.metric.BeanMetric;
import com.utez.edu.almacen.models.metric.DaoMetric;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet(name = "ServletMetric", urlPatterns = {
        "/metric/list-metrics",
        "/metric/delete",
        "/metric/save",
        "/metric/update",
        "/metric/search"
})
public class ServletMetric extends HttpServlet {
    private String action;
    private String redirect = "/metric/list-metrics";
    private BeanMetric metric;
    private String id, name, shortName;
    private boolean status;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        action = request.getServletPath();
        switch (action){
            case "/metric/list-metrics":
                List<BeanMetric> metrics = new DaoMetric().listAll();
                request.setAttribute("metrics", metrics);
                redirect = "/views/metric/metrics.jsp";
                break;
            case "/metric/search":
                shortName = request.getParameter("shortName");
                name = request.getParameter("name");
                String status2 = request.getParameter("status");
                request.setAttribute("searchShortName", shortName);
                request.setAttribute("searchName", name);
                metrics = new DaoMetric().search(name, shortName, status2);
                request.setAttribute("metrics", metrics);
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
        switch (action){
            case "/metric/delete":
                id = request.getParameter("id");
                // Cambiar el estado
                if (new DaoMetric().changeStatus(Long.parseLong(id))) {
                    redirect = "/metric/list-metrics?result=" + true + "&message=" +
                            URLEncoder.encode("¡Estado de la métrica cambiado con éxito!", StandardCharsets.UTF_8);
                } else {
                    redirect = "/metric/list-metrics?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al cambiar el estado!", StandardCharsets.UTF_8);
                }
                break;
            case "/metric/save":
                name = request.getParameter("name");
                shortName = request.getParameter("shortName");
                metric = new BeanMetric(0L, name, shortName, true);
                boolean result = new DaoMetric().save(metric);
                if (result) {
                    redirect = "/metric/list-metrics?result=" + true + "&message=" +
                            URLEncoder.encode("¡Métrica registrada con éxito!", StandardCharsets.UTF_8);
                }else {
                    redirect = "/metric/list-metrics?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al crear el registro de esta métrica!", StandardCharsets.UTF_8);
                }
                break;
            case "/metric/update":
                id = request.getParameter("id");
                name = request.getParameter("name");
                shortName = request.getParameter("shortName");
                status = Boolean.parseBoolean(request.getParameter("status"));
                metric = new BeanMetric(Long.parseLong(id), name, shortName, true);
                if (new DaoMetric().update(metric)){
                    redirect = "/metric/list-metrics?result=" + true + "&message=" +
                            URLEncoder.encode("¡Modificación a la métrica realizada con éxito!", StandardCharsets.UTF_8);
                }else {
                    redirect = "/metric/list-metrics?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al modificar esta métrica!", StandardCharsets.UTF_8);
                }
                break;
        }
        response.sendRedirect(request.getContextPath() + redirect);
    }
}