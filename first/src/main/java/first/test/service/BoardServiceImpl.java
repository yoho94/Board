package first.test.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import first.test.dao.BoardDAO;
import first.test.vo.BoardVO;
import first.test.vo.SearchCriteria;


@Service
public class BoardServiceImpl implements BoardService {
	@Inject
	private BoardDAO dao;
	@Override
	public void regist(BoardVO board) throws Exception {
		dao.create(board);
		dao.updateReGroup(board.getBno());
		System.out.println(board);
	}
	@Override
	public BoardVO read(int bno) throws Exception {
		return dao.read(bno);
	}
	@Override
	public void modify(BoardVO board) throws Exception {
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
	public List<BoardVO> listSearch(SearchCriteria pvo) throws Exception {
		return dao.listSearch(pvo);
	}
	@Override
	public int listSearchCount(SearchCriteria pvo) throws Exception {
		return dao.listSearchCount(pvo);
	}
	@Override
	public int reRegist(BoardVO vo, int obno) throws Exception {
		BoardVO oVO = dao.read(obno);
		dao.reUpdate(oVO);
		vo.setRe_group(oVO.getRe_group());
		vo.setRe_sorts(oVO.getRe_sorts() + 1);
		vo.setRe_depth(oVO.getRe_depth() + 1);		
		return dao.reInsert(vo);
	}

}