package com.dean.service;

/**
 * Created by dongxu on 2017/3/1.
 */
public class AddressInfoVO {
    private Long id;
    private String address;
    private String addressExt;

    public String getAddressExt() {
        return addressExt;
    }

    public void setAddressExt(String addressExt) {
        this.addressExt = addressExt;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
