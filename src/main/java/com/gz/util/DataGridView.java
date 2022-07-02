package com.gz.util;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Data
public class DataGridView {

    //private Integer code=0;
   // private String msg="";
    private Long total;

    public Object getRows() {
        return rows;
    }

    public void setRows(Object rows) {
        this.rows = rows;
    }

    private Object rows;


    public DataGridView() {
    }


    public DataGridView(Object rows) {
        this.rows = rows;
    }


    public DataGridView(Long total, Object rows) {
        this.total = total;
        this.rows = rows;
    }
}

