package com.utez.edu.almacen.controllers.provider;

import com.utez.edu.almacen.models.provider.BeanProvider;
import com.utez.edu.almacen.models.provider.DaoProvider;
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
    private String id, name, socialCase, rfc, postCode, address, phone, email, contactName, contactPhone, contactEmail;
    private boolean status;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        action = request.getServletPath();
        switch (action){
            case "/provider/list-providers":
                List<BeanProvider> providers = new DaoProvider().listAll();
                request.setAttribute("providers", providers);
                redirect = "/views/provider/checkSupplier.jsp";
                break;
            case "/provider/update-view":
                id = request.getParameter("id");
                provider = new DaoProvider().listOne((id != null) ? (Long.parseLong(id)) : (0));
                if (provider != null){
                    request.setAttribute("provider", provider);
                    redirect = "";
                } else{
                    redirect = "/provider/list-providers?result=" + false + "&message="
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
                id = request.getParameter("id");
                // Cambiar el estado
                if (new DaoProvider().changeStatus(Long.parseLong(id))) {
                    redirect = "/provider/list-providers?result=" + true + "&message=" +
                            URLEncoder.encode("¡Estado del proveedor cambiado con éxito!", StandardCharsets.UTF_8);
                } else {
                    redirect = "/provider/list-providers?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al cambiar el estado!", StandardCharsets.UTF_8);
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
                provider = new BeanProvider(0L, name, socialCase, rfc, postCode, address, phone, email, contactName, contactPhone, contactEmail, true);
                boolean result = new DaoProvider().save(provider);
                if (result) {
                    redirect = "/provider/list-providers?result=" + true + "&message=" +
                            URLEncoder.encode("¡Proveedor registrado con éxito!", StandardCharsets.UTF_8);
                }else {
                    redirect = "/provider/list-providers?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al crear el registro de este proveedor!", StandardCharsets.UTF_8);
                }
                break;
            case "/provider/update":
                id = request.getParameter("id");
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
                status = Boolean.parseBoolean(request.getParameter("status"));
                provider = new BeanProvider(Long.parseLong(id), name, socialCase, rfc, postCode, address, phone, email, contactName, contactPhone, contactEmail, status);
                if (new DaoProvider().update(provider)){
                    redirect = "/provider/list-providers?result=" + true + "&message=" +
                            URLEncoder.encode("¡Modificación al proveedor realizada con éxito!", StandardCharsets.UTF_8);
                }else {
                    redirect = "/provider/list-providers?result= " + false + "&message=" +
                            URLEncoder.encode("¡ERROR al modificar este proveedor!", StandardCharsets.UTF_8);
                }
                break;
        }
        response.sendRedirect(request.getContextPath() + redirect);
    }
}