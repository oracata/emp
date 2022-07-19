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

    <link rel="stylesheet" href="static/css/my-responsive.css" />

    <!-- 引入 -->

    <script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
    <script src="static/js/bootstrap.min.js"></script>



        <script src="static/js/ace-elements.min.js"></script>
        <script src="static/js/ace.min.js"></script>

        <!-- 引入 -->



</head>






<body>


<div class="container-fluid" id="main-container">


    <div id="page-content" class="clearfix">







        <div class="tabbable" id="userTab">
            <ul class="nav nav-tabs">
                <!--
                <li class="active">
                    <a data-toggle="tab"  href="#userchartTab">
                        统计图表
                    </a>
                </li>
                -->
                <li>
                    <a data-toggle="tab" href="#listUserTab">
                        数据
                    </a>
                </li>
            </ul>

            <!--
        <div class="tab-content">



         <div id="userchartTab" class="tab-pane fade in active">

             待开发

         </div>
          -->


             <div id="listUserTab" class="tab-pane fade in active" >
                 <!-- 检索  -->
                    <form  method="post" name="reportForm" id="reportForm">
                        <table>
                            <tr>

                                <td><input    class="span10 date-picker" name="begin_date" id="begin_date"  value="${search_con.begin_date}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="请选择"/></td>
                                <td><input    class="span10 date-picker" name="end_date" id="end_date"  value="${search_con.end_date}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="请选择"/></td>


                                <td style="vertical-align:top;"><button class="btn btn-mini btn-light"   title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
                                <td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="icon-download-alt"></i></a></td>
                            </tr>
                        </table>


                    </form>




                    <div id="table-responsive-width"  >
                        <table   id="dataGrid">
                        </table>
                    </div>
                </div>



            </div>



        </div>


    </div>




</div><!--/.fluid-container#main-container-->



<!-- 模态框（Modal） 分配-->

<div class="modal fade" id="allotModal" tabindex="-1" role="dialog" aria-labelledby="allotModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="allotModalLabel">请选择客服</h4>
            </div>
            <div class="modal-body">







                    <form>

                        <div class="form-group">
                        <div class="lable">
                        <div class="input">
                            <input type="hidden" name="id" id="id" value=""   style="width: 400px;height: 37px; float: left;"/>
                        </div>
                        </div>




                        <div class="form-group">

                            <b>*</b>请选择客服:</div>
                            <select class="form-control"  placeholder="请选择：" style="width:100%;height:100%" id="sel">
                                <option value ="邹霞">邹霞</option>
                                <option value ="唐荣">唐荣</option>
                                <option value="刘崇敏">刘崇敏</option>
                                <option value="段晓芳">段晓芳</option>
                                <option value="陆慧敏">陆慧敏</option>
                            </select>
                        </div>
                    </form>





            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" οnclick="update()">提交</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>
<!-- 模态框（Modal）end -->


<!-- 模态框（Modal） 领取-->

<div class="modal fade" id="getModal" tabindex="-1" role="dialog" aria-labelledby="getModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="getModalLabel">修改信息</h4>
            </div>
            <div class="modal-body">




              确定领取？


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" οnclick="update()">确定</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>
<!-- 模态框（Modal）end -->


<script type="text/javascript">
    //加载提示隐藏
    $(top.hangge());
    //提交后停留在当前页



    $(function () {



        $('#dataGrid').bootstrapTable({
            method:"POST",
            //极为重要，缺失无法执行queryParams，传递page参数
            contentType : "application/x-www-form-urlencoded",
            dataType:"json",
            singleSelect: true,//单行选择单行,设置为true将禁止多选
            clickToSelect: true,//点击行时自动选择
           // striped: true,//是否显示行间隔色
            theadClasses: "bg-primary",
            columns: [
                {
                    checkbox: true
                }, {
                    title: '序号',
                    field: '',
                    align: 'center',
                    formatter: function (value, row, index) {
                        var pageSize = $('#dataGrid').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                        var pageNumber = $('#dataGrid').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                        return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                    }
                },

                {
                    field: 'id',
                    title: '客户id',
                    visible: false,
                }
                ,  {
                    field: 'applicationname',
                    title: '平台',
                }, {
                    field: 'name',
                    title: '客户名称',
                }
                , {
                    field: 'linkname',
                    title: '联系人',
                }
                , {
                    field: 'linkphone',
                    title: '联系电话',
                }
                , {
                    field: 'city_name',
                    title: '州市',
                }
                , {
                    field: 'county',
                    title: '区县',
                }
                , {
                    field: 'his_tag',
                    title: '历史最高标签',
                }
                , {
                    field: 'now_tag',
                    title: '本月标签',
                }
                , {
                    field: 'end_order_rq',
                    title: '末单日期',
                }
                , {
                    field: 'emp1',
                    title: '地推',
                }
                , {
                    field: 'emp1_phone',
                    title: '地推电话',
                }
                , {
                    field: 'emp3',
                    title: '平台客服',
                }
                , {
                    field: 'emp',
                    title: '归属客服',
                }
                , {
                    field: 'gh_emp',
                    title: '公海客服',
                }
                , {
                    field: 'gh_rq',
                    title: '公海日期',
                }
                , {
                    field: 'gh_isvalid',
                    title: '公海状态',
                }
                ,{
                    field: '',
                    title: "",
                    formatter:allotCust
                }

            ],
            //search : true,//搜索
            //showToggle:true,
            //showRefresh: true,
            locale:'zh-CN',//中文支持
            //页面需要展示的列，后端交互对象的属性
            pagination: true,  //开启分页
            sidePagination: 'server',
            pageNumber: 1,//默认加载页
            pageSize: 20,//每页数据
            // pageList: [5,10,15,20],//可选的每页数据


            url: 'gh/allot', //服务器数据的加载地址
            queryParams:queryParam,
            responseHandler:function(res){
                console.log(JSON.stringify(res.rows));
                return{                            //return bootstrap-table能处理的数据格式
                    "total":res.total,
                    "rows":res.rows
                }


            }
        });

        function queryParam(params){

            var param = {
                limit : this.limit, // 页面大小
                offset : this.offset, // 页码
                pageNumber : this.pageNumber,
                pageSize : this.pageSize,
                sortName : this.sortName,
                sortOrder : this.sortOrder,
                begin_date: $("#begin_date").val(),
                end_date:$("#end_date").val(),

            };

            return param;
        }

        //分配操作



        //领取 分配 按钮
        function allotCust(value, row, index) {

            if(1==2){
            var htm = '<button  class="btn btn-primary " data-toggle="modal" data-target="#getModal"    >领取' + '</button>';
            }else
            {
                var htm = '<button    class="btn btn-primary"  data-toggle="modal"  data-target="#allotModal"     data-whatever="aaaaaa" >分配' + '</button>';
            }
            return htm;
        }


//初始化时弹出框隐藏
        /*
               $(function () { $('#allotModal').modal('hide')});



           $(function () { $('#myModal').on('hide.bs.modal', function () {
               alert('嘿，我听说您喜欢模态框...');})
           });

        */

//向modal 中传值

        //模态框传值

        $('#allotModal').on('show.bs.modal', function (event,index  ) {
            var row=$("#dataGrid").bootstrapTable('getSelections');


            var modal = $(this);
            modal.find('.modal-title').text(row[0].name);
            modal.find('#id').val(row[0].id);


        });

        //提交更改
        function update() {
            //获取模态框数据
            var stuno = $('#stuno').val();
            var pass = $('#pass').val();
            var name = $('#stuname').val();
            var sex = $('input:radio[name="sex"]:checked').val();
            $.ajax({
                type: "post",
                url: "update.do",
                data: "stuno=" + stuno + "&pass=" + pass + "&name=" + name + "&sex=" + sex,
                dataType: 'html',
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                success: function(result) {
                    location.reload();
                }
            });
        }





        //让当前tab页保留当前位置

        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            // 获取已激活的标签页的名称
            var activeTab = $(e.target).text();
            // 获取前一个激活的标签页的名称
            var previousTab = $(e.relatedTarget).text();
            $(".active-tab span").html(activeTab);
            $(".previous-tab span").html(previousTab);
        });
    });

    /*Bootstrap 3：在页面刷新时保持选中的选项卡*/
    $(document).ready(function () {
        if (location.hash) {
            $("a[href='" + location.hash + "']").tab("show");
        }
        $(document.body).on("click", "a[data-toggle='tab']", function (event) {
            location.hash = this.getAttribute("href");
        });
    });
    $(window).on("popstate", function () {
        var anchor = location.hash || $("a[data-toggle='tab']").first().attr("href");
        $("a[href='" + anchor + "']").tab("show");
        //让当前tab页保留当前位置




    });



</script>



<script type="text/javascript">

    $(function() {

        //日期框
        $('.date-picker').datepicker();


        //复选框
        $('table th input:checkbox').on('click' , function(){
            var that = this;
            $(this).closest('table').find('tr > td:first-child input:checkbox')
                .each(function(){
                    this.checked = that.checked;
                    $(this).closest('tr').toggleClass('selected');
                });

        });

    });

    //导出excel
    function toExcel(){
        var USERNAME = $("#nav-search-input").val();
        var lastLoginStart = $("#lastLoginStart").val();
        var lastLoginEnd = $("#lastLoginEnd").val();
        var ROLE_ID = $("#role_id").val();
        var begin_date = $("#begin_date").val();
        var end_date = $("#end_date").val();

        window.location.href='<%=basePath%>search/excel.do?USERNAME='+USERNAME+'&lastLoginStart='+lastLoginStart+'&lastLoginEnd='+lastLoginEnd+'&ROLE_ID='+ROLE_ID+'&begin_date='+begin_date+'&end_date='+end_date;
    }

    //打开上传excel页面
    function fromExcel(){
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="EXCEL 导入到数据库";
        diag.URL = '<%=basePath%>user/goUploadExcel.do';
        diag.Width = 300;
        diag.Height = 150;
        diag.CancelEvent = function(){ //关闭事件
            if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                if('${page.currentPage}' == '0'){
                    top.jzts();
                    setTimeout("self.location.reload()",100);
                }else{
                    nextPage(${page.currentPage});
                }
            }
            diag.close();
        };
        diag.show();
    }

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
