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


    <link href="static/bootstrap-table/bootstrap-table.css" rel="stylesheet">

    <script src="static/bootstrap-table/bootstrap-table.js"></script>
       <!--汉化文件，放在 bootstrap-table.js 后面-->
    <script src="static/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
 <script src="static/bootstrap-table/extensions/multiple-sort/bootstrap-table-multiple-sort.js"></script>




    <script src="static/js/ace-elements.min.js"></script>
    <script src="static/js/ace.min.js"></script>




</head>






<body>


<div class="container-fluid" id="main-container">


 <div id="page-content" class="clearfix">


<!--当前用户权限id-->
        <input  type="hidden" name="user_role" id="user_role"  value="${search_con.user_role}"/>
        <input  type="hidden" name="login_name" id="login_name"  value="${search_con.login_name}"/>



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


                        <table id="dataGrid"
                               data-url="gh/allot"
                        ></table>


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







                    <form id="form_data">

                        <div class="form-group">

                        <div class="input">
                            <input type="hidden" name="id" id="id" value=""   style="width: 400px;height: 37px; float: left;"/>
                        </div>
                        </div>

                        <div class="form-group">

                            <div class="input">
                                <input type="hidden" name="operate_user" id="operate_user" value=""   style="width: 400px;height: 37px; float: left;"/>
                            </div>
                        </div>




                        <div class="form-group">

                            <b>*</b>请选择客服:</div>
                            <select class="form-control"  placeholder="请选择：" style="width:100%;height:100%" id="emp">
                                <option value ="邹霞">邹霞</option>
                                <option value ="唐荣">唐荣</option>
                                <option value="刘崇敏">刘崇敏</option>
                                <option value="段晓芳">段晓芳</option>
                                <option value="陆慧敏">陆慧敏</option>
                            </select>


                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <button type="button" class="btn btn-primary"   id="sub"    >分配</button>
                        </div>

                    </form>





            </div>

        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>
<!-- 模态框（Modal）end -->


<!-- 模态框（Modal） 领取-->

<div class="modal fade" id="getModal" tabindex="-1" role="dialog" aria-labelledby="getModalLabel" aria-hidden="true">

        <div class="modal-dialog" style="  overflow: auto; pointer-events:auto">

        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="getModalLabel">无数据</h4>
            </div>
            <div class="modal-body">




                <form id="form_data_get">

                    <div class="form-group">

                        <div class="input">
                            <input type="hidden" name="id_get" id="id_get" value=""   style="width: 400px;height: 37px; float: left;"/>
                        </div>
                    </div>

                    <div class="form-group">

                        <div class="input">
                            <input type="hidden" name="operate_user_get" id="operate_user_get" value=""   style="width: 400px;height: 37px; float: left;"/>
                        </div>
                    </div>




                    <div class="form-group">
                        <b>*</b>客服:</div>

                    <input type="text" readonly="readonly" name="emp_get" id="emp_get" value=""   style="width: 400px;height: 37px; float: left;"/>



                </form>


            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary"   id="sub_get"    >领取</button>
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

            columns: [
          /*
                {
                    checkbox: true
                },
         */
                {
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
                }
                , {
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
                    sortable:true,

                }
                , {
                    field: 'now_tag',
                    title: '本月标签',
                }
                , {
                    field: 'end_order_rq',
                    title: '末单日期',
                    sortable:true,
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


                ,

                {
                    field: 'is_take',
                    title: 'is_take',
                    visible: false,
                }

                ,{
                    field: '',
                    title: "操作",
                    formatter:allotCust,
                }

            ],




            showColumns:true, //选择显示字段框



             sortable: true, // 是否启用排序
            showMultiSort: true, // 多列排序
             //sortName:'end_order_rq',
           //  sortOrder:'desc',

            //showToggle:true, 反转显示按钮
            //showRefresh: true,刷新按钮
            locale:'zh-CN',//中文支持
            //页面需要展示的列，后端交互对象的属性
            pagination: true,  //开启分页

            sidePagination: 'server',//服务器端处理分页
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

        //var data = [{"name":"陆良蒋叶生内科诊所","id":"1E5AD444-4DB1-49B4-95A7-E4B9E004765E","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"蒋叶生","linkphone":"13466036289","emp":"段晓芳","city_name":"曲靖","now_tag":"D","gh_emp":"","end_order_rq":"2022-04-16","his_tag":"Z1","emp1_phone":"19987442665","county":"陆良县","emp1":"伏金坤","gh_isvalid":"无任务","emp3":"段晓芳","gh_rq":"","login_name":null,"applicationname":"诊宝倍","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"施映芬内科诊所","id":"E920BDA6-0F3A-4620-8A29-59A9C5A7D944","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"周小裕","linkphone":"13769533348","emp":"段晓芳","city_name":"曲靖","now_tag":"D","gh_emp":"","end_order_rq":"2022-04-19","his_tag":"Z3","emp1_phone":"18208803312","county":"麒麟区","emp1":"王良飞","gh_isvalid":"无任务","emp3":"段晓芳","gh_rq":"","login_name":null,"applicationname":"诊宝倍","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"云县爱华镇新云洲社区卫生室","id":"4631A3CB-E251-4322-9168-57381927A830","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"杨进波","linkphone":"15087818573","emp":"邹霞","city_name":"临沧","now_tag":"D","gh_emp":"尤捷","end_order_rq":"2022-02-22","his_tag":"Z2","emp1_phone":"18669016822","county":"云县","emp1":"黄光利","gh_isvalid":"激活失败","emp3":"邹霞","gh_rq":"2022-06-10","login_name":null,"applicationname":"诊宝倍","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"鲁甸县芝林堂药业有限公司","id":"B7B8D9AF-1916-43B3-85FD-058D3E2AE62D","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"匡敏","linkphone":"18287023053","emp":"刘崇敏","city_name":"昭通","now_tag":"D","gh_emp":"吴波","end_order_rq":"2022-02-26","his_tag":"Z2","emp1_phone":"15894278205","county":"鲁甸县","emp1":"蒋光劲","gh_isvalid":"激活失败","emp3":"刘崇敏","gh_rq":"2022-06-10","login_name":null,"applicationname":"好药优选","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"昭通市昭阳区迪康诊所有限公司","id":"860BC510-A061-4ED2-80AB-3ADE6900C208","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"李章迪","linkphone":"14736526024","emp":"段晓芳","city_name":"昭通","now_tag":"D","gh_emp":"吴波","end_order_rq":"2021-12-18","his_tag":"Z2","emp1_phone":"15894278205","county":"昭阳区","emp1":"蒋光劲","gh_isvalid":"激活失败","emp3":"段晓芳","gh_rq":"2022-06-10","login_name":null,"applicationname":"诊宝倍","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"永善县茂康药店","id":"9D90D9D5-0668-42C3-98E3-D2990F81B72A","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"曾忠武","linkphone":"13408834194","emp":"刘崇敏","city_name":"昭通","now_tag":"D","gh_emp":"吴波","end_order_rq":"2022-03-28","his_tag":"Z3","emp1_phone":"15894278205","county":"永善县","emp1":"蒋光劲","gh_isvalid":"激活失败","emp3":"刘崇敏","gh_rq":"2022-06-10","login_name":null,"applicationname":"好药优选","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"麒麟崔晓华内科诊所","id":"5346CBEB-F25D-4626-BF58-B5B074157E39","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"陈江艳","linkphone":"15087439761","emp":"张鹏","city_name":"曲靖","now_tag":"D","gh_emp":"刘崇敏","end_order_rq":"2021-12-16","his_tag":"Z3","emp1_phone":"18208803312","county":"麒麟区","emp1":"王良飞","gh_isvalid":"激活失败","emp3":"张鹏","gh_rq":"2022-06-10","login_name":null,"applicationname":"诊宝倍","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"昭通市昭阳区红太阳诊所","id":"B57B0E25-C652-4A14-AC70-349A2AF266A3","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"马贤兰","linkphone":"18887016808","emp":"刘崇敏","city_name":"昭通","now_tag":"D","gh_emp":"吴波","end_order_rq":"2022-03-28","his_tag":"Z2","emp1_phone":"15894278205","county":"昭阳区","emp1":"蒋光劲","gh_isvalid":"激活失败","emp3":"刘崇敏","gh_rq":"2022-06-10","login_name":null,"applicationname":"诊宝倍","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"大关县永兰药店","id":"68A35292-733A-449B-A9CF-4BCE5203E75B","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"童永兰","linkphone":"13649684453","emp":"段晓芳","city_name":"昭通","now_tag":"D","gh_emp":"唐荣","end_order_rq":"2021-12-11","his_tag":"Z3","emp1_phone":"15894278205","county":"大关县","emp1":"蒋光劲","gh_isvalid":"激活失败","emp3":"段晓芳","gh_rq":"2022-06-10","login_name":null,"applicationname":"好药优选","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"昭阳康盛诊所","id":"18F6EE76-3917-43F5-BB09-AE1B976D5BBD","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"哀崇会","linkphone":"13708607856","emp":"刘崇敏","city_name":"昭通","now_tag":"D","gh_emp":"","end_order_rq":"2022-04-22","his_tag":"Z3","emp1_phone":"15894278205","county":"昭阳区","emp1":"蒋光劲","gh_isvalid":"无任务","emp3":"刘崇敏","gh_rq":"","login_name":null,"applicationname":"诊宝倍","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"双江康民大药房","id":"67B7CE39-98CC-411A-8382-41457D4D4190","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"郑万华","linkphone":"13988302225","emp":"邹霞","city_name":"临沧","now_tag":"D","gh_emp":"尤捷","end_order_rq":"2021-12-24","his_tag":"Z2","emp1_phone":"18187512205","county":"双江拉祜族佤族布朗族傣族自治县","emp1":"赵子能","gh_isvalid":"激活失败","emp3":"邹霞","gh_rq":"2022-06-10","login_name":null,"applicationname":"好药优选","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"曲靖市欣欣大药房有限公司","id":"0483E143-B201-4D7B-B38E-6C1ECEC20EBE","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"胥红丽","linkphone":"13987413262","emp":"张鹏","city_name":"曲靖","now_tag":"D","gh_emp":"李闰","end_order_rq":"2021-12-22","his_tag":"Z3","emp1_phone":"18208803312","county":"麒麟区","emp1":"王良飞","gh_isvalid":"激活失败","emp3":"张鹏","gh_rq":"2022-06-10","login_name":null,"applicationname":"好药优选","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"曲靖顺康大药房有限公司","id":"C204A360-811C-4BCA-94F6-1E8ABE513265","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"何木康","linkphone":"15911432388","emp":"邹霞","city_name":"曲靖","now_tag":"D","gh_emp":"李闰","end_order_rq":"2021-12-11","his_tag":"Z3","emp1_phone":"18208803312","county":"麒麟区","emp1":"王良飞","gh_isvalid":"激活失败","emp3":"邹霞","gh_rq":"2022-06-10","login_name":null,"applicationname":"好药优选","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"镇雄县华医大药房","id":"F58C8702-C829-4B8D-889C-9503B4ACB234","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"邓志华","linkphone":"19984023028","emp":"刘崇敏","city_name":"昭通","now_tag":"D","gh_emp":"唐荣","end_order_rq":"2021-12-11","his_tag":"Z3","emp1_phone":"15808609283","county":"镇雄县","emp1":"郑健","gh_isvalid":"激活失败","emp3":"刘崇敏","gh_rq":"2022-06-10","login_name":null,"applicationname":"好药优选","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"陆良县中枢镇窑上社区居民委员会卫生所","id":"D2DB5867-61EB-4174-B41C-AB5813150785","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"袁洪良","linkphone":"15924776799","emp":"杨宏通","city_name":"曲靖","now_tag":"D","gh_emp":"","end_order_rq":"2022-04-19","his_tag":"Z3","emp1_phone":"13008677272","county":"陆良县","emp1":"钱超","gh_isvalid":"无任务","emp3":"杨宏通","gh_rq":"","login_name":null,"applicationname":"诊宝倍","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"明硕药店","id":"BB83F728-1599-4282-9421-DCA054868C1A","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"马勋关","linkphone":"13638864474","emp":"刘崇敏","city_name":"昭通","now_tag":"D","gh_emp":"吴波","end_order_rq":"2021-12-31","his_tag":"Z2","emp1_phone":"13887109779","county":"鲁甸县","emp1":"李选虎","gh_isvalid":"激活失败","emp3":"刘崇敏","gh_rq":"2022-06-10","login_name":null,"applicationname":"好药优选","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"鲁甸县桃源乡民溢诊所","id":"7C6179A1-2CE1-4167-8B3E-FB46EC2BA358","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"马凯华","linkphone":"14769161020","emp":"段晓芳","city_name":"昭通","now_tag":"D","gh_emp":"吴波","end_order_rq":"2021-12-12","his_tag":"Z3","emp1_phone":"13887109779","county":"鲁甸县","emp1":"李选虎","gh_isvalid":"激活失败","emp3":"段晓芳","gh_rq":"2022-06-10","login_name":null,"applicationname":"诊宝倍","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"巍山彝族回族自治县庙街镇古城村卫生室","id":"6FD73C62-548F-44B4-BD94-7681418B806F","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"危成才","linkphone":"15912661335","emp":"陆慧敏","city_name":"大理","now_tag":"D","gh_emp":"","end_order_rq":"2021-12-31","his_tag":"Z3","emp1_phone":"15911235525","county":"巍山彝族回族自治县","emp1":"王杰","gh_isvalid":"无任务","emp3":"陆慧敏","gh_rq":"","login_name":null,"applicationname":"诊宝倍","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"宾川县鸿诚大药房","id":"79C2C80E-850E-4C16-B36A-53CCC2ECDD39","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"王宇梅","linkphone":"13577877466","emp":"邹霞","city_name":"大理","now_tag":"D","gh_emp":"","end_order_rq":"2021-12-30","his_tag":"Z2","emp1_phone":"15911235525","county":"宾川县","emp1":"王杰","gh_isvalid":"无任务","emp3":"邹霞","gh_rq":"","login_name":null,"applicationname":"好药优选","sortInfo":null,"pageNumber":1,"pageSize":10},{"name":"新平民健药房","id":"703C2326-4F4E-4269-804B-0062E8179AAF","is_take":0,"user_role":null,"begin_date":null,"end_date":null,"linkname":"白华艳","linkphone":"15887889366","emp":"唐荣","city_name":"玉溪","now_tag":"D","gh_emp":"","end_order_rq":"2022-05-17","his_tag":"Z2","emp1_phone":"18987943876","county":"新平彝族傣族自治县","emp1":"段笔","gh_isvalid":"无任务","emp3":"唐荣","gh_rq":"","login_name":null,"applicationname":"好药优选","sortInfo":null,"pageNumber":1,"pageSize":10}];
      //  $('#dataGrid').bootstrapTable({data: data});

        function queryParam(params){

            var param = {
                limit : this.limit, // 页面大小
                offset : this.offset, // 页码
                pageNumber : this.pageNumber,
                pageSize : this.pageSize,

                begin_date: $("#begin_date").val(),
                end_date:$("#end_date").val(),

             //   sort: params.sort,      //排序列名
              //  sortOrder: params.order //排位命令（desc，asc）

            };




            return param;
        }

        //排序操作




        //领取 分配 按钮
        function allotCust(value, row, index) {
           var roleid= $("#user_role").val();

                if (roleid== 'e74f713314154c35bd7fc98897859fe3') {
                    var htm = '<button  class="btn btn-primary " data-toggle="modal" data-target="#getModal"    >领取' + '</button>';
                } else {
                    var htm = '<button    class="btn btn-primary"  data-toggle="modal"  data-target="#allotModal"     id="aaaaaa" >分配' + '</button>';
                }


            return htm;
        }




//向modal 中传值

        //模态框传值 bootstrapTable必须要有checkbox:true和singleSelect:true

        $('#allotModal').on('show.bs.modal', function (event,index  ) {
            var row=$("#dataGrid").bootstrapTable('getSelections');


            var modal = $(this);
            modal.find('.modal-title').text(row[0].name);
            modal.find('#id').val(row[0].id);
            modal.find('#operate_user').val( $("#login_name").val());


        });

        //模态框中的 按钮事件
        $("#sub").click(function(event){
            var id = $('#id').val();
            var emp = $('#emp').val();
            var user = $('#operate_user').val();
            var type = 0;
            $.ajax({
                type: "get",
                url: "gh/callallot",
                data: {
                    "id": id,
                    "emp": emp,
                    "user": user,
                    "type": type,

                },
               dataType: "json",
                success: function (res) {

                    //重新加载表数据


                    alert(res);


                },
                error: function (err) {
                    alert(JSON.stringify(err));
                }
            });

            $('#allotModal').modal('hide');

            //刷新表 留在在当前页
            var page = $("#dataGrid").bootstrapTable("getOptions").pageNumber;
            $('#dataGrid').bootstrapTable('refreshOptions',{pageNumber:page});
        });





        $('#getModal').on('show.bs.modal', function (event,index  ) {
            var row=$("#dataGrid").bootstrapTable('getSelections');


            var modal = $(this);
             modal.find('.modal-title').text(row[0].name);

            modal.find('#id_get').val(row[0].id);

            modal.find('#operate_user_get').val($("#login_name").val());
            modal.find('#emp_get').val($("#login_name").val());


        });

        //模态框中的 按钮事件
        $("#sub_get").click(function(event){
            var id = $('#id_get').val();
            var emp = $('#emp_get').val();
            var user = $('#operate_user_get').val();
            var type = 0;
            $.ajax({
                type: "get",
                url: "gh/callallot",
                data: {
                    "id": id,
                    "emp": emp,
                    "user": user,
                    "type": type,

                },

                dataType: "json",
                success: function (res) {
                    alert(JSON.parse(JSON.stringify(res)).responseText);
                },
                //现在所有都走error
                error: function (err) {
                    alert(JSON.parse(JSON.stringify(err)).responseText);
                }
            });

            $('#getModal').modal('hide');

            //刷新表 留在在当前页
            var page = $("#dataGrid").bootstrapTable("getOptions").pageNumber;
            $('#dataGrid').bootstrapTable('refreshOptions',{pageNumber:page});
        });






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
