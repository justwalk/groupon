<%@page contentType="text/html; charset=gbk"%>
<%@taglib uri="http://chances.com.cn/jsp/epg" prefix="epg"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setAttribute("basePath", basePath);
	String itemsCount = request.getParameter("itemsCount");
	String type = request.getParameter("type");
	String categoryId = request.getParameter("categoryId");
	String athome = request.getParameter("athome");//是否为家附近跳转而来
	String categoryName = request.getParameter("categoryName");
	//categoryName = new String(categoryName.getBytes("iso-8859-1"),"utf-8");
	categoryName=java.net.URLDecoder.decode(categoryName,"UTF-8");
	String pageId = request.getParameter("pageId");
	//是否记录Bi
	String isbi = request.getParameter("isbi");
	if(isbi==null){
		isbi="true";
	}
	request.setAttribute("isbi", isbi);
	if(pageId==null){
		pageId="";
	}
	request.setAttribute("itemsCount", itemsCount);
	request.setAttribute("type", type);
	request.setAttribute("athome", athome);
	request.setAttribute("categoryId", categoryId);
	request.setAttribute("categoryName", categoryName);
	request.setAttribute("pageId", pageId);
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

#menu_pagerSpan {
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
		if(getFocusIDLongJing==""){
			//getFocusIDLongJing=getFocusID;
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
							document.getElementById("a_next").focus();
							document.getElementById("a_next").focus();
							
							return 0;
						} else {
							//document.getElementById("recommand_" + (idP - 4)).focus();
						}
					}
				}
			}
			else{
				if (getFocusID.indexOf('_')) {
					var idF = getFocusID.split('_')[0];
					var idP = getFocusID.split('_')[1];
					if (idF == "recommand") {
						if (idP < 4) {
							document.getElementById("a_next").focus();
							document.getElementById("a_next").focus();
						} else {
							//document.getElementById("recommand_" + (idP - 4)).focus();
						}
	
						getFocusIDLongJing=getFocusID;
					}
				}
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
						if (idP > 0 && idP != 4) {
							//document.getElementById("recommand_" + (idP - 1)).focus();
						}
						else if(idP == 0 || idP == 4){
							document.getElementById("a_pri").focus();
							priPager();
							return 0;
						}
	
					}
				}
			}
			else{
				if (getFocusID.indexOf('_')) {
					var idF = getFocusID.split('_')[0];
					var idP = getFocusID.split('_')[1];
					if (idF == "recommand") {
						if (idP > 0 && idP != 4) {
							//document.getElementById("recommand_" + (idP - 1)).focus();
						}
						else if(idP == 0 || idP == 4){
							document.getElementById("a_pri").focus();
							priPager();
						}
	
					}
				}
				getFocusIDLongJing=getFocusID;
			}
			break;
		case "EIS_IRKEY_RIGHT":
			//如果是ipanel
			if(typeof(iPanel)!='undefined'){
				//alert(getFocusID);
				if (getFocusID.indexOf('_')>-1) {
					var idF = getFocusID.split('_')[0];
					var idP = getFocusID.split('_')[1];
					if (idF == "recommand") {
						if (idP < (itemsCount-1) && idP != 3) {
							//document.getElementById("recommand_" + (idP - 0 + 1)).focus();
						}
						else if(idP == 3 || idP == (itemsCount-1)){
							document.getElementById("a_next").focus();
							nextPager();
							return 0;
						}
	
					}
				}
			}
			else{
				if (getFocusID.indexOf('_')>-1) {
					var idF = getFocusID.split('_')[0];
					var idP = getFocusID.split('_')[1];
					if (idF == "recommand") {
						if (idP < (itemsCount-1) && idP != 3) {
							//document.getElementById("recommand_" + (idP - 0 + 1)).focus();
						}
						else if(idP == 3 || idP == (itemsCount-1)){
							document.getElementById("a_next").focus();
							nextPager();
						}
	
						getFocusIDLongJing=getFocusID;
					}
				}
			}
			break;
		case "EIS_IRKEY_BACK":
			goBack1();
			return 0;
			break;
		case "EIS_IRKEY_EXIT":
			goBack1();
			return 0;
			break;
		case "EIS_IRKEY_PAGE_UP":
			document.getElementById("a_pri").focus();
			priPager();
			break;
		case "EIS_IRKEY_PAGE_DOWN":
			document.getElementById("a_next").focus();
			nextPager();
			break;
		default:
			return 1;
			break;
		}
	}
	//聚焦控件ID
	var getFocusID = "next";
	var getFocusIDLongJing="";
	var Path = "${basePath}";
	var type = '${type}';
	var athome = '${athome}';
	var categoryId = '${categoryId}';
	var categoryName = '${categoryName}';
	var pageId='${pageId}';
	var funcId=8;//下一页选中
	//是否记录bi数据
	var isbi='${isbi}';
	//当前排序规则
	var sortType="discount";
	//翻页是否完成
	var pageHandComplete=true;
	//当前页码
	var pageIndex = 0;
	var pageSize = 8;
	var itemsCount = '${itemsCount}';
	var itemsSumCount = '${itemsCount}';
	var pagesCount = Math.ceil(itemsCount / pageSize);
	if(pagesCount==0){
		pagesCount=1;
	}
	function init() {
		try{
			mac=hardware.STB.serialNumber;
		}
		catch(err){
			
		}
		pageIndex=getCookie("pageIndex");
		document.getElementById("cate_name").innerHTML = categoryName;
		getPagers(pageIndex,biPageType);
	}
	
	function menuOnfocus(obj) {
		getFocusID = obj;
		document.getElementById(obj + "_Focus").style.display = "block";
		//document.getElementById(obj+"_img").style.border = "solid 2px #ffffff";
	}

	function menuLostfocus(obj) {
		document.getElementById(obj + "_Focus").style.display = "none";
		//document.getElementById(obj+"_img").style.border = "solid 0px #ffffff";
	}
	function pagerOnfocus(obj,obj1) {
		getFocusID = obj;
		document.getElementById(obj + "_Focus").style.display = "block";
		document.getElementById(obj1 + "_Focus").style.display = "none";
		openA();
	}

	function pagerLostfocus(obj) {
		document.getElementById(obj + "_Focus").style.display = "none";
	}


	//上一页
	function priPager() {
		if(!pageHandComplete){
			return;
		}
		if (pageIndex == 0) {
			return;
		}
		pageHandComplete=false;
		funcId=7;
		pageIndex--;
		isbi=true;
		getPagers(pageIndex,biFuncType);
	}
	//下一页
	function nextPager() {
		if(!pageHandComplete){
			return;
		}
		if(pagesCount==1){
			return;
		}
		pageHandComplete=false;
		funcId=8;
		if (pageIndex == pagesCount - 1) {
			pageIndex=-1;
		}
		pageIndex++;
		isbi=true;
		getPagers(pageIndex,biFuncType);
	}
	//调用分页接口
	function getPagers(pageNo,biType) {
		var urlStr=interfaceurl;
		//判断分页种类(团购券/优惠券)
		if(type=="C"){
			urlStr+=getCoupon;
		}
		else{
			urlStr+=getGroupon;
		}
		urlStr+= "?type=0&category=" + categoryId
		+ "&usercode=1&countF=" + pageNo * 8
		+ "&countE=" + pageSize+"&mac=deciveId";
		if(sortType=="hot"){
			urlStr+="&sorttype=hot&sort=desc";
		}
		else if(sortType=="discount"){
			urlStr+="&sorttype=rebate&sort=asc";
		}
		else if(sortType=="price"){
			urlStr+="&sorttype=price&sort=asc";
		}

		if(athome=="1"){
			urlStr+="&athome=true";
		}
		else{
			urlStr+="&athome=false";
		}
		urlStr = escape(urlStr);
		var ajax_url = Path + "clientUrlHandler.do?url=" + urlStr;
		if(isbi){
			ajax_url+="&biType="+biType+"&pageId="+pageId;
			isbi=false;
		}
		if(biType==biFuncType){
			ajax_url+="&funcId="+funcId+"&funcContent="+(pageNo-0+1);
		}
		var _ajaxObj = new AJAX_OBJ(ajax_url, clientUrlHandler);
		_ajaxObj.requestData();
		document.getElementById("menu_pagerSpan").innerHTML = (pageNo - 0 + 1) + "/" + pagesCount + "页";
	}
	//显示分页数据
	function clientUrlHandler(result) {
		var items = eval("(" + result.responseText + ")").response.body.dataList;
		var xLine = 0;//行索引
		var itemsInner = "";
		itemsCount=items.length;
		//该页ID集合
		var tp="0";
		if(type=='C'){
			tp="1";
		}
		for (var i = 0; i < items.length; i++) {
			xLine = Math.floor(i / 4);
			//alert(xLine);
			var item = items[i];
			var itemIDS='[';
			if(itemsCount>1){
				if (i%2==0) {
					itemIDS+="{'id':'"+items[i].deal_id+"','type':'"+tp+"'}";
					if(itemsCount>i+1){
						itemIDS+=",{'id':'"+items[i+1].deal_id+"','type':'"+tp+"'}";
					}
				}
				else{
					itemIDS+="{'id':'"+items[i-1].deal_id+"','type':'"+tp+"'}";
					itemIDS+=",{'id':'"+items[i].deal_id+"','type':'"+tp+"'}";
				}
			}
			else if(itemsCount==1){
				itemIDS+="{'id':'"+items[0].deal_id+"','type':'"+tp+"'}";
			}
			itemIDS+=']';
			itemIDS=escape(itemIDS);
			var itemname = item.name.replace('?','');
			//if (itemname.length > 12) {
				//name='&nbsp;&nbsp;&nbsp;'+name;
				itemname = subString(itemname, 23,true);
			//}
			if(type=='C'){
				itemsInner += '<div id="recommand'
					+ i
					+ '_div" style="width:262px; height:235px; top: '
					+ (160 + xLine * 252)
					+ 'px; left:'
					+ (87 + i % 4 * 280)
					+ 'px; position:absolute; background-color:#ffffff;">'
					+ '<a id="recommand_'
					+ i
					+ '" href="itemDetail.jsp?dealId='
					+ item.deal_id
					+ '&pageIndex='+pageIndex+'&pageCount='+pagesCount+'&itemsCount='+itemsSumCount+'&categoryId='+categoryId+'&pageSize=2&itemIDS='+itemIDS+'&type=C&athome='+athome+'&biType='+biItemType+'&pageId='+pageId+'" onfocus="menuOnfocus(\'recommand_'
					+ i
					+ '\')" onblur="menuLostfocus(\'recommand_'
					+ i
					+ '\')" style="color:#000000;">'
					+ '<img alt="" src="../dzdp/dot.gif" width="262" height="145" />'
					+ '</a>' 
					+ '<img alt="" src="'+item.icon+'" width="262" height="145" style="position: absolute;top: 0px;left: 0px;" />'
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
					+ '" href="itemDetail.jsp?dealId='
					+ item.deal_id
					+ '&pageIndex='+pageIndex+'&pageCount='+pagesCount+'&itemsCount='+itemsSumCount+'&categoryId='+categoryId+'&pageSize=2&itemIDS='+itemIDS+'&type=&athome='+athome
					+'&biType='+biItemType+'&pageId='+pageId+'" onfocus="menuOnfocus(\'recommand_'
					+ i
					+ '\')" onblur="menuLostfocus(\'recommand_'
					+ i
					+ '\')" style="color:#000000;">'
					+ '<img alt="" src="../dzdp/dot.gif" width="262" height="145" />'
				 	+ '</a>'
					+ '<img alt="" src="'+item.s_image_url+'" width="262" height="145" style="position: absolute;top: 0px;left: 0px;" />'
					+ '<div class="pro_content">'
					+ '<div style="height:1px;position:absolute; top:150px; left:8px; width:100px; background-color: ff8b02;"></div>'
					+ '<span id="iname_'+i+'" align="left" style="position:absolute;left:15px;top:155px;width:265px;height:26px;">'
					+ itemname
					+ '</span>'
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
					+ '</div>	'
					+ '<div style="position:absolute; top:210px; left:15px;">'
					+ '<span style="color: #ff0000;">'
					+ item.now_price
					+ '元&nbsp;</span> '
					+ '<span style="text-decoration: line-through;font-size: 13px;">'
					+ item.list_price
					+ '元</span>'
					+ '<span style="color: #0000ff;position: absolute; width: 230px; left: 0px; top: 0px; text-align: right">'
					+ item.hits + '人购买</span> ' + '</div>' + '</div>';
			}
			itemsInner +='<img id="recommand_'
				+ i
				+ '_Focus" style="display:none;width:325px; height:300px; top: '
				+ (127 + xLine * 252)
				+ 'px; left:'
				+ (56 + i % 4 * 280)
				+ 'px; position:absolute;" alt="" src="../dzdp/border_bg4.png" />';
		}
		document.getElementById("recommandList").innerHTML = itemsInner;
		document.getElementById("a_next").focus();
		pageHandComplete=true;
	}
	function colseA(){
		var arrayOfDocFonts = document.getElementsByTagName("a");
		for(var i = 0;i<arrayOfDocFonts.length;i++){
			var aId = arrayOfDocFonts[i].id;
			if(aId.startWith("recommand_")){
				document.getElementById(aId).style.display = "none";
			}
		}
	}
	function openA(){
		var arrayOfDocFonts = document.getElementsByTagName("a");
		for(var i = 0;i<arrayOfDocFonts.length;i++){
			var aId = arrayOfDocFonts[i].id;
			if(aId.startWith("recommand_")){
				document.getElementById(aId).style.display = "block";
			}
		}
	}
	function goBack1(){
		 history.go(-1);
		 return false;
	}
	function sortAlert(sort){
		colseA();
		document.getElementById("sortContent").style.display="block";
		document.getElementById("sort_"+sort+"_a").focus();
	}
	function sort(sort){
		if(sort=="hot"){
			document.getElementById("sort_hot").style.display="block";
			document.getElementById("sort_discount").style.display="none";
			document.getElementById("sort_price").style.display="none";
			funcId=14;
		}
		else if(sort=="discount"){
			document.getElementById("sort_hot").style.display="none";
			document.getElementById("sort_discount").style.display="block";
			document.getElementById("sort_price").style.display="none";
			funcId=15;
		}
		else if(sort=="price"){
			document.getElementById("sort_hot").style.display="none";
			document.getElementById("sort_discount").style.display="none";
			document.getElementById("sort_price").style.display="block";
			funcId=16;
		}
		
		document.getElementById("sort_hot_Focus").style.display="none";
		document.getElementById("sort_discount_Focus").style.display="none";
		document.getElementById("sort_price_Focus").style.display="none";
		document.getElementById("sortContent").style.display="none";
		//更新数据
		if(sort!=sortType){
			sortType=sort;
			pageIndex=0;
			isbi=false;
			getPagers(pageIndex,biFuncType);
		}
	}
	function toDetail(href){
		window.location.href=href;
		return false;
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
		<img id="main_img" src="../dzdp/categoryListBG.png" border="0" width="1280" height="720" />
		<img id="logo" src="../dzdp/2.gif" style="position:absolute; left:1050px; top:40px; Z-index:1000"/>
	</div>

	<div id="header">
		<div id="menu_back" style="position: absolute; top: 43; left: 62px; width: 220px; height: 85px;">
			<a id="menu_back_a" href="javascript:goBack1()" onfocus="menuOnfocus('menu_back');openA();" onblur="menuLostfocus('menu_back')" style="position: absolute; left: 95px; top: 20px;/* background-color: green; */"> 
				<img id="menu_back_img" src="../dzdp/dot.gif" width="130" height="50">
			</a>
			<span id="cate_name" style="position: absolute; top: 15px; left: 75px; font-weight: bold; color: #ffffff; font-size: 35px;width: 153px;height: 80px; background: url(../dzdp/cateBG.png);">生活服务</span>
		</div>
		<div id="menu_pager" style="position: absolute; top: 45px; left: 0px; color: #ffffff; font-weight: bold; font-size: 19px;">
			<div style="position: absolute; top: 12px; left: 292px; width: 152px; height: 45px;/* background-color: red; */">
				<a href="#" id="a_pri" onclick="priPager();return false;" onfocus="pagerOnfocus('pri','next')" onblur="menuLostfocus('pri')" style="position: absolute; top: 6px; left: 6px;width: 152px; height: 45px;">
					<img id="a_pri_img" alt="" src="../dzdp/dot.gif" width="152" height="45">
				</a>
			</div>
			<div style="position: absolute; top: 12px; left: 491px; width: 152px; height: 45px;/* background-color: red; */">
				<a id="a_next" href="#" onclick="nextPager();return false;" onfocus="pagerOnfocus('next','pri');" onblur="pagerLostfocus('next')" style="position: absolute; top: 6px; left: 8px;width: 152px; height: 45px;">
					<img id="a_next_img" alt="" src="../dzdp/dot.gif" width="152" height="45">
				</a>
			</div>
			<div id="menu_pagerSpan" style="position: absolute; left: 723px; top: 20px; width: 158px; font-size: 30px;">1/92页</div>
			<div id="menu_back_Focus" style="position: absolute; display: none; top: -5px; left: 55px; width: 100px; height: 87px;">
				<img id="menuFocus_back_img" src="../dzdp/btn_back_focus.png" width="100" height="87">
			</div>
			<div id="pri_Focus" style="position: absolute; display: none; top: 11px; left: 292px; width: 164px; height: 58px;">
				<img alt="" src="../dzdp/pri_focus.png" style="position: absolute; top: 0px; left: 0px; width: 164px; height:58px;">
			</div>
			<div id="next_Focus" style="position: absolute; display: none; top: 11px; left: 495px; width: 164px; height: 58px;">
				<img alt="" src="../dzdp/next_focus.png" style="position: absolute; top: 0px; left: 0px; width: 164px; height:58px;">
			</div>
		</div>
		<!-- 排序 -->
		<div id="sort_hot" style="display:none; position:absolute; top:53px; left: 880px; font-size:32px; color:ff9f2f; width: 200px;">
			<a id="menu_sort_hot" style="position: absolute;left: 6px;top: 8px;width: 150px;height: 40px;" href="javascript:sortAlert('hot')" onfocus="menuOnfocus('menu_sort_hot')" onblur="menuLostfocus('menu_sort_hot')"> 
				<img src="../dzdp/dot.gif" width="150" height="40">
			</a>
			<img src="../dzdp/menu_sort_hot.png" width="164" height="58">
		</div>
		
		<div id="sort_discount" style="position:absolute; top:53px; left: 880px; font-size:32px; color:ff9f2f; width: 200px;">
			<a id="menu_sort_discount" href="javascript:sortAlert('discount')" onfocus="menuOnfocus('menu_sort_discount')" onblur="menuLostfocus('menu_sort_discount')"> 
				<img src="../dzdp/menu_sort_discount.png" width="164" height="58">
			</a>
		</div>
		
		
		<div id="sort_price" style="display:none;position:absolute; top:53px; left: 880px; font-size:32px; color:ff9f2f; width: 200px;">
			<a id="menu_sort_price" href="javascript:sortAlert('price')" onfocus="menuOnfocus('menu_sort_price')" onblur="menuLostfocus('menu_sort_price')"> 
				<img src="../dzdp/menu_sort_price.png" width="164" height="58">
			</a>
		</div>
		<div id="menu_sort_hot_Focus" style="display:none; position: absolute; top: 53px; left: 880px; width: 100px; height: 87px;">
			<img src="../dzdp/menu_sort_hot_Focus.png" width="164" height="58">
		</div>
		<div id="menu_sort_discount_Focus" style="display:none; position: absolute; top: 53px; left: 880px; width: 100px; height: 87px;">
			<img src="../dzdp/menu_sort_discount_Focus.png" width="164" height="58">
		</div>
		<div id="menu_sort_price_Focus" style="display:none; position: absolute; top: 53px; left: 880px; width: 100px; height: 87px;">
			<img src="../dzdp/menu_sort_price_Focus.png" width="164" height="58">
		</div>
	</div>
	<div id="sortContent" style="display:none;position: absolute; top: 109px; left: 886px; width: 154px; height: 125px; z-index:999;">
		<div id="sort_hot_div" style="position: absolute; top: 5px; left: 0px;">
			<a id="sort_hot_a" href="javascript:sort('hot');" onfocus="menuOnfocus('sort_hot')" onblur="menuLostfocus('sort_hot')">
				<img alt="" src="../dzdp/dot.gif" width="130" height="32">
			</a>
		</div>
		<div id="sort_discount_div" style="position: absolute; top: 46px; left: 0px;">
			<a id="sort_discount_a" href="javascript:sort('discount');" onfocus="menuOnfocus('sort_discount')" onblur="menuLostfocus('sort_discount')">
				<img alt="" src="../dzdp/dot.gif" width="130" height="32">
			</a>
		</div>
		<div id="sort_price_div" style="position: absolute; top: 90px; left: 0px;">
			<a id="sort_price_a" href="javascript:sort('price');" onfocus="menuOnfocus('sort_price')" onblur="menuLostfocus('sort_price')">
				<img alt="" src="../dzdp/dot.gif" width="130" height="32">
			</a>
		</div>
		<div id="sort_hot_Focus" style="display: none; position: absolute; top: 0px; left: 0px;">
			<img alt="" src="../dzdp/sort_hot.png" width="154" height="125">
		</div>
		<div id="sort_discount_Focus" style="display: none; position: absolute; top: 0px; left: 0px;">
			<img alt="" src="../dzdp/sort_discount.png" width="154" height="125">
		</div>
		<div id="sort_price_Focus" style="display: none; position: absolute; top: 0px; left: 0px;">
			<img alt="" src="../dzdp/sort_price.png" width="154" height="125">
		</div>
	</div>
		<div id="recommandList"  style="position: absolute; top: 20px; left: 0px; "></div>
</epg:body>
</epg:html>
