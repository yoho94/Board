package first.test.vo;

public class ReplyUserLike {
	private Integer bno;
	private Integer rno;
	private String userId;
	private Character likeType;
	
	
	public Integer getBno() {
		return bno;
	}
	public void setBno(Integer bno) {
		this.bno = bno;
	}
	public Integer getRno() {
		return rno;
	}
	public void setRno(Integer rno) {
		this.rno = rno;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Character getLikeType() {
		return likeType;
	}
	public void setLikeType(Character likeType) {
		this.likeType = likeType;
	}
	
	@Override
	public String toString() {
		return "ReplyUserLike [rno=" + rno + ", userId=" + userId + ", likeType=" + likeType + "]";
	}
	
	
}
