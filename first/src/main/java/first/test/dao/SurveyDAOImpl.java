package first.test.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import first.test.vo.CategoryVO;
import first.test.vo.QuestionCodeVO;
import first.test.vo.SurveyAnswerVO;
import first.test.vo.SurveyInfoVO;
import first.test.vo.SurveyQuestionVO;

@Repository
public class SurveyDAOImpl implements SurveyDAO {
	@Inject
	private SqlSession session;

	private static String namespace = "first.test.mapper.SurveyMapper";

	@Override
	public SurveyInfoVO selectInfo(int seq) throws Exception {
		return session.selectOne(namespace + ".selectInfo", seq);
	}

	@Override
	public Integer selectQuestionCount(int seq) throws Exception {
		return session.selectOne(namespace + ".selectQuestionCount", seq);
	}

	@Override
	public List<SurveyQuestionVO> selectQuestion(HashMap<String, Object> map) throws Exception {
		return session.selectList(namespace + ".selectQuestion", map);
	}

	@Override
	public List<QuestionCodeVO> selectQuestionCode(int code) throws Exception {
		return session.selectList(namespace + ".selectQuestionCode", code);
	}

	@Override
	public int selectQuestionCount2(int seq) throws Exception {
		return session.selectOne(namespace + ".selectQuestionCount2", seq);
	}

	@Override
	public int selectAnswerCount(HashMap<String, Object> map) throws Exception {
		return session.selectOne(namespace + ".selectAnswerCount", map);
	}

	@Override
	public List<SurveyAnswerVO> selectAnswerList(HashMap<String, Object> map) throws Exception {
		return session.selectList(namespace + ".selectAnswerList", map);
	}

	@Override
	public void insertAnswer(SurveyAnswerVO vo) throws Exception {
		session.insert(namespace + ".insertAnswer", vo);
	}

	@Override
	public int updateAnswer(SurveyAnswerVO vo) throws Exception {
		return session.update(namespace + ".updateAnswer", vo);
	}

	@Override
	public int selectAnswerPeopleCount(SurveyInfoVO vo) throws Exception {
		return session.selectOne(namespace + ".selectAnswerPeopleCount", vo);
	}

	@Override
	public List<SurveyInfoVO> selectInfoList() throws Exception {
		return session.selectList(namespace + ".selectInfoList");
	}

	@Override
	public List<QuestionCodeVO> selectParentCode() throws Exception {
		return session.selectList(namespace + ".selectParentCode");
	}

	@Override
	public List<CategoryVO> selectCategory() throws Exception {
		return session.selectList(namespace + ".selectCategory");
	}

	@Override
	public void insertInfo(SurveyInfoVO vo) throws Exception {
		session.insert(namespace + ".insertInfo", vo);
	}

	@Override
	public void insertCategory(CategoryVO vo) throws Exception {
		session.insert(namespace + ".insertCategory", vo);
	}

	@Override
	public void insertQuestionCode(QuestionCodeVO vo) throws Exception {
		session.insert(namespace + ".insertQuestionCode", vo);
	}

	@Override
	public void insertQuestion(SurveyQuestionVO vo) throws Exception {
		session.insert(namespace + ".insertQuestion", vo);
	}

	@Override
	public List<SurveyInfoVO> selectAdminList() throws Exception {
		return session.selectList(namespace + ".selectAdminList");
	}

	@Override
	public void updateUsing(int seq) throws Exception {
		session.update(namespace + ".updateUsing", seq);
	}

	@Override
	public void updateUnUsing(int seq) throws Exception {
		session.update(namespace + ".updateUnUsing", seq);
	}

	@Override
	public void updateQuestionOrder(SurveyQuestionVO vo) throws Exception {
		session.update(namespace + ".updateQuestionOrder", vo);
	}

	@Override
	public void deleteQuestionO(SurveyQuestionVO vo) throws Exception {
		session.update(namespace + ".deleteQuestionO", vo);
	}
	
	@Override
	public void deleteQuestionD(SurveyQuestionVO vo) throws Exception {
		session.update(namespace + ".deleteQuestionD", vo);
	}

	@Override
	public void deleteQuestionOrder(SurveyQuestionVO vo) throws Exception {
		session.delete(namespace + ".deleteQuestionOrder", vo);
	}

	@Override
	public SurveyInfoVO selectAdminInfo(int seq) throws Exception {
		return session.selectOne(namespace + ".selectAdminInfo", seq);
	}

	@Override
	public Integer selectQuestionDepthCount(SurveyQuestionVO vo) throws Exception {
		return session.selectOne(namespace + ".selectQuestionDepthCount", vo);
	}
	
	@Override
	public List<SurveyQuestionVO> selectQuestionList(int seq) throws Exception {
		return session.selectList(namespace + ".selectQuestionList", seq);
	}
	
	@Override
	public void updateQuestion(SurveyQuestionVO vo) throws Exception {
		session.update(namespace + ".updateQuestion", vo);
	}

	@Override
	public void updateQuestionDepth(SurveyQuestionVO vo) throws Exception {
		session.update(namespace + ".updateQuestionDepth", vo);
	}

	@Override
	public void deleteQuestionDepth(SurveyQuestionVO vo) throws Exception {
		session.update(namespace + ".deleteQuestionDepth", vo);
	}

	@Override
	public void updateQuestionOrderMinToMax(HashMap<String, Object> map) throws Exception {
		session.update(namespace + ".updateQuestionOrderMinToMax", map);
	}

	@Override
	public void updateQuestionOrderMaxToMin(HashMap<String, Object> map) throws Exception {
		session.update(namespace + ".updateQuestionOrderMaxToMin", map);
	}

	@Override
	public void updateQuestionDepthMaxToMin(HashMap<String, Object> map) throws Exception {
		session.update(namespace + ".updateQuestionDepthMaxToMin", map);
	}
	
	@Override
	public void updateQuestionDepthMinToMax(HashMap<String, Object> map) throws Exception {
		session.update(namespace + ".updateQuestionDepthMinToMax", map);
	}
	
	@Override
	public void updateInfo(SurveyInfoVO vo) throws Exception {
		session.update(namespace + ".updateInfo", vo);
	}

	@Override
	public void deleteCategory(CategoryVO vo) throws Exception {
		session.delete(namespace + ".deleteCategory", vo);
	}

	@Override
	public void deleteParentCode(QuestionCodeVO vo) throws Exception {
		session.delete(namespace + ".deleteParentCode", vo);
	}
	
	
}
