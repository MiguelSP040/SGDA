package com.utez.edu.almacen.models.metric;

import com.utez.edu.almacen.models.product.BeanProduct;
import com.utez.edu.almacen.models.product.DaoProduct;
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

public class DaoMetric implements DaoTemplate<BeanMetric> {
    private Connection conn = new MySQLConnection().getConnection();
    private PreparedStatement ps;
    private ResultSet rs;

    @Override
    public List<BeanMetric> listAll() {
        List<BeanMetric> metrics = null;
        try {
            metrics = new ArrayList<>();
            String query = "SELECT * FROM metrics;";
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                BeanMetric metric = new BeanMetric();
                metric.setId(rs.getLong("id_metric"));
                metric.setName(rs.getString("name"));
                metric.setShortName(rs.getString("shortName"));
                metric.setStatus(rs.getBoolean("status"));
                metrics.add(metric);
            }
        }catch (SQLException e){
            Logger.getLogger(DaoMetric.class.getName()).log(Level.SEVERE, "ERROR. Function listAll failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return metrics;
    }

    @Override
    public BeanMetric listOne(Long id) {
        try {
            String query = "SELECT * FROM metrics WHERE id_metric = ?;";
            ps = conn.prepareStatement(query);
            ps.setLong(1, id);
            rs = ps.executeQuery();
            BeanMetric metric = new BeanMetric();
            if (rs.next()){
                metric.setId(rs.getLong("id_metric"));
                metric.setName(rs.getString("name"));
                metric.setShortName(rs.getString("shortName"));
                metric.setStatus(rs.getBoolean("status"));
            }
            return metric;
        }catch (SQLException e){
            Logger.getLogger(DaoMetric.class.getName()).log(Level.SEVERE, "ERROR. Function listOne failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return null;
    }

    @Override
    public boolean save(BeanMetric object) {
        try{
            String query = "INSERT INTO metrics(name, shortName, status) VALUES(?, ?, ?);";
            ps = conn.prepareStatement(query);
            ps.setString(1, object.getName());
            ps.setString(2, object.getShortName());
            ps.setBoolean(3, object.getStatus());
            return ps.executeUpdate() > 0;
        }catch (SQLException e){
            Logger.getLogger(DaoMetric.class.getName()).log(Level.SEVERE, "ERROR. Function save failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return false;
    }

    @Override
    public boolean update(BeanMetric object) {
        try{
            String query = "UPDATE metrics SET name = ?, shortName = ?, status = ? WHERE id_metric = ?;";
            ps = conn.prepareStatement(query);
            ps.setString(1, object.getName());
            ps.setString(2, object.getShortName());
            ps.setBoolean(3, object.getStatus());
            ps.setLong(4, object.getId());
            return ps.executeUpdate() > 0;
        }catch (SQLException e){
            Logger.getLogger(DaoMetric.class.getName()).log(Level.SEVERE, "ERROR. Function update failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return false;
    }

    @Override
    public boolean delete(Long id) {
        try{
           String query = "DELETE FROM metrics WHERE id_metric = ?;";
           ps = conn.prepareStatement(query);
           ps.setLong(1, id);
           return ps.executeUpdate() == 1;
        }catch (SQLException e){
            Logger.getLogger(DaoMetric.class.getName()).log(Level.SEVERE, "ERROR. Function delete failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return false;
    }

    public boolean changeStatus(Long metricId){
        try {
            String query = "UPDATE metrics SET status = NOT status WHERE id_metric = ?;";
            ps = conn.prepareStatement(query);
            ps.setLong(1, metricId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            Logger.getLogger(DaoMetric.class.getName()).log(Level.SEVERE, "ERROR. Function change status failed: " + e.getMessage());
            return false;
        } finally {
            closeConnection();
        }
    }

    public List<BeanMetric> search(String name, String shortName, String status){
        List<BeanMetric> metrics = new ArrayList<>();
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
            StringBuilder query = new StringBuilder("SELECT * FROM metrics WHERE 1=1");


            if (shortName != null && !shortName.isEmpty()) {
                query.append(" AND shortName LIKE ?");
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
                ps.setString(count++,"%" + shortName + "%");
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
                BeanMetric metric = new BeanMetric();
                metric.setId(rs.getLong(1));
                metric.setShortName(rs.getString(2));
                metric.setName(rs.getString(3));
                metric.setStatus(rs.getBoolean(4));

                metrics.add(metric);
            }
        }catch(SQLException e){
            Logger.getLogger(DaoMetric.class.getName()).log(Level.SEVERE, "ERROR. Function search failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return metrics;
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
