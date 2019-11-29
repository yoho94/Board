package first.test.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import first.test.dao.ReplyDAO;
import first.test.vo.ReplyVO;


@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO dao;

	// 댓글 조회
	@Override
	public List<ReplyVO> readReply(int bno) throws Exception {
		return dao.readReply(bno);
	}

	// 댓글 작성
	@Override
	public void writeReply(ReplyVO vo) throws Exception {
		dao.writeReply(vo);
		dao.writeReplyUpdate(vo);
	} 

	// 특정 댓글 조회
	@Override
	public ReplyVO readReplySelect(int rno) throws Exception {
		return dao.readReplySelect(rno);
	}
	
	// 댓글 수정
	@Override
	public void replyUpdate(ReplyVO vo) throws Exception {
		dao.replyUpdate(vo);
	}

	// 댓글 삭제
	@Override
	public void replyDelete(ReplyVO vo) throws Exception {
		dao.replyDelete(vo);
	}

	@Override
	public void replyDeleteAll(int bno) throws Exception {
		dao.replyDeleteAll(bno);		
	}
	
	@Override
	public int writeReReply(ReplyVO vo, int rno) throws Exception {
		ReplyVO oVO = dao.readReplySelect(rno);
		dao.reUpdate(oVO);
		vo.setRe_group(oVO.getRe_group());
		vo.setRe_sorts(oVO.getRe_sorts() + 1);
		vo.setRe_depth(oVO.getRe_depth() + 1);
		dao.reInsert(vo);
		return 0;
	}
 
} 