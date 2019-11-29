package first.test.vo;

import java.util.Date;

public class QuestionCodeVO {
	private int question_code;
	private Integer parent_code;
	private String question_name;
	private Date reg_date; 
	private Date mod_date;
	public int getQuestion_code() {
		return question_code;
	}
	public void setQuestion_code(int question_code) {
		this.question_code = question_code;
	}
	public Integer getParent_code() {
		return parent_code;
	}
	public void setParent_code(Integer parent_code) {
		this.parent_code = parent_code;
	}
	public String getQuestion_name() {
		return question_name;
	}
	public void setQuestion_name(String question_name) {
		this.question_name = question_name;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public Date getMod_date() {
		return mod_date;
	}
	public void setMod_date(Date mod_date) {
		this.mod_date = mod_date;
	}
	@Override
	public String toString() {
		return "QuestionCode [question_code=" + question_code + ", parent_code=" + parent_code + ", question_name="
				+ question_name + ", reg_date=" + reg_date + ", mod_date=" + mod_date + "]";
	}
	
	

}
