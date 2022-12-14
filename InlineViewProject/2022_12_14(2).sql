/*
    SEQUENCE : �ڵ� ������ȣ ==> PK�϶� ���
    --------
      MAXVALUE : ������
      MINVALUE : ���۰�
      -------------------- ���� ���� ���� (���Ѵ�)
      START WITH : ��𼭺��� ������ ������ ����
                START WITH 1, START WITH 100
      INCREMENT BY : ��� ���� ����
                INCREMENT BY 1 ==> 1�� ����, INCREMENT BY 100
                                ---------- �Խù���ȣ, ��۹�ȣ, ��ٱ��� ��ȣ, ....
      CACHE | NOCACHE 
      -----   -------
      CACHE : 1~20���� �̸� ��ȣ�� ������ ���
      CYCLE | NOCYCLE
      -----   -------
      �������� ���� ��� => �ٽ� ó������ ���� 
      
      ** ���簪 �б� ==> currVal
      ** ������ �б� ==> nextVal
      
      1) ����
         CREATE SEQUENCE seq_name
         START WITH 1
         INCREMENT BY 1
         NOCACHE 
         NOCYCLE
      2) ����
         DROP SEQUENCE seq_name
    ** ������ ����
       ----------
       ���̺��_�÷���_seq;
       board_no_seq
       notice_no_seq ...
       ------------------------> CREATE�� ����� �� ���� ���� ����
       ��üŰ,�ĺ�Ű�� ������ �����ϴ� ���� �ƴϴ� => (�⺻Ű ã�� ==> ȸ������)
       
*/
CREATE SEQUENCE test_no_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

SELECT test_no_seq.nextVal FROM DUAL;
SELECT test_no_seq.currVal FROM DUAL;
DROP SEQUENCE test_no_seq;
/*
    ����ȭ�� ������ : ���α׷����� �ʿ��� �����͸� ���� => RDBMS(����Ŭ, MySQL)
    ------------ �����͸� ����
    ������ȭ : �ʿ���� �����͸� ����, ������ �Ǿ��ִ�
    ������ȭ : �ʿ��� ������, �ʿ���� ������ �����ִ�, ���е� ����
    
*/
CREATE TABLE board(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT board_name_nn NOT NULL,
    subject VARCHAR2(4000) CONSTRAINT board_subject_nn NOT NULL,
    content CLOB CONSTRAINT board_content_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT board_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    CONSTRAINT board_no_pk PRIMARY KEY(no)
);

-- no ó��(�ߺ��� ���� ������) => �ڵ����� ó��
CREATE SEQUENCE board_no_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'ȫ�浿','������ ���','������ �����..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'ȫ�浿','������ ���','������ �����..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'ȫ�浿','������ ���','������ �����..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'ȫ�浿','������ ���','������ �����..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'ȫ�浿','������ ���','������ �����..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'ȫ�浿','������ ���','������ �����..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'ȫ�浿','������ ���','������ �����..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'ȫ�浿','������ ���','������ �����..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'ȫ�浿','������ ���','������ �����..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'ȫ�浿','������ ���','������ �����..','1234');

COMMIT;
SELECT * FROM board;

DELETE FROM board WHERE no=3;

CREATE TABLE notice(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT notice_name_nn NOT NULL,
    msg CLOB CONSTRAINT notice_msg_nn NOT NULL,
    CONSTRAINT notice_no_pk PRIMARY KEY(no)
);

CREATE SEQUENCE notice_no_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

INSERT INTO notice VALUES(notice_no_seq.nextVal,'ȫ�浿','��������');
COMMIT;
SELECT * FROM notice;