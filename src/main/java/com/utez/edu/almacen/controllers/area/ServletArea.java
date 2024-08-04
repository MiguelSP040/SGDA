package com.utez.edu.almacen.controllers.area;

import com.utez.edu.almacen.models.area.BeanArea;
import com.utez.edu.almacen.models.area.DaoArea;
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

})
public class ServletArea extends HttpServlet {
    private String action;
    private String redirect = "/area/list-areas";
    private BeanArea area;
    private String id_area, name, description, shortName, status;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        action = request.getServletPath();
        switch (action){
            case "/area/list-areas":
                List<BeanArea> areas = new DaoArea().listAll();
                request.setAttribute("areas", areas);
                redirect = "";
                break;
            case "/area/register":
                redirect = "";
                break;
            case "/area/update-view":
                id_area = request.getParameter("id");
                area = new DaoArea().listOne((id_area != null) ? (Long.parseLong(id_area)): (0));
                if (area != null){
                    request.setAttribute("area", area);
                    redirect = "";
                } else{
                    redirect = "/area/list-areas?result= " + false + "&message="
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
            case "/area/delete":
                id_area = request.getParameter("id");
                if (new DaoArea().delete(Long.parseLong(id_area))){
                    redirect = "/area/list-areas?result= " + true + "&message="
                            + URLEncoder.encode("¡Éxito! Usuario eliminado correctamente",
                            StandardCharsets.UTF_8);
                } else {
                    redirect = "/area/list-areas?result= " + false + "&message="
                            + URLEncoder.encode("¡Error! Acción no realizada correctamente",
                            StandardCharsets.UTF_8);
                }
                break;
            case "/area/save":
                name = request.getParameter("name");
                description = request.getParameter("description");
                shortName = request.getParameter("shortName");
                area = new BeanArea(0L, name, description, shortName, "active");
                boolean result = new DaoArea().save(area);
                if (result) {
                    redirect = "/area/list-areas?result=" + true + "&message="
                            + URLEncoder.encode("Éxito! Usuario registrado correctamente",
                            StandardCharsets.UTF_8);
                }else {
                    redirect = "/area/list-areas?result= " + false + "&message="
                            + URLEncoder.encode("¡Error! Acción no realizada correctamente",
                            StandardCharsets.UTF_8);
                }
                break;
            case "/area/update":
                id_area = request.getParameter("id");
                name = request.getParameter("name");
                description = request.getParameter("description");
                shortName = request.getParameter("shortName");
                status = request.getParameter("status");
                area = new BeanArea(Long.parseLong(id_area), name, description, shortName, status);
                if (new DaoArea().update(area)){
                    redirect = "/area/list-areas?result=" + true + "&message="
                            + URLEncoder.encode("Éxito! Usuario actualizado correctamente",
                            StandardCharsets.UTF_8);
                }else {
                    redirect = "/area/list-areas?result= " + false + "&message="
                            + URLEncoder.encode("¡Error! Acción no realizada correctamente",
                            StandardCharsets.UTF_8);
                }
                break;
        }
        response.sendRedirect(request.getContextPath() + redirect);
    }
}