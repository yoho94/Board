package first.test.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import first.test.vo.DashBoardVO;
import first.test.vo.MemberVO;

@Repository
public class DashBoardDAOImpl implements DashBoardDAO {

	@Inject 
	private SqlSession session; 
	private static String namespace = "first.test.mapper.DashBoardMapper";
	
	@Override
	public List<DashBoardVO> selectBoard(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectBoard", vo);
		
	}

	@Override
	public void insert(DashBoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace+".insert", vo);
	}

	@Override
	public void updateOrder(DashBoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace+".updateOrder", vo);
	}
	
	@Override
	public void delete(DashBoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace+".delete", vo);
	}
	@Override
	public void update(DashBoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace+".update", vo);
	}

}
