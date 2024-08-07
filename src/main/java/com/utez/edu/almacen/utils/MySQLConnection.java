package com.utez.edu.almacen.utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class MySQLConnection {
    final String DBNAME = "almacen4",
            USER = "root", PASSWORD = "root",
            TIMEZONE = "America/Mexico_City",
            USESSL = "false", PUBLICKEY = "true",
            DDLAUTO = "true", HOST = "localhost";

    public Connection getConnection(){
        String datasource = String.format(
                "jdbc:mysql://%s:3306/%s?user=%s&password=%s&serverTimezone=%s&useSSL=%s&allowPublicKeyRetrieval=%s&createDatabaseIfNotExist=%s",
                HOST, DBNAME, USER, PASSWORD, TIMEZONE, USESSL, PUBLICKEY, DDLAUTO
        );

        try {
            DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
            return DriverManager.getConnection(datasource);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        try {
            Connection conn = new MySQLConnection().getConnection();
            if (conn != null) {
                System.out.println("Conexion exitosa");
                conn.close();
            }
            else{
                System.out.println("Conexion fallida");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
