package first.test.service;

import java.util.List;

import first.test.vo.MenuVO;

public interface MenuService {
	public List<MenuVO> selectAdminMenuList() throws Exception;
	public List<MenuVO> selectUserMenuList() throws Exception;
	public MenuVO selectMenu(MenuVO vo) throws Exception;
	public Integer insertMenu(MenuVO vo) throws Exception;
	public Integer deleteMenu(MenuVO vo) throws Exception;
	public Integer updateMenu(MenuVO vo, Integer originalOrder) throws Exception;
	public Integer updateMenuOrderPlus1(MenuVO vo) throws Exception;
	public Integer updateMenuOrderMinus1(MenuVO vo) throws Exception;
	public Integer updateMenuOrder() throws Exception;
	public Integer updateMenuOrderSortable(MenuVO vo, Integer originalOrder) throws Exception;
	
}
