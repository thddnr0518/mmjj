-- 회원 테이블 생성
CREATE TABLE member(
userid      VARCHAR2(20)                NOT NULL,
userpw      VARCHAR2(100)               NOT NULL,
nickname    VARCHAR2(30 BYTE)           NOT NULL,
email       VARCHAR2(60 BYTE)           NOT NULL,
username    VARCHAR2(30 BYTE)           NOT NULL,
birth       VARCHAR2(8 BYTE)            NOT NULL,
gender      CHAR(1 BYTE)                NOT NULL,
zipnum      VARCHAR2(8 BYTE)            NOT NULL,
addr        VARCHAR2(120 BYTE)          NOT NULL,
phone       VARCHAR2(15 BYTE)           NOT NULL,
useryn      CHAR(1 BYTE) DEFAULT 'y'    NOT NULL,
enabled     CHAR(1) DEFAULT '1',
regdate     DATE DEFAULT sysdate,
updatedate  DATE DEFAULT sysdate
);

-- 회원 키 설정 및 관계 설정
ALTER TABLE member
ADD CONSTRAINT member_userid_PK PRIMARY KEY (userid);

--게시판 테이블 생성
CREATE TABLE board(
bno         NUMBER(10)      NOT NULL,
title       VARCHAR2(200)   NOT NULL,
content     VARCHAR2(1000)  NOT NULL,
writer      VARCHAR2(50)    NOT NULL,
regdate     DATE            DEFAULT sysdate,
viewcnt     NUMBER          DEFAULT 0
);

-- 인덱스 생성
CREATE UNIQUE INDEX idx_board_PK ON board (bno ASC);

-- 게시판 키 설정 및 관계 설정
ALTER TABLE board
ADD CONSTRAINT board_bno_PK PRIMARY KEY (bno);

-- 게시판 시퀀스 생성
CREATE SEQUENCE board_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

-- 리플 생성
CREATE TABLE reply(
rno         NUMBER(10)      NOT NULL,
bno         NUMBER(10)      NOT NULL,
replytext   VARCHAR2(1000)  NOT NULL,
replyer     VARCHAR2(50)    NOT NULL,
regdate     DATE            DEFAULT sysdate,
updatedate  DATE            DEFAULT sysdate
);

-- 리플 인덱스 생성
CREATE UNIQUE INDEX IDX_reply_PK ON reply
(bno DESC, rno ASC);

-- 리플 키 설정 및 관계 설정
ALTER TABLE reply
ADD(CONSTRAINT reply_rno_PK PRIMARY KEY(rno),
    CONSTRAINT reply_bno_FK FOREIGN KEY(bno) REFERENCES board(bno));

-- 리플 시퀀스 생성
CREATE SEQUENCE reply_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

-- 리플 카운트 삽입
ALTER TABLE board ADD (replycnt NUMBER DEFAULT 0);

-- 파일 업로드 테이블 생성
CREATE TABLE attach
(
    uuid        VARCHAR2(100)   NOT NULL,
    uploadPath  VARCHAR2(200)   NOT NULL,
    fileName    VARCHAR2(100)   NOT NULL,
    filetype    CHAR(1)     DEFAULT 'I',
    bno         NUMBER
);

-- 파일 업로드 키 설정 및 관계 설정
ALTER TABLE attach
ADD (CONSTRAINT attach_uuid_PK PRIMARY KEY (uuid),
     CONSTRAINT attach_bno_FK FOREIGN KEY (bno) REFERENCES board (bno));

-- 회원 데이터 삽입
INSERT INTO member(id, pwd, nickname, email, name, birth, gender, zip_num, addr, phone)
VALUES('user04','1234','테스트닉네임','테스트이메일','테스트이름','20201119','M','1234','광주 광역시 중흥동 한경빌딩','01012341234');

INSERT INTO member(id, pwd, nickname, email, name, birth, gender, zip_num, addr, phone)
VALUES('1234','1234','일이삼사닉네임','1234이메일','1234이름','20201119','M','1234','광주 광역시 중흥동 한경빌딩','01012341234');

-- 게시판 데이터 삽입
INSERT INTO board(bno,title, content, writer)
VALUES (BOARD_SEQ.nextval ,'테스트글입니다' ,'테스트글의 내용입니다' ,'user04');

-- 이타스 데이터 복제
INSERT INTO board(bno, title, content, writer)
(SELECT board_seq.nextval, title, content, writer
FROM board);

-- 이타스 리플 복제
INSERT INTO reply(rno, bno, replytext, replyer)
(SELECT board_seq.nextval, bno, replytext, replyer
FROM reply);

-- 리플 데이터 삭제
DELETE FROM reply;

-- sequrity 권한 테이블
CREATE TABLE member_auth(
userid      VARCHAR2(20 BYTE)           NOT NULL,
auth        VARCHAR2(50)                NOT NULL,
CONSTRAINT fk_member_auth FOREIGN KEY(userid) REFERENCES member(userid)
);

SELECT
    mem.userid, userpw, nickname, email, name, birth, gender, zipnum, addr, phone, useryn, enabled, regdate, updatedate, auth
FROM
    member mem LEFT OUTER JOIN member_auth auth on mem.userid = auth.userid
WHERE mem.userid = 'admin0';

UPDATE  board
SET     viewcnt = viewcnt + 400
WHERE   bno = 3237;

commit;

SELECT *
FROM    attach
WHERE   bno = 3237;

SELECT  rownum,
        e.*
FROM    (SELECT b.viewcnt,
                b.title,
                b.bno,
                b.writer,
                a.uuid,
                a.uploadpath,
                a.filename
        FROM    board b,
                attach a
        WHERE   b.bno = a.bno
        AND     a.filetype = 1
        ORDER BY b.viewcnt DESC)e
WHERE   rownum <= 3;


--security 테이블 예제
CREATE TABLE users(
username varchar2(50) not null primary key,
password varchar2(50) not null,
enabled char(1) default '1'
);

CREATE TABLE authorities(
username varchar2(50) not null,
authority varchar2(50) not null,
constraint fk_authorities_users foreign key(username) references users(username)
);

insert into tbl_member(userid, userpw, username)
VALUES('admin00', 'pw00', 'admin');

insert into tbl_member_auth(userid, auth)
VALUES('admin0', 'ROLE_MEMBER');

CREATE unique index ix_auth_username on authorities (username,authority);

insert into users (username, password) values('user00', 'pw00');
insert into users (username, password) values('member00', 'pw00');
insert into users (username, password) values('admin00', 'pw00');

insert into authorities (username, authority) values ('user00','ROLE_USER');
insert into authorities (username, authority) values ('member00','ROLE_MANAGER');
insert into authorities (username, authority) values ('admin00','ROLE_MANAGER');
insert into authorities (username, authority) values ('admin00','ROLE_ADMIN');

commit;

drop table users;!!!!!!!!!!!!!!!!!!!!!!!!