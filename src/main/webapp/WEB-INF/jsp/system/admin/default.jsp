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
<%@ include file="top.jsp"%>


	<link rel="stylesheet" href="static/css/my-responsive.css" />
	<link rel="stylesheet" href="static/css/my.css" />

	<!-- 引入 -->

	<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>

	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<!-- 引入 -->

	<!-- 使用官网的文件会变形，所示使用示例的文件 -->

	<script src="static/echarts/map/echarts.min.js"></script>
	<!-- 使用官网的文件会变形，所示使用示例的文件 -->
</head>
<body>

<div class="container-fluid" id="main-container">


	<div id="page-content" class="clearfix">







		<div class="tabbable" id="userTab">
			<ul class="nav nav-tabs">
				<li class="active">
					<a data-toggle="tab"  href="#userchartTab">
						区域分布
					</a>
				</li>
				<li>
					<a data-toggle="tab" href="#listUserTab">
						数据
					</a>
				</li>
			</ul>
			<div class="tab-content">


				<div id="userchartTab" class="tab-pane fade in active">
					<!--图表开始-->
					<div class="mune" style="color: #fff;" align="right">
						<a href="jvascript:void(0)" id="sssj" onclick="loadMapDateTitle(this)" code=""></a>  <a href="jvascript:void(0)" id="ssdsz" onclick="loadMapDateTitle(this)" code=""></a>  <a href="jvascript:void(0)" id="ssfsx"></a>
					</div>
					<div id="back_btn" align="right" onclick="loadMapDateTitleBack(this)">返回</div>
					<div>

						<div id="main_map" class="main_map_repsonsive_width"></div>



					</div>

				</div>
				<script>



					function getUrlQuery(name) {
						var pos, str, para, parastr;
						var array = []
						str = window.location.href;
						if (str.split("?")[1] != undefined && str.split("=")[1] != undefined) {
							parastr = str.split("?")[1];
							parastr=decodeURIComponent(parastr);
							var arr = []
							arr = parastr.split("&");
							for (var i = 0; i < arr.length; i++) {
								array[arr[i].split("=")[0]] = arr[i].split("=")[1];
							}

						}
						return array[name];//project为所要获取的参数
					}


					//当前登录用户单位代码
					var myOrgCode = getUrlQuery("orgCode");
					//当前登录用户单位名称
					var myOrgName = getUrlQuery("orgName");
					if(myOrgCode==null){
						myOrgCode="530000";
					}
					if(myOrgName==null){
						orgName="云南";
					}

					//地图
					var myChartMap = echarts.init(document.getElementById('main_map'));


					//当前缓存对象
					var mapDateObj = {};
					//当前缓存散点对象
					var mapPontObj = {};

					//当前缓存散点对象中心点
					var mapCenterObj = {};

					//当前地图OrgCode
					var thisOrgCode = "";
					//当前地图OrgName
					var thisOrgName = "";

					//地图标点颜色
					var pointColor = ['#27d726', '#e992d6', '#eba67c', '#10dbdb', '#eaef5e', '#0ad9dc', '#ee7990'];
					//地图区域的颜色
					var cityColor = ['#ccc', '#9074c3','#4487d5', '#7e9e8e', '#51a2c2'];


					/**
					 *地图点击事件
					 *
					 **/
					myChartMap.on('click', function (params) {
						if(mapDateObj[thisOrgCode] && mapDateObj[thisOrgCode]!=null && mapDateObj[thisOrgCode].features){
							var listFeatures = mapDateObj[thisOrgCode].features;
							var loadOrgCode = "";
							var loadOrgName = "";
							if(listFeatures!=null && listFeatures.length > 0){
								for (var i = 0; i < listFeatures.length; i++) {
									var  properties = listFeatures[i].properties;
									if(properties.name == params.name){
										loadOrgCode = properties.adcode;
										loadOrgName = params.name;
									}
								}
							}
							if(loadOrgCode!=""){
								loadMapDate(loadOrgCode+"",loadOrgName);
							}
						}

					});

					/**
					 *初始化
					 *
					 **/
					jQuery(function() {
						$("#sssj").html(myOrgName);
						$("#sssj").attr("code",myOrgCode);
						thisOrgCode = myOrgCode;
						thisOrgName = myOrgName;
						initMap();
					});

					/**
					 *初始化地图页面
					 *
					 **/
					function initMap(){
						loadMapDate(myOrgCode,myOrgName);
					}

					/**
					 *标题点击事件
					 *obj
					 *
					 ***/
					function loadMapDateTitle(obj){
						loadMapDate($(obj).attr("code"),$(obj).html());
					}
					/**
					 *返回按钮点击事件
					 *obj
					 *
					 ***/
					function loadMapDateTitleBack(obj){
						if(!($("#ssfsx").is(':hidden'))){
							if(myOrgCode.substring(myOrgCode.length - 4,myOrgCode.length) == "0000"){
								loadMapDateTitle($("#ssdsz"));
							}else{
								if($(obj).attr("code")!=null &&  $(obj).attr("code")!=""){
									loadMapDateTitle($("#ssdsz"));
								}else{
									loadMapDateTitle($("#sssj"));
								}
							}
						}else if(!($("#ssdsz").is(':hidden'))){
							loadMapDateTitle($("#sssj"));
						}
					}
					/**
					 *加载地图页面数据
					 *orgCode
					 *orgName
					 *
					 ***/
					function loadMapDate(orgCode,orgName){
						myChartMap.showLoading();
						if(mapDateObj[orgCode] && mapDateObj[orgCode]!=null &&  mapDateObj[orgCode]!= undefined){
							registerMap(mapDateObj[orgCode],orgCode,orgName);
						}else{
							//  $.get('你的json地址'+orgCode+'.json?uuid=123456', function (geoJson) {
							$.get('static/echarts/map/json/yunnan/'+orgCode+'.json', function (geoJson) {

								var listFeatures = geoJson.features;
								var codeList = [];
								for (var i = 0; i < listFeatures.length; i++) {
									var ent = listFeatures[i].properties;
									try{
										if(ent.centroid){
											codeList.push({name: ent.name,value:[ent.centroid[0], ent.centroid[1], Math.floor(Math.random()*100+1)],code:ent.adcode});
										}else{
											codeList.push({name: ent.name,value:[ent.center[0], ent.center[1], Math.floor(Math.random()*100+1)],code:ent.adcode});
										}
									}catch(e){
									}


								}
								if(orgCode.substring(orgCode.length - 1,orgCode.length) != "0" || codeList.length==1){
									mapPontObj[orgCode] = codeList;
									mapDateObj[orgCode] = geoJson;
									registerMap(geoJson,orgCode,orgName);
								}else{
									mapPontObj[orgCode] = codeList;
									mapDateObj[orgCode] = geoJson;
									registerMap(geoJson,orgCode,orgName);
								}


							});

						}

					}




					function getMapCenter(orgCode){
						var list = mapPontObj[orgCode];
						if(list!=null && list.length>0){
							for (var i = 0; i < list.length; i++) {
								var tmpEnt = list[i];
								mapCenterObj[tmpEnt.code] = [tmpEnt.value[0],tmpEnt.value[1]]
							}
						}
						return mapCenterObj[orgCode];
					}



					/**
					 *重新加载地图页面
					 *geoJson
					 *orgCode
					 *orgName
					 *
					 ***/
					function registerMap(geoJson,orgCode,orgName){

						myChartMap.hideLoading();
						echarts.registerMap('TTMAP', geoJson);


						if(orgCode==myOrgCode){
							$("#back_btn").hide();
						}else{
							$("#back_btn").show();
						}
						var orgNames = [];
						var orgDatas = [];
						var orgDataZps = [];
						thisOrgCode = orgCode;
						thisOrgName = orgName;
						var pcsBool = false;
						if(orgCode.substring(orgCode.length - 1,orgCode.length) != "0"){
							$("#ssfsx").show();
							$("#ssfsx").html(orgName);
							pcsBool = true;
						}else if(orgCode!=myOrgCode){
							$("#ssdsz").show();
							$("#ssdsz").html(orgName);
							$("#ssdsz").attr("code",orgCode);
							$("#ssfsx").hide();
						}else{
							$("#ssdsz").hide();
							$("#ssfsx").hide();
						}

						if(myOrgCode.substring(myOrgCode.length - 1,myOrgCode.length) != "0"){
							$("#ssfsx").hide();
						}



						let optionMap = { // echarts 配置
							visualMap: {
								show: false,
								min: 1,
								max: 99,
								left: 'left',
								top: 'bottom',
								text: ['高', '低'],
								calculable: true,
								seriesIndex: [1],
								inRange: {
									color: cityColor
								}
							},
							tooltip: {
								trigger: 'item',
								formatter: function(t, n, i) {
									if(t && t.data){
										var data = t.data;
										var dw = 10;
										var sb = 50;
										var hc = 12560;
										var yj = 15;
										if(data.value && data.value != undefined &&  data.value!=null && data.value.length>=2){
											return  data.name +"<br/>"
													+"<em style='background-color:#27d726;'>&nbsp;&nbsp;&nbsp;&nbsp;</em> 数据1"+data.value[2]+"条<br/>"
													+"<em style='background-color:#eba67c;'>&nbsp;&nbsp;&nbsp;&nbsp;</em> 数据2"+sb+"条<br/> "
													+"<em style='background-color:#10dbdb;'>&nbsp;&nbsp;&nbsp;&nbsp;</em> 数据3"+hc+"条<br/> "
													+"<em style='background-color:#ee7990;'>&nbsp;&nbsp;&nbsp;&nbsp;</em> 数据4"+yj+"条";

										}else{
											return data.name;
										}
									}

								}
							},
							geo: { // 地图配置
								show: true,
								map: 'TTMAP',
								label: {
									normal: {
										show: false,
									},
									emphasis: {
										show: false
									}
								},
								zoom: 1.2,
								roam: true,
								center: getMapCenter(orgCode),
								itemStyle: {
									normal: {
										areaColor: cityColor[Math.floor(Math.random()*cityColor.length)]
									}
								},
								emphasis: {
									itemStyle: {
										areaColor: '#0A69BB' // 经过颜色
									}
								}


							},
							series: [
								{
									// 散点配置
									type: 'effectScatter',
									coordinateSystem: 'geo',
									data: mapPontObj[orgCode],
									symbolSize: function (val) {
										return pcsBool?10:20;
									},
									symbolOffset: [0, 0],
									zlevel: 10,
									tooltip: {
										show: false
									},
									itemStyle: {
										normal: {
											color: function (params) {
												var num = pointColor.length;
												return pointColor[params.dataIndex % num]
											},
										}
									},
									label: {
										normal: {
											formatter: function(t) {
												var name = t.data.name;

												var ret = name   +"\n"+ t.data.value[2]
												return ret;
											},
											position: "inside",
											show: true,
											color: "#444"
										},
										emphasis: {
											show: true
										}
									}
								},
								{
									type: 'map',
									geoIndex: 0,
									data: mapPontObj[orgCode],
								}
							]
						};
						myChartMap.setOption(optionMap);

					}
				</script>
				<!--图表结束-->




				<div id="listUserTab" class="tab-pane fade" >
					<!-- 检索  -->
					<form  method="post" name="reportForm" id="reportForm">
						<table>
							<tr>

								<td><input    class="span10 date-picker" name="begin_date" id="begin_date"  value="${reportday_con.begin_date}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="请选择"/></td>
								<td><input    class="span10 date-picker" name="end_date" id="end_date"  value="${reportday_con.end_date}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="请选择"/></td>


								<td style="vertical-align:top;"><button class="btn btn-mini btn-light"   title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
							</tr>
						</table>
						<input type="hidden" name="shengfen" id="shengfen" value="${reportday_con.shengfen }"/>
						<input type="hidden" name="chengshi" id="chengshi" value="${reportday_con.chengshi }"/>
						<input type="hidden" name="quyufl" id="quyufl" value="${reportday_con.quyufl }"/>
						<input type="hidden" name="whoactive" id="whoactive" />

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






<script type="text/javascript">
	//加载提示隐藏
	$(top.hangge());
	//提交后停留在当前页



	$(function () {

		window.onresize = myChartMap.resize();

		$('#dataGrid').bootstrapTable({
			method:"POST",
			//极为重要，缺失无法执行queryParams，传递page参数
			contentType : "application/x-www-form-urlencoded",
			dataType:"json",
			columns: [   {
				field: 'chengshi',
				title: '地市',
			}, {
				field: 'quyufl',
				title: '区县',
			}
				, {
					field: 'custom_num',
					title: '客户数',
				}
				, {
					field: 'login_rate',
					title: '登录率',
				}
				, {
					field: 'rq',
					title: '日期',
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


			url: 'report/listtest1', //服务器数据的加载地址
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
				shengfen:$("#shengfen").val(),
				chengshi:$("#chengshi").val(),
				quyufl:$("#quyufl").val(),
			};

			return param;
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
		window.location.href='<%=basePath%>user/excel.do?USERNAME='+USERNAME+'&lastLoginStart='+lastLoginStart+'&lastLoginEnd='+lastLoginEnd+'&ROLE_ID='+ROLE_ID;
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
