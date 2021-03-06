package first.test.dao;

import java.util.List;

import first.test.vo.DashBoardVO;
import first.test.vo.MemberVO;

public interface DashBoardDAO {
	public List<DashBoardVO> selectBoard(MemberVO vo) throws Exception;
	public void insert(DashBoardVO vo) throws Exception;
	public void updateOrder(DashBoardVO vo) throws Exception;
	public void delete(DashBoardVO vo) throws Exception;
	public void update(DashBoardVO vo) throws Exception;
}
