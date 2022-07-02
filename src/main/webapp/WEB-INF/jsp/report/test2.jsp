<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!-- jsp文件头和头部 -->
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">

    <!-- jsp文件头和头部 -->
    <%@ include file=".././system/admin/top.jsp"%>

</head>
<body>


<div class="container-fluid" id="main-container">


    <div id="page-content" class="clearfix">


        <div class="row-fluid">

            <div class="row-fluid">




                <div class="tabbable" id="userTab">
                    <ul class="nav nav-tabs">
                        <li class="active">
                            <a data-toggle="tab" href="#userchartTab">
                                用户分布
                            </a>
                        </li>
                        <li>
                            <a data-toggle="tab" href="#roleUserTab">
                                用户角色分布
                            </a>
                        </li>
                        <li>
                            <a data-toggle="tab" href="#listUserTab">
                                用户列表
                            </a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div id="userchartTab" class="tab-pane fade in active">
                            <table id="dataGrid">
                            </table>
                        </div>

                        <div id="roleUserTab" class="tab-pane fade" >
                            aaaaaa
                        </div>

                        <div id="listUserTab" class="tab-pane fade" >
                            lllllllllllllll
                        </div>



                    </div>
                </div>


            </div>




        </div><!--/.fluid-container#main-container-->





        <script type="text/javascript">

            //加载提示隐藏
            $(top.hangge());

            var data = [
                { Id: 3, Name: "订单管理"   },
                { Id: 4, Name: "基础数据"  },
                { Id: 5, Name: "新增订单"  }];

            $(function () {
                //表格的初始化
                $('#dataGrid').bootstrapTable({
                    data: data,                         //直接从本地数据初始化表格
                 //   method: 'get',                      //请求方式（*）
                    toolbar: '#toolbar',                //工具按钮用哪个容器
                    striped: true,                      //是否显示行间隔色
                    cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                    pagination: true,                   //是否显示分页（*）
                    sortable: false,                     //是否启用排序
                    sortOrder: "asc",                   //排序方式
                    queryParams: function (params) {
                        return params;
                    },                                  //传递参数（*）
                    sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                    pageNumber: 1,                      //初始化加载第一页，默认第一页
                    pageSize: 10,                       //每页的记录行数（*）
                    pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
                    search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
                    strictSearch: true,
                    showColumns: true,                  //是否显示所有的列
                    pagination: false,
                 //   treeView: true,
                 //   treeId: "Id",
                //    treeField: "Name",
                  //  treeRootLevel: 1,
                    showRefresh: true,                  //是否显示刷新按钮
                    minimumCountColumns: 2,             //最少允许的列数
                    clickToSelect: true,                //是否启用点击选中行
                    uniqueId: "Id",                     //每一行的唯一标识，一般为主键列
                    showToggle: true,                    //是否显示详细视图和列表视图的切换按钮
                  //  selectItemName: 'parentItem',
                    columns: [{
                        checkbox: true
                    }, {
                        field: 'Name',
                        title: '菜单名'

                    } ],
                });
            });
        </script>

        <style type="text/css">
            li {list-style-type:none;}
        </style>
        <ul class="navigationTabs">
            <li><a></a></li>
            <li></li>
        </ul>
</body>
</html>
