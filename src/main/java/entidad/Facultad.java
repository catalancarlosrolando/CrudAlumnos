/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entidad;

import jakarta.persistence.Basic;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.io.Serializable;
import java.util.Collection;

/**
 *
 * @author carlos
 */
@Entity
@Table(name = "facultad", catalog = "bdalumnos", schema = "")
@NamedQueries({
    @NamedQuery(name = "Facultad.findAll", query = "SELECT f FROM Facultad f"),
    @NamedQuery(name = "Facultad.findByIdfacultad", query = "SELECT f FROM Facultad f WHERE f.idfacultad = :idfacultad"),
    @NamedQuery(name = "Facultad.findByNombre", query = "SELECT f FROM Facultad f WHERE f.nombre = :nombre")})
public class Facultad implements Serializable {

    @Size(max = 45)
    @Column(name = "nombre")
    private String nombre;

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idfacultad", nullable = false)
    private Integer idfacultad;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "facultadIdfacultad")
    private Collection<Carrera> carreraCollection;

    public Facultad() {
    }

    public Facultad(Integer idfacultad) {
        this.idfacultad = idfacultad;
    }

    public Integer getIdfacultad() {
        return idfacultad;
    }

    public void setIdfacultad(Integer idfacultad) {
        this.idfacultad = idfacultad;
    }


    public Collection<Carrera> getCarreraCollection() {
        return carreraCollection;
    }

    public void setCarreraCollection(Collection<Carrera> carreraCollection) {
        this.carreraCollection = carreraCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idfacultad != null ? idfacultad.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facultad)) {
            return false;
        }
        Facultad other = (Facultad) object;
        if ((this.idfacultad == null && other.idfacultad != null) || (this.idfacultad != null && !this.idfacultad.equals(other.idfacultad))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidad.Facultad[ idfacultad=" + idfacultad + " ]";
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    

}
    