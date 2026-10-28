<%--
    Document   : header
    Created on  : 27 oct 2026
    Author      : carlos
    Descripción : Componente reutilizable de cabecera (logo + título + navbar).
    Dependencias:
        - ${facultades} en request scope (List<Facultad>) cargado por un servlet.
        - CSS: base.css, layout.css, components.css, pages/index.css
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- ===== HEADER ===== -->
<div class="page-wrapper">

    <!-- Icono de Llama Roja Superior -->
    <div class="brand-flame">
        <svg viewBox="0 0 100 130" xmlns="http://www.w3.org/2000/svg">
            <defs>
                <linearGradient id="flameGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                    <stop offset="0%" stop-color="#b42323"/>
                    <stop offset="45%" stop-color="#801313"/>
                    <stop offset="70%" stop-color="#d93b3b"/>
                    <stop offset="100%" stop-color="#f27d7d"/>
                </linearGradient>
                <linearGradient id="flameInner" x1="0%" y1="0%" x2="100%" y2="100%">
                    <stop offset="0%" stop-color="#ffffff"/>
                    <stop offset="60%" stop-color="#ffb8b8"/>
                    <stop offset="100%" stop-color="#b42323"/>
                </linearGradient>
            </defs>
            <!-- Llama externa -->
            <path d="M 52,5 C 50,28 32,45 42,68 C 45,74 53,82 50,95 C 47,108 34,118 48,124 C 33,120 28,102 32,88 C 36,73 22,58 35,32 C 40,21 48,12 52,5 Z" fill="url(#flameGrad)"/>
            <!-- Detalle de luz interno -->
            <path d="M 50,22 C 48,38 38,52 44,66 C 46,71 52,78 49,87 C 45,80 43,72 40,65 C 36,54 44,38 50,22 Z" fill="url(#flameInner)" opacity="0.85"/>
        </svg>
    </div>

    <!-- Título SISTEMA ALUMNOS -->
    <header class="site-title">
        <h1 class="title-sistema">SISTEMA</h1>
        <h2 class="title-alumnos">ALUMNOS</h2>
    </header>

    <!-- Barra de Navegación -->
    <nav class="navbar">
        <ul class="nav-links">
            <li><a href="index.jsp">Inicio</a></li>

            <!-- Facultades (dropdown dinámico desde servlet) -->
            <li class="dropdown">
                <a href="javascript:void(0)" class="dropbtn">Facultades &#9660;</a>
                <ul class="dropdown-content">
                    <c:forEach var="facu" items="${facultades}">
                        <li>
                            <a href="Facultad?codigoFacu=${facu.idfacultad}">${facu.nombre}</a>
                        </li>
                    </c:forEach>
                </ul>
            </li>

            <!-- Docentes -->
            <li class="dropdown">
                <a href="javascript:void(0)" class="dropbtn">Docentes</a>
                <ul class="dropdown-content">
                    <li><a href="ListarDocentes">Listar Docentes</a></li>
                </ul>
            </li>

            <!-- Alumnos -->
            <li class="dropdown">
                <a href="javascript:void(0)" class="dropbtn">Alumnos &#9660;</a>
                <ul class="dropdown-content">
                    <li><a href="Agregar">Agregar</a></li>
                    <li><a href="Listar">Listar</a></li>
                </ul>
            </li>

            <!-- Materias -->
            <li><a href="ListarMaterias">Materias</a></li>

            <!-- Mesas -->
            <li class="dropdown">
                <a href="javascript:void(0)" class="dropbtn">Mesas</a>
                <ul class="dropdown-content">
                    <li><a href="ListarMesas">Filtrar Mesas (Mes / Año)</a></li>
                    <li><a href="ReporteAlumnosSinRendir">Alumnos Sin Rendir (Año Actual)</a></li>
                </ul>
            </li>
        </ul>
    </nav>

    <!-- ===== FIN HEADER — el contenido de cada página va a continuación ===== -->