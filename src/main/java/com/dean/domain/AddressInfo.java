package com.dean.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by dongxu on 2017/2/23.
 */
@Entity
@Table(name="address_info")
public class AddressInfo {
    @Id
    @GeneratedValue
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
