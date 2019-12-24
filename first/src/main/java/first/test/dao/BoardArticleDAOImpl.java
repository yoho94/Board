package first.test.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import first.test.vo.BoardArticleVO;
import first.test.vo.BoardBoardVO;
import first.test.vo.MemberVO;
import first.test.vo.SearchCriteria;


@Repository
public class BoardArticleDAOImpl implements BoardArticleDAO {
	@Inject 
	private SqlSession session; 
	private static String namespace = "first.test.mapper.BoardArticleMapper";
	
	
	
	@Override
	public Integer insertReadTbl(HashMap<String, Object> map) throws Exception {
		return session.insert(namespace + ".insertReadTbl", map);
	}
	
	@Override
	public List<BoardArticleVO> selectMainNoticeList(MemberVO loginVO) throws Exception {
		return session.selectList(namespace+".selectMainNoticeList", loginVO);
	}

	@Override
	public List<BoardArticleVO> selectMainReadList(HashMap<String, Object> map) throws Exception {
		return session.selectList(namespace+".selectMainReadList", map);
	}

	@Override
	public Integer selectMainReadListTotCnt(HashMap<String, Object> map) throws Exception {
		return session.selectOne(namespace+".selectMainReadListTotCnt", map);
	}

	@Override
	public List<BoardArticleVO> selectNoticeList(BoardBoardVO vo) throws Exception {
		return session.selectList(namespace+".selectNoticeList", vo);
	}

	@Override
	public List<BoardArticleVO> selectReadList(HashMap<String, Object> map) throws Exception {
		return session.selectList(namespace+".selectReadList", map);
	}

	@Override
	public List<BoardArticleVO> selectArticleList(HashMap<String, Object> map) throws Exception {
		return session.selectList(namespace+".selectArticleList", map);
	}

	@Override
	public Integer selectReadListTotCnt(HashMap<String, Object> map) throws Exception {
		return session.selectOne(namespace+".selectReadListTotCnt", map);
	}

	@Override
	public Integer selectArticleListTotCnt(HashMap<String, Object> map) throws Exception {
		return session.selectOne(namespace+".selectArticleListTotCnt", map);
	}

	@Override
	public BoardArticleVO selectArticle(BoardArticleVO vo) throws Exception {
		return session.selectOne(namespace+".selectArticle", vo);
	}

	@Override
	public Integer insertArticle(BoardArticleVO vo) throws Exception {
		return session.insert(namespace+".insertArticle", vo);
	}

	@Override
	public Integer updateArticle(BoardArticleVO vo) throws Exception {
		return session.update(namespace+".updateArticle", vo);
	}

	@Override
	public void create(BoardArticleVO vo) throws Exception {
		session.insert(namespace+".create", vo);
	}
	
	@Override
	public int updateReGroup(int bno) throws Exception {
		return session.update(namespace+".updateReGroup", bno);
	}
	
	@Override
	public BoardArticleVO read(int bno) throws Exception {
		return session.selectOne(namespace+".read", bno);
	}
	@Override
	public void update(BoardArticleVO vo) throws Exception {
		session.update(namespace+".update", vo);
	}
	@Override
	public void delete(int bno) throws Exception {
		session.delete(namespace+".delete", bno);
	}
	@Override
	public int realDelete(BoardArticleVO vo) throws Exception {
		return session.delete(namespace+".realDelete", vo);		
	}
	@Override
	public void updateViewcnt(int bno) throws Exception {
		session.update(namespace+".updateViewcnt", bno);		
	}
	@Override
	public List<BoardArticleVO> listSearch(SearchCriteria pvo) throws Exception {
		return session.selectList(namespace+".listSearch", pvo);
	}
	@Override
	public int listSearchCount(SearchCriteria pvo) throws Exception {
		return session.selectOne(namespace+".listSearchCount", pvo);
	}
	
	@Override
	public int reInsert(BoardArticleVO vo) throws Exception {
		return session.insert(namespace+".reInsert", vo);		
	}
	@Override
	public int reUpdate(BoardArticleVO vo) throws Exception {
		return session.update(namespace+".reUpdate", vo);		
	}	
	@Override
	public BoardArticleVO readNotice() throws Exception {
		return session.selectOne(namespace+".readNotice");
	}
	@Override
	public int restore(int bno) throws Exception {
		return session.update(namespace+".restore", bno);
	}
	@Override
	public int realDeleteAll(BoardArticleVO vo) throws Exception {
		return session.delete(namespace+".realDeleteAll", vo);
	}
	@Override
	public List<BoardArticleVO> selectDate() throws Exception {
		return session.selectList(namespace+".selectDate");
	}

}