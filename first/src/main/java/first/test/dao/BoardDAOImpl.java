package first.test.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import first.test.vo.BoardVO;
import first.test.vo.SearchCriteria;


@Repository
public class BoardDAOImpl implements BoardDAO {
	@Inject 
	private SqlSession session; 
	private static String namespace = "first.test.mapper.BoardMapper";
	@Override
	public void create(BoardVO vo) throws Exception {
		session.insert(namespace+".create", vo);
	}
	
	@Override
	public int updateReGroup(int bno) throws Exception {
		return session.update(namespace+".updateReGroup", bno);
	}
	
	@Override
	public BoardVO read(int bno) throws Exception {
		return session.selectOne(namespace+".read", bno);
	}
	@Override
	public void update(BoardVO vo) throws Exception {
		session.update(namespace+".update", vo);
	}
	@Override
	public void delete(int bno) throws Exception {
		session.delete(namespace+".delete", bno);
	}
	@Override
	public void updateViewcnt(int bno) throws Exception {
		session.update(namespace+".updateViewcnt", bno);
		
	}
	@Override
	public List<BoardVO> listSearch(SearchCriteria pvo) throws Exception {
		return session.selectList(namespace+".listSearch", pvo);
	}
	@Override
	public int listSearchCount(SearchCriteria pvo) throws Exception {
		return session.selectOne(namespace+".listSearchCount", pvo);
	}
	
	@Override
	public int reInsert(BoardVO vo) throws Exception {
		return session.insert(namespace+".reInsert", vo);		
	}
	@Override
	public int reUpdate(BoardVO vo) throws Exception {
		return session.update(namespace+".reUpdate", vo);		
	}	
	@Override
	public BoardVO readNotice() throws Exception {
		return session.selectOne(namespace+".readNotice");
	}

}