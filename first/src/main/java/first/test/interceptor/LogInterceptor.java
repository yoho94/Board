package first.test.interceptor;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.web.savedrequest.Enumerator;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import first.test.service.UserAgentService;
import first.test.vo.MemberVO;
import first.test.vo.UserAgentVO;
import uap_clj.java.api.Browser;
import uap_clj.java.api.Device;
import uap_clj.java.api.OS;
 
public class LogInterceptor extends HandlerInterceptorAdapter{
	@Inject
	private UserAgentService uaService;
	
	private static final String VERSION_SEPARATOR = ".";
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception { 
    	
    	//test
//    	Enumeration enu = request.getAttributeNames();    	
//    	System.out.println(enu.toString());
    	//test

    	Map<String, Object> dataMap = new HashMap<>();
    	String path = request.getServletPath();
    	String ip = getIp(request);
    	String userAgent = request.getHeader("User-Agent");
    	String referer = request.getHeader("Referer");
    	
//    	if(path.indexOf(".ajax") > 0 || path.indexOf(".action") > 0) {
//    		return true;
//    	}
    	
    	userAgentParsingToMap(userAgent, dataMap);
//    	System.out.println(userAgent);
//    	System.out.println("path : "+ path);
//    	System.out.println("ip : " + ip);
//    	System.out.println("UA : " + dataMap.toString());
//    	System.out.println("referer : " + referer);
    	
    	UserAgentVO vo = new UserAgentVO();    	
    	vo.setUA(dataMap);
    	vo.setPath(path);
    	vo.setIp(ip);
    	vo.setReferer(referer);
//    	Locale locale = InetAddressLocator.getLocale(ip);
//    	vo.setCountryCode(locale.getCountry());
    	
        HttpSession session = request.getSession();
        MemberVO loginVO = (MemberVO) session.getAttribute("loginVO");        

        if(loginVO != null){
            vo.setId(loginVO.getUserId());
        }
    	
    	uaService.insert(vo);


        
        return true;
    }
 
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
        // TODO Auto-generated method stub
        super.postHandle(request, response, handler, modelAndView);
    }
 
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        // TODO Auto-generated method stub
        super.afterCompletion(request, response, handler, ex);
    }
    
    private String getIp(HttpServletRequest request) {
    	// https://kkumalog.tistory.com/73
    	String ip = request.getHeader("X-FORWARDED-FOR"); 
    	if (ip == null || ip.length() == 0) { 
    		ip = request.getHeader("Proxy-Client-IP"); 
    	}
    	if (ip == null || ip.length() == 0) { 
    		ip = request.getHeader("WL-Proxy-Client-IP");
    	}
    	if (ip == null || ip.length() == 0) { 
    		ip = request.getHeader("HTTP_CLIENT_IP");
    	}
    	if (ip == null || ip.length() == 0) { 
    		ip = request.getRemoteAddr(); 
    	}
    	
    	return ip;
    }
    
    private void userAgentParsingToMap(String userAgent, Map<String, Object> dataMap) {
        HashMap browser = Browser.lookup(userAgent);
//        System.out.println(browser.toString());
        HashMap os = OS.lookup(userAgent);
//        System.out.println(os.toString());
        HashMap device = Device.lookup(userAgent);
//        System.out.println(device.toString());

        dataMap.put("browserName", browser.get("family"));
        dataMap.put("browserVersion", getVersion(browser));
        dataMap.put("osName", os.get("family"));
        dataMap.put("osVersion", getVersion(os));
        dataMap.put("deviceModel", device.get("model"));
        dataMap.put("deviceBrand", device.get("brand"));

    }

    private String getVersion(HashMap dataMap) {
        String majorVersion = (String)dataMap.get("major");
        if (StringUtils.isEmpty(majorVersion)) {
            return StringUtils.EMPTY;
        }
        String minorVersion = (String)dataMap.get("minor");
        String pathVersion = (String)dataMap.get("path");

        StringBuffer sb = new StringBuffer();
        sb.append(majorVersion);
        if (!StringUtils.isEmpty(minorVersion)) {
            sb.append(VERSION_SEPARATOR);
            sb.append(minorVersion);
        }
        if (!StringUtils.isEmpty(pathVersion)) {
            sb.append(VERSION_SEPARATOR);
            sb.append(pathVersion);
        }

        return sb.toString();
    }
 
    
    
}
 