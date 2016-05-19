<%@page contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://chances.com.cn/jsp/epg" prefix="epg"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% 
	String path = request.getContextPath(); 
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
	request.setAttribute("basePath", basePath);
	
%> 
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
function layerAlert(msg)
{
	layer.innerHTML=msg;
	document.getElementById("layer").style.visibility = "visible";
    setTimeout('document.getElementById("layer").style.visibility = "hidden"',2000);
}
function eventHandler(eventObj) {
	switch (eventObj.code) {
	case "EIS_IRKEY_UP":
		break;
	case "EIS_IRKEY_DOWN":
		//document.getElementById("layer").innerHTML=getFocusID;
		if(getFocusID.indexOf('province_a')>-1){
			//var menuIndex=getFocusID.replace("province_a",'')-0+1;
			//document.getElementById("layer").innerHTML=menuIndex;
			//document.getElementById("province_a"+menuIndex).focus();
			//return 0;
		}
		break;
	case "EIS_IRKEY_SELECT":
		break;
	case "EIS_IRKEY_LEFT":
		if(getFocusID=="btn_save"){
			//document.getElementById("telNo").focus();
			//return 0;
		}
		else if(getFocusID.indexOf('province_a')>-1){
			//return 0;
		}
		else if(getFocusID.indexOf('city_a')>-1){
			//document.getElementById("city_a1").focus();
			//document.getElementById("district_a1").focus();
		}
		else if(getFocusID.indexOf('menu_')>-1){
			var menuIndex=getFocusID.split('_')[1];
			document.getElementById("menu_"+(menuIndex-1)+"_a").focus();
			return 0;
		}
		break;
	case "EIS_IRKEY_RIGHT":
		//if(getFocusID=="telNo"){
		//	document.getElementById("btn_save").focus();
		//	return 0;
		//}
		if(getFocusID.indexOf('district_a')>-1){
			//document.getElementById("city_a1").focus();
			//return 0;
		}
		else if(getFocusID.indexOf('city_a')>-1){
			//document.getElementById("province_a1").focus();
			//return 0;
		}
		else if(getFocusID.indexOf('menu_')>-1){
			var menuIndex=getFocusID.split('_')[1];
			document.getElementById("menu_"+(menuIndex-0+1)+"_a").focus();
			return 0;
		}
		break;
	case "EIS_IRKEY_BACK":
		//if(getFocusID=="telNo"){
		//	document.getElementById("telNo").value=document.getElementById("telNo").value.substring(0,document.getElementById("telNo").value.length-1);
		//}
		//return 0;
		break;
	case "EIS_IRKEY_UP":
		break;
	case "SITV_KEY_PAGEDOWN":
		break;
	default:
		return 1;
		break;
	}
}
</script>
<style>
	div,span{
		color:#ffffff;
	}
	.pro_content{
		padding-left:15px;
		font-size: 20px;
		padding-top: 5px;
		font-family: 黑体;
	}
	ul { list-style-type: none }
	ul li{
		padding-top:5px;
		padding-bottom:30px;
		text-algin:left;
	}
	ul li a span{
		font-size:25px;
		color:#000000;
	}
	ul li a:hover { text-decoration:blink;color: red}
</style>
<script>
//聚焦控件ID
var getFocusID="menu_1_a";
var Path = "${basePath}";
var leaveFocus;
var numbers;//二级菜单下的总数；
var biggerWidth;
var biggerHeight;
var biggerLeft;
var biggerTop;
var url = window.location.href;
var firstMenuName;

function init(){
	document.getElementById("menu_5_a").focus();
	//设置用户信息
	try{
		var urlStr=escape(interfaceurl+"getNameAndPhoneByMac?mac=deciveId");
		var ajax_url = Path+"clientUrlHandler.do?url="+urlStr;
		var _ajaxObj = new AJAX_OBJ(ajax_url,handlGetInfo);
		_ajaxObj.requestData();
	}
	catch(pe){
		
	}
	//获取城市信息
	var urlStr=escape(interfaceurl+"findCityByXml");
	var ajax_url = Path+"clientUrlHandler.do?url="+urlStr;
	var _ajaxObj = new AJAX_OBJ(ajax_url,handlGetCitys);
	_ajaxObj.requestData();
}
//查询省份
function handlGetCitys(result){
	var provinces=eval("("+result.responseText+")").response.body.dataList;
	var provinceInner="";
	for(var i=0;i<provinces.length;i++){
		var province=provinces[i];
		provinceInner+=
			'<div style="position: absolute;width:198px;height:43px; top:'+(48+(i-1)*35)+'px; left:0px;">'+
				'<a href="#" style="position: absolute;width:198px;height:40px; top:0px; left:0px;" id="province_a'+i+'" onfocus="btnOnFocus(\'province_a'+i+'\');" onclick="queryCityByName(\''+province.name+'\',\''+province.id+'\');setInput(\''+province.name+'\',\''+province.id+'\');return false;">'+
					'<div style="overflow: hidden;height: 40px; position: absolute;left: 0;top:13px; width: 150px; color:#ffffff; font-size:20px;">'+province.name+'</div>'+
				'</a>'+
				'<img alt="" src="../dzdp/line.png" style="height:1px; width:115px;position:absolute; top:40px; left:0;">'+
			'</div>';
	}
	document.getElementById("ulProvince").innerHTML=provinceInner;
	document.getElementById("ulCity").innerHTML="";
	document.getElementById("ulCity1").innerHTML="";
	document.getElementById("ulDistric").innerHTML="";
}

function handlGetInfo(result){
	try{
		var userInfo=eval("("+result.responseText+")").response.body.dataList;
		document.getElementById("distric").innerHTML=userInfo[0].name;
		document.getElementById("districID").value=userInfo[0].id;
		//document.getElementById("telNo").value=userInfo[0].phone;
	}
	catch(e){
		
	}
}

//查询县区
function queryCityByName(name,id){
	var urlStr=encodeURI(interfaceurl+"getJsonCityName?id="+id);
	var ajax_url = Path+"clientUrlHandler.do?url="+urlStr;
	var _ajaxObj = new AJAX_OBJ(ajax_url,citysHandler);
	_ajaxObj.requestData();
}
function citysHandler(citysStr){
	var citys=eval("("+citysStr.responseText+")").response.body.dataList;
	var cityInner="";
	var cityInner1="";
	for(var i=1;i<citys.length;i++){
		var city=citys[i];
		if(i<13){
			cityInner+=
				'<div style="position: absolute;width:155px;height:43px; top:'+(13+(i-1)*35)+'px; left:0px;">'+
					'<a href="#" id="city_a'+i+'" style="position: absolute;width:155px;height:40px; top:0px; left:0px;" onfocus="btnOnFocus(\'city_a'+i+'\');" onclick="queryDistrictByCity(\''+city.id+'\',\''+city.pid+'\');setInput(\''+city.name+'\',\''+city.id+'\');return false;">'+
						'<div style="overflow: hidden;height: 23px;  color:#ffffff;position: absolute;left: 0;top:13px; width: 150px; font-size:20px;">'+city.name+'</div>'+
					'</a>'+
					'<img alt="" src="../dzdp/line.png" style="height:1px; width:115px;position:absolute; top:40px; left:0;">'+
				'</div>';
		}
		else{
			cityInner1+=
				'<div style="position: absolute;width:167px;height:43px; top:'+(13+(i%13)*35)+'px; left:0px;">'+
					'<a href="#" id="city_a'+i+'" style="position: absolute;width:167px;height:40px; top:0px; left:0px;" onfocus="btnOnFocus(\'city_a'+i+'\');" onclick="queryDistrictByCity(\''+city.id+'\',\''+city.pid+'\');setInput(\''+city.name+'\',\''+city.id+'\');return false;">'+
						'<div style="overflow: hidden;height: 23px;  color:#ffffff;position: absolute;left: 0;top:13px; width: 150px; font-size:20px;">'+city.name+'</div>'+
					'</a>'+
					'<img alt="" src="../dzdp/line.png" style="height:1px; width:115px;position:absolute; top:40px; left:0;">'+
				'</div>';
		}
	}
	document.getElementById("ulCity").innerHTML=cityInner;
	document.getElementById("ulCity1").innerHTML=cityInner1;
	document.getElementById("ulDistric").innerHTML="";
}
//查询商圈
function queryDistrictByCity(id,pid){
	var urlStr=encodeURI(interfaceurl+"getJsonDistrictName?id="+id+"&pid="+pid);
	var ajax_url = Path+"clientUrlHandler.do?url="+urlStr;
	var _ajaxObj = new AJAX_OBJ(ajax_url,districtsHandler);
	_ajaxObj.requestData();
}
function districtsHandler(districtsStr){
	var districts=eval("("+districtsStr.responseText+")").response.body.dataList;
	var districtInner="";
	var districtInner1="";
	for(var i=0;i<districts.length;i++){
		var district=districts[i];
		if(i<13){
			districtInner+=
				'<div style="position: absolute;width:218px;height:40px; top:'+(13+(i)*35)+'px; left:0px;">'+
					'<a href="#" id="district_a'+i+'" style="position: absolute;width:218px;height:40px; top:0px; left:0px;" onfocus="btnOnFocus(\'district_a'+i+'\');" onclick="setInput(\''+district.name+'\',\''+district.id+'\');return false;">'+
						'<span style="overflow: hidden;height: 40px; color:#ffffff;position: absolute;left: 0;top:13px; width: 200px; font-size:20px;">'+district.name+'</span>'+
					'</a>'+
					'<img alt="" src="../dzdp/line.png" style="height:1px; width:115px;position:absolute; top:40px; left:0;">'+
				'</div>';
		}
		else{
			districtInner1+=
				'<div style="position: absolute;width:150px;height:40px; top:'+(13+(i%13)*35)+'px; left:0px;">'+
					'<a href="#" id="district_a'+i+'" style="position: absolute;width:150px;height:40px; top:0px; left:0px;" onfocus="btnOnFocus(\'district_a'+i+'\');" onclick="setInput(\''+district.name+'\',\''+district.id+'\');return false;">'+
						'<span style="overflow: hidden;height: 40px; color:#ffffff;position: absolute;left: 0;top:13px; width: 200px; font-size:20px;">'+district.name+'</span>'+
					'</a>'+
					'<img alt="" src="../dzdp/line.png" style="height:1px; width:115px;position:absolute; top:40px; left:0;">'+
				'</div>';
		}
	}
	document.getElementById("ulDistric").innerHTML=districtInner;
	document.getElementById("ulDistric1").innerHTML=districtInner1;
}
//保存选中名称和ID
function setInput(name,id){
	document.getElementById("distric").innerHTML=name;
	document.getElementById("districID").value=id;
}
//保存设置信息
function saveSetting(){
	var id=document.getElementById("districID").value;
	var name=document.getElementById("distric").innerHTML;
	var phone="";
	//var phone=document.getElementById("telNo").value;
	//if(!isPhone(phone)){
	//	layerAlert("请输入正确的手机号码");
	//	return;
	//}
	var mac="deciveId";
	var host=interfaceurl;
	//var ajax_url = Path+"saveSetting.do?phone="+phone+"&mac="+mac+"&name="+encodeURI(name)+"&id="+id+"&host="+escape(host);
	var ajax_url = Path+"saveSetting.do?phone="+phone+"&mac="+mac+"&name=123&id="+id+"&host="+escape(host);
	var _ajaxObj = new AJAX_OBJ(ajax_url,saveSettingHandler);
	_ajaxObj.requestData();
}
function saveSettingHandler(info){
	if(eval("("+info.responseText+")").response.header.rm.toLowerCase()=="success"){
		layerAlert("保存成功");
	}
	else{
		layerAlert("保存失败,请稍后再试...");
	}
}
function menuOnfocus(obj) {
	if(getFocusID=="menu_5"&&obj.indexOf("menu_")>-1 &&　getFocusID!=obj){
		document.getElementById("menu_5_Focus").style.visibility = "hidden";
	}
	else if(obj.indexOf("menu_")==-1&&getFocusID.indexOf("menu_")>-1){
		document.getElementById("menu_5_Focus").style.visibility = "visible";
	}
	else if(obj.indexOf("menu_")>-1&&getFocusID.indexOf("menu_")==-1){
		document.getElementById("menu_5_Focus").style.visibility = "hidden";
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
	document.getElementById("menu_5_Focus").style.visibility = "visible";
}
function menuTitleLostfocus(obj){
}
function btnOnFocus(obj){
	getFocusID=obj;
	document.getElementById("menu_5_Focus").style.visibility = "visible";
}
function btnOnBlur(obj){
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
<div  id="main_div"  >
	<img id="main_img" src="../dzdp/zhuyemian_bg1.png"  border="0" width="1280" height="720" />
</div>
<div id="layer" style="position:absolute;z-index:10; width: 1200px; height: 40px;left: 0px;top: 110px;text-align: center;font-size: 30px;"></div>
<input type="hidden" id="districID" value="" />
<div id="header">
	<div id="menu_module_a"
		style="position: absolute; top: 51px; left: 90px; width: 40px; height: 40px;">
		<a id="menu_module" href="module.jsp" onfocus="menuOnfocus('menu_module')"
			onblur="menuLostfocus('menu_module')"> 
			<img id="menu_module_img"
			src="../dzdp/dot.png" width="40" height="40">
		</a>
	</div>
	<div id="menu_1" style="position:absolute;top:30;left:205px;width:76px;height:45px;">
		<a id="menu_1_a" href="index.jsp" onfocus="menuOnfocus('menu_1')" onblur="menuLostfocus('menu_1')">
			<img id="menu_1_img" src="../dzdp/dot.png" width="76" height="45">
		</a>
	</div>
	<div id="menu_2" style="position:absolute;top:30px;left: 378PX;width:76px;height:45px;">
		<a id="menu_2_a" href="groupby.jsp" onfocus="menuOnfocus('menu_2')" onblur="menuLostfocus('menu_2')">
			<img id="menu_2_img" src="../dzdp/dot.png" width="76" height="45">
		</a>
	</div>
	<div id="menu_3" style="position:absolute;top:30px;left: 556px;width:76px;height:45px;">
		<a id="menu_3_a" href="coupon.jsp" onfocus="menuOnfocus('menu_3')" onblur="menuLostfocus('menu_3')">
			<img id="menu_3_img" src="../dzdp/dot.png" width="76" height="45">
		</a>
	</div>
	<div id="menu_4" style="position:absolute;top:30px;left: 700px;width:76px;height:45px;">
		<a id="menu_4_a" href="search.jsp" onfocus="menuOnfocus('menu_4')" onblur="menuLostfocus('menu_4')">
			<img id="menu_4_img" src="../dzdp/dot.png" width="76" height="45">
		</a>
	</div>
	<div id="menu_5" style="position:absolute;top:30px;left: 890px;width: 76px;height:45px;">
		<a id="menu_5_a" href="setting.jsp" onfocus="menuOnfocus('menu_5')" onblur="menuLostfocus('menu_5')">
			<img id="menu_5_img" src="../dzdp/dot.png" width="76" height="45">
		</a>
	</div>
	<!-- <div id="menu_6" style="position:absolute;top:25px;left:1069px;width:125px;height:60px;">
		<img id="menu_6_img" src="../dzdp/dot.png" width="125" height="60">
	</div> -->
	<div id="menu_module_Focus"
		style="position: absolute; visibility: hidden; top: 41px; left: 70px; width: 92px; height: 88px;">
		<img id="menuFocus_module_img" src="../dzdp/module.png"
			width="92" height="88">
	</div>
	<div id="menu_1_Focus" style="position: absolute; visibility: hidden; top: 0px; left: 173px; width: 154px; height: 142px;">
		<img id="menuFocus_1_img" src="../dzdp/title_recommend1.png"
			width="148" height="142">
	</div>
	<div id="menu_2_Focus" style="position: absolute; visibility: hidden; top: 0px; left: 324px; width: 170px; height: 142px;">
		<img id="menuFocus_2_img" src="../dzdp/title_game1.png" width="166"
			height="142">
	</div>
	<div id="menu_3_Focus"
		style="position: absolute; visibility: hidden; top: 0px; left: 497px; width: 184px; height: 142px;">
		<img id="menuFocus_3_img" src="../dzdp/youhuijuan1.png" width="179"
			height="142">
	</div>
	<div id="menu_4_Focus" style="position: absolute; visibility: hidden; top: 0px; left: 682px; width: 156px; height: 142px;">
		<img id="menuFocus_4_img" src="../dzdp/title_search1.png"
			width="155" height="142">
	</div>
	<div id="menu_5_Focus"
		style="position: absolute; visibility: hidden; top: 0px; left: 841px;  width: 156px; height: 142px;">
		<img id="menuFocus_5_img" src="../dzdp/title_setting1.png"
			width="149" height="142">
	</div>
</div>
<div id="content" style="position:absolute;top:30px;left:0px;width:1280px;height:690px;">
	<div id="userInfo" style="position:absolute; top:140px; left:105px; font-size:22px; color:ff9f2f; width:990px;">
		<!-- <span style="position:absolute; top:3px;">手机号码:</span>
		<span style="position:absolute; left:125px;">
			<input type="text" id="telNo" onfocus="btnOnFocus('telNo')" onblur="btnOnBlur('telNo')" style=" color:#ffffff;width:150px;border: 1px solid #ff9f2d;background-color: transparent;padding-left: 3px;">
		</span>
		<span style="font-size: 12px;position: absolute;top: 10px;left: 280px;">按返回键删除</span> -->
		<span style="position:absolute; left:145px;">我的商圈:</span>
		<span style="position:absolute; left:265px; top:28px;"><img alt="" src="../dzdp/line2.png" style="height: 1px;" width="220"></span>
		<span id="distric" style="position:absolute; left:275px; color:#ffffff;"></span>
		<span style="position:absolute; left:530px;">
			<a id="btn_save" href="#" onclick="saveSetting('btn_save');return false;" onfocus="btnOnFocus('btn_save');document.getElementById('btn_save_img').src='../dzdp/button_1_focus.png';" onblur="btnOnBlur();document.getElementById('btn_save_img').src='../dzdp/button_1.png';">
				<img id="btn_save_img"alt="" src="../dzdp/button_1.png" width="120" height="30" />
			</a>
		</span>
	</div>
	<div id="ProvinceList" style="position:absolute; top:185px; left:253px; width:150px;">
		<span style="position:absolute; top:0; left:0; font-size:23px; color:ff9f2f;">城市:</span>
		<div style="position:absolute; top:14px; left:0;">
			<div id="ulProvince">
			</div>
		</div>
	</div>
	<div id="cityList" style="position:absolute; top:185px; left:453px; width:180px;">
		<span style="position:absolute; top:0; left:0; font-size:23px; color:ff9f2f;">区(县):</span>
		<div style="position:absolute; top:14px; left:0;">
			<div id="ulCity">
			</div>
		</div>
	</div>
	<div id="cityList1" style="position:absolute; top:185px; left:610px; width:180px;">
		<div style="position:absolute; top:14px; left:0;">
			<div id="ulCity1">
				
			</div>
		</div>
	</div>
	<div id="Districtist" style="position:absolute; top:185px; left:780px; width:150px;">
		<span style="position:absolute; top:0; left:0; font-size:23px; color:ff9f2f;">选择商圈</span>
		<div style="position:absolute; top:14px; left:0;">
			<div id="ulDistric">
			</div>
		</div>
	</div>
	<div id="Districtist1" style="position:absolute; top:185px; left:1000px; width:150px;">
		<div style="position:absolute; top:14px; left:0;">
			<div id="ulDistric1">
			</div>
		</div>
	</div>
</div>
</epg:body>
</epg:html>
