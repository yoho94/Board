package first.test.dao;

import java.util.List;

import first.test.vo.ReplyVO;

public interface ReplyDAO {
	
	// 댓글 조회
	public List<ReplyVO> readReply(int bno) throws Exception;

	// 댓글 작성
	public void writeReply(ReplyVO vo) throws Exception;
	public void writeReplyUpdate(ReplyVO vo) throws Exception;

	// 특정 댓글 조회
	public ReplyVO readReplySelect(int rno) throws Exception;
	
	// 댓글 수정
	public void replyUpdate(ReplyVO vo) throws Exception;
		
	// 댓글 삭제
	public void replyDelete(ReplyVO vo) throws Exception;
	public void replyDeleteAll(int bno) throws Exception;
	
	public int reUpdate(ReplyVO vo) throws Exception;
	public int reInsert(ReplyVO vo) throws Exception;
		
}
