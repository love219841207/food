package com.dean.service;

/**
 * Created by dongxu on 2017/3/1.
 */
public class DeliveryAddressVO {
    private Long id;
    private Long userId;
    private String phone;
    private Long addressId;
    private String addressName;
    private String addressExtend;
    private String name;
    private String dft;

    public String getDft() {
        return dft;
    }

    public void setDft(String dft) {
        this.dft = dft;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddressName() {
        return addressName;
    }

    public void setAddressName(String addressName) {
        this.addressName = addressName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Long getAddressId() {
        return addressId;
    }

    public void setAddressId(Long addressId) {
        this.addressId = addressId;
    }

    public String getAddressExtend() {
        return addressExtend;
    }

    public void setAddressExtend(String addressExtend) {
        this.addressExtend = addressExtend;
    }
}
