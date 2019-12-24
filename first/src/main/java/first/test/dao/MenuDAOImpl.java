package first.test.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import first.test.vo.MenuVO;

@Repository
public class MenuDAOImpl implements MenuDAO {
	@Inject
	private SqlSession session;
	private static String namespace = "first.test.mapper.MenuMapper";

	@Override
	public List<MenuVO> selectAdminMenuList() throws Exception {
		return session.selectList(namespace + ".selectAdminMenuList");
	}

	@Override
	public List<MenuVO> selectUserMenuList() throws Exception {
		return session.selectList(namespace + ".selectUserMenuList");
	}

	@Override
	public Integer deleteMenu(MenuVO vo) throws Exception {
		return session.delete(namespace + ".deleteMenu", vo);
	}

	@Override
	public Integer updateMenuOrderPlus1(MenuVO vo) throws Exception {
		return session.update(namespace + ".updateMenuOrderPlus1", vo);
	}

	@Override
	public Integer updateMenuOrderMinus1(MenuVO vo) throws Exception {
		return session.update(namespace + ".updateMenuOrderMinus1", vo);
	}

	@Override
	public Integer updateMenuOrder() throws Exception {
		return session.update(namespace + ".updateMenuOrder");
	}

	@Override
	public Integer updateMenuOrderSortable(MenuVO vo) throws Exception {
		return session.update(namespace + ".updateMenuOrderSortable", vo);
	}

	@Override
	public Integer insertMenu(MenuVO vo) throws Exception {
		return session.insert(namespace + ".insertMenu", vo);
	}

	@Override
	public Integer updateMenu(MenuVO vo) throws Exception {
		return session.update(namespace + ".updateMenu", vo);
	}

	@Override
	public MenuVO selectMenu(MenuVO vo) throws Exception {
		return session.selectOne(namespace+".selectMenu", vo);
	}
	
	

}
