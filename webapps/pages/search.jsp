<%@page contentType="text/html; charset=gbk"%>
<%@taglib uri="http://chances.com.cn/jsp/epg" prefix="epg"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setAttribute("basePath", basePath);

	String[][] highLightStyles = new String[][]{
			{"60", "160", "45", "45", "A", "#"},
			{"115", "160", "45", "45", "B", "#"},
			{"170", "160", "45", "45", "C", "#"},
			{"225", "160", "45", "45", "D", "#"},
			{"280", "160", "45", "45", "E", "#"},
			{"335", "160", "45", "45", "F", "#"},
			{"390", "160", "45", "45", "G", "#"},
			{"60", "215", "45", "45", "H", "#"},
			{"115", "215", "45", "45", "I", "#"},
			{"170", "215", "45", "45", "J", "#"},
			{"225", "215", "45", "45", "K", "#"},
			{"280", "215", "45", "45", "L", "#"},
			{"335", "215", "45", "45", "M", "#"},
			{"390", "215", "45", "45", "N", "#"},
			{"60", "270", "45", "45", "O", "#"},
			{"115", "270", "45", "45", "P", "#"},
			{"170", "270", "45", "45", "Q", "#"},
			{"225", "270", "45", "45", "R", "#"},
			{"280", "270", "45", "45", "S", "#"},
			{"335", "270", "45", "45", "T", "#"},
			{"60", "325", "45", "45", "U", "#"},
			{"115", "325", "45", "45", "V", "#"},
			{"170", "325", "45", "45", "W", "#"},
			{"225", "325", "45", "45", "X", "#"},
			{"280", "325", "45", "45", "Y", "#"},
			{"335", "325", "45", "45", "Z", "#"},
			{"390", "270", "100", "45", "←", "#"},
			{"390", "325", "100", "45", "搜索", "#"}};
	request.setAttribute("highLightStyles", highLightStyles);
	//是否记录Bi
	String isbi = request.getParameter("isbi");
	if(isbi==null){
		isbi="true";
	}
	String searchWord = request.getParameter("searchWord");
	if(searchWord==null){
		searchWord="";
	}
	request.setAttribute("searchWord", searchWord);
	session.setAttribute("pageIndex","0");
%>
<%@ include file="checkSession.jsp" %>
<epg:html>
<script src="${basePath}/js/ajax.js"></script>
<script src="${basePath}/js/event.js"></script>
<script src="${basePath}/js/data.js?r=2"></script>
<style>
a{
	color:#ffffff;
}
a,a:focus,a:hover{
-webkit-tap-highlight-color:rgba(0,0,0,0);
}
</style>
<script type="text/javascript" charset="utf-8">
function eventHandler(eventObj) {
	switch (eventObj.code) {
	case "EIS_IRKEY_UP":
		if(getFocusID.indexOf('_')){
			//document.getElementById("layer").innerHTML=getFocusID;
			var idF=getFocusID.split('_')[0];
			var idP=getFocusID.split('_')[1];
			if(idF=="item"){
				if(idP>0){
					//document.getElementById("item_"+(idP-1)).focus();
				}
				
				//return 0;
			}
		}
		break;
	case "EIS_IRKEY_DOWN":
		if(getFocusID.indexOf('_')){
			//document.getElementById("layer").innerHTML=getFocusID;
			var idF=getFocusID.split('_')[0];
			var idP=getFocusID.split('_')[1];
			if(idF=="item"){
				//if(idP<4){
				//	document.getElementById("item_"+(idP-0+1)).focus();
				//}
				
				//return 0;
			}
		}
		break;
	case "EIS_IRKEY_SELECT":
		break;
	case "EIS_IRKEY_LEFT":
		break;
	case "EIS_IRKEY_RIGHT":
		break;
	case "SITV_KEY_PAGEUP":
		break;
	case "SITV_KEY_PAGEDOWN":
		break;
	case "EIS_IRKEY_BACK":
		var word = document.getElementById("word").innerHTML;
		if (word == "输入拼音首字母搜索") {
			document.getElementById("word").innerHTML = "";
			return 0;
		}
		break;
	case "EIS_IRKEY_EXIT":
		window.location.href="module.jsp";
		var word = document.getElementById("word").innerHTML;
		if (word == "输入拼音首字母搜索") {
			document.getElementById("word").innerHTML = "";
		}
		return 0;
		break;
	default:
		break;
	}
}
	var keywordArr=eval("(['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'])");
	//聚焦控件ID
	var getFocusID="menu_4_a";
	
	var Path = "${basePath}";
	//搜索关键字
	var searchWord="${searchWord}";
	//bi参数
	var pageId="5";

	function init() {
		try{
			mac=hardware.STB.serialNumber;
		}
		catch(err){
			
		}
		document.getElementById("menu_4_a").focus();
		//document.getElementById("itemList").style.left="400px";
		//热门优惠
		//var urlStr = escape(interfaceurl+getGrouponHotSearch+"?countE=2&countF=0&mac=deciveId");//&mac=deciveId
		//var ajax_url = Path + "clientUrlHandler.do?url=" + urlStr+"&pageId="+pageId+"&biType="+biPageType;
		//var _ajaxObj = new AJAX_OBJ(ajax_url, hotHandler);
		//_ajaxObj.requestData();
		if(searchWord!=""){
			document.getElementById("word").innerHTML=searchWord;
			searchItems();
		}
		var keywordStr="";
		for(var i=0;i<keywordArr.length;i++){
			var width=69;
			var height=59;
			var left=56-0+i%5*68;
			var top=298-0+Math.floor(i/5)*58;
			if(Math.floor(i/5)==1||Math.floor(i/5)==5){
				height=62;
			}
			if(Math.floor(i/5)==2){
				top=302-0+Math.floor(i/5)*58;
			}
			if(Math.floor(i/5)==3){
				top=300-0+Math.floor(i/5)*58;
			}
			
			var widthFocus=77;
			var heightFocus=67;
			var leftFocus=52-0+i%5*68;
			var topFocus=294-0+Math.floor(i/5)*58;
			if(Math.floor(i/5)==1||Math.floor(i/5)==5){
				heightFocus=70;
			}
			if(Math.floor(i/5)==2){
				topFocus=298-0+Math.floor(i/5)*58;
			}
			if(Math.floor(i/5)==3){
				topFocus=296-0+Math.floor(i/5)*58;
			}
			keywordStr+='<div style="position: absolute; left: '+left+'px; top: '+top+'px; width:69px; height:59px;">'
						+'<a id="keyboard_'+i+'" onclick="keywClick(\''+keywordArr[i]+'\');" onfocus="menuOnfocus(\'keyboard_'+i+'\')" onblur="menuLostfocus(\'keyboard_'+i+'\')" href="#">'
						+'<img src="../dzdp/dot.gif" width="'+width+'" height="'+height+'">'
						+'</a>'
						+'</div>'
						+'<div id="keyboard_'+i+'_Focus" style="visibility:hidden;position: absolute; left: '+leftFocus+'px; top: '+topFocus+'px; width:'+widthFocus+'px; height:'+heightFocus+'px;">'
						+'<img src="../dzdp/border_bg4.png" width="'+widthFocus+'" height="'+heightFocus+'">'
						+'</div>';
		}
		keywordStr+='<div style="position: absolute; left: 152px; top: 608px; width: 80px; height: 30px;">'
			+'<a id="keyboard_bs" onclick="backClick();" onfocus="menuOnfocus(\'keyboard_bs\')" onblur="menuLostfocus(\'keyboard_bs\')" href="#">'
			+'<img src="../dzdp/dot.gif" width="80" height="30">'
			+'</a>'
			+'</div>'
			+'<div id="keyboard_bs_Focus" style="visibility: hidden; position: absolute; left: 148px; top: 604px; width: 88px; height: 38px;">'
			+'<img src="../dzdp/border_bg4.png" width="88" height="38">'
			+'</div>';
		keywordStr+='<div style="position: absolute; left: 286px; top: 608px; width: 80px; height: 30px;">'
				+'<a id="keyboard_search" onclick="searchItems();" onfocus="menuOnfocus(\'keyboard_search\')" onblur="menuLostfocus(\'keyboard_search\')" href="#">'
				+'<img src="../dzdp/dot.gif" width="80" height="30">'
				+'</a>'
				+'</div>'
				+'<div id="keyboard_search_Focus" style="visibility: hidden; position: absolute; left: 282px; top: 603px; width: 88px; height: 38px;">'
				+'<img src="../dzdp/border_bg4.png" width="88" height="38">'
				+'</div>';
		document.getElementById("keyboard").innerHTML=keywordStr;
	}
	function hotHandler(result) {
		var hots = eval("(" + result.responseText + ")").response.body.dataList;
		var hotInner = "";
		for (var i = 0; i < hots.length; i++) {
			var hot = hots[i];
			hotInner += '<a href="itemDetail.jsp?dealId='
					+ hot.deal_id
					+ '&itemIDS=[]&type=&pageId='+pageId+'&funcId=13'
					+ '" style="color:#ffffff; padding-right: 25px;">'
					+ hot.name + '</a>';
		}
		document.getElementById("hotSearch").innerHTML = hotInner;
	}
	//查询
	var queryType="";//默认团购券
	function queryItems(word) {
		document.getElementById("itemList").innerHTML="";
		var urlStr= interfaceurl;
		if(queryType=="C"){
			urlStr+=getCoupon;
		}
		else{
			urlStr+=getGroupon;
		}
		urlStr+="?type=5&keyword="+ word + "&usercode=1&countF=0&countE=7&mac=deciveId&athome=false";
		var urlStr = escape(urlStr);//&mac=deciveId
		var ajax_url = Path + "clientUrlHandler.do?url=" + urlStr+"&pageId="+pageId+"&biType="+biFuncType+"&funcId=5&funcContent="+word;
		var _ajaxObj = new AJAX_OBJ(ajax_url, itemsHandler);
		_ajaxObj.requestData();
		function itemsHandler(result) {
			var items = eval("(" + result.responseText + ")").response.body.dataList;
			var itemInner = "";
			for (var i = 0; i < items.length; i++) {
				var item = items[i];
				var name=item.name.replace('?','');
				//if(name.length>20){
					//name=''+name;
				//	name=name.substring(0,18)+'...';
				//}
				itemInner +='<div style="position: absolute; top: '+(240-0+60*i)+'px; left: 437px; width: 320px; height: 46px;">'
								+'<a id="item_'+i+'" href="itemDetail.jsp?dealId='+item.deal_id+'&type=&searchWord='+word+'&itemIDS=[]&pageId='+pageId+'&funcId=5" onfocus="menuOnfocus(\'item_'+i+'\')" onblur="menuLostfocus(\'item_'+i+'\')">'
									+'<img alt="" src="../dzdp/dot.gif" width="420" height="46">'
								+'</a>'
							+'</div>'
							+'<div style="position: absolute; left: 437px; top: '+(252-0+61*i)+'px; white-space: nowrap; overflow: hidden; width: 320px; height: 35px; text-align: left;color: #ffffff;font-size: 20px;">'+name+'</div>'
							+'<div style="position: absolute; left: 753px; top: '+(252-0+60*i)+'px; width: 100px; height: 35px;text-align: right;color: #e68562;  font-weight: bolder;  font-size: 22px;">'+item.cname+'</div>'
							+'<div id="item_'+i+'_Focus" style="visibility: hidden; position: absolute; top: '+(235-0+60*i)+'px; left: 390px; width: 515px; height: 58px;">'
								+'<img alt="" src="../dzdp/border_bg4.png" width="515" height="58">'
							+'</div>'
							+'<div style=" position: absolute; top: '+(295-0+59*i)+'px; left: 423px; width: 443px; height: 1px;">'
								+'<img alt="" src="../dzdp/lineSearch.png" width="441">'
							+'</div>';
			}
			if(itemInner.length==0){
				itemInner='<div style="position: absolute; top: 280px; left: 450px;width:500px;color: #4c4d4f;font-size: 21px;">未查到聚优惠信息,请输入其它搜索条件</div>';
			}
			document.getElementById("itemList").innerHTML = itemInner;
		}
	}
	
	function itemOnfocus(obj) {
		getFocusID=obj;
		//document.getElementById(obj).style.border = "none";
		//document.getElementById(obj+"_img").style.border = "solid 2px #ffffff";
	}
	function itemLostfocus(obj) {
		//document.getElementById(obj + "_Focus").style.visibility = "hidden";
		//document.getElementById(obj+"_img").style.border = "solid 0px #ffffff";
	}
	function menuOnfocus(obj) {
		if(getFocusID=="menu_4"&&obj.indexOf("menu_")>-1 &&　getFocusID!=obj){
			document.getElementById("menu_4_Focus").style.visibility = "hidden";
		}
		else if(obj.indexOf("menu_")==-1&&getFocusID.indexOf("menu_")>-1){
			document.getElementById("menu_4_Focus").style.visibility = "visible";
		}
		else if(obj.indexOf("menu_")>-1&&getFocusID.indexOf("menu_")==-1){
			document.getElementById("menu_4_Focus").style.visibility = "hidden";
		}
		document.getElementById(obj + "_Focus").style.visibility = "visible";
		//document.getElementById("layer").innerHTML=getFocusID+"|"+obj;
		getFocusID = obj;
	}

	function menuLostfocus(obj) {
		document.getElementById(obj + "_Focus").style.visibility = "hidden";
		//document.getElementById(obj+"_img").style.border = "solid 0px #ffffff";
	}
	function menuTitleonfocus(obj){
		getFocusID = obj;
		document.getElementById("menu_4_Focus").style.visibility = "visible";
	}
	function menuTitleLostfocus(obj){
	}

	//搜索
	function searchItems() {
		var word = document.getElementById("word").innerHTML;
		if (word != "输入拼音首字母搜索") {
			queryItems(word);
			//document.getElementById("temp").style.visibility = "hidden";
		}
	}
	function searOnfocus() {
		var word = document.getElementById("word").innerHTML;
		if (word == "输入拼音首字母搜索") {
			document.getElementById("word").innerHTML = "";
		}
	}
	function searOnblur() {
		var word = document.getElementById("word").innerHTML;
		if (word == "") {
			document.getElementById("word").innerHTML = "输入拼音首字母搜索";
		}
	}
	function keywClick(word) {
		if (document.getElementById("word").innerHTML == "输入拼音首字母搜索") {
			document.getElementById("word").innerHTML = word;
		} else {
			document.getElementById("word").innerHTML += word;
		}
	}
	function backClick() {
		var word = document.getElementById("word").innerHTML;
		if (word == "输入拼音首字母搜索") {
			//document.getElementById("word").innerHTML = "";
			return;
		}
		document.getElementById("word").innerHTML = word
				.substring(0, word.length - 1);
		if (document.getElementById("word").innerHTML == "") {
			document.getElementById("word").innerHTML = "输入拼音首字母搜索";
		}
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
<epg:body onload="init()" onunload="exitMosaic()"
	style="background-repeat:no-repeat;width:1280px;height:720px;"
	bgcolor='#ffffff'>
	<!-- 背景图片以及头部图片 -->
	<div id="main_div">
		<img id="main_img" src="../dzdp/searchBG.png" border="0" width="1280" height="720" />
		<img id="logo" src="../dzdp/2.gif" style="position:absolute; left:1000px; top:40px; Z-index:1000"/>
	</div>
	<!-- <div id="layer" style="position:absolute;zIndex:10; width: 1200px; height: 40px;left: 0px;top: 90px;text-align: center;font-size: 30px;"></div> -->
	<jsp:include page="header.jsp" flush="true" />
	
	<div id="content" style="position: absolute; top: 0px; left: 0px; width: 1280px; height: 720px;">
		<div id="word" style="position: absolute; top: 223px; left: 75px; font-size: 26px; color: #ffffff; width: 865px; height: 55px;">输入拼音首字母搜索</div>
		<div id="keyboard">
			
		</div>
		<div id="temp" style="position: absolute; left: 883px; top: 178px; color: #ffffff;">
			<img alt="" src="../dzdp/info.png">
		</div>
		<div id="itemList">
			<!-- <div style="position: absolute; top: 252px; left: 457px; width: 322px; height: 35px;">
				<a id="item_0" href="itemDetail.jsp?dealId=14-6022494&amp;type=&amp;searchWord=T&amp;itemIDS=[]&amp;pageId=5&amp;funcId=5" onfocus="itemOnfocus('item_0')" onblur="itemLostfocus('item_0')">
					<img alt="" src="../dzdp/dot.gif" width="330" height="50">
				</a>
			</div>
			<div style="position: absolute; left: 457px; top: 252px; white-space: nowrap; overflow: hidden; width: 320px; height: 35px; text-align: left;color: #4c4d4f;font-weight: bolder;font-size: 22px;">爱康国宾体检中心</div>
			<div style="position: absolute; left: 778px; top: 252px; width: 100px; height: 35px;text-align: right;color: #e68562;  font-weight: bolder;  font-size: 22px;">生活娱乐</div>
			<div id="item_0_Focus" style="visibility: hidden; position: absolute; top: 235px; left: 410px; width: 515px; height: 58px;">
				<img alt="" src="../dzdp/border_bg4.png" width="515" height="58">
			</div> -->
		</div>
	</div>
</epg:body>
</epg:html>
