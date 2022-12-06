/*
    집합함수 (집계함수) => COLUMN단위로 계산
    ----------------------------------
    COUNT() 갯수출력 => 저장된 ROW의 갯수
    -------
     COUNT(*)   => NULL포함
     COUNT(column) => NULL포함하지 않음
     
     MAX(): 최대값 => 자동 증가번호 MAX()+1
     MIN() : 최소값
     SUM() : 합
     AVG() : 평균
     -------------------- 집계함수, 분석함수 => 컬럼하고 같이 사용 가능 (RANK만)
     RANK() - 중복랭크 이후 숫자 건너뜀
     DENSE_RANK() - 중복랭크 이후에도 숫자 건너뛰지않음
     CUBE()
     ROLLUP()
     --------------- 단일행함수, 단일 컬럼과 같이 사용할 수 없다
     SELECT AVG(sal),ename ~~ 오류
            --------------
            집계함수는 
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
--급여 합, 평균
SELECT SUM(sal) "합", ROUND(AVG(sal),2) "평균"
FROM emp;

-- 급여 최대,최소
SELECT MAX(sal),MIN(sal) FROM emp;

--rank
SELECT ename,hiredate,sal,RANK() OVER(ORDER BY sal DESC) rank
FROM emp;

SELECT ename,hiredate,sal,DENSE_RANK() OVER(ORDER BY sal DESC) rank
FROM emp;

--GROUP BY
-- job, hiredate, deptno (공통된 부분이 있어야 같은 그룹에 묶일 수 있다)
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

-- 그룹별 통계 GROUP BY ==> 집계함수와 사용이 가능
-- 그룹별로 별도 통계가능
SELECT deptno,SUM(sal),ROUND(AVG(sal),2),COUNT(*)
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;

--입사연도별로 통계 -> 인원수, 급여합, 급여평균, 최대급여, 최소급여
SELECT TO_CHAR(hiredate,'YYYY'),COUNT(*) "인원수", SUM(sal) "급여합", ROUND(AVG(sal),2) "급여평균", MAX(sal) "최대급여", MIN(sal) "최소급여"
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY')
ORDER BY TO_CHAR(hiredate,'YYYY');