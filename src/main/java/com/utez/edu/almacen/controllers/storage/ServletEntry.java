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
        "/storage/save-Entry" // POST
})
public class ServletEntry extends HttpServlet {
    private static final Logger logger = Logger.getLogger(ServletEntry.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();
        String redirect = "";

        switch (action) {
            case "/storage/list-Entries":
                String currentUserEmail = (String) request.getSession().getAttribute("user");

                if (currentUserEmail != null) {
                    BeanLoggedUser loggedUser = new DaoLoggedUser().findUserByEmail(currentUserEmail);

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
                logger.warning("Acción no reconocida: " + action);
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
                // Crear una instancia de BeanEntry
                BeanEntry entry = new BeanEntry();

                // Obtener la fecha actual del sistema en formato YYYY-MM-DD usando java.util.Date y SimpleDateFormat
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String formattedDate = sdf.format(new Date());

                // Establecer los valores en el objeto entry
                entry.setChangeDate(formattedDate);
                entry.setInvoiceNumber(request.getParameter("invoiceNumber"));
                entry.setFolioNumber(request.getParameter("folioNumber"));

                try {
                    entry.setIdUser(Integer.parseInt(request.getParameter("id_user")));
                    entry.setIdProvider(Integer.parseInt(request.getParameter("id_provider")));

                    // Obtener y mostrar el valor de totalAllPrices para depuración
                    String totalAllPricesStr = request.getParameter("totalAllPrices");
                    System.out.println("Total All Prices (Servlet): " + totalAllPricesStr);

                    entry.setTotalAllPrices(Double.parseDouble(totalAllPricesStr)); // Obtener totalAllPrices del request
                } catch (NumberFormatException e) {
                    logger.severe("Error en datos de usuario, proveedor o totalAllPrices: " + e.getMessage());
                    response.sendRedirect(request.getContextPath() + "/storage/list-Entries?result=false&message=" + URLEncoder.encode("Error en datos de usuario, proveedor o totalAllPrices.", StandardCharsets.UTF_8));
                    return;
                }

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
                        Long idProduct = idProducts[i] != null && !idProducts[i].trim().isEmpty() ? Long.parseLong(idProducts[i]) : null;
                        Integer quantity = quantities[i] != null && !quantities[i].trim().isEmpty() ? Integer.parseInt(quantities[i]) : null;
                        Double unitPrice = unitPrices[i] != null && !unitPrices[i].trim().isEmpty() ? Double.parseDouble(unitPrices[i]) : null;
                        Double totalPrice = totalPrices[i] != null && !totalPrices[i].trim().isEmpty() ? Double.parseDouble(totalPrices[i]) : null;

                        if (idProduct == null || quantity == null || unitPrice == null || totalPrice == null) {
                            response.sendRedirect(request.getContextPath() + "/storage/list-Entries?result=false&message=" + URLEncoder.encode("Error en datos de productos.", StandardCharsets.UTF_8));
                            return;
                        }

                        product.setIdProduct(idProduct);
                        product.setQuantity(quantity);
                        product.setUnitPrice(unitPrice);
                        product.setTotalPrice(totalPrice);
                        products.add(product);
                    } catch (NumberFormatException e) {
                        logger.severe("Error en datos de productos: " + e.getMessage());
                        response.sendRedirect(request.getContextPath() + "/storage/list-Entries?result=false&message=" + URLEncoder.encode("Error en datos de productos.", StandardCharsets.UTF_8));
                        return;
                    }
                }

                // Registrar la entrada
                boolean success = new DaoEntry().registerEntry(entry, products);

                // Redirigir según el resultado
                if (success) {
                    redirect = "/storage/list-Entries?result=true&message=" + URLEncoder.encode("¡Entrada registrada con éxito!", StandardCharsets.UTF_8);
                } else {
                    redirect = "/storage/list-Entries?result=false&message=" + URLEncoder.encode("¡ERROR al registrar la Entrada!", StandardCharsets.UTF_8);
                }
                response.sendRedirect(request.getContextPath() + redirect);
            break;

            default:
                logger.warning("Acción no reconocida: " + action);
                break;
        }
    }
}