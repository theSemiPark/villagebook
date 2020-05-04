drop table message;
drop table area;
drop table book;
drop table cart;
drop table delivery;
drop table library;
drop table nomi;
drop table notice;
drop table notice_reply;
drop table qna;
drop table qna_reply;
drop table point;
drop table rental;
drop table reserve;
drop table user_info;
drop table nomiheart;

drop sequence rev_id;
drop sequence cart_id;
drop sequence nreplyid_seq;
drop sequence qreplyid_seq;
drop sequence m_seq;
drop sequence pid_seq;
drop sequence nheart_seq;


CREATE TABLE CART(
    CARTID NUMBER(30) PRIMARY KEY,
    CNT NUMBER(1),
    BOOKNAME VARCHAR2(1000),
    LID VARCHAR2(5),
    LNAME VARCHAR2(1000),
    ISBN NUMBER(13),
    CID VARCHAR2(20),
    INDATE DATE
);

create sequence cart_id
start with 1
increment by 1
maxvalue 1000
nocycle;


CREATE TABLE BOOK(
ISBN NUMBER(13) PRIMARY KEY,
BOOKNAME VARCHAR2(3000),
AUTHOR VARCHAR2(3000),
PUBLISHER VARCHAR2(3000),
PDATE DATE,
GENRE VARCHAR2(1000),
IMG VARCHAR2(1000)
);

Insert into BOOK values (9791190305679,'1일 1페이지, 세상에서 가장 짧은 교양 수업 365','데이비드 S. 키더','위즈덤하우스',to_date('2019-10-30','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9788983711892,'코스모스 특별판','칼 세이건','사이언스북스',to_date('06/12/20','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9788946421158,'스스로 행복하라','법정 저','샘터 ',to_date('2020-01-06','RR/MM/DD'),'문학', NULL);
Insert into BOOK values (9788986022100,'식물의 책 - 식물세밀화가 이소영의 도시식물 이야기 ','이소영','책읽는수요일',to_date('2019-10-30','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9791155424353,'바이러스 쇼크 - 인류 재앙의 실체, 알아야 살아남는다','최강석 ','매일경제신문사',to_date('2020-03-01','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9788952751546,'더 위험한 과학책 ','랜들 먼로','시공사',to_date('2020-01-20','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9791186900864,'재밌어서 밤새 읽는 해부학 이야기','사카이 다츠오','더숲',to_date('2019-05-20','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9788997186884,'달로 가는 길 - 한 우주비행사의 이야기','마이클 콜린스 ','사월의 책',to_date('2019-07-20','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9791196250515,'저도 과학은 어렵습니다만','이정모','바틀비',to_date('2018-01-05','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9788995677230,'꿈꾸는 기계의 진화','로돌포 R. 이나스','북센스',to_date('2019-06-20','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9788970445137,'뉴턴의 법칙에서 아인슈타인의 상대론까지','팡리지','전파과학사',to_date('1991-02-01','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9791187150640,'미술관에 간 물리학자 - 명화에서 찾은 물리학의 발견 ','서민아','어바웃어북',to_date('2020-02-07','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9791189932473,'이해하는 미적분 수업','데이비드 애치슨','바다출판사',to_date('2020-01-31','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9788995408407,'지구의 딸 지구시인 레이첼 카슨','김재희','이유책',to_date('03/07/03','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9788958073123,'과학과 종교는 적인가 동지인가','로널드 L. 넘버스','뜨인돌',to_date('10/07/05','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9788991373013,'내몸안의 주치의 면역','하가와라 기요후미','전나무숲',to_date('06/01/15','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9791185104577,'프루프 - 술의 과학','아담 로저스','Mid(엠아이디)',to_date('2015-12-21','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9788965703112,'모든 순간의 물리학','카를로 로벨리','쌤앤파커스',to_date('2016-02-26','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9791195568758,'부분과 전체','베르너 하이젠베르크','서커스',to_date('2016-08-20','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9788959090532,'원더풀 사이언스 - 아름다운 기초과학 산책 ','나탈리 앤지어 ','지호',to_date('10/01/18','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9788901147093,'진화심리학 - 마음과 행동을 탐구하는 새로운 과학','데이비드 M. 버스','웅진지식하우스',to_date('12/06/13','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9788955618013,'다윈의 식탁','장대익','바다출판사',to_date('2015-11-05','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9791186560785,'수학이 필요한 순간 - 인간은 얼마나 깊게 생각할 수 있는가','김민형 ','인플루엔셜(주)',to_date('2018-08-03','RR/MM/DD'),'과학', NULL);
Insert into BOOK values (9788954641630,'쇼코의 미소','최은영','문학동네',to_date('2019-06-20','RR/MM/DD'),'문학', NULL);
Insert into BOOK values (9788936434267,'아몬드','손원평','창비 ',to_date('2017-03-31','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9788937461033,'인간실격','다자이 오사무','민음사',to_date('2014-4-15','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9788986836240,'왜 나는 너를 사랑하는가','알랭 드 보통','청미래',to_date('2013-01-15','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9788972756194,'나미야 잡화점의 기적','히가시노 게이고','현대문학',to_date('12/12/19','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9788932023151,'비행운','김애란','문학과지성사',to_date('12/07/19','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9791190090018,'우리가 빛의 속도로 갈 수 없다면','김초엽','허블',to_date('2019-06-24','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9788988027400,'죽은 시인의 사회','N.H.클라인바움','서교출판사',to_date('04/03/30','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9791130605210,'오베라는 남자','프레드릭 배크만','다산책방',to_date('2015-05-20','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9788936437541,'디디의 우산','황정은','창비',to_date('2019-01-20','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9791190234023,'파인드 미','안드레 애치먼','잔',to_date('2019-12-16','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9791159039690,'어린왕자','생텍쥐페리','더스토리',to_date('2018-09-10','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9788936456085,'완득이','김기령','창비',to_date('2014-03-17','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9791190492249,'사랑 없는 세계','미우라 시온','은행나무',to_date('2020-01-29','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9788937441943,'단순한 진심','조해진','믿음사',to_date('2019-07-05','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9788954640756,'너무 한낮의 연애','김금희','문학동네',to_date('2016-05-31','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9788936437381,'안녕 주정뱅이','권여선','창비',to_date('2016-05-16','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9788973814725,'멋진 신세계','올더스 헉슬리','소담출판사',to_date('2015-06-12','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9788998274931,'봉제인형 살인사건','다니엘 콜','북플라자',to_date('2019-10-20','RR/MM/DD'),' 문학', NULL);
Insert into BOOK values (9791196076061,'기생충 각본집 & 스토리보드북 세트 - 전 2권','봉준호','플레인',to_date('2019-10-21','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9788925568171,'작은 아씨들 무비 아트북','지나 매킨타이어','알에이치코리아(RHK)',to_date('2020-02-12','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9788968331862,'방구석 미술관(아티스트 하우스 에디션)','조원재','블랙피쉬',to_date('2018-08-03','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9788988105726,'타인의 고통','수전 손택 ','이후',to_date('04/01/07','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9788931588507,'김락희의 인체 드로잉','김락희','성안당',to_date('2019-11-27','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9788932320250,'벨 에포크, 아름다운 시대','메리 매콜리프 ','현암사',to_date('2020-01-15','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9791155812587,'총보다 강한 실','카시아 세인트 클레어 ','월북',to_date('2020-02-10','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9791190030281,'예술적 상상력','오종우','어크로스',to_date('2019-12-31','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9788932036052,'매체의 역사 읽기','안드레아스 뵌,안드레아스 자이들러','문학과지성사',to_date('2020-01-30','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9788986377453,'아티스트 웨이','줄리아 카메론','경당',to_date('12/05/10','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9788932320267,'새로운 세기의 예술가들','메리 매콜리프','현암사',to_date('2020-01-15','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9788932320274,'파리는 언제나 축제','메리 매콜리프','현암사',to_date('2020-01-15','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9791155811566,'컬러의 말 : 모든 색에는 이름이 있다','카시아 세인트 클레어','윌북',to_date('2018-06-10','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9788950980221,'레오나르도 다빈치','월터 아이작슨','arte(아르테)',to_date('2019-03-28','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9791196517106,'건반 위의 철학자','프랑수아 누델만','시간의흐름',to_date('2018-11-30','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9788954650892,'알랭 드 보통의 영혼의 미술관 (보급판)','알랭 드 보통,존 암스트롱','문학동네',to_date('2018-07-10','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9791190292023,'감정화하는 사회','오쓰카 에이지','리시올',to_date('2020-01-10','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9788992607148,'만화의 이해','스콧 맥클라우드','비즈앤비즈',to_date('08/07/01','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9791190266017,'그림 쏙 세계사','릴리스','지식서재',to_date('2020-02-24','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9788965642473,'색체 속을 걷는 사람','조르주 디디 위베르만','현실문화A',to_date('2019-12-16','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9791195739585,'서브컬처계를 여행하는 히지하이커를 위한 가이드','손지상','워크라이프',to_date('2020-01-20','RR/MM/DD'),'예술', NULL);
Insert into BOOK values (9788965133520,'유시민의 글쓰기 특강 - 유시민의 30년 베스트셀러 영업기밀','유시민','생각의길',to_date('2015-04-10','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9791185600031,'내가 사는 세상 내가 하는 인문학 - 플라톤에서 니체로','문성준','새잎',to_date('2015-10-05','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9791159016646,'세계로 떠나는 인문학 - 인문학자 11인의 철학.문화.역사 이야기','권영우,김원명','한국외국어대학교출판부 지식출판원(HUINE)',to_date('2020-02-28','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9788934972464,'사피엔스','유발 하라리','김영사',to_date('2015-11-23','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9791190313193,'지적 대화를 위한 넓고 얕은 지식 2','채사장','웨일북',to_date('2020-02-01','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9788954637756,'개인주의자 선언','문유석','문학동네',to_date('2015-09-23','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9788971996676,'담론','신영복','돌베개',to_date('2015-04-20','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9791160402971,'출근길의 주문','이다혜','한겨레출판',to_date('2019-09-30','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9788962622508,'떨림과 울림','김상욱','동아시아',to_date('2018-11-07','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9788934977841,'호모 데우스','유발 하라리','김영사',to_date('2017-05-15','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9788965962205,'라틴어 수업','한동일','흐름출판',to_date('2017-06-30','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9788956055466,'책은 도끼다','박웅현','북하우스',to_date('11/10/10','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9788934926184,'만들어진 신','리처드 도킨스','김영사',to_date('07/07/20','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9791186900963,'지적이고 과학적인 음주탐구생활 - 술에 관한 깊고 넓은 인문학 강의 ','허원','더숲',to_date('2019-08-23','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9788971390849,'인간이 그리는 무늬','최진석','소나무',to_date('2013-05-06','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9788984314238,'나는 왜 쓰는가','조지 오웰','한겨레출판',to_date('10/09/15','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9788979661682,'인간의 사고를 어떻게 이해할 것인가?','예발트 일리옌코프','책갈피',to_date('2019-11-27','RR/MM/DD'),'인문', NULL);
Insert into BOOK values (9788946044807,'영화, 사회복지를 만나다','김민아','한울아카데미',to_date('11/08/19','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9788955920123,'사회와 건축공학','최윤경','스페이스타임',to_date('12/04/05','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9788958287155,'세상물정의 사회학','노명우','사계절',to_date('2013-12-30','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9788961950213,'음식의 종말','토마스 f.폴릭','갈무리',to_date('09/12/12','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9791157061105,'세상을 바꾸는 언어','양정철','메디치미디어',to_date('2018-01-25','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9788994142364,'생각하는 사회','장의관','미지북스',to_date('2014-10-15','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9791155811887,'나는 내가 죽었다고 생각했습니다','질 볼트 테일러','윌북',to_date('2019-01-10','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9788994122267,'빈곤의 사회과학','김장생','사문난적',to_date('2013-06-30','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9788983946522,'정보사회의 이해','정이환','미래인',to_date('11/03/05','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9788994142302,'플라스틱 바다','찰스 무어','미지북스',to_date('2013-09-20','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9791130613512,'혐오사회','카롤린 엠케','다산초당',to_date('2017-07-18','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9788932473475,'유전자 사회','아타이 야나이','을유문화사',to_date('2016-12-20','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9788918024769,'사회과학을 위한 통계학','김태일','법문사',to_date('2018-03-05','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9788983717436,'세계를 바꾼 17가지 방정식','김지선','사이언스북스',to_date('2016-02-15','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9791162241387,'기계는 어떻게 생각하고 학습하는가','넬로 크리스티아니니','한빛미디어',to_date('2018-12-05','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9791195088355,'우연의 과학','다케우치 케이','윤출판',to_date('2014-12-10','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9788935208647,'생각하지 않는 사람들','니콜라스 카','청림출판',to_date('11/02/19','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9788959122981,'사회복지사를 꿈꾸는 그대에게','이홍직','신정',to_date('2013-10-30','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9791129703361,'마음의 사회','마빈 민스키','메가북스',to_date('2019-02-01','RR/MM/DD'),'사회과학', NULL);
Insert into BOOK values (9788932917740,'미래는 누구의 것인가','재런 러니어','열린책들',to_date('11/07/08','RR/MM/DD'),'사회과학', NULL);

CREATE TABLE USER_INFO(
   CID VARCHAR2(20) PRIMARY KEY,
   CPW VARCHAR2(20),
   CNAME VARCHAR2(100),
   CRANK INTEGER,
   CHP VARCHAR2(20),
   CPOSTCODE VARCHAR2(6),
   CADDR1 VARCHAR2(1000),
   CADDR2 VARCHAR2(1000),
   CPOINT INTEGER,
   CAREAID NUMBER(1),
    CLOGIN NUMBER(1)
);

insert into USER_INFO values('test', 'test123', '김동네', 3, '010-1111-1111', '04104', '서울 마포구 신촌로 170', '푸르지오시티 1004호', 10000, 7, 0);
insert into USER_INFO values('book', 'book', '김독서', 2,'010-9999-9999', '06267', '서울 강남구 강남대로 246', '다림빌딩 701호', 10000, 4, 0);
insert into USER_INFO values('local', 'local', '유동네', 1, '010-4444-4444', '01115', '서울 강북구 수유로12가길 3', '2층 3호', 10000, 1, 0);

create  table Delivery(
ordid NUMBER(38),
isbn NUMBER(13),
cid VARCHAR2(20),
lid VARCHAR2(5),
ordercnt INTEGER,
ordmoney INTEGER,
orderdate DATE,
startdate DATE,
returndate DATE,
shipping number(38),
renewtf VARCHAR2(1),
returnwer VARCHAR2(1),
bookname VARCHAR2(1000)
);

CREATE TABLE notice(
seq number(38),
title VARCHAR2(1000),
writer varchar2(100),
content VARCHAR2(1000),
regdate date default sysdate,
cnt INTEGER default 0,
replycnt number default 0
);

insert into notice(seq,title,writer,content) values(1,'코로나바이러스관련 휴관 안내','중앙관리자','사회적 거리두기 실천으로 인해 모든 도서관은 3월 30일까지 휴관입니다.');
insert into notice(seq,title,writer,content) values(2,'QNA 게시판 수정 불가','중앙관리자', 'QNA 게시판에 작성한 글은 추가와 삭제는 가능하지만 수정은 불가능합니다. 이 점 유념하시고 신중한 글쓰기 부탁드립니다.');

CREATE TABLE qna(
seq number(38),
title VARCHAR2(1000),
writer varchar2(100),
content VARCHAR2(1000),
regdate date default sysdate,
cnt INTEGER default 0,
replycnt number default 0,
replytf varchar2(1) default 'X'
);

insert into qna(seq,title,writer,content,replycnt) values(1,'가입인사','admin','잘부탁드립니다....', 2);

CREATE TABLE rental(
LID VARCHAR2(5),
ISBN NUMBER(13),
RCNT INTEGER NOT NULL,
HAVECNT INTEGER NOT NULL
);

Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('001',9791190305679,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('001',9788983711892,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('001',9788946421158,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('001',9788986022100,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('001',9791155424353,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('002',9788952751546,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('002',9791186900864,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('002',9788997186884,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('002',9791196250515,0,5);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('002',9788995677230,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('003',9788970445137,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('003',9791187150640,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('003',9791189932473,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('003',9788995408407,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('003',9788958073123,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('101',9788991373013,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('101',9791185104577,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('101',9788965703112,0,1);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('101',9791195568758,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('101',9788959090532,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('102',9788901147093,0,5);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('102',9788955618013,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('102',9791186560785,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('102',9788950980221,0,5);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('102',9788936434267,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('103',9788937461033,0,1);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('103',9788986836240,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('103',9788972756194,0,1);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('103',9788932023151,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('103',9791190090018,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('104',9788988027400,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('104',9791130605210,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('104',9788936437541,0,5);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('104',9791190234023,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('104',9791159039690,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('201',9788936456085,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('201',9791190492249,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('201',9788937441943,0,5);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('201',9788954640756,0,5);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('201',9788936437381,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('202',9788973814725,0,1);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('202',9788998274931,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('202',9791196076061,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('202',9788925568171,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('202',9788968331862,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('203',9788988105726,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('203',9788931588507,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('203',9788932320250,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('203',9791155812587,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('203',9791190030281,0,1);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('301',9788932036052,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('301',9788986377453,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('301',9788932320267,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('301',9788932320274,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('301',9791155811566,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('302',9788950980221,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('302',9791196517106,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('302',9788954650892,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('302',9791190292023,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('302',9788992607148,0,1);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('401',9791190266017,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('401',9788965642473,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('401',9791195739585,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('401',9788965133520,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('401',9791185600031,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('402',9791159016646,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('402',9788934972464,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('402',9791190313193,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('402',9788954637756,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('402',9788971996676,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('501',9791160402971,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('501',9788962622508,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('501',9788934977841,0,5);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('501',9788965962205,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('501',9788956055466,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('502',9788934926184,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('502',9791186900963,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('502',9788971390849,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('502',9788984314238,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('502',9788979661682,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('503',9788946044807,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('503',9788955920123,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('503',9788958287155,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('503',9788961950213,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('503',9791157061105,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('601',9788994142364,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('601',9791155811887,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('601',9788994122267,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('601',9788983946522,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('601',9788994142302,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('602',9791130613512,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('602',9788932473475,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('602',9788918024769,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('602',9788983717436,0,6);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('602',9791162241387,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('603',9791195088355,0,1);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('603',9788935208647,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('603',9788959122981,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('603',9791129703361,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('603',9788932917740,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('604',9791130613512,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('604',9788979661682,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('604',9788932320250,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('604',9788937461033,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('604',9791186900864,0,2);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('701',9788958073123,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('701',9788937441943,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('701',9788968331862,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('701',9788934972464,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('701',9791195088355,0,5);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('702',9788994142302,0,5);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('702',9791160402971,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('702',9791190492249,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('702',9788983711892,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('702',9791190090018,0,6);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('703',9788932917740,0,3);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('703',9791157061105,0,5);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('703',9788934972464,0,4);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('703',9788954640756,0,5);
Insert into VILLAGEBOOK.RENTAL (LID,ISBN,RCNT,HAVECNT) values ('703',9788995408407,0,1);

create table library(
lid VARCHAR2(5) PRIMARY KEY,
lpw VARCHAR2(1000),
lname VARCHAR2(1000),
ltel VARCHAR2(50),
laddr VARCHAR2(1000),
lholiday VARCHAR2(1000),
loperate VARCHAR2(1000),
llogin NUMBER(1)
);


INSERT INTO library VALUES ('001','001', '종로구립도서관','02-2148-2024', '서울 종로구 삼봉로 43', '매주 화요일, 법정 공휴일 휴무', '평일:9시~20시, 주말:9시~17시', 0 );
INSERT INTO library VALUES ('002','002', '중구구립도서관','02-2230-2921~2', '서울 중구 동호로14길 18', '둘째주 월요일, 법정 공휴일 휴무', '평일:9시~22시, 주말:9시~17시', 0);
INSERT INTO library VALUES ('003','003', '용산구립도서관','02-714-3931', '서울 용산구 백범로 329', '매주 월요일, 법정 공휴일 휴무', '평일:9시~20시, 주말:9시~17시' , 0);

INSERT INTO library VALUES ('101','101', '도봉구통합도서관','02-955-0655', '서울 도봉구 덕릉로 315', '매주 화요일, 법정 공휴일 휴무', '평일:9시~22시, 주말:9시~17시', 0 );
INSERT INTO library VALUES ('102','102', '강북구립도서관','02-944-3100', '서울 강북구 오현로 145', '매주 목요일, 법정 공휴일 휴무', '평일:9시~20시, 주말:9시~17시' , 0);
INSERT INTO library VALUES ('103','103', '성북구립도서관','02-962-1081', '서울 성북구 화랑로18자길 13 ', '법정 공휴일 휴무', '평일:9시~21시, 주말:9시~17시', 0 );
INSERT INTO library VALUES ('104','104', '노원구립도서관','02-950-0050', '서울 노원구 노원로34길 43', '둘째주 수요일, 법정 공휴일 휴무', '평일:9시~22시, 주말:9시~17시' , 0);

INSERT INTO library VALUES ('201','201', '동대문구립도서관','02-960-1959', '서울 동대문구 회기로10길 60', '매주 월요일, 법정 공휴일 휴무', '평일:9시~20시, 주말:9시~17시', 0 );
INSERT INTO library VALUES ('202','202', '중랑구립도서관','02-490-9113', '서울 중랑구 신내로15길 197', '둘째주 월요일, 법정 공휴일 휴무', '평일:9시~18시, 주말:9시~17시' , 0);
INSERT INTO library VALUES ('203','203', '성동구립도서관','02-2204-6420', '서울 성동구 고산자로 10길9', '매주 월요일, 법정 공휴일 휴무', '평일:9시~20시, 주말:9시~17시', 0 );
INSERT INTO library VALUES ('204','204', '광진구립도서관','02-3437-5092', '서울 광진구 아차산로78길 90', '매월 둘째, 넷째 화요일, 법정 공휴일 휴무', '평일:9시~20시, 주말:9시~17시', 0 );

INSERT INTO library VALUES ('301','301', '강동구립도서관','02-488-7223', '서울 강동구 동남로 870,', '둘째주 화요일, 법정 공휴일 휴무', '평일:9시~19시, 주말:9시~17시', 0 );
INSERT INTO library VALUES ('302','302', '송파구립도서관','02-449-8855', '서울 송파구 충민로 120', '매주 수요일, 법정 공휴일 휴무', '평일:9시~20시, 주말:9시~17시', 0 );

INSERT INTO library VALUES ('401','401', '서초구립도서관','02-520-8700', '서울 서초구 고무래로 34 ', '매주 월요일, 법정 공휴일 휴무', '평일:9시~18시, 주말:9시~17시', 0 );
INSERT INTO library VALUES ('402','402', '강남구립도서관','02-565-6666', '서울 강남구 삼성로 212', '둘째주 화요일, 법정 공휴일 휴무', '평일:9시~19시, 주말:9시~17시' , 0);

INSERT INTO library VALUES ('501','501', '동작구립도서관','070-7204-3255', '서울 동작구 노량진로 74', '매주 월요일, 법정 공휴일 휴무', '평일:9시~20시, 주말:9시~17시', 0 );
INSERT INTO library VALUES ('502','502', '관악구립도서관','02-828-5700', '서울 관악구 관악로 30길 23', '매주 월요일, 법정 공휴일 휴무', '평일:9시~20시, 주말:9시~17시', 0);
INSERT INTO library VALUES ('503','503', '금천구립도서관','02-865-6817~9', '서울 금천구 가산로5길 43 ', '매주 월요일, 법정 공휴일 휴무', '평일:7시~20시, 주말:9시~17시', 0 );

INSERT INTO library VALUES ('601','601', '강서구립도서관','02-3664-6990', '서울 강서구 공항대로61길', '법정 공휴일 휴무', '평일:9시~20시, 주말:9시~17시', 0 );
INSERT INTO library VALUES ('602','602', '양천구립도서관','02-2620-3114', '서울 양천구 목동동로 105', '매주 목요일, 법정 공휴일 휴무', '평일:9시~20시, 주말:9시~17시' , 0);
INSERT INTO library VALUES ('603','603', '영등포구립도서관','02-828-3700', '서울 영등포구 여의대로 24', '매주 화요일, 법정 공휴일 휴무', '평일:9시~20시, 주말:9시~17시' , 0);
INSERT INTO library VALUES ('604','604', '구로구립도서관','02-830-1623', '서울 구로구 구로동로26길 54', '매주 화요일, 법정 공휴일 휴무', '평일:9시~16시, 주말:9시~17시', 0 );

INSERT INTO library VALUES ('701','701', '은평구립도서관','02-388-9451', '서울 은평구 통일로78가길', '매주 월요일, 법정 공휴일 휴무', '평일:9시~22시, 주말:9시~17시', 0 );
INSERT INTO library VALUES ('702','702', '마포구립도서관','02-3153-5800', '서울 마포구 성산로 128', '매주 월요일, 법정 공휴일 휴무', '평일:9시~22시, 주말:9시~17시', 0 );
INSERT INTO library VALUES ('703','703', '서대문구립도서관','02-360-8675', '서울 서대문구 증가로10길 16-15', '매주 월요일, 법정 공휴일 휴무', '평일:9시~22시, 주말:9시~17시' , 0);

INSERT INTO LIBRARY VALUES ('admin','admin', '중앙관리자','02-492-5870', '서울 마포구 성산로 128', '연중무휴', '24시간', 1 );

CREATE TABLE AREA (
    GU VARCHAR2(15),
    ID NUMBER(2)
);
INSERT INTO AREA VALUES('용산구', 0);
INSERT INTO AREA VALUES('종로구', 0);
INSERT INTO AREA VALUES('중구', 0);
INSERT INTO AREA VALUES('강북구', 1);
INSERT INTO AREA VALUES('도봉구', 1);
INSERT INTO AREA VALUES('노원구', 1);
INSERT INTO AREA VALUES('성북구', 1);
INSERT INTO AREA VALUES('광진구', 2);
INSERT INTO AREA VALUES('동대문구', 2);
INSERT INTO AREA VALUES('성동구', 2);
INSERT INTO AREA VALUES('중랑구', 2);
INSERT INTO AREA VALUES('강동구', 3);
INSERT INTO AREA VALUES('송파구', 3);
INSERT INTO AREA VALUES('강남구', 4);
INSERT INTO AREA VALUES('서초구', 4);
INSERT INTO AREA VALUES('관악구', 5);
INSERT INTO AREA VALUES('동작구', 5);
INSERT INTO AREA VALUES('금천구', 5);
INSERT INTO AREA VALUES('강서구', 6);
INSERT INTO AREA VALUES('양천구', 6);
INSERT INTO AREA VALUES('구로구', 6);
INSERT INTO AREA VALUES('영등포구', 6);
INSERT INTO AREA VALUES('은평구', 7);
INSERT INTO AREA VALUES('마포구', 7);
INSERT INTO AREA VALUES('서대문구', 7);

create table reserve(
    revid number(38),
    cid varchar2(20),
    isbn number(13),
    lid VARCHAR2(5),
    revrank number(1)
);

create sequence rev_id
start with 1
increment by 1
nocycle;

create table POINT (
    PID NUMBER,
    CID VARCHAR2(20),
    ORDID NUMBER(38),
    PLUSP NUMBER,
    MINUSP NUMBER
);

CREATE SEQUENCE PID_SEQ START WITH 1 INCREMENT BY 1 NOCYCLE;
insert into point values(PID_SEQ.NEXTVAL, 'test', 0, 10000, 0);
insert into point values(PID_SEQ.NEXTVAL, 'book', 0, 10000, 0);
insert into point values(PID_SEQ.NEXTVAL, 'local', 0, 10000, 0);

create table qna_reply(
    qreplyid number(38),
    seq number(38),
    writer varchar2(30),
    regdate date default sysdate,
    rcontent varchar2(1000)
);

create sequence qreplyid_seq
start with 1
increment by 1
nocycle;

insert into qna_reply values (qreplyid_seq.nextval, 1, 'test', sysdate, '작성자다');
insert into qna_reply values (qreplyid_seq.nextval, 1, 'local', sysdate, '댓글 첨써봄');

create table notice_reply(
    nreplyid number(38),
    seq number(38),
    writer varchar2(30),
    regdate date default sysdate,
    rcontent varchar2(1000)
);

create sequence nreplyid_seq
start with 1
increment by 1
nocycle;

CREATE TABLE nomi(
seq number(38),
title VARCHAR2(1000),
writer varchar2(100),
content VARCHAR2(1000),
rating integer default 0,
regdate date default sysdate,
cnt INTEGER default 0
);

insert into nomi(seq,title,writer,content, rating) values(1,'나의 라임 오렌지 나무 핵추','admin','어렸을 때는 잘 몰랐는데 최근에 다시 읽고 심금을 울렸어요~ 감동눈물 왈칵이라네요', 5);
insert into nomi(seq,title,writer,content, rating) values(2,'데이터 통신','admin','데이터 프로토콜의 베이직 그래머급 내용은 졸린데 지금 생각해보면 다 피와 살이 되고 있어요! 전공자분들 꼭 봐보세욤 1장부터 읽는거 추천',3);

CREATE TABLE MESSAGE(
    mid NUMBER NOT NULL,
    targetid VARCHAR2(30) NOT NULL,
    sender VARCHAR2(30) NOT NULL,
    message VARCHAR2(4000) NOT NULL,
    opendate DATE,
    senddate DATE DEFAULT SYSDATE
);

CREATE SEQUENCE m_seq START WITH 1 INCREMENT BY 1;
INSERT INTO MESSAGE VALUES (M_SEQ.NEXTVAL, 'test', '중앙관리자', '님 연체료 오배건', NULL, SYSDATE);

CREATE TABLE NOMIHEART(
    nheart NUMBER NOT NULL,
    seq NUMBER(38) NOT NULL,
    sender VARCHAR2(30) NOT NULL
);

CREATE SEQUENCE nheart_seq START WITH 1 INCREMENT BY 1;

commit;