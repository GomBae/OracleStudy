/*

    뷰
    View : 테이블의 일종(가상테이블)
            = 한개 이상의 테이블을 통합해서 가상 테이블을 만든다.
            = SQL문장을 간결하게 만들 수 있다
            = 보안이 뛰어나다 
            = 읽기 전용
            = 반드시 참조하는 테이블을 가지고 있어야함
            = 테이블과 동일하게 사용이 가능
    1) 뷰의 종류
       1. 단순 뷰 : 테이블을 한개만 참조
       2. 복합 뷰 : 테이블 여러개를 참조 : 자바에서 SQL문장을 줄일 수 있다 (JOIN,SUBQUERY)
       3. 인라인뷰 : FROM (SELECT~ )
       *** 뷰를 생성후 INSERT,UPDATE,DELETE => VIEW에 저장되는게 아닌 테이블에 적용
       *** 뷰는 저장시에 데이터가 저장되는 것이 아니라 SQL문장을 저장하고 있다
       => 변경시에 테이블에 영향을 미친다(READ ONLY)
       => 옵션
            WITH CHECK OPTION => DML이 가능 (추가,수정)
            WITH READ ONLY => DML불가
            
    2) 생성하는 방법 ==> SQL문장을 저장후에 재사용
        = 생성
          CREATE VIEW view_name
          AS
          SELECT~~ 
        = 수정과 동시에 생성
          CREATE OR REPLACE view_name
          AS
          SELECT~~
    3) 삭제하는 방법
        DROP VIEW view_name;
*/
CREATE VIEW emp_view
AS
SELECT empno,ename,job,hiredate,sal,deptno FROM emp;
-- 권한이 없다면 system계정에서 권한을 부여한다
-- grant create view to hr
-- user_tables, user_views, user_constraints
SELECT * FROM user_views;
SELECT * FROM user_tables;
SELECT * FROM user_constraints;
SELECT * FROM user_tables WHERE table_name='EMP';
SELECT text FROM user_views WHERE view_name='EMP_VIEW';

SELECT * FROM emp_view;
DROP VIEW emp_view;
-- 테이블 원본 복사
CREATE TABLE myDept
AS
SELECT * FROM dept;

-- View 제작
CREATE VIEW dept_view
AS
SELECT * FROM myDept WITH READ ONLY;

--DML
INSERT INTO dept_view VALUES(60,'개발부','서울');

--추가 후에 뷰 확인
SELECT * FROM dept_view; -- dept_view에 저장되는 것이 아니라 참조한 테이블에 저장을 한다.
--테이블 확인
SELECT * FROM myDept;

DROP VIEW dept_view;

--수정이 가능하게 만든다
-- 단순뷰(테이블 한개 연결) => 사용빈도가 거의없음
CREATE OR REPLACE VIEW dept_view
AS
SELECT empno,ename,job,hiredate,sal FROM emp;

--뷰는 테이블과 동일시 된다 => 함수, 연산자 사용이 가능 => 많이 사용되는 SQL문장이 있는 경우 => VIEW 생성
--복합뷰 (테이블 여러개 연결해서 사용)
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
-- JOIN , SUBQUERY ==> VIEW를 만들어서 재사용하면 응용프로그램에서 편리하게 사용 가능
-- 
/*
    인라인뷰 => 뷰를 생성하는게 아닌 SELECT를 이용하는 방식 ==> 테이블에서 몇개를 잘라서 출력
                                ------------------- 페이지를 나눠서 출력
                                => 단점 : TOP-N 위에서부터 자를 수 밖에 없다
    형식)
        SELECT ~~
        FROM (SELECT~~) ==> 서브쿼리(테이블 대신 사용)
        ------------------------------------------
        1) rownum : 가상컬럼(오라클) ==> row마다 번호 (INSERT된 순서로 지정)
            => rownum의 순서를 변경시에는 인라인뷰를 이용해서 변경 => ORDER BY를 이용해서 변경
            => 페이징에서도 많이 이용
*/
-- 인라인뷰 (테이블 대신 SELECT)
/*
    SELECT * | column1,column2..
    FROM table_name | view_name | (SELECT~)
                                    -------- 설정된 컬럼명을 벗어나면 안된다
    [
        WHERE 조건
        GROUP BY
        HAVING
        ORDER BY
    ]
    SELECT empno,ename,job,hiredate,sal,comm
                                        ----- 없는 식별자
    FROM (SELECT empno,ename,job,hiredate,sal FROM emp) ==> 오류발생
                -----------------------------
                => JOIN / SUBQUERY/ SQL
*/
--오류 발생
SELECT empno,ename,job,hiredate,sal,comm
FROM (SELECT empno,ename,job,hiredate,sal FROM emp);

--정상 수행
SELECT empno,ename,job
FROM (SELECT empno,ename,job,hiredate,sal FROM emp);

-- JOIN / SUBQUERY
SELECT empno,ename,job,dname,loc
FROM (SELECT empno,ename,job,dname,loc FROM emp,dept WHERE emp.deptno=dept.deptno);

SELECT empno,ename,job,dname,loc
FROM (SELECT empno,ename,job,
        (SELECT dname FROM dept WHERE deptno=emp.deptno) dname,
        (SELECT loc FROM dept WHERE deptno=emp.deptno) loc FROM emp);
        
--필요한 갯수만큼 ROW를 자른다
SELECT empno,ename,sal,rownum
FROM (SELECT empno,ename,sal FROM emp)
WHERE rownum<=5;

SELECT empno,ename,job,hiredate,sal,rownum
FROM emp
WHERE rownum<=10;

SELECT empno,ename,job,hiredate,sal,rownum
FROM emp
WHERE rownum BETWEEN 5 AND 10;

--rownum 번호변경
SELECT empno,ename,job,hiredate,sal,rownum
FROM (SELECT empno,ename,job,hiredate,sal FROM emp ORDER BY sal DESC);

--단점 : TOP-N => 중간은 자를 수 없다

--급여를 많이 받는 사원의 이름 / 직위 / 급여 출력 ==> 상위5명
SELECT ename,job,sal,rownum --3 
FROM emp --1
WHERE rownum<=5 --2
ORDER BY sal DESC; --4

SELECT ename,job,sal,rownum--3
FROM (SELECT ename,job,sal FROM emp ORDER BY sal DESC)--1
WHERE rownum<=5;--2

-- 중간에서 자르기(페이징)
SELECT ename,job,sal,num
FROM (SELECT ename,job,sal,rownum as num
        FROM (SELECT ename,job,sal 
        FROM emp ORDER BY sal DESC))
WHERE num BETWEEN 6 AND 10;

SELECT COUNT(*) FROM food_location;
/*
    SQL문장이 길다, SQL문장이 복잡하다 (JOIN,SUBQUERY) , 보안 : 일반뷰
    상위부터 자르기, 페이지 나누기 = 인라인뷰
    같은 SQL문장을 자주 사용한다 
    ------------------------------------------ 뷰
*/