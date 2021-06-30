--ȸ�� ���̺� ����
CREATE TABLE member (
	id VARCHAR2(10) PRIMARY KEY, /* ���̵� */
	pwd VARCHAR2(10) NOT NULL, /* ��й�ȣ */
	name VARCHAR2(50) NOT NULL, /* �̸� */
	email VARCHAR2(50) NOT NULL, /* �̸��� */
	joinDate DATE DEFAULT sysdate NOT NULL /* �������� */
);

--ȸ�� ���� �߰�
INSERT INTO member values('hong', '1212', 'ȫ�浿', 'hong@gmail.com', sysdate);
INSERT INTO member values('lee', '3434', '�̼���', 'lee@naver.com', sysdate);
INSERT INTO member values('kim', '5656', '������', 'kim@gmail.com', sysdate);

--�Խ��� ���̺� ����
CREATE TABLE board (
	articleNO NUMBER(10) PRIMARY KEY, /* �� ��ȣ */
	title VARCHAR(500) NOT NULL, /* �� ���� */
	content VARCHAR(4000) NOT NULL, /* �� ���� */
	imageFileName VARCHAR(100), /* �̹��� ���� �̸� */
	writeDate DATE DEFAULT sysdate NOT NULL, /* �ۼ��� */
	id VARCHAR2(10), /* ���̵� */
    CONSTRAINT FK_MEM FOREIGN KEY(id) references member(id)
);

--�׽�Ʈ �� �߰�
insert into board(articleNO, title, content, imageFileName, writedate, id) values(1, '�׽�Ʈ���Դϴ�', '�׽�Ʈ���Դϴ�', null, sysdate, 'hong');
insert into board(articleNO, title, content, imageFileName, writedate, id) values(2, '�ȳ��ϼ���', '��ǰ �ı��Դϴ�', null, sysdate, 'hong');
insert into board(articleNO, title, content, imageFileName, writedate, id) values(3, '�亯�Դϴ�', '��ǰ �ı⿡ ���� �亯�Դϴ�', null, sysdate, 'hong');
insert into board(articleNO, title, content, imageFileName, writedate, id) values(5, '�亯�Դϴ�', '��ǰ �����ϴ�', null, sysdate, 'lee');
insert into board(articleNO, title, content, imageFileName, writedate, id) values(4, '�������Դϴ�', '������ �׽�Ʈ���Դϴ�', null, sysdate, 'kim');
insert into board(articleNO, title, content, imageFileName, writedate, id) values(6, '��ǰ �ı��Դϴ�..', '�̼��ž��� ��ǰ ��� �ı⸦ �ø��ϴ�!!', null, sysdate, 'lee');

--��� ���̺� ����
CREATE TABLE comments (
	commentNO NUMBER(10) PRIMARY KEY, /* ��� ��ȣ */
	content VARCHAR(4000), /* ��� ���� */
	writeDate DATE DEFAULT sysdate NOT NULL, /* �ۼ��� */
	articleNO NUMBER(10), /* �� ��ȣ */
	id VARCHAR2(10), /* ���̵� */
    CONSTRAINT FK_MEM2 FOREIGN KEY(id) references member(id),
    CONSTRAINT FK_ART FOREIGN KEY(articleNO) references board(articleNO)
);

--�׽�Ʈ ��� �߰�
insert into comments(commentNO, content, writeDate, articleNO, id) values(1, '��.. ���е�..', sysdate, 1, 'hong');
insert into comments(commentNO, content, writeDate, articleNO, id) values(2, '�� ���!!!!', sysdate, 1, 'lee');
insert into comments(commentNO, content, writeDate, articleNO, id) values(3, '��~~~~', sysdate, 2, 'kim');
insert into comments(commentNO, content, writeDate, articleNO, id) values(4, '���� ���� �����մϴ�~', sysdate, 2, 'kim');
insert into comments(commentNO, content, writeDate, articleNO, id) values(5, '�����־��~~', sysdate, 3, 'hong');
insert into comments(commentNO, content, writeDate, articleNO, id) values(6, '��??', sysdate, 3, 'lee');
insert into comments(commentNO, content, writeDate, articleNO, id) values(7, '���� �ݴ��մϴ�.', sysdate, 3, 'hong');
insert into comments(commentNO, content, writeDate, articleNO, id) values(8, '���� �����մϴ�.', sysdate, 4, 'kim');
insert into comments(commentNO, content, writeDate, articleNO, id) values(9, '�׳�~~', sysdate, 4, 'lee');
insert into comments(commentNO, content, writeDate, articleNO, id) values(10, '�˰ڽ��ϴ�!', sysdate, 5, 'kim');
insert into comments(commentNO, content, writeDate, articleNO, id) values(11, '�ٵ� �̰� ��..', sysdate, 5, 'lee');
insert into comments(commentNO, content, writeDate, articleNO, id) values(12, '��Ű��Ű~~', sysdate, 6, 'hong');
insert into comments(commentNO, content, writeDate, articleNO, id) values(13, '��..', sysdate, 6, 'lee');

commit;
