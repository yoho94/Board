package first.test.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import first.test.dao.MemberDAO;
import first.test.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO dao;

	// 회원 가입
	@Override
	public void register(MemberVO vo) throws Exception {
		dao.register(vo);
	}

	// 로그인
	@Override
	public MemberVO login(MemberVO vo) throws Exception {

		return dao.login(vo);
	}

	// 회원정보 수정
	@Override
	public void modify(MemberVO vo) throws Exception {

		dao.modify(vo);
	}

	// 회원 탈회
	@Override
	public void withdrawal(MemberVO vo) throws Exception {
		dao.withdrawal(vo);
	}

	@Override
	public int idCheck(String userId) throws Exception {
		return dao.idCheck(userId);
	}

	@Override
	public int nameCheck(String userName) throws Exception {
		return dao.nameCheck(userName);
	}

	@Override
	public List<MemberVO> selectMemberList() throws Exception {
		return dao.selectMemberList();
	}

	@Override
	public void updateUsing(String userId) throws Exception {
		dao.updateUsing(userId);
	}

	@Override
	public void updateUnUsing(String userId) throws Exception {
		dao.updateUnUsing(userId);
	}

	@Override
	public void updateAdmin(MemberVO vo) throws Exception {
		dao.updateAdmin(vo);
	}

}
