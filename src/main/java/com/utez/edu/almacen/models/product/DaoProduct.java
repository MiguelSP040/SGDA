package com.utez.edu.almacen.models.product;

import com.utez.edu.almacen.templates.DaoTemplate;
import com.utez.edu.almacen.utils.MySQLConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoProduct{
    private Connection conn = new MySQLConnection().getConnection();
    private PreparedStatement ps;
    private ResultSet rs;

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

    public List<BeanProduct> listAllStock() {
        List<BeanProduct> stocks = new ArrayList<>();
        CallableStatement cs = null;
        rs = null;
        try {
            String query = "{CALL GetStock()}";
            cs = conn.prepareCall(query);
            rs = cs.executeQuery();
            while (rs.next()) {
                BeanProduct stock = new BeanProduct();
                stock.setId(rs.getLong("productId"));
                stock.setCode(rs.getString("productCode"));
                stock.setName(rs.getString("productName"));
                stock.setMetricName(rs.getString("metricName"));
                stock.setProviderName(rs.getString("providerName"));
                stock.setQuantity(rs.getInt("quantity"));
                stocks.add(stock);
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoProduct.class.getName()).log(Level.SEVERE, "ERROR. Function listAllStock failed: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return stocks;
    }

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

    public List<BeanProduct> search(String name, String code, String id_metric, String status){
        List<BeanProduct> products = new ArrayList<>();
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
            StringBuilder query = new StringBuilder("SELECT * FROM products WHERE 1=1");


            if (code != null && !code.isEmpty()) {
                query.append(" AND code = ?");
            }
            if (name != null && !name.isEmpty()) {
                query.append(" AND name LIKE ?");
            }
            if (id_metric != null && !id_metric.isEmpty()) {
                query.append(" AND id_metric LIKE ?");
            }
            if (status != null && (status.equals("Activo") || status.equals("Inactivo"))) {
                query.append(" AND status = ?");
            }else {
                query.append(" AND (status = ? OR status = ?)");
            }



            ps = conn.prepareStatement(query.toString());

            if (code != null && !code.isEmpty()) {
                ps.setString(count++, code);
            }
            if (name != null && !name.isEmpty()) {
                ps.setString(count++, "%" + name + "%");
            }

            if (id_metric != null && !id_metric.isEmpty()) {
                ps.setString(count++, "%" + id_metric + "%");
            }

            if (status != null && (status.equals("Activo") || status.equals("Inactivo"))) {
                ps.setBoolean(count++, status2);
            }else {
                ps.setBoolean(count++, true);
                ps.setBoolean(count++, false);
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                BeanProduct product = new BeanProduct();
                product.setId(rs.getLong(1));
                product.setCode(rs.getString(2));
                product.setName(rs.getString(3));
                product.setId_metric(rs.getString(4));
                product.setDescription(rs.getString(5));
                product.setStatus(rs.getBoolean(6));

                products.add(product);
            }
        }catch(SQLException e){
            Logger.getLogger(DaoProduct.class.getName()).log(Level.SEVERE, "ERROR. Function search failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return products;
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