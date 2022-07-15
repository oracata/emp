package com.gz.service.gh;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.gz.dao.DaoSupport;
import com.gz.entity.report.ReportDay;
import com.gz.entity.report.Search;
import com.gz.util.DataGridView;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("ghService")
public class GhService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;






    public DataGridView listArea(ReportDay reportday) throws Exception {

        Page<Object> page= PageHelper.startPage(reportday.getPageNumber(),reportday.getPageSize());
        List<ReportDay> data= (List<ReportDay>) dao.findForList("ReportAreaMapper.listReportDay",reportday);
        return new DataGridView(page.getTotal(),data);

    }







}