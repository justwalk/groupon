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
	switch (eventObj.code) {
	case "EIS_IRKEY_UP":
		break;
	case "EIS_IRKEY_DOWN":
		break;
	case "EIS_IRKEY_SELECT":
		break;
	case "EIS_IRKEY_LEFT":
		if (getFocusID=="category_1"||getFocusID=="category_68"||getFocusID=="category_107") {
			window.location.href="index.jsp";
			return 0;
		}
		break;
	case "EIS_IRKEY_RIGHT":
		if (getFocusID=="category_53"||getFocusID=="category_96"||getFocusID=="category_126") {
			//window.location.href="coupon.jsp";
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
		window.location.href="module.jsp";
		return 0;
		break;
	default:
		return 1;
		break;
	}
}
//聚焦控件ID
var getFocusID = "menu_2";
var getFocusIDLongJing="";
var Path = "${basePath}";
var pageId="3";

function init(){
	setCookie("pageIndex",0);
	document.getElementById("menu_2_a").focus();
	try{
		mac=hardware.STB.serialNumber;
	}
	catch(err){
		
	}
	var urlStr=escape(interfaceurl+getGrouponCategorys+"?count=10&parentid=0&usercode=1&mac=deciveId&athome=false");//mac=deciveId&
	var ajax_url = Path+"clientUrlHandler.do?url="+urlStr+"&pageId="+pageId+"&biType="+biPageType;
	var _ajaxObj = new AJAX_OBJ(ajax_url,handlGroupby);
	_ajaxObj.requestData();
}
function handlGroupby(result){
	var categorys=eval("("+result.responseText+")").response.body.dataList;
	for(var i=0;i<categorys.length;i++){
		var category=categorys[i];
		try{
			var cateID=category.category_id;
			document.getElementById("category_"+cateID+"_count").innerHTML=category.sum_soft+'<span style="font-size: 18px; padding-left:5px;">个</span>';
			document.getElementById("category_"+cateID+"_name").innerHTML=category.name;
			document.getElementById("category_"+cateID+"_count_focus").innerHTML=category.sum_soft+'<span style="font-size: 18px; padding-left:5px;">个</span>';
			document.getElementById("category_"+cateID+"_name_focus").innerHTML=category.name;
			document.getElementById("category_"+category.category_id+"_a").href=encodeURI(document.getElementById("category_"+category.category_id+"_a").href+"&itemsCount="+category.sum_soft+"&categoryName="+category.name+"&type=");
			document.getElementById("category_"+category.category_id+"_a").href=encodeURI(document.getElementById("category_"+category.category_id+"_a").href+"&itemsCount="+category.sum_soft+"&categoryName="+category.name+"&type=");
		}
		catch(e){
			//alert(category.category_id);
		}
	}
}

function menuOnfocus(obj) {
	if(getFocusID=="menu_2"&&obj.indexOf("menu_")>-1 &&　getFocusID!=obj){
		document.getElementById("menu_2_Focus").style.visibility = "hidden";
	}
	else if(obj.indexOf("category_")>-1&&getFocusID.indexOf("menu_")>-1){
		document.getElementById("menu_2_Focus").style.visibility = "visible";
	}
	else if(obj.indexOf("menu_")>-1&&getFocusID.indexOf("category_")>-1){
		document.getElementById("menu_2_Focus").style.visibility = "hidden";
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
	document.getElementById("menu_2_Focus").style.visibility = "visible";
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
	<img id="main_img" src="../dzdp/groupbuyBG1.png"  border="0" width="1280" height="720" />
	<img id="logo" src="../dzdp/2.gif" style="position:absolute; left:1000px; top:40px; Z-index:1000"/>
</div>
<!-- <div id="layer" style="position:absolute;z-index:10; width: 1200px; height: 40px;left: 0px;top: 90px;text-align: center;font-size: 30px;"></div> -->
<jsp:include page="header.jsp" flush="true" />

<div id="content" style="position:absolute;top:0px;left:0px;width:1280px;height:720px;">
	<div id="category_1" style="position:absolute;top:195px;left:78px;width:369px;height:149px;" >
		<a id="category_1_a" href="categoryChildList.jsp?categoryId=1&pageId=7" onfocus="menuOnfocus('category_1')" onblur="menuLostfocus('category_1')">
			<img id="category_1_img" src="../dzdp/dot.png" width="367" height="149" />
			<span id="category_1_count" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_1_name" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">购物</span>
		</a>
	</div>
	<div id="category_12" style="position:absolute;top:195px;left:458px;width:369px;height:149px;" >
		<a id="category_12_a" href="categoryChildList.jsp?categoryId=12&pageId=8" onfocus="menuOnfocus('category_12')" onblur="menuLostfocus('category_12')">
			<img id="category_12_img" src="../dzdp/dot.png" width="367" height="149" />
			<span id="category_12_count" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_12_name" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">美食</span>
		</a>
	</div>
	<div id="category_53"  style="position:absolute;top:195px;left:839px;width:369px;height:149px;">
		<a id="category_53_a" href="categoryChildList.jsp?categoryId=53&pageId=9" onfocus="menuOnfocus('category_53')" onblur="menuLostfocus('category_53')" >
			<img id="category_53_img" src="../dzdp/dot.png" width="367" height="149" />
			<span id="category_53_count" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_53_name" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">休闲娱乐</span>
		</a>
	</div>
	<div id="category_68" style="position:absolute;top:352px;left:79px;width:184px;height:149px;" >
		<a id="category_68_a" href="categoryChildList.jsp?categoryId=68&pageId=10" onfocus="menuOnfocus('category_68')" onblur="menuLostfocus('category_68')">
			<img id="category_68_img" src="../dzdp/dot.png" width="185" height="149" />
			<span id="category_68_name" style="position: absolute;top: 110px;left:0px; width: 170px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">抽奖</span>
			<span id="category_68_count" style="position: absolute;top: 18px;left:0px; width: 170px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
		</a>
	</div>
	<div id="category_69" style="position:absolute;top:351px;left:269px;width:369px;height:149px;">
		<a id="category_69_a" href="categoryChildList.jsp?categoryId=69&pageId=11" onfocus="menuOnfocus('category_69')" onblur="menuLostfocus('category_69')">
			<img id="category_69_img" src="../dzdp/dot.png" width="367" height="149" />
			<span id="category_69_count" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_69_name" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">丽人</span>
		</a>
	</div>
	<div id="category_79"  style="position:absolute;top:351px;left:645px;width:369px;height:149px;">
		<a id="category_79_a" href="categoryChildList.jsp?categoryId=79&pageId=12" onfocus="menuOnfocus('category_79')" onblur="menuLostfocus('category_79')">
			<img id="category_79_img" src="../dzdp/dot.png" width="367" height="149" />
			<span id="category_79_count" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_79_name" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">结婚亲子</span>
		</a>
	</div>
	<div id="category_96"  style="position:absolute;top:351px;left:1021px;width:185px;height:149px;">
		<a id="category_96_a" href="categoryChildList.jsp?categoryId=96&pageId=13" onfocus="menuOnfocus('category_96')" onblur="menuLostfocus('category_96')">
			<img id="category_96_img" src="../dzdp/dot.png" width="185" height="149" />
			<span id="category_96_name" style="position: absolute;top: 110px;left:0px; width: 170px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">酒店</span>
			<span id="category_96_count" style="position: absolute;top: 18px;left:0px; width: 170px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
		</a>
	</div>
	<div id="category_107"  style="position:absolute;top:508px;left:80px;width:366px;height:145px;">
		<a id="category_107_a" href="categoryChildList.jsp?categoryId=107&pageId=14" onfocus="menuOnfocus('category_107')" onblur="menuLostfocus('category_107')">
			<img id="category_107_img" src="../dzdp/dot.png" width="367" height="149" />
			<span id="category_107_count" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_107_name" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">生活服务</span>
		</a>
	</div>
	<div id="category_125"  style="position:absolute;top:508px;left:459px;width:367px;height:146px;">
		<a id="category_125_a" href="categoryChildList.jsp?categoryId=125&pageId=15" onfocus="menuOnfocus('category_125')" onblur="menuLostfocus('category_125')">
			<img id="category_125_img" src="../dzdp/dot.png" width="367" height="149" />
			<span id="category_125_count" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_125_name" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">院线影院</span>
		</a>
	</div>
	<div id="category_126"  style="position:absolute;top:508px;left:838px;width:367px;height:145px;">
		<a id="category_126_a" href="categoryChildList.jsp?categoryId=126&pageId=16" onfocus="menuOnfocus('category_126')" onblur="menuLostfocus('category_126')">
			<img id="category_126_img" src="../dzdp/dot.png" width="375" height="157" />
			<span id="category_126_count" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
			<span id="category_126_name" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">旅游</span>
		</a>
	</div>
	
	<div id="category_1_Focus" style="position:absolute;visibility:hidden;top:190px;left:63px;width:395px;height:167px;" >
		<img id="menuFocus_1_img" src="../dzdp/gouwu_Focus.png" width="395" height="167" />
		<span id="category_1_count_focus" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
		<span id="category_1_name_focus" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">购物</span>
	</div>
	<div id="category_12_Focus" style="position:absolute;visibility:hidden;top:190px;left:445px;width:395px;height:167px;" >
		<img id="menuFocus_12_img" src="../dzdp/meishi_Focus.png" width="395" height="167" />
		<span id="category_12_count_focus" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
		<span id="category_12_name_focus" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">生活服务</span>
	</div>
	<div id="category_53_Focus"  style="position:absolute;visibility:hidden;top:190px;left:826px;width:395px;height:167px;">
		<img id="menuFocus_53_img" src="../dzdp/xiuxian_Focus.png" width="395" height="167" />
		<span id="category_53_count_focus" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
		<span id="category_53_name_focus" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">生活服务</span>
	</div>
	<div id="category_68_Focus" style="position:absolute;visibility:hidden;top:347px;left:70px;width:195px;height:167px;" >
		<img id="menuFocus_68_img" src="../dzdp/choujiang_Focus.png" width="195" height="167" />
			<span id="category_68_name_focus" style="position: absolute;top: 110px;left:0px; width: 170px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">酒店</span>
			<span id="category_68_count_focus" style="position: absolute;top: 18px;left:0px; width: 170px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
	</div>
	<div id="category_69_Focus" style="position:absolute;visibility:hidden;top:347px;left:255px;width:395px;height:167px;">
		<img id="menuFocus_69_img" src="../dzdp/liren_Focus.png" width="395" height="167" />
		<span id="category_69_count_focus" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
		<span id="category_69_name_focus" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">生活服务</span>
	</div>
	<div id="category_79_Focus"  style="position:absolute;visibility:hidden;top:347px;left:637px;width:395px;height:167px;">
		<img id="menuFocus_79_img" src="../dzdp/jiehun_Focus.png" width="395" height="167" />
		<span id="category_79_count_focus" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
		<span id="category_79_name_focus" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">生活服务</span>
	</div>
	<div id="category_96_Focus"  style="position:absolute;visibility:hidden;top:347px;left:1019px;width:192px;height:167px;">
		<img id="menuFocus_96_img" src="../dzdp/jiudian.png" width="192" height="167" />
			<span id="category_96_name_focus" style="position: absolute;top: 110px;left:0px; width: 170px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">酒店</span>
			<span id="category_96_count_focus" style="position: absolute;top: 18px;left:0px; width: 170px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
	</div>
	<div id="category_107_Focus"  style="position:absolute;visibility:hidden;top:503px;left:65px;width:395px;height:167px;">
		<img id="menuFocus_107_img" src="../dzdp/shenghuo_Focus.png" width="395" height="167" />
		<span id="category_107_count_focus" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
		<span id="category_107_name_focus" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">生活服务</span>
	</div>
	<div id="category_125_Focus"  style="position:absolute;visibility:hidden;top:503px;left:445px;width:395px;height:167px;">
		<img id="menuFocus_125_img" src="../dzdp/yingyuan_Focus.png" width="395" height="167" />
		<span id="category_125_count_focus" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
		<span id="category_125_name_focus" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">院线影院</span>	
	</div>
	<div id="category_126_Focus"  style="position:absolute;visibility:hidden;top:503px;left:826px;width:395px;height:167px;">
		<img id="menuFocus_126_img" src="../dzdp/lvyou_Focus.png" width="395" height="167" />
		<span id="category_126_count_focus" style="position: absolute;top: 18px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;"><span style="font-size: 18px; padding-left:5px;"></span></span>
		<span id="category_126_name_focus" style="position: absolute;top: 110px;left:0px; width: 350px;text-align: right;font-weight: bold; color:#ffffff;font-size: 28px;">旅游</span>
	</div>
</div>
</epg:body>
</epg:html>
