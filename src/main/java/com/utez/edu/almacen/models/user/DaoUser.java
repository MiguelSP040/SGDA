package com.utez.edu.almacen.models.user;

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

public class DaoUser{
    private Connection conn = new MySQLConnection().getConnection();
    private PreparedStatement ps;
    private ResultSet rs;

    public boolean validationByCredentials(String email, String password) {
        try {
            String query = "SELECT * FROM users WHERE email = ? AND password = ?;";
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error loading user: " + e.getMessage());
            return false;
        } finally {
            closeConnection();
        }
    }

    public List<BeanUser> listAllExcept(String email) {
        List<BeanUser> users = new ArrayList<>();
        try {
            String query = "SELECT * FROM users WHERE email <> ?;";
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                BeanUser user = new BeanUser();
                user.setId(rs.getLong("id_user"));
                user.setName(rs.getString("name"));
                user.setSurname(rs.getString("surname"));
                user.setLastname(rs.getString("lastname"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                // Convertir el valor booleano a cadena
                user.setStatus(rs.getBoolean("status") ? true : false);
                users.add(user);
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR. Function listAll failed" + e.getMessage());
        } finally {
            closeConnection();
        }
        return users;
    }

    public BeanUser listOne(Long id) {
        try {
            String query = "SELECT * FROM users WHERE id_user = ?;";
            ps = conn.prepareStatement(query);
            ps.setLong(1, id);
            rs = ps.executeQuery();
            BeanUser user = new BeanUser();
            if (rs.next()){
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
            return user;
        }catch (SQLException e){
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR. Function listOne failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return null;
    }

    public boolean save(BeanUser object) {
        try {
            String query = "INSERT INTO users(name, surname, lastname, phone, email, password, role, status)" +
                    "VALUES(?, ?, ?, ?, ?, ?, ?, ?);";
            ps = conn.prepareStatement(query);
            ps.setString(1, object.getName());
            ps.setString(2, object.getSurname());
            ps.setString(3, object.getLastname());
            ps.setString(4, object.getPhone());
            ps.setString(5, object.getEmail());
            ps.setString(6, object.getPassword());
            ps.setString(7, object.getRole());
            ps.setBoolean(8, object.getStatus());
            return ps.executeUpdate() > 0;
        }catch (SQLException e){
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR. Function save failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return false;
    }

    public boolean changeStatus(Long userId){
        try {
            String query = "UPDATE users SET status = NOT status WHERE id_user = ?;";
            ps = conn.prepareStatement(query);
            ps.setLong(1, userId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR. Function change status failed: " + e.getMessage());
            return false;
        } finally {
            closeConnection();
        }
    }

    public boolean update(BeanUser object) {
        try {
            String query = "UPDATE users SET name = ?, surname = ?, lastname = ?, phone = ?, email = ?," +
                    "password = ?, role = ?, status = ? WHERE id_user = ?;";
            ps = conn.prepareStatement(query);
            ps.setString(1, object.getName());
            ps.setString(2, object.getSurname());
            ps.setString(3, object.getLastname());
            ps.setString(4, object.getPhone());
            ps.setString(5, object.getEmail());
            ps.setString(6, object.getPassword());
            ps.setString(7, object.getRole());
            ps.setBoolean(8, object.getStatus());
            ps.setLong(9, object.getId());
            return ps.executeUpdate() > 0;
        }catch (SQLException e){
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR. Function update failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return false;
    }

    public boolean delete(Long id) {
        try {
            String query = "DELETE FROM users WHERE id_user = ?;";
            ps = conn.prepareStatement(query);
            ps.setLong(1, id);
            return ps.executeUpdate() == 1;
        }catch (SQLException e){
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR. Function delete failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return false;
    }

    public List<BeanUser> search(String name, String role, String email, String status){
        List<BeanUser> users = new ArrayList<>();
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
            StringBuilder query = new StringBuilder("SELECT * FROM users WHERE 1=1");

            if (name != null && !name.isEmpty()) {
                query.append(" AND (name LIKE ? OR surname LIKE ? OR lastname LIKE ?)");
            }
            if (role != null && (role.equals("Almacenista") || role.equals("Administrador"))) {
                query.append(" AND role = ?");
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
                ps.setString(count++, "%" + name + "%");
                ps.setString(count++, "%" + name + "%");
            }
            if (role != null && (role.equals("Almacenista") || role.equals("Administrador"))) {
                ps.setString(count++, role);
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
                BeanUser user = new BeanUser();
                user.setId(rs.getLong(1));
                user.setName(rs.getString(2));
                user.setSurname(rs.getString(3));
                user.setLastname(rs.getString(4));
                user.setPhone(rs.getString(5));
                user.setEmail(rs.getString(6));
                user.setPassword(rs.getString(7));
                user.setRole(rs.getString(8));
                user.setStatus(rs.getBoolean(9));

                users.add(user);
            }
        }catch(SQLException e){
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR. Function search failed" + e.getMessage());
        }finally {
            closeConnection();
        }
        return users;
    }

    public boolean updatePassword(String email, String newPassword) {
        boolean updated = false;
        String query = "UPDATE users SET password = ? WHERE email = ?";

        try {
            conn = new MySQLConnection().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, newPassword);
            ps.setString(2, email);
            updated = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR. Function updatePassword failed: " + e.getMessage());
        } finally {
            closeConnection();
        }

        return updated;
    }


    public void deleteToken(String token) {
        String query = "DELETE FROM password_reset_tokens WHERE token = ?";

        try {
            conn = new MySQLConnection().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, token);
            ps.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR. Function deleteToken failed: " + e.getMessage());
        } finally {
            closeConnection();
        }

    }

    public BeanUser findByEmail(String email) {
        BeanUser user = null;
        String query = "SELECT * FROM users WHERE email = ?";

        try {
            conn = new MySQLConnection().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                user = new BeanUser();
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
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR. Function findByEmail failed: " + e.getMessage());
        } finally {
            closeConnection();
        }

        return user;
    }


    public void closeConnection() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR. Function closeConnection: " + e.getMessage());
        }
    }
}
