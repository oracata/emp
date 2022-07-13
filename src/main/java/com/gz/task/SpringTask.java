package com.gz.task;

import java.text.SimpleDateFormat;
import java.util.Date;


import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * spring定时器1
 *
 * @author tuzongxun123
 *
 */
@Component
public class SpringTask {

   // @Resource(name="logisticService")
   // private LogisticService logisticService;

    @Scheduled(cron = "0 */1 * * * ?")
    public void ErpSendMsgTask() {


        Date date = new Date();
        SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateStr = sim.format(date);
        System.out.println("每1分钟执行一次，当前时间：" + dateStr);
   //     logisticService.LogisticMsg();
    }
}