package first.test.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import first.test.dao.DashBoardDAO;
import first.test.vo.DashBoardVO;
import first.test.vo.MemberVO;

@Service
public class DashBoardServiceImpl implements DashBoardService {
	@Inject
	private DashBoardDAO dao;
	
	@Override
	public List<DashBoardVO> selectBoard(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectBoard(vo);
	}

	@Override
	public void insert(DashBoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.updateOrder(vo);
		dao.insert(vo);
	}

	@Override
	public void updateOrder(DashBoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.updateOrder(vo);
	}
	
	@Override
	public void delete(DashBoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.delete(vo);
	}
	
	@Override
	public void update(DashBoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.updateOrder(vo);
		dao.update(vo);
	}

}
