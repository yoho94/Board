package first.test.service;

import java.util.List;

import first.test.vo.CategoryVO;
import first.test.vo.QuestionCodeVO;
import first.test.vo.SurveyAnswerVO;
import first.test.vo.SurveyInfoVO;
import first.test.vo.SurveyQuestionVO;

public interface SurveyService {
	public SurveyInfoVO selectInfo(int seq) throws Exception;
	public List<SurveyQuestionVO> selectQuestion(int seq, int page) throws Exception;
	public List<QuestionCodeVO> selectQuestionCode(int code) throws Exception;
	public Integer selectQuestionCount(int seq) throws Exception;
	public Integer selectQuestionDepthCount(SurveyQuestionVO vo) throws Exception;
	public int selectQuestionCount2(int seq) throws Exception;
	public int selectAnswerCount(int seq, String id) throws Exception;
	public List<SurveyAnswerVO> selectAnswerList(int seq, int page, String id) throws Exception;
	public void insertAnswer(SurveyAnswerVO vo) throws Exception;
	public int selectAnswerPeopleCount(SurveyInfoVO vo) throws Exception;
	public List<SurveyInfoVO> selectInfoList() throws Exception;
	public List<QuestionCodeVO> selectParentCode() throws Exception;
	public List<CategoryVO> selectCategory() throws Exception;
	public SurveyInfoVO insertInfo(SurveyInfoVO vo) throws Exception;
	public void insertCategory(CategoryVO vo) throws Exception;
	public void insertQuestionCode(QuestionCodeVO vo) throws Exception;
	public void insertQuestion(SurveyQuestionVO vo) throws Exception;
	
	// Admin
	public List<SurveyInfoVO> selectAdminList() throws Exception;
	public SurveyInfoVO selectAdminInfo(int seq) throws Exception;
	public void updateUsing(int seq) throws Exception;
	public void updateUnUsing(int seq) throws Exception;
	public void updateQuestionOrder(SurveyQuestionVO vo) throws Exception;
	public void deleteQuestion(SurveyQuestionVO vo, int originalOrder, int originalDepth) throws Exception;
	public List<SurveyQuestionVO> selectQuestionList(int seq) throws Exception;
	public void updateQuestion(SurveyQuestionVO vo, int originalOrder, int originalDepth) throws Exception;
	public SurveyInfoVO updateInfo(SurveyInfoVO vo) throws Exception;
	public void deleteCategory(CategoryVO vo) throws Exception;
	public void deleteParentCode(QuestionCodeVO vo) throws Exception;
}
