package com.utez.edu.almacen.models.user;

import com.utez.edu.almacen.utils.MySQLConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoLoggedUser {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public DaoLoggedUser() {
        conn = new MySQLConnection().getConnection();
    }

    public BeanLoggedUser findUserByEmail(String email) {
        BeanLoggedUser user = null;
        try {
            String query = "SELECT * FROM users WHERE email = ?";
            conn = new MySQLConnection().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                user = new BeanLoggedUser();
                user.setId(rs.getLong("id_user"));
                user.setName(rs.getString("name"));
                user.setSurname(rs.getString("surname"));
                user.setLastname(rs.getString("lastname"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getBoolean("status"));
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoLoggedUser.class.getName()).log(Level.SEVERE, "ERROR. Function findUserByEmail failed: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return user;
    }

    public BeanLoggedUser findUserById(Long id) {
        BeanLoggedUser user = null;
        try {
            String query = "SELECT * FROM users WHERE id_user = ?;";
            ps = conn.prepareStatement(query);
            ps.setLong(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                user = new BeanLoggedUser();
                user.setId(rs.getLong("id_user"));
                user.setName(rs.getString("name"));
                user.setSurname(rs.getString("surname"));
                user.setLastname(rs.getString("lastname"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getBoolean("status"));
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoLoggedUser.class.getName()).log(Level.SEVERE, "ERROR. Function findUserById failed: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return user;
    }

    public boolean updateProfile(BeanLoggedUser user) {
        boolean result = false;
        try {
            String query = "UPDATE users SET name = ?, surname = ?, lastname = ?, phone = ? WHERE id_user = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, user.getName());
            ps.setString(2, user.getSurname());
            ps.setString(3, user.getLastname());
            ps.setString(4, user.getPhone());
            ps.setLong(5, user.getId());
            result = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoLoggedUser.class.getName()).log(Level.SEVERE, "ERROR. Function updateProfile failed: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean updatePassword(Long id, String newPassword) {
        boolean result = false;
        try {
            String query = "UPDATE users SET password = ? WHERE id_user = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, newPassword);
            ps.setLong(2, id);
            result = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoLoggedUser.class.getName()).log(Level.SEVERE, "ERROR. Function updatePassword failed: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean updateEmail(Long id, String newEmail) {
        boolean result = false;
        try {
            String query = "UPDATE users SET email = ? WHERE id_user = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, newEmail);
            ps.setLong(2, id);
            result = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoLoggedUser.class.getName()).log(Level.SEVERE, "ERROR. Function updateEmail failed: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return result;
    }

    private void closeConnection() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            Logger.getLogger(DaoLoggedUser.class.getName()).log(Level.SEVERE, "ERROR. Function closeConnection: " + e.getMessage());
        }
    }
}
