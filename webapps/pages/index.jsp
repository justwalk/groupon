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
				if (getFocusIDLongJing.indexOf('_')) {
					var idF = getFocusIDLongJing.split('_')[0];
					var idP = getFocusIDLongJing.split('_')[1];
					if (idF == "recommand") {
						if (idP < 4) {
							//document.getElementById("menu_" + idP).focus();
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
				if (getFocusID=="recommand_0"||getFocusID=="recommand_4") {
					window.location.href="module.jsp";
					return 0;
				}
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
				if (getFocusID=="recommand_0"||getFocusID=="recommand_4") {
					window.location.href="module.jsp";
					return 0;
				}
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
							window.location.href="groupby.jsp";
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
						if (idP < (itemCount-1) && idP != 3) {
							//document.getElementById("recommand_" + (idP - 0 + 1)).focus();
						}
						else if(idP == 3 || idP == (itemCount-1)){
							window.location.href="groupby.jsp";
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
			window.location.href="module.jsp";
			return 0;
			break;
		default:
			return 1;
			break;
		}
	}
	//聚焦控件ID
	var getFocusID = "menu_1_a";
	var getFocusIDLongJing="";
	var Path = "${basePath}";
	var itemCount=0;
	var pageId="1";

	function init() {
		setCookie("pageIndex",0);
		document.getElementById("menu_1_a").focus();

		try{
			mac=hardware.STB.serialNumber;
		}
		catch(err){
			
		}
		var urlStr = escape(interfaceurl
				+ getGroupon+"?type=3&count=8&mac=deciveId&usercode=1&mac=deciveId&athome=false");
		var ajax_url = Path + "clientUrlHandler.do?url=" + urlStr+"&pageId="+pageId+"&biType="+biPageType;
		var _ajaxObj = new AJAX_OBJ(ajax_url, clientUrlHandler);
		_ajaxObj.requestData();
	}

	function clientUrlHandler(result) {
		var items = eval("(" + result.responseText + ")").response.body.dataList;
		itemCount=items.length;
		var xLine = 0;//行索引
		var itemsInner = "";
		//该页ID集合
		var itemIDS="[";
		for (var i = 0; i < items.length; i++) {
			itemIDS+="{'id':'"+items[i].id+"','type':'0'},";
		}
		if(itemIDS!="["){
			itemIDS=itemIDS.substring(0,itemIDS.length-1);
		}
		itemIDS+="]";
		for (var i = 0; i < items.length; i++) {
			xLine = Math.floor(i / 4);
			//alert(xLine);
			var item = items[i];
			var name = decodeURI(item.name).replace('?','');
			//if (name.length > 12) {
				//name='&nbsp;&nbsp;&nbsp;'+name;
				name = subString(name, 23,true);
			//}
			itemsInner += '<div id="recommand'
					+ i
					+ '_div" style="width:262px; height:235px; top: '
					+ (180 + xLine * 252)
					+ 'px; left:'
					+ (87 + i % 4 * 280)
					+ 'px; position:absolute; background-color:#ffffff;">'
					+ '<a id="recommand_'
					+ i
					+ '" href="itemDetail.jsp?dealId='
					+ item.deal_id
					+ '&itemIDS='+itemIDS+'&type=&pageId='+pageId+'" onfocus="menuOnfocus(\'recommand_'
					+ i
					+ '\')" onblur="menuLostfocus(\'recommand_'
					+ i
					+ '\')" style="color:#000000;">'
					+ '<img alt="" src="../dzdp/dot.gif" width="262" height="145" />'
				 	+ '</a>'
					+ '<img alt="" src="'+item.s_image_url+'" width="262" height="145" style="position: absolute;top: 0px;left: 0px;" onerror="javascript:this.src=\'../dzdp/logo.png\';" />'
					+ '<div class="pro_content">'
					+ '<img alt="" src="../dzdp/line2.png" style="position:absolute; top:150px; left:8px;height: 1px;" width="100" />'
					+ '<div id="iname_'+i+'" align="left" style="position:absolute;left:15px;top:155px;width:245px;height:26px">'
					+ name
					+ '</div>'
					+ '<div>'
					+ '<span style="font-family: -webkit-body;">'
					+ '<img alt="" src="../dzdp/dazhe_bg.png" width="45" height="20" style="position:absolute;left:210px; top:183px">'
					+ '<span style=" font-size: 13px; position:absolute; left:214px; top: 188px;z-index: 999;">'
					+ (item.discount * 10).toFixed(1)
					+ '折</span>'
					+ '</span>'
					+ '<span style="font-family: -webkit-body;font-size: 16px;">'
					+ '<img alt="" src="'+item.from_type_img_url+'" style="position:absolute;left: 15px;top:183px" width="20" height="20">'
					+ '<span style="position:absolute; left: 38px;top:187px;font-size: 14px;">'+item.from_type+'提供数据</span>'
					+ '</span>'
					+ '</div>'
					+ '</div>'
					+ '<div style="position:absolute; top:210px; left:15px;">'
					+ '<span style="color: #0000ff;">￥'
					+ item.now_price
					+ '</span> '
					+ '<span style=" font-size: 13px;text-decoration: line-through;">￥'
					+ item.list_price
					+ '</span>'
					+ '<span style="color: #ff0000;position: absolute; width: 230px; left: 0px; top: 0px; text-align: right">'
					+ item.hits + '人购买</span> ' + '</div>' + '</div>';

			itemsInner +='<img id="recommand_'
				+ i
				+ '_Focus" style="visibility:hidden;width:325px; height:300px; top: '
				+ (147 + xLine * 252)
				+ 'px; left:'
				+ (56 + i % 4 * 280)
				+ 'px; position:absolute;" alt="" src="../dzdp/border_bg4.png" />';
		}
		document.getElementById("recommandList").innerHTML = itemsInner;
	}

	function menuOnfocus(obj) {
		if(getFocusID=="menu_1"&&obj.indexOf("menu_")>-1 &&　getFocusID!=obj){
			document.getElementById("menu_1_Focus").style.visibility = "hidden";
		}
		else if(obj.indexOf("recommand_")>-1&&getFocusID.indexOf("menu_")>-1){
			document.getElementById("menu_1_Focus").style.visibility = "visible";
		}
		else if(obj.indexOf("menu_")>-1&&getFocusID.indexOf("recommand_")>-1){
			document.getElementById("menu_1_Focus").style.visibility = "hidden";
		}
		document.getElementById(obj + "_Focus").style.visibility = "visible";
		getFocusID = obj;
	}

	function menuLostfocus(obj) {
		document.getElementById(obj + "_Focus").style.visibility = "hidden";
		//document.getElementById(obj+"_img").style.border = "solid 0px #ffffff";
	}
	function menuTitleonfocus(obj){
		getFocusID = obj;
		document.getElementById("menu_1_Focus").style.visibility = "visible";
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
