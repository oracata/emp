package com.gz.controller.report;

import com.gz.controller.base.BaseController;
import com.gz.entity.report.ReportDay;
import com.gz.entity.system.User;
import com.gz.service.report.ReportService;
import com.gz.service.system.user.UserService;
import com.gz.util.*;
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
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value="/report")
public class ReportActiveController  extends BaseController {
    @Resource(name="reportService")
    private ReportService reportService;



    @RequestMapping("/test1")
    public ModelAndView getTest1(Model model, @ModelAttribute ReportDay v_reportday){
        //这个地方设置权限

        //初始化查询条件
        if(v_reportday.getBegin_date()==null && v_reportday.getEnd_date()==null&&v_reportday.getShengfen()==null&&v_reportday.getChengshi()==null&&v_reportday.getQuyufl()==null) {
            v_reportday.setBegin_date(DateUtil.getTimeDay(0));
            v_reportday.setEnd_date(DateUtil.getTimeDay(0));
            v_reportday.setShengfen("云南省");
            v_reportday.setChengshi("");
            v_reportday.setQuyufl(" 合计");
        }
        ModelAndView mav = new ModelAndView("report/test1");
        mav.addObject("reportday_con", v_reportday);

        return mav;
    }

    @ResponseBody
    @RequestMapping(value="/listtest1")
    public DataGridView selectTest1(ReportDay reportday) throws Exception{

        System.out.print("shengfen:"+reportday.getShengfen());
        System.out.print("chengshi:"+reportday.getChengshi());
        System.out.print("quyufl:"+reportday.getQuyufl());
   //     mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限

        return      reportService.listArea(reportday);

    }





    @RequestMapping(value="/test2")
    public ModelAndView selectTest2(User user) throws Exception{
        ModelAndView mv = this.getModelAndView();



        mv.setViewName("report/test2");

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
