package first.test.dao;

import java.util.HashMap;
import java.util.List;

import first.test.vo.BoardArticleVO;
import first.test.vo.BoardBoardVO;
import first.test.vo.MemberVO;
import first.test.vo.SearchCriteria;


public interface BoardArticleDAO {
	public List<BoardArticleVO> selectMainNoticeList(MemberVO loginVO) throws Exception;
	public List<BoardArticleVO> selectMainReadList(HashMap<String, Object> map) throws Exception;
	public Integer selectMainReadListTotCnt(HashMap<String, Object> map) throws Exception;
	public List<BoardArticleVO> selectNoticeList(BoardBoardVO vo) throws Exception;
	public List<BoardArticleVO> selectReadList(HashMap<String, Object> map) throws Exception;
	public List<BoardArticleVO> selectArticleList(HashMap<String, Object> map) throws Exception;
	public Integer selectReadListTotCnt(HashMap<String, Object> map) throws Exception;
	public Integer selectArticleListTotCnt(HashMap<String, Object> map) throws Exception;
	public BoardArticleVO selectArticle(BoardArticleVO vo) throws Exception;
	public Integer insertArticle(BoardArticleVO vo) throws Exception;
	public Integer updateArticle(BoardArticleVO vo) throws Exception;
	public Integer insertReadTbl(HashMap<String, Object> map) throws Exception;
	
	public void create(BoardArticleVO vo) throws Exception; 
	public BoardArticleVO read(int bno) throws Exception; 
	public void update(BoardArticleVO vo) throws Exception; 
	public void delete(int bno) throws Exception; 
	public int realDelete(BoardArticleVO vo) throws Exception;
	public void updateViewcnt(int bno) throws Exception;
	public List<BoardArticleVO> listSearch(SearchCriteria cri) throws Exception;
	public int listSearchCount(SearchCriteria cri) throws Exception;
	public int reUpdate(BoardArticleVO vo) throws Exception;
	public int reInsert(BoardArticleVO vo) throws Exception;
	public int updateReGroup(int bno) throws Exception;
	public BoardArticleVO readNotice() throws Exception;
	public int restore(int bno) throws Exception;
	public int realDeleteAll(BoardArticleVO vo) throws Exception;
	public List<BoardArticleVO> selectDate() throws Exception;
}