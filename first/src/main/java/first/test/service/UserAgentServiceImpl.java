package first.test.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import first.test.dao.UserAgentDAO;
import first.test.vo.BoardArticleVO;
import first.test.vo.SearchCriteria;
import first.test.vo.UserAgentVO;

@Service
public class UserAgentServiceImpl implements UserAgentService {

	@Inject
	private UserAgentDAO dao;

	@Override
	public void insert(UserAgentVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.insert(vo);
	}

	@Override
	public List<UserAgentVO> selectAll() throws Exception {
		// TODO Auto-generated method stub
		return dao.selectAll();
	}

	@Override
	public List<HashMap<String, Object>> selectDate(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectDate(map);
	}

	@Override
	public List<HashMap<String, Object>> selectOsName(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectOsName(map);
	}

	@Override
	public List<HashMap<String, Object>> selectOsVersion(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectOsVersion(map);
	}

	@Override
	public List<HashMap<String, Object>> selectBrowserName(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectBrowserName(map);
	}

	@Override
	public List<HashMap<String, Object>> selectBrowserVersion(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectBrowserVersion(map);
	}

	@Override
	public List<HashMap<String, Object>> selectDeviceBrand(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectDeviceBrand(map);
	}

	@Override
	public List<HashMap<String, Object>> selectDeviceModel(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectDeviceModel(map);
	}

	@Override
	public List<HashMap<String, Object>> selectId(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectId(map);
	}

	@Override
	public List<HashMap<String, Object>> selectIp(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectIp(map);
	}

	@Override
	public List<HashMap<String, Object>> selectReferer(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectReferer(map);
	}

	@Override
	public List<HashMap<String, Object>> selectPath(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectPath(map);
	}

	@Override
	public List<HashMap<String, Object>> selectIdNotNull(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectIdNotNull(map);
	}

	@Override
	public List<HashMap<String, Object>> selectRefererNotNull(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectRefererNotNull(map);
	}

	@Override
	public List<HashMap<String, Object>> selectNewVisit(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectNewVisit(map);
	}

	@Override
	public List<UserAgentVO> listSearch(SearchCriteria pvo) throws Exception {
		return dao.listSearch(pvo);
	}

	@Override
	public int listSearchCount(SearchCriteria pvo) throws Exception {
		return dao.listSearchCount(pvo);
	}

}
