package first.test.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import first.test.service.BoardService;
import first.test.service.MemberService;
import first.test.vo.BoardVO;
import first.test.vo.MemberVO;
import first.test.vo.PageMaker;
import first.test.vo.SearchCriteria;


/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Inject
	private BoardService service;
	@Inject
	private MemberService memberService;

	@RequestMapping("/")
	public String home1() {
		return "home";
	}
	
	@RequestMapping("/home")
	public void home2() {
	}
	
	@RequestMapping("login")
	public String login(MemberVO loginVO, HttpServletRequest request, Model model) throws Exception {

		MemberVO resultVO = new MemberVO();

		resultVO = memberService.login(loginVO);

		if (resultVO != null && !resultVO.getUserId().equals("") && !resultVO.getUserPass().equals("")) {

			request.getSession().setAttribute("loginVO", resultVO);

			return "redirect:/list";

		} else {

			model.addAttribute("msg", "사용자의 ID 혹은 패스워드가 일치하지 않습니다.");

			return "/home";

		}
	}
	
	@RequestMapping("logout")
	public String logout(MemberVO loginVO, HttpServletRequest request, Model model) {
		request.getSession().removeAttribute("loginVO");
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "MemberJoin", method = RequestMethod.GET)
	public void join() {
		
	}
	
	@RequestMapping(value = "MemberJoin", method = RequestMethod.POST)
	public String joinAction(MemberVO vo, @RequestParam("pass2") String pass2, Model model){
		
		if(vo.getUserPass().equals(pass2)) {	
			try {
				memberService.register(vo);
				model.addAttribute("msg", "회원가입 성공 !");
			} catch (Exception e) {
				model.addAttribute("msg", "회원가입 실패. 빈 값이 있습니다.");
			}
			
		}
		else {
			model.addAttribute("msg", "회원가입 실패. 패스워드가 일치하지 않습니다.");
		}
		
		
		return "/home";
	}

	@RequestMapping(value = "/list")
	public void listPage(@ModelAttribute("pvo") SearchCriteria pvo, Model model) throws Exception {
		System.out.println("list pvo: " + pvo);
		model.addAttribute("list", service.listSearch(pvo));

		PageMaker pageMaker = new PageMaker();
		pageMaker.setPvo(pvo);

		pageMaker.setTotalCount(service.listSearchCount(pvo));
		System.out.println("ctrl" + service.listSearch(pvo));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	@RequestMapping(value = "/readPage" , method = RequestMethod.POST)
	public void readPage(@ModelAttribute("pvo") SearchCriteria pvo, @RequestParam("bno") int bno, Model model) throws Exception{
		BoardVO vo = service.read(bno);
		service.updateViewcnt(bno);
		
		model.addAttribute("boardVO", vo);
	}
	
	@RequestMapping(value = "/writePage", method = RequestMethod.POST)
	public void writePage(@ModelAttribute("pvo") SearchCriteria pvo, Model model) {
		
	}
	
	@RequestMapping(value = "/writePageAction", method = RequestMethod.POST)
	public String writePageAction(BoardVO vo) throws Exception {
		service.regist(vo);
		
		return "redirect:/list";
	}
	
	@RequestMapping(value = "/removeAction", method = RequestMethod.POST)
	public String removeAction(@RequestParam("bno") int bno, SearchCriteria pvo, RedirectAttributes rttr) throws Exception{
		service.remove(bno);
		
		rttr.addAttribute("page", pvo.getPage());
		rttr.addAttribute("perPageNum", pvo.getPerPageNum());
		rttr.addAttribute("searchType", pvo.getSearchType());
		rttr.addAttribute("keyword", pvo.getKeyword());
		
		return "redirect:/list";
	}
	
	@RequestMapping(value = "/modifyPage", method = RequestMethod.POST)
	public void modifyPage(@ModelAttribute("boardVO") BoardVO vo, @ModelAttribute("pvo") SearchCriteria pvo) {
		
	}
	
	@RequestMapping(value = "/modifyPageAction", method = RequestMethod.POST)
	public String modifyPageAction(BoardVO board, SearchCriteria pvo, RedirectAttributes rttr) throws Exception {
		service.modify(board);
		
		rttr.addAttribute("page", pvo.getPage());
		rttr.addAttribute("perPageNum", pvo.getPerPageNum());
		rttr.addAttribute("searchType", pvo.getSearchType());
		rttr.addAttribute("keyword", pvo.getKeyword());
		
		return "redirect:/list";
	}
	
	@RequestMapping(value = "/reRegister", method = RequestMethod.POST)
	public void reRegister(@ModelAttribute("oBoardVO")BoardVO vo, @ModelAttribute("pvo") SearchCriteria pvo) {
		
	}
	
	@RequestMapping(value = "/reRegisterAction", method = RequestMethod.POST)
	public String reRegisterAction(@RequestParam("obno") int obno, BoardVO vo, SearchCriteria pvo, RedirectAttributes rttr) throws Exception {
		service.reRegist(vo, obno);
		
		rttr.addAttribute("page", pvo.getPage());
		rttr.addAttribute("perPageNum", pvo.getPerPageNum());
		rttr.addAttribute("searchType", pvo.getSearchType());
		rttr.addAttribute("keyword", pvo.getKeyword());
		
		return "redirect:/list";
	}


}
