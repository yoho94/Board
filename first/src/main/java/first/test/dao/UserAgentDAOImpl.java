package first.test.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import first.test.vo.BoardVO;
import first.test.vo.SearchCriteria;
import first.test.vo.UserAgentVO;

@Repository
public class UserAgentDAOImpl implements UserAgentDAO {
	
	@Inject 
	private SqlSession session; 
	private static String namespace = "first.test.mapper.UserAgentMapper";

	@Override
	public void insert(UserAgentVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace+".insert",vo);
	}

	@Override
	public List<UserAgentVO> selectAll() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectAll");
	}
	
	@Override
	public List<HashMap<String, Object>> selectDate(HashMap<String, Object> map) throws Exception {
		return session.selectList(namespace+".selectDate", map);
	}

	@Override
	public List<HashMap<String, Object>> selectOsName(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectOsName", map);
	}

	@Override
	public List<HashMap<String, Object>> selectOsVersion(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectOsVersion", map);
	}

	@Override
	public List<HashMap<String, Object>> selectBrowserName(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectBrowserName", map);
	}

	@Override
	public List<HashMap<String, Object>> selectBrowserVersion(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectBrowserVersion", map);
	}

	@Override
	public List<HashMap<String, Object>> selectDeviceBrand(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectDeviceBrand", map);
	}

	@Override
	public List<HashMap<String, Object>> selectDeviceModel(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectDeviceModel", map);
	}

	@Override
	public List<HashMap<String, Object>> selectId(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectId", map);
	}

	@Override
	public List<HashMap<String, Object>> selectIp(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectIp", map);
	}

	@Override
	public List<HashMap<String, Object>> selectReferer(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectReferer", map);
	}

	@Override
	public List<HashMap<String, Object>> selectPath(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectPath", map);
	}

	@Override
	public List<HashMap<String, Object>> selectIdNotNull(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectIdNotNull", map);
	}

	@Override
	public List<HashMap<String, Object>> selectRefererNotNull(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectRefererNotNull", map);
	}
	
	@Override
	public List<HashMap<String, Object>> selectNewVisit(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectNewVisit", map);
	}
	
	@Override
	public List<UserAgentVO> listSearch(SearchCriteria pvo) throws Exception {
		return session.selectList(namespace+".listSearch", pvo);
	}
	
	@Override
	public int listSearchCount(SearchCriteria pvo) throws Exception {
		return session.selectOne(namespace+".listSearchCount", pvo);
	}
	

}
