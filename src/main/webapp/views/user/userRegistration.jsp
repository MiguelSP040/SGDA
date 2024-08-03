<%--
  Created by IntelliJ IDEA.
  User: migue
  Date: 30/07/2024
  Time: 12:50 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registro</title>
    <link href="../../assets/css/estilos.css" rel="stylesheet">
    <jsp:include page="../../layouts/header.jsp"/>
</head>
<body>
<!--CONTENEDOR TOTAL-->
<div class="card shadow-lg">
    <div class="col"><h5>Nuevo Usuario</h5></div>
    <div class="row">
        <!--DATOS USUARIO-->
        <div class="col" id="dataRegister">
            <form class="needs-validation" novalidate
                  action="/user/save" method="post">
                <div class="row Inputs">
                    <label for="name" class="col-4">Nombre(s)*</label>
                    <label for="surname" class="col-4">Apellido paterno*</label>
                </div>
                <div class="row">
                    <div class="col-4"><input type="text" class="col-3 form-control" name="name" id="name" required></div>
                    <div class="col-4"><input type="text" class="form-control" name="surname" id="surname" required></div>
                </div>
                <div class="row Inputs">
                    <label for="lastname" class="col-4">Apellido materno*</label>
                    <label for="phone" class="col-4" >Teléfono*</label>
                </div>
                <div class="row">
                    <div class="col-4"><input type="text" class="form-control" name="lastname" id="lastname" required></div>
                    <div class="col-4" ><input type="text" class="form-control" name="phone" id="phone"></div>
                </div>
                <div class="row Inputs" style="text-indent: 2%!important;">
                    <label class="col-8" for="email">Correo electrónico*</label>
                </div>
                <div class="row">
                    <div class="col-8"><input type="email" class="form-control" name="email" id="email" required></div>
                </div>
                <!--Botones -->
                <button class="btn mb-3" id="botonCafe" type="submit">Registrar</button>
                <a href="/user/list-users" class="btn mb-3" id="botonGris">Cancelar</a>
            </form>
        </div>



    </div>
</div>
    <script src="/assets/funciones.js"></script>
    <jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>
