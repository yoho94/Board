package first.test.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import first.test.dao.PopupDAO;
import first.test.vo.PopupVO;

@Service
public class PopupServiceImpl implements PopupService {
	@Inject
	private PopupDAO dao;
	
	@Override
	public List<PopupVO> adminPopupList() throws Exception {
		return dao.adminPopupList();
	}

	@Override
	public PopupVO selectPopupOne(int seq) throws Exception {
		return dao.selectPopupOne(seq);
	}

	@Override
	public List<PopupVO> mainPopupList() throws Exception {
		return dao.mainPopupList();
	}

	@Override
	public void insertPopup(PopupVO vo) throws Exception {
		dao.insertPopup(vo);
	}

	@Override
	public void updatePopup(PopupVO vo) throws Exception {
		dao.updatePopup(vo);
	}

	@Override
	public void deletePopup(int seq) throws Exception {
		dao.deletePopup(seq);
	}
	
	@Override
	public void updatePopupUsing(PopupVO vo) throws Exception {
		dao.updatePopupUsing(vo);
	}

}
