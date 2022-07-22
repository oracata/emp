package com.gz.entity;

public class PageModel {

    public PageModel() {

    }
    //数值没有作用 bootstrap-table已经设置
    private Integer pageNumber=1;
    //数值没有作用 bootstrap-table已经设置
    private Integer pageSize=10;

    private String sortInfo;

    public String getSortInfo() {
        return sortInfo;
    }

    public void setSortInfo(String sortInfo) {
        this.sortInfo = sortInfo;
    }

    public Integer getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(Integer pageNumber) {
        this.pageNumber = pageNumber;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }
}
