-- ����Ŭ 2���� -> SELECT (�����Լ�)
/*
    SQL : �����ͺ��̽����� ���Ǵ� ���
        => ���� : ��� ����ڿ��� ������ ����(������Ʈ)
        => �����ͺ��̽��� ����� �����͸� ���� => DBMS(�����ͺ��̽� �ý���) => �����Ҷ� ���Ǵ� ��� : SQL
        => �ʿ��� �����͸� ���� => ����(�÷�)
        ---------------------------------- ���̺� ���۽� (Ű������ ����, ��������)
        => readonly : �б����� => View, �ߺ��� �ּ�ȭ => ������, �Լ�
    emp/dept
    => ����
       1) DML => ������ ���� (CRUD)
          ����ڴ� �ʿ��� �����͸� �Է� ==> SQL������ ���� ����Ŭ�� ����
       = SELECT : ����ڿ��� �����͸� �˻����ִ� ����
                  ������, �󼼺���, �˻�, ��õ������ �б�...
                  ���̺� ����(JOIN)
       = INSERT : ����ڰ� ��û�� �����͸� ����Ŭ�� �߰�
                  ��) ȸ������, �۾���, ���, ���ϱ�, ���ſ�û
       = UPDATE : ����� ��û�� ���� �����͸� ����
                  ��) ȸ������, �Խñ� ����, ��ٱ��� ....
       = DELETE : ������ ����
                  ��) ȸ��Ż��, �������, �������
       2) DDL : ������� �����(���̺�), �Լ�, �������̺�, �ε���, �ڵ� ������ȣ
          = CREATE : ����
                    CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE INDEX, CREATE FUNCTION
                    ------------ ��������, ��������, Ű
                    ------------ �����ͺ��̽� �𵨸� -> ����ȭ
          = ALTER : ����
                    --- 1. ADD(Į���߰�), 2.MODIFY(�÷� ����), 3.DROP(�÷�����), 4. TRUNCATE(������ �߶󳻱�)
          = DROP : ���̺�, VIEW�� ���� ����
          = RENAME
       3) DCL : GRANT, REVOKE => ����� ���� (View, Index�� ����� ������ ����)
       4) TCL : �ϰ�ó�� (COMMIT,ROLLBACK)
       
       => SELECT : ������ �˻�
         1) ���� (��������)
            => SELECT���� => �÷����, ���̺� ��� ����� ����(�ζ��κ�)
                            ------ ��Į�� ��������
         2) ���� �˻� : ������
         3) ���ϴ� �����͸� ���� : �����Լ�
         4) �������� => ������, ������, ��¥�� ------- �ݵ�� ''
         5) ���ڿ� ���� : ||
         6) �÷����̳�, ���̺���� �� ��� : ��Ī��� as,  ""
         7) �ߺ����� ������ ���� : DISTINCT
         
         ���� => ORDER BY(�������̸� ������� ����) => ��ü ��ɾ� (INDEX)
         ORDER BY ���� => �������� ����
         
         ����)
           SELECT *
           FROM emp
           ORDER BY empno; ==> ASC����(�ø�����)
                    1     2    3
           SELECT empno,ename,job
           FROM emp
           ORDER BY 3;
           
        ���� ����
        -------- ������ϱ�
        SELECT empno,ename,job,deptno
        FROM emp
        ORDER BY deptno ASC,ename DESC


*/
-- emp���̺��� ����� ���� => �ø����� ����
/*SELECT *
FROM emp
ORDER BY empno;

SELECT *
FROM emp
ORDER BY empno DESC;

-- �޿��� ���� ������ ���
SELECT *
FROM emp
ORDER BY sal DESC;
--�Ի����� ���� ������ ���
SELECT *
FROM emp
ORDER BY hiredate;
--�̸��� ���ĺ� ����
SELECT *
FROM emp
ORDER BY ename;

-- �μ����� ��� => ����, GROUP BY
SELECT *
FROM emp
ORDER BY deptno;

--���� ����
SELECT ename,deptno
FROM emp
ORDER BY 2,1 DESC;

SELECT /* INDEX_ASC(emp,emp_empno_pk)*//*empno,ename,job
FROM emp;*/