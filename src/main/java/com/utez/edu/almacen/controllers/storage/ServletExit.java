
package com.utez.edu.almacen.controllers.storage;

import com.utez.edu.almacen.models.storage.*;
import com.utez.edu.almacen.models.user.BeanLoggedUser;
import com.utez.edu.almacen.models.user.DaoLoggedUser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

@WebServlet(name = "ServletExit", urlPatterns = {
        "/storage/list-Exits",
        "/storage/save-Exit"
})
public class ServletExit extends HttpServlet {
    private static final Logger logger = Logger.getLogger(ServletEntry.class.getName());

    private String action;
    private String redirect = "/storage/list-Exits";
    private BeanLoggedUser loggedUser;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        action = request.getServletPath();
        switch (action) {
            case "/storage/list-Exits":

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

                List<BeanExit> salidas = new DaoExit().listAll();
                request.setAttribute("exits2", salidas);
                redirect = "/views/storage/outbounds.jsp";
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
            case "/storage/save-Exit":
                // Crear una instancia de BeanExit
                BeanExit exit = new BeanExit();

                // Obtener la fecha actual del sistema en formato YYYY-MM-DD usando java.util.Date y SimpleDateFormat
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String formattedDate = sdf.format(new Date());

                // Establecer los valores en el objeto exit
                exit.setChangeDate(formattedDate);
                exit.setInvoiceNumber(request.getParameter("invoiceNumber"));
                exit.setFolioNumber(request.getParameter("folioNumber"));
                exit.setIdUser(Integer.parseInt(request.getParameter("id_user")));
                exit.setIdArea(Integer.parseInt(request.getParameter("id_area")));
                exit.setBuyerName(request.getParameter("buyerName"));

                // Obtener y mostrar el valor de totalAllPrices para depuración
                String totalAllPricesStr = request.getParameter("totalAllPrices");
                System.out.println("Total All Prices (Servlet): " + totalAllPricesStr);
                try {
                    exit.setTotalAllPrices(Double.parseDouble(totalAllPricesStr)); // Obtener totalAllPrices del request
                } catch (NumberFormatException e) {
                    logger.severe("Error en datos de totalAllPrices: " + e.getMessage());
                    response.sendRedirect(request.getContextPath() + "/storage/list-Exits?result=false&message=" + URLEncoder.encode("Error en totalAllPrices.", StandardCharsets.UTF_8));
                    return;
                }

                // Obtener los productos de la salida
                String[] idProducts = request.getParameterValues("idProduct");
                String[] idProviders = request.getParameterValues("id_provider");
                String[] quantities = request.getParameterValues("quantity");
                String[] unitPrices = request.getParameterValues("unitPrice");
                String[] totalPrices = request.getParameterValues("total_price");

                List<BeanExitProducts> products = new ArrayList<>();

                for (int i = 0; i < idProducts.length; i++) {
                    BeanExitProducts product = new BeanExitProducts();
                    try {
                        Long idProduct = idProducts[i] != null && !idProducts[i].trim().isEmpty() ? Long.parseLong(idProducts[i]) : null;
                        Long idProvider = idProviders[i] != null && !idProviders[i].trim().isEmpty() ? Long.parseLong(idProviders[i]) : null;
                        Integer quantity = quantities[i] != null && !quantities[i].trim().isEmpty() ? Integer.parseInt(quantities[i]) : null;
                        Double unitPrice = unitPrices[i] != null && !unitPrices[i].trim().isEmpty() ? Double.parseDouble(unitPrices[i]) : null;
                        Double totalPrice = totalPrices[i] != null && !totalPrices[i].trim().isEmpty() ? Double.parseDouble(totalPrices[i]) : null;

                        if (idProduct == null || quantity == null || unitPrice == null || totalPrice == null) {
                            response.sendRedirect(request.getContextPath() + "/storage/list-Exits?result=false&message=" + URLEncoder.encode("Error en datos de productos.", StandardCharsets.UTF_8));
                            return;
                        }

                        product.setIdProduct(idProduct);
                        product.setIdProvider(idProvider);
                        product.setQuantity(quantity);
                        product.setUnitPrice(unitPrice);
                        product.setTotalPrice(totalPrice);
                        products.add(product);
                    } catch (NumberFormatException e) {
                        logger.severe("Error en datos de productos: " + e.getMessage());
                        response.sendRedirect(request.getContextPath() + "/storage/list-Exits?result=false&message=" + URLEncoder.encode("Error en datos de productos.", StandardCharsets.UTF_8));
                        return;
                    }
                }

                // Registrar la salida
                boolean success = new DaoExit().registerExit(exit, products);

                // Redirigir según el resultado
                if (success) {
                    redirect = "/storage/list-Exits?result=true&message=" + URLEncoder.encode("¡Salida registrada con éxito!", StandardCharsets.UTF_8);
                } else {
                    redirect = "/storage/list-Exits?result=false&message=" + URLEncoder.encode("¡ERROR al registrar la Salida!", StandardCharsets.UTF_8);
                }
                response.sendRedirect(request.getContextPath() + redirect);
                break;

            default:
                logger.warning("Acción no reconocida: " + action);
                break;
        }
    }

}
