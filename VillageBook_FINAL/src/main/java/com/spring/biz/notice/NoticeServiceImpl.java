package com.spring.biz.notice;

import java.util.List;

public class NoticeServiceImpl implements NoticeService {

   private NoticeDAO noticeDAO;
   
   public void setnoticeDAO(NoticeDAO noticeDAO) {
      this.noticeDAO = noticeDAO;
   }

   public void insertNotice(NoticeVO vo) {
      noticeDAO.insertNotice(vo);
   }

   public void deleteNotice(NoticeVO vo) {
      noticeDAO.deleteNotice(vo);
   }

   public void upCnt(NoticeVO vo) {
      noticeDAO.upCnt(vo);
   }
   
   public NoticeVO getNotice(NoticeVO vo) {
      return noticeDAO.getNotice(vo);
   }

   public List<NoticeVO> getNoticeList(NoticeVO vo) {
      return noticeDAO.getNoticeList(vo);
   }
}
