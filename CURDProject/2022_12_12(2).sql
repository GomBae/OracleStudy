-- DML
/*
    DQL : SELECT (�����Ͱ˻�)
          SELECT �÷���,(SELECT~) => ��Į�� ��������
          FROM table_name|(SELECT~) => �ζ��κ�
          WHERE �÷��� ������ (SELECT~) => �������� (����, ����)
    DDL : ���Ǿ�� (table, view, index)
          CREATE
          ALTER
          DROP
          TRUNCATE
          RENAME
*/
/*
CREATE TABLE �Ǹ���ǥ(
    ��ǥ��ȣ VARCHAR2(13),
    �Ǹ����� DATE  DEFAULT SYSDATE CONSTRAINT �Ǹ���ǥ_�Ǹ�����_nn NOT NULL,
    ���� VARCHAR2(34) CONSTRAINT �Ǹ���ǥ_����_nn NOT NULL,
    �Ѿ� NUMBER,
    CONSTRAINT �Ǹ���ǥ_��ǥ��ȣ_pk PRIMARY KEY(��ǥ��ȣ),
    CONSTRAINT �Ǹ���ǥ_�Ѿ�_ck CHECK(�Ѿ�>0)
);
*/
/*
CREATE TABLE ��ǰ(
    ��ǰ��ȣ VARCHAR2(12),
    ��ǰ�� VARCHAR2(100) CONSTRAINT ��ǰ_��ǰ��_nn NOT NULL,
    ��ǰ�ܰ� NUMBER,
    CONSTRAINT ��ǰ_��ǰ��ȣ_pk PRIMARY KEY(��ǰ��ȣ),
    CONSTRAINT ��ǰ_��ǰ�ܰ�_ck CHECK(��ǰ�ܰ�>0)
);
*/
/*
CREATE TABLE ��ǥ��(
    ��ǥ��ȣ VARCHAR2(13),
    ��ǰ��ȣ VARCHAR2(100),
    ���� NUMBER CONSTRAINT ��ǥ��_����_nn NOT NULL,
    �ܰ� NUMBER CONSTRAINT ��ǥ��_�ܰ�_nn NOT NULL,
    �ݾ� NUMBER,
    CONSTRAINT ��ǥ��_��ǥ��ȣ_pk PRIMARY KEY(��ǥ��ȣ),
    CONSTRAINT ��ǥ��_�ݾ�_ck CHECK(�ݾ�>0),
    CONSTRAINT ��ǥ��_��ǥ��ȣ_fk FOREIGN KEY(��ǥ��ȣ)
    REFERENCES �Ǹ���ǥ(��ǥ��ȣ),
    CONSTRAINT ��ǥ��_��ǰ��ȣ_fk FOREIGN KEY(��ǰ��ȣ)
    REFERENCES ��ǰ(��ǰ��ȣ)
);
*/
--���̺��� �������� Ȯ��
SELECT * FROM user_constraints
WHERE table_name='��ǥ��';
/*
    CONSTRAINT Type
    C : CHECK, NOT NULL
    P : PRIMARY KEY
    R : FOREIGN
    U : UNIQUE
*/
DROP TABLE �Ǹ���ǥ;
DROP TABLE ��ǰ;
DROP TABLE ��ǥ��;

CREATE TABLE �Ǹ���ǥ(
    ��ǥ��ȣ VARCHAR2(13),
    �Ǹ����� DATE,
    ���� VARCHAR2(34),
    �Ѿ� NUMBER
);
DESC �Ǹ���ǥ;
ALTER TABLE �Ǹ���ǥ ADD CONSTRAINT �Ǹ���ǥ_��ǥ��ȣ_pk PRIMARY KEY(��ǥ��ȣ); --PK ����
ALTER TABLE �Ǹ���ǥ MODIFY �Ǹ����� DATE CONSTRAINT �Ǹ���ǥ_�Ǹ�����_nn NOT NULL;
ALTER TABLE �Ǹ���ǥ MODIFY ���� VARCHAR2(34) CONSTRAINT �Ǹ���ǥ_����_nn NOT NULL;
ALTER TABLE �Ǹ���ǥ ADD CONSTRAINT �Ǹ���ǥ_�Ѿ�_ck CHECK(�Ѿ�>0);

CREATE TABLE ��ǰ(
    ��ǰ��ȣ VARCHAR2(12),
    ��ǰ�� VARCHAR2(100),
    ��ǰ�ܰ� NUMBER
);
ALTER TABLE ��ǰ ADD CONSTRAINT ��ǰ_��ǰ��ȣ_pk PRIMARY KEY(��ǰ��ȣ);
ALTER TABLE ��ǰ ADD CONSTRAINT ��ǰ_��ǰ��_uk UNIQUE(��ǰ��);
ALTER TABLE ��ǰ ADD CONSTRAINT ��ǰ_��ǰ�ܰ�_ck CHECK(��ǰ�ܰ�>0);
CREATE TABLE ��ǥ��(
    ��ǥ��ȣ VARCHAR2(13),
    ��ǰ��ȣ VARCHAR2(100),
    ���� NUMBER,
    �ܰ� NUMBER,
    �ݾ� NUMBER
);
DESC ��ǥ��;
ALTER TABLE ��ǥ�� ADD CONSTRAINT ��ǥ��_��ǥ��ȣ_pk PRIMARY KEY(��ǥ��ȣ);
ALTER TABLE ��ǥ�� ADD CONSTRAINT ��ǥ��_��ǥ��ȣ_fk FOREIGN KEY(��ǥ��ȣ)
REFERENCES �Ǹ���ǥ(��ǥ��ȣ);
ALTER TABLE ��ǥ�� ADD CONSTRAINT ��ǥ��_��ǰ��ȣ_fk FOREIGN KEY(��ǰ��ȣ)
REFERENCES ��ǰ(��ǰ��ȣ);
ALTER TABLE ��ǥ�� MODIFY ���� CONSTRAINT ��ǥ��_����_nn NOT NULL;
ALTER TABLE ��ǥ�� MODIFY �ܰ� CONSTRAINT ��ǥ��_�ܰ�_nn NOT NULL;
ALTER TABLE ��ǥ�� ADD CONSTRAINT ��ǥ��_�ݾ�_ck CHECK(�ݾ�>0);
/*
    ALTER : ���̺� ����
      �÷� �߰�
      �÷� ����
      �÷� ����
      �÷� �̸� ����
      �÷� �������� ����
      
    �����͸� ���� : TRUNCATE
      ����
        TRUNCATE TABLE table_name; => ���̺� ������ �����ִ�
    ���̺� ���� : DROP
      ����
        DROP TABLE table_name; => ���̺� �������� ����
    ���̺� �̸����� : RENAME
        RENAME old_name TO new_name
*/
CREATE TABLE student(
    hakbun NUMBER,
    name VARCHAR2(34) CONSTRAINT std_name_nn NOT NULL,
    CONSTRAINT std_hakbun_pk PRIMARY KEY(hakbun)
);
--�÷� �߰�
ALTER TABLE student ADD kor NUMBER DEFAULT 0;
ALTER TABLE student ADD eng NUMBER DEFAULT 0;
ALTER TABLE student ADD math NUMBER DEFAULT 0;
ALTER TABLE student ADD avg NUMBER NOT NULL;
--�÷� ����
ALTER TABLE student MODIFY avg NUMBER(5,2);
ALTER TABLE student MODIFY kor NUMBER(3);
ALTER TABLE student MODIFY eng NUMBER(3);
ALTER TABLE student MODIFY math NUMBER(3);
DESC student;
--�÷� ����
ALTER TABLE student DROP COLUMN avg;
--�÷��� ����
ALTER TABLE student RENAME COLUMN hakbun TO hak;
