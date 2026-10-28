/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entidad;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author carlos
 */
@Embeddable
public class ExamenPK implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "materia_idmateria", nullable = false)
    private int materiaIdmateria;
    @Basic(optional = false)
    @NotNull
    @Column(name = "alumno_id", nullable = false)
    private int alumnoId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date fecha;

    public ExamenPK() {
    }

    public ExamenPK(int materiaIdmateria, int alumnoId, Date fecha) {
        this.materiaIdmateria = materiaIdmateria;
        this.alumnoId = alumnoId;
        this.fecha = fecha;
    }

    public int getMateriaIdmateria() {
        return materiaIdmateria;
    }

    public void setMateriaIdmateria(int materiaIdmateria) {
        this.materiaIdmateria = materiaIdmateria;
    }

    public int getAlumnoId() {
        return alumnoId;
    }

    public void setAlumnoId(int alumnoId) {
        this.alumnoId = alumnoId;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) materiaIdmateria;
        hash += (int) alumnoId;
        hash += (fecha != null ? fecha.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ExamenPK)) {
            return false;
        }
        ExamenPK other = (ExamenPK) object;
        if (this.materiaIdmateria != other.materiaIdmateria) {
            return false;
        }
        if (this.alumnoId != other.alumnoId) {
            return false;
        }
        if ((this.fecha == null && other.fecha != null) || (this.fecha != null && !this.fecha.equals(other.fecha))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidad.ExamenPK[ materiaIdmateria=" + materiaIdmateria + ", alumnoId=" + alumnoId + ", fecha=" + fecha + " ]";
    }
    
}