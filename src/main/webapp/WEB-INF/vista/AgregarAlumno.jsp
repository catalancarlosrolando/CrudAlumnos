<%-- 
    Document   : AgregarAlumno
    Created on : 19 oct 2026, 16:13:26
    Author     : carlos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registrar Alumno</title>
    <link href="Web-App/css/base.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/layout.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/components.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/pages/alumno.css" rel="stylesheet" type="text/css"/> 
    <link href="Web-App/css/pages/index.css" rel="stylesheet" type="text/css"/> 
   
</head>
<body>
    <jsp:include page="componentes/header.jsp" />
    <div class="container">
        <h1>Nuevo Alumno</h1>

        <form action="AgregarAlumno" method="POST">
            
            <div class="form-group">
                <label for="registro">Número de Registro / Legajo:</label>
                <input type="text" id="registro" name="registro" maxlength="6" required placeholder="Ej: 123456">
            </div>

            <div class="form-group">
                <label for="nombre">Nombre Completo:</label>
                <input type="text" id="nombre" name="nombre" maxlength="45" required placeholder="Ej: Juan Perez">
            </div>

            <div class="form-group">
                <label for="idCarrera">Carrera:</label>
                <select id="idCarrera" name="idCarrera" required>
                    <option value="" disabled selected>-- Seleccione una carrera --</option>
                    <%-- Despliega las carreras obtenidas desde la BD mediante CarreraFacade --%>
                    <c:forEach var="car" items="${lista}">
                        <option value="${car.idcarrera}">
                            ${car.nombre} (Facultad: ${car.facultadIdfacultad.nombre})
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="btn-group">
                <a href="index.jsp" class="btn-cancelar">Cancelar</a>
                <button type="submit" class="btn-guardar">Agregar Alumno</button>
            </div>

        </form>
    </div>

</body>
</html>
