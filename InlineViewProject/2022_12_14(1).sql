/*

    ��
    View : ���̺��� ����(�������̺�)
            = �Ѱ� �̻��� ���̺��� �����ؼ� ���� ���̺��� �����.
            = SQL������ �����ϰ� ���� �� �ִ�
            = ������ �پ�� 
            = �б� ����
            = �ݵ�� �����ϴ� ���̺��� ������ �־����
            = ���̺�� �����ϰ� ����� ����
    1) ���� ����
       1. �ܼ� �� : ���̺��� �Ѱ��� ����
       2. ���� �� : ���̺� �������� ���� : �ڹٿ��� SQL������ ���� �� �ִ� (JOIN,SUBQUERY)
       3. �ζ��κ� : FROM (SELECT~ )
       *** �並 ������ INSERT,UPDATE,DELETE => VIEW�� ����Ǵ°� �ƴ� ���̺� ����
       *** ��� ����ÿ� �����Ͱ� ����Ǵ� ���� �ƴ϶� SQL������ �����ϰ� �ִ�
       => ����ÿ� ���̺� ������ ��ģ��(READ ONLY)
       => �ɼ�
            WITH CHECK OPTION => DML�� ���� (�߰�,����)
            WITH READ ONLY => DML�Ұ�
            
    2) �����ϴ� ��� ==> SQL������ �����Ŀ� ����
        = ����
          CREATE VIEW view_name
          AS
          SELECT~~ 
        = ������ ���ÿ� ����
          CREATE OR REPLACE view_name
          AS
          SELECT~~
    3) �����ϴ� ���
        DROP VIEW view_name;
*/
CREATE VIEW emp_view
AS
SELECT empno,ename,job,hiredate,sal,deptno FROM emp;
-- ������ ���ٸ� system�������� ������ �ο��Ѵ�
-- grant create view to hr
-- user_tables, user_views, user_constraints
SELECT * FROM user_views;
SELECT * FROM user_tables;
SELECT * FROM user_constraints;
SELECT * FROM user_tables WHERE table_name='EMP';
SELECT text FROM user_views WHERE view_name='EMP_VIEW';

SELECT * FROM emp_view;
DROP VIEW emp_view;
-- ���̺� ���� ����
CREATE TABLE myDept
AS
SELECT * FROM dept;

-- View ����
CREATE VIEW dept_view
AS
SELECT * FROM myDept WITH READ ONLY;

--DML
INSERT INTO dept_view VALUES(60,'���ߺ�','����');

--�߰� �Ŀ� �� Ȯ��
SELECT * FROM dept_view; -- dept_view�� ����Ǵ� ���� �ƴ϶� ������ ���̺� ������ �Ѵ�.
--���̺� Ȯ��
SELECT * FROM myDept;

DROP VIEW dept_view;

--������ �����ϰ� �����
-- �ܼ���(���̺� �Ѱ� ����) => ���󵵰� ���Ǿ���
CREATE OR REPLACE VIEW dept_view
AS
SELECT empno,ename,job,hiredate,sal FROM emp;

--��� ���̺�� ���Ͻ� �ȴ� => �Լ�, ������ ����� ���� => ���� ���Ǵ� SQL������ �ִ� ��� => VIEW ����
--���պ� (���̺� ������ �����ؼ� ���)
CREATE OR REPLACE VIEW empDeptGrade_view
AS
SELECT e1.empno,e1.ename,e2.ename "manager",e1.job,e1.hiredate,e1.sal,e1.comm,dname,loc,grade
FROM emp e1,dept,salgrade,emp e2
WHERE e1.deptno=dept.deptno
AND e1.sal BETWEEN losal AND hisal
AND e1.mgr=e2.empno;

SELECT * FROM empDeptGrade_1;

CREATE OR REPLACE VIEW empDeptGrade_1
AS
SELECT e1.empno,e1.ename,e2.ename "manager",e1.job,e1.hiredate,e1.sal,e1.comm,dname,loc,grade
FROM emp e1 JOIN dept
ON e1.deptno=dept.deptno
JOIN salgrade
ON e1.sal BETWEEN losal AND hisal
LEFT OUTER JOIN emp e2
ON e1.mgr=e2.empno;

CREATE OR REPLACE VIEW empDeptGrade_2
AS
SELECT empno,ename,hiredate,sal,comm,
        (SELECT ename FROM emp e2 WHERE e1.mgr=e2.empno) manager,
        (SELECT dname FROM dept WHERE deptno=e1.deptno) dname,
        (SELECT loc FROM dept WHERE deptno=e1.deptno) loc,
        (SELECT grade FROM salgrade WHERE e1.sal BETWEEN losal AND hisal) grade 
FROM emp e1;

SELECT * FROM empDeptGrade_2;
DESC empDeptGrade_2;
-- JOIN , SUBQUERY ==> VIEW�� ���� �����ϸ� �������α׷����� ���ϰ� ��� ����
-- 
/*
    �ζ��κ� => �並 �����ϴ°� �ƴ� SELECT�� �̿��ϴ� ��� ==> ���̺��� ��� �߶� ���
                                ------------------- �������� ������ ���
                                => ���� : TOP-N ���������� �ڸ� �� �ۿ� ����
    ����)
        SELECT ~~
        FROM (SELECT~~) ==> ��������(���̺� ��� ���)
        ------------------------------------------
        1) rownum : �����÷�(����Ŭ) ==> row���� ��ȣ (INSERT�� ������ ����)
            => rownum�� ������ ����ÿ��� �ζ��κ並 �̿��ؼ� ���� => ORDER BY�� �̿��ؼ� ����
            => ����¡������ ���� �̿�
*/
-- �ζ��κ� (���̺� ��� SELECT)
/*
    SELECT * | column1,column2..
    FROM table_name | view_name | (SELECT~)
                                    -------- ������ �÷����� ����� �ȵȴ�
    [
        WHERE ����
        GROUP BY
        HAVING
        ORDER BY
    ]
    SELECT empno,ename,job,hiredate,sal,comm
                                        ----- ���� �ĺ���
    FROM (SELECT empno,ename,job,hiredate,sal FROM emp) ==> �����߻�
                -----------------------------
                => JOIN / SUBQUERY/ SQL
*/
--���� �߻�
SELECT empno,ename,job,hiredate,sal,comm
FROM (SELECT empno,ename,job,hiredate,sal FROM emp);

--���� ����
SELECT empno,ename,job
FROM (SELECT empno,ename,job,hiredate,sal FROM emp);

-- JOIN / SUBQUERY
SELECT empno,ename,job,dname,loc
FROM (SELECT empno,ename,job,dname,loc FROM emp,dept WHERE emp.deptno=dept.deptno);

SELECT empno,ename,job,dname,loc
FROM (SELECT empno,ename,job,
        (SELECT dname FROM dept WHERE deptno=emp.deptno) dname,
        (SELECT loc FROM dept WHERE deptno=emp.deptno) loc FROM emp);
        
--�ʿ��� ������ŭ ROW�� �ڸ���
SELECT empno,ename,sal,rownum
FROM (SELECT empno,ename,sal FROM emp)
WHERE rownum<=5;

SELECT empno,ename,job,hiredate,sal,rownum
FROM emp
WHERE rownum<=10;

SELECT empno,ename,job,hiredate,sal,rownum
FROM emp
WHERE rownum BETWEEN 5 AND 10;

--rownum ��ȣ����
SELECT empno,ename,job,hiredate,sal,rownum
FROM (SELECT empno,ename,job,hiredate,sal FROM emp ORDER BY sal DESC);

--���� : TOP-N => �߰��� �ڸ� �� ����

--�޿��� ���� �޴� ����� �̸� / ���� / �޿� ��� ==> ����5��
SELECT ename,job,sal,rownum --3 
FROM emp --1
WHERE rownum<=5 --2
ORDER BY sal DESC; --4

SELECT ename,job,sal,rownum--3
FROM (SELECT ename,job,sal FROM emp ORDER BY sal DESC)--1
WHERE rownum<=5;--2

-- �߰����� �ڸ���(����¡)
SELECT ename,job,sal,num
FROM (SELECT ename,job,sal,rownum as num
        FROM (SELECT ename,job,sal 
        FROM emp ORDER BY sal DESC))
WHERE num BETWEEN 6 AND 10;

SELECT COUNT(*) FROM food_location;
/*
    SQL������ ���, SQL������ �����ϴ� (JOIN,SUBQUERY) , ���� : �Ϲݺ�
    �������� �ڸ���, ������ ������ = �ζ��κ�
    ���� SQL������ ���� ����Ѵ� 
    ------------------------------------------ ��
*/