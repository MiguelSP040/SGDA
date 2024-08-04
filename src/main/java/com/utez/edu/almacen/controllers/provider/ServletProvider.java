package com.utez.edu.almacen.controllers.provider;

import com.utez.edu.almacen.models.provider.BeanProvider;
import com.utez.edu.almacen.models.provider.DaoProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet(name = "ServletProvider", urlPatterns = {
        "/provider/list-providers",
        "/provider/register",
        "/provider/update-view",
        "/provider/delete",
        "/provider/save",
        "/provider/update"
})
public class ServletProvider extends HttpServlet {
    private String action;
    private String redirect = "/provider/list-providers";
    private BeanProvider provider;
    private String id_provider, name, socialCase, rfc, postCode, address, phone, email, contactName, contactPhone, contactEmail, status;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        action = request.getServletPath();
        switch (action){
            case "/provider/list-providers":
                List<BeanProvider> providers = new DaoProvider().listAll();
                request.setAttribute("providers", providers);
                redirect = "";
                break;
            case "/provider/register":
                redirect = "";
                break;
            case "/provider/update-view":
                id_provider = request.getParameter("id");
                provider = new DaoProvider().listOne((id_provider != null) ? (Long.parseLong(id_provider)) : (0));
                if (provider != null){
                    request.setAttribute("provider", provider);
                    redirect = "";
                } else{
                    redirect = "/provider/list-providers?result= " + false + "&message="
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
            case "/provider/delete":
                id_provider = request.getParameter("id");
                if (new DaoProvider().delete(Long.parseLong(id_provider))){
                    redirect = "/provider/list-providers?result= " + true + "&message="
                            + URLEncoder.encode("¡Éxito! Usuario eliminado correctamente",
                            StandardCharsets.UTF_8);
                } else {
                    redirect = "/provider/list-providers?result= " + false + "&message="
                            + URLEncoder.encode("¡Error! Acción no realizada correctamente",
                            StandardCharsets.UTF_8);
                }
                break;
            case "/provider/save":
                name = request.getParameter("name");
                socialCase = request.getParameter("socialCase");
                rfc = request.getParameter("rfc");
                postCode = request.getParameter("postCode");
                address = request.getParameter("address");
                phone = request.getParameter("phone");
                email = request.getParameter("email");
                contactName = request.getParameter("contactName");
                contactPhone = request.getParameter("contactPhone");
                contactEmail = request.getParameter("contactEmail");
                provider = new BeanProvider(0L, name, socialCase, rfc, postCode, address, phone, email, contactName, contactPhone, contactEmail, "active");
                boolean result = new DaoProvider().save(provider);
                if (result) {
                    redirect = "/provider/list-providers?result=" + true + "&message="
                            + URLEncoder.encode("Éxito! Usuario registrado correctamente",
                            StandardCharsets.UTF_8);
                }else {
                    redirect = "/provider/list-providers?result= " + false + "&message="
                            + URLEncoder.encode("¡Error! Acción no realizada correctamente",
                            StandardCharsets.UTF_8);
                }
                break;
            case "/provider/update":
                id_provider = request.getParameter("id");
                name = request.getParameter("name");
                socialCase = request.getParameter("socialCase");
                rfc = request.getParameter("rfc");
                postCode = request.getParameter("postCode");
                address = request.getParameter("address");
                phone = request.getParameter("phone");
                email = request.getParameter("email");
                contactName = request.getParameter("contactName");
                contactPhone = request.getParameter("contactPhone");
                contactEmail = request.getParameter("contactEmail");
                status = request.getParameter("status");
                provider = new BeanProvider(Long.parseLong(id_provider), name, socialCase, rfc, postCode, address, phone, email, contactName, contactPhone, contactEmail, status);
                if (new DaoProvider().update(provider)){
                    redirect = "/provider/list-providers?result=" + true + "&message="
                            + URLEncoder.encode("Éxito! Usuario actualizado correctamente",
                            StandardCharsets.UTF_8);
                }else {
                    redirect = "/provider/list-providers?result= " + false + "&message="
                            + URLEncoder.encode("¡Error! Acción no realizada correctamente",
                            StandardCharsets.UTF_8);
                }
                break;
        }
        response.sendRedirect(request.getContextPath() + redirect);
    }
}