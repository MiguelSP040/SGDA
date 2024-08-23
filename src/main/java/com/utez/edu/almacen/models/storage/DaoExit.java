package com.utez.edu.almacen.models.storage;

import com.utez.edu.almacen.utils.MySQLConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoExit {
    private Connection conn = new MySQLConnection().getConnection();
    private PreparedStatement ps;
    private ResultSet rs;

    // Método para listar todas las salidas
    public List<BeanExit> listAll() {
        List<BeanExit> exits = new ArrayList<>();
        String sql = "SELECT e.id_exit, e.changeDate, e.invoiceNumber, e.folioNumber, u.name as userName, a.name as areaName, e.totalAllPrices " +
                "FROM exits e " +
                "JOIN users u ON e.id_user = u.id_user " +
                "JOIN areas a ON e.id_area = a.id_area";

        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                BeanExit exit = new BeanExit();
                exit.setIdExit(rs.getLong("e.id_exit"));
                exit.setChangeDate(rs.getString("e.changeDate"));
                exit.setInvoiceNumber(rs.getString("e.invoiceNumber"));
                exit.setFolioNumber(rs.getString("e.folioNumber"));
                exit.setAreaName(rs.getString("areaName"));
                exit.setUserName(rs.getString("userName"));
                exit.setTotalAllPrices(rs.getDouble("e.totalAllPrices"));
                exits.add(exit);
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoExit.class.getName()).log(Level.SEVERE, "ERROR. Function listAll failed: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return exits;
    }

    // Método para listar una salida específica
    public List<BeanExit> listOne(String id) {
        List<BeanExit> exits = new ArrayList<>();
        String sql = "SELECT e.id_exit, e.changeDate, e.invoiceNumber, e.folioNumber, e.buyerName, a.name as areaName, u.name as userName, e.totalAllPrices, " +
                "ep.id_exit_product, ep.id_product, ep.quantity, ep.unitPrice, ep.total_price, " +
                "pr.name as productName, m.name as metricName " +
                "FROM exits e " +
                "JOIN users u ON e.id_user = u.id_user " +
                "JOIN exit_products ep ON e.id_exit = ep.id_exit " +
                "JOIN products pr ON ep.id_product = pr.id_product " +
                "JOIN metrics m ON pr.id_metric = m.id_metric " +
                "JOIN areas a ON e.id_area = a.id_area " +
                "WHERE e.folioNumber = ?";
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                BeanExit exit = new BeanExit();
                exit.setProductName(rs.getString("productName"));
                exit.setMetricName(rs.getString("metricName"));
                exit.setUnitPrice(rs.getDouble("ep.unitPrice"));
                exit.setQuantity(rs.getInt("ep.quantity"));
                exit.setTotalPrice(rs.getDouble("ep.total_price"));
                exits.add(exit);
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoExit.class.getName()).log(Level.SEVERE, "ERROR. Function listOne failed: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return exits;
    }

    public List<BeanExit> searchByDateRange(String startDate, String endDate) {
        List<BeanExit> exits = new ArrayList<>();
        String sql = "SELECT e.id_exit, e.changeDate, e.invoiceNumber, e.folioNumber, p.name AS providerName, ep.total_price " +
                "FROM exits e " +
                "JOIN users u ON e.id_user = u.id_user " +
                "JOIN providers p ON e.id_provider = p.id_provider " +
                "JOIN exit_products ep ON e.id_exit = ep.id_exit " +
                "WHERE e.changeDate BETWEEN ? AND ?";

        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            rs = ps.executeQuery();

            while (rs.next()) {
                BeanExit exit = new BeanExit();
                exit.setIdExit(rs.getLong("id_exit"));
                exit.setChangeDate(rs.getString("changeDate"));
                exit.setInvoiceNumber(rs.getString("invoiceNumber"));
                exit.setFolioNumber(rs.getString("folioNumber"));
                exit.setProviderName(rs.getString("providerName"));
                exit.setTotalAllPrices(rs.getDouble("totalAllPrices"));

                exits.add(exit);
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoExit.class.getName()).log(Level.SEVERE, "ERROR. Function searchByDateRange failed: " + e.getMessage());
        } finally {
            closeConnection();
        }

        return exits;
    }

    public Boolean registerExit(BeanExit exit, List<BeanExitProducts> products) {
        Boolean message = false;
        String sqlExit = "INSERT INTO exits (changeDate, invoiceNumber, folioNumber, id_user, id_area, buyerName, totalAllPrices) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        String sqlExitProduct = "INSERT INTO exit_products (id_exit, id_product, quantity, unitPrice, total_price) " +
                "VALUES (?, ?, ?, ?, ?)";
        String sqlStockCheck = "SELECT quantity FROM stock WHERE id_product = ? AND id_provider = ?";
        String sqlStockUpdate = "UPDATE stock SET quantity = quantity - ? WHERE id_product = ? AND id_provider = ? AND quantity >= ?";

        PreparedStatement psExit = null;
        PreparedStatement psExitProduct = null;
        PreparedStatement psStockCheck = null;
        PreparedStatement psStockUpdate = null;
        ResultSet rs = null;

        try {
            conn.setAutoCommit(false);
            System.out.println("ID Usuario: " + exit.getIdUser());
            System.out.println("ID Área: " + exit.getIdArea());
            System.out.println("Nombre del Comprador: " + exit.getBuyerName());
            System.out.println("Total de Precios: " + exit.getTotalAllPrices());


            // Registrar salida
            psExit = conn.prepareStatement(sqlExit, Statement.RETURN_GENERATED_KEYS);
            psExit.setString(1, exit.getChangeDate());
            psExit.setString(2, exit.getInvoiceNumber());
            psExit.setString(3, exit.getFolioNumber());
            psExit.setInt(4, exit.getIdUser());
            psExit.setInt(5, exit.getIdArea());
            psExit.setString(6, exit.getBuyerName());
            psExit.setDouble(7, exit.getTotalAllPrices());

            // Salida para debugging
            System.out.println("PreparedStatement for exit: " + psExit.toString());

            psExit.executeUpdate();

            // Obtener un id para la salida
            rs = psExit.getGeneratedKeys();
            long idExit = 0;
            if (rs.next()) {
                idExit = rs.getLong(1);
            }

            // Register Products associated with the Exit and update stock
            for (BeanExitProducts product : products) {
                psExitProduct = conn.prepareStatement(sqlExitProduct);
                psExitProduct.setLong(1, idExit);
                psExitProduct.setLong(2, product.getIdProduct());
                psExitProduct.setInt(3, product.getQuantity());
                psExitProduct.setDouble(4, product.getUnitPrice());
                psExitProduct.setDouble(5, product.getTotalPrice());
                psExitProduct.executeUpdate();

                // Check stock
                psStockCheck = conn.prepareStatement(sqlStockCheck);
                psStockCheck.setLong(1, product.getIdProduct());
                psStockCheck.setLong(2, product.getIdProvider());
                rs = psStockCheck.executeQuery();

                if (rs.next()) {
                    // Product exists in stock, update quantity
                    psStockUpdate = conn.prepareStatement(sqlStockUpdate);
                    psStockUpdate.setInt(1, product.getQuantity());
                    psStockUpdate.setLong(2, product.getIdProduct());
                    psStockUpdate.setLong(3, product.getIdProvider());
                    psStockUpdate.setInt(4, product.getQuantity());
                    psStockUpdate.executeUpdate();
                } else {
                    // If the product doesn't exist in stock, log or handle error
                    throw new SQLException("ERROR. Product with ID " + product.getIdProduct() + " not found in stock for provider" + exit.getIdProvider());
                }
            }
            conn.commit(); // Commit transaction
            message = true;
        } catch (SQLException e) {
            try {
                conn.rollback(); // Rollback transaction in case of error
            } catch (SQLException ex) {
                Logger.getLogger(DaoExit.class.getName()).log(Level.SEVERE, "ERROR. Transaction rollback failed: " + ex.getMessage());
            }
            Logger.getLogger(DaoExit.class.getName()).log(Level.SEVERE, "ERROR. Function registerExit failed: " + e.getMessage());
        } finally {
            closeConnection();
        }

        return message;
    }

    private void closeConnection() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            Logger.getLogger(DaoExit.class.getName()).log(Level.SEVERE, "ERROR. Connection close failed: " + e.getMessage());
        }
    }
    public static void main(String[] args) {
        // Crear una instancia de DaoExit
        DaoExit daoExit = new DaoExit();

        // Crear un objeto BeanExit
        BeanExit exit = new BeanExit();
        exit.setChangeDate("2024-08-22"); // Fecha de ejemplo
        exit.setInvoiceNumber("INV-20240822");
        exit.setFolioNumber("S20240822");
        exit.setIdUser(1);
        exit.setIdProvider(1);// ID de usuario de ejemplo
        exit.setIdArea(1); // ID de área de ejemplo
        exit.setBuyerName("Comprador Ejemplo");
        exit.setTotalAllPrices(1500.00); // Total de precios de ejemplo

        // Crear una lista de productos de ejemplo
        List<BeanExitProducts> products = new ArrayList<>();
        BeanExitProducts product1 = new BeanExitProducts();
        product1.setIdProduct(1L); // ID de producto de ejemplo
        product1.setQuantity(4);
        product1.setUnitPrice(50.00);
        product1.setTotalPrice(500.00);
        products.add(product1);

        BeanExitProducts product2 = new BeanExitProducts();
        product2.setIdProduct(2L); // ID de producto de ejemplo
        product2.setQuantity(5);
        product2.setUnitPrice(200.00);
        product2.setTotalPrice(1000.00);
        products.add(product2);

        // Llamar al método registerExit
        boolean success = daoExit.registerExit(exit, products);

        // Mostrar el resultado
        if (success) {
            System.out.println("¡Salida registrada con éxito!");
        } else {
            System.out.println("¡ERROR al registrar la salida!");
        }
    }

}
