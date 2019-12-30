package first.test.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import first.test.vo.ReplyUserLike;
import first.test.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	// 마이바티스 
	@Inject
	private SqlSession sql;
	
	// 매퍼 
	private static String namespace = "first.test.mapper.ReplyMapper";
	
	// 댓글 조회
	@Override
	public List<ReplyVO> readReply(HashMap<String, Object> map) throws Exception {
		return sql.selectList(namespace + ".readReply", map);
	}

	// 댓글 작성
	@Override
	public void writeReply(ReplyVO vo) throws Exception {
		sql.insert(namespace + ".writeReply", vo);		
	}

	// 특정 댓글 조회
	@Override
	public ReplyVO readReplySelect(int rno) throws Exception {
		return sql.selectOne(namespace + ".readReplySelect", rno);
	}
	
	// 댓글 수정
	@Override
	public void replyUpdate(ReplyVO vo) throws Exception {
		sql.update(namespace + ".updateReply", vo);
	}

	// 댓글 삭제
	@Override
	public void replyDelete(ReplyVO vo) throws Exception {
		sql.update(namespace + ".deleteReply", vo);
	}
	
	@Override
	public void replyDeleteAll(int bno) throws Exception {
		sql.delete(namespace + ".deleteAll",bno);
		
	}

	@Override
	public Integer updateGood(ReplyVO vo) throws Exception {
		return sql.update(namespace + ".updateGood", vo);
	}

	@Override
	public Integer updateBad(ReplyVO vo) throws Exception {
		return sql.update(namespace + ".updateBad", vo);
	}

	@Override
	public Integer insertReplyUserLike(ReplyUserLike vo) throws Exception {
		return sql.insert(namespace + ".insertReplyUserLike", vo);
	}

	@Override
	public Integer updateReplyUserLike(ReplyUserLike vo) throws Exception {
		return sql.update(namespace + ".updateReplyUserLike", vo);
	}

	@Override
	public Integer updateLike() throws Exception {
		return sql.update(namespace + ".updateLike");
	}
	
	
	
}