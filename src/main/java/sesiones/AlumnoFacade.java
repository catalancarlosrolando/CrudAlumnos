/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sesiones;

import entidad.Alumno;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import java.util.List;

/**
 *
 * @author carlos
 */
@Stateless
public class AlumnoFacade extends AbstractFacade<Alumno> {

    @PersistenceContext(unitName = "AppAlumnos")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public AlumnoFacade() {
        super(Alumno.class);
    }
    
    public List<Alumno> findAlumnosSinExamenesAnioActual() {
    TypedQuery<Alumno> query = getEntityManager().createQuery(
        "SELECT a FROM Alumno a WHERE a.id NOT IN (" +
        "   SELECT e.examenPK.alumnoId FROM Examen e " +
        "   WHERE FUNCTION('YEAR', e.examenPK.fecha) = FUNCTION('YEAR', CURRENT_DATE)" +
        ")", 
        Alumno.class
    );
    return query.getResultList();
}
}
