<%@page contentType="text/html; charset=gbk"%>
<%@taglib uri="http://chances.com.cn/jsp/epg" prefix="epg"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% 
	String path = request.getContextPath(); 
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
	request.setAttribute("basePath", basePath);

	//�Ƿ��¼Bi
	String isbi = request.getParameter("isbi");
	String from = request.getParameter("from");
	if(isbi==null){
		isbi="true";
	}
	if(from==null){
		from="";
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
function layerAlert(msg)
{
	layer.innerHTML=msg;
	document.getElementById("layer").style.visibility = "visible";
    setTimeout('document.getElementById("layer").style.visibility = "hidden"',2000);
}

//������
var moreObj;
var isShow = false;
function showBigAlertTip(obj,content){
	isShow = true;
	moreObj = obj;
	document.getElementById("bigMoreAlert_div").style.display = "block";
	colseA();
	document.getElementById("closeBigMoreAlert_a").focus();
	setTimeout(shouwArrow,500);
}
function shouwArrow(){
	var aheight = document.getElementById("moreContent").scrollHeight;
	if (aheight > 414) {
		document.getElementById("arrowDown_div").style.visibility = "visible";
		document.getElementById("scrollDown_a").style.display = "block";
	}
}
function closeAlertTip(){
	isShow = false;
	openA();
	document.getElementById("moreContent").style.top ="0";
	document.getElementById("arrowUp_div").style.visibility = "hidden";
	document.getElementById("arrowDown_div").style.visibility = "hidden";
	document.getElementById("bigMoreAlert_div").style.display = "none";
}

function colseA(){
	var arrayOfDocFonts = document.getElementsByTagName("a");
	for(var i = 0;i<arrayOfDocFonts.length;i++){
		var aId = arrayOfDocFonts[i].id;
		if(!aId.startWith("closeBigMoreAlert")){
			document.getElementById(aId).style.display = "none";
		}
	}
}
function openA(){
	var arrayOfDocFonts = document.getElementsByTagName("a");
	for(var i = 0;i<arrayOfDocFonts.length;i++){
		var aId = arrayOfDocFonts[i].id;
		document.getElementById(aId).style.display = "block";
	}
}
function scrollUp(){
	var mTop=document.getElementById("moreContent").style.top;
	mTop=mTop.replace("px","");
	if(mTop<0){
		document.getElementById("moreContent").style.top=(mTop-0+390)+"px";	
	}
}
function scrollDown(){
	var mTop=document.getElementById("moreContent").style.top;
	mTop=mTop.replace("px","");
	if((390+0-mTop)<document.getElementById("moreContent").scrollHeight){
		document.getElementById("moreContent").style.top=(mTop-390)+"px";
		document.getElementById("arrowUp_div").style.visibility = "visible";
		document.getElementById("scrollUp_a").style.display = "block";
	}
}
function eventHandler(eventObj) {
	//�����ipanel
	if(typeof(iPanel)!='undefined'){
		getFocusIDLongJing=getFocusID;
	}
	if(getFocusIDLongJing==""){
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
		//�����ipanel
		if(typeof(iPanel)!='undefined'){
			if(getFocusID.indexOf('menu_')>-1){
				var menuIndex=getFocusID.split('_')[1];
				document.getElementById("menu_"+(menuIndex-1)+"_a").focus();
				return 0;
			}
		}
		else{
			if(getFocusIDLongJing.indexOf('menu_')>-1){
				var menuIndex=getFocusIDLongJing.split('_')[1];
				document.getElementById("menu_"+(menuIndex-1)+"_a").focus();
				getFocusIDLongJing=getFocusID;
			}
		}
		break;
	case "EIS_IRKEY_RIGHT":
		//�����ipanel
		if(typeof(iPanel)!='undefined'){
			if(getFocusID.indexOf('menu_')>-1){
				var menuIndex=getFocusID.split('_')[1];
				document.getElementById("menu_"+(menuIndex-0+1)+"_a").focus();
				return 0;
			}
		}
		else{
			if(getFocusIDLongJing.indexOf('menu_')>-1){
				var menuIndex=getFocusIDLongJing.split('_')[1];
				document.getElementById("menu_"+(menuIndex-0+1)+"_a").focus();
				getFocusIDLongJing=getFocusID;
			}
		}
		break;
	case "EIS_IRKEY_BACK":
		if(from==""){
			window.location.href="atHome_groupby.jsp";
		}
		else{
			window.location.href="module.jsp";
		}
		return 0;
		break;
	case "EIS_IRKEY_EXIT":
		if(from==""){
			window.location.href="atHome_groupby.jsp";
		}
		else{
			window.location.href="module.jsp";
		}
		return 0;
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
		font-family: ����;
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
//�۽��ؼ�ID
var getFocusID="menu_1_a";
var getFocusIDLongJing="";
var Path = "${basePath}";
var pageId="53";
var userInfo;
//�Ƿ���ҳ�����״̬
var isInit=true;
//ҳ���ʼ��ѡ����ȦID
var staticFocus="";
var from="${from}";

function init(){
	//document.getElementById("menu_5_a").focus();
	//�����û���Ϣ
	try{
		try{
			mac=hardware.STB.serialNumber;
		}
		catch(err){
			
		}
		var urlStr=escape(interfaceurl+getMacInfo+"?mac=deciveId");
		var ajax_url = Path+"clientUrlHandler.do?url="+urlStr+"&pageId="+pageId+"&biType="+biPageType;
		var _ajaxObj = new AJAX_OBJ(ajax_url,handlGetInfo);
		_ajaxObj.requestData();
	}
	catch(pe){
		
	}
}

function handlGetInfo(result){
	try{
		userInfo=eval("("+result.responseText+")").response.body.dataList[0];
		//��ȡ������Ϣ
		var urlStr=escape(interfaceurl+getCity);
		var ajax_url = Path+"clientUrlHandler.do?url="+urlStr+"&biType=4";
		var _ajaxObj = new AJAX_OBJ(ajax_url,handlGetCitys);
		_ajaxObj.requestData();
	}
	catch(e){
		
	}
}
//��ѯ����
function handlGetCitys(result){
	var provinces=eval("("+result.responseText+")").response.body.dataList;
	var provinceInner="";
	var focusProvinceIndex="";
	var focusProvinceId="";
	var focusProvinceName="";
	if(!userInfo){
		isInit=false;
		if(i==0){
			isp="iasp;";
		}
		setInput(provinces[0].name,provinces[0].id,12,0);
	}
	
	for(var i=0;i<provinces.length;i++){
		var xline=Math.floor(i/7);
		var province=provinces[i];
		var isp="display:none;";
		if(userInfo&&userInfo.ppid!="" && userInfo.ppid==province.id){
			isp="iasp;";
			focusProvinceIndex=i;
			focusProvinceId=province.id;
			focusProvinceName=province.name;
		}
	
		provinceInner+=
			'<div style="position: absolute;width:115px;height:43px; top:'+(13+53*xline)+'px; left:'+((i%7)*160)+'px;">'+
				'<img alt="" src="../dzdp/city.png" style="height:40px; width:115px;position:absolute; top:0px; left:0;">'+
				'<a id="province_a'+i+'" href="#" style="position: absolute;width:115px;height:40px; top:0px; left:0px;" onblur="btnOnBlurP(\'province_a'+i+'\');" onfocus="btnOnFocusP(\'province_a'+i+'\');" onclick="queryCityByName(\''+province.name+'\',\''+province.id+'\');setInput(\''+province.name+'\',\''+province.id+'\',10,0);return false;">'+
					'<div id="province_a'+i+'_div" style="'+isp+'background-color:#ff6000;overflow: hidden;height: 21px; position: absolute;color:#000000;left: 0;top:10px; width: 115px; font-size:20px; text-align:center;"></div>'+
					'<div style="overflow: hidden;height: 21px; position: absolute;color:#000000;left: 0;top:10px; width: 115px; font-size:20px; text-align:center;">'+province.name+'</div>'+
				'</a>'+
			'</div>';
	}
	if((focusProvinceId+"")!=""){
		queryCityByName(focusProvinceName,focusProvinceId);
		if(userInfo.pid==""){
			setInput(focusProvinceName,focusProvinceId,10,0);
			provinceInner=provinceInner.replace("iasp","");
			isInit=false;
			staticFocus="province_a"+focusProvinceIndex+"_div";
		}
		else{
			//ȥ��ѡ��Ч��
			provinceInner=provinceInner.replace("iasp","display:none");
		}
	}
	else{
		if(provinces.length>0){
			queryCityByName(provinces[0].name,provinces[0].id);
		}
	}
	document.getElementById("ulProvince").innerHTML=provinceInner;
	document.getElementById("ulCity").innerHTML="";
	document.getElementById("ulDistric").innerHTML="";
}

//��ѯ����
function queryCityByName(name,id){
	document.getElementById("distric").innerHTML=name;
	var urlStr=encodeURI(interfaceurl+getDistrictByCity+"?id="+id);
	var ajax_url = Path+"clientUrlHandler.do?url="+urlStr+"&biType=4";
	var _ajaxObj = new AJAX_OBJ(ajax_url,citysHandler);
	_ajaxObj.requestData();
	function citysHandler(citysStr){
		var citys=eval("("+citysStr.responseText+")").response.body.dataList;
		var cityInner="";
		var focusCityIndex="";
		var focusCityId="";
		var focusCityName="";
		cityInner+=
			'<div style="position: absolute;width:115px;height:43px; top:13px; left:0px;">'+
				'<img alt="" src="../dzdp/city.png" style="height:40px; width:115px;position:absolute; top:0px; left:0;">'+
				'<a href="#" id="city_a" style="position: absolute;width:115px;height:40px; top:0px; left:0px;" onblur="btnOnBlurP(\'city_a\');" onfocus="btnOnFocusP(\'city_a\');" onclick="setInput(\'ȫ������\',\''+id+'\',11,1);;return false;">'+
					'<div id="city_a_div" style="display:none;background-color:#ff6000;overflow: hidden;height: 21px;  color:#000000;position: absolute;left: 0;top:10px; width: 115px; font-size:20px; text-align:center;"></div>'+
					'<div style="overflow: hidden;height: 21px;  color:#000000;position: absolute;left: 0;top:10px; width: 115px; font-size:20px; text-align:center;">ȫ������</div>'+
				'</a>'+
			'</div>';
		for(var i=0;i<citys.length;i++){
			var xline=Math.floor(i/7);
			var l=(i+1)%7*160;
			if(xline==0){
				xline=Math.floor(i/6);
				l=((i+1)%7*160);
			}
			else{
				xline=Math.floor((i-6)/7)+1;
			}
			var city=citys[i];
			var isp="display:none;";
			if(userInfo&&userInfo.pid!="" && userInfo.pid==city.id && isInit){
				isp="iasp;";
				focusCityIndex=i;
				focusCityId=city.id;
				focusCityName=city.name;
			}
			cityInner+=
				'<div style="position: absolute;width:115px;height:43px; top:'+(13+53*xline)+'px; left:'+l+'px;">'+
					'<img alt="" src="../dzdp/city.png" style="height:40px; width:115px;position:absolute; top:0px; left:0;">'+
					'<a href="#" id="city_a'+i+'" style="position: absolute;width:115px;height:40px; top:0px; left:0px;" onblur="btnOnBlurP(\'city_a'+i+'\');" onfocus="btnOnFocusP(\'city_a'+i+'\');" onclick="queryDistrictByCity(\''+city.name+'\',\''+city.id+'\',\''+city.pid+'\');setInput(\''+city.name+'\',\''+city.id+'\',11,1);return false;">'+
						'<div id="city_a'+i+'_div" style="'+isp+'background-color:#ff6000;overflow: hidden;height: 21px;  color:#000000;position: absolute;left: 0;top:10px; width: 115px; font-size:20px; text-align:center;"></div>'+
						'<div style="overflow: hidden;height: 21px;  color:#000000;position: absolute;left: 0;top:10px; width: 115px; font-size:20px; text-align:center;">'+city.name+'</div>'+
					'</a>'+
				'</div>';
		}
		if(focusCityId!=""){
			queryDistrictByCity(focusCityName,focusCityId);
			//�ж��Ƿ�����Ȧ
			if(userInfo.id==""){
				setInput(focusCityName,focusCityId,11,1);
				cityInner=cityInner.replace("iasp","");
				staticFocus="city_a"+focusCityIndex+"_div";
			}
			else{
				//ȥ��ѡ��Ч��
				cityInner=cityInner.replace("iasp","display:none");
			}
		}
		else{
			isInit=false;
		}
		document.getElementById("ulCity").innerHTML=cityInner;
		document.getElementById("ulDistric").innerHTML="";
	}
}
//��ѯ��Ȧ
function queryDistrictByCity(name,id,pid){
	var pname=document.getElementById("distric").innerHTML.split('-')[0];
	document.getElementById("distric").innerHTML=pname+" - "+name;
	var urlStr=encodeURI(interfaceurl+getRegionByDistrict+"?id="+id+"&pid="+pid);
	var ajax_url = Path+"clientUrlHandler.do?url="+urlStr+"&biType=4";
	var _ajaxObj = new AJAX_OBJ(ajax_url,districtsHandler);
	_ajaxObj.requestData();
	function districtsHandler(districtsStr){
		var districts=eval("("+districtsStr.responseText+")").response.body.dataList;
		var districtInner="";
		var focusDistrictIndex="";
		var focusDistrictId="";
		var focusDistrictName="";
		districtInner+=
			'<div style="position: absolute;width:150px;height:40px; top:13px; left:0px;">'+
				'<img alt="" src="../dzdp/Distric.png" style="height:40px; width:150px;position:absolute; top:0px; left:0;">'+
				'<a href="#" id="district_a" style="position: absolute;width:150px;height:40px; top:0px; left:0px;" onblur="btnOnBlurD(\'district_a\');" onfocus="btnOnFocusD(\'district_a\');" onclick="setInput(\'ȫ����Ȧ\',\''+id+'\',12,2);return false;">'+
					'<div id="district_a_div" style="display:none;background-color:#55b100;overflow: hidden;height: 21px; color:#000000;position: absolute;left: 0;top:10px; width: 150px; font-size:20px; text-align:center;"></div>'+
					'<div style="overflow: hidden;height: 21px; color:#000000;position: absolute;left: 0;top:10px; width: 150px; font-size:20px; text-align:center;">ȫ����Ȧ</div>'+
				'</a>'+
			'</div>';
		for(var i=0;i<districts.length;i++){
			var xline=Math.floor(i/7);
			var l=(i+1)%7*160;
			if(xline==0){
				xline=Math.floor(i/6);
				l=((i+1)%7*160);
			}
			else{
				xline=Math.floor((i-6)/7)+1;
			}
			var district=districts[i];
			var isp="display:none;";
			if(userInfo&&userInfo.id!="" && userInfo.id==district.id && isInit){
				isp="";
				focusDistrictIndex=i;
				focusDistrictId=district.id;
				focusDistrictName=district.name;
			}
			districtInner+=
				'<div style="position: absolute;width:150px;height:40px; top:'+(13+53*xline)+'px; left:'+l+'px;">'+
					'<img alt="" src="../dzdp/Distric.png" style="height:40px; width:150px;position:absolute; top:0px; left:0;">'+
					'<a href="#" id="district_a'+i+'" style="position: absolute;width:150px;height:40px; top:0px; left:0px;" onblur="btnOnBlurD(\'district_a'+i+'\');" onfocus="btnOnFocusD(\'district_a'+i+'\');" onclick="setInput(\''+district.name+'\',\''+district.id+'\',12,2);return false;">'+
						'<div id="district_a'+i+'_div" style="'+isp+'background-color:#55b100;overflow: hidden;height: 21px; color:#000000;position: absolute;left: 0;top:10px; width: 150px; font-size:20px; text-align:center;"></div>'+
						'<div style="overflow: hidden;height: 21px; color:#000000;position: absolute;left: 0;top:10px; width: 150px; font-size:20px; text-align:center;">'+district.name+'</div>'+
					'</a>'+
				'</div>';
		}
		document.getElementById("ulDistric").innerHTML=districtInner;
		if((focusDistrictId+"")!=""){
			setTimeout(function(){
				//document.getElementById("district_a"+focusDistrictId).click();
				setInput(focusDistrictName,focusDistrictId,12,2);
				isInit=false;
				staticFocus="district_a"+focusDistrictIndex+"_div";
			},100);
		}
		else{
			isInit=false;
		}
	}
}
//����ѡ�����ƺ�ID
function setInput(name,id,funcId,funcType){
	//funcType 0:����,1:����,2:��Ȧ
	if(funcType=="2"){
		var pname=document.getElementById("distric").innerHTML.split('-')[0];
		var cname=document.getElementById("distric").innerHTML.split('-')[1];
		document.getElementById("distric").innerHTML=pname+" - "+cname+" - "+name;
		document.getElementById("menu_module").focus();
	}
	document.getElementById("districID").value=id;
	if(!isInit){
		saveSetting(funcId);
	}
}
//����������Ϣ
function saveSetting(funcId){
	var id=document.getElementById("districID").value;
	var name=document.getElementById("distric").innerHTML;
	var phone="123";
	//var phone=document.getElementById("telNo").value;
	//if(!isPhone(phone)){
	//	layerAlert("��������ȷ���ֻ�����");
	//	return;
	//}
	var mac="deciveId";
	var host=interfaceurl;
	//var ajax_url = Path+"saveSetting.do?phone="+phone+"&mac="+mac+"&name="+encodeURI(name)+"&id="+id+"&host="+escape(host);
	var ajax_url = Path+"saveSetting.do?phone="+phone+"&mac="+mac+"&name=123&id="+id+"&host="+escape(host);
	ajax_url+="&pageId="+pageId+"&biType="+biFuncType+"&funcId="+funcId+"&funcContent="+id;
	var _ajaxObj = new AJAX_OBJ(ajax_url,saveSettingHandler);
	_ajaxObj.requestData();
}
function saveSettingHandler(info){
	if(eval("("+info.responseText+")").response.header.rm.toLowerCase()=="success"){
		//layerAlert("����ɹ�");
		//window.location.href="atHome_groupby.jsp";
	}
	else{
		layerAlert("�趨ʧ��,���Ժ�����...");
	}
}
function menuOnfocus(obj) {
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
}
function btnOnBlur(obj){
}
function btnOnFocusP(obj){
	try{
		document.getElementById(staticFocus).style.display="none";
	}
	catch(e){
		
	}
	getFocusID=obj;
	document.getElementById(obj+"_div").style.display="block";
}
function btnOnBlurP(obj){
	document.getElementById(obj+"_div").style.display="none";
}
function btnOnFocusD(obj){
	try{
		document.getElementById(staticFocus).style.display="none";
	}
	catch(e){
		
	}
	getFocusID=obj;
	document.getElementById(obj+"_div").style.display="block";
}
function btnOnBlurD(obj){
	document.getElementById(obj+"_div").style.display="none";
}

function disclaimer(){
	showBigAlertTip('twodimensionalcodedescribes',"<img alt=''  src='../dzdp/QRcode.png'/>"); return false;
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
<!-- ����ͼƬ�Լ�ͷ��ͼƬ -->
<div  id="main_div"  >
	<img id="main_img" src="../dzdp/atHomeBG.png"  border="0" width="1280" height="720" />
</div>
<div id="layer" style="position:absolute;z-index:10; width: 1200px; height: 40px;left: 0px;top: 110px;text-align: center;font-size: 30px;"></div>
<input type="hidden" id="districID" value="" />
<div id="header">
	<div id="menu_module_a" style="position: absolute; top: 86px; left: 93px; width: 60px; height: 59px;">
		<a id="menu_module" href="atHome_groupby.jsp" onfocus="menuOnfocus('menu_back')" onblur="menuLostfocus('menu_back')"> 
			<img id="menu_module_img" src="../dzdp/dot.png" width="30" height="30">
		</a>
	</div>
	<div id="menu_back_Focus" style="position: absolute; /* visibility: hidden; */ top: 42px; left: 59px; width: 100px; height: 87px;">
		<img id="menuFocus_back_img" src="../dzdp/btn_back_focus.png" width="100" height="87">
	</div>
	<div style="position: absolute; width: 130px; top:50px; left: 143px; height: 59px; font-size:32px;">
		����
	</div>
	<div style="position: absolute; width: 130px; top: 90px; left: 143px; height: 59px; font-size:32px;">
		����
	</div>
	<div id="userInfo" style="position:absolute; top:65px; left: 160px; font-size:32px; color:ff9f2f; width:990px;">
		<span style="position:absolute; left:60px;">�Ҽ�λ��:</span>
		<span style="position:absolute; left: 200px; top: 35px;"><img alt="" src="../dzdp/line2.png" style="height: 1px;" width="530"></span>
		<span id="distric" style="position:absolute; left: 215px; color:#ffffff; width:530px"></span>
	</div>
	<div id="disclaimer" style="position:absolute; top:65px; left: 900px; font-size:32px; color:ff9f2f; width: 200px;">
		<a id="menu_disclaimer" href="javascript:disclaimer()" onfocus="menuOnfocus('disclaimer')" onblur="menuLostfocus('disclaimer')"> 
			<img id="menu_disclaimer_img" src="../dzdp/dot.png" width="30" height="30">
		</a>
	</div>
	<div id="disclaimer_Focus" style="visibility: hidden; position: absolute; top: 46px; left: 894px; width: 100px; height: 87px;">
		<img id="menuFocus_back_img" src="../dzdp/disclaimer.png" width="140" height="64">
	</div>
</div>
<div id="content" style="position:absolute;top:60px;left:0px;width:1280px;height:660px;">
	<div id="ProvinceList" style="position:absolute; top:100px; left:100px; width:150px;">
		<span style="position:absolute; top:0px; left:0; font-size:23px; color:ff9f2f;">����:</span>
		<div style="position:absolute; top:14px; left:0;">
			<div id="ulProvince">
			</div>
		</div>
	</div>
	<div id="cityList" style="position:absolute; top:230px; left:100px; width:180px;">
		<span style="position:absolute; top:0; left:0; font-size:23px; color:ff9f2f;">��(��):</span>
		<div style="position:absolute; top:14px; left:0;">
			<div id="ulCity">
			</div>
		</div>
	</div>
	<div id="Districtist" style="position:absolute; top:400px; left:100px; width:160px;">
		<span style="position:absolute; top:0; left:0; font-size:23px; color:ff9f2f;">ѡ����Ȧ</span>
		<div style="position:absolute; top:14px; left:0;">
			<div id="ulDistric">
			</div>
		</div>
	</div>
</div>
	
<div id="bigMoreAlert_div" style="position:absolute;left:0px; top:0px; width:1280px; height:720px;display:none;overflow:hidden;">
	<epg:img id="alertClose" src="/dzdp/moreAlert.png" width="1280" height="720" />
	<div id="closeBigMoreAlert_div" align="left" style="position:absolute; left:950px;top:85px;width:82px;height:44px;">
	 	<a id="closeBigMoreAlert_a" href="#" onfocus="document.getElementById('closeBigMoreAlert_img').src='../dzdp/alertClose.png';" onblur="document.getElementById('closeBigMoreAlert_img').src='../dzdp/dot.gif';" onclick="closeAlertTip();return false;" style="width:82px;height:44px;">
			<img id="closeBigMoreAlert_img" src="../dzdp/dot.gif" border="0" width="82" height="44">
		</a>
	</div>
	<div id="moreTitle_div" align="left" style="position:absolute; left:238px;top:95px;width:136px;height:34px;">
 		��������
	</div>
	<div id="arrowUp_div" style="position:absolute;visibility:hidden;left:578px; top:140px; width:60px; height:29px; display:none;">
		<epg:img id="scrollUp" onfocus="document.getElementById('scrollUp_img').src='../dzdp/arrowUp_focus.png';" onblur="document.getElementById('scrollUp_img').src='../dzdp/arrowUp.png';" src="/dzdp/arrowUp.png" onclick="scrollUp();return false;" left="0" top="0" width="60" height="29"/>
	</div>
	<div style="position:absolute;left:220px; top:150px; width:843px; height:478px;overflow:hidden;">
		<div id="moreContent" style="position:absolute;left: 15px;top:0px;width: 820px;">
			<span id="moreContent_span" style="color:#000000;font-size:25; font-family:����;height:0px; text-align:center;">
				�� �� �� ��<br>
			    1.������·���Ǳ���˾���Ʒ�Χ���Ӳ�����ϻ��������ɿ�����������ͣ��������ͣ�����ڼ���ɵ�һ�в�������ʧ������վ�����κ����Ρ�<br>
			    2.����վʹ������ΪΥ���������Ĺ涨�������л����񹲺͹����ɵģ�һ�к���Լ����𣬱���վ���е��κ����Ρ�<br>
			    3.������δ�漰������μ������йط��ɷ��棬������������ҷ��ɷ����ͻʱ���Թ��ҷ��ɷ���Ϊ׼��<br>
			    4.����վ���������ַ����ĸ�ý�����˵�֪ʶ��Ȩ�������Ż������֮������վ����������ɾ����
		    </span>
    	</div>
	</div>
	<div id="arrowDown_div"  style="position:absolute;visibility:hidden;left:578px; top:590px; width:60px; height:29px; display:none;">
		<epg:img id="scrollDown" onfocus="document.getElementById('scrollDown_img').src='../dzdp/arrowDown_focus.png';" onblur="document.getElementById('scrollDown_img').src='../dzdp/arrowDown.png';" src="/dzdp/arrowDown.png" onclick="scrollDown();return false;" left="0" top="0" width="60" height="29"/>
	</div>
</div>
</epg:body>
</epg:html>
