<%-- 
    Document   : ListarMaterias
    Created on : 19 oct 2026, 23:24:28
    Author     : carlos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestión de Materias</title>
    <link href="Web-App/css/base.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/layout.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/components.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="Web-App/css/pages/materias.css">
    <link href="Web-App/css/pages/index.css" rel="stylesheet" type="text/css"/> 
</head>
<body>
<jsp:include page="componentes/header.jsp" />
    <div class="container">
        <div class="header-section">
            <h1>Listado de Materias</h1>
            <button class="btn btn-add" onclick="abrirModalAgregar()">+ Nueva Materia</button>
        </div>

        <table>
            <thead>
                <tr>
                    <th style="width: 20%;">Código</th>
                    <th style="width: 50%;">Nombre de la Materia</th>
                    <th style="width: 30%;">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="mat" items="${listaMaterias}">
                    <tr>
                        <td>${mat.idmateria}</td>
                        <td>${mat.nombre}</td>
                        <td>
                            <button class="btn btn-edit" 
                                    onclick="abrirModalModificar('${mat.idmateria}', '${mat.nombre}')">
                                Editar
                            </button>
                            <a class="btn btn-delete" 
                               href="EliminarMateria?idMateria=${mat.idmateria}"
                               onclick="return confirmarEliminacion('${mat.nombre}');">
                                Eliminar
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listaMaterias}">
                    <tr>
                        <td colspan="3" style="text-align: center; color: #7f8c8d; padding: 20px;">
                            No hay materias registradas.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <a href="index.jsp" class="btn-volver">&#8592; Volver al Inicio</a>
    </div>

    <!-- MODAL AGREGAR MATERIA -->
    <div id="modalAgregarMateria" class="modal">
        <div class="modal-content">
            <h3 style="border-bottom: 2px solid #27ae60;">Registrar Materia</h3>
            <form action="AgregarMateria" method="POST">
                <div class="form-group">
                    <label for="nombreMateria">Nombre:</label>
                    <input type="text" id="nombreMateria" name="nombre" maxlength="45" required placeholder="Ej: Algoritmos I">
                </div>
                <div class="modal-actions">
                    <button type="button" class="btn btn-cancel" onclick="cerrarModal('modalAgregarMateria')">Cancelar</button>
                    <button type="submit" class="btn btn-add">Guardar</button>
                </div>
            </form>
        </div>
    </div>

    <!-- MODAL MODIFICAR MATERIA -->
    <div id="modalEditarMateria" class="modal">
        <div class="modal-content">
            <h3 style="border-bottom: 2px solid #2980b9;">Modificar Materia</h3>
            <form action="ModificarMateria" method="POST">
                <input type="hidden" id="editIdMateria" name="idMateria">

                <div class="form-group">
                    <label>Código:</label>
                    <input type="text" id="editIdMateriaVisible" disabled style="background-color: #eee;">
                </div>

                <div class="form-group">
                    <label for="editNombreMateria">Nombre:</label>
                    <input type="text" id="editNombreMateria" name="nombre" maxlength="45" required>
                </div>

                <div class="modal-actions">
                    <button type="button" class="btn btn-cancel" onclick="cerrarModal('modalEditarMateria')">Cancelar</button>
                    <button type="submit" class="btn btn-edit">Guardar Cambios</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function confirmarEliminacion(nombre) {
            return confirm("¿Está seguro de que desea eliminar la materia '" + nombre + "'?");
        }

        function abrirModalAgregar() {
            document.getElementById("nombreMateria").value = "";
            document.getElementById("modalAgregarMateria").style.display = "flex";
            document.getElementById("nombreMateria").focus();
        }

        function abrirModalModificar(id, nombre) {
            document.getElementById("editIdMateria").value = id;
            document.getElementById("editIdMateriaVisible").value = id;
            document.getElementById("editNombreMateria").value = nombre;
            document.getElementById("modalEditarMateria").style.display = "flex";
            document.getElementById("editNombreMateria").focus();
        }

        function cerrarModal(modalId) {
            document.getElementById(modalId).style.display = "none";
        }

        window.onclick = function(event) {
            var modalAdd = document.getElementById("modalAgregarMateria");
            var modalEdit = document.getElementById("modalEditarMateria");
            if (event.target === modalAdd) modalAdd.style.display = "none";
            if (event.target === modalEdit) modalEdit.style.display = "none";
        };
    </script>

</body>
</html>