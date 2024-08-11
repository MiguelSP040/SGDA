package com.utez.edu.almacen.models.product;

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

public class DaoProduct implements DaoTemplate<BeanProduct> {
    private Connection conn = new MySQLConnection().getConnection();
    private PreparedStatement ps;
    private ResultSet rs;

    @Override
    public List<BeanProduct> listAll() {
        List<BeanProduct> products = new ArrayList<>();
        try {
            String query = "SELECT * FROM products;";
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                BeanProduct product = new BeanProduct();
                product.setId(rs.getLong("id_product"));
                product.setName(rs.getString("name"));
                product.setCode(rs.getString("code"));
                product.setDescription(rs.getString("description"));
                product.setId_metric(rs.getString("id_metric"));
                product.setStatus(rs.getBoolean("status"));
                products.add(product);
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoProduct.class.getName()).log(Level.SEVERE, "ERROR. Function listAll failed: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return products;
    }

    @Override
    public BeanProduct listOne(Long id) {
        try {
            String query = "SELECT * FROM products WHERE id_product = ?;";
            ps = conn.prepareStatement(query);
            ps.setLong(1, id);
            rs = ps.executeQuery();
            BeanProduct product = null;
            if (rs.next()) {
                product = new BeanProduct();
                product.setId(rs.getLong("id_product"));
                product.setName(rs.getString("name"));
                product.setCode(rs.getString("code"));
                product.setDescription(rs.getString("description"));
                product.setId_metric(rs.getString("id_metric"));
                product.setStatus(rs.getBoolean("status"));
            }
            return product;
        } catch (SQLException e) {
            Logger.getLogger(DaoProduct.class.getName()).log(Level.SEVERE, "ERROR. Function listOne failed: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return null;
    }

    @Override
    public boolean save(BeanProduct object) {
        try {
            String query = "INSERT INTO products(name, code, description, id_metric, status) VALUES(?, ?, ?, ?, ?);";
            ps = conn.prepareStatement(query);
            ps.setString(1, object.getName());
            ps.setString(2, object.getCode());
            ps.setString(3, object.getDescription());
            ps.setString(4, object.getId_metric());
            ps.setBoolean(5, object.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoProduct.class.getName()).log(Level.SEVERE, "ERROR. Function save failed: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return false;
    }

    @Override
    public boolean update(BeanProduct object) {
        try {
            String query = "UPDATE products SET name = ?, code = ?, description = ?, id_metric = ?, status = ? WHERE id_product = ?;";
            ps = conn.prepareStatement(query);
            ps.setString(1, object.getName());
            ps.setString(2, object.getCode());
            ps.setString(3, object.getDescription());
            ps.setString(4, object.getId_metric());
            ps.setBoolean(5, object.getStatus());
            ps.setLong(6, object.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoProduct.class.getName()).log(Level.SEVERE, "ERROR. Function update failed: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return false;
    }

    @Override
    public boolean delete(Long id) {
        try {
            String query = "DELETE FROM products WHERE id_product = ?;";
            ps = conn.prepareStatement(query);
            ps.setLong(1, id);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            Logger.getLogger(DaoProduct.class.getName()).log(Level.SEVERE, "ERROR. Function delete failed: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return false;
    }

    public boolean changeStatus(Long Id){
        try {
            String query = "UPDATE products SET status = NOT status WHERE id_product = ?;";
            ps = conn.prepareStatement(query);
            ps.setLong(1, Id);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            Logger.getLogger(DaoProduct.class.getName()).log(Level.SEVERE, "ERROR. Function change status failed: " + e.getMessage());
            return false;
        } finally {
            closeConnection();
        }
    }

    public void closeConnection() {
        try {
            if (conn != null) conn.close();
            if (ps != null) ps.close();
            if (rs != null) rs.close();
        } catch (SQLException e) {
            Logger.getLogger(DaoProduct.class.getName()).log(Level.SEVERE, "ERROR. Function closeConnection failed: " + e.getMessage());
        }
    }
}
