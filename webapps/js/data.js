/**
 * 接口地址
 */
//var interfaceurl = "http://211.167.111.39:35/EPG_Api/api/";
var interfaceurl = "http://192.168.1.211/EPG_Api/api/";
var getGrouponCategorys="getGrouponCategory";//团购券获取所有分类信息
var getCouponCategorys="getCouponCategory";//优惠券获取所有分类信息
var getGroupon="getGroupon";//团购券获取商品列表信息
var getCoupon="getCoupon";//优惠券获取商品列表信息
var getGrouponDetail="getGrouponDetail";//团购券商品明细
var getCouponDetail="getCouponDetail";//优惠券商品明细
var getGrouponHotSearch="getGrouponHotSearch";//团购券热门搜索
var getCouponHotSearch="getCouponHotSearch";//优惠券热门搜索
var saveRegion="saveRegion";//保存商圈设置(未使用) 
var getDistrictByCity="getDistrictByCity";//根据市ID查找下属所有区县
var getRegionByDistrict="getRegionByDistrict";//根据区县ID查找下属所有商圈
var getCity="getCity";//根据配置文件读取可选市级
var getMacInfo="getMacInfo";//根据MAC获得设置的商圈名字以及电话
var getObject="getObject";//查询八大专题
var getObjectGroupon="getObjectGroupon";//根据专题ID查询下属商品列表
var saveFavorite="saveFavorite";//添加/取消收藏商品
var getFavorite="getFavorite";//获得收藏夹商品
var getLuckDrawInit="getLuckDrawInit";//在抽奖前获取抽奖初始化信息
var getLuckDrawGoods="getLuckDrawGoods";//判断抽奖次数&根据抽奖id获取奖品信息
var saveLuckDrawInfo="saveLuckDrawInfo";//将电话号码置入盒子表，添加抽奖记录，更新商品表
var biPageType="1";//bi类型
var biFuncType="2";
var biItemType="3";
/**
 * 验证手机号码
 */
function isPhone(phone) {
	var phoneNo = "no-" + phone;
	return (phoneNo.indexOf("no-13") > -1 || phoneNo.indexOf("no-15") > -1 || phoneNo
			.indexOf("no-18") > -1)
			&& phone.length == 11;
}

// 截字
function subString(str, len, hasDot) {
	var newLength = 0;
	var newStr = "";
	var chineseRegex = /[^\x00-\xff]/g;
	var singleChar = "";
	var strLength = str.replace(chineseRegex, "*").length;
	for (var i = 0; i < strLength; i++) {
		singleChar = str.charAt(i).toString();
		if (singleChar.match(chineseRegex) != null) {
			newLength += 2;
		} else {
			newLength++;
		}
		if (newLength > len) {
			break;
		}
		newStr += singleChar;
	}
	if (hasDot && strLength > len) {
		newStr += "...";
	}
	return newStr;
}
String.prototype.replaceAll = function(s1, s2) {
	return this.replace(new RegExp(s1, "gm"), s2);
}
function UnicodeToUTF8(strInUni) {
	if (null == strInUni)
		returnnull;
	var strUni = String(strInUni);
	var strUTF8 = String();
	for (var i = 0; i < strUni.length; i++) {
		var wchr = strUni.charCodeAt(i);
		if (wchr < 0x80) {
			strUTF8 += strUni.charAt(i);
		} else if (wchr < 0x800) {
			var chr1 = wchr & 0xff;
			var chr2 = (wchr >> 8) & 0xff;
			strUTF8 += String.fromCharCode(0xC0 | (chr2 << 2)
					| ((chr1 >> 6) & 0x3));
			strUTF8 += String.fromCharCode(0x80 | (chr1 & 0x3F));
		} else {
			var chr1 = wchr & 0xff;
			var chr2 = (wchr >> 8) & 0xff;
			strUTF8 += String.fromCharCode(0xE0 | (chr2 >> 4));
			strUTF8 += String.fromCharCode(0x80 | ((chr2 << 2) & 0x3C)
					| ((chr1 >> 6) & 0x3));
			strUTF8 += String.fromCharCode(0x80 | (chr1 & 0x3F));
		}
	}
	return strUTF8;
}
String.prototype.startWith = function(compareStr){
	return this.indexOf(compareStr) == 0;
}
function setCookie(name,value)
{
    var Days = 30;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

//读取cookies
function getCookie(name)
{
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
 
    if(arr=document.cookie.match(reg))
 
        return (arr[2]);
    else
        return null;
}
function getsec(str)
{
   //alert(str);
   var str1=str.substring(1,str.length)*1;
   var str2=str.substring(0,1);
   if (str2=="s")
   {
        return str1*1000;
   }
   else if (str2=="h")
   {
       return str1*60*60*1000;
   }
   else if (str2=="d")
   {
       return str1*24*60*60*1000;
   }
}