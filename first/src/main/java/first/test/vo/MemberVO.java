package first.test.vo;

import java.util.regex.Pattern;

public class MemberVO {

	private String userId;
	private String userPass;
	private String userName;
	private Integer isAdmin;
	private Character isUsing;

	private String validMsg = "";

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
		if (userId == null || userPass == null || userName == null || isAdmin == null || isUsing == null) {
			validMsg = "빈 값이 있으면 안됩니다.";
			return false;
		}
		
		if (userId.isEmpty() || userPass.isEmpty() || userName.isEmpty()) {
			validMsg = "빈 값이 있으면 안됩니다.";
			return false;
		}

		if (userId.length() >= 25) {
			validMsg = "아이디는 25자 이하로 적으세요.";
			return false;
		}
		
		if (!Pattern.matches("^[a-zA-Z0-9]*$", userId)) {
			validMsg = "아이디는 영어, 숫자만 가능합니다.";
			return false;
		}

		if (userPass.length() >= 25) {
			validMsg = "패스워드는 25자 이하로 적으세요.";
			return false;
		}

		if (userName.length() >= 25) {
			validMsg = "이름은 25자 이하로 적으세요.";
			return false;
		}

		if (!(isAdmin == 0 || isAdmin == 1)) {
			validMsg = "관리자 권한은 0, 1만 가능합니다.";
			return false;
		}

		if (!(isUsing == 'Y' || isUsing == 'N')) {
			validMsg = "사용 여부는 Y, N만 가능합니다.";
			return false;
		}

		return true;
	}

	public String getValidMsg() {
		return validMsg;
	}

	public void setValidMsg(String validMsg) {
		this.validMsg = validMsg;
	}
	
	

}