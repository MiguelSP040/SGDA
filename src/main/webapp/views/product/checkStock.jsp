<%@ page import="com.utez.edu.almacen.models.metric.BeanMetric" %>
<%@ page import="java.util.List" %>
<%@ page import="com.utez.edu.almacen.models.metric.DaoMetric" %>
<%@ page import="com.utez.edu.almacen.models.provider.DaoProvider" %>
<%@ page import="com.utez.edu.almacen.models.provider.BeanProvider" %>
<%--
  Created by IntelliJ IDEA.
  User: migue
  Date: 05/08/2024
  Time: 10:05 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("pageTitle", "Stock"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String context = request.getContextPath();
    if (request.getSession(false).getAttribute("user") == null){
        response.sendRedirect(context+"/index.jsp");
    }
    List<BeanMetric> metrics = new DaoMetric().listAll(1,2);
    List<BeanProvider> providers = new DaoProvider().listAll(1,2);
%>
<html>
<head>
    <title>Stock</title>
    <link href="../../assets/css/estilos.css" rel="stylesheet">
    <jsp:include page="../../layouts/header.jsp"/>
</head>
<body>
<jsp:include page="../../layouts/menu.jsp"/>


<!--Contenido Total, sin contemplar sidebar y navbar -->
<div class="container">
    <div class="container-fluid vh-100 d-flex justify-content-center align-items-center">
        <div class="card contenidoTotal shadow-lg p-5">
            <!--Titulo de Formulario-->
            <div class="position-relative">
                <h3>Consulta de stock</h3>
            </div>

            <!-- Modal -->
            <!--DATOS DE ENTRADA
                Nombre del producto(*)  - Alfanumérico
                Acrónimo(*)             - Alfanumérico
                Descripción(*)          - Alfanumérico
                -->

            <!--FILTRO DE BUSQUEDA DE PRODUCTO-->
            <div class="mt-3">
                <form action="<%=context%>/product/searchStock" method="get">
                    <div class="row d-flex justify-content-center">
                        <div class="col-3">Clave del producto</div>
                        <div class="col-3">Nombre del producto</div>
                        <div class="col-3">Proveedor </div>
                        <div class="col-3">Unidad de medida</div>
                    </div>

                    <!--Folio de la entrada-->
                    <div class="row d-flex justify-content-center">
                        <div class="col-3">
                            <input id="code" name="code" type="text" class="form-control" placeholder="Clave del producto">
                        </div>
                        <!--Nombre del producto-->
                        <div class="col-3">
                            <input id="id_product" name="name"  type="text" class="form-control" placeholder="Nombre del producto">
                        </div>
                        <!--Proveedor-->
                        <div class="col-3">
                            <select class="form-select" name="providerName" id="id_provider">
                                <option disabled selected value>Seleccionar Proveedor</option>
                                <% for (BeanProvider pr : providers) { %>
                                <% if (pr.getStatus()) { %>
                                <option value="<%=pr.getName()%>"><%=pr.getName()%></option>
                                <% } %>
                                <% } %>
                            </select>
                        </div>
                        <!--Almacenista-->
                        <div class="col-3">
                            <select class="form-select" name="id_metric" id="id_metric">
                                <option disabled selected value>Seleccionar opción</option>
                                <% for (BeanMetric m : metrics) { %>
                                <% if (m.getStatus()) { %>
                                <option value="<%= m.getName() %>"><%= m.getName() %></option>
                                <% } %>
                                <% } %>
                            </select>
                        </div>

                        <!--Botones -->
                        <div class="grid gap-2 d-flex justify-content-end mt-5">
                            <!-- Botón Buscar -->
                            <button type="submit" class="btn botonCafe mb-3">
                                Buscar
                            </button>
                            <!-- Botón Limpiar -->
                            <button type="reset" class="btn botonGris btn-light mb-3">
                                Limpiar
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <!--Tabla con registros-->
            <div class="table-responsive table-container" id="contenedor">
                <table class="table table-bordered table-striped mt-0 text-center">
                    <thead class="thead-dark">
                    <tr>
                        <th scope="col" colspan="8" class="tableTitle">PRODUCTOS EN STOCK</th>
                    </tr>
                    <tr>
                        <th scope="col" class="thead">#</th>
                        <th scope="col" class="thead">Clave</th>
                        <th scope="col" class="thead">Producto</th>
                        <th scope="col" class="thead">Medida</th>
                        <th scope="col" class="thead">Proveedor</th>
                        <th scope="col" class="thead">Cantidad</th>
                    </tr>
                    </thead>
                    <tbody class="align-middle">
                    <c:forEach var="stock" items="${stocks}" varStatus="s">
                        <tr>
                            <th scope="row"><c:out value="${s.count}"/></th>
                            <td><c:out value="${stock.code}"/></td>
                            <td><c:out value="${stock.name}"/></td>
                            <td><c:out value="${stock.metricName}"/></td>
                            <td><c:out value="${stock.providerName}"/></td>
                            <td><c:out value="${stock.quantity}"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <!--Paginación al pie de Página -->
            <div class="pagination d-flex justify-content-center align-items-center mt-5">
                <button class="btn btn-lg me-2" aria-label="Previous Page">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                         class="bi bi-caret-left-fill" viewBox="0 0 16 16">
                        <path d="m3.86 8.753 5.482 4.796c.646.566 1.658.106 1.658-.753V3.204a1 1 0 0 0-1.659-.753l-5.48 4.796a1 1 0 0 0 0 1.506z" />
                    </svg>
                </button>
                <input type="number" class="page-info form-control" style="width: 4rem" min="1" value="1"></input>
                <button class="btn btn-lg ms-2" aria-label="Next Page">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                         class="bi bi-caret-right-fill" viewBox="0 0 16 16">
                        <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z" />
                    </svg>
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="../../assets/js/funciones.js"></script>
<script src="../../assets/js/alerts.js"></script>

<jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>