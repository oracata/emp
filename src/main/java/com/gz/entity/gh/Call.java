package com.gz.entity.gh;

public class Call {

   private  String customerid ;

    public String getCustomerid() {
        return customerid;
    }

    public void setCustomerid(String customerid) {
        this.customerid = customerid;
    }

    public String getEmp() {
        return emp;
    }

    public void setEmp(String emp) {
        this.emp = emp;
    }

    public String getOperate_user() {
        return operate_user;
    }

    public void setOperate_user(String operate_user) {
        this.operate_user = operate_user;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    private  String emp  ;
    private  String operate_user ;
    private  int type  ;
    private  String message   ;
}
