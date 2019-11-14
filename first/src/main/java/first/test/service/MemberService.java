package first.test.service;

import first.test.vo.MemberVO;

public interface MemberService {

	// 회원 가입
	public void register(MemberVO vo) throws Exception;

	// 로그인
	public MemberVO login(MemberVO vo) throws Exception;

	// 회원정보 수정
	public void modify(MemberVO vo) throws Exception;
	
	// 회원 탈퇴
	public void withdrawal(MemberVO vo) throws Exception;
	
	public int idCheck(String userId) throws Exception;
	
	// 닉네임 검사
	public int nameCheck(String userName) throws Exception;
}