package first.test.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import first.test.vo.MemberVO;
 
public class LoginInterceptor extends HandlerInterceptorAdapter{
 
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        
//    	String userAgent = request.getHeader("User-Agent");
//    	System.out.println(userAgent);
        HttpSession session = request.getSession();
        MemberVO loginVO = (MemberVO) session.getAttribute("loginVO");
        

        if(loginVO == null){
            response.sendRedirect("/");
            return false;
        }

        
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
 
    
    
}
 