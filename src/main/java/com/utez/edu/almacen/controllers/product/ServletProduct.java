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

@WebServlet(name = "ServletProduct", urlPatterns = {
        "/product/list-products",
        "/product/delete",
        "/product/save",
        "/product/update"
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
                status = Boolean.parseBoolean(request.getParameter("status"));
                product = new BeanProduct(0L, name, code, description, id_metric, status);
                boolean result = new DaoProduct().save(product);
                if (result) {
                    redirect = "/product/list-products?result=" + true + "&message=" +
                            URLEncoder.encode("¡Producto registrado con éxito!", StandardCharsets.UTF_8);
                } else {
                    redirect = "/product/list-products?result=" + false + "&message=" +
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
