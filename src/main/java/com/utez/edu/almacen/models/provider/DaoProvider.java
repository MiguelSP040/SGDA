package com.utez.edu.almacen.models.provider;

import com.utez.edu.almacen.models.product.BeanProduct;
import com.utez.edu.almacen.models.product.DaoProduct;
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
                provider.setId(rs.getLong("id_provider"));
                provider.setName(rs.getString("name"));
                provider.setSocialCase(rs.getString("socialCase"));
                provider.setRfc(rs.getString("rfc"));
                provider.setPostCode(rs.getString("postCode"));
                provider.setAddress(rs.getString("address"));
                provider.setPhone(rs.getString("phone"));
                provider.setEmail(rs.getString("email"));
                provider.setContactName(rs.getString("contactName"));
                provider.setContactPhone(rs.getString("contactPhone"));
                provider.setContactEmail(rs.getString("contactEmail"));
                provider.setStatus(rs.getBoolean("status"));
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
                provider.setId(rs.getLong("id_provider"));
                provider.setName(rs.getString("name"));
                provider.setSocialCase(rs.getString("socialCase"));
                provider.setRfc(rs.getString("rfc"));
                provider.setPostCode(rs.getString("postCode"));
                provider.setAddress(rs.getString("address"));
                provider.setPhone(rs.getString("phone"));
                provider.setEmail(rs.getString("email"));
                provider.setContactName(rs.getString("contactName"));
                provider.setContactPhone(rs.getString("contactPhone"));
                provider.setContactEmail(rs.getString("contactEmail"));
                provider.setStatus(rs.getBoolean("status"));
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
            String query = "INSERT INTO providers(name, socialCase, rfc, postCode, address, phone, email, contactName, contactPhone, contactEmail, status)" +
                    "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
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
            ps.setString(10, object.getContactEmail());
            ps.setBoolean(11, true);
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
                    "phone = ?, email = ?, contactName = ?, contactPhone = ?, contactEmail = ? WHERE id_provider = ?";
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
            ps.setString(10, object.getContactEmail());
            ps.setLong(11, object.getId());
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

    public boolean changeStatus(Long providerId){
        try {
            String query = "UPDATE providers SET status = NOT status WHERE id_provider = ?;";
            ps = conn.prepareStatement(query);
            ps.setLong(1, providerId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR. Function change status failed: " + e.getMessage());
            return false;
        } finally {
            closeConnection();
        }
    }

    public BeanProvider getProviderByProductAndStock(Long idProduct, Long idStock) {
        try {
            String query = "SELECT p.* FROM providers p " +
                    "JOIN stock s ON p.id_provider = s.id_provider " +
                    "WHERE s.id_product = ? AND s.id_stock = ? AND p.status = true;";
            ps = conn.prepareStatement(query);
            ps.setLong(1, idProduct);
            ps.setLong(2, idStock);
            rs = ps.executeQuery();
            if (rs.next()) {
                BeanProvider provider = new BeanProvider();
                provider.setId(rs.getLong("id_provider"));
                provider.setName(rs.getString("name"));
                // Rellenar otros campos de provider si es necesario
                return provider;
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoProvider.class.getName()).log(Level.SEVERE, "ERROR. Function getProviderByProductAndStock failed" + e.getMessage());
        } finally {
            closeConnection();
        }
        return null;
    }


    public List<BeanProvider> search(String name, String rfc, String email, String status){
        List<BeanProvider> providers = new ArrayList<>();
        int count = 1;
        try {
            Boolean status2 = false;
            if (status != null && (status.equals("Activo") || status.equals("Inactivo"))) {
                if (status.equals("Activo")){
                    status2 = true;
                } else if (status.equals("Inactivo")){
                    status2 = false;
                }
            }
            conn = new MySQLConnection().getConnection();
            StringBuilder query = new StringBuilder("SELECT * FROM providers WHERE 1=1");


            if (name != null && !name.isEmpty()) {
                query.append(" AND name LIKE ?");
            }
            if (rfc != null && !rfc.isEmpty()) {
                query.append(" AND rfc LIKE ?");
            }
            if (email != null && !email.isEmpty()) {
                query.append(" AND email LIKE ?");
            }
            if (status != null && (status.equals("Activo") || status.equals("Inactivo"))) {
                query.append(" AND status = ?");
            }else {
                query.append(" AND (status = ? OR status = ?)");
            }



            ps = conn.prepareStatement(query.toString());

            if (name != null && !name.isEmpty()) {
                ps.setString(count++, "%" + name + "%");
            }
            if (rfc != null && !rfc.isEmpty()) {
                ps.setString(count++, "%" + rfc + "%");
            }

            if (email != null && !email.isEmpty()) {
                ps.setString(count++, "%" + email + "%");
            }

            if (status != null && (status.equals("Activo") || status.equals("Inactivo"))) {
                ps.setBoolean(count++, status2);
            }else {
                ps.setBoolean(count++, true);
                ps.setBoolean(count++, false);
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                BeanProvider provider = new BeanProvider();
                provider.setId(rs.getLong(1));
                provider.setName(rs.getString(2));
                provider.setRfc(rs.getString(3));
                provider.setPhone(rs.getString(4));
                provider.setEmail(rs.getString(5));
                provider.setContactName(rs.getString(6));
                provider.setAddress(rs.getString(7));
                provider.setPostCode(rs.getString(8));
                provider.setSocialCase(rs.getString(9));
                provider.setContactPhone(rs.getString(10));
                provider.setContactEmail(rs.getString(11));
                provider.setStatus(rs.getBoolean(12));

                providers.add(provider);
            }
        }catch(SQLException e){
            Logger.getLogger(DaoProvider.class.getName()).log(Level.SEVERE, "ERROR. Function search failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return providers;
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
