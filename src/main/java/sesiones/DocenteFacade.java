/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sesiones;

import entidad.Docente;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;
import jakarta.persistence.TypedQuery;

/**
 *
 * @author carlos
 */
@Stateless
public class DocenteFacade extends AbstractFacade<Docente> {

    @PersistenceContext(unitName = "AppAlumnos")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public DocenteFacade() {
        super(Docente.class);
    }
    
    public List<Docente> findDocentesMasDeDosMaterias(int cantidad) {
        return em.createQuery(
                "SELECT d FROM Docente d " +
                "JOIN d.materiaCollection m " +
                "GROUP BY d.iddocente " +
                "HAVING COUNT(m) > :cant",
                Docente.class)
            .setParameter("cant", (long) cantidad) // <-- Casteamos a long para que coincida con el COUNT
            .getResultList();
    }
    
}
