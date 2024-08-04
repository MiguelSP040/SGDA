package com.utez.edu.almacen.models.provider;

public class BeanProvider {
    private Long id_provider;
    private String name;
    private String socialCase;
    private String rfc;
    private String postCode;
    private String address;
    private String phone;
    private String email;
    private String contactName;
    private String contactPhone;
    private String status;

    public BeanProvider() {
    }

    public BeanProvider(Long id_provider, String name, String socialCase, String rfc, String postCode, String address, String phone, String email, String contactName, String contactPhone, String status) {
        this.id_provider = id_provider;
        this.name = name;
        this.socialCase = socialCase;
        this.rfc = rfc;
        this.postCode = postCode;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.contactName = contactName;
        this.contactPhone = contactPhone;
        this.status = status;
    }

    public Long getId_provider() {
        return id_provider;
    }

    public void setId_provider(Long id_provider) {
        this.id_provider = id_provider;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSocialCase() {
        return socialCase;
    }

    public void setSocialCase(String socialCase) {
        this.socialCase = socialCase;
    }

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public String getPostCode() {
        return postCode;
    }

    public void setPostCode(String postCode) {
        this.postCode = postCode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
