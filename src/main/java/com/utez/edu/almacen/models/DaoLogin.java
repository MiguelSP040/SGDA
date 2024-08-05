package com.utez.edu.almacen.models;

import com.utez.edu.almacen.utils.MySQLConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoLogin {
    private Connection con;
    private PreparedStatement pstm;
    private ResultSet rs;
    private final MySQLConnection DB_CONNECTION = new MySQLConnection();
    private final String [] QUERIES = {
            "SELECT * FROM users WHERE password=? AND email=?;"
    };

    public boolean findUser(String username, String password) {
        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[0]);
            pstm.setString(1,password);
            pstm.setString(2,username);
            rs = pstm.executeQuery();

            return rs.next();
        }catch (SQLException e){
            Logger.getLogger(DaoLogin.class.getName()).log(Level.SEVERE, "Error loading login" + e.getMessage());
            return false;
        }finally {
            CloseConnection();
        }

    }

    public void CloseConnection(){
        try {
            if (con!=null){
                con.close();
            }
            if (pstm!=null){
                pstm.close();
            }
            if (rs!=null){
                rs.close();
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
}
