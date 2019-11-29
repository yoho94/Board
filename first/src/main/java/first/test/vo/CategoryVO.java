package first.test.vo;

import java.sql.Timestamp;

public class CategoryVO {
	private int category_code;
	private String category_name;
	private Timestamp reg_date;
	private Timestamp mod_date;
	public int getCategory_code() {
		return category_code;
	}
	public void setCategory_code(int category_code) {
		this.category_code = category_code;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
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
		return "CategoryVO [category_code=" + category_code + ", category_name=" + category_name + ", reg_date="
				+ reg_date + ", mod_date=" + mod_date + "]";
	}
	
	
}
