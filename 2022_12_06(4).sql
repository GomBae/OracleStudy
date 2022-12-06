/*
    �����Լ� (�����Լ�) => COLUMN������ ���
    ----------------------------------
    COUNT() ������� => ����� ROW�� ����
    -------
     COUNT(*)   => NULL����
     COUNT(column) => NULL�������� ����
     
     MAX(): �ִ밪 => �ڵ� ������ȣ MAX()+1
     MIN() : �ּҰ�
     SUM() : ��
     AVG() : ���
     -------------------- �����Լ�, �м��Լ� => �÷��ϰ� ���� ��� ���� (RANK��)
     RANK() - �ߺ���ũ ���� ���� �ǳʶ�
     DENSE_RANK() - �ߺ���ũ ���Ŀ��� ���� �ǳʶ�������
     CUBE()
     ROLLUP()
     --------------- �������Լ�, ���� �÷��� ���� ����� �� ����
     SELECT AVG(sal),ename ~~ ����
            --------------
            �����Լ��� 
*/
SELECT COUNT(comm),COUNT(mgr),COUNT(*) FROM emp;
/*
CREATE TABLE my2(
    no NUMBER PRIMARY KEY,
    name VARCHAR2(20)
);
INSERT INTO my2 VALUES(1,'add');
INSERT INTO my2 VALUES((SELECT MAX(no)+1 FROM my2),'bbb');
SELECT * FROM my2;
*/
--�޿� ��, ���
SELECT SUM(sal) "��", ROUND(AVG(sal),2) "���"
FROM emp;

-- �޿� �ִ�,�ּ�
SELECT MAX(sal),MIN(sal) FROM emp;

--rank
SELECT ename,hiredate,sal,RANK() OVER(ORDER BY sal DESC) rank
FROM emp;

SELECT ename,hiredate,sal,DENSE_RANK() OVER(ORDER BY sal DESC) rank
FROM emp;

--GROUP BY
-- job, hiredate, deptno (����� �κ��� �־�� ���� �׷쿡 ���� �� �ִ�)
SELECT * FROM emp
ORDER BY deptno ASC;

SELECT SUM(sal),ROUND(AVG(sal),2),COUNT(*)
FROM emp
WHERE deptno=10;

SELECT SUM(sal),ROUND(AVG(sal),2),COUNT(*)
FROM emp
WHERE deptno=20;

SELECT SUM(sal),ROUND(AVG(sal),2),COUNT(*)
FROM emp
WHERE deptno=30;

-- �׷캰 ��� GROUP BY ==> �����Լ��� ����� ����
-- �׷캰�� ���� ��谡��
SELECT deptno,SUM(sal),ROUND(AVG(sal),2),COUNT(*)
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;

--�Ի翬������ ��� -> �ο���, �޿���, �޿����, �ִ�޿�, �ּұ޿�
SELECT TO_CHAR(hiredate,'YYYY'),COUNT(*) "�ο���", SUM(sal) "�޿���", ROUND(AVG(sal),2) "�޿����", MAX(sal) "�ִ�޿�", MIN(sal) "�ּұ޿�"
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY')
ORDER BY TO_CHAR(hiredate,'YYYY');