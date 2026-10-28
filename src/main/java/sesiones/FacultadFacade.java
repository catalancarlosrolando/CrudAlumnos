/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sesiones;

import entidad.Facultad;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

/**
 *
 * @author carlos
 */
@Stateless
public class FacultadFacade extends AbstractFacade<Facultad> {

    @PersistenceContext(unitName = "AppAlumnos")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public FacultadFacade() {
        super(Facultad.class);
    }
    
    public Facultad findFresh(Object id) {
    Facultad f = getEntityManager().find(Facultad.class, id);
    if (f != null) {
        getEntityManager().refresh(f); // Obliga a recargar desde la BD y reconstruir sus colecciones
    }
    return f;
    
}
}