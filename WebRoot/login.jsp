<%@page language="java" contentType="text/html;charset=GB2312"%>
<%@page import="org.apache.shiro.authc.* " %>
<%
  String rootPath = request.getContextPath();
	String loginExceptionName = (String)request.getAttribute("shiroLoginFailure");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>IT运维监控系统</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK"/>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta content="MSHTML 6.00.2800.1106" name=GENERATOR/>
<style type="text/css">
html,body{ background:#1e4765 url(<%=rootPath%>/resource/image/login_bg.jpg) no-repeat center 100px; font-family:Arial, Helvetica, sans-serif,"宋体"; font-size:12px;}
.box{width:500px; height:95px; margin:0 auto; margin-top:330px;}
.sr{ width:170px; background:none; color:#2a6a98; border:0; padding:3px 0;}
.user{ margin-left:40px;}
.password{ margin-left:100px;}
.txt{ line-height:35px; color:#f2f2f2; padding:20px 7px;}
.rememberme{
	display:block;
	font-size:1.5em;
	color:white;
	padding:10px 0;
}
.nav{ float:right; cursor:pointer; width:113px; height:35px; background:url(<%=rootPath%>/resource/image/login_nav.jpg) no-repeat; border:0;}
</style>
<!--<link href="<%=rootPath%>/common/css/bootstrap.min.css" rel="stylesheet" type="text/css"></link>
  -->
<script language="javascript">
function doLogin()
{
    if(mainForm.userid.value=="")
    {
       alert("请输入用户名!");
       mainForm.userid.focus();
       return false;
    }
    else if(mainForm.password.value=="")
    {
       alert("请输入密码!");
       mainForm.password.focus();
       return false;
    } 
}
<%
if(UnknownAccountException.class.getName().equals(loginExceptionName)){
	%>
	alert('没有这个用户。');
	<%
}else if(IncorrectCredentialsException.class.getName().equals(loginExceptionName)){
	%>
	alert('密码错误。');
	<%
}
%>
</script>


</head>

<body>
<div class="box">
<form method="POST" name="mainForm" action="<%=rootPath%>/login.jsp" onsubmit="return doLogin();">
<input name="userid" id="userid" type="text" class="sr user" />
<input name="password" id="password" type="password" class="sr password"/>
<label class="rememberme"><input type="checkbox" name="rememberMe" />记住我</label>
<div class="txt"><input name="Submit" type="submit" class="nav" value=""/>技术支持 | 东华软件股份公司</div>
</form>
</div>
</body>
</html>
