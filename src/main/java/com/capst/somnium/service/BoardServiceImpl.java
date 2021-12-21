package com.capst.somnium.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Service;

import com.capst.somnium.mapper.BoardMapper;
import com.capst.somnium.model.AttFileVO;
import com.capst.somnium.model.BoardLikeVO;
import com.capst.somnium.model.BoardVO;
import com.capst.somnium.model.BoardViewVO;
import com.capst.somnium.model.ReplyLikeVO;
import com.capst.somnium.model.ReplyVO;
import com.capst.somnium.model.SearchVO;
import com.capst.somnium.utils.PageHelper;

@Service(value = "boardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper boardMapper;
	
	PageHelper pageHelper = new PageHelper();
	
	@Override
	public List<BoardVO> getBoardList(SearchVO searchVO) {
		
		int currentPage = searchVO.getPage();
	    //int startRow = (currentPage - 1) * 10 +1 ; //pagesize=10 °¡Á¤  
		int startRow = (currentPage - 1) * this.pageHelper.getPageSize()+1;
	    //int endRow   = currentPage * 10; ; //pagesize=10 \
		int endRow   = currentPage * this.pageHelper.getPageSize();

	    searchVO.setStartRow(startRow);
	    searchVO.setEndRow(endRow);
	    return this.boardMapper.getBoardList(searchVO);
	}

	@Override
	public StringBuffer getPageUrl(SearchVO searchVO) {
		
		int totalRow = boardMapper.getTotalRow(searchVO);
		return pageHelper.getPageUrl(searchVO, totalRow);
	}

	@Override
	public int writeArticle(BoardVO board) {

		return boardMapper.writeArticle(board);
	}

	@Override
	public int insertFile(AttFileVO file) {
		
		return boardMapper.insertFile(file);
	}

	@Override
	public BoardVO getArticle(int bno) {
		return this.boardMapper.getArticle(bno);
	}

	@Override
	public int updateArticle(BoardVO board) {
		return this.boardMapper.updateArticle(board);
	}


	@Override
	public int getTotalRow(SearchVO searchVO) {
		return this.boardMapper.getTotalRow(searchVO);
	}

	@Override
	public int incrementViewCnt(int bno) {
		return this.boardMapper.incrementViewCnt(bno);
	}

	@Override
	public int incrementGoodCnt(int bno) {
		return this.boardMapper.incrementGoodCnt(bno);
	}

	@Override
	public int incrementReplyCnt(int bno) {
		return this.boardMapper.incrementReplyCnt(bno);
	}

	@Override
	public List<ReplyVO> getReplyList(int bno) {
		return this.boardMapper.getReplyList(bno);
	}

	@Override
	public ReplyVO getReply(int rno) {
		return this.boardMapper.getReply(rno);
	}

	@Override
	public int writeReply(ReplyVO reply) {
		int bno = reply.getBno();
	    this.boardMapper.incrementReplyCnt(bno);
	    return this.boardMapper.writeReply(reply);
	}

	@Override
	public int updateReply(ReplyVO reply) {
		return this.boardMapper.updateReply(reply);
	}

	@Override
	public int incReplyGoodCnt(int rno) {
		return this.boardMapper.incReplyGoodCnt(rno);
	}

	@Override
	public List<AttFileVO> getFileList(int bno) {
		return this.boardMapper.getFileList(bno);
	}

	@Override
	public String getFileName(int fno) {
		return this.boardMapper.getFileName(fno);
	}

	@Override
	public int addBoardLike(BoardLikeVO boardLike) {
		return this.boardMapper.addBoardLike(boardLike);
	}

	@Override
	public int getBoardLike(BoardLikeVO boardLike) {
		return this.boardMapper.getBoardLike(boardLike);
	}

	@Override
	public int addReplyLike(ReplyLikeVO replyLike) {
		return this.boardMapper.addReplyLike(replyLike);
	}

	@Override
	public int getReplyLike(ReplyLikeVO replyLike) {
		return this.boardMapper.getReplyLike(replyLike);
	}

	@Override
	public int addBoardView(BoardViewVO boardView) {
		return this.boardMapper.addBoardView(boardView);
	}

	@Override
	public int getBoardView(BoardViewVO boardView) {
		return this.boardMapper.getBoardView(boardView);
	}

	@Override
	public int deleteArticle(int bno) {
		return this.boardMapper.deleteArticle(bno);
	}

	@Override
	public int deleteReply(int rno) {
		return this.boardMapper.deleteReply(rno);
	}

	@Override
	public int deleteReplyBybno(int bno) {
		return this.boardMapper.deleteReplyBybno(bno);
	}

	@Override
	public int deleteFile(int fno) {
		return this.boardMapper.deleteFile(fno);
	}

	@Override
	public int deleteFileBybno(int bno) {
		return this.boardMapper.deleteFileBybno(bno);
	}
	
	
	
}
