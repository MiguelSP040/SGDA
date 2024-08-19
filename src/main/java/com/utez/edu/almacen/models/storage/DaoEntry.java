
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
    private CallableStatement cs;
    private ResultSet rs;

    public Boolean registerEntry(BeanEntry entry) {
        Boolean message = false;
        try {
            cs = conn.prepareCall("{call registerEntry(?, ?, ?, ?, ?, ?, ?)}");
            cs.setString(1, entry.getFolioNumber());
            cs.setString(2, entry.getInvoiceNumber());
            cs.setInt(3, entry.getIdUser());
            cs.setInt(4, entry.getIdProvider());
            cs.setInt(5, entry.getIdProduct());
            cs.setInt(6, entry.getQuantity());
            cs.setDouble(7, entry.getUnitPrice());

            boolean hasResults = cs.execute();
            if (hasResults) {
                message = true;
            }
        } catch (SQLException e){
            Logger.getLogger(DaoEntry.class.getName()).log(Level.SEVERE, "ERROR. Function save failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return message;
    }

    public List<BeanEntry> listAll() {
        List<BeanEntry> entradas = null;
        try {
            entradas = new ArrayList<>();
            String query = "{CALL listAllEntries()}";
            cs = conn.prepareCall(query);
            rs = cs.executeQuery();
            while (rs.next()) {
                BeanEntry entrada = new BeanEntry(
                        rs.getInt("id_entry"),
                        rs.getString("changeDate"),
                        rs.getString("folioNumber"),
                        rs.getString("invoiceNumber"),
                        rs.getString("productName"),
                        rs.getInt("quantity"),
                        rs.getDouble("total_price"),
                        rs.getString("providerName"),
                        rs.getString("userName"),
                        rs.getString("userSurname"),
                        rs.getString("metricName")
                );
                entradas.add(entrada);
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR. Function listAll failed" + e.getMessage());
        } finally {

        }
        return entradas;
    }

    private void closeConnection() {
        try {
            if (cs != null) cs.close();
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR. Function closeConnection: " + e.getMessage());
        }
    }
}
