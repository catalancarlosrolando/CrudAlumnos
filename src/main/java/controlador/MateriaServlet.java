/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controlador;

import entidad.Materia;
import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sesiones.MateriaFacade;

/**
 *
 * @author carlos
 */
@WebServlet(name = "MateriaServlet", urlPatterns = {"/ListarMaterias", "/AgregarMateria", "/ModificarMateria", "/EliminarMateria"})
public class MateriaServlet extends HttpServlet {
    
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
            case "/ListarMaterias":
                request.setAttribute("listaMaterias", materiaFacade.findAll());
                request.getRequestDispatcher("/WEB-INF/vista/ListarMaterias.jsp").forward(request, response);
                break;

            case "/AgregarMateria":
                String nombreNuevaMateria = request.getParameter("nombre");
                if (nombreNuevaMateria != null && !nombreNuevaMateria.trim().isEmpty()) {
                    Materia nuevaMateria = new Materia();
                    nuevaMateria.setNombre(nombreNuevaMateria);
                    materiaFacade.create(nuevaMateria);
                }
                response.sendRedirect("ListarMaterias");
                break;

            case "/ModificarMateria":
                Integer idMateriaMod = Integer.parseInt(request.getParameter("idMateria"));
                String nuevoNombreMat = request.getParameter("nombre");

                Materia materiaAEditar = materiaFacade.find(idMateriaMod);
                if (materiaAEditar != null && nuevoNombreMat != null && !nuevoNombreMat.trim().isEmpty()) {
                    materiaAEditar.setNombre(nuevoNombreMat);
                    materiaFacade.edit(materiaAEditar);
                }
                response.sendRedirect("ListarMaterias");
                break;

            case "/EliminarMateria":
                Integer idMateriaElim = Integer.parseInt(request.getParameter("idMateria"));
                try {
                    Materia matABorrar = materiaFacade.find(idMateriaElim);
                    if (matABorrar != null) {
                        materiaFacade.remove(matABorrar);
                    }
                } catch (Exception ex) {
                    System.err.println("Error al eliminar materia: " + ex.getMessage());
                }
                response.sendRedirect("ListarMaterias");
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
