package first.test.vo;

public class MenuVO {
	private Integer seq;
	private String name;
	private Integer order;
	private String url;
	private Character isUse;
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getOrder() {
		return order;
	}
	public void setOrder(Integer order) {
		this.order = order;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Character getIsUse() {
		return isUse;
	}
	public void setIsUse(Character isUse) {
		this.isUse = isUse;
	}
	@Override
	public String toString() {
		return "MenuVO [seq=" + seq + ", name=" + name + ", order=" + order + ", url=" + url + ", isUse=" + isUse + "]";
	}
	
	
}
