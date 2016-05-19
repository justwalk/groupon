function Gvent(code, args){
	this.code = code;
	this.args = args;
}

var iPanelReturnFlag = false;

//判断是否iPanel
if (typeof(iPanel) != 'undefined') {
	document.onsystemevent = grabEvent;
	document.onkeypress = grabEvent;
	document.onirkeypress = grabEvent;
}else{
	document.onkeydown = showKeyName;
}

function grabEvent()
{
	var retv = 1;
	var keycode = event.which;
	if(keycode < 58 && keycode > 40){//数字键
		var args = new Object();
		args.value = keycode - 48;
		eventHandler(new Gvent("KEY_NUMERIC", args));
		if(iPanelReturnFlag) return 1;
		//else return 0;
	}
	else if(keycode < 269 && keycode > 258){//数字键
		var args = new Object();
		args.value = keycode - 259;
		eventHandler(new Gvent("KEY_NUMERIC", args));
		if(iPanelReturnFlag) return 1;
		//else return 0;
	}
	else{
		var code = null;
		var args = new Object();
		args.modifiers = 0;
	    switch(keycode)
		{
	    	//NEWLAND中间键匹配值 begin
			case 38://up
				code = "EIS_IRKEY_UP";
				break;
			case 40://down
				code = "EIS_IRKEY_DOWN";
				break;
			case 37://left
				code = "EIS_IRKEY_LEFT";
				break;
			case 39://right
				code = "EIS_IRKEY_RIGHT";
				break;
	    	//NEWLAND中间键匹配值 end
			case 1://up
				code = "EIS_IRKEY_UP";
				break;
			case 2://down
				code = "EIS_IRKEY_DOWN";
				break;
			case 3://left
				code = "EIS_IRKEY_LEFT";
				break;
			case 4://right
				code = "EIS_IRKEY_RIGHT";
				break;
			case 832://red
				code = "EIS_IRKEY_RED";
				break;
			case 834://green
				code = "EIS_IRKEY_GREEN";
				break;
			case 835://blue
				code = "EIS_IRKEY_BLUE";
				break;
			case 833://yellow
				code = "EIS_IRKEY_YELLOW";
				break;
			case 13://select
				code = "EIS_IRKEY_SELECT";
				break;
			case 567://info
				code = "EIS_IRKEY_INFO";
				break;
			case 513:
				code = "EIS_IRKEY_MENU";
				iPanelReturnFlag = true;
				break;
			case 339://exit
				code = "EIS_IRKEY_EXIT";
				break;
			case 340://back
				code = "EIS_IRKEY_BACK";
				break;
			case 372://page up
				code = "EIS_IRKEY_PAGE_UP";
				break;
			case 373://page down
				code = "EIS_IRKEY_PAGE_DOWN";
				break;
			case 514://EPG
				code = "EIS_IRKEY_EPG";
				break;
			case 518://NVOD
				code = "EIS_IRKEY_NVOD";
				break;
			case 564://audio
				code = "EIS_IRKEY_AUDIO";
				break;
			case 570://喜爱键
				code = "EIS_IRKEY_FAVORITE";
				break;
			case 5551://cable线没有连接上的消息
				core = "EIS_CABLE_NETWORK_DISCONNECT";
				break;
			case 5550://插上cable线的消息
				core = "EIS_CABLE_NETWORK_CONNECT";
				break;
			case 8370://写flash完毕
				code = "EIS_DVB_FLASH_WRITE_FINISHED";
				break;
			case 5300://插入智能卡
				code = "EIS_CA_SMARTCARD_INSERT";
				break;
			case 5301://拔出智能卡
				code = "EIS_CA_SMARTCARD_EVULSION";
				break;
			case 8371://从flash中恢复数据到内存中完毕的消息。
				code = "EIS_DVB_DATA_RESTORE_SUCCESS";
				break;
		}
		if(code){
			retv = eventHandler(new Gvent(code, args));
			return retv;
		}
	}
}
//龙晶机顶盒按键监听
function showKeyName()
{
	var retv = 1;
	var keycode = event.keyCode;
	var code = null;
	var args = new Object();
	args.modifiers = 0;
    switch(keycode)
	{
		case 38://up
			code = "EIS_IRKEY_UP";
			break;
		case 40://down
			code = "EIS_IRKEY_DOWN";
			break;
		case 37://left
			code = "EIS_IRKEY_LEFT";
			break;
		case 39://right
			code = "EIS_IRKEY_RIGHT";
			break;
		case 13://select
			code = "EIS_IRKEY_SELECT";
			break;
		case 4://back
			code = "EIS_IRKEY_BACK";
			break;
		case 33://page up
			code = "EIS_IRKEY_PAGE_UP";
			break;
		case 34://page down
			code = "EIS_IRKEY_PAGE_DOWN";
			break;
	}
	if(code){
		retv = eventHandler(new Gvent(code, args));
		return retv;
	}
}