package first.test.vo;

public class MemberVO {

	private String userId;
	private String userPass;
	private String userName;
	private Integer isAdmin;
	private Character isUsing;
	
	public Character getIsUsing() {
		return isUsing;
	}
	public void setIsUsing(Character isUsing) {
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
	public Integer getIsAdmin() {
		return isAdmin;
	}
	public void setIsAdmin(Integer isAdmin) {
		this.isAdmin = isAdmin;
	}
	
	@Override
	public String toString() {
		return "MemberVO [userId=" + userId + ", userPass=" + userPass + ", userName=" + userName + ", isAdmin="
				+ isAdmin + "]";
	}
	
	public boolean valid() {
		if(userId == null || userPass == null || userName == null || isAdmin == null || isUsing == null)
			return false;
		
		if(userId.length() >= 25)
			return false;
		
		if(userPass.length() >= 25)
			return false;
		
		if(userName.length() >= 25)
			return false;
		
		if(!(isAdmin == 0 || isAdmin == 1))
			return false;
		
		if(!(isUsing == 'Y' || isUsing == 'N'))
			return false;		
		
		
		return true;
	}
		
}