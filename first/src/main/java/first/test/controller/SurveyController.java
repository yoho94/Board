package first.test.controller;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import first.test.service.SurveyService;
import first.test.vo.CategoryVO;
import first.test.vo.MemberVO;
import first.test.vo.QuestionCodeVO;
import first.test.vo.SurveyAnswerVO;
import first.test.vo.SurveyInfoVO;
import first.test.vo.SurveyQuestionVO;

@Controller
@RequestMapping("/survey")
public class SurveyController {

	@Inject
	SurveyService service;

	private static final Logger logger = LoggerFactory.getLogger(SurveyController.class);

	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public void write(Model model, Integer seq) throws Exception {
		String head = "퓨전소프트 회원분들을 대상으로 만족도 조사를 진행합니다.\n응답하신 내용은 통계법 33조(비밀의 보호)에 의거 비밀이 보장 되며,\n서비스 개선을 위한 자료 외에 어떠한 목적으로도 사용되지 않음을 약속드립니다.\n많은 참여 부탁드리며, 앞으로도 교육정책 및 교육과정 정보를 보다 빠르게 활용하실 수 있도록 더욱 노력하겠습니다.";
		String tail = "※ 유의사항\n - 당첨자 선정은 응답 내용의 성실성 등을 고려하여 선정됩니다.\n - 1인 1회에 한하여 참여가능 합니다.";
		model.addAttribute("head", head);
		model.addAttribute("tail", tail);
		if(seq != null)
			model.addAttribute("info", service.selectInfo(seq));
	}

	@RequestMapping("/list")
	public void list(Model model) throws Exception {
		model.addAttribute("list", service.selectInfoList());
	}

	@RequestMapping("/info")
	public void info(Model model, int survey_seq) throws Exception {
		SurveyInfoVO info = service.selectInfo(survey_seq);
		info.setSurvey_head(info.getSurvey_head().replaceAll("\n", "<br>"));
		info.setSurvey_content(info.getSurvey_content().replaceAll("\n", "<br>"));
		info.setSurvey_foot(info.getSurvey_foot().replaceAll("\n", "<br>"));
		model.addAttribute("info", info);
	}

	@RequestMapping(value = "/question", method = RequestMethod.POST)
	public String question(HttpServletRequest req, RedirectAttributes rattr, Model model,
			@ModelAttribute("seq") int seq, @ModelAttribute("survey_seq") int survey_seq) throws Exception {
		// ----- 날짜 검사 -----
		SurveyInfoVO infoVO = service.selectInfo(seq);
		Date now = new Date();
		int start = infoVO.getStart_date().compareTo(now);
		int end = infoVO.getEnd_date().compareTo(now);

		if (start > 0 || end < 0) {
			rattr.addFlashAttribute("msg", "설문조사 참여기간이 아닙니다.");
			rattr.addAttribute("survey_seq", survey_seq);
			return "redirect:/survey/info";
		}
		// ----- 날짜 검사 끝
		MemberVO loginVO = (MemberVO) req.getSession().getAttribute("loginVO");

		int questionCount = service.selectQuestionCount2(seq);
		int answerCount = service.selectAnswerCount(seq, loginVO.getUserId());

		int page;
		if (answerCount == 0)
			page = 1;
		else if (answerCount % 5 == 0)
			page = answerCount / 5;
		else
			page = answerCount / 5 + 1;

		int maxPage;
		if (questionCount == 0)
			maxPage = 1;
		else if (questionCount % 5 == 0)
			maxPage = questionCount / 5;
		else
			maxPage = questionCount / 5 + 1;

		model.addAttribute("answerCount", answerCount);
		model.addAttribute("questionCount", questionCount);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("page", page);

		if (answerCount == 0) { // 사용자가 설문조사 처음 일 때
			// model.addAttribute("msg", null);
		} else if (questionCount == answerCount) { // 사용자가 설문조사를 완료 했을 때
			model.addAttribute("msg", "수정하시겠습니까?");
		} else if (questionCount > answerCount) { // 사용자가 설문조사를 도중에 그만 두고 다시 들어
													// 왔을 때
			model.addAttribute("msg", "중간에 그만둔 곳부터 시작됩니다.");
		}

		return "/survey/question";
	}

	@RequestMapping(value = "/questionList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public String getQuestionList(int seq, int page) throws Exception {
		List<SurveyQuestionVO> list = service.selectQuestion(seq, page);
		Gson gson = new Gson();
		return gson.toJson(list);
	}

	@RequestMapping(value = "/questionCode.ajax", method = RequestMethod.POST)
	@ResponseBody
	public String getQuestionCode(int code) throws Exception {
		List<QuestionCodeVO> list = service.selectQuestionCode(code);
		Gson gson = new Gson();
		return gson.toJson(list);
	}

	@RequestMapping(value = "/answerList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public String getAnswerList(HttpServletRequest req, int seq, int page) throws Exception {
		MemberVO loginVO = (MemberVO) req.getSession().getAttribute("loginVO");
		List<SurveyAnswerVO> list = service.selectAnswerList(seq, page, loginVO.getUserId());
		Gson gson = new Gson();
		return gson.toJson(list);
	}

	@RequestMapping(value = "/answerInsert.ajax", method = RequestMethod.POST)
	@ResponseBody
	public void answerInsert(HttpServletRequest req, SurveyAnswerVO vo, String[] choice_answer) throws Exception {
		MemberVO loginVO = (MemberVO) req.getSession().getAttribute("loginVO");
		vo.setUser_id(loginVO.getUserId());

		try {
			String choice_str = "";
			for (int i = 0; i < choice_answer.length; i++) {
				choice_str += choice_answer[i] + "@@";
			}
			vo.setChoice_answer(choice_str);
		} catch (Exception e) {
			vo.setChoice_answer(null);
		}

		service.insertAnswer(vo);
	}

	@RequestMapping(value = "/getProgress.ajax", method = RequestMethod.POST)
	@ResponseBody
	public String getProgress(HttpServletRequest req, int seq) throws Exception {
		MemberVO loginVO = (MemberVO) req.getSession().getAttribute("loginVO");
		int questionCount = service.selectQuestionCount2(seq);
		int answerCount = service.selectAnswerCount(seq, loginVO.getUserId());
		JSONObject json = new JSONObject();
		json.put("questionCount", questionCount);
		json.put("answerCount", answerCount);
		return json.toString();
	}

	@RequestMapping(value = "/getParentCode.ajax", method = RequestMethod.POST)
	@ResponseBody
	public String getParentCode() throws Exception {
		return new Gson().toJson(service.selectParentCode());
	}

	@RequestMapping(value = "/getCategory.ajax", method = RequestMethod.POST)
	@ResponseBody
	public String getCategory() throws Exception {
		return new Gson().toJson(service.selectCategory());
	}

	@RequestMapping(value = "/putInfo.ajax", method = RequestMethod.POST)
	@ResponseBody
	public String putInfo(SurveyInfoVO vo, HttpServletRequest req) throws Exception {
		MemberVO adminVO = (MemberVO) req.getSession().getAttribute("loginVO");
		vo.setAdmin_id(adminVO.getUserId());
		return new Gson().toJson(service.insertInfo(vo));
	}
	
	@RequestMapping(value = "/updateInfo.ajax", method = RequestMethod.POST)
	@ResponseBody
	public String updateInfo(SurveyInfoVO vo, HttpServletRequest req) throws Exception {
		MemberVO adminVO = (MemberVO) req.getSession().getAttribute("loginVO");
		vo.setAdmin_id(adminVO.getUserId());
		return new Gson().toJson(service.updateInfo(vo));
	}

	@RequestMapping(value = "/putCategory.ajax", method = RequestMethod.POST)
	@ResponseBody
	public void putCategory(CategoryVO vo) throws Exception {
		service.insertCategory(vo);
	}

	@RequestMapping(value = "/putQuestionCode.ajax", method = RequestMethod.POST)
	@ResponseBody
	public void putQuestionCode(QuestionCodeVO vo) throws Exception {
		service.insertQuestionCode(vo);
	}

	@RequestMapping(value = "/putQuestion.ajax", method = RequestMethod.POST)
	@ResponseBody
	public String putQuestion(SurveyQuestionVO vo, char childType) throws Exception {

		if (childType == 'P') {
			vo.setType('2');
		}

		if (vo.getType() == '1' || vo.getType() == '2')
			vo.setQuestion_code(null);

		service.insertQuestion(vo);

		return "success";
	}

	@RequestMapping(value = "/getQuestionMax.ajax", method = RequestMethod.POST)
	@ResponseBody
	public int getQuestionMax(int seq) throws Exception {
		Integer cnt = service.selectQuestionCount(seq);
		
		if (cnt == null)
			return 1;
		else
			return cnt+1;
	}

	@RequestMapping(value = "/getQuestionDepthMax.ajax", method = RequestMethod.POST)
	@ResponseBody
	public int getQuestionDepthMax(SurveyQuestionVO vo) throws Exception {
		Integer cnt = service.selectQuestionDepthCount(vo);

		if (cnt == null)
			return 1;
		else
			return cnt+1;
	}
}
