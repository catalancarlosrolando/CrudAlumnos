/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import entidad.Alumno;
import entidad.Carrera;
import java.io.IOException;
import java.util.List;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sesiones.AlumnoFacade;
import sesiones.CarreraFacade;

/**
 *
 * @author carlos
 */
@WebServlet(name = "AlumnoServlet", urlPatterns = {"/Listar", "/Agregar", "/AgregarAlumno", "/ModificarAlumno", "/EliminarAlumno"})
public class AlumnoServlet extends HttpServlet {

    @EJB
    private AlumnoFacade alumnoFacade;
    
    @EJB
    private CarreraFacade carreraFacade;

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
            case "/Listar":
                List<Alumno> listaAlumnos = alumnoFacade.findAll();
                request.setAttribute("lista", listaAlumnos);
                List<Carrera> listasCarreras = carreraFacade.findAll();
                request.setAttribute("listacarrera", listasCarreras);
                request.getRequestDispatcher("/WEB-INF/vista/ListarAlumnos.jsp").forward(request, response);
                break;

            case "/Agregar":
                List<Carrera> listaCarreras = carreraFacade.findAll();
                request.setAttribute("lista", listaCarreras);
                request.getRequestDispatcher("/WEB-INF/vista/AgregarAlumno.jsp").forward(request, response);
                break;

            case "/AgregarAlumno":
                String nombre = request.getParameter("nombre");
                String registro = request.getParameter("registro");
                Integer idCarrera = Integer.parseInt(request.getParameter("idCarrera"));

                Carrera carreraSeleccionada = carreraFacade.find(idCarrera);
                Alumno nuevoAlumno = new Alumno();
                nuevoAlumno.setNombre(nombre);
                nuevoAlumno.setRegistro(Integer.parseInt(registro));
                nuevoAlumno.setCarreraIdcarrera(carreraSeleccionada);

                alumnoFacade.create(nuevoAlumno);
                response.sendRedirect("Listar");
                break;

            case "/ModificarAlumno":
                Integer idAluModificar = Integer.parseInt(request.getParameter("idAlumno"));
                String nuevoNombreAlu = request.getParameter("nombre");
                String nuevoRegistroAlu = request.getParameter("registro");
                Integer idNuevaCarrera = Integer.parseInt(request.getParameter("idCarrera"));

                Alumno aluAEditar = alumnoFacade.find(idAluModificar);
                Carrera carreraSeleccionadaAlu = carreraFacade.find(idNuevaCarrera);

                if (aluAEditar != null && carreraSeleccionadaAlu != null) {
                    aluAEditar.setNombre(nuevoNombreAlu);
                    aluAEditar.setRegistro(Integer.parseInt(nuevoRegistroAlu));
                    aluAEditar.setCarreraIdcarrera(carreraSeleccionadaAlu);
                    alumnoFacade.edit(aluAEditar);
                }
                response.sendRedirect("Listar");
                break;

            case "/EliminarAlumno":
                Integer idAluEliminar = Integer.parseInt(request.getParameter("idAlumno"));
                try {
                    Alumno aluABorrar = alumnoFacade.find(idAluEliminar);
                    if (aluABorrar != null) {
                        alumnoFacade.remove(aluABorrar);
                    }
                } catch (Exception ex) {
                    System.err.println("Error al eliminar alumno: " + ex.getMessage());
                }
                response.sendRedirect("Listar");
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
