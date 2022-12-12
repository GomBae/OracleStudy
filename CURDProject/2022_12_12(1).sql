/*

TABLE : ������ ���� �����
  1. ��������
     ������
       CHAR(1~2000byte)
         => ���� ����Ʈ (���ڼ��� ���� => ����/���� , y,n, y,n)
         => CHAR(10)
       VARCHAR2(1~4000byte) default(����Ŭ������ ����� ����)
         => ��������Ʈ
       CLOB(4�Ⱑ) => ��������Ʈ => ���ڿ� ���� 
    ������
       NUMBER(38) ==> int, long
       NUMBER(4) ==> ������ �� �ִ� ������ ==> 0~9999
       NUMBER =====> 8�ڸ����� ���� ==> NUMBER(8,2)
       NUMBER(7,2) ==> 7�ڸ����� ������ ����, ���� 5�ڸ�, �Ҽ��� 2�ڸ�
       -------------- ������ �Ǽ��� �����ϴ°��� �ƴ�(������ �����ص� ��)
    ��¥��
       DATE : default
       TIMESTAMP : ��� ���
    ��Ÿ��
       BLOB : 2������, BFILE(file����) ==> ������ ������ => ������ �о ���
       => HTML�� ��ũ 
    1-1. 
        ���̺��(�ĺ���)
         1) ���� �����ͺ��̽� (XE)���� ���� �̸��� ���̺��� ���� �� ����
         2) ���ڷ� �����Ѵ� (���ĺ�, �ѱ�) => �翬�� ���ĺ����� �����ض�
            => �ü������ �ѱ� �д� ����� �ٸ���
            => ���ĺ��� ���� ��ҹ��� ������ ����
            => ���� ����Ŭ�� ����� �� �빮�ڷ� �����(���� ���̺��� ������ ���� ��)
         3) ���̺��(30) ==> 15�� : ���̺�� �÷��� ���� �� �� �ִ�
         4) ���ڴ� ����� �� �ִ� (�� �տ� ��� ����)
         5) Ű���� ������ (SELECT, INSERT)
         6) Ư������ ��밡��(_)
  2. �������� : �̻������� ����(���α׷��� �ʿ��� �����͸� ����)
                ----------- ����, ���� => ������ �ʴ� �����Ͱ� ����, ������ �� �ִ�.
            1) NOT NULL : NULL�� ������� �ʴ´�(������ �����Ͱ��� �ʿ�� �Ѵ�)
            2) UNIQUE : ���ϰ� (�ߺ��� ���� ������ => NULL���� ���)
                 * �ĺ�Ű(��üŰ) => �⺻Ű�� �Ҿ������ ��� => �̸���, ��ȭ��ȣ
            3) PRIMARY KEY : �⺻Ű => ������, ID => �ߺ��� ���� ��
                * ��� ���̺��� PK�� �Ѱ��̻� ������ ����
                NOT NULL + UNIQUE
            4) FOREIGN KEY : ����Ű => �����ϰ� �ִ� �����Ͱ��� ����(�ٸ� ���̺�� ����)
            5) CHECK : ������ �����Ͱ��� �Է��� �����ϰ� �����
            6) DEFAULT : �̸� �⺻���� ������ �Ŀ� ==> �����Ͱ��� ���� ��� �ڵ����� ���� �Է� 
                        regdate DATE DEFAULT SYSDATE
                        hit NUMBER DEFAULT 0
  ----------------------------------------------------------------------------------
  2-1 . TABLE �����
        1) ������ ���̺��� ���� (�����Ͱ�_���̺�����)
           CREATE TABLE table_name
           AS
           SELECT ~
        2) ���̺����¸� ���� 
           CREATE TABLE table_name
           AS
           SELECT ~
           WHERE 1=2; ==> WHERE������ false�� �ǰ� ����� ��
        3) ����� ����
        -------------------- COMMIT(AUTO)
  3. ����, ����, ������ �ڸ���
*/
-- ����
/*CREATE TABLE myEmp
AS
SELECT * FROM emp;
SELECT * FROM myEmp;
DESC myEmp;*/
/*CREATE TABLE myEmp2
AS
SELECT * FROM emp
WHERE 1=2;

SELECT * FROM myEmp2;
DESC myEmp2;*/
/*
����
DROP TABLE myEmp;
DROP TABLE myEmp2;
*/
/*
CREATE TABLE myEmp
AS
SELECT emp.*,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;

SELECT * FROM myEmp;
TRUNCATE TABLE myEmp; 
DROP TABLE myEmp;
*/
/*
    �ʿ���� ������ ���� : DELETE ===> ��Ұ���
    ��ü ������ ���� : TRUNCATE ==> ��ҺҰ�(���� �Ұ�)
    ���̺� ��ü ���� : DROP ==> ��ҺҰ�
    => DML(���� ����), DDL(���� �Ұ�) ==> ���
*/
DESC myEmp;
--���̺�� ���� => RENAME old_name TO new_name
RENAME myEmp TO myEmp2;
/*
    ����� ���� ���̺�
    --------------- 
    ����
       CREATE TABLE table_name(
            �÷��� �������� [��������], ==> �÷�����(�÷��� ���ÿ� ����) => NOT NULL, DEFAULT
            �÷��� �������� [��������],
            �÷��� �������� [��������],
            �÷��� �������� [��������],
            [��������] ==> ���̺��� => ���̺��� ������� ���� ���� => PK,FK,CHECK,UNIQUE
       );
    => ���
    CREATE TABLE member
    (
        id VARCHAR2(20) PRIMARY KEY,
        pwd VARCHAR2(10) NOT NULL,
        name VARCHAR2(34) NOT NULL,
        sex CHAR(10) CHECK(sex IN('����','����')),
        email VARCHAR2(100) UNIQUE,
        tel VARCHAR2(13) UNIQUE,
        regdate DATE DEFAULT SYSDATE
    );
    => �������ǿ� �̸��� �ο� ==> ���� (�������Ǹ� ����,������ �����ϴ�)
    CREATE TABLE member
    (
        id VARCHAR2(20),
        pwd VARCHAR2(10) CONSTRAINT member_pwd_nn NOT NULL,
                                    -------------  �ߺ��� ������� �ʴ´�
                                    ���̺��_�÷���_�������Ǿ���
                                    => pk (PRIMARY KEY)
                                    => nn (NOT NULL)
                                    => fk (FOREIGN KEY)
                                    => ck (CHECK)
                                    => uk (UNIQUE)
        name VARCHAR2(34) CONSTRAINT member_name_nn NOT NULL,
        sex CHAR(10),
        email VARCHAR2(100),
        tel VARCHAR2(13),
        regdate DATE DEFAULT SYSDATE,
        CONSTRAINT member_id_pk PRIMARY KEY(id),
        CONSTRAINT member_sex_ck CHECK(IN('����','����'))
        CONSTRAINT member_et_uk UNIQUE(email,tel)
    );
    
     emp
    EMPNO    NOT NULL NUMBER(4)    
    ENAME             VARCHAR2(10) 
    JOB               VARCHAR2(9)  
    MGR               NUMBER(4)    
    HIREDATE          DATE         
    SAL               NUMBER(7,2)  
    COMM              NUMBER(7,2)  
    DEPTNO            NUMBER(2)   

    dept
    DEPTNO NOT NULL NUMBER       
    DNAME           VARCHAR2(20) 
    LOC             VARCHAR2(20) 
    
    CREATE TABLE dept(
        deptno NUMBER(2),
        dname VARCHAR2(20) CONSTRAINT dept_dname_nn NOT NULL,
        loc VARCHAR2(20) CONSTRAINT dept_loc_nn NOT NULL,
        CONSTRAINT dept_deptno_pk PRIMARY KEY(deptno)
    );
    
    CREATE TABLE emp(
        empno NUMBER(4),
        ENAME             VARCHAR2(10) CONSTRAINT emp_ename_nn NOT NULL, 
        JOB               VARCHAR2(9) CONSTRAINT emp_job_nn NOT NULL,  
        MGR               NUMBER(4), -- NULL���� ���  
        HIREDATE          DATE DEFAULT SYSDATE,         
        SAL               NUMBER(7,2) CONSTRAINT emp_sal_nn NOT NULL,  
        COMM              NUMBER(7,2),  
        DEPTNO            NUMBER(2),
        CONSTRAINT emp_empno_pk PRIMARY KEY(empno),
        CONSTRAINT emp_deptno_fk FOREIGN KEY(deptno)
        REFERENCES dept(deptno)
    );
*/
/*
    �����ϴ� ���̺�
    ***�����Ǵ� ���̺� (�켱 ����)
    ����
    �Խù���ȣ => �ߺ��� �ȵǴ� ������ PK => �ڵ����� (������) => MAX
    �̸� => NOT NULL
    ���� => NOT NULL
    ���� => NOT NULL CLOB
    ��й�ȣ => ����/������ ���� Ȯ�� ==> NOU NULL
    ����� => DEFAULT SYSDATE
    ��ȸ�� => DEFAULT 0
    
*/
DROP TABLE board;
CREATE TABLE board(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT board_name_nn NOT NULL, 
    subject VARCHAR2(4) CONSTRAINT board_subject_nn NOT NULL,
    content CLOB CONSTRAINT board_content_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT board_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    address VARCHAR2(100),
    CONSTRAINT board_no_pk PRIMARY KEY(no)
);
-- ALTER => �÷��� ����, �÷��� ����, �÷��߰�, �������� ����
--�߰�
ALTER TABLE board ADD hit NUMBER DEFAULT 0;
DESC board;
--����
ALTER TABLE board MODIFY subject VARCHAR(4000);
--����
ALTER TABLE board DROP COLUMN address;
ALTER TABLE board ADD address VARCHAR2(100) CONSTRAINT board_address_no NOT NULL;
--�÷��� ����
ALTER TABLE board RENAME COLUMN address TO email;
-- ���������� �߰��ϴ� ��쿡 => �����Ͱ� ���� ��쿡�� ���� ����,
-- => ������ �ִ� ��� : NOT NULL, PRIMARY KEY, FOREIGN KEY, CHECK
/*
    ALTER
      �߰� : ADD
      ���� : DROP COLUMN
      ���� : MODIFY
*/
SELECT * FROM tab;
DROP TABLE member;
/*
    member
    id ==> PK
    pwd ==> NN
    sex ==> CHECK
    name == NN
    address 
    tel
*/
CREATE TABLE member(
    id VARCHAR2(20),
    pwd VARCHAR2(10) CONSTRAINT member_pwd_nn NOT NULL,
    sex VARCHAR(6),
    name VARCHAR2(34) CONSTRAINT member_name_nn NOT NULL,
    CONSTRAINT member_id_pk PRIMARY KEY(id),
    CONSTRAINT member_sex_ck CHECK(sex IN('����','����'))
);
INSERT INTO member VALUES('bbb',' ','����','ȫ�浿');
-- ''(NULL) , ' '(����)
SELECT * FROM member;
ALTER TABLE member ADD address VARCHAR2(100) DEFAULT ' ' CONSTRAINT member_address_nn NOT NULL;
-- ���������� �Ѱ��� ����ϴ°��� �ƴϰ� ������ ��� ����
-- ������ NOT NULL, UNIQUE, CHECK 
DROP TABLE board;
CREATE TABLE board(
    no NUMBER,
    name VARCHAR2(34), 
    subject VARCHAR2(4000),
    content CLOB,
    pwd VARCHAR2(10),
    regdate DATE,
    address VARCHAR2(100)
);
--ALTER�� �̿��ؼ� �������� �߰�
-- PRIMARY KEY �߰�
DESC board;
ALTER TABLE board ADD CONSTRAINT board_no_pk PRIMARY KEY(no);
-- NOT NULL 
-- PRIMARY KEY, FOREIGN KEY, CHECK, UNIQUE ===> ADD�� �����
-- NOT NULL ===> MODIFY�� �����ؾ���
ALTER TABLE board MODIFY name CONSTRAINT board_name_nn NOT NULL;
-- DEFAULT�� ���������� �ƴϴ�
ALTER TABLE board MODIFY regdate DATE DEFAULT SYSDATE;
-- �������� ����
ALTER TABLE board DROP CONSTRAINT board_name_nn;
DROP TABLE member2;
CREATE TABLE member2(
    id VARCHAR2(20),
    name VARCHAR2(30) CONSTRAINT mem_name_nn NOT NULL,
    email VARCHAR2(100),
    pwd VARCHAR2(10) CONSTRAINT mem_pwd_nn NOT NULL,
    CONSTRAINT mem_id_pk PRIMARY KEY(id),
    CONSTRAINT mem_email_pk PRIMARY KEY(email)
);

CREATE TABLE member2(
    id VARCHAR2(20),
    name VARCHAR2(30) CONSTRAINT mem_name_nn NOT NULL,
    email VARCHAR2(100),
    pwd VARCHAR2(10) CONSTRAINT mem_pwd_nn NOT NULL,
    CONSTRAINT mem_id_email_pk PRIMARY KEY(id,email)
);
--INSERT INTO member2 VALUES('aaa','hong','hong@co.kr','1234');
INSERT INTO member2 VALUES('aaa','shim','shim@co.kr','1234');
INSERT INTO member2 VALUES('bbb','park','park@co.kr','1234');
INSERT INTO member2 VALUES('ccc','kim','park@co.kr','1234');
/*
INSERT INTO member2 VALUES('aaa','hong','','1234');
SELECT * FROM member2;
DELETE FROM member2 WHERE id='aaa';*/