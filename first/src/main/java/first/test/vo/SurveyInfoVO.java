package first.test.vo;

import java.sql.Timestamp;
import java.util.Date;

public class SurveyInfoVO {
	private int survey_seq;
	private String admin_id;
	private String agency_name;
	private Date start_date;
	private Date end_date;
	private Date result_date;
	private String survey_head;
	private String survey_content; 
	private String survey_foot; 
	private Timestamp reg_date; 
	private Timestamp mod_date;
	private Integer question_count;
	private int answer_people_count;
	private char isUsing;
	
	public char getIsUsing() {
		return isUsing;
	}
	public void setIsUsing(char isUsing) {
		this.isUsing = isUsing;
	}
	
	
	public int getAnswer_people_count() {
		return answer_people_count;
	}
	public void setAnswer_people_count(int answer_people_count) {
		this.answer_people_count = answer_people_count;
	}
	public Integer getQuestion_count() {
		return question_count;
	}
	public void setQuestion_count(Integer question_count) {
		this.question_count = question_count;
	}
	public int getSurvey_seq() {
		return survey_seq;
	}
	public void setSurvey_seq(int survey_seq) {
		this.survey_seq = survey_seq;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	public String getAgency_name() {
		return agency_name;
	}
	public void setAgency_name(String agency_name) {
		this.agency_name = agency_name;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public Date getResult_date() {
		return result_date;
	}
	public void setResult_date(Date result_date) {
		this.result_date = result_date;
	}
	public String getSurvey_head() {
		return survey_head;
	}
	public void setSurvey_head(String survey_head) {
		this.survey_head = survey_head;
	}
	public String getSurvey_content() {
		return survey_content;
	}
	public void setSurvey_content(String survey_content) {
		this.survey_content = survey_content;
	}
	public String getSurvey_foot() {
		return survey_foot;
	}
	public void setSurvey_foot(String survey_foot) {
		this.survey_foot = survey_foot;
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
	public long getPeriod() {
		long time = end_date.getTime() - start_date.getTime();
		return time / (24*60*60*1000) + 1;
	}
	@Override
	public String toString() {
		return "SurveyInfoVO [survey_seq=" + survey_seq + ", admin_id=" + admin_id + ", agency_name=" + agency_name
				+ ", start_date=" + start_date + ", end_date=" + end_date + ", result_date=" + result_date
				+ ", survey_head=" + survey_head + ", survey_content=" + survey_content + ", survey_foot=" + survey_foot
				+ ", reg_date=" + reg_date + ", mod_date=" + mod_date + "]";
	}

	
	
	
}
