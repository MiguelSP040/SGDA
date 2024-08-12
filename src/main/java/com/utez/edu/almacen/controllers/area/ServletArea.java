package com.utez.edu.almacen.controllers.area;

import com.utez.edu.almacen.models.area.BeanArea;
import com.utez.edu.almacen.models.area.DaoArea;
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

@WebServlet(name = "ServletArea", urlPatterns = {
        "/area/list-areas",
        "/area/delete",
        "/area/save",
        "/area/update",
        "/area/search"
})

public class ServletArea extends HttpServlet {
    private String action;
    private String redirect = "/area/list-areas";
    private BeanArea area;
    private String id, name, description, shortName;
    private boolean status;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        action = request.getServletPath();
        switch (action){
            case "/area/list-areas":
                List<BeanArea> areas = new DaoArea().listAll();
                request.setAttribute("areas", areas);
                redirect = "/views/area/destinationAreas.jsp";
                break;
            case "/area/register":
                redirect = "";
                break;
            case "/area/update-view":
                id = request.getParameter("id");
                area = new DaoArea().listOne((id != null) ? (Long.parseLong(id)): (0));
                if (area != null){
                    request.setAttribute("area", area);
                    redirect = "";
                } else{
                    redirect = "/area/list-areas?result=" + false + "&message="
                            + URLEncoder.encode("¡Error! Acción no realizada correctamente",
                            StandardCharsets.UTF_8);
                }
                break;
            case "/area/search":
                shortName = request.getParameter("shortName");
                name = request.getParameter("name");
                description = request.getParameter("description");
                String status2 = request.getParameter("status");
                request.setAttribute("searchShortName", shortName);
                request.setAttribute("searchName", name);
                areas = new DaoArea().search(name, shortName, status2);
                request.setAttribute("areas", areas);
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
            case "/area/delete":
                id = request.getParameter("id");
                // Cambiar el estado
                if (new DaoArea().changeStatus(Long.parseLong(id))) {
                    redirect = "/area/list-areas?result=" + true + "&message=" +
                            URLEncoder.encode("¡Estado del área cambiado con éxito!", StandardCharsets.UTF_8);
                } else {
                    redirect = "/area/list-areas?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al cambiar el estado!", StandardCharsets.UTF_8);
                }
                break;
            case "/area/save":
                name = request.getParameter("name");
                description = request.getParameter("description");
                shortName = request.getParameter("shortName");
                area = new BeanArea(0L, name, description, shortName, true);
                boolean result = new DaoArea().save(area);
                if (result) {
                    redirect = "/area/list-areas?result=" + true + "&message=" +
                            URLEncoder.encode("¡Área registrada con éxito!", StandardCharsets.UTF_8);
                }else {
                    redirect = "/area/list-areas?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al crear el registro de esta área!", StandardCharsets.UTF_8);
                }
                break;
            case "/area/update":
                id = request.getParameter("id");
                name = request.getParameter("name");
                description = request.getParameter("description");
                shortName = request.getParameter("shortName");
                status = Boolean.parseBoolean(request.getParameter("status"));
                area = new BeanArea(Long.parseLong(id), name, description, shortName, status);
                if (new DaoArea().update(area)){
                    redirect = "/area/list-areas?result=" + true + "&message=" +
                            URLEncoder.encode("¡Modificación al área realizada con éxito!", StandardCharsets.UTF_8);
                }else {
                    redirect = "/area/list-areas?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al modificar esta área!", StandardCharsets.UTF_8);
                }
                break;
        }
        response.sendRedirect(request.getContextPath() + redirect);
    }
}