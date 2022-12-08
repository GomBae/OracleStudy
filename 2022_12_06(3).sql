--숫자 관련
/*
    MOD() : 나머지 %
    MOD(10,2) ==> 0 ==> 10%2
    CEIL() : 올림함수 (총페이지)
    CEIL(10.2) ==> 11
    ROUND() : 반올림
    ROUND(10.5678,2)
    => 10.57
    TRUNC() : 버림
    TRUNC(10.5678,2) ==> 10.56
*/
SELECT MOD(10,3) FROM DUAL;
SELECT empno,ename,job
FROM emp
WHERE MOD(empno,2)=0
ORDER BY 1;

SELECT CEIL(10.1) FROM DUAL;
SELECT CEIL(10.0) FROM DUAL;
--총페이지
--SELECT CEIL(COUNT(*)/10.0) FROM emp;
--14/10.0 ==> 1.4 ==> 2
--ROUND
SELECT ROUND(10.23456,3) FROM DUAL;
--TRUNC
SELECT TRUNC(10.23456,3) FROM DUAL;

--날짜함수
/*
   SYSDATE : 시스템의 날짜와 시간을 읽을 때 사용
   MONTHS_BETWEEN : 기간에 해당되는 개월수
   형식) MONTH_BETWEEN(현재,과거)
                     최근  이전
   22/02/01 ~ 22/12/01 ==> 10
   ADD_MONTH : 월추가
   ADD_MONTH(1) 1개월후 날짜
   NEXT_DAY
   LAST_DAY : 마지막 날짜를 읽어온다 SYSDATE => 12/31
                                '22/10/10' => 10/31
   ROUND
   TRUNC
*/
/*CREATE TABLE my(
    name VARCHAR2(20),
    regdate DATE
);
INSERT INTO my VALUES('hong',SYSDATE);
SELECT * FROM my;*/
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE-1 as 어제, SYSDATE as 오늘, SYSDATE+1 as 내일 FROM DUAL;
SELECT ename,hiredate,TRUNC(TRUNC(MONTHS_BETWEEN(SYSDATE,hiredate))/12) "근무개월수"
FROM emp;

SELECT SYSDATE,ADD_MONTHS(SYSDATE,3) FROM DUAL;
SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY('22/02/01') FROM DUAL;
SELECT NEXT_DAY(SYSDATE,'수') FROM DUAL;
/*
    변환
        TO_CHAR : 문자열 변환
        TO_DATE : 날짜형 변경
        TO_NUMBER : 숫자형 변경 TO_NUMBER('10')+10 => 20
*/
SELECT TO_NUMBER('100')+TO_NUMBER('200') FROM DUAL;
SELECT '100'+'200' FROM DUAL;
--주문일
SELECT TO_DATE(SYSDATE,'YYYY-MM-DD')+5 After,
       TO_DATE(SYSDATE,'YYYY-MM-DD')-5 Before
FROM DUAL;

--TO_CHAR
/*
    날짜, 숫자를 문자로 변경 => valueOf()
    날짜 패턴
    d => 1~31
    dd => 01~31
    yy(rr)
    yyyy(rrrr)
    m => month
    mm
    dy => 요일
    hh/hh24 
    mi => minute
    s
    ss => second
    숫자 패턴
    $999,999
    L999,999
*/
SELECT ename,TO_CHAR(sal,'$999,999') FROM emp;
SELECT TO_CHAR(SYSDATE,'RRRR-MM-DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'DY') FROM DUAL;
-- emp사원 입사요일 출력
SELECT ename,TO_CHAR(hiredate,'DY')||'요일' FROM emp;
-- 목요일에 입사한 사원의 모든 정보 출력
SELECT *
FROM emp
WHERE TO_CHAR(hiredate,'DY')='목';

/*
    기타 함수
     NVL() : NULL을 대체하는 함수
     NVL(데이터,값)
     => NULL일 경우에는 연산처리가 안된다
     DECODE() : switch 문장
     CASE : 다중조건문
*/
SELECT ename,sal,comm,sal+NVL(comm,0) FROM emp;
SELECT zipcode,sido||' '||gugun||' ' ||dong||' '||NVL(bunji,' ') FROM zipcode;
SELECT ename,job,hiredate,deptno FROM emp;
SELECT ename,job,hiredate,DECODE(deptno,10,'개발부',
                                        20,'총무부',
                                        30,'기획부') "dname"
FROM emp;
SELECT ename,job,hiredate,CASE
                            WHEN deptno=10 THEN '개발부'
                            WHEN deptno=20 THEN '기획부'
                            WHEN deptno=30 THEN '자재부'
                            END "dname"
FROM emp;