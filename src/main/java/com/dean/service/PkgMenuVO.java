package com.dean.service;

import java.math.BigDecimal;

/**
 * Created by dongxu on 2017/2/20.
 */
public class PkgMenuVO {
    private Long id;
    private String pkgMenu;
    private String typeMenu;
    private int pkgDays;
    private BigDecimal logisticsPrice;
    private BigDecimal originalPrice;
    private BigDecimal salePrice;

    public BigDecimal getLogisticsPrice() {
        return logisticsPrice;
    }

    public void setLogisticsPrice(BigDecimal logisticsPrice) {
        this.logisticsPrice = logisticsPrice;
    }

    public String getPkgMenu() {
        return pkgMenu;
    }

    public void setPkgMenu(String pkgMenu) {
        this.pkgMenu = pkgMenu;
    }

    public String getTypeMenu() {
        return typeMenu;
    }

    public void setTypeMenu(String typeMenu) {
        this.typeMenu = typeMenu;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }



    public int getPkgDays() {
        return pkgDays;
    }

    public void setPkgDays(int pkgDays) {
        this.pkgDays = pkgDays;
    }

    public BigDecimal getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(BigDecimal originalPrice) {
        this.originalPrice = originalPrice;
    }

    public BigDecimal getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(BigDecimal salePrice) {
        this.salePrice = salePrice;
    }
}
