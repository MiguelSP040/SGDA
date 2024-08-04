package com.utez.edu.almacen.models.provider;

import com.utez.edu.almacen.models.user.DaoUser;
import com.utez.edu.almacen.templates.DaoTemplate;
import com.utez.edu.almacen.utils.MySQLConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoProvider implements DaoTemplate<BeanProvider> {
    private Connection conn = new MySQLConnection().getConnection();
    private PreparedStatement ps;
    private ResultSet rs;

    @Override
    public List<BeanProvider> listAll() {
        List<BeanProvider> providers = null;
        try {
            providers = new ArrayList<>();
            String query = "SELECT * FROM providers;";
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()){
                BeanProvider provider = new BeanProvider();
                provider.setId_provider(rs.getLong("id_provider"));
                provider.setName(rs.getString("name"));
                provider.setSocialCase(rs.getString("socialCase"));
                provider.setRfc(rs.getString("rfc"));
                provider.setPostCode(rs.getString("postCode"));
                provider.setAddress(rs.getString("address"));
                provider.setPhone(rs.getString("phone"));
                provider.setEmail(rs.getString("email"));
                provider.setContactName(rs.getString("contactName"));
                provider.setContactPhone(rs.getString("contactPhone"));
                provider.setStatus(rs.getString("status"));
                providers.add(provider);
            }
        }catch (SQLException e){
            Logger.getLogger(DaoProvider.class.getName()).log(Level.SEVERE, "ERROR. Function listAll failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return providers;
    }

    @Override
    public BeanProvider listOne(Long id) {
        try {
            String query = "SELECT * FROM providers WHERE id_provider = ?;";
            ps = conn.prepareStatement(query);
            ps.setLong(1, id);
            rs = ps.executeQuery();
            BeanProvider provider = new BeanProvider();
            if (rs.next()){
                provider.setId_provider(rs.getLong("id_provider"));
                provider.setName(rs.getString("name"));
                provider.setSocialCase(rs.getString("socialCase"));
                provider.setRfc(rs.getString("rfc"));
                provider.setPostCode(rs.getString("postCode"));
                provider.setAddress(rs.getString("address"));
                provider.setPhone(rs.getString("phone"));
                provider.setEmail(rs.getString("email"));
                provider.setContactName(rs.getString("contactName"));
                provider.setContactPhone(rs.getString("contactPhone"));
                provider.setStatus(rs.getString("status"));
            }
            return provider;
        }catch (SQLException e){
            Logger.getLogger(DaoProvider.class.getName()).log(Level.SEVERE, "ERROR. Function listOne failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return null;
    }

    @Override
    public boolean save(BeanProvider object) {
        try {
            String query = "INSERT INTO providers(name, socialCase, rfc, postCode, address, phone, email, contactName, contactPhone, status)" +
                    "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
            ps = conn.prepareStatement(query);
            ps.setString(1, object.getName());
            ps.setString(2, object.getSocialCase());
            ps.setString(3, object.getRfc());
            ps.setString(4, object.getPostCode());
            ps.setString(5, object.getAddress());
            ps.setString(6, object.getPhone());
            ps.setString(7, object.getEmail());
            ps.setString(8, object.getContactName());
            ps.setString(9, object.getContactPhone());
            ps.setString(10, object.getStatus());
            return  ps.executeUpdate() > 0;
        }catch (SQLException e){
            Logger.getLogger(DaoProvider.class.getName()).log(Level.SEVERE, "ERROR. Function save failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return false;
    }

    @Override
    public boolean update(BeanProvider object) {
        try {
            String query = "UPDATE providers SET name = ?, socialCase = ?, rfc = ?, postCode = ?, address = ?," +
                    "phone = ?, email = ?, contactName = ?, contactPhone = ?, status = ? WHERE id_provider = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, object.getName());
            ps.setString(2, object.getSocialCase());
            ps.setString(3, object.getRfc());
            ps.setString(4, object.getPostCode());
            ps.setString(5, object.getAddress());
            ps.setString(6, object.getPhone());
            ps.setString(7, object.getEmail());
            ps.setString(8, object.getContactName());
            ps.setString(9, object.getContactPhone());
            ps.setString(10, object.getStatus());
            ps.setLong(11, object.getId_provider());
            return ps.executeUpdate() > 0;
        }catch (SQLException e){
            Logger.getLogger(DaoProvider.class.getName()).log(Level.SEVERE, "ERROR. Function update failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return false;
    }

    @Override
    public boolean delete(Long id) {
        try {
            String query = "DELETE * FROM providers WHERE id_provider;";
            ps = conn.prepareStatement(query);
            ps.setLong(1, id);
            return ps.executeUpdate() == 1;
        }catch (SQLException e){
            Logger.getLogger(DaoProvider.class.getName()).log(Level.SEVERE, "ERROR. Function update failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return false;
    }

    public void closeConnection(){
        try {
            if (conn != null) conn.close();
            if (ps != null) conn.close();
            if (rs != null) conn.close();
        }catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR. Function closeConnection failed" + e.getMessage());
        }
    }
}
