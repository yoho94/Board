package first.test.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import first.test.dao.BoardArticleDAO;
import first.test.vo.BoardArticleVO;
import first.test.vo.BoardBoardVO;
import first.test.vo.MemberVO;
import first.test.vo.SearchCriteria;


@Service
public class BoardArticleServiceImpl implements BoardArticleService {
	@Inject
	private BoardArticleDAO dao;
	
	
	
	@Override
	public List<BoardArticleVO> selectMainNoticeList(MemberVO loginVO) throws Exception {
		return dao.selectMainNoticeList(loginVO);
	}
	@Override
	public List<BoardArticleVO> selectMainReadList(MemberVO loginVO, SearchCriteria cri) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("userId", loginVO.getUserId());
		map.putAll(cri.getHashMap());
		
		return dao.selectMainReadList(map);
	}
	@Override
	public Integer selectMainReadListTotCnt(MemberVO loginVO, SearchCriteria cri) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("userId", loginVO.getUserId());
		map.putAll(cri.getHashMap());
		
		return dao.selectMainReadListTotCnt(map);
	}
	@Override
	public List<BoardArticleVO> selectNoticeList(BoardBoardVO vo) throws Exception {
		return dao.selectNoticeList(vo);
	}
	@Override
	public List<BoardArticleVO> selectReadList(MemberVO loginVO, BoardBoardVO boardVO, SearchCriteria cri)
			throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("userId", loginVO.getUserId());
		map.put("boardId", boardVO.getBoardId());
		map.putAll(cri.getHashMap());
		
		
		return dao.selectReadList(map);
	}

	@Override
	public List<BoardArticleVO> selectArticleList(BoardBoardVO boardVO, SearchCriteria cri) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("boardId", boardVO.getBoardId());
		map.putAll(cri.getHashMap());
		
		return dao.selectArticleList(map);
	}

	@Override
	public Integer selectReadListTotCnt(MemberVO loginVO, BoardBoardVO boardVO, SearchCriteria cri) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("userId", loginVO.getUserId());
		map.put("boardId", boardVO.getBoardId());
		map.putAll(cri.getHashMap());
		
		return dao.selectReadListTotCnt(map);
	}

	@Override
	public Integer selectArticleListTotCnt(BoardBoardVO boardVO, SearchCriteria cri) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("boardId", boardVO.getBoardId());
		map.putAll(cri.getHashMap());
		
		return dao.selectArticleListTotCnt(map);
	}

	@Override
	public BoardArticleVO selectArticle(BoardArticleVO vo) throws Exception {
		return dao.selectArticle(vo);
	}
	@Override
	public Integer insertArticle(BoardArticleVO vo) throws Exception {
		vo.setIsDelete('N');
		Integer tmp = dao.insertArticle(vo);
		dao.updateReGroup(vo.getBno());
		return tmp;
	}
	@Override
	public Integer updateArticle(BoardArticleVO vo) throws Exception {
		return dao.updateArticle(vo);
	}
	
	@Override
	public Integer insertReadTbl(MemberVO loginVO, BoardArticleVO articleVO) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("bno", articleVO.getBno());
		map.put("userId", loginVO.getUserId());		
		
		Integer tmp;
		
		try {
			tmp = dao.insertReadTbl(map);
		} catch (Exception e) {
			tmp = 0;
		}
		
		return tmp;
	}
	
	@Override
	public void regist(BoardArticleVO board) throws Exception {
		dao.create(board);
		dao.updateReGroup(board.getBno());
//		System.out.println(board);
	}
	@Override
	public BoardArticleVO read(int bno) throws Exception {
		return dao.read(bno);
	}
	@Override
	public void modify(BoardArticleVO board) throws Exception {
		dao.update(board);
	}
	@Override
	public void remove(int bno) throws Exception {
		dao.delete(bno);
	}
	@Override
	public void updateViewcnt(int bno) throws Exception {
		dao.updateViewcnt(bno);
	}
	@Override
	public List<BoardArticleVO> listSearch(SearchCriteria pvo) throws Exception {
		return dao.listSearch(pvo);
	}
	@Override
	public int listSearchCount(SearchCriteria pvo) throws Exception {
		return dao.listSearchCount(pvo);
	}
	@Override
	public int reRegist(BoardArticleVO vo, int obno) throws Exception {
		BoardArticleVO oVO = new BoardArticleVO();
		oVO.setBno(obno);
		oVO = dao.selectArticle(oVO);
		dao.reUpdate(oVO);
		vo.setRe_group(oVO.getRe_group());
		vo.setRe_sorts(oVO.getRe_sorts() + 1);
		vo.setRe_depth(oVO.getRe_depth() + 1);		
		return dao.reInsert(vo);
	}
	@Override
	public BoardArticleVO readNotice() throws Exception {
		return dao.readNotice();
	}
	@Override
	public int realDelete(BoardArticleVO vo) throws Exception {
		if(vo.getBno() == vo.getRe_group())
			return dao.realDeleteAll(vo);
		else
			return dao.realDelete(vo);		
	}
	@Override
	public int restore(int bno) throws Exception {
		return dao.restore(bno);
	}
	@Override
	public List<BoardArticleVO> selectDate() throws Exception {
		return dao.selectDate();
	}

}