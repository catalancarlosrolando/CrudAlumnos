/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import entidad.Carrera;
import entidad.Facultad;
import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sesiones.CarreraFacade;
import sesiones.FacultadFacade;

/**
 *
 * @author carlos
 */
@WebServlet(name = "FacultadServlet", urlPatterns = {"/Facultad", "/AgregarCarrera", "/ModificarCarrera", "/EliminarCarrera"})
public class FacultadServlet extends HttpServlet {

    @EJB
    private FacultadFacade facu;
    
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
            case "/Facultad":
                Integer nroFacultad = Integer.parseInt(request.getParameter("codigoFacu"));
                Facultad miFacu = facu.findFresh(nroFacultad);
                request.setAttribute("facultad", miFacu);
                request.getRequestDispatcher("/WEB-INF/vista/ListarCarreras.jsp").forward(request, response);
                break;

            case "/AgregarCarrera":
                String nombreNuevaCarrera = request.getParameter("nombreCarrera");
                Integer idFacultadAsociada = Integer.parseInt(request.getParameter("idFacultad"));
                Facultad facuPadre = facu.find(idFacultadAsociada);

                if (facuPadre != null && nombreNuevaCarrera != null && !nombreNuevaCarrera.trim().isEmpty()) {
                    Carrera nuevaCarrera = new Carrera();
                    nuevaCarrera.setNombre(nombreNuevaCarrera);
                    nuevaCarrera.setFacultadIdfacultad(facuPadre);
                    carreraFacade.create(nuevaCarrera);
                }
                response.sendRedirect("Facultad?codigoFacu=" + idFacultadAsociada);
                break;

            case "/ModificarCarrera":
                Integer idModificar = Integer.parseInt(request.getParameter("idCarrera"));
                String nuevoNombre = request.getParameter("nombreCarrera");
                Integer idFacuMod = Integer.parseInt(request.getParameter("idFacultad"));

                Carrera carreraAEditar = carreraFacade.find(idModificar);
                if (carreraAEditar != null) {
                    carreraAEditar.setNombre(nuevoNombre);
                    carreraFacade.edit(carreraAEditar);
                }
                response.sendRedirect("Facultad?codigoFacu=" + idFacuMod);
                break;

            case "/EliminarCarrera":
                Integer idEliminar = Integer.parseInt(request.getParameter("idCarrera"));
                Integer idFacuElim = Integer.parseInt(request.getParameter("idFacultad"));

                try {
                    Carrera carreraABorrar = carreraFacade.find(idEliminar);
                    if (carreraABorrar != null) {
                        carreraFacade.remove(carreraABorrar);
                    }
                } catch (Exception e) {
                    System.err.println("Error al eliminar carrera: " + e.getMessage());
                }
                response.sendRedirect("Facultad?codigoFacu=" + idFacuElim);
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
