package com.gz.controller.report;

import com.gz.controller.base.BaseController;
import com.gz.entity.report.ReportDay;
import com.gz.entity.report.Search;
import com.gz.entity.system.User;
import com.gz.service.report.ReportService;
import com.gz.service.system.user.UserService;
import com.gz.util.*;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value="/search")
public class ReportSearchController  extends BaseController {
    @Resource(name="reportService")
    private ReportService reportService;
    String menuUrl = "search/listsearchno.do"; //菜单地址(权限用)



    @RequestMapping("/searchno")
    public ModelAndView getSearch(Model model, @ModelAttribute Search v_search){
        //这个地方设置权限

        //初始化查询条件
        if(v_search.getBegin_date()==null && v_search.getEnd_date()==null) {
            v_search.setBegin_date(DateUtil.getTimeDay(0));
            v_search.setEnd_date(DateUtil.getTimeDay(0));

        }
        ModelAndView mav = new ModelAndView("report/searchno");
        mav.addObject("search_con", v_search);

        return mav;
    }

    @ResponseBody
    @RequestMapping(value="/listsearchno")
    public DataGridView selectSearchno(Search search) throws Exception{


        //     mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
         Page<Object> page= PageHelper.startPage(search.getPageNumber(),search.getPageSize());
        List<Search> data= reportService.listSearchno(search);
        return new DataGridView(page.getTotal(),data);


    }



    /*
     * 导出用户信息到EXCEL
     * @return
     */
    @RequestMapping(value="/excel")
    public ModelAndView exportExcel(Search search){
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try{
            if(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){
                //检索条件===
                String USERNAME = pd.getString("USERNAME");
                if(null != USERNAME && !"".equals(USERNAME)){
                    USERNAME = USERNAME.trim();
                    pd.put("USERNAME", USERNAME);
                    System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXX"+USERNAME);
                }
                String lastLoginStart = pd.getString("lastLoginStart");
                String lastLoginEnd = pd.getString("lastLoginEnd");
                if(lastLoginStart != null && !"".equals(lastLoginStart)){
                    lastLoginStart = lastLoginStart+" 00:00:00";
                    pd.put("lastLoginStart", lastLoginStart);
                }
                if(lastLoginEnd != null && !"".equals(lastLoginEnd)){
                    lastLoginEnd = lastLoginEnd+" 00:00:00";
                    pd.put("lastLoginEnd", lastLoginEnd);
                }
                //检索条件===

                Map<String,Object> dataMap = new HashMap<String,Object>();
                List<String> titles = new ArrayList<String>();

                titles.add("客户"); 		//1
                titles.add("搜索词");  		//2
                titles.add("搜索次数");			//3
                titles.add("日期"); 		//4


                dataMap.put("titles", titles);

                List<Search> listsearchno=  reportService.listSearchno(search);

                System.out.println("*************:"+listsearchno.size());
                List<PageData> varList = new ArrayList<PageData>();
                for(int i=0;i<listsearchno.size();i++){
                    PageData vpd = new PageData();


                    vpd.put("var1", listsearchno.get(i).getWldwname());		//1
                    vpd.put("var2", listsearchno.get(i).getSearch_key());		//2
                    vpd.put("var3", listsearchno.get(i).getSearch_num() );			//3
                    vpd.put("var4", listsearchno.get(i).getRq());			//4

                    varList.add(vpd);
                }
                dataMap.put("varList", varList);
                ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
                mv = new ModelAndView(erv,dataMap);
            }
        } catch(Exception e){
            logger.error(e.toString(), e);
        }
        return mv;
    }




                /* ===============================权限================================== */
    public Map<String, String> getHC(){
        Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
    }
    /* ===============================权限================================== */

}
