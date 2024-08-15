package com.utez.edu.almacen.models.area;

import com.utez.edu.almacen.models.metric.BeanMetric;
import com.utez.edu.almacen.models.metric.DaoMetric;
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
                area.setStatus(rs.getBoolean("status"));
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
                area.setStatus(rs.getBoolean("status"));
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
            String query = "INSERT INTO areas(name, description, shortName, status) VALUES(?, ?, ?, ?);";
            ps = conn.prepareStatement(query);
            ps.setString(1, object.getName());
            ps.setString(2, object.getDescription());
            ps.setString(3, object.getShortName());
            ps.setBoolean(4, object.getStatus());
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
            String query = "UPDATE areas SET name = ?, description = ?, shortName = ?, status = ? WHERE id_area = ?;";
            ps = conn.prepareStatement(query);
            ps.setString(1, object.getName());
            ps.setString(2, object.getDescription());
            ps.setString(3, object.getShortName());
            ps.setBoolean(4, object.getStatus());
            ps.setLong(5, object.getId());
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

    public boolean changeStatus(Long areaId){
        try {
            String query = "UPDATE areas SET status = NOT status WHERE id_area = ?;";
            ps = conn.prepareStatement(query);
            ps.setLong(1, areaId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR. Function change status failed: " + e.getMessage());
            return false;
        } finally {
            closeConnection();
        }
    }

    public List<BeanArea> search(String name, String shortName, String status){
        List<BeanArea> areas = new ArrayList<>();
        int count = 1;
        try {
            Boolean status2 = false;
            if (status != null && (status.equals("Activo") || status.equals("Inactivo"))) {
                if (status.equals("Activo")){
                    status2 = true;
                } else if (status.equals("Inactivo")){
                    status2 = false;
                }
            }
            conn = new MySQLConnection().getConnection();
            StringBuilder query = new StringBuilder("SELECT * FROM areas WHERE 1=1");


            if (shortName != null && !shortName.isEmpty()) {
                query.append(" AND shortName = ?");
            }
            if (name != null && !name.isEmpty()) {
                query.append(" AND name LIKE ?");
            }
            if (status != null && (status.equals("Activo") || status.equals("Inactivo"))) {
                query.append(" AND status = ?");
            }else {
                query.append(" AND (status = ? OR status = ?)");
            }



            ps = conn.prepareStatement(query.toString());

            if (shortName != null && !shortName.isEmpty()) {
                ps.setString(count++, shortName);
            }
            if (name != null && !name.isEmpty()) {
                ps.setString(count++, "%" + name + "%");
            }
            if (status != null && (status.equals("Activo") || status.equals("Inactivo"))) {
                ps.setBoolean(count++, status2);
            }else {
                ps.setBoolean(count++, true);
                ps.setBoolean(count++, false);
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                BeanArea area = new BeanArea();
                area.setId(rs.getLong(1));
                area.setShortName(rs.getString(2));
                area.setName(rs.getString(3));
                area.setDescription(rs.getString(4));
                area.setStatus(rs.getBoolean(5));

                areas.add(area);
            }
        }catch(SQLException e){
            Logger.getLogger(DaoArea.class.getName()).log(Level.SEVERE, "ERROR. Function search failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return areas;
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
