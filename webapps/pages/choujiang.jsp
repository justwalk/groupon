<%@page contentType="text/html; charset=gbk"%>
<%@taglib uri="http://chances.com.cn/jsp/epg" prefix="epg"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% 
	String path = request.getContextPath(); 
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
	request.setAttribute("basePath", basePath);

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
		font-family: ����;
	}
	a,a:focus,a:hover{
		-webkit-tap-highlight-color:rgba(0,0,0,0);
	}
</style>
<script type="text/javascript" charset="utf-8">
function layerAlert(msg)
{
	document.getElementById("layer").innerHTML=msg;
	document.getElementById("layer").style.visibility = "visible";
    setTimeout('document.getElementById("layer").style.visibility = "hidden"',2000);
}
function eventHandler(eventObj) {
	switch (eventObj.code) {
	case "EIS_IRKEY_UP":
		break;
	case "EIS_IRKEY_DOWN":
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
		if(isShow){
			document.getElementById("closeBigMoreAlert_a").click();
			return 0;
		}
		break;
	case "EIS_IRKEY_EXIT":
		if(isShow){
			document.getElementById("closeBigMoreAlert_a").click();
		}
		return 0;
		break;
	default:
		return 1;
		break;
	}
}
var moreObj;
var isShow = false;
function showBigAlertTip(obj,content){
	if(obj=="moreProductContentDiv"){
		document.getElementById("moreWordDiv").style.display = "none";
		document.getElementById("moreProductContentDiv").style.display = "block";
	}
	else{
		document.getElementById("moreWordDiv").style.display = "block";
		document.getElementById("moreProductContentDiv").style.display = "none";
	}
	isShow = true;
	moreObj = obj;
	document.getElementById("bigMoreAlert_div").style.display = "block";
	colseA();
	document.getElementById("closeBigMoreAlert_a").focus();
}
function closeAlertTip1(){
	document.getElementById("productDesc").innerHTML = '<div style="color:#ff0000; font-size:28px;position:absolute;top:20px;">��Ϣ���ύ����ȴ�������Ա������ϵ!</div>';
	setTimeout(function(){
		isShow = false;
		openA();
		document.getElementById("moreContent").style.top ="0";
		document.getElementById("bigMoreAlert_div").style.display = "none";
		if(moreObj=="moreProductContentDiv"){
			document.getElementById("product_a").focus();
		}
		else{
			document.getElementById("starta").focus();
		}
	},2000);
}
function closeAlertTip(){
	isShow = false;
	openA();
	document.getElementById("moreContent").style.top ="0";
	document.getElementById("bigMoreAlert_div").style.display = "none";
	setTimeout(function(){
		if(moreObj=="moreProductContentDiv"){
			document.getElementById("product_a").focus();
		}
		else{
			document.getElementById("starta").focus();
		}
	},300);
}

function colseA(){
	var arrayOfDocFonts = document.getElementsByTagName("a");
	for(var i = 0;i<arrayOfDocFonts.length;i++){
		var aId = arrayOfDocFonts[i].id;
		if(!aId.startWith("closeBigMoreAlert") && !aId.startWith("a_other")){
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


//ת��ת���Ƿ�������
var rateHandComplete=true;
//�۽��ؼ�ID
var getFocusID="menu_back_a";
var Path = "${basePath}";
var pageId="78";
//�齱ʣ�����
var chouJiangCount=3;

function init(){
	
	try{
		mac=hardware.STB.serialNumber;
	}
	catch(err){
		
	}
	document.getElementById("starta").focus();
	//����ʣ��齱����
	var urlStr=escape(interfaceurl+"getCJCount?mac=deciveId");
	var ajax_url = Path+"clientUrlHandler.do?url="+urlStr+"&pageId="+pageId+"&biType="+biPageType;
	var _ajaxObj = new AJAX_OBJ(ajax_url,handlCouponCJ);
	_ajaxObj.requestData();
	//����ת�̳齱����
	var urlStr1=escape(interfaceurl+getLuckDrawInit);
	var ajax_url1 = Path+"clientUrlHandler.do?url="+urlStr1+"&pageId="+pageId+"&biType=4";
	var _ajaxObj1 = new AJAX_OBJ(ajax_url1,handlRateRandom);
	_ajaxObj1.requestData();
}
function handlRateRandom(result){
	winRate=eval("("+result.responseText+")").response.body.dataList;
	//��Ʒ��Ϣ
	var ratePro1="";
	var ratePro2="";
	var ratePro3="";
	for(var i=0;i<winRate.length;i++){
		if(winRate[i].leval=="1"){
			ratePro1+='<div id="moreProductContent1" style="position: absolute; left: 0px; top: '+130*0+'px; width: 200px;">'+
								'<div style="position: absolute;top: 30px;left: 0px;width: 50px;">'+
							'<img alt="" src="../dzdp/rateP0.png">'+
						'</div>'+
						'<div style="position: absolute;top: 0px;left: 138px;border: solid 3px #f1f1f1;">'+
							'<img alt="" src="'+winRate[i].imagePath+'" width="160" height="100">'+
						'</div>'+
						'<div style="position: absolute;top: 20px;height: 80px;overflow: hidden;left: 321px;width: 450px;color: #666666;font-size: 20px;">'+
							winRate[i].name+" "+winRate[i].description+
						'</div>'+
					'</div>';
		}
		else if(winRate[i].leval=="2"){
			ratePro2+='<div id="moreProductContent2" style="position: absolute; left: 0px; top: '+130*1+'px; width: 200px;">'+
								'<div style="position: absolute;top: 30px;left: 0px;width: 50px;">'+
							'<img alt="" src="../dzdp/rateP1.png">'+
						'</div>'+
						'<div style="position: absolute;top: 0px;left: 138px;border: solid 3px #f1f1f1;">'+
							'<img alt="" src="'+winRate[i].imagePath+'" width="160" height="100">'+
						'</div>'+
						'<div style="position: absolute;top: 20px;height: 80px;overflow: hidden;left: 321px;width: 450px;color: #666666;font-size: 20px;">'+
							winRate[i].name+" "+winRate[i].description+
						'</div>'+
					'</div>';
		}
		else if(winRate[i].leval=="3"){
			ratePro3+='<div id="moreProductContent3" style="position: absolute; left: 0px; top: '+130*2+'px; width: 200px;">'+
								'<div style="position: absolute;top: 30px;left: 0px;width: 50px;">'+
							'<img alt="" src="../dzdp/rateP2.png">'+
						'</div>'+
						'<div style="position: absolute;top: 0px;left: 138px;border: solid 3px #f1f1f1;">'+
							'<img alt="" src="'+winRate[i].imagePath+'" width="160" height="100">'+
						'</div>'+
						'<div style="position: absolute;top: 20px;height: 80px;overflow: hidden;left: 321px;width: 450px;color: #666666;font-size: 20px;">'+
							winRate[i].name+" "+winRate[i].description+
						'</div>'+
					'</div>';
		}
	}
	document.getElementById("moreProductContentDiv").innerHTML=ratePro1+ratePro2+ratePro3;
}

var $ = function(id) { return document.getElementById(id); } 
var t = 0; //��תͼƬindex ��12
var runTime=0; //��ת��ʱ��
var run=0;  //��ʱ����ʱʱ��
var timer; 
var winningFlag = 0;//�����н�״̬ 0 �����н�,1���н�, 2����н�
var winningRate = 30;//�н���
var openedFlag = true;//�Ƿ���Գ齱
var t_random = 0;  //�������ֹͣʱ��
var runCount=4;//ת��ת���̶�Ȧ��
var mqIndex=0; //�ײ��н���Ϣindex
var interval;
//����ģ���н�����(��������)
var winRate=eval('([10,10,10,10,10,10,10,10,10,10,10,10])');
var winIndex=-1;
function getRandomTime(){//���ֹͣʱ��
	var rateCount=winRate.length;//ģ���н��ʸ���
	var ratePop="[";//�齱���ʶ�
	var rateA=0;//�齱�����ܺ�
	var minRateVar=0;//��С����
	for(var i=0;i<rateCount;i++){
		ratePop+='{"rateMin":'+rateA+',"rateMax":'+(rateA-0+winRate[i].rate)+'},';
		rateA+=winRate[i].rate*1.0;
		if(minRateVar>winRate[i].rate){
			minRateVar=winRate[i].rate;
		}
	}
	if(rateCount>0){
		ratePop=ratePop.substring(0,ratePop.length-1);
	}
	ratePop+="]";
	//���������
	var random = Math.random()*rateA;
	var ratePopJson=eval('('+ratePop+')');
	for(var i=0;i<ratePopJson.length;i++){
		if(ratePopJson[i].rateMin<random&&random<=ratePopJson[i].rateMax){
			t_random = rateCount*200*runCount+i*200;
			winIndex=i;
			break;
		}
	}
}

function doRotate(){
	if(!rateHandComplete){
		return;
	}
	rateHandComplete=false;
	t = 0;
	runTime=0;
	timer=null;
	t_random=0;
	getRandomTime();
	rotate();
}
//ת��ָ�����µ�λ��
var stopIndex=0;
function rotate(){//����ҡ��
	stopIndex++;
	$("rotate_a").style.display="none";
	if(!openedFlag){
		$("rotate_a").style.display="block";
		return;
	}
	t = t>10 ? 0 : t+1;		
	runTime = runTime+200;
	if(runTime<500) {				
		run = 50;
	}else if(runTime>500&&runTime<6000)  {
		run =20;
	}else if(runTime>6000&&runTime<7000) {
		run = 80;
	}else if(runTime>7000&&runTime<7700) {
		run = 120;
	}else if(runTime>7700&&runTime<7900) {
		run = 140;
	}else if(runTime>=8000) {
		run = 160;
	}
	//alert(t);
	$("img").src="../dzdp/z"+t+".png";	
	if(runTime==t_random){
		$("rotate_a").style.display="block";
		clearTimeout(timer);
		//�ж�ָ������λ�������λ���Ƿ��غ�
		if(stopIndex%winRate.length!=winIndex){
			layerAlert("�쳣�ĳ齱��Ϣ");
			return;
		}
		//�н�ʱ������ʾ��Ϣ
		//document.getElementById("a123").innerHTML=winningFlag;
		if(winRate[winIndex].type==1){//��Ʒ
			var urlStr=escape(interfaceurl+getLuckDrawGoods+"?mac=deciveId&id="+winRate[winIndex].id);
			var ajax_url = Path+"clientUrlHandler.do?url="+urlStr+"&biType=4";
			var _ajaxObj = new AJAX_OBJ(ajax_url,handlCoupon);
			_ajaxObj.requestData();
		}
		else if(winRate[winIndex].type==2){//�Ź�ȯ-����
			var urlStr=escape(interfaceurl+getLuckDrawGoods+"?mac=deciveId&id="+winRate[winIndex].id);
			var ajax_url = Path+"clientUrlHandler.do?url="+urlStr+"&biType=4";
			var _ajaxObj = new AJAX_OBJ(ajax_url,handlCoupon);
			_ajaxObj.requestData();
		}
		else if(winRate[winIndex].type==3){//�Ż�ȯ
			var urlStr=escape(interfaceurl+getLuckDrawGoods+"?mac=deciveId&id="+winRate[winIndex].id);
			var ajax_url = Path+"clientUrlHandler.do?url="+urlStr+"&biType=4";
			var _ajaxObj = new AJAX_OBJ(ajax_url,handlCoupon);
			_ajaxObj.requestData();
		}
		else if(winRate[winIndex].type==4){//�Ź�ȯ-�ۿ�
			var urlStr=escape(interfaceurl+getLuckDrawGoods+"?mac=deciveId&id="+winRate[winIndex].id);
			var ajax_url = Path+"clientUrlHandler.do?url="+urlStr+"&biType=4";
			var _ajaxObj = new AJAX_OBJ(ajax_url,handlCoupon);
			_ajaxObj.requestData();
		}
		else if(winRate[winIndex].type==5){//�Ӵ���
			var urlStr=escape(interfaceurl+getLuckDrawGoods+"?mac=deciveId&id="+winRate[winIndex].id);
			var ajax_url = Path+"clientUrlHandler.do?url="+urlStr+"&biType=4";
			var _ajaxObj = new AJAX_OBJ(ajax_url,handlCoupon);
			_ajaxObj.requestData();
		}
		else{
			var urlStr=escape(interfaceurl+"getCJ?mac=deciveId&isCJ=false");
			var ajax_url = Path+"clientUrlHandler.do?url="+urlStr
			+"&biType="+biFuncType+"&pageId="+pageId+"&funcId=6&funcContent=";
			var _ajaxObj = new AJAX_OBJ(ajax_url,handlCouponCJFailure);
			_ajaxObj.requestData();
			
			setTimeout(function(){
				document.getElementById("a_other1").focus();
			},500);
		}
		stopIndex=0;
		return;
	}else{
		stopIndex=stopIndex%winRate.length;
		timer = setTimeout("rotate();",run+0); 
	}

	rateHandComplete=true;
}
function addRateProduct(productId){
	var urlStr=escape(interfaceurl+saveLuckDrawInfo+"?mac=deciveId&good_id="+productId+"&phone="+document.getElementById("phone").value);
	var ajax_url = Path+"clientUrlHandler.do?url="+urlStr
	+"&biType=4&pageId="+pageId;
	var _ajaxObj = new AJAX_OBJ(ajax_url,handlCJProduct);
	_ajaxObj.requestData();
}
function handlCJProduct(result){
	var header=eval("("+result.responseText+")").response.header;
	if(header.rc==0){
		closeAlertTip1();
	}
	else{
		layerAlert("�ύʧ��,���빤����Ա��ϵ!");
	}
}
function handlCouponCJFailure(result){
	var items=eval("("+result.responseText+")").response.body.dataList;
	var item=items[0];
	document.getElementById("otherCount").innerHTML=item.cjCount;
	document.getElementById("otherCount1").innerHTML=item.cjCount;
	if(item.cjCount>0){
		document.getElementById("alertClose_img").src="../dzdp/choujiangAlert1.png";
		document.getElementById("moreContent").style.display="none";
		document.getElementById("moreContentProduct").style.display="none";
		document.getElementById("moreContent1").style.display="block";
		document.getElementById("moreContent2").style.display="block";
		document.getElementById("moreContent3").style.display="none";
	}
	else{
	 	document.getElementById("alertWord").innerHTML="���ź��������ĳ齱����������!<br>�������Ŭ��.";
		document.getElementById("alertClose_img").src="../dzdp/choujiangAlert1.png";
		document.getElementById("moreContentProduct").style.display="none";
		document.getElementById("moreContent").style.display="none";
		document.getElementById("moreContent1").style.display="none";
		document.getElementById("moreContent2").style.display="none";
		document.getElementById("moreContent3").style.display="block";
	}
	showBigAlertTip('','');
}
function handlCouponCJ(result){
	var items=eval("("+result.responseText+")").response.body.dataList;
	var item=items[0];
	document.getElementById("otherCount").innerHTML=item.cjCount;
	document.getElementById("otherCount1").innerHTML=item.cjCount;
}

function handlCoupon(result){
	var items=eval("("+result.responseText+")").response.body.dataList;
	var hreder=eval("("+result.responseText+")").response.header;
	var item=items[0];
	/*if(!item){
		window.location.href="../common/base/500.jsp";
		return;
	}*/
	if(hreder.rc==-9999){
		window.location.href="../common/base/500.jsp";
		return;
	}
	//�����鵽��Ʒ
	else if(hreder.rc==0){
		//�ж��Ƿ�Ϊʵ����ƷmoreContentProduct
		if(item.type==1){
			document.getElementById("alertClose_img").src="../dzdp/choujiangAlert3.png";
			document.getElementById("moreContentProduct").style.display="block";
			document.getElementById("moreContent").style.display="none";
			document.getElementById("moreContent1").style.display="none";
			document.getElementById("moreContent2").style.display="none";
			document.getElementById("moreContent3").style.display="none";
			document.getElementById("productDesc").innerHTML='<span style="font-size: 32px;color: #e31726;">��ϲ��!</span>'+'<br/>'+"���鵽�Ľ�Ʒ�ǡ�"+item.name+'��<div style="color:#ff0000; font-size:22px;">��ȷ���ֻ�����,�Է��㹤����Ա������ϵ!</div>';
			document.getElementById("a_other_Product").href="javascript:addRateProduct('"+item.deal_id+"');";
			document.getElementById("phone").value=item.phone;
		}
		else if(item.type==5){//���мӴ���
			document.getElementById("alertClose_img").src="../dzdp/choujiangAlert2.png";
		 	document.getElementById("alertWord").innerHTML='<font style="color: #e31726;">��ϲ��!</font> ��ö���3�γ齱����!';
			document.getElementById("moreContentProduct").style.display="none";
			document.getElementById("moreContent").style.display="none";
			document.getElementById("moreContent1").style.display="none";
			document.getElementById("moreContent2").style.display="none";
			document.getElementById("moreContent3").style.display="block";
		}
		else{
			document.getElementById("alertClose_img").src="../dzdp/choujiangAlert2.png";
			document.getElementById("moreContent").style.display="block";
			document.getElementById("moreContentProduct").style.display="none";
			document.getElementById("moreContent1").style.display="none";
			document.getElementById("moreContent2").style.display="block";
			document.getElementById("moreContent3").style.display="none";
			//document.getElementById('layer').innerHTML="item.id="+item.id;
			document.getElementById("a_other").href="itemDetail.jsp?dealId="+item.deal_id+"&itemIDS=[]&type=&"
					+"pageId="+pageId+"&funcId=6&itemId="+item.deal_id+"&itemType=0&from=cj";
		}
		showBigAlertTip('moreDetail','');
		setTimeout(function(){
			if(item.type==1){
				document.getElementById("a_other_Product").focus();
			}
			else{
				document.getElementById("a_other").focus();
			}
		},500);
	}
	else{
		//�齱����������
		 if(hreder.rc==1){
			 document.getElementById("alertWord").innerHTML="���ź��������ĳ齱����������!<br>�������Ŭ��.";
		 }
		 else if(hreder.rc==2){//��Ʒ���Ϊ0
		 	document.getElementById("alertWord").innerHTML="���ź����ѱ�����!";
		 }
		 else if(hreder.rc==3){//��Ʒ������
		 	document.getElementById("alertWord").innerHTML="���ź����ѱ�����!";
		 }
		document.getElementById("alertClose_img").src="../dzdp/choujiangAlert1.png";
		document.getElementById("moreContent").style.display="none";
		document.getElementById("moreContentProduct").style.display="none";
		document.getElementById("moreContent1").style.display="none";
		document.getElementById("moreContent2").style.display="none";
		document.getElementById("moreContent3").style.display="block";
		showBigAlertTip('moreDetail','');
	}
	//document.getElementById("otherCount").innerHTML=item.cjCount;
	//document.getElementById("otherCount1").innerHTML=item.cjCount;
	//�齱������1
	var itemId="";
	if(item){
		itemId=item.id;
	}
	var urlStr=escape(interfaceurl+"getCJ?mac=deciveId&isCJ=false");
	var ajax_url = Path+"clientUrlHandler.do?url="+urlStr
	+"&biType="+biFuncType+"&pageId="+pageId+"&funcId=6&funcContent="+itemId+",";
	if(item.type==1){
		ajax_url+="1";
	}
	var _ajaxObj = new AJAX_OBJ(ajax_url,handlCouponCJ);
	_ajaxObj.requestData();
}

var is=0;
function clear(){
	clearTimeout(timer);
	clearInterval(interval);
	interval=null;
	timer=null;
	iPanel.focus.display = 1;
	iPanel.focus.border = 1;
	iPanel.focus.defaultFocusColor = defaultFocusColor;
	
}
function showProduct(){
	document.getElementById("alertClose_img").src="../dzdp/choujiangAlert4.png";
	document.getElementById("moreWordDiv").style.display="none";
	document.getElementById("moreProductContentDiv").style.display="block";
	showBigAlertTip('moreProductContentDiv','');
}
if(typeof(iPanel)!='undefined'){
	var defaultFocusColor = iPanel.focus.defaultFocusColor;
	iPanel.focus.display = 0;
	iPanel.focus.border = 0;
	iPanel.focus.defaultFocusColor = "#FF0000";
}
</script>
<epg:body onload="init()" onunload="clear()" style="background-repeat:no-repeat;width:1280px;height:720px;" bgcolor='#000000'>

<!-- ����ͼƬ�Լ�ͷ��ͼƬ -->
<div id="main_div"  >
	<img src="../dzdp/choujiangBG.png"  border="0" width="1280" height="720" />
</div>
 <div id="layer" style="position:absolute;z-index:1000; width: 1200px; height: 40px;left: 0px;top: 90px;text-align: center;font-size: 14px;"></div>

	<!--�˳�-->
	<div style="position:absolute; left:1056px;top:303px;width:101px;height:101px;">
		<a id="back_a" onfocus="document.getElementById('back_img').src='../dzdp/choujiangBackFocus.png';" onblur="document.getElementById('back_img').src='../dzdp/dot.png';" href="module.jsp?module=choujiang">
		<img id="back_img" width="101" height="101" src="../dzdp/dot.png" border="0"></a>
	</div>
	<!--��ʼgo-->
	<div id="rotate_a" style="position:absolute; left:810px;top:408px;width:146px;height:147px;">
		<a id="starta" onfocus="document.getElementById('choujiang_go').src='../dzdp/choujiangGO.png';" onblur="document.getElementById('choujiang_go').src='../dzdp/dot.png';" href="javascript:doRotate();">
		<img id="choujiang_go" width="146" height="147" src="../dzdp/dot.png" border="0"></a>
	</div>
	<!--��Ʒ��Ϣ-->
	<div style="position:absolute; left: 1039px;top: 471px;width: 134px;height: 134px;">
		<a id="product_a" onclick="showProduct();return false;" onfocus="document.getElementById('pro_img').src='../dzdp/btn_product.png';" onblur="document.getElementById('pro_img').src='../dzdp/dot.png';" href="#">
		<img id="pro_img" width="134" height="134" src="../dzdp/dot.png" border="0"></a>
	</div>
	<!--����-->
	<div style="position:absolute; left:292px;top:280px;width:200px;height:200px;">
		<img id="img" width="200" height="200" src="../dzdp/z0.png" border="0">
	</div>
	<div style="position:absolute;left: 680px;top: 308px;width: 200px;">
		<span style="position:absolute;font-size: 26px;color: #ffffff;left: 0;top: 5px;width: 480px;">������</span>
		<span id="otherCount1" style="position:absolute;font-size: 36px;color: #ff6000;left: 95px;top: 0px;width: 480px;/* color: #f00000; */"></span>
		<span style="position:absolute;font-size: 26px;color: #ffffff;left: 126px;top: 5px;width: 350px;">����ѳ齱����!</span>
	</div>

<div id="bigMoreAlert_div" style="position:absolute;left:0px; top:0px; display:none; width:1280px; height:720px;overflow:hidden;">
	<epg:img id="alertClose" src="/dzdp/choujiangAlert2.png" width="1280" height="720" />
	<div id="layer" style="position:absolute;z-index:10; width: 1200px; height: 40px;left: 0px;top: 150px;text-align: center;font-size: 30px; color:#ff0000;"></div>
	<div id="closeBigMoreAlert_div" align="left" style="position:absolute; left:940px;top:93px;width:82px;height:44px;">
	 	<a id="closeBigMoreAlert_a" href="#" onfocus="document.getElementById('closeBigMoreAlert_img').src='../dzdp/alertClose.png';" onblur="document.getElementById('closeBigMoreAlert_img').src='../dzdp/dot.gif';" onclick="closeAlertTip();return false;" style="width:82px;height:44px;">
			<img id="closeBigMoreAlert_img" src="../dzdp/dot.gif" border="0" width="82" height="44">
		</a>
	</div>
	<div id="moreTitle_div" align="left" style="position:absolute; left:238px;top:95px;width:136px;height:34px;">
 		
	</div>
	<div id="moreWordDiv" style="position:absolute;left: 305px; top: 440px; width: 770px; height: 170px;overflow:hidden;">
		<div id="moreContent" style="position: absolute; left: 0px; top: 0px; width: 200px; display: none;">
			<span style="position:absolute;font-size: 50px;color: #e31726;left: 0;top: 0px;">��ϲ��!</span>
			<span style="position:absolute;font-size: 30px;color: #000000; left:200px;width: 300px;top: 5px;">�鵽һ���Ź�ȯ</span>
			<a id="a_other" onfocus="document.getElementById('a_other_span').style.color='#ff6000';" onblur="document.getElementById('a_other_span').style.color='#999999';" href="itemDetail.jsp?id=-1&amp;itemIDS=&amp;type=" style="position: absolute;  font-size: 40px; color: #999999; left: 500px; width: 200px;  top: 7px; height:40px;">
				<img alt="" src="../dzdp/dot.png" width="200" height="40">
			</a>
			<span id="a_other_span" style="position: absolute;  font-size: 40px; color: #999999; left: 500px; width: 200px;  top: 5px; ">�鿴����</span>
		</div>
		<div id="moreContentProduct" style="position: absolute; left: 0px; top: 0px; width: 200px; display: block;">
			<div style="position:absolute;left: 240px;/* height: 35px; */">
				<input type="text" id="phone" value="" style="position: absolute;width: 300px;border: none;background: transparent;top: 0px;left: 0px;height: 35px;font-size: 30px;">
			</div>
			<span id="productDesc" style="position:absolute;font-size: 26px;color: #000000; left:0px;width: 670px;top: 41px;"><span style="font-size: 50px;color: #e31726;">��ϲ��!</span>���鵽�Ľ�Ʒ�� �ϼ�����ʿ���޷������¿����������,��ȷ���ֻ�����,�Է��㹤����Ա������ϵ!</span>
			<a id="a_other_Product" onfocus="document.getElementById('a_other_Product_img').src='../dzdp/btn_ok.png';" onblur="document.getElementById('a_other_Product_img').src='../dzdp/dot.png';" href="javascript:addRateProduct('-1');" style="position: absolute;  font-size: 40px; color: #999999; left: 551px; width: 117px;  top: -8px; height:48px;">
				<img id="a_other_Product_img" alt="" src="../dzdp/dot.png" width="117" height="48">
			</a>
		</div>
		<div id="moreContent1" style="position: absolute; left: 0px; top: 0px; width: 200px; display: none;">
			<span style="position:absolute;font-size: 50px;color: #000000;left: 0;top: 0px;width: 480px;">���ź���û���н�!</span>
			<a id="a_other1" onfocus="document.getElementById('a_other1_span').style.color='#ff6000';" onblur="document.getElementById('a_other1_span').style.color='#999999';" href="#" onclick="closeAlertTip();doRotate(); return false;" style="position: absolute;  font-size: 40px; color: #999999; left: 480px; width: 200px;  top: 5px;">
				<img alt="" src="../dzdp/dot.png" width="200" height="40">
			</a>
			<span id="a_other1_span" style="position: absolute;  font-size: 40px; color: #999999; left: 500px; width: 200px;  top: 5px; ">����һ��</span>
		</div>
		<div id="moreContent2" style="position: absolute; left: 0px; top: 70px; width: 200px; display: none;">
			<span style="position:absolute;font-size: 40px;color: #000000;left: 0;top: 5px;width: 480px;">�����ջ���</span>
			<span id="otherCount" style="position:absolute;font-size: 50px;color: #ff6000;left: 205px;top: 0px;width: 480px;">0</span>
			<span style="position:absolute;font-size: 40px;color: #000000;left: 233px;top: 5px;width: 350px;">�γ齱����!</span>
		</div>
		<div id="moreContent3" style="position: absolute; left: 0px; top: 0px; width: 200px; display: none;">
			<span id="alertWord" style="position:absolute;font-size: 50px;color: #000000;left: 0;top: 30px;width: 750px;text-align: left;">���ź��������ĳ齱����������!<br>�������Ŭ��.</span>
		</div>
	</div>
	<div id="moreProductContentDiv" style="position:absolute;left: 255px; top: 180px; width: 770px; height: 400px;overflow:hidden;">
	</div>
	
	<div id="notice" style="position:absolute;left:0px; top:0px; display:none; width:1280px; height:720px;overflow:hidden;">
	<epg:img id="noticeImg" src="/dzdp/choujiangAlert4.png" width="1280" height="720" />
	<div style="position:absolute;z-index:10; width: 1200px; height: 40px;left: 0px;top: 150px;text-align: center;font-size: 30px; color:#ff0000;">���Ѿ����˽�Ʒ���Ժ�ͷ�����ϵ�㣡</div>
	</div>
</div>
</epg:body>
</epg:html>