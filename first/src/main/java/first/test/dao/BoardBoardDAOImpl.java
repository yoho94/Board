package first.test.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import first.test.vo.BoardBoardVO;
import first.test.vo.SearchCriteria;

@Repository
public class BoardBoardDAOImpl implements BoardBoardDAO {
	@Inject 
	private SqlSession session; 
	private static String namespace = "first.test.mapper.BoardBoardMapper";

	@Override
	public List<BoardBoardVO> selectBoardList(SearchCriteria cri) throws Exception {
		return session.selectList(namespace+".selectBoardList", cri);
	}

	@Override
	public Integer selectBoardListTotCnt() throws Exception {
		return session.selectOne(namespace+".selectBoardListTotCnt");
	}
	
	@Override
	public List<BoardBoardVO> selectUserBoardList(SearchCriteria cri) throws Exception {
		return session.selectList(namespace+".selectUserBoardList", cri);
	}

	@Override
	public Integer selectUserBoardListTotCnt() throws Exception {
		return session.selectOne(namespace+".selectUserBoardListTotCnt");
	}

	@Override
	public BoardBoardVO selectBoard(BoardBoardVO vo) throws Exception {
		return session.selectOne(namespace+".selectBoard", vo);
	}

	@Override
	public BoardBoardVO selectUrlBoard(BoardBoardVO vo) throws Exception {
		return session.selectOne(namespace+".selectUrlBoard", vo);
	}

	@Override
	public Integer insertBoard(BoardBoardVO vo) throws Exception {
		return session.selectOne(namespace+".insertBoard", vo);
	}

	@Override
	public Integer updateBoard(BoardBoardVO vo) throws Exception {
		return session.selectOne(namespace+".updateBoard", vo);
	}

	@Override
	public Integer deleteBoard(BoardBoardVO vo) throws Exception {
		return session.selectOne(namespace+".deleteBoard", vo);
	}

	@Override
	public Integer updateBoardOrderPlus1(BoardBoardVO vo) throws Exception {
		return session.update(namespace + ".updateBoardOrderPlus1", vo);
	}

	@Override
	public Integer updateBoardOrderMinus1(BoardBoardVO vo) throws Exception {
		return session.update(namespace + ".updateBoardOrderMinus1", vo);
	}
	
	@Override
	public Integer updateBoardOrder() throws Exception {
		return session.update(namespace+".updateBoardOrder");
	}
	
	@Override
	public Integer updateBoardOrderSortable(BoardBoardVO vo) throws Exception {
		return session.update(namespace+".updateBoardOrderSortable", vo);
	}
	
}
