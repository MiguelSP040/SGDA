package com.utez.edu.almacen.models.metric;

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
                metric.setStatus(rs.getString("status"));
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
                metric.setStatus(rs.getString("status"));
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
            ps.setString(3, object.getStatus());
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
            ps.setString(3, object.getStatus());
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
