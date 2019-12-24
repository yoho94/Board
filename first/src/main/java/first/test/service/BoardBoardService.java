package first.test.service;

import java.util.List;

import first.test.vo.BoardArticleVO;
import first.test.vo.BoardBoardVO;
import first.test.vo.SearchCriteria;



public interface BoardBoardService {
	public List<BoardBoardVO> selectBoardList(SearchCriteria cri) throws Exception;
	public Integer selectBoardListTotCnt() throws Exception;
	public List<BoardBoardVO> selectUserBoardList(SearchCriteria cri) throws Exception;
	public Integer selectUserBoardListTotCnt() throws Exception;
	public BoardBoardVO selectBoard(BoardBoardVO vo) throws Exception;
	public BoardBoardVO selectUrlBoard(BoardBoardVO vo) throws Exception;
	public Integer insertBoard(BoardBoardVO vo) throws Exception;
	public Integer updateBoard(BoardBoardVO vo, Integer originalOrder) throws Exception;
	public Integer deleteBoard(BoardBoardVO vo) throws Exception;
	public Integer updateBoardOrderPlus1(BoardBoardVO vo) throws Exception;
	public Integer updateBoardOrderMinus1(BoardBoardVO vo) throws Exception;
	public Integer updateBoardOrder() throws Exception;
	public Integer updateBoardOrderSortable(BoardBoardVO vo, Integer originalOrder) throws Exception;
}