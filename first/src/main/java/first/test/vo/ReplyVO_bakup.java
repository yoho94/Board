package first.test.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ReplyVO_bakup {

	private int bno;
	private int rno;
	private String content;
	private String writer;
	private Date regDate;
	
	private int re_group;
	private int re_sorts;
	private int re_depth;
	
	private int isDelete;
	
	
	
	public int getRe_group() {
		return re_group;
	}
	public void setRe_group(int re_group) {
		this.re_group = re_group;
	}
	public int getRe_sorts() {
		return re_sorts;
	}
	public void setRe_sorts(int re_sorts) {
		this.re_sorts = re_sorts;
	}
	public int getRe_depth() {
		return re_depth;
	}
	public void setRe_depth(int re_depth) {
		this.re_depth = re_depth;
	}
	public int getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(int isDelete) {
		this.isDelete = isDelete;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
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
	@Override
	public String toString() {
		return "ReplyVO [bno=" + bno + ", rno=" + rno + ", content=" + content + ", writer=" + writer + ", regDate="
				+ regDate + "]";
	}
	
	public String getRegStr() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd (E) hh:mm");
		return format.format(regDate);
	}

	
	
	
}
