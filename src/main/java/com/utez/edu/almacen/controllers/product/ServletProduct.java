package com.utez.edu.almacen.controllers.product;

import com.utez.edu.almacen.models.product.BeanProduct;
import com.utez.edu.almacen.models.product.DaoProduct;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "ServletProduct",
        urlPatterns = {
            "/product/list-products", //get
            "/product/list-stocks", //get
            "/product/search", //get
            "/product/searchStock", //get
            "/product/delete", //post
            "/product/save", //post
            "/product/saveout", //post
            "/product/update" //post

})
public class ServletProduct extends HttpServlet {
    private String action;
    private String redirect = "/product/list-products";
    private BeanProduct product;
    private String id, name, code, description, id_metric;
    private Boolean status;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        action = request.getServletPath();
        switch (action) {
            case "/product/list-products":
                List<BeanProduct> products = new DaoProduct().listAll();
                request.setAttribute("products", products);
                redirect = "/views/product/products.jsp";
            break;
            case "/product/register":
                redirect = "";
                break;
            case "/product/update-view":
                id = request.getParameter("id");
                product = new DaoProduct().listOne((id != null) ? (Long.parseLong(id)) : (0));
                if (product != null) {
                    request.setAttribute("product", product);
                    redirect = "";
                } else {
                    redirect = "/product/list-products?result=" + false + "&message=" +
                            URLEncoder.encode("¡Error! Acción no realizada correctamente", StandardCharsets.UTF_8);
                }
            break;
            case "/product/list-stocks":
                List<BeanProduct> stocks = new DaoProduct().listAllStock();

                // Filtrar productos con cantidad mayor a 0
                List<BeanProduct> inStockProducts = stocks.stream()
                        .filter(product -> product.getQuantity() > 0)
                        .collect(Collectors.toList());

                request.setAttribute("stocks", inStockProducts);
                redirect = "/views/product/checkStock.jsp";
            break;
            case "/product/search":
                code = request.getParameter("code");
                name = request.getParameter("name");
                id_metric = request.getParameter("id_metric");
                description = request.getParameter("description");
                String status2 = request.getParameter("status");
                request.setAttribute("searchCode", code);
                request.setAttribute("searchName", name);
                products = new DaoProduct().search(name, code, id_metric, status2);
                request.setAttribute("products", products);
            break;
            case "/product/searchStock":
                String code = request.getParameter("code");
                String name = request.getParameter("name");
                String id_metric = request.getParameter("id_metric");
                String providerName = request.getParameter("providerName");

                request.setAttribute("searchCode", code);
                request.setAttribute("searchName", name);
                request.setAttribute("searchMetric", id_metric);
                request.setAttribute("searchProviderName", providerName);

                stocks = new DaoProduct().searchStock(name, code, id_metric, providerName);

                List<BeanProduct> inStockSearchResults = stocks.stream()
                        .filter(product -> product.getQuantity() > 0)
                        .collect(Collectors.toList());

                request.setAttribute("stocks", inStockSearchResults);
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
            case "/product/delete":
                id = request.getParameter("id");
                if (new DaoProduct().changeStatus(Long.parseLong(id))) {
                    redirect = "/product/list-products?result=" + true + "&message=" +
                            URLEncoder.encode("¡Estado del Producto cambiado con éxito!", StandardCharsets.UTF_8);
                } else {
                    redirect = "/product/list-products?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al cambiar el estado!", StandardCharsets.UTF_8);
                }
                break;
            case "/product/save":
                name = request.getParameter("name");
                code = request.getParameter("code");
                description = request.getParameter("description");
                id_metric = request.getParameter("id_metric");
                product = new BeanProduct(0L, name, code, description, id_metric, true);
                boolean result = new DaoProduct().save(product);
                if (result) {
                    redirect = "/product/list-products?result=" + true + "&message=" +
                            URLEncoder.encode("¡Producto registrado con éxito!", StandardCharsets.UTF_8);
                } else {
                    redirect = "/product/list-products?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al crear el registro del producto!", StandardCharsets.UTF_8);
                }
                break;
            case "/product/saveout":
                name = request.getParameter("name");
                code = request.getParameter("code");
                description = request.getParameter("description");
                id_metric = request.getParameter("id_metric");
                product = new BeanProduct(0L, name, code, description, id_metric, true);
                result = new DaoProduct().save(product);
                if (result) {
                    //redirect = "/storage/list-entrys?result=" + true + "&message=" +
                    redirect = "/storage/list-Entries?result=" + true + "&message=" +
                            URLEncoder.encode("¡Producto registrado con éxito!", StandardCharsets.UTF_8);
                } else {
                    //redirect = "/storage/list-entrys?result=" + false + "&message=" +
                    redirect = "/storage/list-Entries?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al crear el registro del producto!", StandardCharsets.UTF_8);
                }
                break;
            case "/product/update":
                id = request.getParameter("id");
                name = request.getParameter("name");
                code = request.getParameter("code");
                description = request.getParameter("description");
                id_metric = request.getParameter("id_metric");
                status = Boolean.parseBoolean(request.getParameter("status"));
                product = new BeanProduct(Long.parseLong(id), name, code, description, id_metric, status);
                if (new DaoProduct().update(product)) {
                    redirect = "/product/list-products?result=" + true + "&message=" +
                            URLEncoder.encode("¡Modificación del producto realizada con éxito!", StandardCharsets.UTF_8);
                } else {
                    redirect = "/product/list-products?result=" + false + "&message=" +
                            URLEncoder.encode("¡ERROR al modificar el producto!", StandardCharsets.UTF_8);
                }
                break;
            default:
                System.out.println(action);
        }
        response.sendRedirect(redirect);
    }
}
