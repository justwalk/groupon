<%@page contentType="text/html; charset=gb2312" pageEncoding="UTF-8"%>
<%@taglib uri="http://chances.com.cn/jsp/epg" prefix="epg"%>
<%@ page language="java" import="sitv.epg.zhangjiagang.service.*,java.util.*" %>
<%@ page import="sitv.epg.business.*" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page language="java" import="org.springframework.web.context.WebApplicationContext,org.springframework.web.servlet.support.RequestContextUtils" %>
<%
		WebApplicationContext applicationContext = RequestContextUtils.getWebApplicationContext(request);
		LoginService loginService = (LoginService)applicationContext.getBean("loginService");
		
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("vmType","csdv");
		paramMap.put("stbType","hd");
		paramMap.put("entry","hdvod");
		boolean loginFlag = loginService.login(request,paramMap);
		String contextPath = request.getContextPath();
		if(loginFlag){
%>
<epg:html>
<meta name="login" content="login">
<head>
<script language="JavaScript">
function submit(){
	window.location.href = "<%=request.getContextPath()%>/index/hdvod.do";
}
</script>
</head>
<body bgcolor="#12141b" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="submit();">
</body>
</epg:html>
<%}%>