<%@page contentType="text/html; charset=gbk"%>
<%@taglib uri="http://chances.com.cn/jsp/epg" prefix="epg"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% 
	String path = request.getContextPath(); 
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
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
	switch (eventObj.code) {
	case "EIS_IRKEY_UP":
		break;
	case "EIS_IRKEY_DOWN":
		break;
	case "EIS_IRKEY_SELECT":
		break;
	case "EIS_IRKEY_LEFT":
		if (getFocusID=="category_1"||getFocusID=="category_48"||getFocusID=="category_86") {
			window.location.href="groupby.jsp";
			return 0;
		}
		break;
	case "EIS_IRKEY_RIGHT":
		if (getFocusID=="category_39"||getFocusID=="category_76"||getFocusID=="category_94") {
			window.location.href="search.jsp";
			return 0;
		}
		else if(getFocusID=="menu_5"){
			document.getElementById("menu_module").focus();
		}
		break;
	case "SITV_KEY_PAGEUP":
		break;
	case "SITV_KEY_PAGEDOWN":
		break;
	case "EIS_IRKEY_EXIT":
		return 0;
		break;
	default:
		return 1;
		break;
	}
}
//聚焦控件ID
var getFocusID = "menu_3_a";
var getFocusIDLongJing="";

var Path = "${basePath}";
var pageId="4";

function init(){
	setCookie("pageIndex",0);
	document.getElementById("menu_3_a").focus();

	try{
		mac=hardware.STB.serialNumber;
	}
	catch(err){
		
	}
	var urlStr=escape(interfaceurl+getCouponCategorys+"?count=10&parentid=0&usercode=1&mac=deciveId&athome=false");//&mac=deciveId
	var ajax_url = Path+"clientUrlHandler.do?url="+urlStr+"&pageId="+pageId+"&biType="+biPageType;
	var _ajaxObj = new AJAX_OBJ(ajax_url,handlCoupon);
	_ajaxObj.requestData();
}
function handlCoupon(result){
	var categorys=eval("("+result.responseText+")").response.body.dataList;
	for(var i=0;i<categorys.length;i++){
		var category=categorys[i];
		try{
			document.getElementById("category_"+category.category_id+"_count").innerHTML=category.sum_soft+'<span style="font-size: 18px; padding-left:5px;">个</span>';
			document.getElementById("category_"+category.category_id+"_name").innerHTML=category.name;
			document.getElementById("category_"+category.category_id+"_count_focus").innerHTML=category.sum_soft+'<span style="font-size: 18px; padding-left:5px;">个</span>';
			document.getElementById("category_"+category.category_id+"_name_focus").innerHTML=category.name;
			document.getElementById("category_"+category.category_id+"_a").href=encodeURI(document.getElementById("category_"+category.category_id+"_a").href+"&itemsCount="+category.sum_soft+"&categoryName="+category.name+"&type=C");
			document.getElementById("category_"+category.category_id+"_a").href=encodeURI(document.getElementById("category_"+category.category_id+"_a").href+"&itemsCount="+category.sum_soft+"&categoryName="+category.name+"&type=C");
		}
		catch(e){
			//alert(e);
		}
	}
}

function menuOnfocus(obj) {
	if(getFocusID=="menu_3"&&obj.indexOf("menu_")>-1 &&　getFocusID!=obj){
		document.getElementById("menu_3_Focus").style.visibility = "hidden";
	}
	else if(obj.indexOf("category_")>-1&&getFocusID.indexOf("menu_")>-1){
		document.getElementById("menu_3_Focus").style.visibility = "visible";
	}
	else if(obj.indexOf("menu_")>-1&&getFocusID.indexOf("category_")>-1){
		document.getElementById("menu_3_Focus").style.visibility = "hidden";
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
	document.getElementById("menu_3_Focus").style.visibility = "visible";
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
<div  id="main_div">
	<img id="main_img" src="../dzdp/couponBG1.png"  border="0" width="1280" height="720" />
</div>
<jsp:include page="header.jsp" flush="true" />
	
<div id="content" style="position:absolute;top:0px;left:0px;width:1280px;height:720px;">
	<div style="position:absolute;top:352px;left:5px;width:36px;height:70px; display:none;">
		<img src="../dzdp/toLeft.png" width="36" height="70">
	</div>
	<div style="position:absolute;top:352px;left:1240px;width:36px;height:70px; display:none;">
		<img src="../dzdp/toRight.png" width="36" height="70">
	</div>
	<div id="category_1" style="position:absolute;top:195px;left:78px;width:369px;height:149px;" >
		<a id="category_1_a" href="categoryChildList.jsp?categoryId=1&pageId=17" onfocus="menuOnfocus('category_1')" onblur="menuLostfocus('category_1')">
			<img id="category_1_img" src="../dzdp/dot.png" width="369" height="149" />
			<span id="category_1_count" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_1_name" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">美食</span>
		</a>
	</div>
	<div id="category_23" style="position:absolute;top:195px;left:458px;width:369px;height:149px;" >
		<a id="category_23_a" href="categoryChildList.jsp?categoryId=23&pageId=18" onfocus="menuOnfocus('category_23')" onblur="menuLostfocus('category_23')">
			<img id="category_23_img" src="../dzdp/dot.png" width="369" height="149" />
			<span id="category_23_count" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_23_name" style="position: absolute;top: 110px;left: 240px;font-weight: bold; color:#ffffff;font-size: 28px;">休闲娱乐</span>
		</a>
	</div>
	<div id="category_39"  style="position:absolute;top:195px;left:839px;width:369px;height:149px;">
		<a id="category_39_a" href="categoryChildList.jsp?categoryId=39&pageId=19" onfocus="menuOnfocus('category_39')" onblur="menuLostfocus('category_39')" >
			<img id="category_39_img" src="../dzdp/dot.png" width="369" height="149" />
			<span id="category_39_count" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_39_name" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">购物</span>
		</a>
	</div>
	<div id="category_48" style="position:absolute;top:352px;left:79px;width:184px;height:149px;" >
		<a id="category_48_a" href="categoryChildList.jsp?categoryId=48&pageId=20" onfocus="menuOnfocus('category_48')" onblur="menuLostfocus('category_48')">
			<img id="category_48_img" src="../dzdp/dot.png" width="185" height="149" />
			<span id="category_48_count" style="position: absolute;top: 18px;left:0px; width: 170px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">丽人</span>
			<span id="category_48_name" style="position: absolute;top: 110px;left:0px; width: 170px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
		</a>
	</div>
	<div id="category_69"  style="position:absolute;top:351px;left:269px;width:369px;height:149px;">
		<a id="category_69_a" href="categoryChildList.jsp?categoryId=69&pageId=22" onfocus="menuOnfocus('category_69')" onblur="menuLostfocus('category_69')">
			<img id="category_69_img" src="../dzdp/dot.png" width="369" height="149" />
			<span id="category_69_count" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_69_name" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">亲子</span>
		</a>
	</div>
	<div id="category_57" style="position:absolute;top:351px;left:645px;width:369px;height:149px;">
		<a id="category_57_a" href="categoryChildList.jsp?categoryId=57&pageId=21" onfocus="menuOnfocus('category_57')" onblur="menuLostfocus('category_57')">
			<img id="category_57_img" src="../dzdp/dot.png" width="369" height="149" />
			<span id="category_57_count" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_57_name" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">结婚</span>
		</a>
	</div>
	<div id="category_76"  style="position:absolute;top:351px;left:1021px;width:185px;height:149px;">
		<a id="category_76_a" href="categoryChildList.jsp?categoryId=76&pageId=23" onfocus="menuOnfocus('category_76')" onblur="menuLostfocus('category_76')">
			<img id="category_76_img" src="../dzdp/dot.png" width="185" height="149" />
			<span id="category_76_count" style="position: absolute;top: 18px;left: 0px;font-weight: bold;width: 170px;text-align: right; color:#ffffff;font-size: 28px;">运动健身</span>
			<span id="category_76_name" style="position: absolute;top: 110px;left:0px; width: 170px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
		</a>
	</div>
	<div id="category_86"  style="position:absolute;top:508px;left:80px;width:366px;height:145px;">
		<a id="category_86_a" href="categoryChildList.jsp?categoryId=86&pageId=24" onfocus="menuOnfocus('category_86')" onblur="menuLostfocus('category_86')">
			<img id="category_86_img" src="../dzdp/dot.png" width="366" height="145" />
			<span id="category_86_count" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_86_name" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">酒店</span>
		</a>
	</div>
	<div id="category_91"  style="position:absolute;top:508px;left:459px;width:367px;height:146px;">
		<a id="category_91_a" href="categoryChildList.jsp?categoryId=91&pageId=25" onfocus="menuOnfocus('category_91')" onblur="menuLostfocus('category_91')">
			<img id="category_91_img" src="../dzdp/dot.png" width="367" height="146" />
			<span id="category_91_count" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_91_name" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">家装</span>
		</a>
	</div>
	<div id="category_94"  style="position:absolute;top:508px;left:838px;width:367px;height:145px;">
		<a id="category_94_a" href="categoryChildList.jsp?categoryId=94&pageId=26" onfocus="menuOnfocus('category_94')" onblur="menuLostfocus('category_94')">
			<img id="category_94_img" src="../dzdp/dot.png" width="367" height="146" />
			<span id="category_94_count" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_94_name" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"></span>
		</a>
	</div>
	
	<div id="category_1_Focus" style="position:absolute;visibility:hidden;top:185px;left:68px;width:369px;height:149px;" >
		<img id="menuFocus_1_img" src="../dzdp/youhuijuan_meishi_Focus.png" width="395" height="167" />
			<span id="category_1_count_focus" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_1_name_focus" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"></span>
	</div>
	<div id="category_23_Focus" style="position:absolute;visibility:hidden;top:185px;left:443px;width:395px;height:167px;" >
		<img id="menuFocus_23_img" src="../dzdp/youhuijuan_xiuxian_Focus.png" width="395" height="167" />
			<span id="category_23_count_focus" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_23_name_focus" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"></span>
	</div>
	<div id="category_39_Focus"  style="position:absolute;visibility:hidden;top:185px;left:822px;width:395px;height:167px;">
		<img id="menuFocus_39_img" src="../dzdp/youhuijuan_gouwu_Focus.png" width="395" height="167" />
			<span id="category_39_count_focus" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_39_name_focus" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"></span>
	</div>
	<div id="category_48_Focus" style="position:absolute;visibility:hidden;top:342px;left:74px;width:192px;height:167px;" >
		<img id="menuFocus_48_img" src="../dzdp/youhuijuan_liren_Focus.png" width="195" height="167" />
			<span id="category_48_count_focus" style="position: absolute;top: 18px;left:0px; width: 170px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_48_name_focus" style="position: absolute;top: 110px;left:0px; width: 170px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"></span>
	</div>
	<div id="category_69_Focus"  style="position:absolute;visibility:hidden;top:342px;left:263px;width:395px;height:167px;">
		<img id="menuFocus_69_img" src="../dzdp/youhuijuan_qinzi_Focus.png" width="395" height="167" />
			<span id="category_69_count_focus" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_69_name_focus" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"></span>
	</div>
	<div id="category_57_Focus" style="position:absolute;visibility:hidden;top:342px;left:637px;width:395px;height:167px;">
		<img id="menuFocus_57_img" src="../dzdp/youhuijuan_jiehun_Focus.png" width="395" height="167" />
			<span id="category_57_count_focus" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_57_name_focus" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"></span>
	</div>
	<div id="category_76_Focus"  style="position:absolute;visibility:hidden;top:342px;left:1015px;width:192px;height:167px;">
		<img id="menuFocus_76_img" src="../dzdp/youhuijuan_jianshen_Focus.png" width="195" height="167" />
			<span id="category_76_count_focus" style="position: absolute;top: 18px;left:0px; width: 170px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_76_name_focus" style="position: absolute;top: 110px;left:0px; width: 170px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"></span>
	</div>
	<div id="category_86_Focus"  style="position:absolute;visibility:hidden;top:495px;left:70px;width:395px;height:167px;">
		<img id="menuFocus_86_img" src="../dzdp/youhuijuan_jiudian_Focus.png" width="395" height="167" />
			<span id="category_86_count_focus" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_86_name_focus" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"></span>
	</div>
	<div id="category_91_Focus"  style="position:absolute;visibility:hidden;top:495px;left:449px;width:395px;height:167px;">
		<img id="menuFocus_91_img" src="../dzdp/youhuijuan_fuwu_Focus.png" width="395" height="167" />
			<span id="category_91_count_focus" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_91_name_focus" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"></span>
	</div>
	<div id="category_94_Focus"  style="position:absolute;visibility:hidden;top:495px;left:826px;width:395px;height:167px;">
		<img id="menuFocus_94_img" src="../dzdp/youhuijuan_aiche_Focus.png" width="395" height="167" />
			<span id="category_94_count_focus" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_94_name_focus" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"></span>
	</div>
</div>
</epg:body>
</epg:html>
