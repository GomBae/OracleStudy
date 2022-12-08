--2022-12-06 오라클 내장함수
--집합함수 , GROUP BY, HAVING
-- JOIN, SUBQUERY
-- DDL => DML
-- VIEW, SEQUENCE, INDEX
-- PL/SQL
-- 데이터베이스 모델링
/*
    내장함수, 사용자 정의 함수(PL/SQL) => 업체마다 다르다
    ------ 오라클에서 지원하는 함수
      |
    단일행함수 집합행함수
    ------------------ 사용처 예) COUNT -> 로그인
    단일행 함수
    ---------
      1) 오라클에서 지원하는 데이터형
      --------------------------
      문자형 / 숫자형 / 날짜형 / 기타형
      
      2) 데이터형에 맞게 함수 제작
         1) 문자함수 => String
            => 변환함수
               1. UPPER() => 대문자변환
               2. LOWER() => 소문자변환
               3. INITCAP() =>이니셜 변경
                  INITCAP("ABC") => Abc
                  
            => 제어함수
               1. SUBSTR()
               2. INSTR() =>indexOf()
               3. REPLACE()
               4. TRIM() ==> LTRIM(), RTRIM()
               5. PAD() ==> LPAD(), RPAD()
                                    ------- 아이디찾기 
                                           admin => ad***
               6. LENGTH()
            
            => 정규식
         2) 숫자함수 => Math
         3) 날짜함수 => Date,Calendar
         4) 변환함수 => Format
         5) 기타함수 => 
*/
--대문자, 소문자, 이니셜 출력
SELECT ename "저장된 데이터", UPPER (ename) "대문자", LOWER (ename) "소문자", INITCAP(ename) "이니셜"
FROM emp;

--SELECT INITCAP('hello java!!') FROM DUAL;
--LENGTH => 문자갯수, LENGTHB => 문자의 BYTE수
SELECT ename,LENGTH(ename),LENGTHB(ename) FROM emp;
--한글은 글자당 3byte(오라클에서만)
SELECT ename
FROM emp
WHERE LENGTH(ename) BETWEEN 4 AND 5;

--REPLACE : 문자, 문자열 변경
-- ||, &
SELECT REPLACE('Hello Java&Spring','&','^') FROM DUAL;
SELECT REPLACE('Hello Java','a','b') FROM DUAL;
SELECT REPLACE('Hello Java','Java','Spring') FROM DUAL;
-- SUBSTR : 문자열을 자르는 경우에 사용 (substring())
--- 1번부터 시작
/*
    HELLO JAVA
    0123456789 ==> 자바
    HELLO JAVA
    12345678910 ==> 오라클
*/
SELECT SUBSTR('Hello Java',1,1) FROM DUAL;
--81년에 입사한 사원 목록
SELECT ename,hiredate
FROM emp
WHERE SUBSTR(hiredate,1,2)=81;

--12월에 입사한 사원 이름,입사일
SELECT ename,hiredate
FROM emp
WHERE SUBSTR(hiredate,4,2)=12;

SELECT ename,SUBSTR(hiredate,7,2)
FROM emp;

SELECT ename,SUBSTR(hiredate,-2,2)
FROM emp;
/*
    81 /12 /01
    123 45 678
           -3 -2 -1
*/
/*SELECT SUBSTR(hiredate,1,2), SUM(sal),ROUND(AVG(sal),1)
FROM emp
GROUP BY SUBSTR(hiredate,1,2)
ORDER BY SUBSTR(hiredate,1,2) DESC;
*/
--LPAD / RPAD => 글자수에 따라서 특수문자를 출력
SELECT LPAD('Hello Oracle',15,'#'),RPAD('Hello Oracle',15,'#') FROM DUAL;
SELECT ename,RPAD(SUBSTR(ename,1,2),LENGTH(ename),'*') FROM emp;
-- 비밀번호 => 재설정, 이메일 전송(JavaMail)
-- trim() (좌우), LTRIM(),RTRIM => 지정된 문자를 제거 => 문자를 지정하지 않으면 공백
SELECT LTRIM('AAABBBCCC','A'),RTRIM('AAABBBCCC','C') FROM DUAL;
SELECT TRIM('A' FROM 'AAABBBAAA') FROM DUAL;
-- CONCAT
SELECT CONCAT('Hello ','Java') FROM DUAL;
SELECT 'Hello ' || 'Java' FROM DUAL;
-- INSTR => indexOf()
SELECT ename, INSTR(ename,'A',1,2) FROM emp; --indexOf
SELECT INSTR('Hello Java','l',-1,1) FROM DUAL; -- lastIndexOf