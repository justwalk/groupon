<%@page contentType="text/html; charset=gbk" pageEncoding="UTF-8"%>
<%@taglib uri="http://chances.com.cn/jsp/epg" prefix="epg"%>
<%@ page language="java" import="java.util.*,chances.epg.exception.*,sitv.epg.web.context.*,chances.epg.log.*" %>
<epg:html>
<meta name="error" content="epgError">
<script src="<%=request.getContextPath()%>/js/event.js"></script>
<script>
document.onkeydown = function(event){
	var code = Event(event);
	switch (code) {
		case "KEY_UP":
			break;
	    case "KEY_DOWN":
			break;
		case "KEY_LEFT":
			break;
	    case "KEY_RIGHT":
			break;
		case "KEY_PAGE_UP":
			pageUp();
	    	return 0;
			break;
	    case "KEY_PAGE_DOWN":
			pageDown();
	    	return 0;
			break;
		default:
			break;
	}
}
function init(){
	document.getElementById("back_a").focus();
}
function back(){
	history.back();
}
</script>
<% 
String url = (String)request.getAttribute("javax.servlet.forward.request_uri");
if (url.endsWith(".jpg") || url.endsWith(".gif")) {
	EpgLogFactory.getSystemLogger().error("cannot find pic:"+url);
	return;
}
%>
<!-- onload="init()" onunload="undisplay()"  -->
<epg:body onload="init()" background="/common/images/errorBg.jpg" autoflag="notall" style="background-repeat:no-repeat;" width="1280" height="720">
<div align="center" style="position:absolute;left:630px;top:456px;width:130px;height:22px;">
<font style="font-size:24px;color:#333333">${errorCode}</font>
</div>
<div style="position:absolute;left:324px;top:498px;width:760px;height:29px;">
<font style="font-size:24px;color:#dfbc75">系统忙，请稍后再试</font>
</div>
<div style="position:absolute;left:582px;top:378px;width:113px;height:48px;">
<epg:img id="back" src="/common/images/dot.gif" width="113" height="48" href="javascript:back();"></epg:img>
</div>
</epg:body>
</epg:html>