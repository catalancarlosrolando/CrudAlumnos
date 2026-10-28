<%-- 
    Document   : ListarMesas
    Created on : 26 oct 2026, 21:15:38
    Author     : carlos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestión de Mesas de Examen</title>
    <link href="Web-App/css/base.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/layout.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/components.css" rel="stylesheet" type="text/css">
    <link href="Web-App/css/pages/mesas.css" rel="stylesheet" type="text/css"/> 
    <link href="Web-App/css/pages/index.css" rel="stylesheet" type="text/css"/> 
</head>
<body>
<jsp:include page="componentes/header.jsp" />
    <div class="container">
        <div class="header-section">
            <h1>Mesas de Examen</h1>
            <button type="button" class="btn btn-add" onclick="abrirModalAgregar()">+ Nueva Mesa</button>
        </div>

        <!-- Formulario de Filtrado por Mes y Año -->
        <form action="FiltrarMesas" method="GET" class="filter-form">
            <div class="form-group">
                <label for="mes">Mes:</label>
                <select id="mes" name="mes" required>
                    <option value="">Seleccione mes...</option>
                    <option value="1" ${filtroMes == 1 ? 'selected' : ''}>Enero</option>
                    <option value="2" ${filtroMes == 2 ? 'selected' : ''}>Febrero</option>
                    <option value="3" ${filtroMes == 3 ? 'selected' : ''}>Marzo</option>
                    <option value="4" ${filtroMes == 4 ? 'selected' : ''}>Abril</option>
                    <option value="5" ${filtroMes == 5 ? 'selected' : ''}>Mayo</option>
                    <option value="6" ${filtroMes == 6 ? 'selected' : ''}>Junio</option>
                    <option value="7" ${filtroMes == 7 ? 'selected' : ''}>Julio</option>
                    <option value="8" ${filtroMes == 8 ? 'selected' : ''}>Agosto</option>
                    <option value="9" ${filtroMes == 9 ? 'selected' : ''}>Septiembre</option>
                    <option value="10" ${filtroMes == 10 ? 'selected' : ''}>Octubre</option>
                    <option value="11" ${filtroMes == 11 ? 'selected' : ''}>Noviembre</option>
                    <option value="12" ${filtroMes == 12 ? 'selected' : ''}>Diciembre</option>
                </select>
            </div>

            <div class="form-group">
                <label for="anio">Año:</label>
                <select id="anio" name="anio" required>
                    <option value="">Seleccione año...</option>
                    <option value="2024" ${filtroAnio == 2024 ? 'selected' : ''}>2024</option>
                    <option value="2025" ${filtroAnio == 2025 ? 'selected' : ''}>2025</option>
                    <option value="2026" ${filtroAnio == 2026 ? 'selected' : ''}>2026</option>
                </select>
            </div>

            <div>
                <button type="submit" class="btn btn-filter">Filtrar</button>
                <a href="ListarMesas" class="btn btn-reset">Ver Todos</a>
            </div>
        </form>

        <!-- Tabla de Mesas de Examen -->
        <table>
            <thead>
                <tr>
                    <th style="width: 25%;">Fecha y Hora</th>
                    <th style="width: 30%;">Materia</th>
                    <th style="width: 25%;">Alumno</th>
                    <th style="width: 8%;">Nota</th>
                    <th style="width: 12%;">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ex" items="${listaExamenes}">
                    <c:set var="fechaObj" value="${not empty ex.examenPK ? ex.examenPK.fecha : ex.fecha}" />
                    <fmt:formatDate value="${fechaObj}" pattern="yyyy-MM-dd'T'HH:mm" var="fechaFormattedIso" />
                    <fmt:formatDate value="${fechaObj}" pattern="dd/MM/yyyy HH:mm" var="fechaFormattedDisplay" />

                    <tr>
                        <td>${fechaFormattedDisplay}</td>
                        <td>${ex.materia.nombre}</td>
                        <td>${ex.alumno.nombre}</td>
                        <td class="nota">${ex.nota}</td>
                        <td>
                            <button class="btn btn-edit" 
                                    onclick="abrirModalEditar('${ex.alumno.id}', '${ex.alumno.nombre}', '${ex.materia.idmateria}', '${ex.materia.nombre}', '${fechaFormattedIso}', '${ex.nota}')">
                                Editar
                            </button>
                            <a class="btn btn-delete" 
                               href="EliminarMesa?idAlumno=${ex.alumno.id}&idMateria=${ex.materia.idmateria}&fecha=${fechaObj.time}"
                               onclick="return confirm('¿Confirma eliminar la mesa de ${ex.alumno.nombre} en ${ex.materia.nombre}?');">
                                Borrar
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listaExamenes}">
                    <tr>
                        <td colspan="5" style="text-align: center; color: #7f8c8d; padding: 25px;">
                            No se encontraron mesas de examen registradas.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <a href="index.jsp" class="btn-volver">&#8592; Volver al Inicio</a>
    </div>

    <!-- MODAL AGREGAR MESA DE EXAMEN -->
    <div id="modalAgregarMesa" class="modal">
        <div class="modal-content">
            <h3>Registrar Nueva Mesa de Examen</h3>
            <form action="AgregarMesa" method="POST" class="modal-form">
                <div class="form-group">
                    <label for="addIdAlumno">Alumno:</label>
                    <select id="addIdAlumno" name="idAlumno" required>
                        <option value="">Seleccione un alumno...</option>
                        <c:forEach var="alu" items="${listaAlumnos}">
                            <option value="${alu.id}">${alu.nombre} (Registro: ${alu.registro})</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="addIdMateria">Materia:</label>
                    <select id="addIdMateria" name="idMateria" required>
                        <option value="">Seleccione una materia...</option>
                        <c:forEach var="mat" items="${listaMaterias}">
                            <option value="${mat.idmateria}">${mat.nombre}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="addFecha">Fecha y Hora:</label>
                    <input type="datetime-local" id="addFecha" name="fecha" required>
                </div>

                <div class="form-group">
                    <label for="addNota">Nota Obtenida (1 a 10):</label>
                    <input type="number" id="addNota" name="nota" min="1" max="10" required placeholder="Ej: 8">
                </div>

                <div class="modal-actions">
                    <button type="button" class="btn btn-cancel" onclick="cerrarModal('modalAgregarMesa')">Cancelar</button>
                    <button type="submit" class="btn btn-add">Guardar Mesa</button>
                </div>
            </form>
        </div>
    </div>

    <!-- MODAL MODIFICAR NOTA DE MESA -->
    <div id="modalEditarMesa" class="modal">
        <div class="modal-content edit-header">
            <h3>Modificar Calificación</h3>
            <form action="ModificarMesa" method="POST" class="modal-form">
                <input type="hidden" id="editIdAlumno" name="idAlumno">
                <input type="hidden" id="editIdMateria" name="idMateria">
                <input type="hidden" id="editFecha" name="fecha">

                <div class="form-group">
                    <label>Alumno:</label>
                    <input type="text" id="editAlumnoNombre" disabled style="background-color: #eee;">
                </div>

                <div class="form-group">
                    <label>Materia:</label>
                    <input type="text" id="editMateriaNombre" disabled style="background-color: #eee;">
                </div>

                <div class="form-group">
                    <label for="editNota">Nueva Nota (1 a 10):</label>
                    <input type="number" id="editNota" name="nota" min="1" max="10" required>
                </div>

                <div class="modal-actions">
                    <button type="button" class="btn btn-cancel" onclick="cerrarModal('modalEditarMesa')">Cancelar</button>
                    <button type="submit" class="btn btn-filter">Guardar Cambios</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function abrirModalAgregar() {
            document.getElementById("addIdAlumno").selectedIndex = 0;
            document.getElementById("addIdMateria").selectedIndex = 0;
            document.getElementById("addFecha").value = "";
            document.getElementById("addNota").value = "";
            document.getElementById("modalAgregarMesa").style.display = "flex";
        }

        function abrirModalEditar(id, nombreAlumno, idMateria, nombreMateria, fechaIso, nota) {
            document.getElementById("editIdAlumno").value = id;
            document.getElementById("editAlumnoNombre").value = nombreAlumno;
            document.getElementById("editIdMateria").value = idMateria;
            document.getElementById("editMateriaNombre").value = nombreMateria;
            document.getElementById("editFecha").value = fechaIso;
            document.getElementById("editNota").value = nota;

            document.getElementById("modalEditarMesa").style.display = "flex";
            document.getElementById("editNota").focus();
        }

        function cerrarModal(modalId) {
            document.getElementById(modalId).style.display = "none";
        }

        window.onclick = function(event) {
            var modalAdd = document.getElementById("modalAgregarMesa");
            var modalEdit = document.getElementById("modalEditarMesa");
            if (event.target === modalAdd) cerrarModal('modalAgregarMesa');
            if (event.target === modalEdit) cerrarModal('modalEditarMesa');
        };
    </script>
</body>
</html>
