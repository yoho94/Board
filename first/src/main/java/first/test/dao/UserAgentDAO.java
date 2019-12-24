package first.test.dao;

import java.util.HashMap;
import java.util.List;

import first.test.vo.BoardArticleVO;
import first.test.vo.SearchCriteria;
import first.test.vo.UserAgentVO;

public interface UserAgentDAO {
	public void insert(UserAgentVO vo) throws Exception;
	public List<UserAgentVO> selectAll() throws Exception;
	public List<HashMap<String, Object>> selectDate(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectNewVisit(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectOsName(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectOsVersion(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectBrowserName(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectBrowserVersion(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectDeviceBrand(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectDeviceModel(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectId(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectIp(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectReferer(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectPath(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectIdNotNull(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectRefererNotNull(HashMap<String, Object> map) throws Exception;
	
	public List<UserAgentVO> listSearch(SearchCriteria cri) throws Exception;
	public int listSearchCount(SearchCriteria cri) throws Exception;
}
