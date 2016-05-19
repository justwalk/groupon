package sitv.epg.web.context;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;

import sitv.epg.zhangjiagang.EpgUserSession;

import chances.epg.log.EpgLogFactory;

public class EpgHelper {
	
	public static String[] getHeaders(HttpServletRequest httpRequest) {
		String hs = httpRequest.getHeader(EpgUserSession.headerName);
		if (hs == null) {
			hs = httpRequest.getHeader("FieldName");
		}		
		if (hs == null){
			hs = "STB_MODEL=DVT-6020EU-NDS,NET_IP=10.65.73.101,STB_MAC=00264c50fb0f,NET_ID=0002";
		}
		String[] items = hs.split(",");
		String[] result = new String[4];
		for(int i=0;i<items.length;i++){
			if (items[i].startsWith("STB_MODEL")){
				result[0] = items[i].substring(items[i].indexOf("=")+1);
				
				//userSession.setStbModel(items[i].substring(items[i].indexOf("=")+1));
			}else if (items[i].startsWith("NET_IP")){
				result[1] = items[i].substring(items[i].indexOf("=")+1);
			}else if (items[i].startsWith("STB_MAC")){
				result[2] = items[i].substring(items[i].indexOf("=")+1);
				//userSession.setStbMac(items[i].substring(items[i].indexOf("=")+1));
			}else if (items[i].startsWith("NET_ID")){
				result[3] = items[i].substring(items[i].indexOf("=")+1);
				//userSession.setNetId(items[i].substring(items[i].indexOf("=")+1));
			}
		}
		return result;
	}
}
