//-----右键菜单的样式---------------------------------------
function pingMenuOut() {
	window.event.srcElement.className="ping_menu_out";
}
function pingMenuOver() {
	window.event.srcElement.className="ping_menu_over";
}
function deleteMenuOut() {
	window.event.srcElement.className="deleteline_menu_out";
}
function deleteMenuOver() {
	window.event.srcElement.className="deleteline_menu_over";
}
function detailMenuOut() {
	window.event.srcElement.className="detail_menu_out";
}
function detailMenuOver() {
	window.event.srcElement.className="detail_menu_over";
}
//设备面板
function sbmbMenuOut() {
	window.event.srcElement.className="sbmb_menu_out";
}
function sbmbMenuOver() {
	window.event.srcElement.className="sbmb_menu_over";
}
//设备关联应用  HONGLI ADD
function deleteEquipRelatedApplicationsMenuOut() {
	window.event.srcElement.className="equipRelatedApplications_menu_out";
}
function deleteEquipRelatedApplicationsMenuOver() {
	window.event.srcElement.className="equipRelatedApplications_menu_over";
}
function panelmanageMenuOut() {
	window.event.srcElement.className="panel_manage_menu_out";
}
function panelmanagelMenuOver() {
	window.event.srcElement.className="panel_manage_menu_over";
}
function detailMenuOut1() {
	window.event.srcElement.className="detail_menu_out1";
}
function detailMenuOver1() {
	window.event.srcElement.className="detail_menu_over1";
}
function manageMenuOut() {
	window.event.srcElement.className="manage_menu_out";
}
function manageMenuOver() {
	window.event.srcElement.className="manage_menu_over";
}
function downloadMenuOut() {
	window.event.srcElement.className="download_menu_out";
}
function downloadMenuOver() {
	window.event.srcElement.className="download_menu_over";
}
//yangjun add
function deleteEquipMenuOut() {
	window.event.srcElement.className="deleteEquip_menu_out";
}
function deleteEquipMenuOver() {
	window.event.srcElement.className="deleteEquip_menu_over";
}
function propertyMenuOut() {
	window.event.srcElement.className="property_menu_out";
}
function propertyMenuOver() {
	window.event.srcElement.className="property_menu_over";
}
function relationMapMenuOut() {
	window.event.srcElement.className="relationmap_menu_out";
}
function relationMapMenuOver() {
	window.event.srcElement.className="relationmap_menu_over";
}
function deleteLineMenuOut() {
	window.event.srcElement.className="deleteline_menu_out";
}
function deleteLineMenuOver() {
	window.event.srcElement.className="deleteline_menu_over";
}
function editLineMenuOut() {
	window.event.srcElement.className="editline_menu_out";
}
function editLineMenuOver() {
	window.event.srcElement.className="editline_menu_over";
}

function telnetMenuOut() {
	window.event.srcElement.className="telnet_menu_out";
}

function telnetMenuOver() {
	window.event.srcElement.className="telnet_menu_over";
}

//end
function traceMenuOut() {
	window.event.srcElement.className="trace_menu_out";
}
function traceMenuOver() {
	window.event.srcElement.className="trace_menu_over";
}

function cloudMenuOut() {
	window.event.srcElement.className="cloud_menu_out";
}
function cloudMenuOver() {
	window.event.srcElement.className="cloud_menu_over";
}
function showalert(id) {
	//window.parent.parent.opener.location="/afunms/detail/dispatcher.jsp?id="+id;
	window.parent.parent.opener.parent.window.document.getElementById('mainFrame').src="/afunms/detail/dispatcher.jsp?id="+id;
}
//右键菜单
//


//document.oncontextmenu = function() {
//    if($("div_RightMenu") == null)
//    {    
//        CreateMenu();
//        document.oncontextmenu = ShowMenu
//        document.body.onclick  = HideMenu    
//    }
//    else
//    {
//        document.oncontextmenu = ShowMenu
//        document.body.onclick  = HideMenu    
//    }    
//}
function evtMenu2()
{    
    HideMenu();
}
function evtMenuOnmouseMove()
{
    this.style.backgroundColor='#8AAD77';
    this.style.paddingLeft='30px';    
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
        
        var div_Menu1          = document.createElement("Div");
        div_Menu1.className   = "divMenuItem";
        div_Menu1.onclick     = createSubMap;
        div_Menu1.onmousemove = evtMenuOnmouseMove;
        div_Menu1.onmouseout  = evtOnMouseOut;
        div_Menu1.innerHTML   = "创建子图";
        
        var div_Menu2          = document.createElement("Div");
        div_Menu2.className   = "divMenuItem";
        div_Menu2.onclick     = evtMenu2;
        div_Menu2.onmousemove = evtMenuOnmouseMove
        div_Menu2.onmouseout  = evtOnMouseOut
        div_Menu2.innerHTML   = "删除记录";
        
        
        var div_Menu4          = document.createElement("Div");
        div_Menu4.className   = "divMenuItem";
        div_Menu4.onmousemove = evtMenuOnmouseMove;
        div_Menu4.onmouseout  = evtOnMouseOut;
        div_Menu4.innerHTML   = "刷新";
        
        var Hr1        = document.createElement("Hr");
        
        
        var div_Menu6          = document.createElement("Div");
        div_Menu6.className   = "divMenuItem";
        div_Menu6.onmousemove = evtMenuOnmouseMove;
        div_Menu6.onmouseout  = evtOnMouseOut;
        div_Menu6.innerHTML   = "复制";
        
        var div_Menu7          = document.createElement("Div");
        div_Menu7.className   = "divMenuItem";
        div_Menu7.onmousemove = evtMenuOnmouseMove;
        div_Menu7.onmouseout  = evtOnMouseOut;
        div_Menu7.innerHTML   = "全选";
        
        var Hr2        = document.createElement("Hr");
        
        var div_Menu10           = document.createElement("Div");
        div_Menu10.className   = "divMenuItem";
        div_Menu10.style.marginBottom =  0;
        div_Menu10.onmousemove = evtMenuOnmouseMove;
        div_Menu10.onmouseout  = evtOnMouseOut;
        div_Menu10.innerHTML   = "属性";
        
        
        div_Menu.appendChild(div_Menu1);
        div_Menu.appendChild(div_Menu2);
        div_Menu.appendChild(div_Menu4);
        div_Menu.appendChild(Hr1);
        
        div_Menu.appendChild(div_Menu6);
        div_Menu.appendChild(div_Menu7);
        div_Menu.appendChild(Hr2);
        
        div_Menu.appendChild(div_Menu10);

        document.body.appendChild(div_Menu);
}
    
// 判断客户端浏览器
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
        var menu = $("div_RightMenu");
        if (redge<menu.offsetWidth)
        {
            menu.style.left=document.body.scrollLeft + event.clientX-menu.offsetWidth
        }
        else
        {
            menu.style.left=document.body.scrollLeft + event.clientX
            //这里有改动
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
    if (IsIE()) $("div_RightMenu").style.display="none";    
}

function $(gID)
{
    return document.getElementById(gID);
}