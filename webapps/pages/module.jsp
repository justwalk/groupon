<%@page contentType="text/html; charset=gbk"%>
<%@taglib uri="http://chances.com.cn/jsp/epg" prefix="epg"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setAttribute("basePath", basePath);
	//是否记录Bi
	String isbi = request.getParameter("isbi");
	if(isbi==null){
		isbi="true";
	}
%>
<%@ include file="checkSession.jsp" %>
<epg:html>
<link rel="stylesheet" type="text/css" href="${basePath}/css/reset.css"/>
<script src="${basePath}/js/ajax.js"></script>
<script src="${basePath}/js/event.js"></script>
<script src="${basePath}/js/data.js"></script>
<style>
.pro_content {
	padding-left: 15px;
	font-size: 20px;
	padding-top: 5px;
	font-family: 黑体;
}
a,a:focus,a:hover{
-webkit-tap-highlight-color:rgba(0,0,0,0);
}
</style>
<script>
	function eventHandler(eventObj) {
		//如果是ipanel
		if(typeof(iPanel)!='undefined'){
			getFocusIDLongJing=getFocusID;
		}
		if(getFocusIDLongJing==""){
			getFocusIDLongJing=getFocusID;
		}
		switch (eventObj.code) {
		case "EIS_IRKEY_UP":
			//如果是ipanel
			if(typeof(iPanel)!='undefined'){
				if (getFocusID.indexOf('_')) {
					var idF = getFocusID.split('_')[0];
					var idP = getFocusID.split('_')[1];
					if (idF == "recommand") {
						if (idP < 4) {
							//document.getElementById("menu_" + idP).focus();
						} else {
							//document.getElementById("recommand_" + (idP - 4)).focus();
						}
	
						//return 0;
					}
				}
			}
			else{
				getFocusIDLongJing=getFocusID;
				if (getFocusIDLongJing.indexOf('_')) {
					var idF = getFocusIDLongJing.split('_')[0];
					var idP = getFocusIDLongJing.split('_')[1];
					if (idF == "recommand") {
						if (idP < 4) {
							//document.getElementById("menu_" + idP+"_a").focus();
						} else {
							//document.getElementById("recommand_" + (idP - 4)).focus();
						}
					}
				}
				getFocusIDLongJing=getFocusID;
			}
			break;
		case "EIS_IRKEY_DOWN":
			getFocusIDLongJing=getFocusID;
			break;
		case "EIS_IRKEY_SELECT":
			break;
		case "EIS_IRKEY_LEFT":
			//如果是ipanel
			if(typeof(iPanel)!='undefined'){
				if (getFocusID.indexOf('_')) {
					var idF = getFocusID.split('_')[0];
					var idP = getFocusID.split('_')[1];
					if (idF == "recommand") {
						if (idP > 0) {
							//document.getElementById("recommand_" + (idP - 1)).focus();
						}
	
						//return 0;
					}
				}
			}
			else{
				if (getFocusIDLongJing.indexOf('_')) {
					var idF = getFocusIDLongJing.split('_')[0];
					var idP = getFocusIDLongJing.split('_')[1];
					if (idF == "recommand") {
						if (idP > 0) {
							//document.getElementById("recommand_" + (idP - 1)).focus();
						}
					}
				}

				getFocusIDLongJing=getFocusID;
			}
			break;
		case "EIS_IRKEY_RIGHT":
			//如果是ipanel
			if(typeof(iPanel)!='undefined'){
				if (getFocusID.indexOf('_')) {
					var idF = getFocusID.split('_')[0];
					var idP = getFocusID.split('_')[1];
					if (idF == "recommand") {
						if (idP < (itemCount-1) && idP != 3) {
							//document.getElementById("recommand_" + (idP - 0 + 1)).focus();
						}
						else if(idP == 3 || idP == (itemCount-1)){
							window.location.href="index.jsp";
						}
	
						//return 0;
					}
				}
			}
			else{
				if (getFocusID.indexOf('_')) {
					var idF = getFocusID.split('_')[0];
					var idP = getFocusID.split('_')[1];
					if (idF == "recommand") {
						if(idP == 3 || idP == (itemCount-1)){
							window.location.href="index.jsp";
						}
	
					}
				}

				getFocusIDLongJing=getFocusID;
			}
			break;
		case "SITV_KEY_PAGEUP":
			break;
		case "SITV_KEY_PAGEDOWN":
			break;
		case "EIS_IRKEY_EXIT":
			window.location.href="http://itv.kmcable.tv/dmx/dmx2portal.htm";
			return 0;
			break;
		default:
			return 1;
			break;
		}
	}
	//聚焦控件ID
	var getFocusID = "menu_module";
	var getFocusIDLongJing="";

	var Path = "${basePath}";
	var itemCount=0;

	var pageId="2";
	var hasSetting=true;

	function init() {
		setCookie("pageIndex",0);
		document.getElementById("menu_module").focus();
		try{
			var urlStr1 = escape(interfaceurl
					+ getMacInfo+"?mac=deciveId");
			var ajax_url1 = Path + "clientUrlHandler.do?url=" + urlStr1+"&biType=4";
			var _ajaxObj1 = new AJAX_OBJ(ajax_url1, clientAtHomeHandler);
			_ajaxObj1.requestData();
			
			function clientAtHomeHandler(result){
				var rc=eval("(" + result.responseText + ")").response.header.rc;
				if(rc=="9"){
					hasSetting=false;
				}
				var urlStr = escape(interfaceurl
						+ getObject+"?mac=deciveId&countF=0&countE=8");
				var ajax_url = Path + "clientUrlHandler.do?url=" + urlStr+"&pageId="+pageId+"&biType="+biPageType;
				var _ajaxObj = new AJAX_OBJ(ajax_url, clientUrlHandler);
				_ajaxObj.requestData();
			}
		}
		catch(e){
			var urlStr = escape(interfaceurl
					+ getObject+"?mac=deciveId&countF=0&countE=8");
			var ajax_url = Path + "clientUrlHandler.do?url=" + urlStr+"&pageId="+pageId+"&biType="+biPageType;
			var _ajaxObj = new AJAX_OBJ(ajax_url, clientUrlHandler);
			_ajaxObj.requestData();
		}
	}

	function clientUrlHandler(result) {
		var items = eval("(" + result.responseText + ")").response.body.dataList;
		var xLine = 0;//行索引
		var itemsInner = "";
		itemCount=items.length;
		//该页ID集合
		var itemIDS="[";
		for (var i = 0; i < items.length; i++) {
			itemIDS+=items[i].id+",";
		}
		if(itemIDS!="["){
			itemIDS=itemIDS.substring(0,itemIDS.length-1);
		}
		itemIDS+="]";
		for (var i = 0; i < items.length; i++) {
			xLine = Math.floor(i / 4);
			var item = items[i];
			var clickHref=item.dbc_HREF+'?pageId='+item.dbc_BiPageID;
			if(item.dbc_HREF=="moduleChildList.jsp"){
				clickHref='moduleChildList.jsp?dbcId=' + item.dbc_ID + '&itemsCount='+item.count+'&dbcName='+item.dbc_Name+'&type=&pageId='+item.dbc_BiPageID;
				clickHref=encodeURI(clickHref);
				clickHref=encodeURI(clickHref);
			}
			//判断是否已设置过商圈
			else if(item.dbc_HREF=="atHome_groupby.jsp" && !hasSetting){
				//clickHref="atHome.jsp?pageId=53";
				window.location.href="atHome.jsp?from=module";
				return;
			}
			//var name = decodeURI(item.name).replace('?','');
			//name = subString(name, 23,true);
			itemsInner += '<div id="recommand'
					+ i
					+ '_div" style="width:270px; height:232px; top: '
					+ (200 + xLine * 238)
					+ 'px; left:'
					+ (81 + i % 4 * 282)
					+ 'px; position:absolute;">'
					+ '<a id="recommand_'
					+ i
					+ '" href="'+clickHref+'" onfocus="menuOnfocus(\'recommand_'
					+ i
					+ '\')" onblur="menuLostfocus(\'recommand_'
					+ i
					+ '\')" style="color:#000000;">'
					+ '<img alt="" src="../dzdp/dot.gif" width="258" height="218" style="margin-top: 7px;margin-left: 6px;" onerror="javascript:this.src=\'../dzdp/logo.png\';" />'
					+ '</a>' 
					+ '<img alt="" src="'+item.dbc_Image+'" width="270" height="232" style="position: absolute;top: 0px;left: 0px;" onerror="javascript:this.src=\'../dzdp/logo.png\';" />'
					+ '<span style="position:absolute; font-size:30px; color:#ffffff; text-align: center; top: 170px; left: 0px; width:260px; height:60px;">'
					+item.dbc_Name+'</span>'
					+ '</div>';

			itemsInner +='<img id="recommand_'
				+ i
				+ '_Focus" style="visibility:hidden;width:316px; height:276px; top: '
				+ (178 + xLine * 238)
				+ 'px; left:'
				+ (58 + i % 4 * 282)
				+ 'px; position:absolute;" alt="" src="../dzdp/border_bg4.png" />';
		}
		document.getElementById("recommandList").innerHTML = itemsInner;
	}

	function menuOnfocus(obj) {
		if(getFocusID=="menu_module"&&obj.indexOf("menu_")>-1 &&　getFocusID!=obj){
			document.getElementById("menu_module_Focus").style.visibility = "hidden";
		}
		else if(obj.indexOf("recommand_")>-1&&getFocusID.indexOf("menu_")>-1){
			document.getElementById("menu_module_Focus").style.visibility = "visible";
		}
		else if(obj.indexOf("menu_")>-1&&getFocusID.indexOf("recommand_")>-1){
			document.getElementById("menu_module_Focus").style.visibility = "hidden";
		}
		document.getElementById(obj + "_Focus").style.visibility = "visible";
		/* obj = document.getElementById(obj);
		obj.addEventListener("focus",function(){
			obj.style.dispaly = "none";
		}); */
		
		//document.getElementById("layer").innerHTML=getFocusID+"|"+obj;
		getFocusID = obj;
	}

	function menuLostfocus(obj) {
		document.getElementById(obj + "_Focus").style.visibility = "hidden";
		//document.getElementById(obj+"_img").style.border = "solid 0px #ffffff";
	}
	function menuTitleonfocus(obj){
		getFocusID = obj;
		document.getElementById("menu_0_Focus").style.visibility = "visible";
	}
	function menuTitleLostfocus(obj){
	}

	if(typeof(iPanel)!='undefined'){
		var defaultFocusColor = iPanel.focus.defaultFocusColor;
		iPanel.focus.display = 0;
		iPanel.focus.border = 0;
		iPanel.focus.defaultFocusColor = "#FF0000";
	}
	function exitMosaic(){
		iPanel.focus.display = 1;
		iPanel.focus.border = 1;
		iPanel.focus.defaultFocusColor = defaultFocusColor;
	}
</script>

<epg:body onload="init()" onunload="exitMosaic()" style="background-repeat:no-repeat;width:1280px;height:720px;" bgcolor='#000000'>

	<!-- 背景图片以及头部图片 -->
	<div id="main_div">
		<img id="main_img" src="../dzdp/zhuyemian_bg1.png" border="0" width="1280" height="720" />
		<img id="logo" src="../dzdp/2.gif" style="position:absolute; left:1000px; top:40px; Z-index:1000"/>
	</div>
	<div id="layer" style="position:absolute;z-index:10; width: 1200px; height: 40px;left: 0px;top: 90px;text-align: center;font-size: 30px;"></div>
	<jsp:include page="header.jsp" flush="true" />
	<div id="content" style="position: absolute; top: 0px; left: 0px; width: 1280px; height: 720px;">
		<div style="position:absolute;top:352px;left:5px;width:36px;height:70px; display:none;">
			<img src="../dzdp/toLeft.png" width="36" height="70">
		</div>
		<div style="position:absolute;top:352px;left:1240px;width:36px;height:70px; display:none;">
			<img src="../dzdp/toRight.png" width="36" height="70">
		</div>
		<div id="recommandList"></div>
	</div>
</epg:body>
</epg:html>
