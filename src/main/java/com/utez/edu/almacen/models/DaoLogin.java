package com.utez.edu.almacen.models;

import com.utez.edu.almacen.utils.MySQLConnection;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoLogin {
    private Connection con;
    private PreparedStatement pstm;
    private ResultSet rs;
    private final MySQLConnection DB_CONNECTION = new MySQLConnection();
    private final String [] QUERIES = {
            "SELECT * FROM users WHERE email=?;"
    };

    public LoginResult findUser(String username, String password) {
        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[0]);
            pstm.setString(1, username);
            rs = pstm.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");
                String role = rs.getString("role");
                boolean isActive = rs.getBoolean("status");

                if (!dbPassword.equals(password)) {
                    return new LoginResult(false, "Usuario y/o contraseña incorrectos.");
                }

                if (!isActive) {
                    return new LoginResult(false, "Usuario inactivo.");
                }

                // Incluye el rol en el resultado
                return new LoginResult(true, "Login exitoso.", role);
            } else {
                return new LoginResult(false, "Usuario y/o contraseña incorrectos.");
            }


        } catch (SQLException e) {
            Logger.getLogger(DaoLogin.class.getName()).log(Level.SEVERE, "Error en el login: " + e.getMessage());
            return new LoginResult(false, "Error en el servidor.");
        } finally {
            CloseConnection();
        }
    }

    public void CloseConnection(){
        try {
            if (con != null) {
                con.close();
            }
            if (pstm != null) {
                pstm.close();
            }
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

