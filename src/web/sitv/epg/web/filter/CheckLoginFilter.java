/*
 * Copyright (c) 2011 by Chances.
 * $CVSHeader$
 * $Author$
 * $Date$
 * $Revision$
 */
package sitv.epg.web.filter;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
import org.apache.oro.text.perl.Perl5Util;
import org.springframework.beans.factory.annotation.Autowired;
import sitv.epg.business.EpgLogFactory;
import sitv.epg.business.dao.CategoryItemService;
import sitv.epg.entity.edit.EpgCategoryItem;
import sitv.epg.zhangjiagang.EpgUserSession;
import chances.epg.web.UserSession;

/**
 * 用于检查用户是否登录的过滤器. 
 * 如果检查到用户未登录，则将用户请求转向到登录页面。
 * 
 * @author <a href="mailto:libf@chances.com.cn">libf</a>
 */
public class CheckLoginFilter implements Filter {
	
    private String loginRedirectUrl; // 未登录转向页面链接

    private String loginSkipPattern; // 检查登录过滤条件
    
    protected Perl5Util perl;

    @Autowired
    protected CategoryItemService categoryItemService;

    /* (non-Javadoc)
     * @see javax.servlet.Filter#destroy()
     */
    public void destroy() {
        perl = null;
    }

    /* (non-Javadoc)
     * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest, javax.servlet.ServletResponse, javax.servlet.FilterChain)
     */
    public void doFilter(ServletRequest _request, ServletResponse _response,
            FilterChain chain) throws IOException, ServletException {
        if (perl == null) {
            perl = new Perl5Util();
        }
    }

    /* (non-Javadoc)
     * @see javax.servlet.Filter#init(javax.servlet.FilterConfig)
     */
    public void init(FilterConfig config) throws ServletException {
//        loginRedirectUrl = config.getInitParameter("loginRedirectUrl");
//        loginSkipPattern = config.getInitParameter("loginSkipPattern");
        perl = new Perl5Util();
    }
    
    
    private String createRedirectURL(HttpServletRequest request) throws IOException {
       return "";
    }
    
    private void logAccessLog(HttpServletRequest request, String curCat) {//HttpServletRequest request,int seq,String curCat
        
    }
    
    public String getLoginRedirectUrl() {
		return loginRedirectUrl;
	}

	public void setLoginRedirectUrl(String loginRedirectUrl) {
		this.loginRedirectUrl = loginRedirectUrl;
	}

	public String getLoginSkipPattern() {
		return loginSkipPattern;
	}

	public void setLoginSkipPattern(String loginSkipPattern) {
		this.loginSkipPattern = loginSkipPattern;
	}
    
    public static void main(String[] args) {
//    	for (int i = 0; i < 100; i++) {
//			System.out.println(RandomUtils.nextInt(100000));
//		}
    	String a = "/epg/biz/biz_88149754/cat/ccms_category_74215561/det/vod/program_imsp_544782.do";
    	String[] b = a.split("/");
    	String c = b[b.length-1];
    	String[] d = c.split(".do");
    	String e = d[0];
    	System.out.println(e);
    	boolean aa = StringUtils.isNotBlank("");
    	System.out.println(aa);
    	String[] refBiz = "ref=biz_60150362|null".split("ref=")[1].split("\\|");
    	System.out.println(refBiz[0]);
//    	System.out.println(a.split("&").length);
    }
}
