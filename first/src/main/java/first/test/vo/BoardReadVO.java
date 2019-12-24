package first.test.vo;

import java.sql.Timestamp;

public class BoardReadVO {
	private String userId;
	private Integer bno;
	private Timestamp regDate;
	private String regId;
	private Timestamp modDate;
	private String modId;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Integer getBno() {
		return bno;
	}
	public void setBno(Integer bno) {
		this.bno = bno;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public Timestamp getModDate() {
		return modDate;
	}
	public void setModDate(Timestamp modDate) {
		this.modDate = modDate;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
	@Override
	public String toString() {
		return "BoardReadVO [userId=" + userId + ", bno=" + bno + ", regDate=" + regDate + ", regId=" + regId
				+ ", modDate=" + modDate + ", modId=" + modId + "]";
	}
	
	
	
}
