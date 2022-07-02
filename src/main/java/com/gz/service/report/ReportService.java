package com.gz.service.report;

import java.util.List;

import javax.annotation.Resource;

import com.gz.entity.report.ReportDay;
import com.gz.entity.report.Search;
import com.gz.util.DataGridView;
import com.gz.util.PageData;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.Page;
import org.springframework.stereotype.Service;

import com.gz.dao.DaoSupport;



@Service("reportService")
public class ReportService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;






    public DataGridView listArea(ReportDay reportday) throws Exception {

        Page<Object> page= PageHelper.startPage(reportday.getPageNumber(),reportday.getPageSize());
        List<ReportDay> data= (List<ReportDay>) dao.findForList("ReportAreaMapper.listReportDay",reportday);
        return new DataGridView(page.getTotal(),data);

    }


    public List<Search> listSearchno(Search search) throws Exception {


        return (List<Search>) dao.findForList("ReportSearchMapper.listSearchno",search);

    }




}