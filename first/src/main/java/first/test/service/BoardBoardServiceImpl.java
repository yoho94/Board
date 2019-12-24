package first.test.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import first.test.dao.BoardBoardDAO;
import first.test.vo.BoardBoardVO;
import first.test.vo.SearchCriteria;


@Service
public class BoardBoardServiceImpl implements BoardBoardService {

	@Inject
	BoardBoardDAO dao;
	
	@Override
	public List<BoardBoardVO> selectBoardList(SearchCriteria cri) throws Exception {
		return dao.selectBoardList(cri);
	}

	@Override
	public Integer selectBoardListTotCnt() throws Exception {
		return dao.selectBoardListTotCnt();
	}
	
	@Override
	public List<BoardBoardVO> selectUserBoardList(SearchCriteria cri) throws Exception {
		return dao.selectUserBoardList(cri);
	}

	@Override
	public Integer selectUserBoardListTotCnt() throws Exception {
		return dao.selectUserBoardListTotCnt();
	}

	@Override
	public BoardBoardVO selectBoard(BoardBoardVO vo) throws Exception {
		return dao.selectBoard(vo);
	}

	@Override
	public BoardBoardVO selectUrlBoard(BoardBoardVO vo) throws Exception {
		return dao.selectUrlBoard(vo);
	}

	@Override
	public Integer insertBoard(BoardBoardVO vo) throws Exception {
		dao.updateBoardOrderPlus1(vo);
		Integer returnValue = dao.insertBoard(vo);
		dao.updateBoardOrder();
		return returnValue;
	}

	@Override
	public Integer updateBoard(BoardBoardVO vo, Integer originalOrder) throws Exception {
		if(originalOrder > vo.getOrder())
			dao.updateBoardOrderPlus1(vo);
		else
			dao.updateBoardOrderMinus1(vo);
		
		Integer returnValue = dao.updateBoard(vo);
		dao.updateBoardOrder();
		return returnValue;
	}

	@Override
	public Integer deleteBoard(BoardBoardVO vo) throws Exception {
		return dao.deleteBoard(vo);
	}

	@Override
	public Integer updateBoardOrderPlus1(BoardBoardVO vo) throws Exception {
		return dao.updateBoardOrderPlus1(vo);
	}
	

	@Override
	public Integer updateBoardOrderMinus1(BoardBoardVO vo) throws Exception {
		return dao.updateBoardOrderMinus1(vo);
	}

	@Override
	public Integer updateBoardOrder() throws Exception {
		return dao.updateBoardOrder();
	}
	
	@Override
	public Integer updateBoardOrderSortable(BoardBoardVO vo, Integer originalOrder) throws Exception {
		if(originalOrder > vo.getOrder())
			dao.updateBoardOrderPlus1(vo);
		else
			dao.updateBoardOrderMinus1(vo);
		
		Integer returnValue = dao.updateBoardOrderSortable(vo);
		dao.updateBoardOrder();
		return returnValue;
	}
	
}