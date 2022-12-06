-- 오라클 2일차 -> SELECT (내장함수)
/*
    SQL : 데이터베이스에서 사용되는 언어
        => 목적 : 모든 사용자에게 데이터 공유(웹사이트)
        => 데이터베이스에 저장된 데이터를 제어 => DBMS(데이터베이스 시스템) => 제어할때 사용되는 언어 : SQL
        => 필요한 데이터만 수집 => 구분(컬럼)
        ---------------------------------- 테이블 제작시 (키에대한 종류, 제약조건)
        => readonly : 읽기전용 => View, 중복을 최소화 => 시퀀스, 함수
    emp/dept
    => 문법
       1) DML => 데이터 조작 (CRUD)
          사용자는 필요한 데이터만 입력 ==> SQL문장을 만들어서 오라클로 전송
       = SELECT : 사용자에게 데이터를 검색해주는 문장
                  목록출력, 상세보기, 검색, 추천데이터 읽기...
                  테이블 연결(JOIN)
       = INSERT : 사용자가 요청한 데이터를 오라클에 추가
                  예) 회원가입, 글쓰기, 댓글, 찜하기, 예매요청
       = UPDATE : 사용자 요청에 의해 데이터를 수정
                  예) 회원수정, 게시글 수정, 장바구니 ....
       = DELETE : 데이터 삭제
                  예) 회원탈퇴, 구매취소, 예약취소
       2) DDL : 저장공간 만들기(테이블), 함수, 가상테이블, 인덱스, 자동 증가번호
          = CREATE : 생성
                    CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE INDEX, CREATE FUNCTION
                    ------------ 제약조건, 데이터형, 키
                    ------------ 데이터베이스 모델링 -> 정규화
          = ALTER : 수정
                    --- 1. ADD(칼럼추가), 2.MODIFY(컬럼 수정), 3.DROP(컬럼삭제), 4. TRUNCATE(데이터 잘라내기)
          = DROP : 테이블, VIEW를 완전 삭제
          = RENAME
       3) DCL : GRANT, REVOKE => 사용자 계정 (View, Index를 사용할 권한이 없다)
       4) TCL : 일괄처리 (COMMIT,ROLLBACK)
       
       => SELECT : 데이터 검색
         1) 형식 (문법사항)
            => SELECT문장 => 컬럼대신, 테이블 대신 사용이 가능(인라인뷰)
                            ------ 스칼라 서브쿼리
         2) 조건 검색 : 연산자
         3) 원하는 데이터를 추출 : 내장함수
         4) 데이터형 => 숫자형, 문자형, 날짜형 ------- 반드시 ''
         5) 문자열 결합 : ||
         6) 컬럼명이나, 테이블명이 긴 경우 : 별칭사용 as,  ""
         7) 중복없는 데이터 추출 : DISTINCT
         
         정렬 => ORDER BY(가급적이면 사용하지 말라) => 대체 명령어 (INDEX)
         ORDER BY 순서 => 마지막에 등장
         
         사용법)
           SELECT *
           FROM emp
           ORDER BY empno; ==> ASC생략(올림차순)
                    1     2    3
           SELECT empno,ename,job
           FROM emp
           ORDER BY 3;
           
        이중 정렬
        -------- 묻고답하기
        SELECT empno,ename,job,deptno
        FROM emp
        ORDER BY deptno ASC,ename DESC


*/
-- emp테이블에서 사번을 정렬 => 올림차순 정렬
/*SELECT *
FROM emp
ORDER BY empno;

SELECT *
FROM emp
ORDER BY empno DESC;

-- 급여가 많은 순서로 출력
SELECT *
FROM emp
ORDER BY sal DESC;
--입사일이 빠른 순서로 출력
SELECT *
FROM emp
ORDER BY hiredate;
--이름을 알파벳 순서
SELECT *
FROM emp
ORDER BY ename;

-- 부서별로 출력 => 정렬, GROUP BY
SELECT *
FROM emp
ORDER BY deptno;

--이중 정렬
SELECT ename,deptno
FROM emp
ORDER BY 2,1 DESC;

SELECT /* INDEX_ASC(emp,emp_empno_pk)*//*empno,ename,job
FROM emp;*/