package first.test.controller;

import java.io.File;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.nhncorp.lucy.security.xss.XssPreventer;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import first.test.service.BoardService;
import first.test.service.PopupService;
import first.test.service.ReplyService;
import first.test.vo.BoardVO;
import first.test.vo.MemberVO;
import first.test.vo.PageMaker;
import first.test.vo.ReplyVO;
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
	private ReplyService repService;
	@Inject
	private PopupService popupService;

	@RequestMapping("/")
	public String home1() {
		return "home";
	}
	
	@RequestMapping("/home")
	public void home2() {
	}	

	@RequestMapping(value = "/list")
	public void listPage(@ModelAttribute("pvo") SearchCriteria pvo, Model model) throws Exception {
//		System.out.println("list pvo: " + pvo);
		model.addAttribute("list", service.listSearch(pvo));

		PageMaker pageMaker = new PageMaker();
		pageMaker.setPvo(pvo);

		pageMaker.setTotalCount(service.listSearchCount(pvo));
//		System.out.println("ctrl" + service.listSearch(pvo));
		model.addAttribute("pageMaker", pageMaker);
		
		if(pvo.getPage() == 1) {
			BoardVO notice = service.readNotice();
			model.addAttribute("noticeVO", notice);
			// 팝업 띄우기
			model.addAttribute("popupList", popupService.mainPopupList());
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
//		System.out.println(real_save_path);
		File Folder = new File(real_save_path);
		System.out.println(real_save_path);

		// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
		if (!Folder.exists()) {
			try {
				Folder.mkdir(); // 폴더 생성합니다.
//				System.out.println("폴더가 생성되었습니다.");
			} catch (Exception e) {
				e.getStackTrace();
			}
		} else {
//			System.out.println("이미 폴더가 생성되어 있습니다.");
		}
		
		MultipartRequest multi = new MultipartRequest(request, real_save_path, maxRequestSize, "UTF-8", new DefaultFileRenamePolicy());
	
//		Enumeration it = multi.getFileNames();
//		String getFileName;
//		while(it.hasMoreElements()){
//			getFileName = (String) it.nextElement();
//			System.out.println(getFileName);
//			System.out.println(multi.getOriginalFileName(getFileName));
//		}		
		
		String fileName_CK = multi.getOriginalFileName("upload"); // ckeditor5 static const
		String fileName_popup = multi.getOriginalFileName("image"); // ckeditor5 static const
		if(fileName_CK != null) {
			JSONObject outData = new JSONObject();
			outData.put("uploaded", true);
			outData.put("url", request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/" + fileName_CK);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(outData.toString());
		} else {
			JSONObject outData = new JSONObject();
			outData.put("uploaded", true);
			outData.put("url", request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/" + fileName_popup);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(outData.toString());
		}

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
	
    /**
     * 댓글 등록(Ajax)
     * @param boardVO
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/board/addComment.do")
    @ResponseBody
    public String ajax_addComment(ReplyVO vo) throws Exception{        
    	repService.writeReply(vo);
    	
        return "success";
    }
    
    @RequestMapping(value="/board/addReComment.do")
    @ResponseBody
    public String ajax_addReComment(ReplyVO vo, @RequestParam("orno") int orno) throws Exception{        
    	repService.writeReReply(vo, orno);
    	
        return "success";
    }
	
	/**
     * 게시물 댓글 불러오기(Ajax)
     * @param boardVO
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/board/commentList.do", produces="application/json; charset=utf8")
    @ResponseBody
    public ResponseEntity ajax_commentList(@ModelAttribute("boardVO") BoardVO boardVO, HttpServletRequest request) throws Exception{
        
        HttpHeaders responseHeaders = new HttpHeaders();
        ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
        
        // 해당 게시물 댓글
        List<ReplyVO> commentVO = repService.readReply(boardVO.getBno());
        
        if(commentVO.size() > 0){
            for(int i=0; i<commentVO.size(); i++){
                HashMap hm = new HashMap();
                hm.put("bno", commentVO.get(i).getBno());
                hm.put("content", commentVO.get(i).getContent());
                hm.put("writer", commentVO.get(i).getWriter());
                hm.put("regDate", commentVO.get(i).getRegStr());
                hm.put("rno", commentVO.get(i).getRno());
                hm.put("re_depth", commentVO.get(i).getRe_depth());
                
                hmlist.add(hm);
            }
            
        }
        
        JSONArray json = new JSONArray(hmlist);        
        return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
        
    }

}
