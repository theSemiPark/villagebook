package com.spring.biz.nomi;

import java.util.List;

public interface NomiService {
   void insertNomi(NomiVO vo);
   void updateNomi(NomiVO vo, int cnt);
   void deleteNomi(NomiVO vo);
   void upCnt(NomiVO vo);
   NomiVO editNomi(NomiVO vo);
   NomiVO getNomi(NomiVO vo, String reader);
   List<NomiVO> getNomiList(NomiVO vo);
}
