package first.test.dao;

import java.util.List;

import first.test.vo.PopupVO;

public interface PopupDAO {
	public List<PopupVO> adminPopupList() throws Exception;

	public PopupVO selectPopupOne(int seq) throws Exception;

	public List<PopupVO> mainPopupList() throws Exception;

	public void insertPopup(PopupVO vo) throws Exception;

	public void updatePopup(PopupVO vo) throws Exception;

	public void deletePopup(int seq) throws Exception;
	
	public void updatePopupUsing(PopupVO vo) throws Exception;
}
