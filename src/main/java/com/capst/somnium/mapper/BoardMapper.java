package com.capst.somnium.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.capst.somnium.model.AttFileVO;
import com.capst.somnium.model.BoardLikeVO;
import com.capst.somnium.model.BoardVO;
import com.capst.somnium.model.BoardViewVO;
import com.capst.somnium.model.ReplyLikeVO;
import com.capst.somnium.model.ReplyVO;
import com.capst.somnium.model.SearchVO;

@Mapper
public interface BoardMapper {

	List<BoardVO> getBoardList(SearchVO searchVO);	//	�۸����ȸ
	
	BoardVO getArticle(int bno);      //�� ��ȸ
	int writeArticle(BoardVO board);   //�� ����
	int updateArticle(BoardVO board);   //�� ����
	int deleteArticle(int bno);      //�� ����
	   
	int getTotalRow(SearchVO searchVO);
	   
	int incrementViewCnt(int bno);
	int incrementGoodCnt(int bno);
	int incrementReplyCnt(int bno);
	   
	List<ReplyVO> getReplyList(int bno);
	ReplyVO getReply(int rno);
	
	int writeReply(ReplyVO reply);
	int updateReply(ReplyVO reply);
	int deleteReply(int rno);
	int deleteReplyBybno(int bno);
	
	int incReplyGoodCnt(int rno);
	
	List<AttFileVO> getFileList(int bno);
	String getFileName(int fno);
	
	int insertFile(AttFileVO file);

	int deleteFile(int fno);
	int deleteFileBybno(int bno);
	
	int addBoardLike(BoardLikeVO boardLike);
	int getBoardLike(BoardLikeVO boardLike);
	
	int addReplyLike(ReplyLikeVO replyLike);
	int getReplyLike(ReplyLikeVO replyLike);
	
	int addBoardView(BoardViewVO boardView);
	int getBoardView(BoardViewVO boardView);
}
