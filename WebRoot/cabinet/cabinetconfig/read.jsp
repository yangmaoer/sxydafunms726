<%@page language="java" contentType="text/html;charset=gb2312"%>
<%@ include file="/include/globe.inc"%>
<%@page import="java.util.List"%>
<%@page import="com.afunms.system.model.TimeShareConfig"%>
<%@page import="com.afunms.cabinet.model.MachineCabinet"%>
<%
	String rootPath = request.getContextPath();
	String menuTable = (String) request.getAttribute("menuTable");
	MachineCabinet vo = (MachineCabinet) request.getAttribute("vo");
	Object obj = request.getAttribute("isTreeView");
%>
<html>
	<head>

		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<script type="text/javascript"
			src="<%=rootPath%>/include/swfobject.js"></script>
		<script language="JavaScript" type="text/javascript"
			src="<%=rootPath%>/include/navbar.js"></script>

		<script type="text/javascript" src="<%=rootPath%>/resource/js/wfm.js"></script>

		<link
			href="<%=rootPath%>/resource/<%=com.afunms.common.util.CommonAppUtil.getSkinPath()%>css/global/global.css"
			rel="stylesheet" type="text/css" />

		<link rel="stylesheet" type="text/css"
			href="<%=rootPath%>/js/ext/lib/resources/css/ext-all.css"
			charset="gb2312" />
		<script type="text/javascript"
			src="<%=rootPath%>/js/ext/lib/adapter/ext/ext-base.js"
			charset="gb2312"></script>
		<script type="text/javascript"
			src="<%=rootPath%>/js/ext/lib/ext-all.js" charset="gb2312"></script>
		<script type="text/javascript"
			src="<%=rootPath%>/js/ext/lib/locale/ext-lang-zh_CN.js"
			charset="gb2312"></script>

		<!--nielin add for timeShareConfig at 2010-01-04 start-->
		<script type="text/javascript"
			src="<%=rootPath%>/application/resource/js/timeShareConfigdiv.js"
			charset="gb2312"></script>
		<!--nielin add for timeShareConfig at 2010-01-04 end-->

		<!-- snow add for gatherTime at 2010-5-12 start -->
		<script type="text/javascript"
			src="<%=rootPath%>/application/resource/js/addTimeConfig.js"
			charset="gb2312"></script>
		<script type="text/javascript"
			src="<%=rootPath%>/application/resource/js/jquery-1.4.2.js"
			charset="gb2312"></script>
		<script type="text/javascript">
	$(addTimeConfigRow);//addTimeConfigRow函数在application/resource/js/addTimeConfig.js中 
</script>
		<!-- snow add for gatherTime at 2010-5-12 end -->


		<script language="JavaScript" type="text/javascript">


  Ext.onReady(function()
{  

setTimeout(function(){
	        Ext.get('loading').remove();
	        Ext.get('loading-mask').fadeOut({remove:true});
	    }, 250);
	
 Ext.get("process").on("click",function(){     
        Ext.MessageBox.wait('数据加载中，请稍后.. '); 
        //msg.style.display="block";
        mainForm.action = "<%=rootPath%>/maccabinet.do?action=edit";
        mainForm.submit(); 
       // mainForm.submit();
 });	
	
});
//-- nielin modify at 2010-01-04 start ----------------
function CreateWindow(url)
{
	
msgWindow=window.open(url,"protypeWindow","toolbar=no,width=600,height=400,directories=no,status=no,scrollbars=yes,menubar=no")
}    

function setReceiver(eventId){
	var event = document.getElementById(eventId);
	return CreateWindow('<%=rootPath%>/user.do?action=setReceiver&event='+event.id+'&value='+event.value);
}
//-- nielin modify at 2010-01-04 end ----------------

//-- nielin add at 2010-07-27 start ----------------
function setBid(eventTextId , eventId){
	var event = document.getElementById(eventId);
	return CreateWindow('<%=rootPath%>/business.do?action=setBid&event='+event.id+'&value='+event.value + '&eventText=' + eventTextId);
}
//-- nielin add at 2010-07-27 end ----------------


</script>

		<script language="JavaScript" type="text/JavaScript">
var show = true;
var hide = false;
//修改菜单的上下箭头符号
function my_on(head,body)
{
	var tag_a;
	for(var i=0;i<head.childNodes.length;i++)
	{
		if (head.childNodes[i].nodeName=="A")
		{
			tag_a=head.childNodes[i];
			break;
		}
	}
	tag_a.className="on";
}
function my_off(head,body)
{
	var tag_a;
	for(var i=0;i<head.childNodes.length;i++)
	{
		if (head.childNodes[i].nodeName=="A")
		{
			tag_a=head.childNodes[i];
			break;
		}
	}
	tag_a.className="off";
}
//添加菜单	
function initmenu()
{
	var idpattern=new RegExp("^menu");
	var menupattern=new RegExp("child$");
	var tds = document.getElementsByTagName("div");
	for(var i=0,j=tds.length;i<j;i++){
		var td = tds[i];
		if(idpattern.test(td.id)&&!menupattern.test(td.id)){					
			menu =new Menu(td.id,td.id+"child",'dtu','100',show,my_on,my_off);
			menu.init();		
		}
	}
	timeShareConfiginit(); // nielin add for time-sharing at 2010-01-04
}

</script>
	</head>
	<body id="body" class="body" onload="initmenu();">
		<form id="mainForm" method="post" name="mainForm">
			<input type="hidden" id="id" name="id" value="<%=vo.getId()%>">
			<table id="body-container" class="body-container">
				<tr>
					<%
						if (null == obj) {
					%>
					<td class="td-container-menu-bar">
						<table id="container-menu-bar" class="container-menu-bar">
							<tr>
								<td>
									<%=menuTable%>
								</td>
							</tr>
						</table>
					</td>
					<%
						}
					%>
					<td class="td-container-main">
						<table id="container-main" class="container-main">
							<tr>
								<td class="td-container-main-add">
									<table id="container-main-add" class="container-main-add">
										<tr>
											<td>
												<table id="add-content" class="add-content">
													<tr>
														<td>
															<table id="add-content-header" class="add-content-header">
																<tr>
																	<td align="left" width="5"><img src="<%=rootPath%>/common/images/right_t_01.jpg" width="5" height="29" /></td>
																	<td class="add-content-title">应用 &gt;&gt; 机柜管理 &gt;&gt; 详细</td>
																	<td align="right"><img src="<%=rootPath%>/common/images/right_t_03.jpg" width="5" height="29" /></td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td>
															<table id="detail-content-body" class="detail-content-body">
																<tr>
																	<td>
																		<table cellspacing="1">
																			<tr style="">
																				<td align="right" height="24" width="10%">名称:&nbsp;</td>
																				<td width="40%">&nbsp;<%=vo.getName()%></td>
																				<td align="right" height="24" width="10%">所属机房:&nbsp;</td>
																				<td width="40%">&nbsp;<%=vo.getMotorroom()%></td>
																			</tr>
																			<tr style="background-color: #ECECEC;">
																				<td align="right" height="24" width="10%">机房X位置:&nbsp;</td>
																				<td width="40%">&nbsp;<%=vo.getMachinex()%></td>
																				<td align="right" height="24" width="10%">机房Y位置:&nbsp;</td>
																				<td width="40%">&nbsp;<%=vo.getMachiney()%></td>
																			</tr>
																			<tr style="">
																				<td align="right" height="24" width="10%">机房Z位置:&nbsp;</td>
																				<td width="40%">&nbsp;<%=vo.getMachinez()%></td>
																				<td align="right" height="24" width="10%">U:&nbsp;</td>
																				<td width="40%">&nbsp;<%=vo.getUselect()%></td>
																			</tr>
																			<tr style="background-color: #ECECEC;">
																				<td align="right" height="24" width="10%">机架规格:&nbsp;</td>
																				<td width="40%">&nbsp;<%=vo.getStandards()%></td>
																				<td align="right" height="24" width="10%">电源个数:&nbsp;</td>
																				<td width="40%">&nbsp;<%=vo.getPowers()%></td>
																			</tr>
																			<tr style="">
																				<td align="right" height="24" width="10%">高度(CM):&nbsp;</td>
																				<td width="40%">&nbsp;<%=vo.getHeights()%></td>
																				<td align="right" height="24" width="10%">宽度(CM):&nbsp;</td>
																				<td width="40%">&nbsp;<%=vo.getWidths()%></td>
																			</tr>
																			<tr style="background-color: #ECECEC;">
																				<td align="right" height="24" width="10%">深度(CM):&nbsp;</td>
																				<td width="40%">&nbsp;<%=vo.getDepths()%></td>
																				<td align="right" height="24" width="10%">机柜编号:&nbsp;</td>
																				<td width="40%">&nbsp;<%=vo.getNos()%></td>
																			</tr>
																			<tr>
																				<td colspan="4" align=center><br><input type="reset" style="width: 50" value="返回" onclick="javascript:history.back(1)"></td>
																			</tr>
																		</table>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td>
															<table id="detail-content-footer" class="detail-content-footer">
																<tr>
																	<td>
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td align="left" valign="bottom"><img src="<%=rootPath%>/common/images/right_b_01.jpg" width="5" height="12" /></td>
																				<td></td>
																				<td align="right" valign="bottom"><img src="<%=rootPath%>/common/images/right_b_03.jpg" width="5" height="12" /></td>
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
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</BODY>
</HTML>