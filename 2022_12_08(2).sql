/*
1. 각 부서별로 최대 급여를 구하세요.
SELECT deptno,MAX(sal)
FROM emp
GROUP BY deptno;
2. 각 직급(job)별로 최대 급여를 구하세요. 
SELECT job,MAX(sal)
FROM emp
GROUP BY job;
3. 각 부서별로 평균 급여를 구하세요.
SELECT deptno,ROUND(AVG(sal))
FROM emp
GROUP BY deptno;
4. 각 직급(job)별의 인원수를 구하세요.
SELECT job,COUNT(*)
FROM emp
GROUP BY job;
5. 각 부서별 보너스(comm)을 받는  인원수 출력 . 
SELECT deptno,COUNT(*)
FROM emp
WHERE comm IS NOT NULL AND comm<>0
GROUP BY deptno;
6. 각 년도별로 입사한 인원수를 구하세요.
SELECT SUBSTR(hiredate,1,2),COUNT(*)
FROM emp
GROUP BY SUBSTR(hiredate,1,2);
7.  부셔별 평균급여를 구하고 그 결과 평균급여가 2000 이상인 부서만 출력하세요.
SELECT deptno,ROUND(AVG(sal))
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal))>=2000;

WHERE ==> 그룹에서 조건을 걸때는 HAVING을 사용한다.

*/

/*
1. 사원 이름이 SCOTT인 사원의 사번(empno), 이름(ename), 부서명(dname)를 출력하세요.
SELECT DISTINCT empno,ename,dname
FROM emp,dept
WHERE emp.deptno=dept.deptno
WHERE ename='SCOTT';
2. 사원이름과 급여(sal)와 급여등급(grade)을 출력하세요.
SELECT ename,sal,grade
FROM emp,salgrade
WHERE sal BETWEEN losal AND hisal;
3. 위 2번문제에서 부서명을 추가시켜 출력하세요.
SELECT ename,sal,grade,dname
FROM emp,salgrade,dept
WHERE emp.deptno=dept.deptno
AND sal BETWEEN losal AND hisal;
4. 사원이름과 매니저의 이름을 아래와 같은 형식으로 출력하세요.
     "XXX"의 매니져는 "XXX" 입니다. 
SELECT e1.ename||'의 매니저는 '||e2.ename||'입니다'
FROM emp e1,emp e2
WHERE e1.empno=e2.mgr;
5. 부서번호가 30번인 사원들의 이름, 직급(job), 부서번호(deptno), 부서위치(loc)를 출력하세요.
SELECT ename,job,emp.deptno,loc
FROM emp,dept
WHERE emp.deptno=30 AND dept.deptno=30;
6. 보너스(comm)을 받은사원의 이름, 보너스, 부서명, 부서위치를 출력하세요.
SELECT ename,comm,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND comm IS NOT NULL AND comm<>0;
7. DALLAS에서 근무하는 사원들의 이름, 직급, 부서번호, 부서명을 출력하세요.
SELECT ename,job,dept.deptno,dname
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND loc='DALLAS';
8. 이름에 'A'가 들어가는 사원들의 이름과 부서명을 출력하세요.
SELECT ename,dname
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND ename LIKE '%A%';
*/
/*
1. SCOTT의 급여와 동일하거나 더 많이 받는 사원의 이름과 급여를 출력하세요.

2. 직급(job)이 'CLERK'인 사람의 부서의 부서번호와 부서명을 출력하세요.

3. 이름에 T를 포함하고 있는 사원들과 같은부서에서 근무하는 사원의 사번과 이름을 출력하세요

4. 부서위치(loc)가 DALLAS인 모든 사원의 이름, 부서번호를 출력하세요

5. SALES 부서의 모든사원의 이름과 급여를 출력하세요

6. 자신의 급여가 평균 급여보다 많고 이름에 S가 들어가는 사원과
    동일한 부서에서 근무하는 모든 사원의 이름, 급여를 출력하세요
7. 평균 급여보다 더 많은 급여를 받는 사원의 이름, 사번, 급여를 검색하되 급여가 많은 순서로나열하세요.

*/
