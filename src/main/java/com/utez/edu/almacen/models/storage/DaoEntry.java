package com.utez.edu.almacen.models.storage;

import com.utez.edu.almacen.utils.MySQLConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoEntry {
    private Connection conn = new MySQLConnection().getConnection();
    private PreparedStatement ps;
    private ResultSet rs;

    // Método para listar todas las entradas
    public List<BeanEntry> listAll() {
        List<BeanEntry> entries = new ArrayList<>();
        String sql = "SELECT e.id_entry, e.changeDate, e.invoiceNumber, e.folioNumber, u.name as userName, e.totalAllPrices," +
                "p.name as providerName " +
                "FROM entries e " +
                "JOIN users u ON e.id_user = u.id_user " +
                "JOIN providers p ON e.id_provider = p.id_provider ";

        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                BeanEntry entry = new BeanEntry();
                entry.setIdEntry(rs.getLong("e.id_entry"));
                entry.setChangeDate(rs.getString("e.changeDate"));
                entry.setInvoiceNumber(rs.getString("e.invoiceNumber"));
                entry.setFolioNumber(rs.getString("e.folioNumber"));
                entry.setUserName(rs.getString("userName"));
                entry.setProviderName(rs.getString("providerName"));
                entry.setTotalAllPrices(rs.getDouble("e.totalAllPrices"));
                entries.add(entry);
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoEntry.class.getName()).log(Level.SEVERE, "ERROR. Function listAll failed: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return entries;
    }

    // Método para listar una entrada específica
    public BeanEntry listOne(int idEntry) {
        BeanEntry entry = null;
        String sql = "SELECT e.id_entry, e.changeDate, e.invoiceNumber, e.folioNumber, u.name as userName, e.totalAllPrices," +
                "p.name as providerName, ep.id_entry_product, ep.id_product, ep.quantity, ep.unitPrice, ep.total_price, " +
                "pr.name as productName, m.name as metricName " +
                "FROM entries e " +
                "JOIN users u ON e.id_user = u.id_user " +
                "JOIN providers p ON e.id_provider = p.id_provider " +
                "JOIN entry_products ep ON e.id_entry = ep.id_entry " +
                "JOIN products pr ON ep.id_product = pr.id_product " +
                "JOIN metrics m ON pr.id_metric = m.id_metric " +
                "WHERE e.id_entry = ?";

        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idEntry);
            rs = ps.executeQuery();
            if (rs.next()) {
                entry = new BeanEntry();
                entry.setIdEntry(rs.getLong("e.id_entry"));
                entry.setChangeDate(rs.getString("e.changeDate"));
                entry.setInvoiceNumber(rs.getString("e.invoiceNumber"));
                entry.setFolioNumber(rs.getString("e.folioNumber"));
                entry.setUserName(rs.getString("userName"));
                entry.setProviderName(rs.getString("providerName"));
                entry.setTotalAllPrices(rs.getDouble("e.totalAllPrices"));

                // Crear un BeanEntryProducts para cada producto asociado
                BeanEntryProducts entryProduct = new BeanEntryProducts();
                entryProduct.setIdProductEntry(rs.getLong("ep.id_entry_product"));
                entryProduct.setIdEntry(rs.getLong("e.id_entry"));
                entryProduct.setIdProduct(rs.getLong("ep.id_product"));
                entryProduct.setQuantity(rs.getInt("ep.quantity"));
                entryProduct.setUnitPrice(rs.getDouble("ep.unitPrice"));
                entryProduct.setTotalPrice(rs.getDouble("ep.total_price"));

                // Asignar los nombres del producto y la métrica al entry
                entry.setProductName(rs.getString("productName"));
                entry.setMetricName(rs.getString("metricName"));
                entry.setUnitPrice(entryProduct.getUnitPrice());
                entry.setQuantity(entryProduct.getQuantity());
                entry.setTotalPrice(entryProduct.getTotalPrice());
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoEntry.class.getName()).log(Level.SEVERE, "ERROR. Function listOne failed: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return entry;
    }

    public List<BeanEntry> searchByDateRange(String startDate, String endDate) {
        List<BeanEntry> entries = new ArrayList<>();
        String sql = "SELECT e.id_entry, e.changeDate, e.invoiceNumber, e.folioNumber, p.name AS providerName, ep.total_price " +
                "FROM entries e " +
                "JOIN users u ON e.id_user = u.id_user " +
                "JOIN providers p ON e.id_provider = p.id_provider " +
                "JOIN entry_products ep ON e.id_entry = ep.id_entry " +
                "WHERE e.changeDate BETWEEN ? AND ?";

        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            rs = ps.executeQuery();

            while (rs.next()) {
                BeanEntry entry = new BeanEntry();
                entry.setIdEntry(rs.getLong("id_entry"));
                entry.setChangeDate(rs.getString("changeDate"));
                entry.setInvoiceNumber(rs.getString("invoiceNumber"));
                entry.setFolioNumber(rs.getString("folioNumber"));
                entry.setProviderName(rs.getString("providerName"));
                entry.setTotalPrice(rs.getDouble("total_price"));

                entries.add(entry);
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoEntry.class.getName()).log(Level.SEVERE, "ERROR. Function searchByDateRange failed: " + e.getMessage());
        } finally {
            closeConnection();
        }

        return entries;
    }

    public Boolean registerEntry(BeanEntry entry, List<BeanEntryProducts> products) {
        Boolean message = false;
        String sqlEntry = "INSERT INTO entries (changeDate, invoiceNumber, folioNumber, id_user, id_provider, totalAllPrices) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        String sqlEntryProduct = "INSERT INTO entry_products (id_entry, id_product, quantity, unitPrice, total_price) " +
                "VALUES (?, ?, ?, ?, ?)";
        String sqlStockCheck = "SELECT quantity FROM stock WHERE id_product = ? AND id_provider = ?";
        String sqlStockInsert = "INSERT INTO stock (id_product, id_provider, quantity) VALUES (?, ?, ?)";
        String sqlStockUpdate = "UPDATE stock SET quantity = quantity + ? WHERE id_product = ? AND id_provider = ?";

        PreparedStatement psEntry = null;
        PreparedStatement psEntryProduct = null;
        PreparedStatement psStockCheck = null;
        PreparedStatement psStockInsert = null;
        PreparedStatement psStockUpdate = null;
        ResultSet rs = null;

        try {
            conn.setAutoCommit(false); // Start transaction

            // Register Entry
            psEntry = conn.prepareStatement(sqlEntry, Statement.RETURN_GENERATED_KEYS);
            psEntry.setString(1, entry.getChangeDate());
            psEntry.setString(2, entry.getInvoiceNumber());
            psEntry.setString(3, entry.getFolioNumber());
            psEntry.setInt(4, entry.getIdUser());
            psEntry.setInt(5, entry.getIdProvider());
            psEntry.setDouble(6, entry.getTotalAllPrices());
            psEntry.executeUpdate();

            // Get generated ID for the entry
            rs = psEntry.getGeneratedKeys();
            long idEntry = 0;
            if (rs.next()) {
                idEntry = rs.getLong(1);
            }

            // Register Products associated with the Entry and update stock
            for (BeanEntryProducts product : products) {
                psEntryProduct = conn.prepareStatement(sqlEntryProduct);
                psEntryProduct.setLong(1, idEntry);
                psEntryProduct.setLong(2, product.getIdProduct());
                psEntryProduct.setInt(3, product.getQuantity());
                psEntryProduct.setDouble(4, product.getUnitPrice());
                psEntryProduct.setDouble(5, product.getTotalPrice());
                psEntryProduct.executeUpdate();

                // Check stock
                psStockCheck = conn.prepareStatement(sqlStockCheck);
                psStockCheck.setLong(1, product.getIdProduct());
                psStockCheck.setLong(2, entry.getIdProvider());
                rs = psStockCheck.executeQuery();

                if (rs.next()) {
                    // Product exists in stock
                    int currentQuantity = rs.getInt("quantity");
                    psStockUpdate = conn.prepareStatement(sqlStockUpdate);
                    psStockUpdate.setInt(1, product.getQuantity());
                    psStockUpdate.setLong(2, product.getIdProduct());
                    psStockUpdate.setLong(3, entry.getIdProvider());
                    psStockUpdate.executeUpdate();
                } else {
                    // Product does not exist in stock
                    psStockInsert = conn.prepareStatement(sqlStockInsert);
                    psStockInsert.setLong(1, product.getIdProduct());
                    psStockInsert.setLong(2, entry.getIdProvider());
                    psStockInsert.setInt(3, product.getQuantity());
                    psStockInsert.executeUpdate();
                }
            }
            conn.commit(); // Commit transaction
            message = true;
        } catch (SQLException e) {
            try {
                conn.rollback(); // Rollback transaction in case of error
            } catch (SQLException ex) {
                Logger.getLogger(DaoEntry.class.getName()).log(Level.SEVERE, "ERROR. Transaction rollback failed: " + ex.getMessage());
            }
            Logger.getLogger(DaoEntry.class.getName()).log(Level.SEVERE, "ERROR. Function registerEntry failed: " + e.getMessage());
        } finally {
            try {
                if (psEntry != null) psEntry.close();
                if (psEntryProduct != null) psEntryProduct.close();
                if (psStockCheck != null) psStockCheck.close();
                if (psStockInsert != null) psStockInsert.close();
                if (psStockUpdate != null) psStockUpdate.close();
                if (rs != null) rs.close();
                conn.setAutoCommit(true); // Reset auto commit
            } catch (SQLException e) {
                Logger.getLogger(DaoEntry.class.getName()).log(Level.SEVERE, "ERROR. Connection close failed: " + e.getMessage());
            }
        }

        return message;
    }

    private void closeConnection() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            Logger.getLogger(DaoEntry.class.getName()).log(Level.SEVERE, "ERROR. Connection close failed: " + e.getMessage());
        }
    }
        public static void main(String[] args) {
            DaoEntry dao = new DaoEntry();

            // Crear y registrar la entrada
            BeanEntry entry = new BeanEntry(
                    null, // idEntry, se generará automáticamente
                    "2024-08-20", // changeDate
                    "INV12345", // invoiceNumber
                    "E20242208", // folioNumber
                    275.0, // totalAllPrices
                    1, // idUser
                    1 // idProvider
            );

            // Crear una lista de BeanEntryProducts
            List<BeanEntryProducts> products = new ArrayList<>();
            products.add(new BeanEntryProducts(null, 1L, 10, 15.0, 150.0)); // Agregar producto
            products.add(new BeanEntryProducts(null, 2L, 5, 25.0, 125.0)); // Otro producto

            // Registrar la entrada y los productos
            boolean result = dao.registerEntry(entry, products);
            if (result) {
                System.out.println("Entrada y productos registrados con éxito.");
            } else {
                System.out.println("Error al registrar la entrada o los productos.");
            }

            // Listar todas las entradas para verificar
            List<BeanEntry> entries = dao.listAll();
            for (BeanEntry e : entries) {
                System.out.println("ID: " + e.getIdEntry() + ", Change Date: " + e.getChangeDate() + ", Invoice Number: " + e.getInvoiceNumber() + ", Folio Number: " + e.getFolioNumber() + ", User: " + e.getIdUser() + ", Provider: " + e.getIdProvider() + ", Total Price: $" + e.getTotalAllPrices());
            }

            // Probar la función searchByDateRange
            String startDate = "2024-08-19";
            String endDate = "2024-08-21";
            List<BeanEntry> entriesInRange = dao.searchByDateRange(startDate, endDate);
            System.out.println("\nEntradas en el rango de fechas " + startDate + " a " + endDate + ":");
            for (BeanEntry e : entriesInRange) {
                System.out.println("ID: " + e.getIdEntry() + ", Change Date: " + e.getChangeDate() + ", Invoice Number: " + e.getInvoiceNumber() + ", Folio Number: " + e.getFolioNumber() + ", User: " + e.getIdUser() + ", Provider: " + e.getIdProvider() + ", Total Price: $" + e.getTotalAllPrices());
            }
        }

    }
