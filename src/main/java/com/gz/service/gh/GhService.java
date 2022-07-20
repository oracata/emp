package com.gz.service.gh;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.gz.dao.DaoSupport;
import com.gz.entity.gh.Call;
import com.gz.entity.gh.Cust;
import com.gz.entity.report.ReportDay;
import com.gz.entity.report.Search;
import com.gz.util.DataGridView;
import com.gz.util.DynamicDataSourceHolder;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("ghService")
public class GhService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;






    public List<Cust> listCust(Cust cust) throws Exception {

        List<Cust> listcust=  (List<Cust>) dao.findForList("CustMapper.listCust",cust);

        return  listcust;



    }


    public  Cust findCust(Cust cust) throws Exception {

        Cust data=  (Cust) dao.findForObject("CustMapper.findById",cust);

        return  data;



    }


    public  Call callAllot(Call call) throws Exception {

        dao.callForObject("CallMapper.allotCust",call);

        return  call;



    }




}