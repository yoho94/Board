package first.test.service;

import java.util.HashMap;
import java.util.List;

import first.test.vo.BoardArticleVO;
import first.test.vo.BoardBoardVO;
import first.test.vo.MemberVO;
import first.test.vo.SearchCriteria;



public interface BoardArticleService {
	public List<BoardArticleVO> selectMainNoticeList(MemberVO loginVO) throws Exception;
	public List<BoardArticleVO> selectMainReadList(MemberVO loginVO, SearchCriteria cri) throws Exception;
	public Integer selectMainReadListTotCnt(MemberVO loginVO, SearchCriteria cri) throws Exception;
	public List<BoardArticleVO> selectNoticeList(BoardBoardVO vo) throws Exception;
	public List<BoardArticleVO> selectReadList(MemberVO loginVO, BoardBoardVO boardVO, SearchCriteria cri) throws Exception;
	public List<BoardArticleVO> selectArticleList(BoardBoardVO boardVO, SearchCriteria cri) throws Exception;
	public Integer selectReadListTotCnt(MemberVO loginVO, BoardBoardVO boardVO, SearchCriteria cri) throws Exception;
	public Integer selectArticleListTotCnt(BoardBoardVO boardVO, SearchCriteria cri) throws Exception;
	public BoardArticleVO selectArticle(BoardArticleVO vo) throws Exception;
	public Integer insertArticle(BoardArticleVO vo) throws Exception;
	public Integer updateArticle(BoardArticleVO vo) throws Exception;
	public Integer insertReadTbl(MemberVO loginVO, BoardArticleVO articleVO);
	
	public void regist(BoardArticleVO board) throws Exception; // 게시글 등록
	public BoardArticleVO read(int bno) throws Exception; // 게시글 조회
	public void modify(BoardArticleVO board) throws Exception; // 게시글 수정
	public void remove(int bno) throws Exception; // 게시글 삭제
	public void updateViewcnt(int bno) throws Exception; // 조회수 증가
	public List<BoardArticleVO> listSearch(SearchCriteria cri) throws Exception; // 전체 게시글 목록
	public int listSearchCount(SearchCriteria cri) throws Exception; // 페이징 처리
	public int reRegist(BoardArticleVO vo, int obno) throws Exception;
	public BoardArticleVO readNotice() throws Exception;
	public int realDelete(BoardArticleVO vo) throws Exception;
	public int restore(int bno) throws Exception;
	public List<BoardArticleVO> selectDate() throws Exception;
}