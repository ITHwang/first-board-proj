--회원 테이블 생성
CREATE TABLE member (
	id VARCHAR2(10) PRIMARY KEY, /* 아이디 */
	pwd VARCHAR2(10) NOT NULL, /* 비밀번호 */
	name VARCHAR2(50) NOT NULL, /* 이름 */
	email VARCHAR2(50) NOT NULL, /* 이메일 */
	joinDate DATE DEFAULT sysdate NOT NULL /* 가입일자 */
);

--회원 정보 추가
INSERT INTO member values('hong', '1212', '홍길동', 'hong@gmail.com', sysdate);
INSERT INTO member values('lee', '3434', '이순신', 'lee@naver.com', sysdate);
INSERT INTO member values('kim', '5656', '김유신', 'kim@gmail.com', sysdate);

--게시판 테이블 생성
CREATE TABLE board (
	articleNO NUMBER(10) PRIMARY KEY, /* 글 번호 */
	title VARCHAR(500) NOT NULL, /* 글 제목 */
	content VARCHAR(4000) NOT NULL, /* 글 내용 */
	imageFileName VARCHAR(100), /* 이미지 파일 이름 */
	writeDate DATE DEFAULT sysdate NOT NULL, /* 작성일 */
	id VARCHAR2(10), /* 아이디 */
    CONSTRAINT FK_MEM FOREIGN KEY(id) references member(id)
);

--테스트 글 추가
insert into board(articleNO, title, content, imageFileName, writedate, id) values(1, '테스트글입니다', '테스트글입니다', null, sysdate, 'hong');
insert into board(articleNO, title, content, imageFileName, writedate, id) values(2, '안녕하세요', '상품 후기입니다', null, sysdate, 'hong');
insert into board(articleNO, title, content, imageFileName, writedate, id) values(3, '답변입니다', '상품 후기에 대한 답변입니다', null, sysdate, 'hong');
insert into board(articleNO, title, content, imageFileName, writedate, id) values(5, '답변입니다', '상품 좋습니다', null, sysdate, 'lee');
insert into board(articleNO, title, content, imageFileName, writedate, id) values(4, '김유신입니다', '김유신 테스트글입니다', null, sysdate, 'kim');
insert into board(articleNO, title, content, imageFileName, writedate, id) values(6, '상품 후기입니다..', '이순신씨의 상품 사용 후기를 올립니다!!', null, sysdate, 'lee');

--댓글 테이블 생성
CREATE TABLE comments (
	commentNO NUMBER(10) PRIMARY KEY, /* 댓글 번호 */
	content VARCHAR(4000), /* 댓글 내용 */
	writeDate DATE DEFAULT sysdate NOT NULL, /* 작성일 */
	articleNO NUMBER(10), /* 글 번호 */
	id VARCHAR2(10), /* 아이디 */
    CONSTRAINT FK_MEM2 FOREIGN KEY(id) references member(id),
    CONSTRAINT FK_ART FOREIGN KEY(articleNO) references board(articleNO)
);

--테스트 댓글 추가
insert into comments(commentNO, content, writeDate, articleNO, id) values(1, '음.. 별론듯..', sysdate, 1, 'hong');
insert into comments(commentNO, content, writeDate, articleNO, id) values(2, '오 대박!!!!', sysdate, 1, 'lee');
insert into comments(commentNO, content, writeDate, articleNO, id) values(3, '오~~~~', sysdate, 2, 'kim');
insert into comments(commentNO, content, writeDate, articleNO, id) values(4, '좋은 정보 감사합니다~', sysdate, 2, 'kim');
insert into comments(commentNO, content, writeDate, articleNO, id) values(5, '질문있어요~~', sysdate, 3, 'hong');
insert into comments(commentNO, content, writeDate, articleNO, id) values(6, '잉??', sysdate, 3, 'lee');
insert into comments(commentNO, content, writeDate, articleNO, id) values(7, '저는 반대합니다.', sysdate, 3, 'hong');
insert into comments(commentNO, content, writeDate, articleNO, id) values(8, '저는 동의합니다.', sysdate, 4, 'kim');
insert into comments(commentNO, content, writeDate, articleNO, id) values(9, '네넹~~', sysdate, 4, 'lee');
insert into comments(commentNO, content, writeDate, articleNO, id) values(10, '알겠습니다!', sysdate, 5, 'kim');
insert into comments(commentNO, content, writeDate, articleNO, id) values(11, '근데 이건 좀..', sysdate, 5, 'lee');
insert into comments(commentNO, content, writeDate, articleNO, id) values(12, '오키오키~~', sysdate, 6, 'hong');
insert into comments(commentNO, content, writeDate, articleNO, id) values(13, '헐..', sysdate, 6, 'lee');

commit;
