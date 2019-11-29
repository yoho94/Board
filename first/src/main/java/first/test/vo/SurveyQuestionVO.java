package first.test.vo;

import java.util.Date;

public class SurveyQuestionVO {
	private int survey_seq; 
	private int question_order;
	private int question_depth;
	private int category_code;
	private String category_name;
	private String question_name;
	private Integer question_code;
	private String title;
	private char type;
	private char is_free;
	private int number; 
	private Date reg_date; 
	private Date mod_date;
	private int questionDepthMax = 0;
	
	
	
	public int getQuestionDepthMax() {
		return questionDepthMax;
	}
	public void setQuestionDepthMax(int questionDepthMax) {
		this.questionDepthMax = questionDepthMax;
	}
	public String getQuestion_name() {
		return question_name;
	}
	public void setQuestion_name(String question_name) {
		this.question_name = question_name;
	}
	public int getCategory_code() {
		return category_code;
	}
	public void setCategory_code(int category_code) {
		this.category_code = category_code;
	}
	public int getSurvey_seq() {
		return survey_seq;
	}
	public void setSurvey_seq(int survey_seq) {
		this.survey_seq = survey_seq;
	}
	public int getQuestion_order() {
		return question_order;
	}
	public void setQuestion_order(int question_order) {
		this.question_order = question_order;
	}
	public int getQuestion_depth() {
		return question_depth;
	}
	public void setQuestion_depth(int question_depth) {
		this.question_depth = question_depth;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public Integer getQuestion_code() {
		return question_code;
	}
	public void setQuestion_code(Integer question_code) {
		this.question_code = question_code;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public char getType() {
		return type;
	}
	public void setType(char type) {
		this.type = type;
	}
	public char getIs_free() {
		return is_free;
	}
	public void setIs_free(char is_free) {
		this.is_free = is_free;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
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
		return "SurveyQuestionVO [survey_seq=" + survey_seq + ", question_order=" + question_order + ", question_depth="
				+ question_depth + ", category_code=" + category_code + ", category_name=" + category_name
				+ ", question_name=" + question_name + ", question_code=" + question_code + ", title=" + title
				+ ", type=" + type + ", is_free=" + is_free + ", number=" + number + ", reg_date=" + reg_date
				+ ", mod_date=" + mod_date + ", questionDepthMax=" + questionDepthMax + "]";
	}
	
	
}
