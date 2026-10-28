<%-- 
    Document   : ListarDocentes
    Created on : 19 oct 2026, 20:45:07
    Author     : carlos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="Web-App/css/base.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/layout.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/components.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/pages/docente.css" rel="stylesheet" type="text/css"/> 
    <link href="Web-App/css/pages/index.css" rel="stylesheet" type="text/css"/> 
    <title>Listado de Docentes</title>
    
</head>
<body>
    <jsp:include page="componentes/header.jsp" />
    <div class="container">
        <div class="header-section">
            <h1>Cuerpo Docente</h1>
            <a href="AgregarDocenteForm" class="btn btn-add">+ Nuevo Docente</a>
        </div>
        
        <!-- Formulario de Filtrado por Mes y Año -->
        <form action="FiltrarDocente" method="GET" class="filter-form">
            <div class="form-group">
                <label for="cantidad">Cantidad de Materias</label>
                <select id="cantidad" name="cantidad" required>
                    <option value="">Seleccione cantidad...</option>
                    
                    <option value="2" ${filtroCant == 2 ? 'selected' : ''}>2</option>
                    <option value="3" ${filtroCant == 3 ? 'selected' : ''}>3</option>
                    <option value="4" ${filtroCant == 4 ? 'selected' : ''}>4</option>
                    <option value="5" ${filtroCant == 5 ? 'selected' : ''}>5</option>
    
                </select>
            </div>
            <div>
                <button type="submit" class="btn btn-filter">Filtrar</button>
                <a href="ListarDocentes" class="btn btn-reset">Ver Todos</a>
            </div>
        </form>

        <table>
            <thead>
                <tr>
                    <th style="width: 10%;">ID</th>
                    <th style="width: 30%;">Nombre</th>
                    <th style="width: 15%;">Cargo</th>
                    <th style="width: 25%;">Materias a Cargo</th>
                    <th style="width: 20%;">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="doc" items="${listaDocentes}">
                    <tr>
                        <td>${doc.iddocente}</td>
                        <td>${doc.nombre}</td>
                        <td><span class="badge">${doc.cargo}</span></td>
                        <td>
                            <c:forEach var="mat" items="${doc.materiaCollection}">
                                • ${mat.nombre}<br>
                            </c:forEach>
                            <c:if test="${empty doc.materiaCollection}">
                                <em style="color: #95a5a6;">Sin asignación</em>
                            </c:if>
                        </td>
                        <td>
                            <a class="btn btn-delete" 
                               href="EliminarDocente?iddocente=${doc.iddocente}"
                               onclick="return confirm('¿Seguro que desea eliminar al docente ${doc.nombre}?');">
                                Eliminar
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listaDocentes}">
                    <tr><td colspan="5" style="text-align: center; color: #7f8c8d; padding: 20px;">No hay docentes registrados.</td></tr>
                </c:if>
            </tbody>
        </table>
        <a href="index.jsp" class="btn-volver">&#8592; Volver al Inicio</a>
    </div>
</body>
</html>
