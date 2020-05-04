package com.spring.biz.qna;

import java.util.List;

public class QnAServiceImpl implements QnAService {

   private QnADAO qnaDAO;
   
   public void setqnaDAO(QnADAO qnaDAO) {
      this.qnaDAO = qnaDAO;
   }

   public void insertQnA(QnAVO vo) {
      qnaDAO.insertQnA(vo);
   }

   public void deleteQnA(QnAVO vo) {
      qnaDAO.deleteQnA(vo);
   }

   public void upCnt(QnAVO vo) {
      qnaDAO.upCnt(vo);
   }
   
   public QnAVO getQnA(QnAVO vo) {
      return qnaDAO.getQnA(vo);
   }

   public List<QnAVO> getQnAList(QnAVO vo) {
      return qnaDAO.getQnAList(vo);
   }
}
