package com.spring.biz.nomi;

import java.util.List;

public class NomiServiceImpl implements NomiService {

   private NomiDAO nomiDAO;
   
   public void setnomiDAO(NomiDAO nomiDAO) {
      this.nomiDAO = nomiDAO;
   }

   public void insertNomi(NomiVO vo) {
      nomiDAO.insertNomi(vo);
   }

   public void updateNomi(NomiVO vo, int cnt) {
	   nomiDAO.updateNomi(vo, cnt);
   }
   
   public void deleteNomi(NomiVO vo) {
      nomiDAO.deleteNomi(vo);
   }

   public void upCnt(NomiVO vo) {
      nomiDAO.upCnt(vo);
   }
   
   public NomiVO editNomi(NomiVO vo) {
	   return nomiDAO.editNomi(vo);
   }
   
   public NomiVO getNomi(NomiVO vo, String reader) {
      return nomiDAO.getNomi(vo, reader);
   }

   public List<NomiVO> getNomiList(NomiVO vo) {
      return nomiDAO.getNomiList(vo);
   }
}
