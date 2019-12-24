package first.test.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import first.test.service.BoardArticleService;
import first.test.service.DashBoardService;
import first.test.service.UserAgentService;
import first.test.vo.BoardArticleVO;
import first.test.vo.DashBoardVO;
import first.test.vo.MemberVO;
import first.test.vo.PageMaker;
import first.test.vo.SearchCriteria;
import first.test.vo.UserAgentVO;

@Controller
@RequestMapping("/chart")
public class ChartController {
	@Inject
	private BoardArticleService service;
	@Inject
	private UserAgentService uaService;
	@Inject
	private DashBoardService dbService;

	private static final Logger logger = LoggerFactory.getLogger(ChartController.class);
	
	@RequestMapping("/addChart.action")
	public String addChart(HttpServletRequest request, DashBoardVO vo) throws Exception{	
		
		HttpSession session = request.getSession();
        MemberVO loginVO = (MemberVO) session.getAttribute("loginVO");
        vo.setId(loginVO.getUserId());
		
        dbService.insert(vo);
        
		return "redirect:/chart/home";
	}
	
	@RequestMapping("/delete.action")
	public String deleteChart(HttpServletRequest request, DashBoardVO vo) throws Exception{		
        dbService.delete(vo);        
		return "redirect:/chart/home";
	}
	
	@RequestMapping("/modifyChart.action")
	public String modifyChart(HttpServletRequest request, DashBoardVO vo) throws Exception{		
        dbService.update(vo);        
		return "redirect:/chart/home";
	}
	
	@RequestMapping("/modal")
	public String modal() {
		return "/chart/modal";
	}
	
	@RequestMapping("/")
	public String home1() {
		return "/chart/dash_board";
	}
	
	// 엑셀
	@RequestMapping("/excelAll.xls")
	public void excelAll(HttpServletRequest request, @ModelAttribute("pvo") SearchCriteria pvo, HttpServletResponse response) throws Exception {
		List<UserAgentVO> listUA = uaService.selectAll();
		HSSFWorkbook workbook = new HSSFWorkbook(); // 새 엑셀 생성
        HSSFSheet sheet = workbook.createSheet(); // 새 시트(Sheet) 생성
        HSSFRow row = sheet.createRow(0); // 엑셀의 행은 0번부터 시작
    	HSSFCell cell = row.createCell(0); // 행의 셀은 0번부터 시작
    	cell.setCellValue("IP");
    	row.createCell(1).setCellValue("날짜");
    	row.createCell(2).setCellValue("아이디");
    	row.createCell(3).setCellValue("OS이름");
    	row.createCell(4).setCellValue("OS버전");
    	row.createCell(5).setCellValue("브라우저 이름");
    	row.createCell(6).setCellValue("브라우저 버전");
    	row.createCell(7).setCellValue("디바이스 브랜드");
    	row.createCell(8).setCellValue("디바이스 모델");
    	row.createCell(9).setCellValue("리퍼러");
    	row.createCell(10).setCellValue("방문한 주소");
        for(int i=0; i<listUA.size(); i++) {
        	UserAgentVO vo = listUA.get(i);
        	row = sheet.createRow(i+1); // 엑셀의 행은 0번부터 시작
        	row.createCell(0).setCellValue(vo.getIp());
        	row.createCell(1).setCellValue(vo.getDate());
        	row.createCell(2).setCellValue(vo.getId());
        	row.createCell(3).setCellValue(vo.getOsName());
        	row.createCell(4).setCellValue(vo.getOsVersion());
        	row.createCell(5).setCellValue(vo.getBrowserName());
        	row.createCell(6).setCellValue(vo.getBrowserVersion());
        	row.createCell(7).setCellValue(vo.getDeviceBrand());
        	row.createCell(8).setCellValue(vo.getDeviceModel());
        	row.createCell(9).setCellValue(vo.getReferer());
        	row.createCell(10).setCellValue(vo.getPath());
        }    		
    		OutputStream os = response.getOutputStream();
    		workbook.write(os);
    		os.close();
    		
//            String path = "/resources/upload"; 
//    		String real_save_path = request.getSession().getServletContext().getRealPath(path);	
//            try {    		
//        		File Folder = new File(real_save_path);
////        		System.out.println(real_save_path);
//
//        		// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
//        		if (!Folder.exists()) {
//        			Folder.mkdir(); // 폴더 생성합니다.
//        		} else {
////        			System.out.println("이미 폴더가 생성되어 있습니다.");
//        		}
//            FileOutputStream fileoutputstream = new FileOutputStream(real_save_path+"/all.xlsx");
//            workbook.write(fileoutputstream);
//            fileoutputstream.close();
//            System.out.println("엑셀파일생성성공");
//            
//            OutputStream os = response.getOutputStream();
//            FileInputStream fis = new FileInputStream(real_save_path+"/all.xlsx");
// 
//            int ncount = 0;
//            byte[] bytes = new byte[512];
// 
//            while ((ncount = fis.read(bytes)) != -1 ) {
//                os.write(bytes, 0, ncount);
//            }
//            fis.close();
//            os.close();            
//        } catch (IOException e) {
//            e.printStackTrace();
//            System.out.println("엑셀파일생성실패");
//        }        
		
	}
	
	@RequestMapping(value = "/getList.ajax")
	@ResponseBody
	public String ajax_getList(Integer page, Integer perPageNum, String searchType, String keyword, Long start, Long end) throws Exception {
		SearchCriteria pvo = new SearchCriteria(searchType, keyword);
		pvo.setPage(page);
		pvo.setPerPageNum(perPageNum);
		pvo.setStartDate(new Date(start));
		pvo.setEndDate(new Date(end));
		
		Gson gson = new Gson();
		JSONObject json = new JSONObject();
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setPvo(pvo);
		pageMaker.setTotalCount(uaService.listSearchCount(pvo));
		
		List<UserAgentVO> list = uaService.listSearch(pvo);
		
		json.put("pvo", new JSONObject(gson.toJson(pvo)));
		json.put("pageMaker", new JSONObject(gson.toJson(pageMaker)));
		json.put("list", new JSONArray(gson.toJson(list)));
		
		return json.toString();
	}	

	@RequestMapping("/home")
	public String home2(@ModelAttribute("pvo") SearchCriteria pvo, Model model, HttpServletRequest request) throws Exception {
		
		model.addAttribute("list", uaService.listSearch(pvo));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setPvo(pvo);
		
		pageMaker.setTotalCount(uaService.listSearchCount(pvo));
		model.addAttribute("pageMaker", pageMaker);
		
		HttpSession session = request.getSession();
        MemberVO loginVO = (MemberVO) session.getAttribute("loginVO");
		model.addAttribute("dashList", dbService.selectBoard(loginVO));
		
		return "/chart/dash_board";
	}

	@RequestMapping("dashboard")
	public String dashboard() {
		return "/chart/dash_board";
	}
	
	@RequestMapping(value = "/getVisit.ajax")
	@ResponseBody
	public String ajax_getVisit(String type, long start, long end) throws Exception {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("type", type.charAt(0));
		map.put("startDate", new Date(start));
		map.put("endDate", new Date(end));
		
		List<HashMap<String, Object>> hmap = uaService.selectDate(map);		

		
		Gson gson = new Gson();
		return gson.toJson(hmap);
	}
	
	@RequestMapping(value = "/getNewVisit.ajax")
	@ResponseBody
	public String ajax_getNewVisit(String type, long start, long end) throws Exception {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("type", type.charAt(0));
		map.put("startDate", new Date(start));
		map.put("endDate", new Date(end));
		
		List<HashMap<String, Object>> hmap = uaService.selectNewVisit(map);

		
		Gson gson = new Gson();
		return gson.toJson(hmap);
	}
	
	@RequestMapping(value = "/getOsName.ajax")
	@ResponseBody
	public String ajax_getOsName(long start, long end, Integer limit) throws Exception {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("startDate", new Date(start));
		map.put("endDate", new Date(end));
		map.put("limit", limit);
		
		List<HashMap<String, Object>> hmap = uaService.selectOsName(map);		
		
		Gson gson = new Gson();
		return gson.toJson(hmap);
	}
	
	@RequestMapping(value = "/getOsVersion.ajax")
	@ResponseBody
	public String ajax_getOsVersion(long start, long end, Integer limit) throws Exception {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("startDate", new Date(start));
		map.put("endDate", new Date(end));
		map.put("limit", limit);
		
		List<HashMap<String, Object>> hmap = uaService.selectOsVersion(map);		
		
		Gson gson = new Gson();
		return gson.toJson(hmap);
	}
	
	@RequestMapping(value = "/getBrowserName.ajax")
	@ResponseBody
	public String ajax_getBrowserName(long start, long end, Integer limit) throws Exception {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("startDate", new Date(start));
		map.put("endDate", new Date(end));
		map.put("limit", limit);
		
		List<HashMap<String, Object>> hmap = uaService.selectBrowserName(map);		
		
		Gson gson = new Gson();
		return gson.toJson(hmap);
	}
	
	@RequestMapping(value = "/getBrowserVersion.ajax")
	@ResponseBody
	public String ajax_getBrowserVersion(long start, long end, Integer limit) throws Exception {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("startDate", new Date(start));
		map.put("endDate", new Date(end));
		map.put("limit", limit);
		
		List<HashMap<String, Object>> hmap = uaService.selectBrowserVersion(map);		
		
		Gson gson = new Gson();
		return gson.toJson(hmap);
	}
	
	@RequestMapping(value = "/getDeviceBrand.ajax")
	@ResponseBody
	public String ajax_getDeviceBrand(long start, long end, Integer limit) throws Exception {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("startDate", new Date(start));
		map.put("endDate", new Date(end));
		map.put("limit", limit);
		
		List<HashMap<String, Object>> hmap = uaService.selectDeviceBrand(map);		
		
		Gson gson = new Gson();
		return gson.toJson(hmap);
	}
	
	@RequestMapping(value = "/getDeviceModel.ajax")
	@ResponseBody
	public String ajax_getDeviceModel(long start, long end, Integer limit) throws Exception {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("startDate", new Date(start));
		map.put("endDate", new Date(end));
		map.put("limit", limit);
		
		List<HashMap<String, Object>> hmap = uaService.selectDeviceModel(map);		
		
		Gson gson = new Gson();
		return gson.toJson(hmap);
	}
	
	@RequestMapping(value = "/getId.ajax")
	@ResponseBody
	public String ajax_getId(long start, long end, Integer limit, Boolean check) throws Exception {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("startDate", new Date(start));
		map.put("endDate", new Date(end));
		map.put("limit", limit);		
		
		List<HashMap<String, Object>> hmap;
		
		if(check)
			hmap = uaService.selectIdNotNull(map);
		else
			hmap = uaService.selectId(map);
		
		Gson gson = new Gson();
		return gson.toJson(hmap);
	}
	@RequestMapping(value = "/getIp.ajax")
	@ResponseBody
	public String ajax_getIp(long start, long end, Integer limit) throws Exception {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("startDate", new Date(start));
		map.put("endDate", new Date(end));
		map.put("limit", limit);
		
		List<HashMap<String, Object>> hmap = uaService.selectIp(map);		
		
		Gson gson = new Gson();
		return gson.toJson(hmap);
	}
	@RequestMapping(value = "/getReferer.ajax")
	@ResponseBody
	public String ajax_getReferer(long start, long end, Integer limit, Boolean check) throws Exception {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("startDate", new Date(start));
		map.put("endDate", new Date(end));
		map.put("limit", limit);
		
		List<HashMap<String, Object>> hmap;
		
		if(check)
			hmap = uaService.selectRefererNotNull(map);
		else
			hmap = uaService.selectReferer(map);	
		
		Gson gson = new Gson();
		return gson.toJson(hmap);
	}
	@RequestMapping(value = "/getPath.ajax")
	@ResponseBody
	public String ajax_getPath(long start, long end, Integer limit) throws Exception {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("startDate", new Date(start));
		map.put("endDate", new Date(end));
		map.put("limit", limit);
		
		List<HashMap<String, Object>> hmap = uaService.selectPath(map);		
		
		Gson gson = new Gson();
		return gson.toJson(hmap);
	}
	
	/*
	@RequestMapping(value = "/getVisit.ajax")
	@ResponseBody
	public String ajax_getUA(String type) throws Exception {
		char flag = type.charAt(0);
		List<UserAgentVO> ualist = uaService.selectAll();
		LinkedHashMap<Date, Integer> map = new LinkedHashMap<>();

		switch (flag) {
		case 'y': // 년
			for (UserAgentVO vo : ualist) {
				int year = vo.getDate().getYear();
				Date key = new Date(year, 0, 0);
				map.put(key, map.getOrDefault(key, 0) + 1);
			}
			break;
		case 'm': // 월
			for (UserAgentVO vo : ualist) {
				int year = vo.getDate().getYear();
				int month = vo.getDate().getMonth();
				Date key = new Date(year, month, 0);
				map.put(key, map.getOrDefault(key, 0) + 1);
			}
			break;
		case 'd': // 일
			for (UserAgentVO vo : ualist) {
				int year = vo.getDate().getYear();
				int month = vo.getDate().getMonth();
				int date = vo.getDate().getDate();
				Date key = new Date(year, month, date);
				map.put(key, map.getOrDefault(key, 0) + 1);
			}
			break;
		}

		StringBuilder sb = new StringBuilder();

		for (Date key : map.keySet()) {
			sb.append(key.getTime() + "=" + map.get(key) + ",");
		}

		return sb.toString();
	} 
	*/

	@RequestMapping(value = "/getDate", produces = "application/json; charset=utf8")
	@ResponseBody
	public String ajax_getDate(String type) throws Exception {
		// JSONObject data = new JSONObject();
		// JSONArray array = new JSONArray();
		LinkedHashMap<Date, Integer> map = new LinkedHashMap<>();

		List<BoardArticleVO> listVO = service.selectDate();
		if (listVO.size() > 0) {
			for (int i = 0; i < listVO.size(); i++) {
				BoardArticleVO vo = listVO.get(i);
				Date key = new Date(vo.getRegDate().getYear(), vo.getRegDate().getMonth(), vo.getRegDate().getDate());

				if (map.get(key) == null)
					map.put(key, 1);
				else
					map.put(key, map.get(key) + 1);
			}
		}
		StringBuilder sb = new StringBuilder();

		for (Date key : map.keySet()) {
			sb.append(key + "=" + map.get(key) + ",");
		}

		// data.put("regDate", array);
//		System.out.println(type);
//		System.out.println(map.toString());
//		System.out.println(sb.toString());
		return sb.toString();
	}

	// @RequestMapping(value="/getDate", produces="application/json;
	// charset=utf8")
	// @ResponseBody
	// public String ajax_getDate(HttpServletRequest request) throws Exception{
	//
	// HttpHeaders responseHeaders = new HttpHeaders();
	//
	// JSONObject data = new JSONObject();
	// JSONObject ajaxObjCols1 = new JSONObject(); //cols의 1번째 object를 담을
	// JSONObject
	// JSONObject ajaxObjCols2 = new JSONObject(); //cols의 2번째 object를 담을
	// JSONObject
	// JSONArray ajaxArryCols = new JSONArray(); //위의 두개의 JSONObject를 담을
	// JSONArray
	// JSONArray ajaxArryRows = new JSONArray();
	//
	// ajaxObjCols1.put("type", "string");
	// ajaxObjCols2.put("type", "string");
	//
	// ajaxArryCols.put(ajaxObjCols1);
	// ajaxArryCols.put(ajaxObjCols2);
	//
	// List<BoardVO> listVO = service.selectDate();
	//
	// if(listVO.size() > 0){
	// for(int i=0; i<listVO.size(); i++){
	// BoardVO vo = listVO.get(i);
	// JSONObject legend = new JSONObject();
	// legend.put("v", vo.getRegdate());
	//// legend.put("f", null);
	//
	// JSONObject value = new JSONObject();
	// value.put("v", vo.getRegdate());
	//// value.put("f", null);
	//
	// JSONArray cValueArry = new JSONArray();
	// cValueArry.put(legend);
	// cValueArry.put(value);
	//
	// JSONObject cValueObj = new JSONObject();
	// cValueObj.put("c", cValueArry);
	//
	// ajaxArryRows.put(cValueObj);
	// }
	//
	// }
	//
	//
	// data.put("cols", ajaxArryCols);
	// data.put("rows", ajaxArryRows);
	//
	// System.out.println(data);
	//
	//
	//// List<BoardVO> listVO = service.selectDate();
	////
	//// if(listVO.size() > 0){
	//// for(int i=0; i<listVO.size(); i++){
	//// HashMap hm = new HashMap();
	//// hm.put("regDate", listVO.get(i).getRegdate());
	////
	//// hmlist.add(hm);
	//// }
	////
	//// }
	//
	// return data.toString();
	//
	// }
	
	@RequestMapping("/print")
	public void print() {
		
	}
}
