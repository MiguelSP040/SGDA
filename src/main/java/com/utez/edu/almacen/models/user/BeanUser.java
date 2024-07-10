package com.utez.edu.almacen.models.user;

public class BeanUser {
    private int id;
    private String name;
    private String lastname;
    private String phone;
    private String email;
    private String password;
    private int role;
    private boolean status;

    public BeanUser(){

    }

    public BeanUser(int id, String name, String lastname, String email, String phone, String password, int role, boolean status) {
        this.id = id;
        this.name = name;
        this.lastname = lastname;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.role = role;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
