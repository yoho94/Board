package first.test.vo;

public class MemberVO {

	private String userId;
	private String userPass;
	private String userName;
	private int isAdmin;
	private char isUsing;
	
	public char getIsUsing() {
		return isUsing;
	}
	public void setIsUsing(char isUsing) {
		this.isUsing = isUsing;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPass() {
		return userPass;
	}
	public void setUserPass(String userPass) {
		this.userPass = userPass;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getIsAdmin() {
		return isAdmin;
	}
	public void setIsAdmin(int isAdmin) {
		this.isAdmin = isAdmin;
	}
	
	@Override
	public String toString() {
		return "MemberVO [userId=" + userId + ", userPass=" + userPass + ", userName=" + userName + ", isAdmin="
				+ isAdmin + "]";
	}
	
	
		
}