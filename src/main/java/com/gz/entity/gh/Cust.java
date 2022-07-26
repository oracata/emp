package com.gz.entity.gh;

import com.gz.entity.PageModel;

public class Cust extends PageModel {
    private String id                  ;
    private String applicationname     ;
    private String name                ;
    private String linkname            ;
    private String linkphone           ;
    private String city_name           ;
    private String county              ;
    private String his_tag             ;
    private String now_tag             ;
    private String end_order_rq        ;
    private String emp1                ;
    private String emp1_phone          ;

    private String emp3                ;
    private String emp                 ;
    private String gh_emp              ;
    private String gh_rq               ;
    private String gh_isvalid          ;
    private String login_name          ;



    public String getUser_role() {
        return user_role;
    }

    public void setUser_role(String user_role) {
        this.user_role = user_role;
    }

    public int getInactive_day() {
        return inactive_day;
    }

    public void setInactive_day(int inactive_day) {
        this.inactive_day = inactive_day;
    }

    private int  inactive_day  ;



    private String user_role;

    private String begin_date              ;
    private String end_date              ;

    public int getIs_take() {
        return is_take;
    }

    public void setIs_take(int is_take) {
        this.is_take = is_take;
    }

    private int is_take;

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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getApplicationname() {
        return applicationname;
    }

    public void setApplicationname(String applicationname) {
        this.applicationname = applicationname;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLinkname() {
        return linkname;
    }

    public void setLinkname(String linkname) {
        this.linkname = linkname;
    }

    public String getLinkphone() {
        return linkphone;
    }

    public void setLinkphone(String linkphone) {
        this.linkphone = linkphone;
    }

    public String getCity_name() {
        return city_name;
    }

    public void setCity_name(String city_name) {
        this.city_name = city_name;
    }

    public String getCounty() {
        return county;
    }

    public void setCounty(String county) {
        this.county = county;
    }

    public String getHis_tag() {
        return his_tag;
    }

    public void setHis_tag(String his_tag) {
        this.his_tag = his_tag;
    }

    public String getNow_tag() {
        return now_tag;
    }

    public void setNow_tag(String now_tag) {
        this.now_tag = now_tag;
    }

    public String getEnd_order_rq() {
        return end_order_rq;
    }

    public void setEnd_order_rq(String end_order_rq) {
        this.end_order_rq = end_order_rq;
    }

    public String getEmp1() {
        return emp1;
    }

    public void setEmp1(String emp1) {
        this.emp1 = emp1;
    }

    public String getEmp1_phone() {
        return emp1_phone;
    }

    public void setEmp1_phone(String emp1_phone) {
        this.emp1_phone = emp1_phone;
    }

    public String getEmp3() {
        return emp3;
    }

    public void setEmp3(String emp3) {
        this.emp3 = emp3;
    }

    public String getEmp() {
        return emp;
    }

    public void setEmp(String emp) {
        this.emp = emp;
    }

    public String getGh_emp() {
        return gh_emp;
    }

    public void setGh_emp(String gh_emp) {
        this.gh_emp = gh_emp;
    }

    public String getGh_rq() {
        return gh_rq;
    }

    public void setGh_rq(String gh_rq) {
        this.gh_rq = gh_rq;
    }

    public String getGh_isvalid() {
        return gh_isvalid;
    }

    public void setGh_isvalid(String gh_isvalid) {
        this.gh_isvalid = gh_isvalid;
    }

    public String getLogin_name() {
        return login_name;
    }

    public void setLogin_name(String login_name) {
        this.login_name = login_name;
    }

}
