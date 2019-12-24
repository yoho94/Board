package first.test.vo;

import java.sql.Timestamp;

import com.nhncorp.lucy.security.xss.LucyXssFilter;
import com.nhncorp.lucy.security.xss.XssPreventer;
import com.nhncorp.lucy.security.xss.XssSaxFilter;

public class BoardArticleVO {
	private String name;
	private Integer boardId;
	private Integer bno;
	private String title;
	private String content;
	private String writer;
	private Timestamp regDate;
	private Integer viewcnt;
	private Timestamp modDate;
	private String modWriter;
	private String password;
	private Integer re_group;
	private Integer re_sorts;
	private Integer re_depth;
	private Character isDelete = 'N';
	private Character isNotice = 'N';
	private Character isSecret = 'N';
	
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getBno() {
		return bno;
	}
	public void setBno(Integer bno) {
		this.bno = bno;
	}
	public String getTitle() {		
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content.replaceAll("'", "&#039;");
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer.replaceAll("'", "&#039;");
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public Integer getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(Integer viewcnt) {
		this.viewcnt = viewcnt;
	}
	public Integer getRe_group() {
		return (re_group == null) ? 0 : re_group;
	}
	public void setRe_group(Integer re_group) {
		this.re_group = re_group;
	}
	public Integer getRe_sorts() {
		return (re_sorts == null) ? 0 : re_sorts;
	}
	public void setRe_sorts(Integer re_sorts) {
		this.re_sorts = re_sorts;
	}
	public Integer getRe_depth() {
		return (re_depth == null) ? 0 : re_depth;
	}
	public void setRe_depth(Integer re_depth) {
		this.re_depth = re_depth;
	}
	public Integer getBoardId() {
		return boardId;
	}
	public void setBoardId(Integer boardId) {
		this.boardId = boardId;
	}
	public Timestamp getModDate() {
		return modDate;
	}
	public void setModDate(Timestamp modDate) {
		this.modDate = modDate;
	}
	public String getModWriter() {
		return modWriter;
	}
	public void setModWriter(String modWriter) {
		this.modWriter = modWriter;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Character getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(Character isDelete) {
		this.isDelete = isDelete;
	}
	public Character getIsNotice() {
		return isNotice;
	}
	public void setIsNotice(Character isNotice) {
		this.isNotice = isNotice;
	}
	public Character getIsSecret() {
		return isSecret;
	}
	public void setIsSecret(Character isSecret) {
		this.isSecret = isSecret;
	}
	
	@Override
	public String toString() {
		return "BoardArticleVO [boardId=" + boardId + ", bno=" + bno + ", title=" + title + ", content=" + content
				+ ", writer=" + writer + ", regDate=" + regDate + ", viewcnt=" + viewcnt + ", modDate=" + modDate
				+ ", modWriter=" + modWriter + ", password=" + password + ", re_group=" + re_group + ", re_sorts="
				+ re_sorts + ", re_depth=" + re_depth + ", isDelete=" + isDelete + ", isNotice=" + isNotice
				+ ", isSecret=" + isSecret + "]";
	}
	

}
