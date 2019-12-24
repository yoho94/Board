package first.test.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ReplyVO {

	private Integer bno;
	private Integer rno;
	private Integer good_score;
	private Integer bad_score;
	private Integer parent;
	private String content;
	private String writer;
	private Date regDate;
	private Integer isDelete;
	
	private Integer re_depth;
	
	
	public Integer getRe_depth() {
		return re_depth;
	}
	public void setRe_depth(Integer re_depth) {
		this.re_depth = re_depth;
	}
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
	public Integer getGood_score() {
		return good_score;
	}
	public void setGood_score(Integer good_score) {
		this.good_score = good_score;
	}
	public Integer getBad_score() {
		return bad_score;
	}
	public void setBad_score(Integer bad_score) {
		this.bad_score = bad_score;
	}
	public Integer getParent() {
		return parent;
	}
	public void setParent(Integer parent) {
		this.parent = parent;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getRegDateStr() {
		if(regDate == null)
			return null;
		SimpleDateFormat foramt = new SimpleDateFormat("yyyy년 MM월 dd일 E요일 HH:mm:ss");
		return foramt.format(regDate);
	}
	public Integer getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}
	@Override
	public String toString() {
		return "ReplyVO [bno=" + bno + ", rno=" + rno + ", good_score=" + good_score + ", bad_score=" + bad_score
				+ ", parent=" + parent + ", content=" + content + ", writer=" + writer + ", regDate=" + regDate
				+ ", isDelete=" + isDelete + ", re_depth=" + re_depth + "]";
	}
	
	
}
