<%@page contentType="text/html; charset=gbk"%>
<%@taglib uri="http://chances.com.cn/jsp/epg" prefix="epg"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setAttribute("basePath", basePath);
%>
<%@ include file="checkSession.jsp" %>
<epg:html>
<script src="${basePath}/js/ajax.js"></script>
<script src="${basePath}/js/event.js"></script>
<script src="${basePath}/js/data.js?r=2"></script>
<style>
.pro_content {
	padding-left: 15px;
	font-size: 20px;
	padding-top: 5px;
	font-family: 黑体;
}

#menu_topSpan {
	color: #ffffff;
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
		switch (eventObj.code) {
		case "EIS_IRKEY_UP":
			getFocusIDLongJing=getFocusID;
			if(document.getElementById("bigMoreAlert_div").style.display=="block"){
				scrollUp();
				return 0;
			}
		case "EIS_IRKEY_DOWN":
			//如果是ipanel
			getFocusIDLongJing=getFocusID;
			if(document.getElementById("bigMoreAlert_div").style.display=="block"){
				scrollDown();
				return 0;
			}
			if(typeof(iPanel)!='undefined'){
				if(getTopFocusID=="item7"){
					document.getElementById("item0_a").focus();
					scrollDown();
				}
			}
			else{
				if(getFocusIDLongJing=="item7"){
					document.getElementById("item0_a").focus();
					getFocusIDLongJing=getFocusID;
				}
			}
			break;
		case "EIS_IRKEY_SELECT":
			break;
		case "EIS_IRKEY_LEFT":
			if(document.getElementById("bigMoreAlert_div").style.display=="block"){
				return 0;
			}
			//如果是ipanel
			if(typeof(iPanel)!='undefined'){
				if(getFocusID=="more"){
					document.getElementById("item0_a").focus();
					return 0;
			
				}
				if(itemStrIndex>0 && bTop){
					/* itemStrIndex--;
					document.getElementById("topSelect"+itemStrIndex).style.display="block";
					document.getElementById("topSelect"+(itemStrIndex-0+1)).style.display="none";
					drawItems();
					return 0; */
					moveLeftPlus();
				}
			}
			else{
				if(getFocusIDLongJing=="more"){
					document.getElementById("item0_a").focus();
					getFocusIDLongJing=getFocusID;
					return 0;
				}
				if(itemStrIndex>0 && bTop){
					/* itemStrIndex--;
					document.getElementById("topSelect"+itemStrIndex).style.display="block";
					document.getElementById("topSelect"+(itemStrIndex-0+1)).style.display="none";
					drawItems();
					getFocusIDLongJing=getFocusID;
					return 0; */
					moveLeftPlus();
				}
			}
			break;
		case "EIS_IRKEY_RIGHT":
			if(document.getElementById("bigMoreAlert_div").style.display=="block"){
				return 0;
			}
			//如果是ipanel
			if(typeof(iPanel)!='undefined'){
				if(getFocusID=="item"){
					document.getElementById("more_detail_a").focus();
					return 0;
				}
				if(itemStrIndex<itemEval.length && bTop){
				/* 	itemStrIndex++;
					document.getElementById("topSelect"+itemStrIndex).style.display="block";
					document.getElementById("topSelect"+(itemStrIndex-1)).style.display="none";
					drawItems();
					return 0; */
					moveRightPlus();
				}
			}
			else{
				if(getFocusID=="item"){
					document.getElementById("more_detail_a").focus();
					getFocusIDLongJing=getFocusID;
					return 0;
				}
				if(itemStrIndex<itemEval.length && bTop){
				/* 	itemStrIndex++;
					document.getElementById("topSelect"+itemStrIndex).style.display="block";
					document.getElementById("topSelect"+(itemStrIndex-1)).style.display="none";
					drawItems();
					getFocusIDLongJing=getFocusID;
					return 0; */
					moveRightPlus();
				}
			}
			break;
		case "EIS_IRKEY_BACK":
			break;
		case "EIS_IRKEY_EXIT":
			window.location.href="module.jsp";
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
	var getFocusID = "menu_1_a";
	var getFocusIDLongJing="";
	var getTopFocusID = "";
	//是否切换排行榜
	var bTop=false;

	var Path = "${basePath}";
	var itemIDS='';
	var pageIndex='1';
	var pageCount='1';
	var categoryId='-1';
	var pageSize='1';
	var type='';
	//排行榜数据源索引
	var itemStrIndex=0;
	var itemEval;
	var maxItemsCount=8;
	//bi参数
	var pageId="74";
	function init() {
		try{
			mac=hardware.STB.serialNumber;
		}
		catch(err){
			
		}
		top10Init();
	}
	//查询top10数据
	function top10Init(){
		var urlStr=escape(interfaceurl+"getRank");
		var ajax_url = Path+"clientUrlHandler.do?url="+urlStr+"&pageId="+pageId+"&biType="+biPageType;
		var _ajaxObj = new AJAX_OBJ(ajax_url,handlTop10);
		_ajaxObj.requestData();
	}
	function handlTop10(result){
		itemsStr=result.responseText;
		itemEval=eval("("+itemsStr+")").response.body.dataList;
		var topStr="";
		for(var i=0;i<itemEval.length;i++){	
			var display="none";
			var dis = "block"
			if(i==0){
				display="block";
			}
			if(i>5){
				dis="none";
			}
			topStr+='<div id="topItem'+i+'" style="position: absolute; display:'+dis+'; left:'+(100*i-18)+'px;top:5px;width:100px;height: 30px;text-align:center;"><span style="font-size:26px;">'+itemEval[i].desc+'</span></div>'
				+'<img id="split'+i+'"  style="position: absolute; left:'+(80-0+100*i)+'px; top:-5px;" alt="" src="../dzdp/split.png">'
				+'<img id="topSelect'+i+'" style="position: absolute; display:'+display+'; left: '+(100*i-12)+'px; top:-10px;height: 59px; width: 90px;" alt="" src="../dzdp/topTypeSelected.png">';
		}
		document.getElementById("menu_top").innerHTML=topStr;
		drawItems();
	}
	//绘制top10数据
	function drawItems(){
		//var itemEval=eval("("+itemsStr+")").response.body.dataList;
		var its=itemEval[itemStrIndex];
		var items=its.items;
		var ulStr='';
		var max=maxItemsCount;
		if(maxItemsCount>items.length){
			max=items.length;
		}
		for(var i=0;i<max;i++){
			var top=25-0+i*50;
			if(i==1 || i==4 || i==7){
				top-=2;
			}
			else if(i==2){
				top-=3;
			}
			var color="#ffffff";
			if(i<3){
				color="#000000";
			}
			ulStr+='<div style="position: absolute; width: 255px;height:39px; left: -24px;top: '+top+'px;">'
			ulStr+='<a id="item'+i+'_a" style="position: absolute;width:255px;height:39px;" href="#" onblur="bTop=false;itemBlur('+i+');" onfocus="bTop=true;itemFocus(\'item'+i+'\','+i+');queryItemDetail(\''+items[i].k+'\');">';
			ulStr+='<img id="item'+i+'_img" alt="" style="position: absolute; left:0px;top:0px;" src="../dzdp/dot.png" width="255" height="39" />'
			ulStr+="</a>";
			ulStr+="</div>";
			ulStr+='<div id="item'+i+'_div" style="position: absolute;font-size:26px;color:#ffffff;width: 190px;height:26px;overflow: hidden;left: 38px;top: '+(31-0+i*50)+'px;">'
			ulStr+=items[i].v;
			ulStr+="</div>";
			var spanTop=30-0+i*50;
			var spanLeft=14;
			if(i>0&&i<3){
				spanTop+=6;
				spanLeft-=1;
			}
			else if(i==0){
				spanTop+=9;
				spanLeft-=1;
			}
			ulStr+='<div id="item'+i+'_span" style="position: absolute;font-size:20px;color:'+color+';width: 190px;height:26px;overflow: hidden;left: '+spanLeft+'px;top: '+spanTop+'px;">'
			ulStr+=(i-0+1);
			ulStr+="</div>";
		}
		ulStr+="";
		document.getElementById("recommandList").innerHTML = ulStr;
		
		//document.getElementById("menu_top").innerHTML = "川菜";//its.desc;
		//setTimeout(document.getElementById("item0_a").focus(),200);
		if(null!=document.getElementById("item0_a")){
			setTimeout(document.getElementById("item0_a").focus(),200);
		}else{
			setTimeout(document.getElementById("menu_back_a").focus(),200);
		}
	}
	function itemFocus(obj,i){
		if(obj.substr(0,4)=="item"){
			getFocusID = "item"
		}
		getTopFocusID=obj;
		document.getElementById("item"+i+"_img").src="../dzdp/topItemSelected"+i+".png"
		document.getElementById("item"+i+"_div").style.color="#000000";
		document.getElementById("item"+i+"_span").style.color="#000000";
	}
	function itemBlur(i){
		document.getElementById("item"+i+"_img").src="../dzdp/dot.png"
		document.getElementById("item"+i+"_div").style.color="#ffffff";
		var color="#ffffff";
		if(i<3){
			color="#000000";
		}
		document.getElementById("item"+i+"_span").style.color=color;
	}
	function menuOnfocus(obj) {
		if(obj=="menu_back"){
			document.getElementById("reBtn").style.color = "#FFB322";
		}
		getFocusID = obj;
		document.getElementById(obj + "_Focus").style.visibility = "visible";
	}

	function menuLostfocus(obj) {
	if(obj=="menu_back"){
			document.getElementById("reBtn").style.color = "#FFFFFF";
		}
		document.getElementById(obj + "_Focus").style.visibility = "hidden";
	}
	function pagerOnfocus(obj) {
		getFocusID = obj;
		document.getElementById("a_"+obj+"_img").src="../dzdp/"+obj+"_focus.png";
	}

	function pagerLostfocus(obj) {
		document.getElementById("a_"+obj+"_img").src="../dzdp/"+obj+".png";
	}


	//查询单个商品信息
	function queryItemDetail(itemId){
		dealId=itemId;
		//document.getElementById("layer").innerHTML="itemIDS="+itemIDS+"nextItemId="+nextItemId+"---itemId="+itemId;
		var urlStr= interfaceurl;
		if(type=="C"){
			urlStr+=getCouponDetail;
		}
		else{
			urlStr+=getGrouponDetail;
		}
		urlStr+="?dealId="+itemId;
		urlStr=escape(urlStr);
		var ajax_url = Path+"clientUrlHandler.do?url="+urlStr
				+"&biType="+biItemType+"&pageId="+pageId+"&funcId=&itemId="+dealId+"&itemType=0";
		var _ajaxObj = new AJAX_OBJ(ajax_url,handlItemDetail);
		_ajaxObj.requestData();
	}
	
	function handlItemDetail(result){
		var items=eval("("+result.responseText+")").response.body.dataList;
		var item=items[0];
		//设置item明细
		document.getElementById("contentName").innerHTML=subString(item.name.replace('?',''), 30,true);
		document.getElementById("conDiscount").innerHTML=(item.discount*10).toFixed(1)+'折';
		document.getElementById("contentPCount").innerHTML=item.hits+'人';
		document.getElementById("contentExpress").innerHTML=item.r_end.substring(0,10);
		var region=item.regions.replace("?","");
		var bsAddress = item.businesses_address.replace(",","<br/>");
		document.getElementById("contentCity").innerHTML=subString(region,200,true);
		document.getElementById("contentCity").innerHTML += '<br/><div style="color:#FFF;font-size:22px;">商家地址：</div>';
		document.getElementById("contentCity").innerHTML += bsAddress;
		document.getElementById("icon").src=item.icon;
		var itemDeatail=item.explains.replace('?','');
		if(type!='C'){
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
		
		//是否已收藏
		/*if(item.favoriteStatus=="1"){
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
		}*/
		document.getElementById("city").innerHTML=item.city;
	}
	function clientTwoCodeHandler(result){
		var code=result.responseText;

		//document.getElementById("layer").innerHTML=code;
		document.getElementById("twoCodeImg").src="data:image/png;base64,"+code;
	}
	var moreObj;
	var isShow = false;
	function showBigAlertTip(obj,content){
		content=document.getElementById("word").innerHTML;
		title = document.getElementById("contentName").innerHTML;
		isShow = true;
		moreObj = obj;
		document.getElementById("moreContent_span").innerHTML=content;
		document.getElementById("moreTitle_div").innerHTML = title;
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
		if(moreObj=='moreRegion'){
			document.getElementById("moreRegion").focus();
		}
		else{
			document.getElementById("more_detail_a").focus();
		}
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
		if(document.getElementById("moreContent").style.top<0){
			document.getElementById("moreContent").style.top=document.getElementById("moreContent").style.top-0+390;	
		}
	}
	function scrollDown(){
		if((390+0-document.getElementById("moreContent").style.top)<document.getElementById("moreContent").scrollHeight){
			document.getElementById("moreContent").style.top=document.getElementById("moreContent").style.top-390;
			document.getElementById("arrowUp_div").style.visibility = "visible";
			document.getElementById("scrollUp_a").style.display = "block";
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
		var _ajaxObj = new AJAX_OBJ(ajax_url, faviousHandler);
		_ajaxObj.requestData();

		function faviousHandler(result){
			var handle = eval("(" + result.responseText + ")").response.header.rc;
			if(handle==0||handle=="0"){
				if(favious=="1"){
					//document.getElementById("btn_favious").style.display="block";
					//document.getElementById("btn_favious_cancel").style.display="none";
					//document.getElementById("btn_favious_Focus").style.visibility = "hidden";
					//document.getElementById("btn_favious_cancel_Focus").style.visibility = "hidden";
					//document.getElementById("btn_favious_a").focus();
				}
				else{
					//document.getElementById("btn_favious").style.display="none";
					//document.getElementById("btn_favious_cancel").style.display="block";
					//document.getElementById("btn_favious_Focus").style.visibility = "hidden";
					//document.getElementById("btn_favious_cancel_Focus").style.visibility = "hidden";
					//document.getElementById("btn_favious_cancel_a").focus();
				}
			}
			else{
				alert('服务器繁忙,请稍后再试...');
			}
		}
	}
	function moveRightPlus(){
		itemStrIndex++;
		if(itemEval.length>6){
			if(itemStrIndex<6){
				document.getElementById("topSelect"+itemStrIndex).style.display="block";
				document.getElementById("topSelect"+(itemStrIndex-1)).style.display="none";
				drawItems();
				getFocusIDLongJing=getFocusID;
				return 0;
			}
			else{
				if(parseInt(document.getElementById("topItem6").style.left)==582){
					for(var j=0;j<itemStrIndex;j++){
						document.getElementById("topItem"+(j+itemEval.length-itemStrIndex)).style.left=(100*j-18)+"px";
						document.getElementById("topSelect"+(j+itemEval.length-itemStrIndex)).style.left=(100*j-12)+"px";
					}
					document.getElementById("topItem0").style.display="none";
					document.getElementById("topItem"+itemStrIndex).style.display="block";
					document.getElementById("topSelect"+itemStrIndex).style.display="block";
					document.getElementById("topSelect"+(itemStrIndex-1)).style.display="none";
					drawItems();
					getFocusIDLongJing=getFocusID;
					return 0;
				}
				else if(parseInt(document.getElementById("topItem6").style.left)==482){
					document.getElementById("topSelect"+itemStrIndex).style.display="block";
					document.getElementById("topSelect"+(itemStrIndex-1)).style.display="none";
					drawItems();
					getFocusIDLongJing=getFocusID;
					return 0;
				}
			}
		}
		else{
		document.getElementById("topSelect"+itemStrIndex).style.display="block";
		document.getElementById("topSelect"+(itemStrIndex-1)).style.display="none";
		drawItems();
		getFocusIDLongJing=getFocusID;
		return 0;
		}
	}
	function moveLeftPlus(){
		itemStrIndex--;
		if(itemEval.length>6){
			if(itemStrIndex>0){
				document.getElementById("topSelect"+itemStrIndex).style.display="block";
				document.getElementById("topSelect"+(itemStrIndex-0+1)).style.display="none";
				drawItems();
				getFocusIDLongJing=getFocusID;
				return 0;
			}
			else{
				if(parseInt(document.getElementById("topItem6").style.left)==582){
					document.getElementById("topSelect"+itemStrIndex).style.display="block";
					document.getElementById("topSelect"+(itemStrIndex-0+1)).style.display="none";
					drawItems();
					getFocusIDLongJing=getFocusID;
					return 0;
				}
				else{
					for(var j=0;j<itemEval.length;j++){
						document.getElementById("topItem"+j).style.left=(100*j-18)+"px";
						document.getElementById("topSelect"+j).style.left=(100*j-12)+"px";
					}
						document.getElementById("topItem6").style.display="none";
						document.getElementById("topItem0").style.display="block";
						document.getElementById("topSelect"+itemStrIndex).style.display="block";
						document.getElementById("topSelect"+(itemStrIndex+1)).style.display="none";
					drawItems();
					getFocusIDLongJing=getFocusID;
					return 0;	
				}
			}
		}
		else{
			document.getElementById("topSelect"+itemStrIndex).style.display="block";
			document.getElementById("topSelect"+(itemStrIndex-0+1)).style.display="none";
			drawItems();
			getFocusIDLongJing=getFocusID;
			return 0;
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
	bgcolor='#000000'>
	<div id="showInfo" style="z-index:10000;color:#FFFFFF;position:absolute;top:20px;left:20px;"></div>
	<!-- 背景图片以及头部图片 -->
	<div id="main_div">
		<img id="main_img" src="../dzdp/topBG.png" border="0"
			width="1280" height="720" />
	</div>

	<div id="header">
		<div id="menu_back" style="position: absolute; top: 23; left: 62px; width: 245px; height: 85px;">
			<a id="menu_back_a" href="module.jsp" onfocus="bTop=true;menuOnfocus('menu_back')" onblur="bTop=false;menuLostfocus('menu_back')"> 
				<img id="menu_back_img" src="../dzdp/dot.png" width="59" height="59">
			</a>
			<div style="position: absolute;top: 12px;left: 60px;font-weight: bold; color:#ffffff; width: 360px;font-size: 22px;">
				<span id="reBtn" style="font-size: 35px; position:absolute; top:5px; left:0px;">排行榜</span>
			</div>
		</div>
		<div id="menu_top" style="position: absolute;width:615px; text-align:left; font-size:32px; top: 45px; left: 530px; color: #ffffff; font-weight: bold;">
			
		</div>
		<div id="menu_back_Focus" style="position:absolute;visibility: hidden;top:23px;left:27px;width:100px;height:87px;" >
			<img id="menuFocus_back_img" src="../dzdp/btn_back_focus.png" width="100" height="87" />
		</div>
	</div>
	<div id="content"
		style="position: absolute; top: 0px; left: 0px; width: 1280px; height: 720px;">
		<div id="recommandList" style="position: absolute; top: 185px; left: 118px;">
		</div>
		<div id="itemDetail" style="position:absolute;top: 50px;left: 400px;">
			<img id="icon" style="position:absolute; top:140px;left:13px;" src="#ff00ff"  border="0" width="325" height="202" />
			<span style="width: 160px;position:absolute; top:320px;left:385px; font-size:22px; color:#ffffff;">扫描二维码获取本品</span> 
			<div id="twoCode" style="position:absolute; top:266px;left:427px;">
				<span id="conDiscount_img"><img alt="" src="../dzdp/7.8.png"  width="130" height="49" style="position:absolute;left:0px; top:0px"></span>
				<span id="conDiscount" style=" font-size: 16px;color: #ffffff; position:absolute;top: 10px;width: 87px;font-size: 26px; left:51px;"></span>
			</div>
			<img id="twoCodeImg" alt="" src="" width="160" height="160" style="position:absolute;left:382px; top:389px">
			<div style="width:320px;position:absolute; top:375px;left:35px;  font-size:22px;">
				<div style="color:#ffffff;">适用商圈：<span id="city"></div>
				<div id="contentCity" style=";position: absolute;width: 300px;color:#ffffff;line-height: 30px;font-size:20px;height: 175px;overflow:hidden;"></div>&nbsp;
			</div>
			<div id="contentName" style="width:420px;position:absolute; top:138px;left:360px; font-size:27px; color:#ffffff;display:inline;height: 28px;overflow: hidden;">
				
			</div>
			<div id="contentInfo" style="position:absolute; top:198px; left:360px; width:430px; height:60px; font-size:20px;">
				<span style="position:absolute; top:5px;left:0px;color:#ff0001; font-size:32px;" id="nowPrice"></span>
				<span id="disPrice" style="position:absolute; top:12px;left:110px;font-size:24px;color:#eee333;text-decoration: line-through;"></span>
				
				<span style="position:absolute; top:0px;left:230px;color:#ffffff;font-size:20px;width:100px;">购买数:</span>
				<span id="contentPCount" style="position:absolute; top:0px;left:310px;font-size:20px;color:#ff6000;width: 120px;"></span>
				<span style="position:absolute;color:#ffffff;top:22px;left:230px;font-size:20px;width:80px;">有效期:</span>
				<span id="contentExpress" style="position:absolute; top:22px;left:310px;font-size:20px;color:#ff6000; width:120px;"></span>
			</div>
			
			<div id="word" style="position:absolute; top:265px;left:583px; font-size:17px;line-height: 30px;width: 185px; height:215px; overflow: hidden; color:#b6bcca;">
				
			</div>
			<div id="detail_more" style="position:absolute; top:487; left:590px; width:172px; height:54px;z-index:999;">
				<epg:img id="more_detail" src="/dzdp/dot.png" top="0" left="0" width="172" height="54" href="#" onfocus="bTop=true;getFocusID='more';document.getElementById('more_detail_img').src='../dzdp/topMore_focus.png';" onblur="bTop=false;document.getElementById('more_detail_img').src='../dzdp/dot.png';" onclick="showBigAlertTip('moreDetail','');return false;"/>
			</div>
		</div>
	</div>
<div id="bigMoreAlert_div" style="position:absolute;left:0px; top:0px; width:1280px; height:720px;display:none;overflow:hidden;">
	<epg:img id="alertClose" src="/dzdp/moreAlert.png" width="1280" height="720" />
	<div id="closeBigMoreAlert_div" align="left" style="position:absolute; left:950px;top:85px;width:82px;height:44px;">
	 	<a id="closeBigMoreAlert_a" href="#" onfocus="document.getElementById('closeBigMoreAlert_img').src='../dzdp/alertClose.png';" onblur="document.getElementById('closeBigMoreAlert_img').src='../dzdp/dot.png';" onclick="closeAlertTip();return false;" style="width:82px;height:44px;">
			<img id="closeBigMoreAlert_img" src="../dzdp/dot.png" border="0" width="82" height="44">
		</a>
	</div>
	<div id="moreTitle_div" align="left" style="position:absolute; font-size:28px; font-family:'黑体'; left:238px;top:95px;width:600px;height:34px;">
 		
	</div>
	<div id="arrowUp_div" style="position:absolute;visibility:hidden;left:578px; top:140px; width:60px; height:29px; display:none;">
		<epg:img id="scrollUp" onfocus="document.getElementById('scrollUp_img').src='../dzdp/arrowUp_focus.png';" onblur="document.getElementById('scrollUp_img').src='../dzdp/arrowUp.png';" src="/dzdp/arrowUp.png" href="javascript:scrollUp();" left="0" top="0" width="60" height="29"/>
	</div>
	<div style="position:absolute;left:237px; top:171px; width:792px; height:414px;overflow:hidden;">
		<div id="moreContent" style="position:absolute;left:0px;top:0px;width:792px;">
		<span id="moreContent_span" style="color:#000000;font-size:25; font-family:黑体;height:0px;"></span></div>
	</div>
	<div id="arrowDown_div"  style="position:absolute;visibility:hidden;left:578px; top:590px; width:60px; height:29px; display:none;">
		<epg:img id="scrollDown" onfocus="document.getElementById('scrollDown_img').src='../dzdp/arrowDown_focus.png';" onblur="document.getElementById('scrollDown_img').src='../dzdp/arrowDown.png';" src="/dzdp/arrowDown.png" href="#" onclick="scrollDown();return false;"  left="0" top="0" width="60" height="29"/>
	</div>
</div>
</epg:body>
</epg:html>
