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
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

	<!-- jsp文件头和头部 -->
	<%@ include file="top.jsp"%>
	<style type="text/css">
	.commitopacity{position:absolute; width:100%; height:100px; background:#7f7f7f; filter:alpha(opacity=50); -moz-opacity:0.8; -khtml-opacity: 0.5; opacity: 0.5; top:0px; z-index:99999;}
	</style>
	
	<!-- 即时通讯 -->
	<script type="text/javascript">var wimadress="${pd.WIMIP}:${pd.WIMPORT}";</script>
	<script type="text/javascript">var oladress="${pd.OLIP}:${pd.OLPORT}";</script>
	<link rel="stylesheet" type="text/css" href="plugins/websocketInstantMsg/ext4/resources/css/ext-all.css">
	<link rel="stylesheet" type="text/css" href="plugins/websocketInstantMsg/css/websocket.css" />
	<script type="text/javascript" src="plugins/websocketInstantMsg/ext4/ext-all-debug.js"></script>
	<script type="text/javascript" src="plugins/websocketInstantMsg/websocket.js"></script>
	<!-- 即时通讯 -->
	
</head>
<body>

	<!-- 页面顶部¨ -->
	<%@ include file="head.jsp"%>
	<div id="websocket_button"></div>
	<div class="container-fluid" id="main-container">
		<a href="#" id="menu-toggler"><span></span></a>
		<!-- menu toggler -->

		<!-- 左侧菜单 -->
		<%@ include file="left.jsp"%>

		<div id="main-content" class="clearfix">

			<div id="jzts" style="display:none; width:100%; position:fixed; z-index:99999999;">
			<div class="commitopacity" id="bkbgjz"></div>
			<div style="padding-left: 70%;padding-top: 1px;">
				<div style="float: left;margin-top: 3px;"><img src="static/images/loadingi.gif" /> </div>
				<div style="margin-top: 5px;"><h4 class="lighter block red">&nbsp;加载中 ...</h4></div>
			</div>
			</div>

			<div>
				<iframe name="mainFrame" id="mainFrame" frameborder="0" src="tab.do" style="margin:0 auto;width:100%;height:100%;"></iframe>
			</div>




			<!-- 模态框（Modal） 公海-->

			<div class="modal fade hide" id="ghModal" tabindex="-1" role="dialog" aria-labelledby="getModalLabel" aria-hidden="true"  style="width:900px">

				<div class="modal-dialog" style="  overflow: auto; pointer-events:auto">

					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							<h4 class="modal-title" id="getModalLabel"></h4>
						</div>
						<div class="modal-body" >



							<div id="table-responsive-width"  >
								<table   id="ghdataGrid">
								</table>
							</div>




						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>

						</div>


					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal -->
			</div>
			<!-- 模态框（Modal）end -->

			<!-- 换肤 -->
			<div id="ace-settings-container">
				<div class="btn btn-app btn-mini btn-warning" id="ace-settings-btn">
					<i class="icon-cog"></i>
				</div>
				<div id="ace-settings-box">
					<div>
						<div class="pull-left">
							<select id="skin-colorpicker" class="hidden">
								<option data-class="default" value="#438EB9"
									<c:if test="${user.SKIN =='default' }">selected</c:if>>#438EB9</option>
								<option data-class="skin-1" value="#222A2D"
									<c:if test="${user.SKIN =='skin-1' }">selected</c:if>>#222A2D</option>
								<option data-class="skin-2" value="#C6487E"
									<c:if test="${user.SKIN =='skin-2' }">selected</c:if>>#C6487E</option>
								<option data-class="skin-3" value="#D0D0D0"
									<c:if test="${user.SKIN =='skin-3' }">selected</c:if>>#D0D0D0</option>
							</select>
						</div>
						<span>&nbsp; 选择皮肤</span>
					</div>
					<div>
						<label><input type='checkbox' name='menusf' id="menusf"
							onclick="menusf();" /><span class="lbl" style="padding-top: 5px;">菜单缩放</span></label>
					</div>


					<div>

					</div>

					<div>
						<label><button   type='button' name='menugh' id="menugh"   data-toggle="modal"  data-target="#ghModal"
									  ><span class="lbl" style="padding-top: 5px;">公海日志</span></button></label>
					</div>


				</div>
			</div>
			<!--/#ace-settings-container-->

		</div>
		<!-- #main-content -->
	</div>
	<!--/.fluid-container#main-container-->
	<!-- basic scripts -->
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<!-- 引入 -->
		
		<script type="text/javascript" src="static/js/jquery.cookie.js"></script>
		<script type="text/javascript" src="static/js/myjs/menusf.js"></script>
		
		<!--引入属于此页面的js -->
		<script type="text/javascript" src="static/js/myjs/index.js"></script>




	<script type="text/javascript">




		$(function () {


			$('#ghdataGrid').bootstrapTable({
				method: "POST",
				//极为重要，缺失无法执行queryParams，传递page参数
				contentType: "application/x-www-form-urlencoded",
				dataType: "json",
				singleSelect: true,//单行选择单行,设置为true将禁止多选
				clickToSelect: true,//点击行时自动选择
				// striped: true,//是否显示行间隔色

				columns: [
					 {
						title: '序号',
						field: '',
						align: 'center',
						formatter: function (value, row, index) {
							var pageSize = $('#ghdataGrid').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
							var pageNumber = $('#ghdataGrid').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
							return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
						}
					},

				  {
						field: 'name',
						title: '客户名称',

					}
					,  {
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
					,  {
						field: 'emp',
						title: '归属客服',

					}
					,  {
						field: 'gh_isvalid',
						title: '公海状态',

					}
					,

					{
						field: 'end_date',
						title: '领取时间',

					}
					,

					{
						field: 'emp1',
						title: '领取客服',

					}


				],


				// search : true,//搜索
				//showToggle:true,
				//showRefresh: true,
				locale: 'zh-CN',//中文支持
				//页面需要展示的列，后端交互对象的属性
				pagination: true,  //开启分页
				sidePagination: 'server',
				pageNumber: 1,//默认加载页
				pageSize: 10,//每页数据
				// pageList: [5,10,15,20],//可选的每页数据


				url: 'gh/logdata', //服务器数据的加载地址
				queryParams: queryParam,
				responseHandler: function (res) {
					console.log(JSON.stringify(res.rows));
					return {                            //return bootstrap-table能处理的数据格式
						"total": res.total,
						"rows": res.rows
					}


				}
			});

			function queryParam(params) {

				var param = {
					limit: this.limit, // 页面大小
					offset: this.offset, // 页码
					pageNumber: this.pageNumber,
					pageSize: this.pageSize,



				};

				return param;
			}




		});



	</script>

</body>
</html>
