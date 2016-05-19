<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://chances.com.cn/jsp/epg" prefix="epg"%>
<%@ page language="java" import="java.util.*,sitv.epg.zhangjiagang.*,chances.epg.utils.*" %>
<%
EpgUserSession eus = EpgUserSession.findUserSession(request);
eus.setEntry("hdvod");
//String bizCode="biz_01729755";
//String bizCode="biz_52329300";
//String bizCode="biz_10629687";
//String bizCode="biz_60374177";
//String bizCode="biz_99359049";
//String bizCode="biz_27530316";
String contextPath = request.getContextPath();
if ("/".equals(contextPath)){
	contextPath = "";
}
String fixparams = EpgUserSession.createFixUrlParams(request);

String url = new StringBuffer().append(contextPath).append("/pages/index").append(".jsp?").append(fixparams).toString();
response.sendRedirect(url);
%>

