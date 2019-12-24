package first.test.vo;

import java.util.HashMap;

public class PageVO {
	private int page = 1;
	private int perPageNum = 10;
	
	public HashMap<String, Object> getHashMap() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("page", page);
		map.put("perPageNum", perPageNum);
		map.put("pageStart", (this.page-1) * perPageNum);
		
		return map;
	}
	
	public PageVO() {
		this.page = 1;
		this.perPageNum = 10;
	}
	
	public int getPage() {
		return page;
	}
	public void setPage(Integer page) {
		if (page == null || page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	public int getPerPageNum() {
		return perPageNum;
	}
	public void setPerPageNum(Integer perPageNum) {
		if (perPageNum == null || perPageNum <=0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}
	
	// method for MyBatis SQL Mapper
	public int getPageStart() {
		return (this.page-1) * perPageNum;
	}
	
	@Override
	public String toString() {
		return "PageVO [page=" + page + ", perPageNum=" + perPageNum + "]";
	}
	
}