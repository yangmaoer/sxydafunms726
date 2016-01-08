<%@page language="java" contentType="text/html;charset=GB2312"%>
<%@page import="com.afunms.system.model.*"%>
<%@page import="com.afunms.common.base.JspPage"%>
<%@page import="java.util.List"%>
<%@page import="com.afunms.system.util.*"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/include/globe.inc"%>
<%
	String rootPath = request.getContextPath();
	List list = (List) request.getAttribute("list");
	JspPage jp = (JspPage) request.getAttribute("page");
	UserView view = new UserView();
%>
<%
	String menuTable = (String) request.getAttribute("menuTable");
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<script language="JavaScript" type="text/javascript"src="<%=rootPath%>/include/navbar.js"></script>
		<script type="text/javascript" src="<%=rootPath%>/resource/js/page.js"></script>

		<link href="<%=rootPath%>/resource/<%=com.afunms.common.util.CommonAppUtil.getSkinPath() %>css/global/global.css"
			rel="stylesheet" type="text/css" />

		<script language="JavaScript" type="text/javascript">
	/**
	*��ʾ ɾ�� ���ӷ���
	*/		
  var listAction = "<%=rootPath%>/resourceAllocation.do?action=resourcelist";
  var delAction = "<%=rootPath%>/resourceAllocation.do?action=delete";
  var curpage= <%=jp.getCurrentPage()%>;
  var totalpages = <%=jp.getPageTotal()%>;
  function toAdd()
  {
     mainForm.action = "<%=rootPath%>/resourceAllocation.do?action=ready_add";
     mainForm.submit();
  }

</script>
		<script language="JavaScript" type="text/JavaScript">
var show = true;
var hide = false;
//�޸Ĳ˵������¼�ͷ����
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
//���Ӳ˵�	
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

}

</script>
	</head>
	<body id="body" class="body" onload="initmenu();">
		<form id="mainForm" method="post" name="mainForm">
			<table id="body-container" class="body-container">
				<tr>
					<td class="td-container-menu-bar">
						<table id="container-menu-bar" class="container-menu-bar">
							<tr>
								<td>
									<%=menuTable%>
								</td>	
							</tr>
						</table>
					</td>
					<td class="td-container-main">
						<table id="container-main" class="container-main">
							<tr>
								<td class="td-container-main-content">
									<table id="container-main-content" class="container-main-content">
										<tr>
											<td>
												<table id="content-header" class="content-header">
								                	<tr>
									                	<td align="left" width="5"><img src="<%=rootPath%>/common/images/right_t_01.jpg" width="5" height="29" /></td>
									                	<td class="content-title"> ϵͳ���� >> ά�������� >> �����б� </td>
									                    <td align="right"><img src="<%=rootPath%>/common/images/right_t_03.jpg" width="5" height="29" /></td>
									       			</tr>
									        	</table>
		        							</td>
		        						</tr>
										<tr>
		        							<td>
		        								<table id="content-body" class="content-body">
		        									<tr >
		        										<td>
															<table>
																<tr>
																	<td class="body-data-title" style="text-align: right;">
																		<a href="#" onclick="toAdd()">����</a>
																		<a href="#" onclick="toDelete()">ɾ��</a>&nbsp;&nbsp;&nbsp;
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td>
															<table>
																<tr>
									    							<td class="body-data-title">
																		<jsp:include page="../../common/page.jsp">
																			<jsp:param name="curpage" value="<%=jp.getCurrentPage()%>" />
																			<jsp:param name="pagetotal" value="<%=jp.getPageTotal()%>" />
																		</jsp:include>
														    		</td>
			        											</tr>
															</table>
														</td>
													</tr>
													<tr>
		        										<td>
		        											<table>
		        												<tr>
																	<td align="center" class="body-data-title">
																		<INPUT type="checkbox" class=noborder name="checkall"
																			onclick="javascript:chkall()">
																	</td>
																	<td align="center" class="body-data-title">
																		ID
																	</td>
																	<td align="center" class="body-data-title">
																		����
																	</td>
																	<td align="center" class="body-data-title">
																		ά����
																	</td>
																	<td align="center" class="body-data-title">
																		����ʱ��
																	</td>
																	<td align="center" class="body-data-title">
																		����ʱ��
																	</td>
																	<td align="center" class="body-data-title">
																		״̬
																	</td>
																	<td align="center" class="body-data-title">
																		������Ϣ
																	</td>
																	<td align="center" class="body-data-title">
																		ά������
																	</td>
																	<td align="center" class="body-data-title">
																		����
																	</td>
																</tr>
																<%
																	ResourceConf vo = null;
																	int startRow = jp.getStartRow();
																	for (int i = 0; i < list.size(); i++) {
																		vo = (ResourceConf) list.get(i);
																		int id=vo.getId();
																		String confititle=vo.getConfititle();
																		String logname=vo.getLogname();
																		String startdate=vo.getStartdate();
																		String endDate=vo.getEnddate();
																		String state = null;
																		if(vo.getState().equals("1")){
																			state = "ֹͣ";
																		}else if(vo.getState().equals("0")){
																			state = "�";										state ="�";
																		}
																		
																		String desc = vo.getResourcedesc();
																%>
																<tr>
																	<td align="center" class="body-data-list" id="id">
																		<INPUT type="checkbox" class="noborder" name="checkbox" value="<%=id%>">
																	</td>
																	<td align="center" class="body-data-list" id="id">
																			<%=id%>
																	</td>
																	<td align="center" class="body-data-list" id="title"><%=confititle %></td>
																	<td align="center" class="body-data-list" id="maintainer"><%=logname %></td>
																	<td align="center" class="body-data-list" id="startDate"><%=startdate %></td>
																	<td align="center" class="body-data-list" id="endDate"><%=endDate %></td>
																	<td align="center" class="body-data-list" id="state"><%=state %></td>
																	<td align="center" class="body-data-list" id="describe"><%=desc %></td>
																	<!----><td align="center" class="body-data-list">
																		<a href="javascript:void(null)"  onClick='window.open("<%=rootPath%>/resourceConfigNode.do?action=list&id=<%=id%>","oneping", "height=600, width= 1000, top=300, left=100,scrollbars=yes")'>
																			<img src="<%=rootPath%>/resource/image/editicon.gif" border="0"/>
																		</a>
																	</td>
																	<td align="center" class="body-data-list">
																		<a href="<%=rootPath%>/resourceAllocation.do?action=ready_edit&id=<%=id%>">
																			<img src="<%=rootPath%>/resource/image/editicon.gif" border="0"/>
																		</a>
																	</td>
																</tr>
																<%
																	}
																%>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
		        							<td>
		        								<table id="content-footer" class="content-footer">
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
		</form>
	</BODY>
</HTML>