package first.test.service;

import java.util.List;

import first.test.vo.BoardVO;
import first.test.vo.SearchCriteria;



public interface BoardService {
	public void regist(BoardVO board) throws Exception; // 게시글 등록
	public BoardVO read(int bno) throws Exception; // 게시글 조회
	public void modify(BoardVO board) throws Exception; // 게시글 수정
	public void remove(int bno) throws Exception; // 게시글 삭제
	public void updateViewcnt(int bno) throws Exception; // 조회수 증가
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception; // 전체 게시글 목록
	public int listSearchCount(SearchCriteria cri) throws Exception; // 페이징 처리
	public int reRegist(BoardVO vo, int obno) throws Exception;
	public BoardVO readNotice() throws Exception;
	public int realDelete(BoardVO vo) throws Exception;
	public int restore(int bno) throws Exception;
	public List<BoardVO> selectDate() throws Exception;
}