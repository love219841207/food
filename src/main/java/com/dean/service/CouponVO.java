package com.dean.service;

import java.math.BigDecimal;

/**
 * Created by dongxu on 2017/2/22.
 */
public class CouponVO {
    private Long id;
    private BigDecimal price;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
}
