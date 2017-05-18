package com.dean.domain;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by dongxu on 2017/2/21.
 */
@Entity
@Table(name="order_info")
public class OrderInfo {
    @Id
    private String id;
    private Long userId;
    private Date createTime;
    private String typeMenu;
    private String timeMenu;
    private String pkgMenu;
    private int pkgDays;
    private BigDecimal pkgSalePrice;
    private BigDecimal totalPrice;
    private BigDecimal logisticsPrice;
    private Long couponId;
    private BigDecimal couponPrice;
    private BigDecimal lastPrice;
    private Integer status;
    private Date payTime;
    private Date arrivalTime;
    private String remark;

    public Date getPayTime() {
        return payTime;
    }

    public void setPayTime(Date payTime) {
        this.payTime = payTime;
    }

    public Date getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(Date arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public BigDecimal getCouponPrice() {
        return couponPrice;
    }

    public void setCouponPrice(BigDecimal couponPrice) {
        this.couponPrice = couponPrice;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getPkgMenu() {
        return pkgMenu;
    }

    public void setPkgMenu(String pkgMenu) {
        this.pkgMenu = pkgMenu;
    }

    public BigDecimal getPkgSalePrice() {
        return pkgSalePrice;
    }

    public void setPkgSalePrice(BigDecimal pkgSalePrice) {
        this.pkgSalePrice = pkgSalePrice;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getTypeMenu() {
        return typeMenu;
    }

    public void setTypeMenu(String typeMenu) {
        this.typeMenu = typeMenu;
    }

    public String getTimeMenu() {
        return timeMenu;
    }

    public void setTimeMenu(String timeMenu) {
        this.timeMenu = timeMenu;
    }

    public int getPkgDays() {
        return pkgDays;
    }

    public void setPkgDays(int pkgDays) {
        this.pkgDays = pkgDays;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public BigDecimal getLogisticsPrice() {
        return logisticsPrice;
    }

    public void setLogisticsPrice(BigDecimal logisticsPrice) {
        this.logisticsPrice = logisticsPrice;
    }

    public Long getCouponId() {
        return couponId;
    }

    public void setCouponId(Long couponId) {
        this.couponId = couponId;
    }

    public BigDecimal getLastPrice() {
        return lastPrice;
    }

    public void setLastPrice(BigDecimal lastPrice) {
        this.lastPrice = lastPrice;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
