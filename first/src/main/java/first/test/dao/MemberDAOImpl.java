package first.test.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import first.test.vo.MemberVO;

@Service
public class MemberDAOImpl implements MemberDAO {

	// 마이바티스
	@Inject
	private SqlSession sql;

	// 매퍼
	private static String namespace = "first.test.mapper.MemberMapper";

	// 회원 가입
	@Override
	public void register(MemberVO vo) throws Exception {
		sql.insert(namespace + ".register", vo);
	}

	// 로그인
	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		return sql.selectOne(namespace + ".login", vo);
	}

	// 회원정보 수정
	@Override
	public void modify(MemberVO vo) throws Exception {
		sql.update(namespace + ".modify", vo);
	}

	// 회원 탈퇴
	@Override
	public void withdrawal(MemberVO vo) throws Exception {
		sql.delete(namespace + ".withdrawal", vo);
	}

	// 아이디 검사
	@Override
	public int idCheck(String userId) throws Exception {
		return sql.selectOne(namespace + ".idCheck", userId);
	}

	@Override
	public int nameCheck(String userName) throws Exception {
		return sql.selectOne(namespace + ".nameCheck", userName);
	}

	@Override
	public List<MemberVO> selectMemberList() throws Exception {
		// TODO Auto-generated method stub
		return sql.selectList(namespace + ".selectMemberList");
	}

	@Override
	public void updateUsing(String userId) throws Exception {
		sql.update(namespace + ".updateUsing", userId);
	}

	@Override
	public void updateUnUsing(String userId) throws Exception {
		sql.update(namespace + ".updateUnUsing", userId);
	}

	@Override
	public void updateAdmin(MemberVO vo) throws Exception {
		sql.update(namespace + ".updateAdmin", vo);
	}

}
