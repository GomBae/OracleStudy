/*
    SELECT CHR(65) FROM DUAL;
    ���ڸ� ���ڷ� ��ȯ�ϴ� �Լ� => CHR()
    
*/
--SELECT CHR(65) FROM DUAL;
-- HAVING : �׷캰 ������ ����� �� ==> �ݵ�� GROUP BY �� �־����
-- ������ �׷� => �ο���, �޿���, �޿����, ��ü �޿��� ��պ��� ���� �޿��� ���
SELECT ROUND(AVG(sal)) FROM emp;
SELECT job,COUNT(*),SUM(sal),AVG(sal)
FROM emp
GROUP BY job
HAVING AVG(sal)>(SELECT ROUND(AVG(sal)) FROM emp);
-- �������� SQL������ ������ ��� �ѹ��� ó��(�μ�����)

--�⵵�� ===> �ο��� �θ��̻� => �ο���, �޿� �ִ�, �޿� �ּ�
SELECT TO_CHAR(hiredate,'YYYY'),COUNT(*),MAX(sal),MIN(sal)
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY')
HAVING COUNT(*)>1;
/*
    JOIN
    �Ѱ� �̻��� ���̺��� ��¿� �ʿ��� �����͸� �����ϴ� ���
    = ����
        1) INNER JOIN ==> ������ (���� ���� ������ �ִ� ��� ó��) => ���� : NULL�� ��쿡�� ó������ ���Ѵ�
           = EQUI_JOIN => ������ (=)
             = Oracle JOIN
               SELECT A.column,B.column
               FROM A,B
               WHERE A.column=B.column
               
             = ANSI JOIN
               SELECT A.column,B.column
               FROM A (INNER)JOIN B
                      ------- ��������
               ON A.column=B.column
               -----> column���� => ���̺��.�÷�, ��Ī.�÷� => �÷����� �ٸ� ��쿡�� ����
                                => �÷����� ���� ��쿡 �����ϸ� "�ָ��� ����"
           = NON_EQUI_JOIN => ������(=������ ���� �ٸ� ������ ���) => ����(BETWEEN,�񿬻���,��������)
             = Oracle JOIN
             = ANSI JOIN
        ---------------------------------------
           = NATURAL JOIN => �ڿ�����
           = JOIN~ USING
        --------------------------------------- �ݵ�� ���� �÷����� �־�� �Ѵ�
        2) OUTER JOIN => INNER JOIN+@ ==> ������ + ������ => NULL�� ��쿡�� ó��
           = LEFT OUTER JOIN => 
             = Oracle JOIN
             = ANSI JOIN
           = RIGHT OUTER JOIN
*/
--SELECT empno,ename,job,hiredate,sal,deptno
--FROM emp;
--SELECT * FROM dept;

-- EQUI_JOIN
--���,�̸�,����,�Ի���,�޿�,�μ���,�ٹ���, �μ���ȣ
SELECT empno,ename,job,hiredate,sal,dname,loc,e.deptno
FROM emp e,dept d
WHERE e.deptno=d.deptno;
-- ANSI JOIN => ǥ��ȭ(��� �����ͺ��̽� ���� => oracle,ms,my ...)
SELECT empno,ename,job,hiredate,sal,dname,loc,emp.deptno
FROM emp JOIN dept
ON emp.deptno=dept.deptno;

--NON_EQUI_JOIN
--NATURAL JOIN 
--���̺�� ���̺� ���̿� ���� �÷����� �ִ� ��츸 ó�� ����
SELECT empno,ename,job,hiredate,sal,dname,loc,deptno
FROM emp NATURAL JOIN dept;
--JOIN~USING
SELECT empno,ename,job,hiredate,sal,dname,loc,deptno
FROM emp JOIN dept USING(deptno);
------------------------------- SELF JOIN (���� ���̺�) --������ ���� ��Ī ���
SELECT e1.ename "����", e2.ename "���"
FROM emp e1,emp e2
WHERE e1.mgr=e2.empno;
--- ���� ���� ===> �̸��߿� A�� �����ϰ� �ִ� ����� �̸�,����,�μ���,,�ٹ���
-- ������ ���� => ���� ���̺��� ���� ���� ������ �ִ� �����Ͱ� �����ؾ��Ѵ�
SELECT ename,job,emp.deptno,loc
FROM emp,dept
WHERE ename LIKE '%A%';

/*CREATE TABLE SALGRADE(
	GRADE NUMBER,
	LOSAL NUMBER,
	HISAL NUMBER
	);
INSERT INTO SALGRADE VALUES (1, 700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);
COMMIT;*/
SELECT * FROM salgrade;
/*
  �� ���� (NON EQUI JOIN) => = �̿��� ������ ���� ==> ��������
*/
SELECT empno,ename,job,hiredate,sal,grade
FROM emp,salgrade
WHERE sal BETWEEN losal AND hisal;
/*
    emp,dept,salgrade => 3�� ����
*/
-- Oracle JOIN
SELECT empno,ename,job,hiredate,sal,dname,loc,grade
FROM emp,dept,salgrade
WHERE emp.deptno=dept.deptno
AND sal BETWEEN losal AND hisal;

-- ANSI JOIN
SELECT empno,ename,job,hiredate,sal,dname,loc,grade
FROM emp JOIN dept
ON emp.deptno=dept.deptno
JOIN salgrade
ON sal BETWEEN losal AND hisal;

-- NATURAL JOIN
SELECT empno,ename,job,hiredate,dname,loc,grade
FROM emp NATURAL JOIN dept
JOIN salgrade
ON sal BETWEEN losal AND hisal;

--JOIN USING
SELECT empno,ename,job,hiredate,dname,loc,grade
FROM emp JOIN dept USING(deptno)
JOIN salgrade
ON sal BETWEEN losal AND hisal;

-- emp -> empno,ename,job,hiredate,sal => dname,loc => SCOTT�� ��� ����
-- ����� ����, �μ�����, �����̺� �ʿ��� �����͸� ���� =? JOIN
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND ename='SCOTT';

SELECT empno,ename,job,hiredate,sal,
    (SELECT dname FROM dept WHERE deptno=emp.deptno) dname,
    (SELECT loc FROM dept WHERE deptno=emp.deptno) loc
FROM emp
WHERE ename='SCOTT';
/*
    => 2�� �̻��� ���̺��� �����Ͱ� �б�
       1) JOIN : 2�� �̻��� ���̺��� �����͸� �����ϴ� ���
          �������� ���̺��� �����ؼ� �ϳ��� ���̺��� �����°�
          �������� (EQUI_JOIN) ==> ������ ���ÿ� = �� ����Ѵ�.
          WHERE ���̺��.�÷�=���̺��.�÷�
          ------------------------------- => ���̺�� ���̺��� ���� ���� �����ϰ� �־�� ����
          ------------------------------- ���� : null�� ������ ������ �˻��� �� ����
          SELF JOIN => ���� ���̺��̱� ������ ��Ī���� ����
          ��Ī => NATURAL JOIN, JOIN~ USING �� ��Ī�� �����ʴ´�.
       2) SubQuery : 2�� �̻��� SQL�� �����ؼ� ó��
       
       INNER JOIN => INTERSECT(������)
       OUTER JOIN (inner join + NULL�� �����ؼ� �����͸� ������ �´�)
         = LEFT OUTER JOIN => INTERSECT(������)+ (A-B)
           ����)
              = Oracle JOIN
                SELECT A.column,B.column
                FROM A,B
                WHERE A.column=B.column(+)
            
              = ANSI JOIN
                SELECT A.column,B.column
                FROM A LEFT OUTER JOIN B
                ON A.column=B.column
               
         = RIGHT OUTER JOIN => INTERSECT(������)+ (B-A)
           ����)
              = Oracle JOIN
                SELECT A.column,B.column
                FROM A,B
                WHERE A.column(+)=B.column
            
              = ANSI JOIN
                SELECT A.column,B.column
                FROM A RIGHT OUTER JOIN B
                ON A.column=B.column
                
         = FULL OUTER JOIN => UNION
           ����)
              = ANSI JOIN
                SELECT A.column,B.column
                FROM A FULL OUTER JOIN B
                ON A.column=B.column
*/
CREATE TABLE test1(no NUMBER);
CREATE TABLE test2(no NUMBER);
INSERT INTO test1 VALUES(1);
INSERT INTO test1 VALUES(2);
INSERT INTO test1 VALUES(3);
INSERT INTO test1 VALUES(4);
INSERT INTO test2 VALUES(3);
INSERT INTO test2 VALUES(4);
INSERT INTO test2 VALUES(5);
INSERT INTO test2 VALUES(6);
COMMIT;
-- ��
SELECT no FROM test1
UNION ALL
SELECT no FROM test2;

-- �ߺ����� ���
SELECT no FROM test1
UNION
SELECT no FROM test2;

-- ������
SELECT no FROM test1
INTERSECT
SELECT no FROM test2;

--LEFT OUTER JOIN
SELECT no FROM test1
MINUS
SELECT no FROM test2;

--RIGHT OUTER JOIN
SELECT no FROM test2
MINUS
SELECT no FROM test1;

--RIGHT OUTER JOIN
SELECT empno,ename,job,hiredate,sal,dname,loc,dept.deptno
FROM emp,dept
WHERE emp.deptno(+)=dept.deptno;

--LEFT OUTER JOIN
SELECT empno,ename,job,hiredate,sal,dname,loc,dept.deptno
FROM emp,dept
WHERE emp.deptno=dept.deptno(+);

--right(ANSI)
SELECT empno,ename,job,hiredate,sal,dname,loc,dept.deptno
FROM emp RIGHT OUTER JOIN dept
ON emp.deptno=dept.deptno;

--left(ANSI)
SELECT empno,ename,job,hiredate,sal,dname,loc,dept.deptno
FROM emp LEFT OUTER JOIN dept
ON emp.deptno=dept.deptno;
