package com.gz.entity.report;

import com.gz.entity.PageModel;

public class ReportDay extends PageModel {
    private String begin_date              ;
    private String end_date                ;
    private String rq                      ;
    private String shengfen                ;
    private String chengshi                ;
    private String quyufl                  ;
    private int custom_num              ;
    private double login_rate              ;
    private int login_pay_custom        ;
    private int login_nopay_custom      ;
    private int order_pay_custom        ;
    private double order_pay_price         ;
    private int order_nopay_custom      ;
    private double order_nopay_price       ;
    private int shopping_cart_custom    ;
    private double shopping_cart_price     ;

    public String getBegin_date() {
        return begin_date;
    }

    public void setBegin_date(String begin_date) {
        this.begin_date = begin_date;
    }

    public String getEnd_date() {
        return end_date;
    }

    public void setEnd_date(String end_date) {
        this.end_date = end_date;
    }

    public String getRq() {
        return rq;
    }

    public void setRq(String rq) {
        this.rq = rq;
    }

    public String getShengfen() {
        return shengfen;
    }

    public void setShengfen(String shengfen) {
        this.shengfen = shengfen;
    }

    public String getChengshi() {
        return chengshi;
    }

    public void setChengshi(String chengshi) {
        this.chengshi = chengshi;
    }

    public String getQuyufl() {
        return quyufl;
    }

    public void setQuyufl(String quyufl) {
        this.quyufl = quyufl;
    }

    public int getCustom_num() {
        return custom_num;
    }

    public void setCustom_num(int custom_num) {
        this.custom_num = custom_num;
    }

    public double getLogin_rate() {
        return login_rate;
    }

    public void setLogin_rate(double login_rate) {
        this.login_rate = login_rate;
    }

    public int getLogin_pay_custom() {
        return login_pay_custom;
    }

    public void setLogin_pay_custom(int login_pay_custom) {
        this.login_pay_custom = login_pay_custom;
    }

    public int getLogin_nopay_custom() {
        return login_nopay_custom;
    }

    public void setLogin_nopay_custom(int login_nopay_custom) {
        this.login_nopay_custom = login_nopay_custom;
    }

    public int getOrder_pay_custom() {
        return order_pay_custom;
    }

    public void setOrder_pay_custom(int order_pay_custom) {
        this.order_pay_custom = order_pay_custom;
    }

    public double getOrder_pay_price() {
        return order_pay_price;
    }

    public void setOrder_pay_price(double order_pay_price) {
        this.order_pay_price = order_pay_price;
    }

    public int getOrder_nopay_custom() {
        return order_nopay_custom;
    }

    public void setOrder_nopay_custom(int order_nopay_custom) {
        this.order_nopay_custom = order_nopay_custom;
    }

    public double getOrder_nopay_price() {
        return order_nopay_price;
    }

    public void setOrder_nopay_price(double order_nopay_price) {
        this.order_nopay_price = order_nopay_price;
    }

    public int getShopping_cart_custom() {
        return shopping_cart_custom;
    }

    public void setShopping_cart_custom(int shopping_cart_custom) {
        this.shopping_cart_custom = shopping_cart_custom;
    }

    public double getShopping_cart_price() {
        return shopping_cart_price;
    }

    public void setShopping_cart_price(double shopping_cart_price) {
        this.shopping_cart_price = shopping_cart_price;
    }
}
