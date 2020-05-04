package com.spring.biz.qna;

import java.util.List;

public interface QnAService {
   void insertQnA(QnAVO vo);
   void deleteQnA(QnAVO vo);
   void upCnt(QnAVO vo);
   QnAVO getQnA(QnAVO vo);
   List<QnAVO> getQnAList(QnAVO vo);
}
