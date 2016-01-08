<%@page language="java" contentType="text/html;charset=gb2312" %>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%@page import="com.afunms.topology.model.*" %>
<%@page import="com.afunms.linkReport.manager.LinkReportInfo;"%>
<%
	String rootPath = request.getContextPath();
	LinkReportInfo cri=(LinkReportInfo)request.getAttribute("linkReport");
	String sendTime =(String)request.getAttribute("sendTime");
  	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String	startdate = sdf.format(new Date());
			String	todate = sdf.format(new Date());	
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<style type="text/css"></style>
	<script type="text/javascript" src="<%=rootPath%>/js/tree/Tree.js"></script>
	<script type="text/javascript" src="<%=rootPath%>/js/tree/common.js"></script>
	<script type="text/javascript" src="<%=rootPath%>/include/swfobject.js"></script>
	<script language="JavaScript" type="text/javascript" src="<%=rootPath%>/include/navbar.js"></script>
	<link href="<%=rootPath%>/resource/<%=com.afunms.common.util.CommonAppUtil.getSkinPath() %>css/global/global.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="<%=rootPath%>/resource/js/page.js"></script> 
	<script language="JavaScript" src="<%=rootPath%>/include/date.js"></script> 
	<script type="text/javascript"
			src="<%=rootPath%>/application/environment/resource/ext3.1/adapter/ext/ext-base.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=rootPath%>/js/ext/css/common.css" charset="utf-8"/>
	<script type="text/javascript"
			src="<%=rootPath%>/application/environment/resource/ext3.1/ext-all.js"></script>
	<script type="text/javascript" src="<%=rootPath%>/js/ext/lib/locale/ext-lang-zh_CN.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=rootPath%>/resource/js/jquery-1.4.2.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=rootPath%>/application/environment/resource/ext3.1/resources/css/ext-all.css" />

<script>
////////////////初始化树/////////////////////////
	var ddtree = null;
	function init()
	{
		parseDataForTree();
	}

	function parseDataForTree()
	{
		ddtree = new Tree("sorttree","100%","100%",0);
		ddtree.setImagePath("<%=rootPath%>/resource/image/tree/");
		ddtree.setDelimiter(",");
		ddtree.enableCheckBoxes(1);
		ddtree.insertNewItem("","root","链路资源树", 0, "", "","", "");
		<%
		List linkList = (ArrayList)request.getAttribute("listList");
		if(linkList != null){
			for(int i=0; i<linkList.size(); i++){
				Link link = (Link)linkList.get(i);
	%>
			ddtree.insertNewItem("root","<%=link.getId()%>","<%=link.getLinkName()%>", 0, "", "","", "");
	<%
			}
		}
		%>
		
	}
</script>

<script language="JavaScript" type="text/JavaScript">
	Ext.onReady(function()
	{  
		setTimeout(function(){
	        Ext.get('loading').remove();
	        Ext.get('loading-mask').fadeOut({remove:true});
	    }, 250);
	}); 
</script>

<script language="JavaScript" type="text/javascript">
	function CreateDeviceWindow(url)
	{
		msgWindow=window.open(url,"_blank","toolbar=no,width=900,height=400,directories=no,status=no,scrollbars=yes,menubar=no")
	}
	function CreateWindow(url)
	{	
 		msgWindow=window.open(url,"_blank","toolbar=no,width=600,height=400,directories=no,status=no,scrollbars=yes,menubar=no")
	}
</script>
</head>
<body id="body" class="body" onLoad="init();">
<IFRAME frameBorder=0 id=CalFrame marginHeight=0 marginWidth=0 noResize scrolling=no src="<%=rootPath%>/include/calendar.htm" style="DISPLAY: none; HEIGHT: 189px; POSITION: absolute; WIDTH: 148px; Z-INDEX: 100"></IFRAME>
	<form id="mainForm" method="post" name="mainForm">
		<div id="loading">
			<div class="loading-indicator">
				<img src="<%=rootPath%>/js/ext/lib/resources/extanim64.gif" width="32" height="32" style="margin-right: 8px;" align="middle" />Loading...
			</div>
		</div>
		<div id="loading-mask" style=""></div>
		<table id="body-container" class="body-container">
			<tr>
				<td valign=top style="margin: 10px auto;position :relative;">
					<table>
                		<tr>
               	 			<td colspan="2">
     							<div style=" height:36px; background:url('<%=rootPath%>/resource/image/tree/tit_bg.gif'); padding-left:30px; line-height:36px; font-size:20px; font-weight:bold; color:#fff;">报表模板详细信息
     							</div>
     						</td>
     					</tr>
     					<tr>
							<td  height="100%" align="left" valign="top">
								<div id="sorttree" style="margin-top: 0px; background-color: #FFFFFF;OVERFLOW-y:auto;OVERFLOW-x:auto;height:400;width:250;"></div>
							</td>
							<td width="80%" height="100%" valign="top">
								<table border="0" cellpadding="0" cellspacing="0" class="win-content" id="win-content">
									<tr >
										<td width=100% >
											<table cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" border=1>
												<tr>
													<td width="100%" align=left>
														<div id="editmodel" >
															<table border="0" id="table1" cellpadding="0" width="100%">
																<tr style="background-color: #FFFFFF;">
																	<TD nowrap align="right" height="24" width="10%">
																		报表名称&nbsp;
																	</TD>
																	<TD nowrap width="40%">
																		&nbsp;
																		<input type="text" name="report_name" id="report_name"
																			size="50" class="formStyle" size="50" value="<%=cri.getName() %>">
																		<font color='red'>*</font>
																	</TD>
																</tr>
																<tr style="background-color: #ECECEC;">
																	<TD nowrap align="right" height="24" width="10%">
																		报表接收人&nbsp;
																	</TD>
																	<TD nowrap width="40%">
																		&nbsp;
																		<input type="text" name="recievers_name" id="recievers_name"
																			size="50" class="formStyle" size="50" value="<%=cri.getUserName() %>" readonly>
																		<font color='red'>*</font>
																	</TD>
																</tr>
																<tr>
																	<TD nowrap align="right" height="24" width="10%">
																		邮件标题:&nbsp;
																	</TD>
																	<TD nowrap width="40%">
																		&nbsp;
																		<input type="text" name="tile" id="tile" size="50"
																			class="formStyle" value="<%=cri.getEmailTitle() %>">
																	</TD>
																</tr>
																<tr style="background-color: #ECECEC;">
																	<TD nowrap align="right" height="24" width="10%">
																		邮件描述:&nbsp;
																	</TD>
																	<TD nowrap width="40%">
																		&nbsp;
																		<input type="text" name="desc" id="desc" size="50"
																			class="formStyle" value="<%=cri.getEmailContent() %>">
																	</TD>
																</tr>
																<tr>
																	<td colspan= 2 >
																		<input type="checkbox" name="terms" value ="shangxing" <%if(cri.getTerms().indexOf("shangxing")>-1 ){ %>checked<%} %> readonly>链路上行流速&nbsp;&nbsp;
																		<input type="checkbox" name="terms" value ="xiaxing" <%if(cri.getTerms().indexOf("xiaxing")>-1 ){ %>checked<%} %> readonly>链路下行流速&nbsp;&nbsp;
																		<input type="checkbox" name="terms" value ="keyongxin" <%if(cri.getTerms().indexOf("keyongxin")>-1 ){ %>checked<%} %> readonly>链路可用性&nbsp;&nbsp;
																		<input type="checkbox" name="terms" value ="daikuan" <%if(cri.getTerms().indexOf("daikuan")>-1 ){ %>checked<%} %> readonly>链路带宽&nbsp;&nbsp;
																		<input type="checkbox" name="terms" value ="qushitu" <%if(cri.getTerms().indexOf("qushitu")>-1 ){ %>checked<%} %> readonly>链路带宽趋势图&nbsp;&nbsp;
																	</td>
																</tr>
																<tr>
																	<TD nowrap align="right" height="24" width="10%">
																		生成报表类型:&nbsp;
																	</TD>
																	<TD nowrap width="40%">
																		&nbsp;
																		<SELECT id="exporttype" name="exporttype">
																			<OPTION value="xls" <%if(cri.getAttachmentFormat().equals("xls")){ %>selected<%} %>>
																				Excel
																			</OPTION>
																			<OPTION value="doc" <%if(cri.getAttachmentFormat().equals("doc")){ %>selected<%} %>>
																				Word
																			</OPTION>
																			<OPTION value="pdf" <%if(cri.getAttachmentFormat().equals("pdf")){ %>selected<%} %>>
																				Pdf
																			</OPTION>
																		</SELECT>
																	</TD>
																</tr>
																<tr style="background-color: #ECECEC;">
																	<TD nowrap align="right" height="24">
																		日报报表生成时间:&nbsp;
																	</TD>
																	<td nowrap colspan="3">
																		&nbsp;
																		<%=sendTime %>
																	</td>
																</tr>
																<tr>
																	<TD nowrap colspan="4" align=center>
																		<br>
																			<input type="button" value="关闭" style="width: 50" class="formStylebutton" id="close" onclick='window.close()'>
																	</TD>
																</tr>
															</TABLE>
														</div>
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
</BODY>
</HTML>