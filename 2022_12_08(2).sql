/*
1. �� �μ����� �ִ� �޿��� ���ϼ���.
SELECT deptno,MAX(sal)
FROM emp
GROUP BY deptno;
2. �� ����(job)���� �ִ� �޿��� ���ϼ���. 
SELECT job,MAX(sal)
FROM emp
GROUP BY job;
3. �� �μ����� ��� �޿��� ���ϼ���.
SELECT deptno,ROUND(AVG(sal))
FROM emp
GROUP BY deptno;
4. �� ����(job)���� �ο����� ���ϼ���.
SELECT job,COUNT(*)
FROM emp
GROUP BY job;
5. �� �μ��� ���ʽ�(comm)�� �޴�  �ο��� ��� . 
SELECT deptno,COUNT(*)
FROM emp
WHERE comm IS NOT NULL AND comm<>0
GROUP BY deptno;
6. �� �⵵���� �Ի��� �ο����� ���ϼ���.
SELECT SUBSTR(hiredate,1,2),COUNT(*)
FROM emp
GROUP BY SUBSTR(hiredate,1,2);
7.  �μź� ��ձ޿��� ���ϰ� �� ��� ��ձ޿��� 2000 �̻��� �μ��� ����ϼ���.
SELECT deptno,ROUND(AVG(sal))
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal))>=2000;

WHERE ==> �׷쿡�� ������ �ɶ��� HAVING�� ����Ѵ�.

*/

/*
1. ��� �̸��� SCOTT�� ����� ���(empno), �̸�(ename), �μ���(dname)�� ����ϼ���.
SELECT DISTINCT empno,ename,dname
FROM emp,dept
WHERE emp.deptno=dept.deptno
WHERE ename='SCOTT';
2. ����̸��� �޿�(sal)�� �޿����(grade)�� ����ϼ���.
SELECT ename,sal,grade
FROM emp,salgrade
WHERE sal BETWEEN losal AND hisal;
3. �� 2���������� �μ����� �߰����� ����ϼ���.
SELECT ename,sal,grade,dname
FROM emp,salgrade,dept
WHERE emp.deptno=dept.deptno
AND sal BETWEEN losal AND hisal;
4. ����̸��� �Ŵ����� �̸��� �Ʒ��� ���� �������� ����ϼ���.
     "XXX"�� �Ŵ����� "XXX" �Դϴ�. 
SELECT e1.ename||'�� �Ŵ����� '||e2.ename||'�Դϴ�'
FROM emp e1,emp e2
WHERE e1.empno=e2.mgr;
5. �μ���ȣ�� 30���� ������� �̸�, ����(job), �μ���ȣ(deptno), �μ���ġ(loc)�� ����ϼ���.
SELECT ename,job,emp.deptno,loc
FROM emp,dept
WHERE emp.deptno=30 AND dept.deptno=30;
6. ���ʽ�(comm)�� ��������� �̸�, ���ʽ�, �μ���, �μ���ġ�� ����ϼ���.
SELECT ename,comm,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND comm IS NOT NULL AND comm<>0;
7. DALLAS���� �ٹ��ϴ� ������� �̸�, ����, �μ���ȣ, �μ����� ����ϼ���.
SELECT ename,job,dept.deptno,dname
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND loc='DALLAS';
8. �̸��� 'A'�� ���� ������� �̸��� �μ����� ����ϼ���.
SELECT ename,dname
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND ename LIKE '%A%';
*/
/*
1. SCOTT�� �޿��� �����ϰų� �� ���� �޴� ����� �̸��� �޿��� ����ϼ���.

2. ����(job)�� 'CLERK'�� ����� �μ��� �μ���ȣ�� �μ����� ����ϼ���.

3. �̸��� T�� �����ϰ� �ִ� ������ �����μ����� �ٹ��ϴ� ����� ����� �̸��� ����ϼ���

4. �μ���ġ(loc)�� DALLAS�� ��� ����� �̸�, �μ���ȣ�� ����ϼ���

5. SALES �μ��� ������� �̸��� �޿��� ����ϼ���

6. �ڽ��� �޿��� ��� �޿����� ���� �̸��� S�� ���� �����
    ������ �μ����� �ٹ��ϴ� ��� ����� �̸�, �޿��� ����ϼ���
7. ��� �޿����� �� ���� �޿��� �޴� ����� �̸�, ���, �޿��� �˻��ϵ� �޿��� ���� �����γ����ϼ���.

*/
