<%@page language="java" contentType="text/html;charset=GB2312"%>
<%
String rootPath = request.getContextPath();
request.setCharacterEncoding("gb2312");
response.setCharacterEncoding("gb2312");
%>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="<%=rootPath%>/js/ext/lib/resources/css/ext-all.css" />
<script type="text/javascript" src="<%=rootPath%>/js/ext/lib/adapter/ext/ext-base.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type="text/javascript" src="<%=rootPath%>/js/ext/lib/ext-all.js"></script>
<script> 
Ext.onReady(function(){
  Ext.QuickTips.init();
  var form=new Ext.FormPanel({
     frame:true,
     width:300,
     monitorValid:true,//绑定验证
     layout:"form",
     labelWidth:70,
     title:"添加配置项信息",
     labelAlign:"left",
     renderTo:"form",
     submit: function(){
                    this.getEl().dom.action = 'configureTree.do?action=add_fatherData',
                    this.getEl().dom.method='POST',
                    this.getEl().dom.submit();
              },
     items:[{
               xtype:"textfield",
               fieldLabel:"配置项名",
               id:"text",
               allowBlank:false,
               blankText:"不能为空，请正确填写",
               name:"text",
               anchor:"90%"
           },{
               xtype:"textarea",
               fieldLabel:"描述",
               id:"descn",
               name:"descn",
               anchor:"90%"
           }],
     buttons:[{text:"确定",handler:function(){form.form.submit();},formBind:true},{text:"取消",handler:function(){form.form.reset();}},
     			{text:"回到配置首页",handler:function(){window.location.href="configureTree.do?action=homepage";}}]           
       });
});
</script>
   </head>   
    <body>   
<table width="100%"   border="0" cellpadding="0" cellspacing="0" > 
<tr> 
   <td align=center valign="top" >    
      <div id="form" style="height:1000px;width:17%" ></div>   
   </td> 
</tr>
</table>     
    </body>    
</html> 