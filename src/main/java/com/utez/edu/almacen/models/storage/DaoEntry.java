
    package com.utez.edu.almacen.models.storage;

    import com.utez.edu.almacen.models.user.DaoUser;
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
            String sql = "SELECT e.id_entry, e.changeDate, e.invoiceNumber, e.folioNumber, u.name AS userName, u.surname AS userSurname, p.name AS providerName, ep.total_price " +
                    "FROM entries e " +
                    "JOIN users u ON e.id_user = u.id_user " +
                    "JOIN providers p ON e.id_provider = p.id_provider " +
                    "JOIN entry_products ep ON e.id_entry = ep.id_entry ";

            try {
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    BeanEntry entry = new BeanEntry();
                    entry.setIdEntry(rs.getLong("id_entry"));
                    entry.setChangeDate(rs.getString("changeDate"));
                    entry.setInvoiceNumber(rs.getString("invoiceNumber"));
                    entry.setFolioNumber(rs.getString("folioNumber"));
                    entry.setUserName(rs.getString("userName"));
                    entry.setUserSurname(rs.getString("userSurname"));
                    entry.setProviderName(rs.getString("providerName"));
                    entry.setTotalPrice(rs.getDouble("total_price"));

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
            String sql = "SELECT e.id_entry, e.changeDate, e.invoiceNumber, e.folioNumber, u.userName, p.providerName " +
                    "FROM entries e " +
                    "JOIN users u ON e.id_user = u.id_user " +
                    "JOIN providers p ON e.id_provider = p.id_provider " +
                    "WHERE e.id_entry = ?";

            try {
                ps = conn.prepareStatement(sql);
                ps.setInt(1, idEntry);
                rs = ps.executeQuery();
                if (rs.next()) {
                    entry = new BeanEntry();
                    entry.setIdEntry(rs.getLong("id_entry"));
                    entry.setChangeDate(rs.getString("changeDate"));
                    entry.setInvoiceNumber(rs.getString("invoiceNumber"));
                    entry.setFolioNumber(rs.getString("folioNumber"));
                    entry.setUserName(rs.getString("userName"));
                    entry.setProviderName(rs.getString("providerName"));
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
            String sql = "SELECT e.id_entry, e.changeDate, e.invoiceNumber, e.folioNumber, u.name AS userName, u.surname AS userSurname, p.name AS providerName, ep.total_price " +
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
                    entry.setUserName(rs.getString("userName"));
                    entry.setUserSurname(rs.getString("userSurname"));
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


        // Método para registrar una entrada
        public Boolean registerEntry(BeanEntry entry, List<BeanEntryProducts> products) {
            Boolean message = false;
            String sqlEntry = "INSERT INTO entries (changeDate, invoiceNumber, folioNumber, id_user, id_provider) " +
                    "VALUES (?, ?, ?, ?, ?)";
            String sqlEntryProduct = "INSERT INTO entry_products (id_entry, id_product, quantity, unitPrice, total_price) " +
                    "VALUES (?, ?, ?, ?, ?)";

            PreparedStatement psEntry = null;
            PreparedStatement psEntryProduct = null;
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
                psEntry.executeUpdate();

                // Get generated ID for the entry
                rs = psEntry.getGeneratedKeys();
                long idEntry = 0;
                if (rs.next()) {
                    idEntry = rs.getLong(1);
                }

                // Register Products associated with the Entry
                psEntryProduct = conn.prepareStatement(sqlEntryProduct);
                for (BeanEntryProducts product : products) {
                    psEntryProduct.setLong(1, idEntry);
                    psEntryProduct.setLong(2, product.getIdProduct());
                    psEntryProduct.setInt(3, product.getQuantity());
                    psEntryProduct.setDouble(4, product.getUnitPrice()); // Use setBigDecimal if applicable
                    psEntryProduct.setDouble(5, product.getTotalPrice()); // Use setBigDecimal if applicable
                    psEntryProduct.executeUpdate();
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
                    if (rs != null) rs.close();
                    if (psEntry != null) psEntry.close();
                    if (psEntryProduct != null) psEntryProduct.close();
                    conn.setAutoCommit(true); // Reset to default auto-commit behavior
                } catch (SQLException e) {
                    Logger.getLogger(DaoEntry.class.getName()).log(Level.SEVERE, "ERROR. Closing resources failed: " + e.getMessage());
                }
                closeConnection(); // Close connection
            }
            return message;
        }


        public long getLastInsertedEntryId() {
            long idEntry = 0;
            String sql = "SELECT LAST_INSERT_ID()";
            try {
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();
                if (rs.next()) {
                    idEntry = rs.getLong(1);
                }
            } catch (SQLException e) {
                Logger.getLogger(DaoEntry.class.getName()).log(Level.SEVERE, "ERROR. Function getLastInsertedEntryId failed: " + e.getMessage());
            } finally {
                closeConnection();
            }
            return idEntry;
        }


        // Método para cerrar conexiones
        private void closeConnection() {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                Logger.getLogger(DaoEntry.class.getName()).log(Level.SEVERE, "ERROR. Function closeConnection: " + e.getMessage());
            }
        }
        public static void main(String[] args) {
            DaoEntry dao = new DaoEntry();

            // Crear y registrar la entrada
            BeanEntry entry = new BeanEntry(
                    null, // idEntry, se generará automáticamente
                    "2024-08-20", // changeDate
                    "INV12345", // invoiceNumber
                    "E20249899", // folioNumber
                    null, // totalPrice, puede ser calculado después
                    "kg", // metricName
                    1, // idUser
                    1, // idProvider
                    0, // idProduct, este valor es solo un placeholder
                    0, // quantity, este valor es solo un placeholder
                    0.0 // unitPrice, este valor es solo un placeholder
            );

            // Crear una lista de BeanEntryProducts con el idEntry obtenido
            List<BeanEntryProducts> products = new ArrayList<>();
            products.add(new BeanEntryProducts(null, 0L, 1L, 10, 15.0, 150.0)); // Agregar producto
            products.add(new BeanEntryProducts(null, 0L, 1L, 5, 25.0, 125.0)); // Otro producto

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
                System.out.println("ID: " + e.getIdEntry() + ", Change Date: " + e.getChangeDate() + ", Invoice Number: " + e.getInvoiceNumber() + ", Folio Number: " + e.getFolioNumber() + ", User: " + e.getUserName() + ", Provider: " + e.getProviderName() + ", Total Price: $" + e.getTotalPrice());
            }
        }
    }
