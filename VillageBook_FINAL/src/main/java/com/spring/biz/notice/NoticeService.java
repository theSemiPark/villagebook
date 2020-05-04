package com.spring.biz.notice;

import java.util.List;

public interface NoticeService {
   void insertNotice(NoticeVO vo);
   void deleteNotice(NoticeVO vo);
   void upCnt(NoticeVO vo);
   NoticeVO getNotice(NoticeVO vo);
   List<NoticeVO> getNoticeList(NoticeVO vo);
}
