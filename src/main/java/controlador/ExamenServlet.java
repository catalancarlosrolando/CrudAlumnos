/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import entidad.Alumno;
import entidad.Examen;
import entidad.ExamenPK;
import entidad.Materia;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sesiones.AlumnoFacade;
import sesiones.ExamenFacade;
import sesiones.MateriaFacade;

/**
 *
 * @author carlos
 */
@WebServlet(name = "ExamenServlet", urlPatterns = {
    "/ListarMesas", 
    "/FiltrarMesas", 
    "/AgregarMesaForm",
    "/AgregarMesa",
    "/ModificarMesa",
    "/EliminarMesa",
    "/ReporteAlumnosSinRendir"
})
public class ExamenServlet extends HttpServlet {

    @EJB
    private ExamenFacade examenFacade;
    
    @EJB
    private AlumnoFacade alumnoFacade;
    
    @EJB
    private MateriaFacade materiaFacade;

    private static final SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String path = request.getServletPath();

        switch (path) {
            case "/ListarMesas":
                request.setAttribute("listaExamenes", examenFacade.findAll());
                request.setAttribute("listaAlumnos", alumnoFacade.findAll());
                request.setAttribute("listaMaterias", materiaFacade.findAll());
                request.getRequestDispatcher("/WEB-INF/vista/ListarMesas.jsp").forward(request, response);
                break;

            case "/FiltrarMesas":
                String mesStr = request.getParameter("mes");
                String anioStr = request.getParameter("anio");

                if (mesStr != null && !mesStr.isEmpty() && anioStr != null && !anioStr.isEmpty()) {
                    int mes = Integer.parseInt(mesStr);
                    int anio = Integer.parseInt(anioStr);
                    request.setAttribute("listaExamenes", examenFacade.findByMesYAnio(mes, anio));
                    request.setAttribute("filtroMes", mes);
                    request.setAttribute("filtroAnio", anio);
                } else {
                    request.setAttribute("listaExamenes", examenFacade.findAll());
                }
                request.setAttribute("listaAlumnos", alumnoFacade.findAll());
                request.setAttribute("listaMaterias", materiaFacade.findAll());
                request.getRequestDispatcher("/WEB-INF/vista/ListarMesas.jsp").forward(request, response);
                break;

            case "/AgregarMesaForm":
                request.setAttribute("listaAlumnos", alumnoFacade.findAll());
                request.setAttribute("listaMaterias", materiaFacade.findAll());
                request.getRequestDispatcher("/WEB-INF/vista/AgregarMesa.jsp").forward(request, response);
                break;

            case "/AgregarMesa":
                try {
                    Integer idAlumno = Integer.parseInt(request.getParameter("idAlumno"));
                    Integer idMateria = Integer.parseInt(request.getParameter("idMateria"));
                    Integer nota = Integer.parseInt(request.getParameter("nota"));
                    String fechaStr = request.getParameter("fecha");

                    Date fechaParsed = SDF.parse(fechaStr);
                    Alumno alumno = alumnoFacade.find(idAlumno);
                    Materia materia = materiaFacade.find(idMateria);

                    if (alumno != null && materia != null) {
                        Examen nuevoExamen = new Examen();
                        nuevoExamen.setAlumno(alumno);
                        nuevoExamen.setMateria(materia);
                        nuevoExamen.setNota(nota);
                        nuevoExamen.setFecha(fechaParsed);

                        ExamenPK pk = new ExamenPK(idMateria, idAlumno, fechaParsed);
                        nuevoExamen.setExamenPK(pk);

                        examenFacade.create(nuevoExamen);
                    }
                } catch (ParseException | NumberFormatException e) {
                    System.err.println("Error al registrar mesa de examen: " + e.getMessage());
                }
                response.sendRedirect("ListarMesas");
                break;

            case "/ModificarMesa":
                try {
                    Integer idAlumno = Integer.parseInt(request.getParameter("idAlumno"));
                    Integer idMateria = Integer.parseInt(request.getParameter("idMateria"));
                    Integer nuevaNota = Integer.parseInt(request.getParameter("nota"));
                    String fechaStr = request.getParameter("fecha");

                    Date fechaParsed = SDF.parse(fechaStr);
                    ExamenPK pk = new ExamenPK(idMateria, idAlumno, fechaParsed);
                    Examen examenExistente = examenFacade.find(pk);

                    if (examenExistente != null) {
                        examenExistente.setNota(nuevaNota);
                        examenFacade.edit(examenExistente);
                    }
                } catch (ParseException | NumberFormatException e) {
                    System.err.println("Error al modificar mesa de examen: " + e.getMessage());
                }
                response.sendRedirect("ListarMesas");
                break;

            case "/EliminarMesa":
                try {
                    Integer idAlumno = Integer.parseInt(request.getParameter("idAlumno"));
                    Integer idMateria = Integer.parseInt(request.getParameter("idMateria"));
                    String fechaStr = request.getParameter("fecha");

                    // Parsear Timestamp/Date según cómo provenga el parámetro en milisegundos o formato fecha ISO
                    Date fechaParsed;
                    if (fechaStr.matches("\\d+")) {
                        fechaParsed = new Date(Long.parseLong(fechaStr));
                    } else {
                        fechaParsed = SDF.parse(fechaStr);
                    }

                    ExamenPK pk = new ExamenPK(idMateria, idAlumno, fechaParsed);
                    Examen examenABorrar = examenFacade.find(pk);

                    if (examenABorrar != null) {
                        examenFacade.remove(examenABorrar);
                    }
                } catch (ParseException | NumberFormatException e) {
                    System.err.println("Error al eliminar mesa de examen: " + e.getMessage());
                }
                response.sendRedirect("ListarMesas");
                break;

            case "/ReporteAlumnosSinRendir":
                request.setAttribute("listaAlumnos", alumnoFacade.findAlumnosSinExamenesAnioActual());
                request.getRequestDispatcher("/WEB-INF/vista/ReporteAlumnosSinRendir.jsp").forward(request, response);
                break;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
