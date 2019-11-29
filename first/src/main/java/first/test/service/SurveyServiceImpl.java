package first.test.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import first.test.dao.SurveyDAO;
import first.test.vo.CategoryVO;
import first.test.vo.QuestionCodeVO;
import first.test.vo.SurveyAnswerVO;
import first.test.vo.SurveyInfoVO;
import first.test.vo.SurveyQuestionVO;

@Service
public class SurveyServiceImpl implements SurveyService {
	@Inject
	SurveyDAO dao;

	@Override
	public SurveyInfoVO selectInfo(int seq) throws Exception {
		SurveyInfoVO vo = dao.selectInfo(seq);
		vo.setQuestion_count(dao.selectQuestionCount(seq));

		return vo;
	}

	@Override
	public List<SurveyQuestionVO> selectQuestion(int seq, int page) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		map.put("page", (page - 1) * 5);

		return dao.selectQuestion(map);
	}

	@Override
	public List<QuestionCodeVO> selectQuestionCode(int code) throws Exception {
		return dao.selectQuestionCode(code);
	}
	
	@Override
	public Integer selectQuestionDepthCount(SurveyQuestionVO vo) throws Exception {
		return dao.selectQuestionDepthCount(vo);
	}

	@Override
	public Integer selectQuestionCount(int seq) throws Exception {
		return dao.selectQuestionCount(seq);
	}

	@Override
	public int selectQuestionCount2(int seq) throws Exception {
		return dao.selectQuestionCount2(seq);
	}

	@Override
	public int selectAnswerCount(int seq, String id) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		map.put("id", id);

		return dao.selectAnswerCount(map);
	}

	@Override
	public List<SurveyAnswerVO> selectAnswerList(int seq, int page, String id) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		map.put("id", id);
		map.put("page", (page - 1) * 5);

		return dao.selectAnswerList(map);
	}

	@Override
	public void insertAnswer(SurveyAnswerVO vo) throws Exception {
		int result = dao.updateAnswer(vo);

		if (result == 0)
			dao.insertAnswer(vo);
	}

	@Override
	public int selectAnswerPeopleCount(SurveyInfoVO vo) throws Exception {
		return dao.selectAnswerPeopleCount(vo);
	}

	@Override
	public List<SurveyInfoVO> selectInfoList() throws Exception {
		List<SurveyInfoVO> list = dao.selectInfoList();

		for (int i = 0; i < list.size(); i++) {
			SurveyInfoVO vo = list.get(i);
			int answerPeopleCount = dao.selectAnswerPeopleCount(vo);
			vo.setAnswer_people_count(answerPeopleCount);
		}

		return list;
	}

	@Override
	public List<QuestionCodeVO> selectParentCode() throws Exception {
		return dao.selectParentCode();
	}

	@Override
	public List<CategoryVO> selectCategory() throws Exception {
		return dao.selectCategory();
	}

	@Override
	public SurveyInfoVO insertInfo(SurveyInfoVO vo) throws Exception {
		dao.insertInfo(vo);
		return vo;
	}
	
	@Override
	public SurveyInfoVO updateInfo(SurveyInfoVO vo) throws Exception {
		dao.updateInfo(vo);
		return vo;
	}

	@Override
	public void insertCategory(CategoryVO vo) throws Exception {
		dao.insertCategory(vo);
	}

	@Override
	public void insertQuestionCode(QuestionCodeVO vo) throws Exception {
		dao.insertQuestionCode(vo);
	}

	@Override
	public void insertQuestion(SurveyQuestionVO vo) throws Exception {
		dao.insertQuestion(vo);
	}

	@Override
	public List<SurveyInfoVO> selectAdminList() throws Exception {
		List<SurveyInfoVO> list = dao.selectAdminList();

		for (int i = 0; i < list.size(); i++) {
			SurveyInfoVO vo = list.get(i);
			int answerPeopleCount = dao.selectAnswerPeopleCount(vo);
			vo.setAnswer_people_count(answerPeopleCount);
		}

		return list;
	}

	@Override
	public void updateUsing(int seq) throws Exception {
		dao.updateUsing(seq);
	}

	@Override
	public void updateUnUsing(int seq) throws Exception {
		dao.updateUnUsing(seq);
	}

	@Override
	public void updateQuestionOrder(SurveyQuestionVO vo) throws Exception {
		dao.updateQuestionOrder(vo);
	}

	@Override
	@Transactional
	public void deleteQuestion(SurveyQuestionVO vo, int originalOrder, int originalDepth) throws Exception {
		SurveyQuestionVO delVO = new SurveyQuestionVO();
		delVO.setSurvey_seq(vo.getSurvey_seq());
		delVO.setQuestion_order(originalOrder);
		delVO.setQuestion_depth(originalDepth);		
		
		
		if(originalDepth == 0) {
			dao.deleteQuestionO(delVO);
			dao.deleteQuestionOrder(delVO);
		} else {
			dao.deleteQuestionD(delVO);
			dao.deleteQuestionDepth(delVO);
		}
		
	}

	@Override
	public SurveyInfoVO selectAdminInfo(int seq) throws Exception {
		SurveyInfoVO vo = dao.selectAdminInfo(seq);
		vo.setQuestion_count(dao.selectQuestionCount(seq));

		return vo;
	}
    
	@Override
	public List<SurveyQuestionVO> selectQuestionList(int seq) throws Exception {
		List<SurveyQuestionVO> list = dao.selectQuestionList(seq);
		
		for(int i=0; i<list.size(); i++) {
			Integer cnt = dao.selectQuestionDepthCount(list.get(i));

			if (cnt == null)
				list.get(i).setQuestionDepthMax(0);
			else
				list.get(i).setQuestionDepthMax(cnt);
		}
		
		
		return list;
	}
	
	@Override
	@Transactional
	public void updateQuestion(SurveyQuestionVO vo, int originalOrder, int originalDepth) throws Exception {
//		System.out.println(vo);
		int targetOrder = vo.getQuestion_order();
		int targetDepth = vo.getQuestion_depth();
		
		SurveyQuestionVO delVO = new SurveyQuestionVO();
		delVO.setSurvey_seq(vo.getSurvey_seq());
		delVO.setQuestion_order(originalOrder);
		delVO.setQuestion_depth(originalDepth);		
		dao.deleteQuestionD(delVO);
//		System.out.println(delVO);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("survey_seq", vo.getSurvey_seq());
		map.put("question_order", originalOrder);
		map.put("originalOrder", originalOrder);
		map.put("targetOrder", targetOrder);
		map.put("originalDepth", originalDepth);
		map.put("targetDepth", targetDepth);
		
		if(originalDepth == 0) {
			if(originalOrder > targetOrder) {
				dao.updateQuestionOrderMaxToMin(map);
			} else {
				dao.updateQuestionOrderMinToMax(map);
			}		
		} else {
			if(originalDepth > targetDepth) {
				dao.updateQuestionDepthMaxToMin(map);
			} else {
				dao.updateQuestionDepthMinToMax(map);
			}	
		}
		
//		System.out.println(vo);
		dao.insertQuestion(vo);		
		
	}

	@Override
	public void deleteCategory(CategoryVO vo) throws Exception {
		dao.deleteCategory(vo);
	}

	@Override
	public void deleteParentCode(QuestionCodeVO vo) throws Exception {
		dao.deleteParentCode(vo);
	}
	
}
