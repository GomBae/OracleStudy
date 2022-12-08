/*
    SELECT CHR(65) FROM DUAL;
    숫자를 문자로 변환하는 함수 => CHR()
    
*/
--SELECT CHR(65) FROM DUAL;
-- HAVING : 그룹별 조건을 사용할 때 ==> 반드시 GROUP BY 가 있어야함
-- 직위별 그룹 => 인원수, 급여합, 급여평균, 전체 급여의 평균보다 높은 급여만 출력
SELECT ROUND(AVG(sal)) FROM emp;
SELECT job,COUNT(*),SUM(sal),AVG(sal)
FROM emp
GROUP BY job
HAVING AVG(sal)>(SELECT ROUND(AVG(sal)) FROM emp);
-- 서브쿼리 SQL문장을 여러개 묶어서 한번에 처리(부속질의)

--년도별 ===> 인원이 두명이상 => 인원수, 급여 최대, 급여 최소
SELECT TO_CHAR(hiredate,'YYYY'),COUNT(*),MAX(sal),MIN(sal)
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY')
HAVING COUNT(*)>1;
/*
    JOIN
    한개 이상의 테이블에서 출력에 필요한 데이터를 추출하는 기법
    = 종류
        1) INNER JOIN ==> 교집합 (같은 값을 가지고 있는 경우 처리) => 단점 : NULL일 경우에는 처리하지 못한다
           = EQUI_JOIN => 연산자 (=)
             = Oracle JOIN
               SELECT A.column,B.column
               FROM A,B
               WHERE A.column=B.column
               
             = ANSI JOIN
               SELECT A.column,B.column
               FROM A (INNER)JOIN B
                      ------- 생략가능
               ON A.column=B.column
               -----> column구분 => 테이블명.컬럼, 별칭.컬럼 => 컬럼명이 다른 경우에는 생략
                                => 컬럼명이 같은 경우에 생략하면 "애매한 정의"
           = NON_EQUI_JOIN => 연산자(=연산자 외의 다른 연산자 사용) => 포함(BETWEEN,비연산자,논리연산자)
             = Oracle JOIN
             = ANSI JOIN
        ---------------------------------------
           = NATURAL JOIN => 자연조인
           = JOIN~ USING
        --------------------------------------- 반드시 같은 컬럼명이 있어야 한다
        2) OUTER JOIN => INNER JOIN+@ ==> 교집합 + 차집합 => NULL일 경우에도 처리
           = LEFT OUTER JOIN => 
             = Oracle JOIN
             = ANSI JOIN
           = RIGHT OUTER JOIN
*/
--SELECT empno,ename,job,hiredate,sal,deptno
--FROM emp;
--SELECT * FROM dept;

-- EQUI_JOIN
--사번,이름,직위,입사일,급여,부서명,근무지, 부서번호
SELECT empno,ename,job,hiredate,sal,dname,loc,e.deptno
FROM emp e,dept d
WHERE e.deptno=d.deptno;
-- ANSI JOIN => 표준화(모든 데이터베이스 통일 => oracle,ms,my ...)
SELECT empno,ename,job,hiredate,sal,dname,loc,emp.deptno
FROM emp JOIN dept
ON emp.deptno=dept.deptno;

--NON_EQUI_JOIN
--NATURAL JOIN 
--테이블과 테이블 사이에 같은 컬럼명이 있는 경우만 처리 가능
SELECT empno,ename,job,hiredate,sal,dname,loc,deptno
FROM emp NATURAL JOIN dept;
--JOIN~USING
SELECT empno,ename,job,hiredate,sal,dname,loc,deptno
FROM emp JOIN dept USING(deptno);
------------------------------- SELF JOIN (같은 테이블) --구분을 위해 별칭 사용
SELECT e1.ename "본인", e2.ename "사수"
FROM emp e1,emp e2
WHERE e1.mgr=e2.empno;
--- 조건 수행 ===> 이름중에 A를 포함하고 있는 사원의 이름,직위,부서명,,근무지
-- 조인의 조건 => 양쪽 테이블에서 같은 값을 가지고 있는 데이터가 존재해야한다
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
  비등가 조인 (NON EQUI JOIN) => = 이외의 연산자 사용시 ==> 범위포함
*/
SELECT empno,ename,job,hiredate,sal,grade
FROM emp,salgrade
WHERE sal BETWEEN losal AND hisal;
/*
    emp,dept,salgrade => 3개 조인
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

-- emp -> empno,ename,job,hiredate,sal => dname,loc => SCOTT의 사원 정보
-- 사원의 정보, 부서정보, 두테이블에 필요한 데이터를 추출 =? JOIN
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
    => 2개 이상의 테이블에서 데이터값 읽기
       1) JOIN : 2개 이상의 테이블에서 데이터를 추출하는 방법
          여러개의 테이블을 연계해서 하나의 테이블을 만들어가는것
          동등조인 (EQUI_JOIN) ==> 연산자 사용시에 = 를 사용한다.
          WHERE 테이블명.컬럼=테이블명.컬럼
          ------------------------------- => 테이블과 테이블이 같은 값을 저장하고 있어야 가능
          ------------------------------- 단점 : null을 가지고 있으면 검색할 수 없다
          SELF JOIN => 같은 테이블이기 때문에 별칭으로 구분
          별칭 => NATURAL JOIN, JOIN~ USING 은 별칭을 쓰지않는다.
       2) SubQuery : 2개 이상의 SQL을 연결해서 처리
       
       INNER JOIN => INTERSECT(교집합)
       OUTER JOIN (inner join + NULL을 포함해서 데이터를 가지고 온다)
         = LEFT OUTER JOIN => INTERSECT(교집합)+ (A-B)
           형식)
              = Oracle JOIN
                SELECT A.column,B.column
                FROM A,B
                WHERE A.column=B.column(+)
            
              = ANSI JOIN
                SELECT A.column,B.column
                FROM A LEFT OUTER JOIN B
                ON A.column=B.column
               
         = RIGHT OUTER JOIN => INTERSECT(교집합)+ (B-A)
           형식)
              = Oracle JOIN
                SELECT A.column,B.column
                FROM A,B
                WHERE A.column(+)=B.column
            
              = ANSI JOIN
                SELECT A.column,B.column
                FROM A RIGHT OUTER JOIN B
                ON A.column=B.column
                
         = FULL OUTER JOIN => UNION
           형식)
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
-- 합
SELECT no FROM test1
UNION ALL
SELECT no FROM test2;

-- 중복없이 출력
SELECT no FROM test1
UNION
SELECT no FROM test2;

-- 교집합
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
