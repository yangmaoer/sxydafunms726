<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>amline</title>
</head>
<body leftmargin="0" topmargin="0" bgcolor="#FFFFFF">
<!-- saved from url=(0013)about:internet -->
<!-- amline script-->
<script type="text/javascript" src="home/chart/script/swfobject.js"></script>
	<div id="flashcontent">
		<strong>You need to upgrade your Flash Player</strong>
	</div>

	<script type="text/javascript">
		// <![CDATA[
		var unit_label = "<labels><label><x>4</x><y>185</y><rotate></rotate><width></width><align></align><text_color></text_color><text_size></text_size><text><![CDATA[<%=(String)request.getAttribute("unit")%>]]></text></label></labels>";

		var grid="<settings><graphs><graph gid='0'><axis>left</axis><title>入网</title><color>#EF689D</color><color_hover>#FF1010</color_hover></graph><graph gid='1'><axis>left</axis><title>出网</title><color>#81B5E4</color><color_hover>#1B1BD4</color_hover></graph></graphs>"+unit_label+"</settings>";
		//var data="1949;2.54;20.21\n1950;2.51;19.73\n1951;2.53;18.43\n1952;2.53;18.08\n1953;2.68;19.01\n1954;2.78;19.57\n1955;2.77;19.58\n1956;2.79;19.43\n1957;3.09;20.83\n1958;3.01;19.73\n1959;2.90;18.87\n1960;2.88;18.43\n1961;2.89;18.31\n1962;2.90;18.19\n1963;2.89;17.89\n1964;2.88;17.60\n1965;2.86;17.20\n1966;2.88;16.84\n1967;2.92;16.56\n1968;2.94;16.00\n1969;3.09;15.95\n1970;3.18;15.52\n1971;3.39;15.85\n1972;3.39;15.36\n1973;3.89;16.59\n1974;6.87;26.39\n1975;7.67;27.00\n1976;8.19;27.26\n1977;8.57;26.78\n1978;9.00;26.14\n1979;12.64;32.98\n1980;21.59;49.63\n1981;31.77;66.20\n1982;28.52;55.98\n1983;26.19;49.80\n1984;25.88;47.18\n1985;24.09;42.40\n1986;12.51;21.62\n1987;15.40;25.68\n1988;12.58;20.14\n1989;15.86;24.22\n1990;20.03;29.03\n1991;16.54;23.00\n1992;15.99;21.59\n1993;14.25;18.68\n1994;13.19;16.86\n1995;14.62;18.17\n1996;18.46;22.40\n1997;17.23;20.39";	
		//var data2="2008-03-03 20:15:30;29900909090;29900909090\n2008-03-03 20:15:30;19900909090;299090\n2008-03-03 20:15:30;29900909090;29900909090\n2008-03-03 20:15:30;49900909090;29900990\n2008-03-03 20:15:30;2955500909090;29900909090\n2008-03-03 20:15:30;299309090;29900909090\n2008-03-03 20:15:30;29900909090;29900909090\n2008-03-03 20:15:30;29900090;29900909090\n2008-03-03 20:15:30;29900909090;29900909090\n2008-03-03 20:15:30;29900909090;2999090\n2008-03-03 20:15:30;29910909090;29900909090\n2008-03-03 20:15:30;2990039090;2990909090\n2008-03-03 20:15:30;1900909090;299009090\n2008-03-03 20:15:30;900909090;29900909090\n2008-03-03 20:15:30;20909090;29900909090";
		var data = "<%=(String)request.getAttribute("data")%>";
		
		var so = new SWFObject("home/chart/amline/amline.swf", "amline", "370", "230", "8", "#FFFFFF");
		so.addVariable("path", "amline/");
		so.addVariable("settings_file", escape("home/chart/amline/amline_settings.xml")); 
	    so.addVariable("additional_chart_settings", grid);
		so.addVariable("chart_data", data);

		//so.addVariable("data_file", escape("amline_data.xml"));
//	so.addVariable("chart_data", "");                                       // you can pass chart data as a string directly from this file
//	so.addVariable("chart_settings", "");                                   // you can pass chart settings as a string directly from this file
//	so.addVariable("additional_chart_settings", "");                        // you append some chart settings to the loaded ones
       // so.addVariable("loading_settings", "载入设置");                 // you can set custom "loading settings" text here
       // so.addVariable("loading_data", "载入数据");                         // you can set custom "loading data" text here
		so.addVariable("preloader_color", "#999999");
		so.write("flashcontent");
		// ]]>
	</script>
<!-- end of amline script -->
</body>
</html>
