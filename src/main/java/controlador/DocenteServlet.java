/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import entidad.Docente;
import entidad.Materia;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sesiones.DocenteFacade;
import sesiones.MateriaFacade;

/**
 *
 * @author carlos
 */
@WebServlet(name = "DocenteServlet", urlPatterns = {
    "/ListarDocentes", 
    "/AgregarDocenteForm", 
    "/AgregarDocente", 
    "/ModificarDocente", 
    "/EliminarDocente",
    "/FiltrarDocente"
})
public class DocenteServlet extends HttpServlet {

    @EJB
    private DocenteFacade docenteFacade;
    
    @EJB
    private MateriaFacade materiaFacade;

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
            case "/ListarDocentes":
                request.setAttribute("listaDocentes", docenteFacade.findAll());
                // Pasamos también la lista de materias para alimentar los modales o formularios de edición
                request.setAttribute("listaMaterias", materiaFacade.findAll());
                request.getRequestDispatcher("/WEB-INF/vista/ListarDocentes.jsp").forward(request, response);
                break;

            case "/AgregarDocenteForm":
                request.setAttribute("listaMaterias", materiaFacade.findAll());
                request.getRequestDispatcher("/WEB-INF/vista/AgregarDocente.jsp").forward(request, response);
                break;

            case "/AgregarDocente":
                String nombre = request.getParameter("nombre");
                String cargo = request.getParameter("cargo");
                String[] materiasIds = request.getParameterValues("materiasIds"); // IDs seleccionados en checkboxes o select múltiple

                Docente nuevoDocente = new Docente();
                nuevoDocente.setNombre(nombre);
                nuevoDocente.setCargo(cargo);

                // Mapear materias seleccionadas a la colección
                List<Materia> materiasAsignadas = new ArrayList<>();
                if (materiasIds != null) {
                    for (String idStr : materiasIds) {
                        Integer idMat = Integer.parseInt(idStr);
                        Materia mat = materiaFacade.find(idMat);
                        if (mat != null) {
                            materiasAsignadas.add(mat);
                        }
                    }
                }
                nuevoDocente.setMateriaCollection(materiasAsignadas);

                docenteFacade.create(nuevoDocente);
                response.sendRedirect("ListarDocentes");
                break;

            case "/ModificarDocente":
                Integer idDocenteMod = Integer.parseInt(request.getParameter("iddocente"));
                String nuevoNombre = request.getParameter("nombre");
                String nuevoCargo = request.getParameter("cargo");
                String[] idsMateriasMod = request.getParameterValues("materiasIds");

                Docente docenteAEditar = docenteFacade.find(idDocenteMod);
                if (docenteAEditar != null) {
                    docenteAEditar.setNombre(nuevoNombre);
                    docenteAEditar.setCargo(nuevoCargo);

                    List<Materia> nuevasMaterias = new ArrayList<>();
                    if (idsMateriasMod != null) {
                        for (String idStr : idsMateriasMod) {
                            Materia mat = materiaFacade.find(Integer.parseInt(idStr));
                            if (mat != null) {
                                nuevasMaterias.add(mat);
                            }
                        }
                    }
                    docenteAEditar.setMateriaCollection(nuevasMaterias);
                    docenteFacade.edit(docenteAEditar);
                }
                response.sendRedirect("ListarDocentes");
                break;

            case "/EliminarDocente":
                Integer idDocenteElim = Integer.parseInt(request.getParameter("iddocente"));
                try {
                    Docente docenteABorrar = docenteFacade.find(idDocenteElim);
                    if (docenteABorrar != null) {
                        docenteFacade.remove(docenteABorrar);
                    }
                } catch (Exception ex) {
                    System.err.println("Error al eliminar docente: " + ex.getMessage());
                }
                response.sendRedirect("ListarDocentes");
                break;
            
            case "/FiltrarDocente":
                int cantidad = Integer.parseInt(request.getParameter("cantidad"));
                if (cantidad >= 2)
                {
                    
                    request.setAttribute("listaDocentes", docenteFacade.findDocentesMasDeDosMaterias(cantidad));

                }
                request.setAttribute("listaMaterias", materiaFacade.findAll());
                request.getRequestDispatcher("/WEB-INF/vista/ListarDocentes.jsp").forward(request, response);
            
                
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
