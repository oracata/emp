package com.gz.controller.gh;

import com.gz.controller.base.BaseController;
import com.gz.entity.report.ReportDay;
import com.gz.entity.system.User;
import com.gz.service.gh.GhService;
import com.gz.service.report.ReportService;
import com.gz.util.Const;
import com.gz.util.DataGridView;
import com.gz.util.DateUtil;
import com.sun.xml.internal.rngom.parse.host.GrammarSectionHost;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping(value="/gh")
public class GhController  extends BaseController {
    @Resource(name="ghService")
    private GhService ghService;


//分配
    @RequestMapping("/allot")
    public ModelAndView getAllot(Model model, @ModelAttribute ReportDay v_reportday){
        //这个地方设置权限

        //初始化查询条件
        if(v_reportday.getBegin_date()==null && v_reportday.getEnd_date()==null&&v_reportday.getShengfen()==null&&v_reportday.getChengshi()==null&&v_reportday.getQuyufl()==null) {
            v_reportday.setBegin_date(DateUtil.getTimeDay(0));
            v_reportday.setEnd_date(DateUtil.getTimeDay(0));
            v_reportday.setShengfen("云南省");
            v_reportday.setChengshi("");
            v_reportday.setQuyufl(" 合计");
        }
        ModelAndView mav = new ModelAndView("gh/allot");
        mav.addObject("reportday_con", v_reportday);

        return mav;
    }






    @RequestMapping(value="/get")
    public ModelAndView selectGet(User user) throws Exception{
        ModelAndView mv = this.getModelAndView();



        mv.setViewName("gh/get");

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
