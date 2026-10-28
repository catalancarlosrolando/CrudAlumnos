/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sesiones;

import entidad.Examen;
import java.util.List;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

/**
 *
 * @author carlos
 */
@Stateless
public class ExamenFacade extends AbstractFacade<Examen> {

    @PersistenceContext(unitName = "AppAlumnos")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ExamenFacade() {
        super(Examen.class);
    }
    
    
    public List<Examen> findByMes(int mes) {
        return em.createQuery(
            "SELECT e FROM Examen e WHERE EXTRACT(MONTH FROM e.examenPK.fecha) = :mes",
            Examen.class)
            .setParameter("mes", mes)
            .getResultList();
    }
    
    public List<Examen> findByMesYAnio(int mes, int anio) {
    java.util.Calendar cal = java.util.Calendar.getInstance();
    
    // Inicio del mes (Día 1 a las 00:00:00)
    cal.set(anio, mes - 1, 1, 0, 0, 0);
    cal.set(java.util.Calendar.MILLISECOND, 0);
    java.util.Date inicio = cal.getTime();

    // Fin del mes (Último día del mes a las 23:59:59)
    cal.set(anio, mes - 1, cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH), 23, 59, 59);
    cal.set(java.util.Calendar.MILLISECOND, 999);
    java.util.Date fin = cal.getTime();

    // Nota: Ajustar a "e.examenPK.fecha" si tu clave es compuesta, o "e.fecha" si es directa
    String jpql = "SELECT e FROM Examen e WHERE e.examenPK.fecha BETWEEN :inicio AND :fin";
    
    jakarta.persistence.TypedQuery<Examen> query = getEntityManager().createQuery(jpql, Examen.class);
    query.setParameter("inicio", inicio);
    query.setParameter("fin", fin);

    return query.getResultList();
}
    
}
