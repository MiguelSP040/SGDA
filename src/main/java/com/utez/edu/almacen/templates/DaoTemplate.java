package com.utez.edu.almacen.templates;

import java.util.List;

public interface DaoTemplate<D> {
    List<D> listAll();
    D listOne(Long id);
    boolean save(D object);
    boolean update(D object);
    boolean delete(Long id);
}
