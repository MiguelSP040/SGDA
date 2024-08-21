package com.utez.edu.almacen.controllers.storage;

import com.utez.edu.almacen.models.storage.BeanEntry;
import com.utez.edu.almacen.models.storage.BeanEntryProducts;
import com.utez.edu.almacen.models.storage.DaoEntry;
import com.utez.edu.almacen.models.user.BeanLoggedUser;
import com.utez.edu.almacen.models.user.DaoLoggedUser;
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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@WebServlet(name = "ServletEntry", urlPatterns = {
        "/storage/list-Entries", // GET
        "/storage/search", // GET
        "/storage/save-Entry", // POST
        "/storage/search-Entry", // POST
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

            case "/storage/search":
                // Implementar la búsqueda si es necesario
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
        String action = request.getServletPath();
        String redirect = "";

        switch (action) {
            case "/storage/save-Entry":
                BeanEntry entry = new BeanEntry();

                // Obtener la fecha actual del sistema en formato YYYY-MM-DD usando java.util.Date y SimpleDateFormat
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String formattedDate = sdf.format(new Date());

                entry.setChangeDate(formattedDate);
                entry.setInvoiceNumber(request.getParameter("invoiceNumber"));
                entry.setFolioNumber(request.getParameter("folioNumber"));
                entry.setIdUser(Integer.parseInt(request.getParameter("id_user")));
                entry.setIdProvider(Integer.parseInt(request.getParameter("id_provider")));

                // Obtener los productos de la entrada
                String[] idProducts = request.getParameterValues("idProduct");
                String[] metrics = request.getParameterValues("metric");
                String[] unitPrices = request.getParameterValues("unitPrice");
                String[] quantities = request.getParameterValues("quantity");
                String[] totalPrices = request.getParameterValues("total_price");

                List<BeanEntryProducts> products = new ArrayList<>();
                    for (int i = 0; i < idProducts.length; i++) {
                        BeanEntryProducts product = new BeanEntryProducts();
                        try {
                            product.setIdProduct(Long.parseLong(idProducts[i]));
                            product.setQuantity(Integer.parseInt(quantities[i]));
                            product.setUnitPrice(Double.parseDouble(unitPrices[i]));
                            product.setTotalPrice(Double.parseDouble(totalPrices[i]));
                            products.add(product);
                        } catch (NumberFormatException e) {
                            e.printStackTrace();
                            response.sendRedirect(request.getContextPath() + "/storage/list-Entries?result=false&message=" + URLEncoder.encode("Error en datos de productos.", StandardCharsets.UTF_8));
                            return;
                        }
                    }

                    boolean message = new DaoEntry().registerEntry(entry, products);

                    if (message) {
                        redirect = "/storage/list-Entries?result=true&message=" + URLEncoder.encode("¡Entrada registrada con éxito!", StandardCharsets.UTF_8);
                    } else {
                        redirect = "/storage/list-Entries?result=false&message=" + URLEncoder.encode("¡ERROR al registrar la Entrada!", StandardCharsets.UTF_8);
                    }
                break;

            default:
                System.out.println(action);
                break;
        }
        response.sendRedirect(request.getContextPath() + redirect);
    }
}