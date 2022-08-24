package com.gz.controller.gh;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.gz.controller.base.BaseController;
import com.gz.entity.gh.Call;
import com.gz.entity.gh.Cust;
import com.gz.entity.report.ReportDay;
import com.gz.entity.report.Search;
import com.gz.entity.system.User;
import com.gz.service.gh.GhService;
import com.gz.service.report.ReportService;
import com.gz.service.system.user.UserService;
import com.gz.util.*;
import com.sun.xml.internal.rngom.parse.host.GrammarSectionHost;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value="/gh")
public class GhController  extends BaseController {

    @Resource(name="ghService")
    private GhService ghService;

    String menuUrl = "gh/listCust.do"; //菜单地址(权限用)


    @RequestMapping("/cust")
    public ModelAndView getSearch(Model model, @ModelAttribute Cust v_cust) throws Exception {
        //这个地方设置权限

        //初始化查询条件
        if(v_cust.getBegin_date()==null && v_cust.getEnd_date()==null) {
            v_cust.setBegin_date("2021-12-01" );
            v_cust.setEnd_date(DateUtil.getTimeDay(0));
        }
        Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
        Session session = currentUser.getSession();
        String ROLE_ID = (String)session.getAttribute(Const.SESSION_ROLE_ID);
        v_cust.setUser_role(ROLE_ID);
        String name = (String)session.getAttribute(Const.SESSION_NAME);
        v_cust.setLogin_name(name);

        ModelAndView mav = new ModelAndView("gh/allot");
        mav.addObject("search_con", v_cust);
        mav.addObject(Const.SESSION_QX,this.getHC());	//按钮权限

        return mav;
    }


//查询客户

    @ResponseBody
    @RequestMapping(value="/allot")
    public DataGridView selectCust(Cust cust) throws Exception{



        Page<Object> page= PageHelper.startPage(cust.getPageNumber(),cust.getPageSize());
        List<Cust> data= ghService.listCust(cust);
        return new DataGridView(page.getTotal(),data);


    }

    @ResponseBody
    @RequestMapping(value="/findcust")
    public Cust findCust(Cust cust) throws Exception{



        Cust data= ghService.findCust(cust);
        return data;


    }



    @ResponseBody
    @RequestMapping(value="/callallot"  ,method = RequestMethod.GET)
    public String  callAllot(  String id, String emp, String user, int type) throws Exception{
         Call call=new Call();
         call.setCustomerid(id);
         call.setEmp(emp);
         call.setOperate_user(user);
         call.setType(type);


        Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
        Session session = currentUser.getSession();
        String username = (String)session.getAttribute(Const.SESSION_NAME);
        call.setOperate_user(username);




        Call message=(Call)ghService.callAllot(call);
        return message.getMessage();


    }





    @ResponseBody
    @RequestMapping(value="/logdata")
    public DataGridView logData(Cust cust) throws Exception{


        //     mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限


        Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
        Session session = currentUser.getSession();

        String name = (String)session.getAttribute(Const.SESSION_NAME);
        cust.setLogin_name(name);

        Page<Object> page= PageHelper.startPage(cust.getPageNumber(),cust.getPageSize());
        List<Cust> data= ghService.logData(cust);
        return new DataGridView(page.getTotal(),data);


    }

    /**
     * 批量分配
     */
    @ResponseBody
    @RequestMapping(value="/allotall"  ,method = RequestMethod.GET)
    public String  allotAll(  String id, String emp,  int type) throws Exception{

        Call call=new Call();
        call.setEmp(emp);

        call.setType(type);


        Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
        Session session = currentUser.getSession();
        String username = (String)session.getAttribute(Const.SESSION_NAME);
        call.setOperate_user(username);



        String message="";
        try {

            String USER_IDS = id;

            if(null != USER_IDS && !"".equals(USER_IDS)){
                String ArrayUSER_IDS[] = USER_IDS.split(",");
                if(Jurisdiction.buttonJurisdiction(menuUrl, "add"))
                  {
                        for(int i=0;i<ArrayUSER_IDS.length;i++) {
                            Call calls=new Call();
                            calls=call;
                            //竖线要换成逗号才能分解
                            String IDS=ArrayUSER_IDS[i].replace("|",",");

                            String Arraycust[] =IDS.split(",");
                            String customerid=Arraycust[0];
                            String customername=Arraycust[1];
                            calls.setCustomerid(customerid);
                            System.out.println(customername);

                        message += customername+":"+  ghService.callAllot(calls).getMessage()+"\n";
                        }
                  }

            }else{
                message="失败";
            }


        } catch (Exception e) {
            logger.error(e.toString(), e);
        } finally {
            logAfter(logger);
        }
        return message;
    }

    /* ===============================权限================================== */
    public Map<String, String> getHC(){
        Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
    }
    /* ===============================权限================================== */

}
