package com.gz.test;

import com.gz.entity.system.User;
import com.gz.service.system.user.UserService;
import com.gz.util.Const;
import com.gz.util.PageData;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:spring/ApplicationContext_Test.xml"})
public class ServiceTest {

    @Resource
    UserService userservice;



    @Test
    public void userTest() throws Exception {
        PageData pd = new PageData();

        pd.put(Const.SESSION_USERNAME, "admin");
        System.out.println(userservice.findByUId(pd).get("ROLE_ID").toString());
    }



}
