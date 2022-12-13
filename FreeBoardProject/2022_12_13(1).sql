/*
    DML
        INSERT : ������ �߰�
                 �Խ��� �۾���, ȸ������, ���ϱ�, �����ϱ�, ��۾���
                 ����)
                    = ��ü ������ �߰�
                        INSERT INTO table_name VALUES(��,��,��...) => ���ڿ�,��¥ ==> ''
                            => ������ ��� �÷��� ���� �߰�
                    = �ʿ��� �����͸� �߰� (����Ʈ ������ �� ���)
                        INSERT INTO table_name(�÷���,�÷���,�÷���...) VALUES(��,��....)
                        ** �߰��� => �ݵ�� COMMIT�� �������
        UPDATE : ������ ����
                 �Խ��� ����, ��� ����, ȸ�� ����, ��ٱ��� ����, ���� ����
                 ����)
                    UPDATE table_name SET
                    �÷���=��, �÷���='����'
        DELETE : ������ ����
                 �Խù� ����, ��� ����, ȸ��Ż��, ������� ....
                 
*/
CREATE TABLE emp_update
AS
SELECT * FROM emp;
SELECT * FROM emp_update;

--���� ����
UPDATE emp_update SET
job='CLERK';
ROLLBACK;

--INSERT
INSERT INTO emp_update VALUES ((SELECT MAX(empno)+1 FROM emp_update),'ȫ�浿','CLERK',7788,SYSDATE,2000,100,40);
INSERT INTO emp_update VALUES ((SELECT MAX(empno)+1 FROM emp_update),'��û��','MANAGER',7788,'21/10/10',3000,500,40);
INSERT INTO emp_update VALUES ((SELECT MAX(empno)+1 FROM emp_update),'�ڹ���','CLERK',7788,SYSDATE,2000,100,40);
COMMIT;

--�ڹ��� update
UPDATE emp_update SET
job='SALESMAN',mgr=7698,hiredate='20/01/05',sal=3500,comm=700,deptno=30
WHERE empno='7937';
SELECT * FROM emp_update;
COMMIT;

INSERT INTO emp_update VALUES ((SELECT MAX(empno)+1 FROM emp_update),'ȫ�浿1','CLERK',7788,SYSDATE,2000,100,40);
INSERT INTO emp_update VALUES ((SELECT MAX(empno)+1 FROM emp_update),'ȫ�浿5','CLERK',7788,SYSDATE,2000,100,40);
INSERT INTO emp_update VALUES ((SELECT MAX(empno)+1 FROM emp_update),'ȫ�浿2','CLERK',7788,SYSDATE,2000,100,40);
INSERT INTO emp_update VALUES ((SELECT MAX(empno)+1 FROM emp_update),'ȫ�浿3','CLERK',7788,SYSDATE,2000,100,40);
INSERT INTO emp_update VALUES ((SELECT MAX(empno)+1 FROM emp_update),'ȫ�浿4','CLERK',7788,SYSDATE,2000,100,40);

UPDATE emp_update SET
deptno=60
WHERE deptno=(SELECT deptno FROM emp_update WHERE empno=7938);

--��ü ����
DELETE FROM emp_update;
SELECT * FROM emp_update;
ROLLBACK;

DELETE FROM emp_update;
DROP TABLE emp_update;
/*
    COMMIT/ROLLBACK => INSERT, UPDATEm DELETE
    ALTER, CREATE, RENAME, DROP, TRUNCATE ==> ROLLBACK�� �������ʴ´�
*/