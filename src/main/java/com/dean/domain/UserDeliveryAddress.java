package com.dean.domain;

import javax.persistence.*;

/**
 * Created by dongxu on 2017/3/1.
 */
@Entity
@Table(name="user_delivery_address")
public class UserDeliveryAddress {
    @Id
    @GeneratedValue
    private Long id;
    private Long userId;
    private String phone;
   /* private Long addressId;*/
    private String name;
    private String addressExtend;
    @ManyToOne
    @JoinColumn(name="address_id")
    private AddressInfo address;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public AddressInfo getAddress() {
        return address;
    }

    public void setAddress(AddressInfo address) {
        this.address = address;
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

    public String getAddressExtend() {
        return addressExtend;
    }

    public void setAddressExtend(String addressExtend) {
        this.addressExtend = addressExtend;
    }
}
