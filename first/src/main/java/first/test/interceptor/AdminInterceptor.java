package first.test.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import first.test.vo.MemberVO;

public class AdminInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		MemberVO loginVO = (MemberVO) session.getAttribute("loginVO");
		Boolean isAdminLogin = (Boolean) session.getAttribute("isAdminLogin");
		
//		System.out.println(loginVO);
//		System.out.println(isAdminLogin);
		
		if (loginVO.getIsAdmin() != 1) {
			response.sendRedirect("/list");
			return false;
		} else if (isAdminLogin == null || !isAdminLogin) {
			response.sendRedirect("/admin/login");
			return false;
		}
		
		return true;
	}

}
