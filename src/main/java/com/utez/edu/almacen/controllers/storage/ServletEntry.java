
package com.utez.edu.almacen.controllers.storage;

import com.utez.edu.almacen.models.storage.BeanEntry;
import com.utez.edu.almacen.models.storage.DaoEntry;
import com.utez.edu.almacen.models.user.BeanLoggedUser;
import com.utez.edu.almacen.models.user.DaoLoggedUser;
import com.utez.edu.almacen.models.user.DaoUser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

import static com.mysql.cj.conf.PropertyKey.logger;

@WebServlet(name = "ServletEntry", urlPatterns = {
        "/storage/list-Entries",
        "/storage/save-Entry",
        "/storage/search-Entry"
})
public class ServletEntry extends HttpServlet {
    private String action;
    private String redirect = "/storage/list-Entries";
    private BeanLoggedUser loggedUser;
    private static final Logger logger = Logger.getLogger(ServletEntry.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        action = request.getServletPath();
        switch (action) {
            case "/storage/list-Entries":

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

                List<BeanEntry> entradas = new DaoEntry().listAll();
                request.setAttribute("entries2", entradas);
                redirect = "/views/storage/entrys.jsp";
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
            case "/storage/save-Entry":
                BeanEntry entry = new BeanEntry(
                        request.getParameter("folioNumber"),
                        request.getParameter("invoiceNumber"),
                        Integer.parseInt(request.getParameter("id_user")),
                        Integer.parseInt(request.getParameter("id_provider")),
                        Integer.parseInt(request.getParameter("idProduct")),
                        Integer.parseInt(request.getParameter("quantity")),
                        Double.parseDouble(request.getParameter("unitPrice")));

                Boolean message = new DaoEntry().registerEntry(entry);
                response.getWriter().println(message);
                if (message) {
                    redirect = "/storage/list-Entries?result=" + true + "&message=" +
                            URLEncoder.encode("¡Entrada registrada con éxito!", StandardCharsets.UTF_8);
                } else {
                    redirect = "/storage/list-Entries?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al registrar la Entrada!", StandardCharsets.UTF_8);
                }
                break;
            default:
                System.out.println(action);
                break;
        }
        response.sendRedirect(request.getContextPath() + redirect);
    }
}
