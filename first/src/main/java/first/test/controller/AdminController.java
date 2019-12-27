package first.test.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import first.test.service.BoardBoardService;
import first.test.service.MemberService;
import first.test.service.MenuService;
import first.test.service.PopupService;
import first.test.service.SurveyService;
import first.test.vo.BoardBoardVO;
import first.test.vo.CategoryVO;
import first.test.vo.MemberVO;
import first.test.vo.MenuVO;
import first.test.vo.PageMaker;
import first.test.vo.PopupVO;
import first.test.vo.QuestionCodeVO;
import first.test.vo.SearchCriteria;
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
	@Inject
	private BoardBoardService boardService;
	@Inject
	private MenuService menuService;

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	// 메뉴 관리 시작

	// 메뉴 관리 리스트
	@RequestMapping(value = "/ajax/menuList", method = RequestMethod.POST)
	public void getMenuList(Model model) throws Exception {
		model.addAttribute("list", menuService.selectAdminMenuList());
	}

	// 메뉴 작성 및 수정 모달
	@RequestMapping(value = "/ajax/menuWrite", method = RequestMethod.POST)
	public void getMenuWrite(Model model, MenuVO vo) throws Exception {
		if (vo != null && vo.getSeq() != null && vo.getSeq() > 0) {
			model.addAttribute("vo", menuService.selectMenu(vo));
		}
	}

	// 메뉴 작성 액션
	@RequestMapping(value = "/ajax/menuWrite.action", method = RequestMethod.POST)
	@ResponseBody
	public boolean getMenuWriteAction(Model model, MenuVO vo, Integer originalOrder, Integer isUpdate)
			throws Exception {
		Integer tmp;
		if (isUpdate != null && isUpdate > 0) {
			tmp = menuService.updateMenu(vo, originalOrder);
		} else {
			tmp = menuService.insertMenu(vo);
		}

		return (tmp != null && tmp > 0);
	}

	// 메뉴 순서 이동 액션
	@RequestMapping(value = "/ajax/updateMenuOrderSortable.ajax", method = RequestMethod.POST)
	@ResponseBody
	public boolean getUpdateMenuOrderSortable(Model model, MenuVO vo, Integer originalOrder) throws Exception {
		Integer update = menuService.updateMenuOrderSortable(vo, originalOrder);
		return (update != null && update > 0);
	}	
	// 메뉴 관리 끝
	
	//게시판 관리 시작
	
	//게시판 관리 목록 보기
	@RequestMapping(value = "/ajax/boardList", method = RequestMethod.POST)
	public void getBoardList(Model model, Integer page, Integer perPageNum, String searchType, String keyword) throws Exception {
		SearchCriteria pvo = new SearchCriteria(searchType, keyword);
		pvo.setPage(page);
		pvo.setPerPageNum(perPageNum);
		
		model.addAttribute("list", boardService.selectBoardList(pvo));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setPvo(pvo);
		pageMaker.setTotalCount(boardService.selectBoardListTotCnt());		
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("pvo", pvo);
	}
	
	//게시판 작성 및 수정 모달
	@RequestMapping(value = "/ajax/boardWrite", method = RequestMethod.POST)
	public void getBoardWrite(Model model, BoardBoardVO vo) throws Exception {
		if(vo.getBoardId() != null && vo.getBoardId() > 0) {
			model.addAttribute("vo", boardService.selectBoard(vo));
		}
	}
	
	//게시판 URL 검사
	@RequestMapping(value = "/ajax/urlCheck", method = RequestMethod.POST)
	@ResponseBody
	public boolean getUrlCheck(Model model, BoardBoardVO vo) throws Exception {
		BoardBoardVO boardVO = boardService.selectUrlBoard(vo);
		return (boardVO == null);
	}
	
	//게시판 작성 액션
	@RequestMapping(value = "/ajax/boardWrite.action", method = RequestMethod.POST)
	@ResponseBody
	public boolean getBoardWriteAction(Model model, BoardBoardVO vo, Integer originalOrder, Integer isUpdate) throws Exception {
		Integer tmp;
		if(isUpdate != null && isUpdate > 0) {
			tmp = boardService.updateBoard(vo, originalOrder);
		} else {
			tmp = boardService.insertBoard(vo);
		}
		
		return (tmp != null && tmp > 0);
	}
	
	//게시판 순서 이동 액션
	@RequestMapping(value = "/ajax/updateBoardOrderSortable.ajax", method = RequestMethod.POST)
	@ResponseBody
	public boolean getUpdateBoardOrderSortable(Model model, BoardBoardVO vo, Integer originalOrder) throws Exception {
		Integer update = boardService.updateBoardOrderSortable(vo, originalOrder);
		return (update != null && update > 0);
	}
	
	//게시판 관리 끝
	
	@RequestMapping(value = "/home")
	public void homePage(Model model, String msg) throws Exception {
		
	}
	
	@RequestMapping(value = "/login")
	public String loginPage(HttpServletRequest request, Model model, String msg) throws Exception {
		HttpSession session = request.getSession();
		
		MemberVO loginVO = (MemberVO) session.getAttribute("loginVO");		
		if (loginVO.getIsAdmin() != 1) {
			return "redirect:/board/list";
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
	
	@RequestMapping(value = "/member/excelUpload.ajax", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String excelUpload(HttpServletRequest request) throws Exception {
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
		
		MultipartRequest mpr = new MultipartRequest(request, real_save_path);
		FileInputStream fis = new FileInputStream(mpr.getFile("excel"));
		HSSFWorkbook workbook = new HSSFWorkbook(fis);
		int rowindex=0;
		int columnindex=0;
		HSSFSheet sheet=workbook.getSheetAt(0);
		
		List<MemberVO> members = new ArrayList<>();
		
		//행의 수
		int rows=sheet.getPhysicalNumberOfRows();
		for(rowindex=1;rowindex<rows;rowindex++){
		    //행을 읽는다
		    HSSFRow row=sheet.getRow(rowindex);
		    if(row !=null){
		    	try {
		    		MemberVO member = new MemberVO();
			    	String userId = getValue(row.getCell(0));
			    	String userPass = getValue(row.getCell(1));
			    	String userName = getValue(row.getCell(2));
			    	String isAdmin = getValue(row.getCell(3));
			    	String isUsing = getValue(row.getCell(4));
			    	
			    	member.setUserId(userId.trim());
			    	member.setUserPass(userPass.trim());		    	
			    	member.setUserName(userName.trim());
			    	try {
			    		member.setIsAdmin(Integer.parseInt(isAdmin.trim()));
			    	} catch (Exception e) {
			    		return "ERROR\nROW : " + rowindex + "\nMSG : 관리자 여부는 숫자만 가능합니다.";
			    	}
			    	try {
			    		member.setIsUsing(isUsing.trim().charAt(0));
			    	} catch (Exception e) {
			    		return "ERROR\nROW : " + rowindex + "\nMSG : 회원 사용 여부를 확인해주세요.";
			    	}
			    	logger.info(member.toString());
			    	
			    	if(!member.valid()) {
			    		
			    		return "ERROR\nROW : " + rowindex + "\nMSG : " + member.getValidMsg();
			    	}
			    	
			    	Integer idCheck = memberService.idCheck(member.getUserId());
			    	if(idCheck == null || idCheck > 0) {
			    		return "ERROR\nROW : " + rowindex + "\nMSG : 아이디가 이미 존재합니다.";
			    	}
			    	
			    	Integer nameCheck = memberService.nameCheck(member.getUserName());
			    	if(nameCheck == null || nameCheck > 0) {
			    		return "ERROR\nROW : " + rowindex + "\nMSG : 이름이 이미 존재합니다.";
			    	}
			    	
			    	memberService.register(member);
			    	
				} catch (Exception e) {
					logger.error(e.toString());
					return "ERROR\nROW : " + rowindex + "\nMSG : 알수없는 이유로 에러가 발생";
				}		    	
		    }
		}
		
		return "finish";
	}
	
	public String getValue(HSSFCell cell) {		
        String value = "";
        
        if(cell == null) {
            value = "";
        }
        else {
        	cell.setCellType(HSSFCell.CELL_TYPE_STRING);
        	
            if( cell.getCellType() == HSSFCell.CELL_TYPE_FORMULA ) {
                value = cell.getCellFormula();
            }
            else if( cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC ) {
                value = cell.getNumericCellValue() + "";
            }
            else if( cell.getCellType() == HSSFCell.CELL_TYPE_STRING ) {
                value = cell.getStringCellValue();
            }
            else if( cell.getCellType() == HSSFCell.CELL_TYPE_BOOLEAN ) {
                value = cell.getBooleanCellValue() + "";
            }
            else if( cell.getCellType() == HSSFCell.CELL_TYPE_ERROR ) {
                value = cell.getErrorCellValue() + "";
            }
            else if( cell.getCellType() == HSSFCell.CELL_TYPE_BLANK ) {
                value = "";
            }
            else {
                value = cell.getStringCellValue();
            }
        }
        
//        if(value.substring(value.length() - 2).equals(".0"))
//        	value = value.substring(0, value.length() - 2);
        
        return value;
    }
	
	@RequestMapping("/member/sample.xls")
	public void sampleExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("mime/type");
		
		HSSFWorkbook workbook = new HSSFWorkbook(); // 새 엑셀 생성
        HSSFSheet sheet = workbook.createSheet(); // 새 시트(Sheet) 생성
        HSSFRow row = sheet.createRow(0); // 엑셀의 행은 0번부터 시작
    	HSSFCell cell = row.createCell(0); // 행의 셀은 0번부터 시작
    	cell.setCellValue("회원 아이디");
    	row.createCell(1).setCellValue("회원 비밀번호");
    	row.createCell(2).setCellValue("회원 이름");
    	row.createCell(3).setCellValue("관리자 여부 (0, 1)");
    	row.createCell(4).setCellValue("회원 사용 여부 (Y, N)");
    	
    	row = sheet.createRow(1); // 엑셀의 행은 0번부터 시작
    	row.createCell(0).setCellValue("hong_gil_dong");
    	row.createCell(1).setCellValue("PASSWORD");
    	row.createCell(2).setCellValue("홍길동");
    	row.createCell(3).setCellValue("0");
    	row.createCell(4).setCellValue("N");
    	
		OutputStream os = response.getOutputStream();
		workbook.write(os);
		os.close();   
		
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
