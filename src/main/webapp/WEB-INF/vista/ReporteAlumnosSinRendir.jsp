<%-- 
    Document   : ReporteAlumnosSinRendir
    Created on : 19 oct 2026, 20:45:42
    Author     : carlos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Alumnos Sin Exámenes en el Año</title>
    <link href="Web-App/css/base.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/layout.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/components.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/pages/reporte.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/pages/index.css" rel="stylesheet" type="text/css"/> 
</head>
<body>
    <jsp:include page="componentes/header.jsp" />
    <div class="container">
        <h1>Alumnos sin exámenes rendidos en el año en curso</h1>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Registro</th>
                    <th>Nombre</th>
                    <th>Carrera</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="alu" items="${listaAlumnos}">
                    <tr>
                        <td>${alu.id}</td>
                        <td>${alu.registro}</td>
                        <td>${alu.nombre}</td>
                        <td>${alu.carreraIdcarrera.nombre}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listaAlumnos}">
                    <tr><td colspan="4" style="text-align: center; color: #7f8c8d; padding: 20px;">Todos los alumnos han registrado al menos un examen este año.</td></tr>
                </c:if>
            </tbody>
        </table>
        <a href="index.jsp" class="btn-volver">&#8592; Volver al Inicio</a>
    </div>
</body>
</html>
