package first.test.dao;

import java.util.HashMap;
import java.util.List;

import first.test.vo.CategoryVO;
import first.test.vo.QuestionCodeVO;
import first.test.vo.SurveyAnswerVO;
import first.test.vo.SurveyInfoVO;
import first.test.vo.SurveyQuestionVO;

public interface SurveyDAO {
	public SurveyInfoVO selectInfo(int seq) throws Exception;
	public Integer selectQuestionCount(int seq) throws Exception;
	public List<SurveyQuestionVO> selectQuestion(HashMap<String, Object> map) throws Exception;
	public List<QuestionCodeVO> selectQuestionCode(int code) throws Exception;
	public int selectQuestionCount2(int seq) throws Exception;
	public Integer selectQuestionDepthCount(SurveyQuestionVO vo) throws Exception;
	public int selectAnswerCount(HashMap<String, Object> map) throws Exception;
	public List<SurveyAnswerVO> selectAnswerList(HashMap<String, Object> map) throws Exception;
	public void insertAnswer(SurveyAnswerVO vo) throws Exception;
	public int updateAnswer(SurveyAnswerVO vo) throws Exception;
	public int selectAnswerPeopleCount(SurveyInfoVO vo) throws Exception;
	public List<SurveyInfoVO> selectInfoList() throws Exception;
	public List<QuestionCodeVO> selectParentCode() throws Exception;
	public List<CategoryVO> selectCategory() throws Exception;
	public void insertInfo(SurveyInfoVO vo) throws Exception;
	public void insertCategory(CategoryVO vo) throws Exception;
	public void insertQuestionCode(QuestionCodeVO vo) throws Exception;
	public void insertQuestion(SurveyQuestionVO vo) throws Exception;
	
	// Admin
	public List<SurveyInfoVO> selectAdminList() throws Exception;
	public SurveyInfoVO selectAdminInfo(int seq) throws Exception;
	public void updateUsing(int seq) throws Exception;
	public void updateUnUsing(int seq) throws Exception;
	public void updateQuestionOrder(SurveyQuestionVO vo) throws Exception;
	public void updateQuestionDepth(SurveyQuestionVO vo) throws Exception;
	public void deleteQuestionO(SurveyQuestionVO vo) throws Exception;
	public void deleteQuestionD(SurveyQuestionVO vo) throws Exception;
	public void deleteQuestionOrder(SurveyQuestionVO vo) throws Exception;
	public void deleteQuestionDepth(SurveyQuestionVO vo) throws Exception;
	public List<SurveyQuestionVO> selectQuestionList(int seq) throws Exception;
	public void updateQuestion(SurveyQuestionVO vo) throws Exception;
	public void updateQuestionOrderMinToMax(HashMap<String, Object> map) throws Exception;
	public void updateQuestionOrderMaxToMin(HashMap<String, Object> map) throws Exception;
	public void updateQuestionDepthMinToMax(HashMap<String, Object> map) throws Exception;
	public void updateQuestionDepthMaxToMin(HashMap<String, Object> map) throws Exception;
	public void updateInfo(SurveyInfoVO vo) throws Exception;
	public void deleteCategory(CategoryVO vo) throws Exception;
	public void deleteParentCode(QuestionCodeVO vo) throws Exception;
}
