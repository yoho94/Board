package first.test.vo;

import java.sql.Timestamp;

public class SurveyAnswerVO {
	private int survey_seq;
	private int question_order; 
	private int question_depth; 
	private String user_id; 
	private String subjective_answer; 
	private String choice_answer; 
	private Timestamp reg_date; 
	private Timestamp mod_date;
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
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getSubjective_answer() {
		return subjective_answer;
	}
	public void setSubjective_answer(String subjective_answer) {
		this.subjective_answer = subjective_answer;
	}
	public String getChoice_answer() {
		return choice_answer;
	}
	public void setChoice_answer(String choice_answer) {
		this.choice_answer = choice_answer;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public Timestamp getMod_date() {
		return mod_date;
	}
	public void setMod_date(Timestamp mod_date) {
		this.mod_date = mod_date;
	}
	@Override
	public String toString() {
		return "SurveyAnswerVO [survey_seq=" + survey_seq + ", question_order=" + question_order + ", question_depth="
				+ question_depth + ", user_id=" + user_id + ", subjective_answer=" + subjective_answer
				+ ", choice_answer=" + choice_answer + ", reg_date=" + reg_date + ", mod_date=" + mod_date + "]";
	}
	
	
}
