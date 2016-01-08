<%@page language="java" contentType="text/html;charset=GB2312"%>
<%@page import="java.util.List"%>
<%@page import="com.afunms.common.util.SessionConstant"%>
<%@page import="com.afunms.system.model.User"%>
<%@page import="com.afunms.application.course.model.Lsfclass"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.afunms.application.course.dao.LsfClassProcessMonitoringDao"%>
<%@page import="com.afunms.application.course.model.LsfClassComprehensiveModel"%>
<%
	JspPage jp = (JspPage) request.getAttribute("page");
	String rootPath = request.getContextPath();
	User current_user = (User) session.getAttribute(SessionConstant.CURRENT_USER);
	List list = null;
	LsfClassProcessMonitoringDao dao = new LsfClassProcessMonitoringDao();
	list = dao.loadFrom_lsf_class();
	if (list == null) {
		list = new ArrayList();
	}
	System.out.println(rootPath);
%>
<html>
<head>
<title></title>
<link rel="StyleSheet" href="<%=rootPath%>/application/course/dtree/dtree.css" type="text/css" />
<script type="text/javascript" src="<%=rootPath%>/application/course/dtree/dtree.js"></script>
<style>
body {
margin-left: 6px;
margin-top: 0px;
margin-right: 6px;
margin-bottom: 6px;
scrollbar-face-color: #E0E3EB;
scrollbar-highlight-color: #E0E3EB;
scrollbar-shadow-color: #E0E3EB;
scrollbar-3dlight-color: #E0E3EB;
scrollbar-arrow-color: #7ED053;
scrollbar-track-color: #ffffff;
scrollbar-darkshadow-color: #9D9DA1;
}
body,td,th {color: #666666;line-height:20px}
.div_RightMenu
{
    z-index:30000;
    text-align:left;    
    cursor: default;
    position: absolute;
    background-color:#FAFFF8;
    width:100px;
    height:auto;
    border: 1px solid #333333;
    display:none;
    filter:progid:DXImageTransform.Microsoft.Shadow(Color=#333333,Direction=120,strength=5);    
}
.divMenuItem
{
    height:17px;
    color:Black;
    font-family:����;
    vertical-align:middle;
    font-size:10pt;
    margin-bottom:3px;
    cursor:hand;
    padding-left:10px;
    padding-top:2px;
}
</style>
</head>
<body>
<div class="dtree" style="">
<!--  
<p><a href="javascript: d.openAll();">չ��</a> | <a href="javascript: d.closeAll();">�ϱ�</a> | <a href="javascript: window.location.reload();">ˢ��</a></p>
-->
<script type="text/javascript"><!--
        var currTreeNodeId = '';		// ��ǰ���Ľڵ� Id
        var treeNodeFatherId = '';		// ��ǰ���Ľڵ�ĸ� Id	
        var imagestr = '';
        var key = 0 ;
		d = new dTree('d');
		d.add(0,-1,'��Ⱥ���','','','','rightFrame');
		//d.add(0,-1,'��Ⱥ���','<%=rootPath+ "/lsfProcessMonitoring.do?action=list&isTreeView=1&jp=1"%>','','','rightFrame');
		parent.document.getElementById("rightFrame").src='<%=rootPath+ "/lsfProcessMonitoring.do?action=list_join&isTreeView=1&jp=1"%>';//rooms
		//parent.document.getElementById("rightFrame").src='<%=rootPath+ "/eqproom.do?action=list&isTreeView=1&jp=1"%>';//rooms
		
		<%
		String img= rootPath+"/application/course/dtree/img/folder_2.gif";
		String b="2";
			for(int i = 0;i<list.size();i++){

				LsfClassComprehensiveModel room = (LsfClassComprehensiveModel)list.get(i);
				//String url = rootPath + "/maccabinet.do?action=loadByRoomID&isTreeView=1&id="+room.getClass_id()+"&jp=1";
				%>
				d.add('r'+'<%=room.getClass_id()%>',0,'<%=room.getClass_name()%>','','','','rightFrame','<%=img%>','<%=room.getClass_id()%>');
				<%
			}
		%>
		document.write(d);
//------------search one device-------------����ѡ�е����ڵ��ڵ�ͼ��������Ӧ���豸

function SearchNode(ip)
{
	var coor = window.parent.mainFrame.mainFrame.getNodeCoor(ip);
	if (coor == null)
	{
		var msg = "û����ͼ��������IP��ַΪ "+ ip +" ���豸��";
		window.alert(msg);
		return;
	}
	else if (typeof coor == "string")
	{
		window.alert(coor);
		return;
	}
	window.parent.mainFrame.mainFrame.moveMainLayer(coor);
}
//--------------------end--------------------
//--------------------beginѡ���豸��ʾ�Ҽ��˵�--------------------
var nodeid="";
var nodeip="";
var nodecategory="";
function showMenu(id,ip){
    nodeid = id.split(";")[0];
    nodecategory = id.split(";")[1];
    nodeip = ip;
    /**/
    if(document.getElementById("div_RightMenu") == null)
    {    
        CreateMenu();
        document.oncontextmenu = ShowMenu
        document.body.onclick  = HideMenu    
    }
    else
    {
        document.oncontextmenu = ShowMenu
        document.body.onclick  = HideMenu    
    } 

}
function add(){
    var nodeId = nodeid;//Ҫ��֤nodeid�ĳ��ȴ���3
    var coor = window.parent.mainFrame.mainFrame.getNodeId(nodeId);
    if (coor == null)
	{
         window.parent.mainFrame.mainFrame.addEquip(nodeId,nodecategory);
	}
	else if (typeof coor == "string")
	{
		window.alert(coor);
		return;
	}
    window.parent.mainFrame.mainFrame.moveMainLayer(coor);
    window.alert("���豸�Ѿ�������ͼ�д��ڣ�");
}
function detail(){
    showalert(nodeid);
	window.parent.parent.opener.focus();
}
function showalert(id) {
	alert("performance/tree.jsp-/afunms/detail/dispatcher.jsp?id="+id);
	window.parent.parent.opener.location="/afunms/detail/dispatcher.jsp?id="+id;
}
function evtMenuOnmouseMove()
{
    this.style.backgroundColor='#8AAD77';
    this.style.paddingLeft='10px';    
}
function evtOnMouseOut()
{
    this.style.backgroundColor='#FAFFF8';
}
function CreateMenu()
{    
        var div_Menu          = document.createElement("Div");
        div_Menu.id           = "div_RightMenu";
        div_Menu.className    = "div_RightMenu";
        
        var div_Menu1         = document.createElement("Div");
        div_Menu1.id          = "div_Menu1";
        div_Menu1.className   = "divMenuItem";
        div_Menu1.onclick     = add;
        div_Menu1.onmousemove = evtMenuOnmouseMove;
        div_Menu1.onmouseout  = evtOnMouseOut;
        div_Menu1.innerHTML   = "���ӵ�����ͼ";
        var div_Menu2         = document.createElement("Div");
        div_Menu2.id          = "div_Menu2";
        div_Menu2.className   = "divMenuItem";
        div_Menu2.onclick     = detail;
        div_Menu2.onmousemove = evtMenuOnmouseMove;
        div_Menu2.onmouseout  = evtOnMouseOut;
        div_Menu2.innerHTML   = "��ϸ��Ϣ";
        
        div_Menu.appendChild(div_Menu1);
        div_Menu.appendChild(div_Menu2);
        document.body.appendChild(div_Menu);
}
// �жϿͻ��������
function IsIE() 
{
    if (navigator.appName=="Microsoft Internet Explorer") 
    {
        return true;
    } 
    else 
    {
        return false;
    }
}

function ShowMenu()
{
    
    if (IsIE())
    {
        document.body.onclick  = HideMenu;
        var redge=document.body.clientWidth-event.clientX;
        var bedge=document.body.clientHeight-event.clientY;
        var menu = document.getElementById("div_RightMenu");
        if (redge<menu.offsetWidth)
        {
            menu.style.left=document.body.scrollLeft + event.clientX-menu.offsetWidth
        }
        else
        {
            menu.style.left=document.body.scrollLeft + event.clientX
            //�����иĶ�
            menu.style.display = "block";
        }
        if (bedge<menu.offsetHeight)
        {
            menu.style.top=document.body.scrollTop + event.clientY - menu.offsetHeight
        }
        else
        {
            menu.style.top = document.body.scrollTop + event.clientY
            menu.style.display = "block";
        }
    }
    return false;
}
function HideMenu()
{
    if (IsIE())  document.getElementById("div_RightMenu").style.display="none";    
}
--></script>
</div>
</body>
</html>