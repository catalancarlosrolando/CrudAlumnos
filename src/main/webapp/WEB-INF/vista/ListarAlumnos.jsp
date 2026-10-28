<%-- 
    Document   : ListarCarreras
    Created on : 19 oct 2026, 15:14:03
    Author     : carlos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Listado de Alumnos</title>
    <link href="Web-App/css/base.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/layout.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/components.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/pages/alumno.css" rel="stylesheet" type="text/css"/> 
    <link href="Web-App/css/pages/index.css" rel="stylesheet" type="text/css"/> 
</head>
<body>
<jsp:include page="componentes/header.jsp" />
    <div class="container">
        <div class="header-section">
            <h1>Alumnos Registrados</h1>
        </div>

        <table>
            <thead>
                <tr>
                    <th style="width: 10%;">ID</th>
                    <th style="width: 35%;">Nombre</th>
                    <th style="width: 15%;">Registro</th>
                    <th style="width: 20%;">Carrera</th>
                    <th style="width: 20%;">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="alu" items="${lista}">
                    <tr>
                        <td>${alu.id}</td>
                        <td>${alu.nombre}</td>
                        <td>${alu.registro}</td>
                        <td>${alu.carreraIdcarrera.nombre}</td>
                        <td>
                            <!-- Botón Modificar: Precarga los datos en el modal -->
                            <button class="btn btn-edit" 
                                    onclick="abrirModalModificar('${alu.id}', '${alu.nombre}', '${alu.registro}', '${alu.carreraIdcarrera.idcarrera}')">
                                Editar
                            </button>

                            <!-- Botón Eliminar: Confirmación nativa JS -->
                            <a class="btn btn-delete" 
                               href="EliminarAlumno?idAlumno=${alu.id}"
                               onclick="return confirmarEliminacion('${alu.nombre}');">
                                Eliminar
                            </a>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty lista}">
                    <tr>
                        <td colspan="5" class="empty-msg">No hay alumnos registrados en el sistema.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <a href="index.jsp" class="btn-volver">&#8592; Volver al Inicio</a>
    </div>

    <!-- MODAL PARA MODIFICAR ALUMNO -->
    <div id="modalEditarAlumno" class="modal">
        <div class="modal-content">
            <h3>Modificar Alumno</h3>
            <form action="ModificarAlumno" method="POST">
                <input type="hidden" id="modalIdAlumno" name="idAlumno">

                <div class="form-group">
                    <label>ID Alumno:</label>
                    <input type="text" id="modalIdAlumnoVisible" disabled style="background-color: #eee;">
                </div>

                <div class="form-group">
                    <label for="modalRegistro">Registro / Legajo:</label>
                    <input type="text" id="modalRegistro" name="registro" maxlength="6" required>
                </div>

                <div class="form-group">
                    <label for="modalNombre">Nombre Completo:</label>
                    <input type="text" id="modalNombre" name="nombre" maxlength="45" required>
                </div>

                <div class="form-group">
                    <label for="modalIdCarrera">Carrera:</label>
                    <select id="modalIdCarrera" name="idCarrera" required>
                        <c:forEach var="car" items="${listacarrera}">
                            <option value="${car.idcarrera}">
                                ${car.nombre} (${car.facultadIdfacultad.nombre})
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="modal-actions">
                    <button type="button" class="btn btn-cancel" onclick="cerrarModal()">Cancelar</button>
                    <button type="submit" class="btn btn-edit">Guardar Cambios</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function confirmarEliminacion(nombreAlumno) {
            return confirm("¿Está seguro de que desea eliminar al alumno '" + nombreAlumno + "'?");
        }

        function abrirModalModificar(id, nombre, registro, idCarrera) {
            document.getElementById("modalIdAlumno").value = id;
            document.getElementById("modalIdAlumnoVisible").value = id;
            document.getElementById("modalNombre").value = nombre;
            document.getElementById("modalRegistro").value = registro;
            document.getElementById("modalIdCarrera").value = idCarrera;
            
            document.getElementById("modalEditarAlumno").style.display = "flex";
            document.getElementById("modalNombre").focus();
        }

        function cerrarModal() {
            document.getElementById("modalEditarAlumno").style.display = "none";
        }

        window.onclick = function(event) {
            var modal = document.getElementById("modalEditarAlumno");
            if (event.target === modal) {
                cerrarModal();
            }
        };
    </script>

</body>
</html>