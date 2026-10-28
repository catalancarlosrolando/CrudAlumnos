<%--
    Document   : index
    Created on : 19 oct 2026, 12:56:32
    Author     : carlos
    Descripción: Página HOME con carrusel de banners Java.
                 Usa header.jsp y footer.jsp como componentes reutilizables.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sistema Alumnos</title>

        <!-- Fuentes e iconos -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Courier+Prime:wght@400;700&family=Montserrat:wght@700;800;900&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">



        <!-- CSS específico de esta página -->
        <link rel="stylesheet" href="Web-App/css/pages/index.css">
    </head>
    <body class="page-home">

        <!-- ===== HEADER (componente reutilizable) ===== -->
        <jsp:include page="WEB-INF/vista/componentes/header.jsp" />

        <!-- ===== CONTENIDO ESPECÍFICO DE LA PÁGINA ===== -->
        <main class="showcase-slider">

            <!-- Tarjeta 1: Botón Naranja Java -->
            <article class="card-item card-left">
                <a href="#prev" class="carousel-control left" aria-label="Anterior">
                    <i class="fa-solid fa-chevron-left"></i>
                </a>
                <div class="badge-java">
                    <div class="badge-content">
                        <svg viewBox="0 0 100 120" xmlns="http://www.w3.org/2000/svg">
                            <path d="M 45,15 Q 40,28 47,38 T 46,55" fill="none" stroke="#ffffff" stroke-width="3.5" stroke-linecap="round"/>
                            <path d="M 55,8 Q 62,24 53,36 T 58,55" fill="none" stroke="#ffffff" stroke-width="4" stroke-linecap="round"/>
                            <path d="M 36,25 Q 30,35 37,45" fill="none" stroke="#ffffff" stroke-width="3" stroke-linecap="round"/>
                            <path d="M 28,60 L 68,60 C 68,78 62,86 48,86 C 34,86 28,78 28,60 Z" fill="none" stroke="#ffffff" stroke-width="4"/>
                            <path d="M 68,64 C 76,64 78,74 68,78" fill="none" stroke="#ffffff" stroke-width="3.5"/>
                            <path d="M 22,92 C 38,98 58,98 74,92" fill="none" stroke="#ffffff" stroke-width="4" stroke-linecap="round"/>
                        </svg>
                        <div class="badge-text">Java<sup>TM</sup></div>
                    </div>
                </div>
            </article>

            <!-- Tarjeta 2: Bosquejo Clásico de Java -->
            <article class="card-item card-center">
                <div class="java-sketch-logo">
                    <svg width="150" height="150" viewBox="0 0 160 170" xmlns="http://www.w3.org/2000/svg">
                        <!-- Humo / Vapores (rojos) -->
                        <g stroke="#b81b2e" fill="none" stroke-linecap="round">
                            <path d="M 78,12 C 86,22 83,38 73,48 C 66,55 72,66 79,72" stroke-width="2.6"/>
                            <path d="M 68,20 C 60,30 63,40 70,50 C 76,60 74,70 65,76" stroke-width="2.4"/>
                            <path d="M 90,26 C 98,38 95,50 86,60 C 82,65 83,72 87,76" stroke-width="2.2"/>
                            <path d="M 60,35 C 53,42 56,52 64,59" stroke-width="2"/>
                            <path d="M 98,40 C 105,48 100,58 92,67" stroke-width="2"/>
                        </g>
                        <!-- Taza estilo sketch (azules) -->
                        <g stroke="#2f5b88" fill="none" stroke-linecap="round">
                            <path d="M 52,78 C 70,72 102,72 120,78 C 122,81 106,85 86,85 C 62,85 50,81 52,78 Z" stroke-width="2.8"/>
                            <path d="M 56,82 C 72,78 98,78 114,82" stroke-width="1.8"/>
                            <path d="M 53,82 C 55,98 62,110 84,112 C 105,114 116,104 118,82" stroke-width="2.6"/>
                            <path d="M 58,88 C 62,102 70,108 86,108 C 102,108 110,98 114,88" stroke-width="2"/>
                            <path d="M 62,96 C 72,105 96,105 106,96" stroke-width="1.6"/>
                            <path d="M 44,112 C 68,104 108,104 128,112 C 114,119 72,122 44,112 Z" stroke-width="2.6"/>
                            <path d="M 40,116 C 66,122 106,122 132,116" stroke-width="2.2"/>
                            <path d="M 52,119 C 75,125 98,125 120,119" stroke-width="1.6"/>
                        </g>
                    </svg>
                    <div class="java-classic-title">JAVA<sup>TM</sup></div>
                </div>
            </article>

            <!-- Tarjeta 3: Java Web Services -->
            <article class="card-item card-right">
                <a href="#next" class="carousel-control right" aria-label="Siguiente">
                    <i class="fa-solid fa-chevron-right"></i>
                </a>
                <div class="ws-top">
                    <svg viewBox="0 0 100 120" xmlns="http://www.w3.org/2000/svg">
                        <defs>
                            <linearGradient id="cupGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                                <stop offset="0%" stop-color="#f5a04e"/>
                                <stop offset="100%" stop-color="#df7220"/>
                            </linearGradient>
                        </defs>
                        <path d="M 45,15 Q 40,28 47,38 T 46,55" fill="none" stroke="url(#cupGrad)" stroke-width="4.5" stroke-linecap="round"/>
                        <path d="M 56,8 Q 64,24 54,36 T 59,55" fill="none" stroke="url(#cupGrad)" stroke-width="5" stroke-linecap="round"/>
                        <path d="M 35,26 Q 28,36 36,46" fill="none" stroke="url(#cupGrad)" stroke-width="4" stroke-linecap="round"/>
                        <path d="M 26,62 L 72,62 C 72,82 64,90 49,90 C 33,90 26,82 26,62 Z" fill="none" stroke="url(#cupGrad)" stroke-width="5"/>
                        <path d="M 72,66 C 81,66 83,76 72,81" fill="none" stroke="url(#cupGrad)" stroke-width="4"/>
                        <path d="M 18,97 C 36,104 60,104 78,97" fill="none" stroke="url(#cupGrad)" stroke-width="5" stroke-linecap="round"/>
                    </svg>
                    <span class="ws-java-text">Java</span>
                </div>
                <div class="ws-bottom-banner">
                    <span>Web Services</span>
                </div>
            </article>

        </main>

        <!-- ===== FOOTER (componente reutilizable) ===== -->
        <jsp:include page="WEB-INF/vista/componentes/footer.jsp" />

    </body>
</html>