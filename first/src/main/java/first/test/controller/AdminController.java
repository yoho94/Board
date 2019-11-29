package first.test.controller;

import java.io.File;
import java.util.Enumeration;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import first.test.service.MemberService;
import first.test.service.PopupService;
import first.test.service.SurveyService;
import first.test.vo.CategoryVO;
import first.test.vo.MemberVO;
import first.test.vo.PopupVO;
import first.test.vo.QuestionCodeVO;
import first.test.vo.SurveyQuestionVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Inject
	private MemberService memberService;
	@Inject
	private SurveyService surveyService;
	@Inject
	private PopupService popupService;

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@RequestMapping(value = "/home")
	public void homePage(Model model, String msg) throws Exception {
		
	}
	
	@RequestMapping(value = "/login")
	public String loginPage(HttpServletRequest request, Model model, String msg) throws Exception {
		HttpSession session = request.getSession();
		
		MemberVO loginVO = (MemberVO) session.getAttribute("loginVO");		
		if (loginVO.getIsAdmin() != 1) {
			return "redirect:/list";
		}
		
		model.addAttribute("msg", msg);
		
		return "/admin/login";
	}
	
	@RequestMapping(value = "/login.action", method = RequestMethod.POST)
	public String loginAction(HttpServletRequest request, RedirectAttributes rttr, String pass) throws Exception {
		HttpSession session = request.getSession();
		MemberVO loginVO = (MemberVO) session.getAttribute("loginVO");
		
		if(pass.equals(loginVO.getUserPass())) {		
			session.setAttribute("isAdminLogin", new Boolean(true));
			return "redirect:/admin/home";
		} else {
			rttr.addAttribute("msg", "비밀번호가 틀렸습니다.");
			return "redirect:/admin/login";
		}		
		
	}
	
	// 멤버
	@RequestMapping(value = "/ajax/memberList", method = RequestMethod.POST)
	public void getMemberList(Model model) throws Exception {
		model.addAttribute("list", memberService.selectMemberList());
	}
	
	@RequestMapping(value = "/member/change.ajax", method = RequestMethod.POST)
	@ResponseBody
	public void memberUpdateUnUsing(MemberVO vo) throws Exception {
		switch(vo.getIsUsing()) {
		case 'Y':
			memberService.updateUsing(vo.getUserId());
			break;
		case 'N':
			memberService.updateUnUsing(vo.getUserId());
			break;
		}
		memberService.updateAdmin(vo);
	}
	
	// 설문
	@RequestMapping(value = "/ajax/surveyList", method = RequestMethod.POST)
	public void getSurveyList(Model model) throws Exception {
		model.addAttribute("list", surveyService.selectAdminList());
	}
		
	@RequestMapping(value = "/survey/surveyDetails.ajax", method = RequestMethod.POST)
	public String selectAdminInfo(Model model, int seq) throws Exception {
		model.addAttribute("info", surveyService.selectAdminInfo(seq));
		return "/admin/ajax/surveyDetails";
	}
	
	@RequestMapping(value = "/survey/updateUnUsing.ajax", method = RequestMethod.POST)
	@ResponseBody
	public void surveyUpdateUnUsing(int seq) throws Exception {
		surveyService.updateUnUsing(seq);
	}
	
	@RequestMapping(value = "/survey/updateUsing.ajax", method = RequestMethod.POST)
	@ResponseBody
	public void surveyUpdateUsing(int seq) throws Exception {
		surveyService.updateUsing(seq);
	}
	
	@RequestMapping(value = "/ajax/questionList", method = RequestMethod.POST)
	public void getQuestionList(Model model, int seq) throws Exception {
		model.addAttribute("categoryList", surveyService.selectCategory());
		model.addAttribute("parentCode", surveyService.selectParentCode());
		model.addAttribute("list", surveyService.selectQuestionList(seq));
		model.addAttribute("questionMax", surveyService.selectQuestionCount(seq));
	}
	
	@RequestMapping(value = "/survey/questionMod.ajax", method = RequestMethod.POST)
	@ResponseBody
	public void questionMod(SurveyQuestionVO vo, int originalOrder, int originalDepth) throws Exception {
		surveyService.updateQuestion(vo, originalOrder, originalDepth);
	}
	
	@RequestMapping(value = "/survey/questionDel.ajax", method = RequestMethod.POST)
	@ResponseBody
	public void questionDel(SurveyQuestionVO vo, int originalOrder, int originalDepth) throws Exception {
		surveyService.deleteQuestion(vo, originalOrder, originalDepth);
	}
	
	@RequestMapping(value = "/survey/deleteCategory.ajax", method = RequestMethod.POST)
	@ResponseBody
	public void deleteCategory(CategoryVO vo) throws Exception {
		surveyService.deleteCategory(vo);
	}
	
	@RequestMapping(value = "/survey/deleteParentCode.ajax", method = RequestMethod.POST)
	@ResponseBody
	public void deleteParentCode(QuestionCodeVO vo) throws Exception {
		surveyService.deleteParentCode(vo);
	}
	
	// 팝업
	@RequestMapping(value = "/ajax/popupList", method = RequestMethod.POST)
	public void getPopupList(Model model) throws Exception {
		model.addAttribute("list", popupService.adminPopupList());
	}
	
	@RequestMapping(value = "/ajax/popupDetails", method = RequestMethod.POST)
	public void getPopupDetails(Model model, int seq) throws Exception {
		model.addAttribute("vo", popupService.selectPopupOne(seq));
	}
	@RequestMapping(value = "/showPopup")
	public void showPopup(Model model, int seq) throws Exception {
		model.addAttribute("vo", popupService.selectPopupOne(seq));
	}
	
	@RequestMapping(value = "/ajax/popupMod", method = RequestMethod.POST)
	public String getPopupMod(Model model, @RequestParam(name = "seq", defaultValue = "0") int seq) throws Exception {
		model.addAttribute("vo", popupService.selectPopupOne(seq));
		return "/admin/ajax/popupWrite";
	}
	
	@RequestMapping(value = "/ajax/popupWrite", method = RequestMethod.POST)
	public void getPopupWrite(Model model) throws Exception {
	}
	
	@RequestMapping(value = "/ajax/popupWrite.ajax", method = RequestMethod.POST)
	public void getPopupWriteAction(PopupVO vo, HttpServletRequest req, int isUpdate) throws Exception {
		MemberVO adminVO = (MemberVO) req.getSession().getAttribute("loginVO");
		vo.setWrite_id(adminVO.getUserId());
		vo.setMod_id(adminVO.getUserId());
		if(isUpdate == 0) {
			popupService.insertPopup(vo);
		} else {
			popupService.updatePopup(vo);
		}
	}
	
	@RequestMapping(value = "/ajax/popupUsingUpdate.ajax", method = RequestMethod.POST)
	@ResponseBody
	public void popupUsingUpdate(PopupVO vo) throws Exception {
		popupService.updatePopupUsing(vo);
	}
	
	@RequestMapping(value = "/imgUp", method = RequestMethod.POST)
	public void doImgUp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int maxRequestSize = 1024 * 1024 * 50;
		
		request.setCharacterEncoding("UTF-8");
		String path = "/resources/upload"; // 개발자 지정 폴더
//		String real_save_path = "D:/upload";
		String real_save_path = request.getSession().getServletContext().getRealPath(path);	
//		System.out.println(real_save_path);
		File Folder = new File(real_save_path);
//		System.out.println(real_save_path);

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
	
		Enumeration it = multi.getFileNames();
		String originalfileName;
		while(it.hasMoreElements()){
			originalfileName = (String) it.nextElement();
			String fileName = multi.getOriginalFileName(originalfileName);
			
			JSONObject outData = new JSONObject();
			if(fileName != null){
				outData.put("uploaded", true);
				outData.put("url", request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/" + fileName);
			}
			else
				outData.put("uploaded", false);
			
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(outData.toString());
		}			

	}
	
}
