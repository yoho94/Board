package first.test.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.nhncorp.lucy.security.xss.XssPreventer;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import first.test.service.BoardArticleService;
import first.test.service.BoardBoardService;
import first.test.service.PopupService;
import first.test.service.ReplyService;
import first.test.vo.BoardArticleVO;
import first.test.vo.BoardBoardVO;
import first.test.vo.MemberVO;
import first.test.vo.PageMaker;
import first.test.vo.ReplyVO;
import first.test.vo.SearchCriteria;


/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/board")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Inject
	private BoardBoardService boardService;
	@Inject
	private BoardArticleService service;
	@Inject
	private ReplyService repService;
	@Inject
	private PopupService popupService;

	@RequestMapping("/sidenav")
	public String getSidenav() throws Exception {
		return "/board/sidenav";
	}
	
	@RequestMapping("/sidenavList")
	public String getSidenavList(Model model, Integer page, Integer perPageNum, String searchType, String keyword) throws Exception {
		SearchCriteria pvo = new SearchCriteria(searchType, keyword);
		pvo.setPage(page);
		pvo.setPerPageNum(perPageNum);
		
		model.addAttribute("list", boardService.selectUserBoardList(pvo));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setPvo(pvo);
		pageMaker.setTotalCount(boardService.selectUserBoardListTotCnt());		
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("pvo", pvo);
		
		return "/board/sidenavList";
	}
	
	@RequestMapping(value = "/list")
	public String getBoardMainList(Model model, @ModelAttribute("pvo") SearchCriteria pvo,
			HttpServletResponse response, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		MemberVO loginVO = (MemberVO) session.getAttribute("loginVO");
		
		model.addAttribute("list", service.selectMainReadList(loginVO, pvo));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setPvo(pvo);

		pageMaker.setTotalCount(service.selectMainReadListTotCnt(loginVO, pvo));
		model.addAttribute("pageMaker", pageMaker);

		if (pvo.getPage() == 1) {
			List<BoardArticleVO> baList = service.selectMainNoticeList(loginVO);
			if(baList != null && baList.size() > 0) {
				model.addAttribute("noticeVO", baList.get(0));
				model.addAttribute("noticeVOList", baList);
			}
			
			// 팝업 띄우기
			model.addAttribute("popupList", popupService.mainPopupList());
		}
		
		return "/board/list";
	}
	
	@RequestMapping(value = "/readPage", method = RequestMethod.POST)
	public String articleMainReadPage(Model model, BoardArticleVO vo, String pw,
			@ModelAttribute("pvo") SearchCriteria pvo,
			@ModelAttribute("showType") String showType,
			HttpServletResponse response, HttpServletRequest request) throws Exception {
		BoardArticleVO articleVO = service.selectArticle(vo);
		Character isSecret = articleVO.getIsSecret();		
		
		if(isSecret != null && isSecret == 'Y') {
			boolean pwMatches = false;
			BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder(10);
			pwMatches = pwEncoder.matches(pw, articleVO.getPassword());
			
			if(!pwMatches) {
				response.setContentType("text/html; charset=UTF-8");			 
				PrintWriter out = response.getWriter();			 
				out.println("<script>alert('비밀번호 불일치.'); self.opener = self; window.close();</script>");			 
				out.flush();
				
				return "redirect:/board/list";
			}
		}
		
		BoardBoardVO boardVO = new BoardBoardVO();
		boardVO.setBoardId(articleVO.getBoardId());
		boardVO = boardService.selectBoard(boardVO);
		String boardType = boardVO.getBoardType();
		model.addAttribute("boardVO", boardVO);
		
		service.updateViewcnt(articleVO.getBno());
		if(boardType.equals("notice")) {
			HttpSession session = request.getSession();
			MemberVO loginVO = (MemberVO) session.getAttribute("loginVO");
			service.insertReadTbl(loginVO, articleVO);		
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setPvo(pvo);

			pageMaker.setTotalCount(service.selectMainReadListTotCnt(loginVO, pvo));
			model.addAttribute("pageMaker", pageMaker);
		}		
		
		String clean = XssPreventer.escape(vo.getTitle());
		vo.setTitle(clean);
		model.addAttribute("articleVO", articleVO);
		
		return "/board/" + boardType + "/readPage";
	}
	
	@RequestMapping(value = "/{boardType}/{url}/list")
	public String getBoardList(Model model, @ModelAttribute("pvo") SearchCriteria pvo,
			HttpServletResponse response, HttpServletRequest request, 
			@RequestParam(value = "showType", defaultValue = "default") String showType,
			@PathVariable String boardType,	@PathVariable String url) throws Exception {
		
		BoardBoardVO urlBoardVO = new BoardBoardVO();
		urlBoardVO.setUrl(url);
		BoardBoardVO boardVO = boardService.selectUrlBoard(urlBoardVO);
		model.addAttribute("boardVO", boardVO);
		
		if(boardVO.getIsUse() != 'Y') {
			response.setContentType("text/html; charset=UTF-8");			 
			PrintWriter out = response.getWriter();			 
			out.println("<script>alert('사용 불가 게시판입니다.'); location.href='/board/list';</script>");			 
			out.flush();
		}
		
		if (boardType.equals("notice")) {
			HttpSession session = request.getSession();
			MemberVO loginVO = (MemberVO) session.getAttribute("loginVO");
			Integer readListTotCnt = service.selectReadListTotCnt(loginVO, boardVO ,pvo);
			
			model.addAttribute("readListTotCnt", readListTotCnt);
			model.addAttribute("showType", showType);
			if(showType.equals("default")) {				
				model.addAttribute("list", service.selectReadList(loginVO, boardVO, pvo));
				
				PageMaker pageMaker = new PageMaker();
				pageMaker.setPvo(pvo);
		
				pageMaker.setTotalCount(readListTotCnt);
				model.addAttribute("pageMaker", pageMaker);	
			} else {
				model.addAttribute("list", service.selectArticleList(boardVO, pvo));
				
				PageMaker pageMaker = new PageMaker();
				pageMaker.setPvo(pvo);
		
				pageMaker.setTotalCount(service.selectArticleListTotCnt(boardVO ,pvo));
				model.addAttribute("pageMaker", pageMaker);	
			}
		} else { // 기본 게시판, 알림 게시판 전체보기
			model.addAttribute("list", service.selectArticleList(boardVO, pvo));
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setPvo(pvo);
	
			pageMaker.setTotalCount(service.selectArticleListTotCnt(boardVO ,pvo));
			model.addAttribute("pageMaker", pageMaker);	
		}
		
		/*if(boardType.equals("basic")) {			
			model.addAttribute("list", service.selectArticleList(boardVO, pvo));
	
			PageMaker pageMaker = new PageMaker();
			pageMaker.setPvo(pvo);
	
			pageMaker.setTotalCount(service.selectArticleListTotCnt(boardVO ,pvo));
			model.addAttribute("pageMaker", pageMaker);	

		} else if (boardType.equals("notice")) {
			HttpSession session = request.getSession();
			MemberVO loginVO = (MemberVO) session.getAttribute("loginVO");
			
			model.addAttribute("list", service.selectReadList(loginVO, boardVO, pvo));
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setPvo(pvo);
	
			pageMaker.setTotalCount(service.selectReadListTotCnt(loginVO, boardVO ,pvo));
			model.addAttribute("pageMaker", pageMaker);	
		}*/
		
		
		if (pvo.getPage() == 1) {
			List<BoardArticleVO> baList = service.selectNoticeList(boardVO);
			if(baList != null && baList.size() > 0) {
				model.addAttribute("noticeVO", baList.get(0));
				model.addAttribute("noticeVOList", baList);
			}
			
			// 팝업 띄우기
			model.addAttribute("popupList", popupService.mainPopupList());
		}
		
		return "/board/" + boardType + "/list";
	}
	
	@RequestMapping(value = "/{boardType}/{url}/writePage", method = RequestMethod.POST)
	public String articleWritePage(Model model, @ModelAttribute("pvo") SearchCriteria pvo,
			HttpServletResponse response, HttpServletRequest request,
			@PathVariable String boardType,	@PathVariable String url) throws Exception {
		
		BoardBoardVO urlBoardVO = new BoardBoardVO();
		urlBoardVO.setUrl(url);
		BoardBoardVO boardVO = boardService.selectUrlBoard(urlBoardVO);
		model.addAttribute("boardVO", boardVO);
		
		return "/board/" + boardType + "/writePage";
	}
	
	@RequestMapping(value = "/{boardType}/{url}/writePageAction", method = RequestMethod.POST)
	public String articleWritePageAction(Model model, BoardArticleVO vo,
			@PathVariable String boardType,	@PathVariable String url) throws Exception {
		String userPW = vo.getPassword();
		if(userPW != null && !userPW.isEmpty()) {
			BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder(10);
			String encodePW = pwEncoder.encode(userPW);
			vo.setPassword(encodePW);
		}
		service.insertArticle(vo);
		return "redirect:/board/" + boardType + "/" + url + "/list";
	}
	
	@RequestMapping(value = "/{boardType}/{url}/readPage", method = RequestMethod.POST)
	public String articleReadPage(Model model, BoardArticleVO vo, String pw,
			HttpServletResponse response, HttpServletRequest request, @ModelAttribute("pvo") SearchCriteria pvo,
			@ModelAttribute("showType") String showType,
			@PathVariable String boardType,	@PathVariable String url) throws Exception {
		BoardArticleVO articleVO = service.selectArticle(vo);
		Character isSecret = articleVO.getIsSecret();		
		
		if(isSecret != null && isSecret == 'Y') {
			boolean pwMatches = false;
			BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder(10);
			pwMatches = pwEncoder.matches(pw, articleVO.getPassword());
			
			if(!pwMatches) {
				response.setContentType("text/html; charset=UTF-8");			 
				PrintWriter out = response.getWriter();			 
				out.println("<script>alert('비밀번호 불일치.'); self.opener = self; window.close();</script>");			 
				out.flush();
				return "redirect:/board/" + boardType + "/" + url + "/list";
			}
		}
		
		service.updateViewcnt(articleVO.getBno());
		if(boardType.equals("notice")) {
			HttpSession session = request.getSession();
			MemberVO loginVO = (MemberVO) session.getAttribute("loginVO");
			service.insertReadTbl(loginVO, articleVO);	
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setPvo(pvo);

			pageMaker.setTotalCount(service.selectMainReadListTotCnt(loginVO, pvo));
			model.addAttribute("pageMaker", pageMaker);
		}
		
		BoardBoardVO urlBoardVO = new BoardBoardVO();
		urlBoardVO.setUrl(url);
		BoardBoardVO boardVO = boardService.selectUrlBoard(urlBoardVO);
		model.addAttribute("boardVO", boardVO);
		
		String clean = XssPreventer.escape(vo.getTitle());
		vo.setTitle(clean);
		model.addAttribute("articleVO", articleVO);
		
		return "/board/" + boardType + "/readPage";
	}
	
	@RequestMapping(value = "/{boardType}/{url}/modifyPage", method = RequestMethod.POST)
	public String articleModifyPage(Model model, BoardArticleVO vo,
			@ModelAttribute("pvo") SearchCriteria pvo, String pw,
			HttpServletResponse response, HttpServletRequest request,
			@PathVariable String boardType,	@PathVariable String url) throws Exception {
		BoardArticleVO articleVO = service.selectArticle(vo);
		
		Character isSecret = articleVO.getIsSecret();		
		
		if(isSecret != null && isSecret == 'Y') {
			boolean pwMatches = false;
			BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder(10);
			pwMatches = pwEncoder.matches(pw, articleVO.getPassword());
			
			if(!pwMatches) {
				response.setContentType("text/html; charset=UTF-8");			 
				PrintWriter out = response.getWriter();			 
				out.println("<script>alert('비밀번호 불일치.'); self.opener = self; window.close();</script>");			 
				out.flush();
				return "redirect:/board/" + boardType + "/" + url + "/list";
			}
		}
		
		BoardBoardVO urlBoardVO = new BoardBoardVO();
		urlBoardVO.setUrl(url);
		BoardBoardVO boardVO = boardService.selectUrlBoard(urlBoardVO);
		model.addAttribute("boardVO", boardVO);
		
		String clean = XssPreventer.escape(vo.getTitle());
		vo.setTitle(clean);
		model.addAttribute("articleVO", articleVO);
		
		return "/board/" + boardType + "/modifyPage";
	}
	
	@RequestMapping(value = "/{boardType}/{url}/modifyPageAction", method = RequestMethod.POST)
	public String articleModifyPageAction(BoardArticleVO board,
			@PathVariable String boardType,	@PathVariable String url,
			SearchCriteria pvo, RedirectAttributes rttr) throws Exception {
		String userPW = board.getPassword();
		if(userPW != null && !userPW.isEmpty()) {
			BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder(10);
			String encodePW = pwEncoder.encode(userPW);
			board.setPassword(encodePW);
		}
		service.updateArticle(board);
		
		/*BoardBoardVO urlBoardVO = new BoardBoardVO();
		urlBoardVO.setUrl(url);
		BoardBoardVO boardVO = boardService.selectUrlBoard(urlBoardVO);
		rttr.addAttribute("boardVO", boardVO);
		
		rttr.addAttribute("page", pvo.getPage());
		rttr.addAttribute("perPageNum", pvo.getPerPageNum());
		rttr.addAttribute("searchType", pvo.getSearchType());
		rttr.addAttribute("keyword", pvo.getKeyword());*/
		
		return "redirect:/board/" + boardType + "/" + url + "/list";
	}
	
	@RequestMapping(value = "/{boardType}/{url}/removeAction", method = RequestMethod.POST)
	public String removeAction(BoardArticleVO vo, SearchCriteria pvo, String pw,
			HttpServletResponse response, HttpServletRequest request,
			@PathVariable String boardType,	@PathVariable String url,
			RedirectAttributes rttr) throws Exception{
		
		BoardArticleVO articleVO = service.selectArticle(vo);
		
		Character isSecret = articleVO.getIsSecret();		
		
		if(isSecret != null && isSecret == 'Y') {
			boolean pwMatches = false;
			BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder(10);
			pwMatches = pwEncoder.matches(pw, articleVO.getPassword());
			
			if(!pwMatches) {
				response.setContentType("text/html; charset=UTF-8");			 
				PrintWriter out = response.getWriter();			 
				out.println("<script>alert('비밀번호 불일치.'); self.opener = self; window.close();</script>");			 
				out.flush();
				return "redirect:/board/" + boardType + "/" + url + "/list";
			}
		}
		
		service.remove(articleVO.getBno());
		
		/*BoardBoardVO urlBoardVO = new BoardBoardVO();
		urlBoardVO.setUrl(url);
		BoardBoardVO boardVO = boardService.selectUrlBoard(urlBoardVO);
		rttr.addAttribute("boardVO", boardVO);
		
		rttr.addAttribute("page", pvo.getPage());
		rttr.addAttribute("perPageNum", pvo.getPerPageNum());
		rttr.addAttribute("searchType", pvo.getSearchType());
		rttr.addAttribute("keyword", pvo.getKeyword());*/
		
		return "redirect:/board/" + boardType + "/" + url + "/list";
	}
	
	@RequestMapping(value = "/{boardType}/{url}/reRegister", method = RequestMethod.POST)
	public String articleReRegister(@ModelAttribute("oBoardVO")BoardArticleVO vo, 
			@PathVariable String boardType,	@PathVariable String url, Model model,
			@ModelAttribute("pvo") SearchCriteria pvo) throws Exception {
		BoardBoardVO urlBoardVO = new BoardBoardVO();
		urlBoardVO.setUrl(url);
		BoardBoardVO boardVO = boardService.selectUrlBoard(urlBoardVO);
		model.addAttribute("boardVO", boardVO);
		
		String clean = XssPreventer.escape(vo.getTitle());
		vo.setTitle(clean);
		
		return "/board/" + boardType + "/reRegister";
	}
	
	@RequestMapping(value = "/{boardType}/{url}/reRegisterAction", method = RequestMethod.POST)
	public String articleReRegisterAction(@RequestParam("obno") int obno, BoardArticleVO vo, 
			@PathVariable String boardType,	@PathVariable String url,
			SearchCriteria pvo, RedirectAttributes rttr) throws Exception {
		String userPW = vo.getPassword();
		if(userPW != null && !userPW.isEmpty()) {
			BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder(10);
			String encodePW = pwEncoder.encode(userPW);
			vo.setPassword(encodePW);
		}
		service.reRegist(vo, obno);
		
//		BoardBoardVO urlBoardVO = new BoardBoardVO();
//		urlBoardVO.setUrl(url);
//		BoardBoardVO boardVO = boardService.selectUrlBoard(urlBoardVO);
//		rttr.addAttribute("boardVO", boardVO);
//		
//		rttr.addAttribute("page", pvo.getPage());
//		rttr.addAttribute("perPageNum", pvo.getPerPageNum());
//		rttr.addAttribute("searchType", pvo.getSearchType());
//		rttr.addAttribute("keyword", pvo.getKeyword());
		
		return "redirect:/board/" + boardType + "/" + url + "/list";
	}
}
