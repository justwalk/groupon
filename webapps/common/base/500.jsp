<%@page contentType="text/html; charset=gbk" pageEncoding="UTF-8"%>
<%@taglib uri="http://chances.com.cn/jsp/epg" prefix="epg"%>
<epg:html>
<script src="<%=request.getContextPath()%>/js/event.js"></script>
<script>
function eventHandler(eventObj)
{
	switch(eventObj.code)
	{
		case "SYSTEM_EVENT_ONLOAD":
			break;
		case "SITV_KEY_UP":
	    	break;
		case "SITV_KEY_DOWN":
	    	break;
		case "EIS_IRKEY_SELECT":
			break;
		case "SITV_KEY_LEFT":
	    	break;
		case "SITV_KEY_RIGHT":
	    	break;
	    case "SITV_KEY_PAGEUP":
				pageUp();
				return 0;
	    	break;
	    case "SITV_KEY_PAGEDOWN":
				pageDown();
				return 0;
	    	break;
	    case "SITV_KEY_BACK":
	    	window.location.href = "${returnHomeUrl}";
			return 0;
	    	break;
		case "SITV_KEY_EXIT":
			window.location.href = "${returnHomeUrl}";
			return 0;
			break;
	  case "SITV_KEY_MENU":
			iPanel.focus.display = 1;
			iPanel.focus.border = 1;
			iPanel.eventFrame.openIndex();
			return 0;
			break;
		default:
			return 1;
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
<!-- onunload="undisplay()" -->
<epg:body onload="init()" background="/common/images/errorBg.jpg" autoflag="notall" style="background-repeat:no-repeat;" width="1280" height="720">
<div align="center" style="position:absolute;left:630px;top:456px;width:130px;height:22px;">
<font style="font-size:24px;color:#333333">500</font>
</div>
<div style="position:absolute;left:324px;top:498px;width:760px;height:29px;">
<font style="font-size:24px;color:#dfbc75">内部服务器错误</font>
</div>
<div style="position:absolute;left:582px;top:378px;width:113px;height:48px;">
<epg:img id="back" src="/common/images/dot.gif" width="113" height="48" href="javascript:back();"></epg:img>
</div>
</epg:body>
</epg:html>