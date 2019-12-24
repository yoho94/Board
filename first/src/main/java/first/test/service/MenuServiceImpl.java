package first.test.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import first.test.dao.MenuDAO;
import first.test.vo.MenuVO;

@Service
public class MenuServiceImpl implements MenuService{
	@Inject
	MenuDAO dao;

	@Override
	public List<MenuVO> selectAdminMenuList() throws Exception {
		return dao.selectAdminMenuList();
	}

	@Override
	public List<MenuVO> selectUserMenuList() throws Exception {
		return dao.selectUserMenuList();
	}

	@Override
	public Integer deleteMenu(MenuVO vo) throws Exception {
		Integer tmp = dao.deleteMenu(vo);
		dao.updateMenuOrder();
		return tmp;
	}

	@Override
	public Integer updateMenuOrderPlus1(MenuVO vo) throws Exception {
		return dao.updateMenuOrderPlus1(vo);
	}

	@Override
	public Integer updateMenuOrderMinus1(MenuVO vo) throws Exception {
		return dao.updateMenuOrderMinus1(vo);
	}

	@Override
	public Integer updateMenuOrder() throws Exception {
		return dao.updateMenuOrder();
	}	
	
	@Override
	public Integer insertMenu(MenuVO vo) throws Exception {
		dao.updateMenuOrderPlus1(vo);
		Integer tmp = dao.insertMenu(vo);
		dao.updateMenuOrder();
		return tmp;
	}

	@Override
	public Integer updateMenu(MenuVO vo, Integer originalOrder) throws Exception {
		if(originalOrder > vo.getOrder())
			dao.updateMenuOrderPlus1(vo);
		else
			dao.updateMenuOrderMinus1(vo);
		
		Integer returnValue = dao.updateMenu(vo);
		dao.updateMenuOrder();
		return returnValue;
	}

	@Override
	public Integer updateMenuOrderSortable(MenuVO vo, Integer originalOrder) throws Exception {
		if(originalOrder > vo.getOrder())
			dao.updateMenuOrderPlus1(vo);
		else
			dao.updateMenuOrderMinus1(vo);
		
		Integer returnValue = dao.updateMenuOrderSortable(vo);
		dao.updateMenuOrder();
		return returnValue;
	}
	
	@Override
	public MenuVO selectMenu(MenuVO vo) throws Exception {
		return dao.selectMenu(vo);
	}
	
	
}
