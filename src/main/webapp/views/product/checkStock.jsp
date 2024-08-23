<%@ page import="com.utez.edu.almacen.models.user.BeanLoggedUser" %>
<%@ page import="java.util.List" %>
<%@ page import="com.utez.edu.almacen.models.metric.BeanMetric" %>
<%@ page import="com.utez.edu.almacen.models.metric.DaoMetric" %>
<%@ page import="com.utez.edu.almacen.models.provider.DaoProvider" %>
<%@ page import="com.utez.edu.almacen.models.provider.BeanProvider" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("pageTitle", "Stock"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String context = request.getContextPath();
    String email = (String) request.getSession(false).getAttribute("user");
    String role = (String) request.getSession(false).getAttribute("role");
    if (email == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
    List<BeanMetric> metrics = new DaoMetric().listAll();
    List<BeanProvider> providers = new DaoProvider().listAll();
%>
<html>
<head>
    <title>Stock</title>
    <link href="../../assets/css/estilos.css" rel="stylesheet">
    <jsp:include page="../../layouts/header.jsp"/>
</head>
<body>
<%
    if ("Administrador".equals(role)) {
%>
<jsp:include page="../../layouts/menu.jsp"/>
<%
} else if ("Almacenista".equals(role)) {
%>
<jsp:include page="../../layouts/menu2.jsp"/>
<%
    }
%>

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
                        <div class="col-3">Clave</div>
                        <div class="col-3">Producto</div>
                        <div class="col-3">Proveedor </div>
                        <div class="col-3">Unidad de medida </div>
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
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="../../assets/js/funciones.js"></script>
<script src="../../assets/js/alerts.js"></script>

<jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>