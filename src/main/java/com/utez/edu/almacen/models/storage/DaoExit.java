
package com.utez.edu.almacen.models.storage;

import com.utez.edu.almacen.models.user.BeanUser;
import com.utez.edu.almacen.models.user.DaoUser;
import com.utez.edu.almacen.utils.MySQLConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoExit {
    private Connection conn = new MySQLConnection().getConnection();
    private PreparedStatement ps;
    private CallableStatement cs;
    private ResultSet rs;

    public Boolean registerExit(BeanExit exit) {
        Boolean message = false;
        try {
            cs = conn.prepareCall("{call registerExit(?, ?, ?, ?, ?, ?, ?, ?)}");
            cs.setString(1, exit.getFolioNumber());
            cs.setString(2, exit.getInvoiceNumber());
            cs.setInt(3, exit.getIdUser());
            cs.setInt(4, exit.getIdArea());
            cs.setString(5, exit.getBuyerName());
            cs.setInt(6, exit.getIdProduct());
            cs.setInt(7, exit.getQuantity());
            cs.setDouble(8, exit.getUnitPrice());

            boolean hasResults = cs.execute();
            if (hasResults) {
                message = true;
            }
        } catch (SQLException e){
            Logger.getLogger(DaoExit.class.getName()).log(Level.SEVERE, "ERROR. Function save failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return message;
    }

    public List<BeanExit> listAll() {
        List<BeanExit> salidas = null;
        try {
            salidas = new ArrayList<>();
            String query = "{CALL listAllExits()}";
            cs = conn.prepareCall(query);
            rs = cs.executeQuery();
            while (rs.next()) {
                BeanExit salida = new BeanExit(
                        rs.getInt("id_exit"),
                        rs.getString("changeDate"),
                        rs.getString("invoiceNumber"),
                        rs.getString("folioNumber"),
                        rs.getInt("id_user"),
                        rs.getString("userName"),
                        rs.getString("userSurname"),
                        rs.getInt("id_area"),
                        rs.getString("areaName"),
                        rs.getString("buyerName"),
                        rs.getInt("id_product"),
                        rs.getString("productName"),
                        rs.getString("metricName"),
                        rs.getInt("quantity"),
                        rs.getDouble("unitPrice"),
                        rs.getDouble("total_price")
                );
                salidas.add(salida);
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoExit.class.getName()).log(Level.SEVERE, "ERROR. Function listAll failed" + e.getMessage());
        } finally {

        }
        return salidas;
    }

    private void closeConnection() {
        try {
            if (cs != null) cs.close();
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            Logger.getLogger(DaoExit.class.getName()).log(Level.SEVERE, "ERROR. Function closeConnection: " + e.getMessage());
        }
    }
}
