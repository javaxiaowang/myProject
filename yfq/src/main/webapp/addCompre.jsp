<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="zh-CN">

<head>
<title>添加综合数据</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<!-- VENDOR CSS -->
<link rel="stylesheet"
	href="assets/vendor/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="assets/vendor/linearicons/style.css">
<!-- MAIN CSS -->
<link rel="stylesheet" href="assets/css/main.css">
<!-- FOR DEMO PURPOSES ONLY. You should remove this in your project -->
<link rel="stylesheet" href="assets/css/demo.css">
<!-- GOOGLE FONTS -->
<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700"
	rel="stylesheet">
<!-- ICONS -->
<script src="js/jquery.min.js"></script>
<link rel="apple-touch-icon" sizes="76x76" href="img/login_logo_top.png">
<link rel="icon" type="image/png" sizes="96x96" href="img/web_icon.png">
<script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="assets/scripts/klorofil-common.js"></script>
<script src="myjs/customer.js"></script>
<!--引入我的js与css文件-->
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/normalize.css">
<link rel="stylesheet" href="css/pagination.css">
<script src="js/bootstrap.min.js"></script>
<script src="js/ajaxfileupload.js"></script>
<script src="js/jquery.pagination.min.js"></script>
</head>
<!--获取从上一页面传来的数据 -->
		<%-- <%
		request.setCharacterEncoding("utf-8");
		Long id=Long.parseLong(request.getParameter("id"));
		Integer quota=Integer.parseInt(request.getParameter("quota"));
		Integer userType=Integer.parseInt(request.getParameter("userType"));
		String clientWX = request.getParameter("beeWX");
		%>  --%>
<script type="text/javascript">
	$(function(){
			 //获取供应商信息
		   /*  $.ajax({
				url:"listSupplier",
		      	type:"post",
		      	crossDomain:true,
		      	async:true,
		      	dataType:"json",
		      	contentType: "application/json",
		      	success:function(data){
		      		 var lenth = data.data.length;
		      		 var str = "";
		      		  for(var i=0 ;i<=lenth;i++){
		      			$("#supplier").append("<option value='"+ data.data[i].id+"'>"+ data.data[i].supplier +"</option>");
		      			} 
		      	},
		      	error:function(){
		           alert("访问失败");
		           return false;
		      	}
		    });  */
		
		/*  function checkUser(){
		 	var password = $("#password").attr("value");
			var dpassword = $("#dpassword").attr("value");
			var auditPassWord = $("#auditPassWord").attr("value");
			var dauditPassWord = $("#dauditPassWord").attr("value");
			if(password==dpassword && auditPassWord==dauditPassWord){
			alert("两次输入一致");
			return true;
			}else{
			alert("两次输入不一致");
			return false
			}
		 } */
		  
		  /* 点击计算总价按钮 */
		 $("#count").click(function(){
		 	//先对内容进行判空
		  	var pacPeriods = $("#pacPeriods").val();
		  	var packageMouth = $("#packageMouth").val();
		  	//var bill = $("#bill").val();
		  	if(pacPeriods!=""&&packageMouth!=""){
		  		//套餐总价
				var Totalprice;
				Totalprice=(parseInt(pacPeriods*packageMouth));
		  		$("#totalprice").val(Totalprice);
		  		return true;
		  	}else{
		  		alert("提交的资料中不允许有空值！！！");
		  	}
		 });
		 /*点击提交按钮事件  */
		 $("#submit").click(function(){
		 	//先对内容进行判空
		 	//总价
		 	var price = $("#price").val();
		 	//期数
		  	var periods = $("#periods").val();
		  	//公司
		  	var company = $("#company").val();
		  	var phoneNumber = $("#phoneNumber").val();
		  	//手机数量
		  	if(price!=""&&periods!=""&&company!=""&&phoneNumber!=""){
		  		submit(price,company,periods,phoneNumber);
		  		return true;
		  	}else{
		  		alert("提交的资料中不允许有空值！！！");
		  		return false;
		  	}
		  	/* alert(totalprice+":"+quota);
		  	return false; */
		 });
		 //提交综合资料
		 function submit(price,company,periods,phoneNumber){
		 	$.ajax({
				url:"insertCompre",
		      	type:"post",
		      	crossDomain:true,
		      	async:true,
		      	dataType:"json",
		      	data: {price:price,company:company,periods:periods,phoneNumber:phoneNumber},
		      	success:function(data){
		      	if(data.status==="SUCCESS"){
		      		$("#packagemsg").html("公司综合数据保存完成");
		      		window.location.href="compreList?pageNum=1";
		      	}else{
		      		alert("新增失败");
		      	}
		      	},
		      	error:function(){
		           alert("新增失败，请仔细检查您提交的资料!!!");
		           return false;
		      	}
		    });
		 }
	});
	$(function(){
		//获取公司信息
		$.ajax({
				url:"listCompany",
		      	type:"post",
		      	crossDomain:true,
		      	async:true,
		      	dataType:"json",
		      	//contentType: "application/json",
		      	//data: {company:company},
		      	success:function(data){
		      		 var lenth = data.data.length;
		      		 for(var i=0 ;i<=lenth;i++){
		      			$("#company").append("<option value='"+ data.data[i].company+"'>"+ data.data[i].company +"</option>");
		      			}
		      		 /* $.each( data,function(){
						$("#brand").append("<option value='"+ this.data.id+"'>"+ this.data.attributevalue +"</option>");
						});   */
		      	},
		      	error:function(){
		          
		           return false;
		      	}
			});
	})
</script>
<body>
	<!-- <form action="">
	<div class="form-group">
    <label for="inputEmail3" class="col-sm-2 control-label" style="width: 100px">用户名：</label>
    <div class="col-sm-10">
      <input type="email" class="form-control" id="inputEmail3" placeholder="用户名" style="width: 500px">
    </div><br><br>
  </div>
  <div class="form-group">
    <label for="inputPassword3" class="col-sm-2 control-label" style="width: 100px">密码：</label>
    <div class="col-sm-10">
      <input type="password" class="form-control" id="inputPassword3" placeholder="密码" style="width: 500px">
    </div>
  </div>
  </form> -->
  <!--表单  -->
	 <div class="panel" style="width: 800px;height:600px;margin-left: 100px;margin-top: 10px">
		<div class="panel-heading">
			<h3 class="panel-title">添加综合数据</h3>
		</div>
		<div class="panel-body" >
			<form action="userInsertAndUpdate" method="post">
				 <label style="float: left;width: 80px;line-height: 34px">总金额</label>
				 <input id="price" type="text" required="required" class="form-control" placeholder="总金额" style="display: block;width: 50%">
				 <div style="float:left"><label id="phoneCheck" style="line-height: 34px;color: red"></label></div>
				 <br>
				 <br>
				 <br>
				<label style="float: left;width: 85px;line-height: 34px">选择公司</label>
				<select  id="company" class="form-control"style="width: 374px"  style="display: block;width: 100%">
					
				</select>
				 <br>
				
				<label style="float: left;width: 80px;line-height: 34px">手机数量</label>
				 <input id="phoneNumber" type="text"  required="required" class="form-control" placeholder="手机数量" style="display: block;width: 50%">
				<div style="float:left"><label id="modelCheck" style="line-height: 34px;color: red"></label></div>
				 <br> 
				 <br>
				 <br>
				 <label style="float: left;width: 85px;line-height: 34px">期数</label>
				<select id="periods" class="form-control" style="width: 374px" name="userType" style="display: block;width: 100%">
					 	<option selected="selected" value="12">12</option>
					  	<option value="24">24</option>
				</select>
				<br>
				 <!-- <label style="float: left;width: 80px;line-height: 34px">套餐详情</label>
				<textarea id="details"  rows="4" cols="20" class="form-control" style="display: block;width: 50%"></textarea>
				 <br> 
				 <br> -->
				<button id="submit" type="button" class="btn btn-info" style="width: 200px;">保存数据</button>
				<span id="packagemsg" style="color:green;"></span>
				<!-- <input id="submit" type="submit" class="btn btn-primary" value="新增"> -->
			</form>
		</div>
	</div> 
	<!-- <form action="userInsertAndUpdate">
		<input id="username" type="text" class="form-control" placeholder="用户名" name="username"><br>
		<input id="password" type="password" class="form-control" placeholder="密码"name="password"> 
		<input id="submit" type="submit" class="btn btn-primary">新增用户</button>
	</form> -->
</body>

</html>
