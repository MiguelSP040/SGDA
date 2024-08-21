package com.utez.edu.almacen.models;

public class LoginResult {
    private boolean success;
    private String message;
    private String role;

    public LoginResult(boolean success, String message) {
        this(success, message, null);
    }

    public LoginResult(boolean success, String message, String role) {
        this.success = success;
        this.message = message;
        this.role = role;
    }

    public boolean isSuccess() {
        return success;
    }

    public String getMessage() {
        return message;
    }

    public String getRole() {
        return role;
    }
}
