package com.utez.edu.almacen.controllers.metric;

import com.utez.edu.almacen.models.metric.BeanMetric;
import com.utez.edu.almacen.models.metric.DaoMetric;
import com.utez.edu.almacen.models.user.DaoUser;
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
        "/metric/update"
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
            case "/metric/register":
                redirect = "";
                break;
            case "/metric/update-view":
                id = request.getParameter("id");
                metric = new DaoMetric().listOne((id != null) ? (Long.parseLong(id)) : (0));
                if (metric != null){
                    request.setAttribute("metric", metric);
                    redirect = "";
                } else{
                    redirect = "/metric/list-metrics?result=" + false + "&message="
                            + URLEncoder.encode("¡Error! Acción no realizada correctamente",
                            StandardCharsets.UTF_8);
                }
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
                            URLEncoder.encode("¡Estado cambiado con éxito!", StandardCharsets.UTF_8);
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
                    redirect = "/metric/list-metrics?result=" + true + "&message="
                            + URLEncoder.encode("Éxito! Usuario registrado correctamente",
                            StandardCharsets.UTF_8);
                }else {
                    redirect = "/metric/list-metrics?result=" + false + "&message="
                            + URLEncoder.encode("¡Error! Acción no realizada correctamente",
                            StandardCharsets.UTF_8);
                }
                break;
            case "/metric/update":
                id = request.getParameter("id");
                name = request.getParameter("name");
                shortName = request.getParameter("shortName");
                status = Boolean.parseBoolean(request.getParameter("status"));
                metric = new BeanMetric(Long.parseLong(id), name, shortName, status);
                if (new DaoMetric().update(metric)){
                    redirect = "/metric/list-metrics?result=" + true + "&message="
                            + URLEncoder.encode("Éxito! Usuario actualizado correctamente",
                            StandardCharsets.UTF_8);
                }else {
                    redirect = "/metric/list-metrics?result=" + false + "&message="
                            + URLEncoder.encode("¡Error! Acción no realizada correctamente",
                            StandardCharsets.UTF_8);
                }
                break;
        }
        response.sendRedirect(request.getContextPath() + redirect);
    }
}