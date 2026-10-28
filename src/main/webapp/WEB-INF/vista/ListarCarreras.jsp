<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Carreras de la Facultad</title>
    <link href="Web-App/css/base.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/layout.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/components.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/pages/carreras.css" rel="stylesheet" type="text/css"/> 
    <link href="Web-App/css/pages/index.css" rel="stylesheet" type="text/css"/> 
    
</head>
<body>
<jsp:include page="componentes/header.jsp" />
    <div class="container">
        <div class="header-section">
            <h1>Carreras de: ${facultad.nombre}</h1>
            <!-- Botón que dispara el modal de agregar -->
            <button class="btn btn-add" onclick="abrirModalAgregar()">+ Nueva Carrera</button>
        </div>
        
        <p class="info-header">Código de Facultad: <strong>${facultad.idfacultad}</strong></p>

        <table>
            <thead>
                <tr>
                    <th style="width: 15%;">Código</th>
                    <th style="width: 55%;">Nombre de la Carrera</th>
                    <th style="width: 30%;">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="car" items="${facultad.getCarreraCollection()}">
                    <tr>
                        <td>${car.idcarrera}</td>
                        <td>${car.nombre}</td>
                        <td>
                            <button class="btn btn-edit" 
                                    onclick="abrirModalModificar('${car.idcarrera}', '${car.nombre}')">
                                Editar
                            </button>
                            <a class="btn btn-delete" 
                               href="EliminarCarrera?idCarrera=${car.idcarrera}&idFacultad=${facultad.idfacultad}"
                               onclick="return confirmarEliminacion('${car.nombre}');">
                                Eliminar
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty facultad.getCarreraCollection()}">
                    <tr>
                        <td colspan="3" style="text-align: center; color: #7f8c8d; font-style: italic;">
                            No hay carreras registradas para esta facultad.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <a href="index.jsp" class="volver">&#8592; Volver al Inicio</a>
    </div>

    <!-- 1. MODAL PARA AGREGAR NUEVA CARRERA -->
    <div id="modalAgregar" class="modal">
        <div class="modal-content">
            <h3 style="border-bottom: 2px solid #27ae60;">Registrar Nueva Carrera</h3>
            <form action="AgregarCarrera" method="POST">
                <!-- Se envía el id de la facultad actual de forma oculta -->
                <input type="hidden" name="idFacultad" value="${facultad.idfacultad}">

                <div class="form-group">
                    <label for="nombreNuevaCarrera">Nombre de la Carrera:</label>
                    <input type="text" id="nombreNuevaCarrera" name="nombreCarrera" required 
                           placeholder="Ej: Licenciatura en Sistemas">
                </div>

                <div class="modal-actions">
                    <button type="button" class="btn btn-cancel" onclick="cerrarModal('modalAgregar')">Cancelar</button>
                    <button type="submit" class="btn btn-add">Guardar Carrera</button>
                </div>
            </form>
        </div>
    </div>

    <!-- 2. MODAL PARA MODIFICAR CARRERA EXISTENTE -->
    <div id="modalEditar" class="modal">
        <div class="modal-content">
            <h3 style="border-bottom: 2px solid #2980b9;">Modificar Carrera</h3>
            <form action="ModificarCarrera" method="POST">
                <input type="hidden" id="modalIdCarrera" name="idCarrera">
                <input type="hidden" name="idFacultad" value="${facultad.idfacultad}">

                <div class="form-group">
                    <label>Código:</label>
                    <input type="text" id="modalIdCarreraVisible" disabled style="background-color: #eee;">
                </div>

                <div class="form-group">
                    <label for="modalNombre">Nombre de la Carrera:</label>
                    <input type="text" id="modalNombre" name="nombreCarrera" required>
                </div>

                <div class="modal-actions">
                    <button type="button" class="btn btn-cancel" onclick="cerrarModal('modalEditar')">Cancelar</button>
                    <button type="submit" class="btn btn-edit">Guardar Cambios</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function confirmarEliminacion(nombreCarrera) {
            return confirm("¿Está seguro de que desea eliminar la carrera '" + nombreCarrera + "'?");
        }

        // Modal Agregar
        function abrirModalAgregar() {
            document.getElementById("nombreNuevaCarrera").value = "";
            document.getElementById("modalAgregar").style.display = "flex";
            document.getElementById("nombreNuevaCarrera").focus();
        }

        // Modal Modificar
        function abrirModalModificar(id, nombre) {
            document.getElementById("modalIdCarrera").value = id;
            document.getElementById("modalIdCarreraVisible").value = id;
            document.getElementById("modalNombre").value = nombre;
            document.getElementById("modalEditar").style.display = "flex";
            document.getElementById("modalNombre").focus();
        }

        // Cierre genérico de modales
        function cerrarModal(idModal) {
            document.getElementById(idModal).style.display = "none";
        }

        // Cierra al hacer clic en el fondo oscuro
        window.onclick = function(event) {
            var modalAdd = document.getElementById("modalAgregar");
            var modalEdit = document.getElementById("modalEditar");
            if (event.target === modalAdd) {
                modalAdd.style.display = "none";
            }
            if (event.target === modalEdit) {
                modalEdit.style.display = "none";
            }
        };
    </script>

</body>
</html>