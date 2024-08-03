package com.utez.edu.almacen.models.area;

import com.utez.edu.almacen.models.user.DaoUser;
import com.utez.edu.almacen.templates.DaoTemplate;
import com.utez.edu.almacen.utils.MySQLConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoArea implements DaoTemplate<BeanArea> {
    private Connection conn = new MySQLConnection().getConnection();
    private PreparedStatement ps;
    private ResultSet rs;

    @Override
    public List<BeanArea> listAll() {
        List<BeanArea> areas = null;
        try {
            areas = new ArrayList<>();
            String query = "SELECT * FROM areas;";
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                BeanArea area = new BeanArea();
                area.setId(rs.getLong("id_area"));
                area.setName(rs.getString("name"));
                area.setDescription(rs.getString("description"));
                area.setShortName(rs.getString("shortName"));
                areas.add(area);
            }
        }catch (SQLException e){
            Logger.getLogger(DaoArea.class.getName()).log(Level.SEVERE, "ERROR. Function listAll failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return areas;
    }

    @Override
    public BeanArea listOne(Long id) {
        try {
            String query = "SELECT * FROM areas WHERE id_area = ?;";
            ps = conn.prepareStatement(query);
            ps.setLong(1, id);
            rs = ps.executeQuery();
            BeanArea area = new BeanArea();
            if (rs.next()){
                area.setId(rs.getLong("id_area"));
                area.setName(rs.getString("name"));
                area.setDescription(rs.getString("description"));
                area.setShortName(rs.getString("shortName"));
            }
            return area;
        }catch (SQLException e){
            Logger.getLogger(DaoArea.class.getName()).log(Level.SEVERE, "ERROR. Function findOne failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return null;
    }

    @Override
    public boolean save(BeanArea object) {
        try {
            String query = "INSERT INTO areas(name, description, shortName) VALUES(?, ?, ?);";
            ps = conn.prepareStatement(query);
            //Modificar BD para establecer AUTO_INCREMENT en id
            ps.setString(1, object.getName());
            ps.setString(2, object.getDescription());
            ps.setString(3, object.getShortName());
            return ps.executeUpdate() > 0;
        }catch (SQLException e) {
            Logger.getLogger(DaoArea.class.getName()).log(Level.SEVERE, "ERROR. Function save failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return false;
    }

    @Override
    public boolean update(BeanArea object) {
        try {
            String query = "UPDATE areas SET name = ?, description = ?, shortName = ? WHERE id_area = ?;";
            ps = conn.prepareStatement(query);
            ps.setString(1, object.getName());
            ps.setString(2, object.getDescription());
            ps.setString(3, object.getShortName());
            ps.setLong(4, object.getId());
            return ps.executeUpdate() > 0;
        }catch (SQLException e){
            Logger.getLogger(DaoArea.class.getName()).log(Level.SEVERE, "ERROR. Function update failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return false;
    }

    @Override
    public boolean delete(Long id) {
        try {
            String query = "DELETE FROM areas WHERE id_area = ?;";
            ps = conn.prepareStatement(query);
            ps.setLong(1, id);
            return ps.executeUpdate() == 1;
        }catch (SQLException e){
            Logger.getLogger(DaoArea.class.getName()).log(Level.SEVERE, "ERROR. Function delete failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return false;
    }

    public void closeConnection(){
        try {
            if (conn != null) conn.close();
            if (ps != null) conn.close();
            if (rs != null) conn.close();
        }catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR. Function closeConnection failed" + e.getMessage());
        }
    }

}
