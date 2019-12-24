package first.test.dao;

import java.util.List;

import first.test.vo.MenuVO;


public interface MenuDAO {
	public List<MenuVO> selectAdminMenuList() throws Exception;
	public List<MenuVO> selectUserMenuList() throws Exception;
	public MenuVO selectMenu(MenuVO vo) throws Exception;
	public Integer deleteMenu(MenuVO vo) throws Exception;
	public Integer updateMenu(MenuVO vo) throws Exception;
	public Integer updateMenuOrderPlus1(MenuVO vo) throws Exception;
	public Integer updateMenuOrderMinus1(MenuVO vo) throws Exception;
	public Integer updateMenuOrder() throws Exception;
	public Integer updateMenuOrderSortable(MenuVO vo) throws Exception;
	public Integer insertMenu(MenuVO vo) throws Exception;
}