package first.test.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import first.test.service.MemberService;
import first.test.vo.MemberVO;

@Controller
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Inject
	private MemberService memberService;
	
	@RequestMapping("login")
	public String login(MemberVO loginVO, HttpServletRequest request, Model model) throws Exception {

		MemberVO resultVO = new MemberVO();

		resultVO = memberService.login(loginVO);

		if (resultVO != null && !resultVO.getUserId().equals("") && !resultVO.getUserPass().equals("")) {
			switch (resultVO.getIsUsing()) {
			case 'Y':				
				request.getSession().setAttribute("loginVO", resultVO);
				break;
			case 'N':
				model.addAttribute("msg", "미사용 회원이니, 관리자에게 문의하세요.");
				return "/home";
			}
			

			return "redirect:/list";

		} else {

			model.addAttribute("msg", "사용자의 ID 혹은 패스워드가 일치하지 않습니다.");

			return "/home";

		}
	}
	
	@RequestMapping("logout")
	public String logout(MemberVO loginVO, HttpServletRequest request, Model model) {
//		request.getSession().removeAttribute("loginVO");
		request.getSession().invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "MemberJoin", method = RequestMethod.GET)
	public void join() {
		
	}
	
	@RequestMapping(value = "MemberJoin", method = RequestMethod.POST)
	public String joinAction(MemberVO vo, @RequestParam("pass2") String pass2, Model model){
		
		if(vo.getUserPass().equals(pass2)) {	
			try {
				vo.setUserId(vo.getUserId().trim());
				vo.setUserName(vo.getUserId().trim());
				memberService.register(vo);
				model.addAttribute("msg", "회원가입 성공 !");
			} catch (Exception e) {
				model.addAttribute("msg", "회원가입 실패. 다시 시도해주세요.");
			}
			
		}
		else {
			model.addAttribute("msg", "회원가입 실패. 패스워드가 일치하지 않습니다.");
		}
		
		
		return "/home";
	}
	
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	public @ResponseBody String idCheck(String userId) {
		int tmp;
		try {
			tmp = memberService.idCheck(userId.trim());
		} catch(Exception e) {
//			System.out.println(e.toString());
			tmp = 1;
		}
		return tmp+"";
	}
	
	@RequestMapping(value = "/nameCheck", method = RequestMethod.POST)
	public @ResponseBody String nameCheck(String userName) {
		int tmp;
		try {
			tmp = memberService.nameCheck(userName.trim());
		} catch(Exception e) {
//			System.out.println(e.toString());
			tmp = 1;
		}
		return tmp+"";
	}
}
