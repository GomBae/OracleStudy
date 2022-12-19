/*

    PL/SQL
    프로시저 생성 언어 => 함수 => 재사용
                       ---
                       1. FUNCTION : 리턴형을 가지고 있는 함수 (내장함수)
                       2. PROCEDURE : 리턴형이 없는 기능만 수행하는 함수
                       3. TRIGGER : 자동처리
                       
    
    1) 변수
       = 일반 변수(스칼라 변수)
         변수 데이터형
         no NUMBER
         name VARCHAR2(10)
       = 실제 테이블에 존재하는 변수의 데이터형
         %TYPE
         => no emp.empno%TYPE
               --------------- 데이터형(가장 많이 사용되는 변수)
       = 테이블 전체변수의 모든 데이터형 읽기
         %ROWTYPE
         => vemp emp%ROWTYPE
       = 데이터 전체 => ResultSet, ArrayList
         => CURSOR
       = 사용자 정의 데이터형 => 테이블을 여러개 묶어서 사용 : RECORD
    
    2) 연산자 => 기존에 배운 연산자를 사용
    3) 제어문 
       = 조건문
         = IF(단일 조건문)
         = IF ~ ELSE(선택 조건문)
         = IF ELSIF ~ ELSIF ~ ELSIF (다중 조건문)
         = CASE (선택문)
       = 반목문
         = BASIC LOOP
         = WHILE
         = FOR
    
    4) SQL => DML/DQL
    
    PL/SQL 문법 형식
    ---------------
    DECLARE => 선언부 (변수 설정)
     변수 선언위치
    BEGIN {
     구현부
    END; }
     /

-- 1. 오라클에서 실행
-- 출력 / 입력
-- DBMS_OUTPUT.PUTLINE() => sysout => 변수설정 => 결과가 추출 => 출력
-- & => Scanner
*/
SET SERVEROUTPUT ON;
DECLARE
--변수 선언 위치
-- CREATE FUNCTION
-- CREATE PROCEDURE
-- CREATE TRIGGER
pEmpno NUMBER(4):=10; --초기화는 :=를 사용해야함
pEname VARCHAR2(34);
pJob VARCHAR2(20);
pHiredate DATE;
pSal NUMBER(7,2);
BEGIN
-- 구현부 (SQL)
SELECT empno,ename,job,hiredate,sal INTO pEmpno,pEname,pJob,pHiredate,pSal
FROM emp
WHERE empno=7788;
--SELECT를 통해서 변수의 값 초기화 => ROW => CURSOR (FOR)
DBMS_OUTPUT.PUT_LINE('-------결과-------');
DBMS_OUTPUT.PUT_LINE('사번:'||pEmpno);
DBMS_OUTPUT.PUT_LINE('이름:'||pEname);
DBMS_OUTPUT.PUT_LINE('직위:'||pJob);
DBMS_OUTPUT.PUT_LINE('입사일:'||pHiredate);
DBMS_OUTPUT.PUT_LINE('급여:'||pSal);
END;
/
-- 실제 테이블의 컬럼데이터형 읽기 : %TYPE
/*
    CREATE [OR REPLACE] FUNCTION func_name(
        매개변수
    ) RETURN 데이터형
    IS
        지역변수
    BEGIN
        구현
        RETURN 값
    END;
    /
*/
DECLARE
-- 변수 선언 위치
vEmpno emp.empno%TYPE;
vEname emp.ename%TYPE;
vJob emp.job%TYPE;
vDname dept.dname%TYPE;
vLoc dept.loc%TYPE;
vGrade salgrade.grade%TYPE;
BEGIN
--구현부
SELECT empno,ename,job,dname,loc,grade INTO vEmpno,vEname,VJob,vDname,vLoc,Vgrade
FROM emp JOIN dept
ON emp.deptno=dept.deptno
JOIN salgrade
ON sal BETWEEN losal AND hisal
WHERE empno=7788;
-- 출력(결과값) --> 함수
DBMS_OUTPUT.PUT_LINE('-------결과-------');
DBMS_OUTPUT.PUT_LINE('사번:'||vEmpno);
DBMS_OUTPUT.PUT_LINE('이름:'||vEname);
DBMS_OUTPUT.PUT_LINE('직위:'||vJob);
DBMS_OUTPUT.PUT_LINE('부서명:'||vDname);
DBMS_OUTPUT.PUT_LINE('급여:'||vLoc);
DBMS_OUTPUT.PUT_LINE('호봉:'||vGrade);
END;
/

--테이블 전체의 데이터형 받기 => 7900, 7902
SELECT * FROM emp;
-- %ROWTYPE => 자바 (~vo) => 한명에 대한 모든 정보
DECLARE 
vEmp emp%ROWTYPE;
BEGIN
SELECT * INTO vEmp
FROM emp
WHERE empno=7900;
DBMS_OUTPUT.PUT_LINE('----------결과-----------');
DBMS_OUTPUT.PUT_LINE('사번:'||vEmp.empno);
DBMS_OUTPUT.PUT_LINE('이름:'||vEmp.ename);
DBMS_OUTPUT.PUT_LINE('직위:'||vEmp.job);
DBMS_OUTPUT.PUT_LINE('사수번호:'||vEmp.mgr);
DBMS_OUTPUT.PUT_LINE('입사일:'||vEmp.hiredate);
DBMS_OUTPUT.PUT_LINE('급여:'||vEmp.sal);
DBMS_OUTPUT.PUT_LINE('성과급:'||vEmp.comm);
DBMS_OUTPUT.PUT_LINE('부서번호:'||vEmp.deptno);
END;
/

--JOIN,SUBQUERY => 다른 테이블 연결 => %ROWTYPE을 사용할 수 없다 => 사용자 정의 데이터형
-- RECORD
/*
    RECORD 사용방법(사용자 정의) => ROWTYPE(한명에 대한 정보만 읽을 수 있다)
    -------------- CURSOR
    TYPE record명 IS RECORD(
        변수 설정
    );
*/
DECLARE
-- 사용자 정의 데이터형 제작
TYPE empDept IS RECORD(
empno emp.empno%TYPE,
ename emp.ename%TYPE,
job emp.job%TYPE,
hiredate emp.hiredate%TYPE,
dname dept.dname%TYPE,
loc dept.loc%TYPE
);
--변수 선언
/*
class ClassName(
)
ClassName s=new ClassName()
*/
ed empDept;
BEGIN
SELECT empno,ename,job,hiredate,dname,loc INTO ed
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND empno=7902;
DBMS_OUTPUT.PUT_LINE('----------결과-----------');
DBMS_OUTPUT.PUT_LINE('사번:'||ed.empno);
DBMS_OUTPUT.PUT_LINE('이름:'||ed.ename);
DBMS_OUTPUT.PUT_LINE('직위:'||ed.job);
DBMS_OUTPUT.PUT_LINE('입사일:'||ed.hiredate);
DBMS_OUTPUT.PUT_LINE('부서명:'||ed.dname);
DBMS_OUTPUT.PUT_LINE('근무지:'||ed.loc);
END;
/
--제어문 -> Record (GROUP BY, JOIN, SUBQUERY)
/*
    제어문
      = 조건문
        IF(단일 조건문)
        형식)
            IF 조건문 THEN 
            실행문장
            END IF;
        
        IF ~ ELSE (선택조건문)
        형식)
            IF 조건문 THEN
            실행문장
            ELSE
            실행문장
            END IF;
            
        IF~ELSIF ~ ELSIF ~ELSE (다중 조건문)
        형식) 
            IF 조건문 THEN
            처리문장
            ELSIF 조건문 THEN
            처리문장
            ELSIF 조건문 THEN
            처리문장
            ELSIF 조건문 THEN
            처리문장
            ELSE
            처리문장
            END IF;
        
    반복문
        BASIC ~ LOOP
        WHILE ~ LOOP
        FOR [REVERSE]~ LOOP ==> 일반 for, ForEach 구문이 있다 (무조건 증가만 가능)
        
        
*/
--IF조건 
DECLARE
--스칼라변수
vEmpno NUMBER(4):=0;
vEname VARCHAR2(20):=' ';
vJob VARCHAR2(20):=' ';
vDname VARCHAR2(20):=' ';
vDeptno NUMBER(2):=0;
BEGIN
--실제 데이터값 읽어서 변수에 대입
SELECT empno,ename,job,deptno INTO vEmpno,Vename,vJob,vDeptno
FROM emp
WHERE empno=&empno; --&입력을 받을 경우에 사용
IF vDeptno=10 THEN
vDname:='영업부';
END IF;

IF vDeptno=20 THEN
vDname:='개발부';
END IF;

IF vDeptno=30 THEN
vDname:='자재부';
END IF;

IF vDeptno=40 THEN
vDname:='신입';
END IF;

DBMS_OUTPUT.PUT_LINE('---------- 결과 ------------');
DBMS_OUTPUT.PUT_LINE('사번:'||vEmpno);
DBMS_OUTPUT.PUT_LINE('이름:'||vEname);
DBMS_OUTPUT.PUT_LINE('직위:'||vJob);
DBMS_OUTPUT.PUT_LINE('부서명:'||vDname);
DBMS_OUTPUT.PUT_LINE('부서번호:'||vDeptno);
END;
/

DECLARE
vEname emp.ename%TYPE:=' ';
vComm emp.comm%TYPE:=0;
vSal emp.sal%TYPE:=0;
vTotal NUMBER(7,2):=0;
BEGIN
SELECT ename,comm,sal,sal+NVL(comm,0) INTO vEname,vComm,vSal,vTotal
FROM emp
WHERE empno=&empno;

IF vComm>0 THEN
    DBMS_OUTPUT.PUT_LINE(vEname||'님의 급여는 '||vSal||'이고 성과급은'||vComm||'입니다 총 급여는 '||vTotal||'입니다.');
ELSE
    DBMS_OUTPUT.PUT_LINE(vEname||'님의 급여는 '||vSal||'이고 성과급은 없으며 총 급여는 '||vTotal||'입니다.');
END IF;
END;
/

--다중조건문
DECLARE
vEname emp.ename%TYPE;
vDname dept.dname%TYPE;
vDeptno emp.deptno%TYPE;
BEGIN
SELECT ename,deptno INTO vEname,vDeptno
FROM emp
WHERE empno=7902;

--vDeptno 10,20,30 => 10(부서결정)
IF vDeptno=10 THEN
vDname:='영업부';
ELSIF vDeptno=20 THEN
vDname:='기획부';
ELSIF vDeptno=30 THEN
vDname:='개발부';
ELSE
vDname:='신입';
END IF;

DBMS_OUTPUT.PUT_LINE('---------- 결과 -----------');
DBMS_OUTPUT.PUT_LINE('이름:'||vEname);
DBMS_OUTPUT.PUT_LINE('부서명:'||vDname);
END;
/

-- 선택문 switch~case => CASE
DECLARE
vEname emp.ename%TYPE;
vDeptno emp.deptno%TYPE;
vDname dept.dname%TYPE;
BEGIN
SELECT ename,deptno INTO vEname,vDeptno
FROM emp
WHERE empno=7788;

vDname:=CASE vDeptno
        WHEN 10 THEN '개발부'
        WHEN 20 THEN '영업부'
        WHEN 30 THEN '기획부'
        ELSE
            '신입'
        END;
    
DBMS_OUTPUT.PUT_LINE('---------- 결과 -----------');
DBMS_OUTPUT.PUT_LINE('이름:'||vEname);
DBMS_OUTPUT.PUT_LINE('부서명:'||vDname);
END;
/

--Loop 실행 ( DO ~ WHILE)
DECLARE
 sno NUMBER:=1;
 eno NUMBER:=10;
BEGIN
 LOOP
 DBMS_OUTPUT.PUT_LINE(sno);
 --증가식
 sno:=sno+1;
 EXIT WHEN sno>eno;
END LOOP;
END;
/

--WHILE
DECLARE 
 no NUMBER:=1;
BEGIN
 WHILE no<=10 LOOP
 DBMS_OUTPUT.PUT_LINE(no);
 no:=no+1;
 END LOOP;
END;
/

--FOR문
DECLARE 
BEGIN
 FOR i IN REVERSE 1..10 LOOP
  DBMS_OUTPUT.PUT_LINE(i);
 END LOOP;
END;
/

--DECLARE
BEGIN
 FOR i IN 1..10 LOOP
  IF MOD(i,2)=0 THEN
   DBMS_OUTPUT.PUT_LINE(i);
  END IF;
 END LOOP;
END;
/

DECLARE 
 total NUMBER:=0;
 even NUMBER:=0;
 odd NUMBER:=0;
BEGIN
 FOR i IN 1..100 LOOP
  total:=total+i; --total +=i
  IF MOD(i,2)=0 THEN
   even:=even+i;
  ELSE
   odd:=odd+i;
  END IF;
 END LOOP;
 DBMS_OUTPUT.PUT_LINE('--------- 결과 -----------');
 DBMS_OUTPUT.PUT_LINE('1~100까지 총합 : '||total);
 DBMS_OUTPUT.PUT_LINE('1~100까지 짝수합 : '||even);
 DBMS_OUTPUT.PUT_LINE('1~100까지 홀수합 : '||odd);
END;
/

DECLARE 
 dan NUMBER:=&dan;
 result VARCHAR2(100):=' ';
BEGIN
 FOR i IN 1..9 LOOP
  result:=dan||'*'||i||'='||(dan*i);
  DBMS_OUTPUT.PUT_LINE(result);
 END LOOP;
END;
/
-- CURSOR ==> 자바 매칭 클래스 ResultSet
-- CURSOR를 이용하면 여러명을 동시에 출력 가능 ArrayList
-- 자바에 목록 출력할때 => cursor만 이용
/*
 1. Cursor 설정
    CURSOR 커서명 IS
     SELECT~ => 실행된 결과값을 가지고 있다
 2. Cursor 열기
    OPEN 커서명;
 3. LOOP(인출)
    1) FETCH 받는변수명 IN 커서명
    2) 종료시점 설정
         커서명%NOTFOUND => 데이터가 없는 경우
         커서명%FOUND
         커서명%COUNT
 4. Cursor 닫기
    CLOSE 커서명
*/
DECLARE
 vEmp emp%ROWTYPE;
 --커서 설정
 CURSOR cur IS
  SELECT * FROM emp;
BEGIN
 --커서 열기
 OPEN cur;
 --인출
 LOOP
  FETCH cur INTO vEmp;
  --종료시점
  EXIT WHEN cur%NOTFOUND; --데이터가 없는 경우까지 LOOP
  DBMS_OUTPUT.PUT_LINE(vEmp.empno||' '||vEmp.ename||' '||vEmp.job||' '||vEmp.hiredate||' '||vEmp.sal);
 END LOOP;
 -- 커서 닫아주기
 CLOSE cur;
END;
/

--CURSOR를 FOR문으로 제어 (가장 많이 사용되는 방법)
DECLARE 
 vEmp emp%ROWTYPE;
 CURSOR cur IS
  SELECT * FROM emp; --실행된 결과를 커서에 삽입 (JOIN,SubQUERY)
BEGIN
 FOR vEmp IN cur LOOP
  DBMS_OUTPUT.PUT_LINE(vEmp.empno||' '||vEmp.ename||' '||vEmp.job||' '||vEmp.hiredate||' '||vEmp.sal);
 END LOOP;
END;
/

--JOIN된 데이터를 저장 => FOR를 이용해서 출력
DECLARE
 TYPE empDept IS RECORD(
 empno emp.empno%TYPE,
 ename emp.ename%TYPE,
 job emp.job%TYPE,
 dname dept.dname%TYPE,
 loc dept.loc%TYPE
);
ed empDept; --사용자 정의 데이터형을 선언
-- 커서 설정
CURSOR cur IS
 SELECT empno,ename,job,dname,loc
 FROM emp,dept
 WHERE emp.deptno=dept.deptno;
BEGIN
 FOR ed IN cur LOOP
  DBMS_OUTPUT.PUT_LINE(ed.empno||' '||ed.ename||' '||ed.job||' '||ed.dname||' '||ed.loc);
 END LOOP;
END;
/
-- 함수, 프로시저, 트리거 => 제작할때 사용되는 언어 => 처리문장은 SQL => PL/SQL
