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
function layerAlert(msg)
{
	layer.innerHTML=msg;
	document.getElementById("layer").style.visibility = "visible";
    setTimeout('document.getElementById("layer").style.visibility = "hidden"',2000);
}
</script>
<style>
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
					} else {
						document.getElementById("recommand_" + (idP - 4)).focus();
						return 0;
					}
				}
			}
		}
		else{
			if (getFocusIDLongJing.indexOf('_')) {
				var idF = getFocusIDLongJing.split('_')[0];
				var idP = getFocusIDLongJing.split('_')[1];
				if (idF == "recommand") {
					if (idP < 4) {
					} else {
						//document.getElementById("recommand_" + (idP - 4)).focus();
						getFocusIDLongJing=getFocusID;
					}
				}
			}
		}
		break;
	case "EIS_IRKEY_DOWN":
		break;
	case "EIS_IRKEY_SELECT":
		break;
	case "EIS_IRKEY_LEFT":
		//如果是ipanel
		if(typeof(iPanel)!='undefined'){
			if (getFocusID=="recommand_0"||getFocusID=="recommand_4") {
				window.location.href="search.jsp";
				return 0;
			}
			if (getFocusID.indexOf('_')) {
				var idF = getFocusID.split('_')[0];
				var idP = getFocusID.split('_')[1];
				if (idF == "recommand") {
					if (idP > 0 && idP != 4) {
						document.getElementById("recommand_" + (idP - 1)).focus();
					}
					else if(idP == 0 || idP == 4){
						priPager();
					}
	
					return 0;
				}
			}
		}
		else{
			if (getFocusID=="recommand_0"||getFocusID=="recommand_4") {
				window.location.href="search.jsp";
				return 0;
			}
			if (getFocusID.indexOf('_')) {
				var idF = getFocusID.split('_')[0];
				var idP = getFocusID.split('_')[1];
				if (idF == "recommand") {
					if (idP > 0 && idP != 4) {
						//document.getElementById("recommand_" + (idP - 1)).focus();
					}
					else if(idP == 0 || idP == 4){
						priPager();
					}
	
					getFocusIDLongJing=getFocusID;
				}
			}
		}
		break;
	case "EIS_IRKEY_RIGHT":
		//如果是ipanel
		if(typeof(iPanel)!='undefined'){
			if (getFocusID.indexOf('_')) {
				var idF = getFocusID.split('_')[0];
				var idP = getFocusID.split('_')[1];
				if (idF == "recommand") {
					if (idP < (currItemsCount-1) && idP != 3) {
						document.getElementById("recommand_" + (idP - 0 + 1)).focus();
					}
					else if(idP == 3 || idP == (currItemsCount-1)){
						nextPager();
					}
	
					return 0;
				}
			}
		}
		else{
			if (getFocusIDLongJing.indexOf('_')) {
				var idF = getFocusIDLongJing.split('_')[0];
				var idP = getFocusIDLongJing.split('_')[1];
				if (idF == "recommand") {
					if (idP < (currItemsCount-1) && idP != 3) {
						//document.getElementById("recommand_" + (idP - 0 + 1)).focus();
					}
					else if(idP == 3 || idP == (currItemsCount-1)){
						nextPager();
					}
	
					getFocusIDLongJing=getFocusID;
				}
			}
		}
		break;
	case "EIS_IRKEY_BACK":
		return 0;
		break;
	case "EIS_IRKEY_EXIT":
		window.location.href="module.jsp";
		return 0;
		break;
	case "EIS_IRKEY_PAGE_UP":
		priPager();
		break;
	case "EIS_IRKEY_PAGE_DOWN":
		nextPager();
		break;
	default:
		return 1;
		break;
	}
}
//聚焦控件ID
var getFocusID = "menu_5_a";
var getFocusIDLongJing="";
var Path = "${basePath}";

//当前页码
var pageIndex = 0;
var pageSize = 8;
var itemsCount = 0;
var currItemsCount=0;
var pagesCount = 1;
//bi参数
var pageId="6";
var isbi=true;
function init() {
	try{
		mac=hardware.STB.serialNumber;
	}
	catch(err){
		
	}
	document.getElementById("menu_5_a").focus();
	getPagers(0);
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
function pagerOnfocus(obj,obj1) {
	getFocusID = obj;
	document.getElementById(obj + "_Focus").style.display = "block";
	document.getElementById(obj1 + "_Focus").style.display = "none";
}

function pagerLostfocus(obj) {
	document.getElementById(obj + "_Focus").style.display = "none";
}


//上一页
function priPager() {
	if (pageIndex == 0) {
		return;
	}
	pageIndex--;
	getPagers(pageIndex);
}
//下一页
function nextPager() {
	if (pageIndex == pagesCount - 1) {
		pageIndex=-1;
	}
	pageIndex++;
	getPagers(pageIndex);
}
//调用分页接口
function getPagers(pageNo) {
	var urlStr=escape(interfaceurl+getFavorite+"?mac=deciveId&countF="
			+(pageIndex*pageSize)+"&countE="+pageSize);
	var ajax_url = Path + "clientUrlHandler.do?url=" + urlStr;
	if(isbi){
		ajax_url+="&pageId="+pageId+"&biType="+biPageType;
		isbi=false;
	}
	else{
		ajax_url+="&biType=4";
	}
	var _ajaxObj = new AJAX_OBJ(ajax_url, clientUrlHandler);
	_ajaxObj.requestData();
}
//显示分页数据
function clientUrlHandler(result) {
	var items = eval("(" + result.responseText + ")").response.body.dataList;
	itemsCount=eval("(" + result.responseText + ")").response.header.count;
	pagesCount = Math.ceil(itemsCount / pageSize);
	var xLine = 0;//行索引
	var itemsInner = "";
	currItemsCount=items.length;
	//该页ID集合
	var itemIDS="[";
	for (var i = 0; i < items.length; i++) {
		itemIDS+="{'id':'"+items[i].dealId+"','type':'"+items[i].type+"'},";
	}
	if(itemIDS!="["){
		itemIDS=itemIDS.substring(0,itemIDS.length-1);
	}
	itemIDS+="]";
	itemIDS=escape(itemIDS);
	for (var i = 0; i < items.length; i++) {
		xLine = Math.floor(i / 4);
		var item = items[i];
		var itemname = item.name.replace('?','');
		itemname = subString(itemname, 23,true);
		//是否下架
		var isHidden="";
		var href="#";
		if(item.date_over_mark=="1"){
			isHidden="visibility: hidden;";
			href='itemDetail.jsp?dealId='
				+ item.dealId
				+ '&pageIndex='+pageIndex+'&pageCount='+pagesCount+'&pageSize='
				+pageSize+'&itemIDS='+itemIDS+'&type=&faviousId='+item.id+'&isFavious=1'
				+'&biType='+biItemType+'&pageId='+pageId;
		}
		//优惠券
		if((item.type+"")=="1"){
			itemsInner += '<div id="recommand'
				+ i
				+ '_div" style="width:262px; height:235px; top: '
				+ (160 + xLine * 252)
				+ 'px; left:'
				+ (87 + i % 4 * 280)
				+ 'px; position:absolute; background-color:#ffffff;">'
				+ '<a id="recommand_'
				+ i
				+ '" href="'+href+'" onfocus="menuOnfocus(\'recommand_'
				+ i
				+ '\')" onblur="menuLostfocus(\'recommand_'
				+ i
				+ '\')" style="color:#000000;">'
				+ '<img alt="" src="../dzdp/dot.gif" width="262" height="145" />'
				+ '</a>' 
				+ '<img alt="" src="'+item.s_image_url+'" width="262" height="145" style="position: absolute;top: 0px;left: 0px;" onerror="javascript:this.src=\'../dzdp/logo.png\';" />'
				+ '<div class="pro_content">'
				+ '<div style="height:1px;position:absolute; top:150px; left:8px; width:100px; background-color: ff8b02;"></div>'
				+ '<div id="iname_'+i+'" align="left" style="position:absolute;left:15px;top:155px;width:265px;height:26px;">'
				+ itemname
				+ '</div>'
				+ '<div>'
					+ '<span style="font-family: -webkit-body;font-size: 16px;">'
						+ '<img alt="" src="'+item.from_type_img_url+'" style="position:absolute;left: 15px;top:184px" width="20" height="20">'
						+ '<span style="position:absolute; left: 38px;top:186px;font-size: 14px;">'+item.from_type+'提供数据</span>'
					+ '</span>'
				+ '</div>'
				+ '</div>'
				+ '<div style="position:absolute; top:210px; left:15px; text-align:left;">有效期:'
				+ item.r_end 
				+ '</div>' 
				+ '<div style="position:absolute; top:210px; left:15px;">'
				+ '<span style="color: #6299df;position: absolute; width: 240px; left: 0px; top: 0px; text-align: right;">'
				+ item.hits + '人购买</span> ' 
				+ '</div>' 
				+ '</div>';
			
		}
		else{
			itemsInner += '<div id="recommand'
				+ i
				+ '_div" style="width:262px; height:235px; top: '
				+ (160 + xLine * 252)
				+ 'px; left:'
				+ (87 + i % 4 * 280)
				+ 'px; position:absolute; background-color:#ffffff;">'
				+ '<a id="recommand_'
				+ i
				+ '" href="'+href+'" onfocus="menuOnfocus(\'recommand_'
				+ i
				+ '\')" onblur="menuLostfocus(\'recommand_'
				+ i
				+ '\')" style="color:#000000;">'
				+ '<img alt="" src="../dzdp/dot.gif" width="262" height="145" />' 
				+ '</a>'
				+ '<img alt="" src="'+item.s_image_url+'" width="262" height="145" style="position: absolute;top: 0px;left: 0px;" onerror="javascript:this.src=\'../dzdp/logo.png\';" />' 
				+ '<div class="pro_content">'
				+ '<div style="height:1px;position:absolute; top:150px; left:8px; width:100px; background-color: ff8b02;"></div>'
				+ '<span id="iname_'+i+'" align="left" style="position:absolute;left:15px;top:155px;width:265px;height:26px;">'
				+ itemname
				+ '</span>'
				+ '<div>'
				+ '<span style="font-family: -webkit-body;">'
				+ '<img alt="" src="../dzdp/dazhe_bg.png" width="45" height="20" style="position:absolute;left:210px; top:183px">'
				+ '<span style=" font-size: 13px; position:absolute; left:214px; top: 188px;z-index: 999;">'
				+ (item.discount * 1.0).toFixed(1)
				+ '折</span>'
				+ '</span>'
				+ '<span style="font-family: -webkit-body;font-size: 16px;">'
				+ '<img alt="" src="'+item.from_type_img_url+'" style="position:absolute;left: 15px;top:183px" width="20" height="20">'
				+ '<span style="position:absolute; left: 38px;top:187px;font-size: 14px;">'+item.from_type+'提供数据</span>'
				+ '</span>'
				+ '</div>'
				+ '</div>	'
				+ '<div style="position:absolute; top:210px; left:15px;">'
				+ '<span style="color: #0000ff;">￥'
				+ item.now_price
				+ '</span> '
				+ '<span style="text-decoration: line-through;font-size: 13px;">&nbsp;￥'
				+ item.list_price
				+ '</span>'
				+ '<span style="color: #ff0000;position: absolute; width: 230px; left: 0px; top: 0px; text-align: right">'
				+ item.hits + '人购买</span> ' + '</div>' + '</div>';
		}
		itemsInner +='<img id="recommand_'
			+ i
			+ '_Focus" style="visibility:hidden;width:325px; height:300px; top: '
			+ (127 + xLine * 252)
			+ 'px; left:'
			+ (56 + i % 4 * 280)
			+ 'px; position:absolute;" alt="" src="../dzdp/border_bg4.png" />';
		itemsInner +='<img id="recommand_'
			+ i
			+ '_layer" style="'+isHidden+'width:263px; height:235px; top: '
			+ (160 + xLine * 252)
			+ 'px; left:'
			+ (86 + i % 4 * 280)
			+ 'px; position:absolute;" alt="" src="../dzdp/layer.png" />';
	}
	document.getElementById("recommandList").innerHTML = itemsInner;
	document.getElementById("recommand_0").focus();
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
		<img id="logo" src="../dzdp/2.gif" style="position:absolute; left:1000px; top:40px; Z-index:1000"/>
	</div>
	<div id="layer" style="position:absolute;z-index:10; width: 1200px; height: 40px;left: 0px;top: 110px;text-align: center;font-size: 30px;"></div>
	<input type="hidden" id="districID" value="" />
	<jsp:include page="header.jsp" flush="true" />
	
	<div id="content" style="position: absolute; top: 20px; left: 0px; width: 1280px; height: 700px;">
		<div style="position:absolute;top:352px;left:35px;width:36px;height:70px;">
			<img src="../dzdp/toLeft.png" width="36" height="70" onclick="priPager();">
		</div>
		<div style="position:absolute;top:352px;left:1200px;width:36px;height:70px;">
			<img src="../dzdp/toRight.png" width="36" height="70" onclick="nextPager();">
		</div>
		<div id="recommandList"></div>
	</div>
</epg:body>
</epg:html>
