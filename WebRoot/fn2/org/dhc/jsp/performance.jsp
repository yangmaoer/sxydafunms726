 <%@ page language="java" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
    String rootPath = request.getContextPath();    
    String id = (String) request.getParameter("id"); 
    String type = (String) request.getParameter("type"); 
  //  System.out.println(id+"=========");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>性能信息</title>
<script type="text/javascript">

		function init(){
			//alert("=====");
			//window.resizeTo(100,100);
			window.open('<%=rootPath%>/flex/RightClickMenuShowData.swf?id=<%=id%>&type=<%=type%>','pingwindow','toolbar=no,height=400,width=800');
			window.open('','_top'); 
			window.top.close(1);
		}
</script>
</head>
<body onload="init()">
</body>
</html>