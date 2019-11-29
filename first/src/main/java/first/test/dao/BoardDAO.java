package first.test.dao;

import java.util.List;

import first.test.vo.BoardVO;
import first.test.vo.SearchCriteria;


public interface BoardDAO {
	public void create(BoardVO vo) throws Exception; 
	public BoardVO read(int bno) throws Exception; 
	public void update(BoardVO vo) throws Exception; 
	public void delete(int bno) throws Exception; 
	public int realDelete(BoardVO vo) throws Exception;
	public void updateViewcnt(int bno) throws Exception;
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception;
	public int listSearchCount(SearchCriteria cri) throws Exception;
	public int reUpdate(BoardVO vo) throws Exception;
	public int reInsert(BoardVO vo) throws Exception;
	public int updateReGroup(int bno) throws Exception;
	public BoardVO readNotice() throws Exception;
	public int restore(int bno) throws Exception;
	public int realDeleteAll(BoardVO vo) throws Exception;
	public List<BoardVO> selectDate() throws Exception;
}