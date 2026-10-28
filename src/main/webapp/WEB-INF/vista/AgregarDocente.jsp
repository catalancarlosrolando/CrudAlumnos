<%-- 
    Document   : AgregarDocente
    Created on : 26 oct 2026, 20:29:57
    Author     : carlos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="Web-App/css/base.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/layout.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/components.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/pages/docente.css" rel="stylesheet" type="text/css"/> 
    <link href="Web-App/css/pages/index.css" rel="stylesheet" type="text/css"/> 
    <title>Registrar Nuevo Docente</title>
    <style>
       
    </style>
</head>
<body>
    <jsp:include page="componentes/header.jsp" />
    <div class="container">
        <h2>Registrar Docente</h2>
        <form action="AgregarDocente" method="POST">
            <div class="form-group">
                <label for="nombre">Nombre Completo:</label>
                <input type="text" id="nombre" name="nombre" required maxlength="45">
            </div>

            <div class="form-group">
                <label for="cargo">Cargo:</label>
                <select id="cargo" name="cargo" required>
                    <option value="TITULAR">TITULAR</option>
                    <option value="ADJUNTO">ADJUNTO</option>
                    <option value="JTP">JTP</option>
                </select>
            </div>

            <div class="form-group">
                <label>Materias que dicta:</label>
                <div class="checkbox-container">
                    <c:forEach var="mat" items="${listaMaterias}">
                        <label>
                            <input type="checkbox" name="materiasIds" value="${mat.idmateria}"> 
                            ${mat.nombre}
                        </label>
                    </c:forEach>
                    <c:if test="${empty listaMaterias}">
                        <em>No hay materias cargadas en el sistema.</em>
                    </c:if>
                </div>
            </div>

            <div style="margin-top: 20px; display: flex; justify-content: flex-end; gap: 10px;">
                <a href="ListarDocentes" class="btn btn-cancel">Cancelar</a>
                <button type="submit" class="btn btn-save">Guardar Docente</button>
            </div>
        </form>
    </div>
</body>
</html>
