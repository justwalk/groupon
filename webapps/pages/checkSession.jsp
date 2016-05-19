<%
	if(session.getAttribute("mac")==null){
		String mac = (String)request.getParameter("mac");
		String uri ="";
		if(mac!=null){
			session.setAttribute("mac",mac);
		}
		uri = request.getRequestURI();
		String queryString = request.getQueryString();
		if(queryString==null){
			uri=uri+"?r=1";
		}else{
			uri=uri+"?"+queryString;
		}
%>
<epg:html>
	<meta name="login" content="login">
	<head>
	<script language="JavaScript">
		var mac = "00264c50fb0f";//取不到mac默认值
		function submit(){
			try{
				mac=hardware.STB.serialNumber;
			}catch(err){
			}
			var uri= '<%= uri %>';
			if(uri.indexOf("mac=")!=-1){
				window.location.href = "<%= uri %>"
			}else{
				window.location.href = "<%= uri %>&mac="+mac;
			}
		}
	</script>
	</head>
	<body bgcolor="#12141b" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="submit();">
	</body>
	</epg:html>
<% 	
	}
%>
