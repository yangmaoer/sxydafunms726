﻿<%@page language="java" contentType="text/html;charset=UTF-8"%>
<%@page import="com.afunms.topology.model.HostNode"%>
<%@page import="com.afunms.common.base.JspPage"%>
<%@page import="com.afunms.common.util.SysUtil"%>
<%@ include file="/include/globe.inc"%>
<%@page import="com.afunms.common.util.*" %>
<%@page import="com.afunms.monitor.item.*"%>
<%@page import="com.afunms.polling.node.*"%>
<%@page import="com.afunms.polling.*"%>
<%@page import="com.afunms.polling.impl.*"%>
<%@page import="com.afunms.polling.api.*"%>
<%@page import="com.afunms.topology.util.NodeHelper"%>
<%@page import="com.afunms.topology.dao.*"%>
<%@page import="com.afunms.monitor.item.base.MoidConstants"%>
<%@page import="org.jfree.data.general.DefaultPieDataset"%>
<%@ page import="com.afunms.polling.api.I_Portconfig"%>
<%@ page import="com.afunms.polling.om.Portconfig"%>
<%@ page import="com.afunms.polling.om.*"%>
<%@ page import="com.afunms.polling.impl.PortconfigManager"%>
<%@page import="com.afunms.report.jfree.ChartCreator"%>
<%@page import="com.afunms.config.dao.IpAliasDao" %>
<%@page import="com.afunms.config.model.IpAlias" %>

<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.lang.*"%>
<%@page import="com.afunms.monitor.item.base.*"%>
<%@page import="com.afunms.monitor.executor.base.*"%>
<%
  	//String rootPath = request.getContextPath();;
  
  	String tmp = request.getParameter("id"); 
	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	double cpuvalue = 0;
	String pingconavg ="0";
	String collecttime = null;
	String sysuptime = null;
	String sysservices = null;
	String sysdescr = null;
		
	String hostname = "";
	String porcessors = "";
	String sysname = "";
	String SerialNumber = "";
	String CSDVersion = "";
	String mac = "";
		
    	HostNodeDao hostdao = new HostNodeDao();
    	List hostlist = hostdao.loadHost();
    	
    	Host host = (Host)PollingEngine.getInstance().getNodeByID(Integer.parseInt(tmp)); 
    	String ipaddress = host.getIpAddress();
    	String orderflag = request.getParameter("orderflag");
    	if(orderflag == null || orderflag.trim().length()==0)
    		orderflag="index";
        String[] time = {"",""};
        DateE datemanager = new DateE();
        Calendar current = new GregorianCalendar();
        current.set(Calendar.MINUTE,59);
        current.set(Calendar.SECOND,59);
        time[1] = datemanager.getDateDetail(current);
        current.add(Calendar.HOUR_OF_DAY,-1);
        current.set(Calendar.MINUTE,0);
        current.set(Calendar.SECOND,0);
        time[0] = datemanager.getDateDetail(current);
        String starttime = time[0];
        String endtime = time[1];
        
        I_HostLastCollectData hostlastmanager=new HostLastCollectDataManager();
        
        Vector vector = new Vector();
        String[] netInterfaceItem={"index","ifDescr","ifSpeed","ifOperStatus","OutBandwidthUtilHdx","InBandwidthUtilHdx"};
        try{
        	vector = hostlastmanager.getInterface_share(host.getIpAddress(),netInterfaceItem,orderflag,starttime,endtime); 
        	//System.out.println(host.getIpAddress()+"===vec size===="+vector.size());
        }catch(Exception e){
        	e.printStackTrace();
        }
        Hashtable hostinfohash = new Hashtable();
        List networkconfiglist = new ArrayList();
        List cpulist = new ArrayList();
        
		Hashtable ipAllData = (Hashtable)ShareData.getSharedata().get(host.getIpAddress());
		if(ipAllData != null){
			hostinfohash = (Hashtable)ipAllData.get("hostinfo");
			networkconfiglist = (List)ipAllData.get("networkconfig");
			cpulist = (List)hostinfohash.get("CPUname");
			hostname = (String)hostinfohash.get("Hostname");
			porcessors = (String)hostinfohash.get("NumberOfProcessors");
			sysname = (String)hostinfohash.get("Sysname");
			SerialNumber = (String)hostinfohash.get("SerialNumber");
			CSDVersion = (String)hostinfohash.get("CSDVersion");
			if(networkconfiglist != null && networkconfiglist.size()>0){
				for(int i=0;i<networkconfiglist.size();i++){
					Hashtable rvalue = (Hashtable)networkconfiglist.get(i);
					if(rvalue.containsKey("MACAddress")){
						mac = mac+(String)rvalue.get("MACAddress")+",";
					}
				}
			}		
			Vector cpuV = (Vector)ipAllData.get("cpu");
			if(cpuV != null && cpuV.size()>0){
				
				CPUcollectdata cpu = (CPUcollectdata)cpuV.get(0);
				cpuvalue = new Double(cpu.getThevalue());
			}
			//得到系统启动时间
			Vector systemV = (Vector)ipAllData.get("system");
			if(systemV != null && systemV.size()>0){
				for(int i=0;i<systemV.size();i++){
					Systemcollectdata systemdata=(Systemcollectdata)systemV.get(i);
					if(systemdata.getSubentity().equalsIgnoreCase("sysUpTime")){
						sysuptime = systemdata.getThevalue();
					}
					if(systemdata.getSubentity().equalsIgnoreCase("sysServices")){
						sysservices = systemdata.getThevalue();
					}
					if(systemdata.getSubentity().equalsIgnoreCase("sysDescr")){
						sysdescr = systemdata.getThevalue();
					}
				}
			}
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String time1 = sdf.format(new Date());
								
	
		String starttime1 = time1 + " 00:00:00";
		String totime1 = time1 + " 23:59:59";
		
		Hashtable ConnectUtilizationhash = new Hashtable();
		I_HostCollectData hostmanager=new HostCollectDataManager();
		try{
			ConnectUtilizationhash = hostmanager.getCategory(host.getIpAddress(),"Ping","ConnectUtilization",starttime1,totime1);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		if (ConnectUtilizationhash.get("avgpingcon")!=null){
			pingconavg = (String)ConnectUtilizationhash.get("avgpingcon");
			pingconavg = pingconavg.replace("%", "");
		}
		
		
		Vector pingData = (Vector)ShareData.getPingdata().get(host.getIpAddress());
		if(pingData != null && pingData.size()>0){
			Pingcollectdata pingdata = (Pingcollectdata)pingData.get(0);
			Calendar tempCal = (Calendar)pingdata.getCollecttime();							
			Date cc = tempCal.getTime();
			collecttime = sdf1.format(cc);
		}
		
        	request.setAttribute("vector", vector);
        	request.setAttribute("id", tmp);
        	request.setAttribute("ipaddress", host.getIpAddress());
		request.setAttribute("cpuvalue", cpuvalue);
		request.setAttribute("collecttime", collecttime);
		request.setAttribute("sysuptime", sysuptime);
		request.setAttribute("sysservices", sysservices);
		request.setAttribute("sysdescr", sysdescr);
		request.setAttribute("pingconavg", new Double(pingconavg));




  
String[] memoryItem={"AllSize","UsedSize","Utilization"};
String[] memoryItemch={"总容量","已用容量","当前利用率","最大利用率"};
String[] sysItem={"sysName","sysUpTime","sysContact","sysLocation","sysServices","sysDescr"};
String[] sysItemch={"设备名","设备启动时间","设备联系","设备位置","设备服务","设备描述"};
Hashtable hash = (Hashtable)request.getAttribute("hash");
Hashtable hash1 = (Hashtable)request.getAttribute("hash1");
Hashtable max = (Hashtable) request.getAttribute("max");
Hashtable imgurl = (Hashtable)request.getAttribute("imgurl");

double avgpingcon = (Double)request.getAttribute("pingconavg");

int percent1 = Double.valueOf(avgpingcon).intValue();
int percent2 = 100-percent1;
int cpuper = Double.valueOf(cpuvalue).intValue();

  String rootPath = request.getContextPath();  
  
  //ResponseTimeItem item1 = (ResponseTimeItem)host.getMoidList().get(0); 
  String chart1 = null,chart2 = null,chart3 = null,responseTime = null;
  DefaultPieDataset dpd = new DefaultPieDataset();
  dpd.setValue("可用率",avgpingcon);
  dpd.setValue("不可用率",100 - avgpingcon);
  chart1 = ChartCreator.createPieChart(dpd,"",130,130);  
  
  //if(item1.getSingleResult()!=-1)
  //{
     //responseTime = item1.getSingleResult() + " ms";
  
     //SnmpItem item2 = (SnmpItem)host.getItemByMoid(MoidConstants.CISCO_CPU);
     //if(item2!=null&&item2.getSingleResult()!=-1)
         //chart2 = ChartCreator.createMeterChart(item2.getSingleResult(),"",150,150); 
         chart2 = ChartCreator.createMeterChart(cpuvalue,"",120,120);   
  
     //SnmpItem item3 = (SnmpItem)host.getItemByMoid(MoidConstants.CISCO_MEMORY);
     //if(item3!=null&&item3.getSingleResult()!=-1)
        chart3 = ChartCreator.createMeterChart(40.0,"",120,120);       
  //}
  //else
     //responseTime = "无响应"; 
     
     Vector ifvector = (Vector)request.getAttribute("vector"); 				  	   
%>
<%String menuTable = (String)request.getAttribute("menuTable");%>
<html>
<head>
<script language="JavaScript" type="text/javascript" src="<%=rootPath%>/include/navbar.js"></script>
<link href="<%=rootPath%>/resource/<%=com.afunms.common.util.CommonAppUtil.getSkinPath() %>css/global/global.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" 	href="<%=rootPath%>/js/ext/lib/resources/css/ext-all.css" charset="utf-8" />
<link rel="stylesheet" type="text/css" href="<%=rootPath%>/js/ext/css/common.css" charset="utf-8"/>
<script type="text/javascript" 	src="<%=rootPath%>/js/ext/lib/adapter/ext/ext-base.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=rootPath%>/js/ext/lib/ext-all.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=rootPath%>/js/ext/lib/locale/ext-lang-zh_CN.js" charset="utf-8"></script>
<LINK href="<%=rootPath%>/resource/css/style.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="<%=rootPath%>/resource/js/page.js"></script> 

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<LINK href="<%=rootPath%>/resource/css/itsm_style.css" type="text/css" rel="stylesheet">
<link href="<%=rootPath%>/resource/css/detail.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=rootPath%>/resource/css/style.css" type="text/css">
<link href="<%=rootPath%>/include/mainstyle.css" rel="stylesheet" type="text/css">
<script language="javascript">	
  
  Ext.onReady(function()
{  

setTimeout(function(){
	        Ext.get('loading').remove();
	        Ext.get('loading-mask').fadeOut({remove:true});
	    }, 250);
	
	
	
});

  function doQuery()
  {  
     if(mainForm.key.value=="")
     {
     	alert("请输入查询条件");
     	return false;
     }
     mainForm.action = "<%=rootPath%>/network.do?action=find";
     mainForm.submit();
  }
  
    function toGetConfigFile()
  {
        msg.style.display="block";
        mainForm.action = "<%=rootPath%>/cfgfile.do?action=getcfgfile&ipaddress=<%=host.getIpAddress()%>";
        mainForm.submit();
  }
  
  function doChange()
  {
     if(mainForm.view_type.value==1)
        window.location = "<%=rootPath%>/topology/network/index.jsp";
     else
        window.location = "<%=rootPath%>/topology/network/port.jsp";
  }

  function toAdd()
  {
      mainForm.action = "<%=rootPath%>/network.do?action=ready_add";
      mainForm.submit();
  }
  
function changeOrder(para){
  	location.href="<%=rootPath%>/detail/hostutilhdx.jsp?id=<%=tmp%>&ipaddress=<%=host.getIpAddress()%>&orderflag="+para;
} 
function openwin3(operate,index,ifname) 
{	
        window.open ("<%=rootPath%>/monitor.do?action="+operate+"&id=<%=tmp%>&ipaddress=<%=host.getIpAddress()%>&ifindex="+index+"&ifname="+ifname, "newwindow", "height=500, width=600, toolbar= no, menubar=no, scrollbars=yes, resizable=yes, location=yes, status=yes") 
} 

</script>
<script language="JavaScript">

	//公共变量
	var node="";
	var ipaddress="";
	var operate="";
	/**
	*根据传入的id显示右键菜单
	*/
	function showMenu(id,nodeid,ip)
	{	
		ipaddress=ip;
		node=nodeid;
		//operate=oper;
	    if("" == id)
	    {
	        popMenu(itemMenu,100,"100");
	    }
	    else
	    {
	        popMenu(itemMenu,100,"1111");
	    }
	    event.returnValue=false;
	    event.cancelBubble=true;
	    return false;
	}
	/**
	*显示弹出菜单
	*menuDiv:右键菜单的内容
	*width:行显示的宽度
	*rowControlString:行控制字符串，0表示不显示，1表示显示，如“101”，则表示第1、3行显示，第2行不显示
	*/
	function popMenu(menuDiv,width,rowControlString)
	{
	    //创建弹出菜单
	    var pop=window.createPopup();
	    //设置弹出菜单的内容
	    pop.document.body.innerHTML=menuDiv.innerHTML;
	    var rowObjs=pop.document.body.all[0].rows;
	    //获得弹出菜单的行数
	    var rowCount=rowObjs.length;
	    //alert("rowCount==>"+rowCount+",rowControlString==>"+rowControlString);
	    //循环设置每行的属性
	    for(var i=0;i<rowObjs.length;i++)
	    {
	        //如果设置该行不显示，则行数减一
	        var hide=rowControlString.charAt(i)!='1';
	        if(hide){
	            rowCount--;
	        }
	        //设置是否显示该行
	        rowObjs[i].style.display=(hide)?"none":"";
	        //设置鼠标滑入该行时的效果
	        rowObjs[i].cells[0].onmouseover=function()
	        {
	            this.style.background="#397DBD";
	            this.style.color="white";
	        }
	        //设置鼠标滑出该行时的效果
	        rowObjs[i].cells[0].onmouseout=function(){
	            this.style.background="#F1F1F1";
	            this.style.color="black";
	        }
	    }
	    //屏蔽菜单的菜单
	    pop.document.oncontextmenu=function()
	    {
	            return false; 
	    }
	    //选择右键菜单的一项后，菜单隐藏
	    pop.document.onclick=function()
	    {
	        pop.hide();
	    }
	    //显示菜单
	    pop.show(event.clientX-1,event.clientY,width,rowCount*25,document.body);
	    return true;
	}
	function detail()
	{
	    //location.href="<%=rootPath%>/detail/dispatcher.jsp?id="+node;
	    window.open ("<%=rootPath%>/monitor.do?action=show_hostutilhdx&id=<%=tmp%>&ipaddress=<%=host.getIpAddress()%>&ifindex="+node+"&ifname="+ipaddress, "newwindow", "height=500, width=600, toolbar= no, menubar=no, scrollbars=yes, resizable=yes, location=yes, status=yes");
	}
	function portset()
	{
		window.open ("<%=rootPath%>/panel.do?action=show_portreset&ipaddress=<%=host.getIpAddress()%>&ifindex="+node, "newwindow", "height=200, width=600, toolbar= no, menubar=no, scrollbars=yes, resizable=yes, location=yes, status=yes");
	}	
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

}

function setClass(){
	document.getElementById('hostDetailTitle-1').className='detail-data-title';
	document.getElementById('hostDetailTitle-1').onmouseover="this.className='detail-data-title'";
	document.getElementById('hostDetailTitle-1').onmouseout="this.className='detail-data-title'";
}


//网络设备的ip地址
function modifyIpAliasajax(ipaddress){
	var t = document.getElementById('ipalias'+ipaddress);
	var ipalias = t.options[t.selectedIndex].text;//获取下拉框的值
	$.ajax({
			type:"GET",
			dataType:"json",
			url:"<%=rootPath%>/networkDeviceAjaxManager.ajax?action=modifyIpAlias&ipaddress="+ipaddress+"&ipalias="+ipalias,
			success:function(data){
				window.alert("修改成功！");
			}
		});
}
$(document).ready(function(){
	//$("#testbtn").bind("click",function(){
	//	gzmajax();
	//});
//setInterval(modifyIpAliasajax,60000);
});
</script>

</head>
<BODY leftmargin="0" topmargin="0" bgcolor="#cedefa" onload="initmenu();">

	<div id="itemMenu" style="display: none";>
	<table border="1" width="100%" height="100%" bgcolor="#F1F1F1"
		style="border: thin" cellspacing="0">
		<tr>
			<td style="cursor: default; border: outset 1;" align="center"
				onclick="parent.detail()">查看状态</td>
		</tr>	
	</table>
	</div>

<form method="post" name="mainForm">
<input type=hidden name="orderflag">
<input type=hidden name="id">
<div id="loading">
	<div class="loading-indicator">
	<img src="<%=rootPath%>/js/ext/lib/resources/extanim64.gif" width="32" height="32" style="margin-right: 8px;" align="middle" />Loading...</div>
</div>
<div id="loading-mask" style=""></div>
<table border="0" id="table1" cellpadding="0" cellspacing="0" width=1000>
	<tr>
		<td width="200" valign=top align=center>
			<%=menuTable%>
		</td>
		<td bgcolor="#cedefa" align="left" valign="top">
			<table border="0" id="table1" cellpadding="0" cellspacing="0" width=100%>
				<tr>
					<td width="0"></td>
					<td align="left">
						<table width="100%" border=0 cellpadding=0 cellspacing=0>
							<tr>
							  	<td height=385 bgcolor="#FFFFFF" valign="top">
									<table width="100%" style="BORDER-COLLAPSE: collapse" borderColor=#cedefa cellPadding=0 rules=none align=center border=1 algin="center">
		                  				<tr>
		                    				<td>
												<table width="100%" style="BORDER-COLLAPSE: collapse" borderColor=#cedefa cellPadding=0 rules=none w align=center border=1 algin="center">
		                        					<tbody>
		                          						<tr>
															<td>
																<jsp:include page="/topology/includejsp/systeminfo_hostwmi.jsp">
																	 <jsp:param name="rootPath" value="<%= rootPath %>"/>
																	 <jsp:param name="tmp" value="<%= tmp %>"/> 
																	 <jsp:param name="collecttime" value="<%= collecttime %>"/> 
																	 <jsp:param name="sysuptime" value="<%= sysuptime %>"/> 
																	 <jsp:param name="sysdescr" value="<%= sysdescr %>"/> 
																	 <jsp:param name="percent1" value="<%= percent1 %>"/> 
																	 <jsp:param name="percent2" value="<%= percent2 %>"/> 
																	 <jsp:param name="cpuper" value="<%= cpuper %>"/>  
																 </jsp:include>
															</td>																			
			                								<td width="200" align="center" valign="middle" class=dashLeft> 
			                								
			            									</td>
			                								<td width="200" align="left" valign="top" class=dashLeft>
																<table width="100%" style="BORDER-COLLAPSE: collapse" borderColor=#cedefa cellPadding=0 rules=none w align=center border=1 algin="center">
			                        								<tbody>                     										                        								
			                    										<tr algin="left" valign="center">                      														
			                      											<td height="28" align="left" bordercolor="#9FB0C4" bgcolor="#D1DDF5" class="txtGlobalBold">&nbsp;工具</td>
			                    										</tr>
			                    										<tr align="left" valign="center"> 
			                    											<td height="28" align="left">&nbsp;<img src="<%=rootPath%>/resource/image/cancelMng.gif">&nbsp;<a href="<%=rootPath%>/tool/ping.jsp?ipaddress=<%=host.getIpAddress()%>" target=_blank>取消管理</td>
			                    										</tr> 
			                    										<!--<tr align="left" valign="center"> 
			                    											<td height="28" align="left">&nbsp;<img src="<%=rootPath%>/resource/image/delete2.gif">&nbsp;<a href="javascript:void(null)" onClick='window.open("<%=rootPath%>/network.do?action=telnet&ipaddress=<%=host.getIpAddress()%>","onetelnet", "height=0, width= 0, top=0, left= 0")'>SSH</td>
			                    										</tr>-->                    										
			                    										<tr align="left" valign="center">
			                      											<td height="28" align="left">&nbsp;<img src="<%=rootPath%>/resource/image/nodelist.png">&nbsp;<a href="javascript:void(null)" onClick='window.open("<%=rootPath%>/network.do?action=telnet&ipaddress=<%=host.getIpAddress()%>","onetelnet", "height=0, width= 0, top=0, left= 0")'>Telnet</td>
			                    										</tr>
			                    										<tr align="left" valign="center"> 
			                    											<td height="28" align="left"><img src="<%=rootPath%>/resource/image/topo/icon_ping.gif">&nbsp;<a href="javascript:void(null)" onClick='window.open("<%=rootPath%>/tool/ping.jsp?ipaddress=<%=host.getIpAddress()%>","oneping", "height=400, width= 500, top=300, left=100")'>Ping</td>
			                    										</tr> 
			                    										<tr align="left" valign="center"> 
			                    											<td height="28" align="left">&nbsp;<img src="<%=rootPath%>/resource/image/topo/traceroute.gif">&nbsp;<a href="javascript:void(null)" onClick='window.open("<%=rootPath%>/tool/tracerouter.jsp?ipaddress=<%=host.getIpAddress()%>","newtracerouter", "height=400, width= 500, top=300, left=100")'>路由跟踪</td>
			                    										</tr>                     										                      								
			            											</tbody>
			            										</table>
				            										
																<table width="100%" style="BORDER-COLLAPSE: collapse" borderColor=#cedefa cellPadding=0 rules=none w align=center border=1 algin="center">
			                        								<tbody>                     										                        								
			                    										<tr algin="left" valign="center">                      														
			                      											<td height="28" align="left" bordercolor="#9FB0C4" bgcolor="#D1DDF5" class="txtGlobalBold">&nbsp;配置</td>
			                    										</tr>
			                    										<tr align="left" valign="center"> 
			                    											<td height="28" align="left">&nbsp;<img src="<%=rootPath%>/resource/image/editicon.gif" border=0>&nbsp;<a href="<%=rootPath%>/network.do?action=ready_editalias&id=<%=tmp%>&ipaddress=<%=host.getIpAddress()%>">修改设备标签</td>
			                    										</tr> 
			                    										<tr align="left" valign="center"> 
			                    											<td height="28" align="left">&nbsp;<img src="<%=rootPath%>/resource/image/manageDev.gif" border=0>&nbsp;<a href="<%=rootPath%>/network.do?action=ready_editsysgroup&id=<%=tmp%>&ipaddress=<%=host.getIpAddress()%>">修改系统组属性</td>
			                    										</tr>                    										
			                    										<tr align="left" valign="center">
			                      											<td height="28" align="left">&nbsp;<img src="<%=rootPath%>/resource/image/modifySnmp32.gif" width=16>&nbsp;<a href="<%=rootPath%>/network.do?action=ready_editsnmp&id=<%=tmp%>&ipaddress=<%=host.getIpAddress()%>">修改SNMP参数</td>
			                    										</tr>                    										                      								
				            										</tbody>
			            										</table> 
				            										
																<table width="100%" style="BORDER-COLLAPSE: collapse" borderColor=#cedefa cellPadding=0 rules=none w align=center border=1 algin="center">
			                        								<tbody>                     										                        								
			                    										<tr algin="left" valign="center">                      														
			                      											<td height="28" align="left" bordercolor="#9FB0C4" bgcolor="#D1DDF5" class="txtGlobalBold">&nbsp;性能监视配置</td>
			                    										</tr>
			                    										<tr align="left" valign="center"> 
			                    											<td height="28" align="left">&nbsp;<img src="<%=rootPath%>/resource/image/editicon.gif" border=0>&nbsp;<a href="<%=rootPath%>/moid.do?action=ready_editmoids&id=<%=tmp%>&ipaddress=<%=host.getIpAddress()%>">配置性能监视项</td>
			                    										</tr> 
			                    										<tr align="left" valign="center"> 
			                    											<td height="28" align="left">&nbsp;<img src="<%=rootPath%>/resource/image/manageDev.gif" border=0>&nbsp;<a href="<%=rootPath%>/moid.do?action=showallmoids&id=<%=tmp%>&ipaddress=<%=host.getIpAddress()%>">监视指标阀值配置</td>
			                    										</tr>                    										                 										                      								
			            											</tbody>
			            										</table>   
				            								</td>            									
			            								</tr>
			                						</tbody>
		                						</table>
		                					</td>
		                				</tr>
		                				<tr>
	                						<td>
												<table width="100%" style="BORDER-COLLAPSE: collapse" borderColor=#cedefa cellPadding=0 rules=none align=center border=1 algin="center">
													<tr>
				                    					<td>
					            							<table width="100%" border="0" cellpadding="0" cellspacing="0">
																<tr>
																	<td width="30" height="22">
																		&nbsp;
																	</td>
																	<td width="80" height="22"
																		background="<%=rootPath%>/resource/image/anjian_1.gif">
																		<div align="center">
																			<a href="<%=rootPath%>/detail/dispatcher.jsp?id=net<%=tmp%>"><font
																				color="#397dbd">连通率</font>
																			</a>
																		</div>
																	</td>
																	<td width="80" height="22"
																		background="<%=rootPath%>/resource/image/anjian.gif">
																		<div align="center">
																			<a href="<%=rootPath%>/detail/host_wmiutilhdx.jsp?id=<%=tmp%>"><font
																				color="#FFFFFF">流速信息</font>
																			</a>
																		</div>
																	</td>
																	<td width="80" height="22"
																		background="<%=rootPath%>/resource/image/anjian_1.gif">
																		<div align="center">
																			<a
																				href="<%=rootPath%>/monitor.do?action=hostcpu&id=<%=tmp%>&ipaddress=<%=host.getIpAddress()%>"><font
																				color="#397dbd">性能信息</font>
																			</a>
																		</div>
																	</td>
																	<td width="80" height="22"
																		background="<%=rootPath%>/resource/image/anjian_1.gif">
																		<div align="center">
																			<a
																				href="<%=rootPath%>/monitor.do?action=hostproc&id=<%=tmp%>&ipaddress=<%=host.getIpAddress()%>"><font
																				color="#397dbd">进程信息</font>
																			</a>
																		</div>
																	</td>
																	<td width="80" height="22"
																		background="<%=rootPath%>/resource/image/anjian_1.gif">
																		<div align="center">
																			<a
																				href="<%=rootPath%>/monitor.do?action=hostsyslog&id=<%=tmp%>&ipaddress=<%=host.getIpAddress()%>"><font
																				color="#397dbd">Syslog信息</font>
																			</a>
																		</div>
																	</td>
																	<td width="80" height="22"
																		background="<%=rootPath%>/resource/image/anjian_1.gif">
																		<div align="center">
																			<a
																				href="<%=rootPath%>/monitor.do?action=hostconfig&id=<%=tmp%>&ipaddress=<%=host.getIpAddress()%>"><font
																				color="#397dbd">配置信息</font>
																			</a>
																		</div>
																	</td>
																	<td width="80" height="22"
																		background="<%=rootPath%>/resource/image/anjian_1.gif">
																		<div align="center">
																			<a
																				href="<%=rootPath%>/monitor.do?action=hostservice&id=<%=tmp%>&ipaddress=<%=host.getIpAddress()%>"><font
																				color="#397dbd">服务信息</font>
																			</a>
																		</div>
																	</td>
																	<td width="80" height="22"
																		background="<%=rootPath%>/resource/image/anjian_1.gif">
																		<div align="center">
																			<a
																				href="<%=rootPath%>/monitor.do?action=hostevent&id=<%=tmp%>&ipaddress=<%=host.getIpAddress()%>"><font
																				color="#397dbd">事件信息</font>
																			</a>
																		</div>
																	</td>
																	<td align=right>
																		&nbsp;&nbsp;
																	</td>
																</tr>
															</table>
															<table width="100%" border="0" cellpadding="3" cellspacing="1"
																bgcolor="#FFFFFF">
																<tr align="center">
																	<td rowspan="2" width="6%" align="left">
																		索引
																	</td>
																	<td rowspan="2" width="9%" align="left">
																		描述
																	</td>
																	<td rowspan="2" width="9%" align="left">
																		关联应用
																	</td>
																	<td rowspan="2" width="11%">
																		每秒字节数(M)
																	</td>
																	<td rowspan="2" width="9%">
																		当前状态
																	</td>
																	<!--<td colspan="2" height="23">带宽利用率</td>-->
																	<td height="23" colspan="2">
																		流速
																	</td>
																	<td rowspan="2" align="center">
																		查看详情
																	</td>
																	<!--<td rowspan="2" width="9%" align="center">查看相关</td>-->
																</tr>
																<tr>
																	<!-- 
															    <td   width="9%"><html:submit  property="button1" styleClass="button" onclick="changeOrder('OutBandwidthUtilHdxPerc')">出口 </html:submit></td>
															    <td   width="9%"><html:submit  property="button2" styleClass="button" onclick="changeOrder('InBandwidthUtilHdxPerc')">入口 </html:submit></td>
															    -->
																	<td width="15%">
																		<input type=button name="button3" styleClass="button" value="出口流速"
																			onclick="changeOrder('OutBandwidthUtilHdx')">
																	</td>
																	<td width="15%">
																		<input type=button name="button4" styleClass="button" value="入口流速"
																			onclick="changeOrder('InBandwidthUtilHdx')">
																	</td>
																</tr>
																<%
																	int[] width = { 6, 18, 11, 15, 15, 15, 15 };
																	for (int i = 0; i < ifvector.size(); i++) {
																		String[] strs = (String[]) ifvector.get(i);
																		String ifname = strs[1];
																		String index = strs[0];
																%>
																<tr bgcolor="DEEBF7" <%=onmouseoverstyle%> height=25>
																	<%
																		for (int j = 0; j < strs.length; j++) {
																				if (j == 3) {
																					String status = strs[j];
																					String url = "";
																					System.out.println("status=========" + status);
																					if (status.equals("1")) {
																						url = rootPath + "/resource/image/topo/up.gif";
																					} else if (status.equals("2")) {
																						url = rootPath + "/resource/image/topo/down.gif";
																					} else {
																						url = rootPath + "/resource/image/topo/testing.gif";
																					}
																	%>
																	<td width="<%=width[j]%>%" align="center">
																		<img src="<%=url%>">
																	</td>
																	<%
																		} else {
																					if (j == 1) {
																						if (hash != null && hash.size() > 0) {
																							String linkuse = "";
																							if (hash.get(ipaddress + ":" + index) != null)
																								linkuse = (String) hash.get(ipaddress + ":"
																										+ index);
																	%>
																	<td width="<%=width[j] / 2%>%"><%=strs[j]%></td>
																	<td width="<%=width[j] / 2%>%"><%=linkuse%></td>
																	<%
																		} else {
																	%>
																	<td width="<%=width[j] / 2%>%"><%=strs[j]%></td>
																	<td width="<%=width[j] / 2%>%"></td>
																	<%
																		}
																					} else {
																	%>
																	<td width="<%=width[j]%>%"><%=strs[j]%></td>
																	<%
																		}
																				}
																			}
																	%>
																	<td width="9%" align="center">
															
																		&nbsp;
																		<img src="<%=rootPath%>/resource/image/status.gif" border="0"
																			width=15 oncontextmenu=showMenu('2','<%=index%>','111')>
															
																	</td>
																	<!--<td  width="9%"align="center"><a  style="cursor:hand" onclick="openwin3('read_about','<%=index%>','<%=ifname%>')">查看相关</a></td>-->
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