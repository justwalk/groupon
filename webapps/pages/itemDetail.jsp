<%@page contentType="text/html; charset=gbk"%>
<%@taglib uri="http://chances.com.cn/jsp/epg" prefix="epg"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% 
	String path = request.getContextPath(); 
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
	request.setAttribute("basePath", basePath);

	//获取明细数据
	String itemId = request.getParameter("id");
	String itemIDS = request.getParameter("itemIDS");
	String pageIndex = request.getParameter("pageIndex");
	String pageCount = request.getParameter("pageCount");
	String itemsCount = request.getParameter("itemsCount");
	String categoryId = request.getParameter("categoryId");
	String dbcId = request.getParameter("dbcId");
	String pageSize = request.getParameter("pageSize");
	String type=request.getParameter("type");
	String dealId = request.getParameter("dealId");
	String faviousId = request.getParameter("faviousId");
	String isFavious = request.getParameter("isFavious");
	String pageId = request.getParameter("pageId");
	String funcId = request.getParameter("funcId");
	String athome = request.getParameter("athome");
	String from = request.getParameter("from");
	if(athome==null){
		athome="0";
	}
	if(pageId==null){
		pageId="";
	}
	if(funcId==null){
		funcId="";
	}
	if(pageIndex==null){
		pageIndex="";
	}
	if(pageCount==null){
		pageCount="";
	}
	if(categoryId==null){
		categoryId="";
	}
	if(faviousId==null){
		faviousId="";
	}
	if(dbcId==null){
		dbcId="";
	}
	if(isFavious==null){
		isFavious="0";
	}
	if(dealId==null){
		dealId="";
	}
	if(pageSize==null){
		pageSize="";
	}
	if(type==null){
		type="";
	}
	if(from==null){
		from="";
	}
    request.setAttribute("type",type);
    request.setAttribute("itemId",itemId);
    request.setAttribute("dealId",dealId);
    request.setAttribute("faviousId",faviousId);
    request.setAttribute("isFavious",isFavious);
    request.setAttribute("itemIDS",itemIDS);
    request.setAttribute("pageIndex",pageIndex);
    request.setAttribute("pageCount",pageCount);
    request.setAttribute("itemsCount",itemsCount);
    request.setAttribute("categoryId",categoryId);
    request.setAttribute("dbcId",dbcId);
    request.setAttribute("pageSize",pageSize);
    request.setAttribute("pageId",pageId);
    request.setAttribute("funcId",funcId);
    request.setAttribute("athome",athome);
    request.setAttribute("from",from);
	String searchWord = request.getParameter("searchWord");
	if(searchWord==null){
		searchWord="";
	}
	request.setAttribute("searchWord", searchWord);
%>
<%@ include file="checkSession.jsp" %>
<epg:html>
<script src="${basePath}/js/ajax.js"></script>
<script src="${basePath}/js/event.js"></script>
<script src="${basePath}/js/data.js?r=1"></script>
<style>
	.pro_content{
		padding-left:15px;
		font-size: 20px;
		padding-top: 5px;
		font-family: 黑体;
	}
	a,a:focus,a:hover{
	-webkit-tap-highlight-color:rgba(0,0,0,0);
}
</style>
<script type="text/javascript" charset="utf-8">
function ppp(){
	if(priItemId!=""){
		queryItemDetail(priItemId,priItemId);
	}
	else if(pageIndex>0){
		//重新获取上下页数据
		priPager();
	}
}
function nnn(){

	//document.getElementById("layer").innerHTML="nextItemId="+nextItemId;
	if(nextItemId!=""){
		queryItemDetail(nextItemId,nextItemId);
	}
	else if(pageIndex<pageCount-1){
		//重新获取上下页数据
		nextPager();
	}
}
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
		if(document.getElementById("bigMoreAlert_div").style.display=="block"){
			scrollUp();
			return 0;
		}
		break;
	case "EIS_IRKEY_DOWN":
		getFocusIDLongJing=getFocusID;
		if(document.getElementById("bigMoreAlert_div").style.display=="block"){
			scrollDown();
			return 0;
		}
		break;
	case "EIS_IRKEY_SELECT":
		break;
	case "EIS_IRKEY_LEFT":
		if(document.getElementById("bigMoreAlert_div").style.display=="none"){
			//如果是ipanel
			if(typeof(iPanel)!='undefined'){
				if(getFocusID=="menu_back"){
					if(priItemId!=""){
						queryItemDetail(priItemId,priItemId);
					}
					else if(pageIndex>0){
						//重新获取上下页数据
						priPager();
					}
					return 0;
				}
			}
			else{
				if(getFocusID=="menu_back"){
					if(priItemId!=""){
						queryItemDetail(priItemId,priItemId);
					}
					else if(pageIndex>0){
						//重新获取上下页数据
						priPager();
					}
					getFocusIDLongJing=getFocusID;
				}
			}
		}
		break;
	case "EIS_IRKEY_RIGHT":
		//document.getElementById("layer").innerHTML="itemIDS="+itemIDS+"------nextItemId="+nextItemId;
		if(document.getElementById("bigMoreAlert_div").style.display=="none"){
			//如果是ipanel
			if(typeof(iPanel)!='undefined'){
				if(getFocusID=="menu_back"){
					if(nextItemId!=""){
						queryItemDetail(nextItemId,nextItemId);
					}
					else if(pageIndex<pageCount-1){
						//重新获取上下页数据
						nextPager();
					}
					return 0;
				}
			}
			else{
				if(getFocusID=="menu_back"){
					if(nextItemId!=""){
						queryItemDetail(nextItemId,nextItemId);
					}
					else if(pageIndex<pageCount-1){
						//重新获取上下页数据
						nextPager();
					}
					getFocusIDLongJing=getFocusID;
				}
			}
		}
		break;
	case "EIS_IRKEY_BACK":
		if(searchWord!=""){
			return goBack1();
		}
		break;
	case "EIS_IRKEY_EXIT":
		goBack1();
		return 0;
		break;
	case "SITV_KEY_PAGEUP":
		break;
	case "SITV_KEY_PAGEDOWN":
		break;
	default:
		return 1;
		break;
	}
}
//聚焦控件ID
var getFocusID="menu_back";
var getFocusIDLongJing="";
var Path = "${basePath}";

var itemIDS="${itemIDS}";
var pageIndex='${pageIndex}';
var pageIndex_list='${pageIndex}';
var pageCount='${pageCount}';
var itemsCount='${itemsCount}';
pageCount=Math.ceil(itemsCount/2);
var categoryId='${categoryId}';
var dbcId='${dbcId}';
var pageSize='${pageSize}';
var type='${type}';
var from='${from}';
var itemId='${itemId}';
//bi记录的页面id
var pageId='${pageId}';
var funcId='${funcId}';
//从收藏传递来的参数 商品ID
var dealId='${dealId}';
//从搜索页传递来的参数
var searchWord="${searchWord}";
//是否收藏
var isFavious='${isFavious}';
//收藏表ID
var faviousId='${faviousId}';
//上一个商品ID
var priItemId="";
//下一个商品ID
var nextItemId="";
//当前商品title
var itemTitle = "";
var athome='${athome}';
function init(){
	try{
		mac=hardware.STB.serialNumber;
	}
	catch(err){
		
	}
	//alert(searchWord);
	queryItemDetail(itemId,dealId);
}
//查询商品明细
function queryItemDetail(itemid,dealid){
	itemId=itemid;
	var ids=eval('('+itemIDS+')');
	var tp="";
	type="";
	var itemType="0";
	//document.getElementById("layer").innerHTML="itemIDS="+itemIDS+"nextItemId="+nextItemId+"---itemid="+itemid;
	for(var i=0;i<ids.length;i++){
		if(ids[i].id==dealid){
			if(ids[i].type=="1"){
				tp="C";
				type="C";
				itemType="1";
				break;
			}
		}
	}
	var urlStr= interfaceurl;
	if(tp=="C"){
		urlStr+=getCouponDetail;
	}
	else{
		urlStr+=getGrouponDetail;
	}
	urlStr+="?dealId="+dealid;
	urlStr=escape(urlStr);
	var ajax_url = Path+"clientUrlHandler.do?url="+urlStr+"&biType="+biItemType+"&pageId="+pageId+"&funcId="+funcId+"&itemId="+dealid+"&itemType="+itemType+"&mac=deciveId";
	
	var _ajaxObj = new AJAX_OBJ(ajax_url,handlItemDetail);
	_ajaxObj.requestData();
	
	function handlItemDetail(result){
		var items=eval("("+result.responseText+")").response.body.dataList;
		var item=items[0];
		try{
			dealId=item.deal_id;
		}
		catch(e){
			
		}
		//设置item明细
		try{
			itemTitle = subString(item.name.replace('?',''), 43,true);
			document.getElementById("contentName").innerHTML=subString(item.name.replace('?',''), 43,true);
			document.getElementById("moreTitle_div").innerHTML=subString(item.name.replace('?',''), 43,true);
			document.getElementById("contentType").innerHTML=item.cname;
			document.getElementById("conDiscount").innerHTML=(item.discount*10).toFixed(1)+'折';
			document.getElementById("contentPCount").innerHTML=item.hits+'人';
			document.getElementById("contentExpress").innerHTML=item.r_end.substring(0,10);
			var region=item.regions.replace("?","");
			var bsAddress = item.businesses_address.replace(",","<br/>");
			document.getElementById("contentCity").innerHTML=subString(region,292,true);
			document.getElementById("contentCity").innerHTML += '<br/><div style="color:#FFF;font-size:22px;">商家地址：</div>';
			document.getElementById("contentCity").innerHTML += bsAddress;
			document.getElementById("icon").src=item.icon;
			var itemDeatail=item.explains.replace('?','');
			//判断商品类型
			if(tp!='C'){
				itemDeatail+="<br>"+item.details.replace('?','');
				document.getElementById("nowPrice").innerHTML='￥'+item.now_price+'|';
				document.getElementById("disPrice").innerHTML='￥'+item.list_price+' ';
				//加载图片二维码
				//var urlStr = escape(item.deal_h5_url);
				//var servlets="<%=request.getContextPath() %>/servlet/ImageServlet?url=";
				//document.getElementById("twoCodeImg").src=servlets+urlStr;
				document.getElementById("twoCodeImg").src=item.more_image_url;
			}
			else{
				document.getElementById("conDiscount").innerHTML="";
				document.getElementById("conDiscount_img").innerHTML="";
				document.getElementById("twoCodeImg").src=item.deal_h5_url;
			}
			document.getElementById("word").innerHTML=itemDeatail;
			document.getElementById("logo_img").src=item.from_type_img_url;
			document.getElementById("fromCon").innerHTML=item.from_type;
			document.getElementById("kefuTelNo").innerHTML=item.custPhone;
			document.getElementById("city").innerHTML=item.city;
		}
		catch(e){
			alert(e);
		}
		//设置上/下一个itemID
		try{
			var ids=eval('('+itemIDS+')');
			for(var i=0;i<ids.length;i++){
				//if((isFavious=="1"&&ids[i].id==item.deal_id)||(isFavious=="0"&&ids[i].id==item.id)){
				if(ids[i].id==item.deal_id){
					if(i==0){
						priItemId="";
					}
					else{
						priItemId=ids[i-1].id;
					}
					if(i==ids.length-1){
						nextItemId="";
					}
					else{
						nextItemId=ids[i+1].id;
					}
				}
			}
		}
		catch(e){
			alert(e);
		}
		document.getElementById("menu_back_a").focus();
		//是否已收藏
		if(item.favoriteStatus=="1"){
			document.getElementById("btn_favious").style.display="block";
			document.getElementById("btn_favious_cancel").style.display="none";
			document.getElementById("btn_favious_Focus").style.visibility = "hidden";
			document.getElementById("btn_favious_cancel_Focus").style.visibility = "hidden";
		}
		else{
			document.getElementById("btn_favious").style.display="none";
			document.getElementById("btn_favious_cancel").style.display="block";
			document.getElementById("btn_favious_Focus").style.visibility = "hidden";
			document.getElementById("btn_favious_cancel_Focus").style.visibility = "hidden";
		}
	}
}

//弹出框
var moreObj;
var isShow = false;
function showBigAlertTip(obj,content){
	isShow = true;
	moreObj = obj;
	
	 if(moreObj=='moreRegion'){
		document.getElementById("moreTitle_div").innerHTML="适用商圈";
	}else if(moreObj=='twoCode1'){
		document.getElementById("moreTitle_div").innerHTML="二维码扫描介绍";
		content=document.getElementById("word").innerHTML;
		document.getElementById("moreContent_span").innerHTML='<img id="twoCodeImg" src="../dzdp/QRcode.png" width="840"/>';
	}
	else{
		var needKnow = document.getElementById("moreTitle_div").innerHTML;
		if(needKnow=="" || needKnow==null || needKnow=="underfind"){
			document.getElementById("moreTitle_div").innerHTML="购买须知";
		}else{
			document.getElementById("moreTitle_div").innerHTML=itemTitle;
		}
		content=document.getElementById("word").innerHTML;
		document.getElementById("moreContent_span").innerHTML=content;

	}
	 
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
	setTimeout(function(){
		if(moreObj=='moreRegion'){
			document.getElementById("moreRegion").focus();
		}else if(moreObj=='twoCode1'){
			document.getElementById("twoCode_a").focus();
		}
		else{
			document.getElementById("more_detail").focus();
		}
	},500);
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
	if((mTop+"").indexOf("px")>-1){
		mTop=mTop.replace("px","");
	}
	if(mTop<0){
		document.getElementById("moreContent").style.top=(mTop-0+390)+"px";	
	}
}
function scrollDown(){
	var mTop=document.getElementById("moreContent").style.top;
	if((mTop+"").indexOf("px")>-1){
		mTop=mTop.replace("px","");
	}
	if((390+0-mTop)<document.getElementById("moreContent").scrollHeight){
		document.getElementById("moreContent").style.top=(mTop-390)+"px";
		document.getElementById("arrowUp_div").style.visibility = "visible";
		document.getElementById("scrollUp_a").style.display = "block";
	}
}
function menuOnfocus(obj){
	getFocusID=obj;
	document.getElementById(obj+"_Focus").style.visibility = "visible";
}

function menuLostfocus(obj){
	document.getElementById(obj+"_Focus").style.visibility = "hidden";
}


var isPorN=false;
//上一页
function priPager() {
	if (pageIndex == 0) {
		return;
	}
	isPorN=false;
	pageIndex--;
	getPagers(pageIndex);
}
//下一页
function nextPager() {
	if (pageIndex == pageCount - 1) {
		return;
	}
	isPorN=true;
	pageIndex++;
	getPagers(pageIndex);
}
//调用分页接口
function getPagers(pageNo) {
	var urlStr="";
	if(dbcId!=null && dbcId!=""){
		urlStr = interfaceurl + getObjectGroupon
			+ "?dbcId=" + dbcId
			+ "&usercode=1&countF=" + pageNo * 2
			+ "&countE=" + pageSize;
		if(athome=="1"){
			urlStr+="&mac=deciveId";
		}
	}
	else if(isFavious=="1"){
		var urlStr=interfaceurl+getFavorite+"?mac=deciveId&countF="
				+(pageIndex*pageSize)+"&countE="+pageSize;
	}
	else{
		urlStr= interfaceurl;
		if(type=="C"){
			urlStr+=getCoupon;
		}
		else{
			urlStr+=getGroupon;
		}
		urlStr+= "?type=0&category=" + categoryId
			+ "&usercode=1&countF=" + pageNo * 2
			+ "&countE=" + pageSize+"&mac=deciveId";
		if(athome=="1"){
			urlStr+="&athome=true";
		}
		else{
			urlStr+="&athome=false";
		}
	}
	urlStr=escape(urlStr);
	var ajax_url = Path + "clientUrlHandler.do?url=" + urlStr+"&biType=4&pageId="+pageId;
	var _ajaxObj = new AJAX_OBJ(ajax_url, getPagersHandler);
	_ajaxObj.requestData();
}
//显示分页数据
function getPagersHandler(result) {
	var items = eval("(" + result.responseText + ")").response.body.dataList;
	//该页ID集合
	itemIDS="[";
	for (var i = 0; i < items.length; i++) {
		var tp="0";
		if(type=='C'){
			tp="1";
		}
		if(isFavious=="1"){
			itemIDS+="{'id':'"+items[i].dealId+"','type':'"+items[i].type+"'},";
		}
		else{
			itemIDS+="{'id':'"+items[i].deal_id+"','type':'"+tp+"'},";
		}
	}
	if(itemIDS!="["){
		itemIDS=itemIDS.substring(0,itemIDS.length-1);
	}
	itemIDS+="]";
	var ids=eval('('+itemIDS+')');
	if(ids.length>0){
		if(isPorN){
			queryItemDetail(ids[0].id,ids[0].id);
		}
		else{
			queryItemDetail(ids[ids.length-1].id,ids[ids.length-1].id);
		}
	}
}
//收藏/取消收藏
function favious(favious){
	var t="0";
	if(type=="C"){
		t="1";
	}
	var urlStr=escape(interfaceurl + saveFavorite
			+ "?type="+t+"&mac=deciveId&status="+favious+"&dealId="+dealId);
	var ajax_url = Path + "clientUrlHandler.do?url=" + urlStr+"&biType=4";
	
	if(favious=="1"){
		ajax_url+="&biType="+biFuncType+"&pageId="+pageId+"&funcId=3&funcContent="+dealId+","+type;
	}
	else{
		ajax_url+="&biType="+biFuncType+"&pageId="+pageId+"&funcId=2&funcContent="+dealId+","+type;
	}
	
	var _ajaxObj = new AJAX_OBJ(ajax_url, faviousHandler);
	_ajaxObj.requestData();

	function faviousHandler(result){
		var handle = eval("(" + result.responseText + ")").response.header.rc;
		if(handle==0||handle=="0"){
			if(favious=="1"){
				document.getElementById("btn_favious").style.display="block";
				document.getElementById("btn_favious_cancel").style.display="none";
				document.getElementById("btn_favious_Focus").style.visibility = "hidden";
				document.getElementById("btn_favious_cancel_Focus").style.visibility = "hidden";
				document.getElementById("btn_favious_a").focus();
			}
			else{
				document.getElementById("btn_favious").style.display="none";
				document.getElementById("btn_favious_cancel").style.display="block";
				document.getElementById("btn_favious_Focus").style.visibility = "hidden";
				document.getElementById("btn_favious_cancel_Focus").style.visibility = "hidden";
				document.getElementById("btn_favious_cancel_a").focus();
			}
		}
		else{
			alert('服务器繁忙,请稍后再试...');
		}
	}
}
function towCodeClick(){
	
}

function goBack1(){
	if(searchWord!=""){
		window.location.href="search.jsp?searchWord="+searchWord;
		return 0;
	}
	if(from=="cj"){
		window.location.href="choujiang.jsp?r="+Math.random();
		return 0;
	}
	//pageIndex=Math.floor(pageIndex/4);
	setCookie("pageIndex",pageIndex_list);
	history.go(-1);
	return 1;
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
<div id="main_div"  >
	<img id="appdetial_bg" src="../dzdp/appdetial_bg1.png"  border="0" width="1280" height="720" />
	<img id="logo" src="../dzdp/2.gif" style="position:absolute; left:1000px; top:20px; Z-index:1000"/>
</div>
<div id="layer" style="position:absolute;z-index:1000; width: 1200px; height: 40px;left: 0px;top: 90px;text-align: center;font-size: 14px;"></div>

<div id="content" style="position:absolute;top:0px;left:0px;width:1280px;height:720px;">
	<div id="header">
		<div id="menu_back" style="position:absolute;top:30;left:37px;width:59px;height:59px;" >
			<a id="menu_back_a" style="position:absolute; top: 45px; left: 27px;width:20px;height:20px;" href="javascript:goBack1()" onfocus="menuOnfocus('menu_back')" onblur="menuLostfocus('menu_back')">
				<img id="menu_back_img" src="../dzdp/dot.png" width="20" height="20">
			</a>
			<div style="position: absolute;top: 5px;left: 80px;font-weight: bold; color:#ffffff; width: 360px;font-size: 22px;">
				<span style="font-size: 35px; position:absolute; top:5px; left:0px;">详情&nbsp;-</span>
				<img alt="" id="logo_img" src="../dzdp/dazhongdianping.png" style="position:absolute; top:12px; left:115px;" width="20" height="20">
				<span style=" font-size: 22px;position:absolute; top:12px; left:137px; width:220px;"><span id="fromCon">大众点评</span>提供数据</span>
				<span style=" font-size: 22px;position:absolute; top:12px; left:365px; width:520px;">客服电话:&nbsp;<span id="kefuTelNo"></span></span>
			</div>
		</div>	
		<div id="menu_back_Focus" style="position:absolute;visibility:hidden;top:22px;left:26px;width:100px;height:87px;" >
			<img id="menuFocus_back_img" src="../dzdp/btn_back_focus.png" width="100" height="87" />
		</div>
	</div>
	<div id="itemDetail">
		<img id="icon" style="position:absolute; top:142px;left:41px;" src="#ff00ff"  border="0" />
		<span style="position:absolute; top:350px;left:625px; font-size:22px; color:#ffffff;">扫描二维码获取本品</span> 
		<div id="twoCode" style="position:absolute; top:300px;left:705px;">
			<span id="conDiscount_img"><img alt="" src="../dzdp/7.8.png" width="130" height="49" style="position:absolute;left:0px; top:0px"></span>
			<span id="conDiscount" style=" color: #ffffff; position:absolute;top: 10px;width: 87px;font-size: 26px; left:51px;"></span>
		</div>
		<div style="position:absolute;left:557px; top:392px">
<%-- 			<a id="twoCode_a" href="#" onclick="showBigAlertTip('twodimensionalcodedescribes','<img alt=''  src='../dzdp/QRcode.png'/>'); return false;" style="position:absolute;left:0px; top:0px;width:270px;height:270px" onfocus="menuOnfocus('twoCode')" onblur="menuLostfocus('twoCode')">
				<img id="twoCodeImg" alt="" src="" width="270" height="270" style="position:absolute;left:0px; top:0px">
			</a> --%>
			
			<a id="twoCode_a" href="#" onclick="showBigAlertTip('twoCode1','');return false;" style="position:absolute;left:0px; top:0px;width:270px;height:270px" onfocus="menuOnfocus('twoCode')" onblur="menuLostfocus('twoCode')">
				<img id="twoCodeImg" alt="" src="../dzdp/twoCode.png" width="270" height="270" style="position:absolute;left:0px; top:0px ">
			</a>
		</div>
		<div id="twoCode_Focus" style="position: absolute; visibility: hidden; left: 525px; top: 355px;">
			<img id="twoCodeImg" alt="" src="../dzdp/border_bg4.png" width="332" height="343" style="position:absolute;left:0px; top:0px">
		</div>
		
		<div style="position:absolute; top:465px;left:50px; font-size:22px;">
			<div style="color:#ffffff;">适用商圈：<span id="city"></span></div>
			<div id="contentCity" style="position: absolute;width: 430px;color:#ffffff;line-height: 30px;font-size:20px;height: 175px;overflow:hidden;"></div>&nbsp;
		</div>
		<div id="contentName" style="position:absolute;width: 700px; top:138px;left:540px; font-size:35px; color:#ffffff;display:inline;height: 35px;overflow: hidden;">
			
		</div>
		<div id="contentInfo" style="position:absolute; top:210px;left:520px; width:700px;height:60px; font-size:20px;">
			<span style="color:#ff6000;font-size:40px;" id="nowPrice"></span>
			<span id="disPrice" style="margin-left:10px;font-size:24px;color:#eee333;text-decoration: line-through;"></span>
			
			<span style="color:#ffffff; display:none;" id="typeLabel">类型:</span>
			<span id="contentType" style=" font-size:20px;color:#ff6000;padding-right:8px; display:none;"></span>
			<span style="position:absolute;top:21px;left:260px;color:#ffffff;font-size:20px;">购买数:</span>
			<span id="contentPCount" style="position:absolute; top:21px;left:340px;font-size:20px;color:#ff6000;"></span>
			<span style="position:absolute;top:21px;left:460px;color:#ffffff;font-size:20px;">有效期:</span>
			<span id="contentExpress" style="position:absolute;top:21px;left:540px;font-size:20px;color:#ff6000; width:170px;"></span>
		</div>
		<div id="content" style="width:345px;height:303px; top: 295px; left:880px; position:absolute;">
			<!-- <div id="wordTitle" style="position:absolute; top:210px;left:0; font-size:26px;color:#666666;">
			</div> -->
			<div id="word" style="position:absolute; top:0px;left:0; font-size:22px;line-height: 30px;width: 345px; height:300px; overflow: hidden; color:#b6bcca;">
			</div>
		</div>
		<div style="position:absolute; top:599; left:890px; width:183px; height:64px;z-index:999;">
			<a id="more_detail" style="position:absolute;top:0px;left:0px;width:183px;height:64px;" href="#" onclick="showBigAlertTip('moreDetail','');return false;" onfocus="menuOnfocus('more_detail')" onblur="menuLostfocus('more_detail')">
				<img src="../dzdp/dot.png" width="183" height="64" style="position:absolute; top:0px; left:0px;"/>
			</a>
		</div>
		<div id="more_detail_Focus" style="visibility: hidden;position:absolute; top:599; left:890px; width:183px; height:64px;z-index:999;">
			<img src="../dzdp/more_focus.png" width="183" height="64" style="position:absolute; top:0px; left:0px;"/>
		</div>
		<div id="btn_favious" style="display:none;position:absolute;top:599px;left:1080px;width:138px;height:64px;" >
			<a id="btn_favious_a" style="position:absolute;top:0px;left:0px;width:138px;height:64px;" href="#" onclick="favious(0); return false;" onfocus="menuOnfocus('btn_favious')" onblur="menuLostfocus('btn_favious')">
				<img id="btn_favious_img" src="../dzdp/btn_favious.png" width="138" height="64" style="position:absolute; top:0px; left:0px;"/>
			</a>
		</div>		
		<div id="btn_favious_Focus" style="position:absolute;visibility:hidden;top:599px;left:1080px;width:138px;height:64px;" >
			<img id="btn_favious_img" src="../dzdp/btn_favious_focus.png" width="138" height="64" />
		</div>
		<div id="btn_favious_cancel" style="display:none;position:absolute;top:599px;left:1080px;width:138px;height:64px;" >
			<a id="btn_favious_cancel_a" style="position:absolute;top:0px;left:0px;width:138px;height:64px;" href="#" onclick="favious(1); return false;" onfocus="menuOnfocus('btn_favious_cancel')" onblur="menuLostfocus('btn_favious_cancel')">
				<img id="btn_favious_cancel_img" src="../dzdp/btn_favious_cancel.png" width="138" height="64" style="position:absolute; top:0px; left:0px;"/>
			</a>
		</div>		
		<div id="btn_favious_cancel_Focus" style="position:absolute;visibility:hidden;top:599px;left:1080px;;width:138px;height:64px;" >
			<img id="btn_favious_cancel_img" src="../dzdp/btn_favious_cancel_focus.png" width="138" height="64" />
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
	<div id="moreTitle_div" align="left" style="position:absolute; font-size:28px; font-family:'黑体'; left:238px;top:95px;width:600px;height:34px;">
 		
	</div>
	<div id="arrowUp_div" style="position:absolute;visibility:hidden;left:578px; top:140px; width:60px; height:29px; display:none;">
		<epg:img id="scrollUp" onfocus="document.getElementById('scrollUp_img').src='../dzdp/arrowUp_focus.png';" onblur="document.getElementById('scrollUp_img').src='../dzdp/arrowUp.png';" src="/dzdp/arrowUp.png" onclick="scrollUp();return false;" left="0" top="0" width="60" height="29"/>
	</div>
	<div style="position:absolute;left:220px; top:150px; width:840px; height:467px;overflow:hidden;">
		<div id="moreContent" style="position:absolute;left:0px;top:0px;width:840px;">
		<span id="moreContent_span" style="color:#000000;font-size:25; font-family:黑体;height:0px;"></span></div>
	</div>
	<div id="arrowDown_div"  style="position:absolute;visibility:hidden;left:578px; top:590px; width:60px; height:29px; display:none;">
		<epg:img id="scrollDown" onfocus="document.getElementById('scrollDown_img').src='../dzdp/arrowDown_focus.png';" onblur="document.getElementById('scrollDown_img').src='../dzdp/arrowDown.png';" src="/dzdp/arrowDown.png" onclick="scrollDown();return false;" left="0" top="0" width="60" height="29"/>
	</div>
</div>
</epg:body>
</epg:html>
