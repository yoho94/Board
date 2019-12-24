package first.test.vo;

import java.util.Date;
import java.util.HashMap;

public class SearchCriteria extends PageVO{
	private String searchType;
	private String keyword = "";
	private Date startDate;
	private Date endDate;
	
	@Override
	public HashMap<String, Object> getHashMap() {
		HashMap<String, Object> map = super.getHashMap();
		map.put("searchType", searchType);
		map.put("keyword", keyword);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		
		return map;
	}
	
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public SearchCriteria() {
		
	}
	public SearchCriteria(String searchType, String keyword) {
		super();
		this.searchType = searchType;
		this.keyword = keyword;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	@Override
	public String toString() {
		return "SearchCriteria [searchType=" + searchType + ", keyword=" + keyword + "]";
	}
	
}