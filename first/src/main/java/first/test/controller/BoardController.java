package first.test.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.nhncorp.lucy.security.xss.XssPreventer;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

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
			System.out.println(e.toString());
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
			System.out.println(e.toString());
			tmp = 1;
		}
		return tmp+"";
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
		
		if(pvo.getPage() == 1) {
			BoardVO notice = service.readNotice();
			model.addAttribute("noticeVO", notice);
		}
	}
	
	@RequestMapping(value = "/readPage" , method = RequestMethod.POST)
	public void readPage(@ModelAttribute("pvo") SearchCriteria pvo, @RequestParam("bno") int bno, Model model) throws Exception{
		BoardVO vo = service.read(bno);
		service.updateViewcnt(bno);
		
		String clean = XssPreventer.escape(vo.getTitle());
		vo.setTitle(clean);
//		System.out.println(clean);
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
	
	@RequestMapping(value = "/adminRemoveAction", method = RequestMethod.POST)
	public String adminRemoveAction(@RequestParam("bno") int bno, SearchCriteria pvo, RedirectAttributes rttr) throws Exception{
		service.remove(bno);
		
		rttr.addAttribute("page", pvo.getPage());
		rttr.addAttribute("perPageNum", pvo.getPerPageNum());
		rttr.addAttribute("searchType", pvo.getSearchType());
		rttr.addAttribute("keyword", pvo.getKeyword());
		
		return "redirect:/adminPage";
	}
	
	@RequestMapping(value = "/realRemoveAction", method = RequestMethod.POST)
	public String realRemoveAction(BoardVO vo, SearchCriteria pvo, RedirectAttributes rttr) throws Exception {
		service.realDelete(vo);
		
		rttr.addAttribute("page", pvo.getPage());
		rttr.addAttribute("perPageNum", pvo.getPerPageNum());
		rttr.addAttribute("searchType", pvo.getSearchType());
		rttr.addAttribute("keyword", pvo.getKeyword());
		
		return "redirect:/adminPage";
	}
	
	@RequestMapping(value = "/restore", method = RequestMethod.POST)
	public String restore(BoardVO vo, SearchCriteria pvo, RedirectAttributes rttr) throws Exception {
		service.restore(vo.getBno());
		
		rttr.addAttribute("page", pvo.getPage());
		rttr.addAttribute("perPageNum", pvo.getPerPageNum());
		rttr.addAttribute("searchType", pvo.getSearchType());
		rttr.addAttribute("keyword", pvo.getKeyword());
		
		return "redirect:/adminPage";
	}
	
	@RequestMapping(value = "/modifyPage", method = RequestMethod.POST)
	public void modifyPage(@ModelAttribute("boardVO") BoardVO vo, @ModelAttribute("pvo") SearchCriteria pvo) {
		String clean = XssPreventer.escape(vo.getTitle());
		vo.setTitle(clean);
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
		String clean = XssPreventer.escape(vo.getTitle());
		vo.setTitle(clean);
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
	
	@RequestMapping(value = "/modal")
	public void modal(Model model) throws Exception{
		BoardVO notice = service.readNotice();
		model.addAttribute("noticeVO", notice);
	}
	
	@RequestMapping("/imgUp")
	public void doImgUp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int maxRequestSize = 1024 * 1024 * 50;
		
		request.setCharacterEncoding("UTF-8");
		String path = "/resources/upload"; // 개발자 지정 폴더
//		String real_save_path = "D:/upload";
		String real_save_path = request.getSession().getServletContext().getRealPath(path);	
		
		File Folder = new File(real_save_path);
		System.out.println(real_save_path);

		// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
		if (!Folder.exists()) {
			try {
				Folder.mkdir(); // 폴더 생성합니다.
				System.out.println("폴더가 생성되었습니다.");
			} catch (Exception e) {
				e.getStackTrace();
			}
		} else {
			System.out.println("이미 폴더가 생성되어 있습니다.");
		}
		
		MultipartRequest multi = new MultipartRequest(request, real_save_path, maxRequestSize, "UTF-8", new DefaultFileRenamePolicy());
		String fileName = multi.getOriginalFileName("upload"); // ckeditor5 static const
		JSONObject outData = new JSONObject();
		outData.put("uploaded", true);
		outData.put("url", request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/" + fileName);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(outData.toString());

	}
	
	
	@RequestMapping(value="/common/error{error_code}.do")
    public ModelAndView error(HttpServletRequest request, @PathVariable String error_code) {
        ModelAndView mv = new ModelAndView("/error");
        String msg = (String) request.getAttribute("javax.servlet.error.message"); 
         
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("STATUS_CODE", request.getAttribute("javax.servlet.error.status_code"));
        map.put("REQUEST_URI", request.getAttribute("javax.servlet.error.request_uri"));
        map.put("EXCEPTION_TYPE", request.getAttribute("javax.servlet.error.exception_type"));
        map.put("EXCEPTION", request.getAttribute("javax.servlet.error.exception"));
        map.put("SERVLET_NAME", request.getAttribute("javax.servlet.error.servlet_name"));
         
        try {
            int status_code = Integer.parseInt(error_code);
            switch (status_code) {
            case 400: msg = "잘못된 요청입니다."; break;
            case 403: msg = "접근이 금지되었습니다."; break;
            case 404: msg = "페이지를 찾을 수 없습니다."; break;
            case 405: msg = "요청된 메소드가 허용되지 않습니다."; break;
            case 500: msg = "서버에 오류가 발생하였습니다."; break;
            case 503: msg = "서비스를 사용할 수 없습니다."; break;
            default: msg = "알 수 없는 오류가 발생하였습니다."; break;
            }
        } catch(Exception e) {
            msg = "기타 오류가 발생하였습니다.";
        } finally {
            map.put("MESSAGE", msg);
        }         

        mv.addObject("error", map);
        return mv;
    }
	
	@RequestMapping(value ="/adminPage")
	public String adminPage(HttpServletRequest request, Model model, @ModelAttribute("pvo") SearchCriteria pvo) throws Exception {
        HttpSession session = request.getSession();
        MemberVO loginVO = (MemberVO) session.getAttribute("loginVO"); 

        if(loginVO.getIsAdmin() != 1){
        	model.addAttribute("msg", "관리자만 접근 가능합니다.");
        	return "/home";
        }
        
		model.addAttribute("list", service.listSearch(pvo));

		PageMaker pageMaker = new PageMaker();
		pageMaker.setPvo(pvo);

		pageMaker.setTotalCount(service.listSearchCount(pvo));
		model.addAttribute("pageMaker", pageMaker);
		
//		BoardVO notice = service.readNotice();
//		model.addAttribute("noticeVO", notice);
        
        return "/adminPage";
	}

}
