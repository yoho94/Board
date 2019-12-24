package first.test.vo;

import java.sql.Timestamp;

public class BoardBoardVO {
	private Integer boardId;
	private String boardType;
	private String note;
	private String name;
	private Integer order;
	private Character isRpy;
	private Character isComment;
	private Character isSecret;
	private Character isNotice;
	private Character isUse;
	private String url;
	private Timestamp regDate;
	private String regId;
	private Timestamp modDate;
	private String modId;
	public Integer getBoardId() {
		return boardId;
	}
	public void setBoardId(Integer boardId) {
		this.boardId = boardId;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
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
	public Character getIsRpy() {
		return isRpy;
	}
	public void setIsRpy(Character isRpy) {
		this.isRpy = isRpy;
	}
	public Character getIsComment() {
		return isComment;
	}
	public void setIsComment(Character isComment) {
		this.isComment = isComment;
	}
	public Character getIsSecret() {
		return isSecret;
	}
	public void setIsSecret(Character isSecret) {
		this.isSecret = isSecret;
	}
	public Character getIsNotice() {
		return isNotice;
	}
	public void setIsNotice(Character isNotice) {
		this.isNotice = isNotice;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
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
		return "BoardBoardVO [boardId=" + boardId + ", boardType=" + boardType + ", note=" + note + ", name=" + name
				+ ", order=" + order + ", isRpy=" + isRpy + ", isComment=" + isComment + ", isSecret=" + isSecret
				+ ", isNotice=" + isNotice + ", url=" + url + ", regDate=" + regDate + ", regId=" + regId + ", modDate="
				+ modDate + ", modId=" + modId + "]";
	}
	public Character getIsUse() {
		return isUse;
	}
	public void setIsUse(Character isUse) {
		this.isUse = isUse;
	}
	
	

	
	
}
