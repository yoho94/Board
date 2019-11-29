package first.test.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import first.test.vo.PopupVO;

@Repository
public class PopupDAOImpl implements PopupDAO {
	
	@Inject 
	private SqlSession session; 
	private static String namespace = "first.test.mapper.PopupMapper";

	@Override
	public List<PopupVO> adminPopupList() throws Exception {
		return session.selectList(namespace + ".adminPopupList");
	}

	@Override
	public PopupVO selectPopupOne(int seq) throws Exception {
		return session.selectOne(namespace + ".selectPopupOne", seq);
	}

	@Override
	public List<PopupVO> mainPopupList() throws Exception {
		return session.selectList(namespace + ".mainPopupList");
	}

	@Override
	public void insertPopup(PopupVO vo) throws Exception {
		session.insert(namespace + ".insertPopup", vo);
	}

	@Override
	public void updatePopup(PopupVO vo) throws Exception {
		session.update(namespace + ".updatePopup", vo);
	}

	@Override
	public void deletePopup(int seq) throws Exception {
		session.delete(namespace + ".deletePopup", seq);
	}
	
	@Override
	public void updatePopupUsing(PopupVO vo) throws Exception {
		session.update(namespace + ".updatePopupUsing", vo);
	}

}
