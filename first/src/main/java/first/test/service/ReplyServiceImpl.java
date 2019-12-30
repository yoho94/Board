package first.test.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import first.test.dao.ReplyDAO;
import first.test.vo.ReplyUserLike;
import first.test.vo.ReplyVO;


@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO dao;

	// 댓글 조회
	@Override
	public List<ReplyVO> readReply(int bno, String orderType, String userId) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("bno", bno);
		map.put("orderType", orderType);
		map.put("userId", userId);
		dao.updateLike();
		
		return dao.readReply(map);
	}

	// 댓글 작성
	@Override
	public void writeReply(ReplyVO vo) throws Exception {
		dao.writeReply(vo);
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
	public Integer updateGood(ReplyVO vo) throws Exception {
		return dao.updateGood(vo);
	}

	@Override
	public Integer updateBad(ReplyVO vo) throws Exception {
		return dao.updateBad(vo);
	}

	@Override
	public Integer replyLike(ReplyUserLike vo, Character isUpdate) throws Exception {
		Integer tmp;
		
		if(isUpdate == null || isUpdate == 'N') {
			try {
				tmp = dao.insertReplyUserLike(vo);
			} catch (Exception e) {
				tmp = dao.updateReplyUserLike(vo);
			}			
		} else {
			tmp = dao.updateReplyUserLike(vo);
		}
		
		return tmp;
	}
	
	
 
} 