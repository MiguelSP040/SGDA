package com.utez.edu.almacen.controllers.email;

import com.utez.edu.almacen.models.user.DaoUser;
import com.utez.edu.almacen.models.user.BeanUser;
import com.utez.edu.almacen.utils.MySQLConnection;

import java.sql.*;

public class CustomerService {
    private final DaoUser daoUser = new DaoUser();

    public boolean resetCustomerPassword(String email, String newPassword, String token) {
        boolean isUpdated = daoUser.updatePassword(email, newPassword);
        if (isUpdated) {
            daoUser.deleteToken(token);
        }
        return isUpdated;
    }

    public boolean doesEmailExist(String email) {
        BeanUser user = daoUser.findByEmail(email);
        return user != null;
    }

    public void saveResetToken(String email, String resetToken) {
        Timestamp expiration = new Timestamp(System.currentTimeMillis() + 3600000);

        String sql = "INSERT INTO password_reset_tokens (email, token, expiration) VALUES (?, ?, ?)";

        try (Connection conn = new MySQLConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, resetToken);
            stmt.setTimestamp(3, expiration);

            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error saving reset token", e);
        }
    }

    public BeanUser validateResetToken(String token) {
        String sql = "SELECT email FROM password_reset_tokens WHERE token = ? AND expiration > NOW()";
        String email = null;

        try (Connection conn = new MySQLConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, token);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                email = rs.getString("email");
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error validating reset token", e);
        }

        if (email != null) {
            return daoUser.findByEmail(email);
        }

        return null;
    }
}
