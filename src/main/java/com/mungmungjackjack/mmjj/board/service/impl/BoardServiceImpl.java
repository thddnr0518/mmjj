package com.mungmungjackjack.mmjj.board.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.mungmungjackjack.mmjj.board.domain.BoardAttachDTO;
import com.mungmungjackjack.mmjj.board.domain.BoardDTO;
import com.mungmungjackjack.mmjj.board.domain.BoardRankDTO;
import com.mungmungjackjack.mmjj.board.mapper.BoardAttachMapper;
import com.mungmungjackjack.mmjj.board.mapper.BoardMapper;
import com.mungmungjackjack.mmjj.board.service.IBoardService;
import com.mungmungjackjack.mmjj.domain.Criteria;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BoardServiceImpl implements IBoardService{

	@Autowired
	private BoardMapper mapper;
	
	@Autowired
	private BoardAttachMapper attachMapper;

	@Override
	public List<BoardDTO> listAll(Criteria cri) throws Exception {
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotalCnt(Criteria cri) throws Exception {
		return mapper.getTotalCnt(cri);
	}
	
	@Transactional
	@Override
	public void register(BoardDTO bDto) throws Exception {
		mapper.create(bDto);
		
		if (bDto.getAttachList() == null || bDto.getAttachList().size() <= 0) {
			return;
		}
		
		bDto.getAttachList().forEach(attach -> {attach.setBno(bDto.getBno()); attachMapper.insert(attach);});
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public BoardDTO read(Integer bno) throws Exception {
		mapper.updateViewCnt(bno);
		return mapper.read(bno);
	}

	@Transactional
	@Override
	public boolean modify(BoardDTO bDto) throws Exception {
		attachMapper.deleteAll(bDto.getBno());
		
		boolean modifyResult = mapper.update(bDto) == 1;
		
		if (modifyResult && bDto.getAttachList() != null) {
			bDto.getAttachList().forEach(attach -> {
				log.info("attach : " + attach);
				attach.setBno(bDto.getBno());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
	}
	
	@Override
	public List<BoardAttachDTO> getAttachList(int bno) {
		return attachMapper.findByBno(bno);
	}

	@Transactional
	@Override
	public boolean remove(Integer bno) throws Exception {
		attachMapper.deleteAll(bno);
		return mapper.delete(bno) == 1;
	}

	@Override
	public void updateViewCnt(Integer bno) throws Exception {
		mapper.updateViewCnt(bno);
	}

	@Override
	public void updateReplyCnt(Map<String, Object> update) throws Exception {
		
		mapper.updateReplyCnt(update);
	}

	@Override
	public List<BoardRankDTO> rank() throws Exception {
		return mapper.rank();
	}

	@Override
	public List<BoardRankDTO> monthRank() throws Exception {
		return mapper.monthRank();
	}

}
