//-----右键菜单的样式---------------------------------------
function pingMenuOut() {
	window.event.srcElement.className="ping_menu_out";
}
function pingMenuOver() {
	window.event.srcElement.className="ping_menu_over";
}

function detailMenuOut() {
	window.event.srcElement.className="detail_menu_out";
}
function detailMenuOver() {
	window.event.srcElement.className="detail_menu_over";
}

function cloudMenuOut() {
	window.event.srcElement.className="cloud_menu_out";
}
function cloudMenuOver() {
	window.event.srcElement.className="cloud_menu_over";
}
function showalert(id) {
	//window.parent.parent.opener.location="/afunms/detail/dispatcher.jsp?id="+id;
	window.parent.parent.opener.parent.window.document.getElementById('mainFrame').src="/afunms/detail/dispatcher.jsp?id="+id+"&fromtopo=true";
}
//----以上是拓扑图右键菜单的样式，样式的定义在CSS文件中，菜单在XML中的MENU项中设置