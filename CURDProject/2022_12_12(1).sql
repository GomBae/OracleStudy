/*

TABLE : 데이터 저장 만들기
  1. 데이터형
     문자형
       CHAR(1~2000byte)
         => 고정 바이트 (글자수가 동일 => 남자/여자 , y,n, y,n)
         => CHAR(10)
       VARCHAR2(1~4000byte) default(오라클에서만 사용이 가능)
         => 가변바이트
       CLOB(4기가) => 가변바이트 => 문자열 저장 
    숫자형
       NUMBER(38) ==> int, long
       NUMBER(4) ==> 저장할 수 있는 데이터 ==> 0~9999
       NUMBER =====> 8자리까지 저장 ==> NUMBER(8,2)
       NUMBER(7,2) ==> 7자리까지 저장이 가능, 정수 5자리, 소숫점 2자리
       -------------- 무조건 실수를 저장하는것은 아님(정수만 저장해도 됨)
    날짜형
       DATE : default
       TIMESTAMP : 기록 경기
    기타형
       BLOB : 2진파일, BFILE(file형식) ==> 폴더에 저장후 => 파일을 읽어서 출력
       => HTML의 링크 
    1-1. 
        테이블명(식별자)
         1) 같은 데이터베이스 (XE)에서 같은 이름의 테이블을 만들 수 없다
         2) 문자로 시작한다 (알파벳, 한글) => 당연히 알파벳으로 생성해라
            => 운영체제마다 한글 읽는 방식이 다르다
            => 알파벳을 사용시 대소문자 구분이 없다
            => 실제 오라클에 저장될 때 대문자로 저장됨(실제 테이블의 형식을 읽을 때)
         3) 테이블명(30) ==> 15자 : 테이블명 컬럼은 동일 할 수 있다
         4) 숫자는 사용할 수 있다 (단 앞에 사용 금지)
         5) 키워드 사용금지 (SELECT, INSERT)
         6) 특수문자 사용가능(_)
  2. 제약조건 : 이상현상을 방지(프로그램에 필요한 데이터만 저장)
                ----------- 수정, 삭제 => 원하지 않는 데이터가 수정, 삭제될 수 있다.
            1) NOT NULL : NULL을 허용하지 않는다(무조건 데이터값을 필요로 한다)
            2) UNIQUE : 유일값 (중복이 없는 데이터 => NULL값을 허용)
                 * 후보키(대체키) => 기본키를 잃어버렸을 경우 => 이메일, 전화번호
            3) PRIMARY KEY : 기본키 => 정수값, ID => 중복이 없는 값
                * 모든 테이블은 PK를 한개이상 설정을 권장
                NOT NULL + UNIQUE
            4) FOREIGN KEY : 참조키 => 참조하고 있는 데이터값만 저장(다른 테이블과 연결)
            5) CHECK : 지정된 데이터값만 입력이 가능하게 만든다
            6) DEFAULT : 미리 기본값을 설정한 후에 ==> 데이터값이 없는 경우 자동으로 값을 입력 
                        regdate DATE DEFAULT SYSDATE
                        hit NUMBER DEFAULT 0
  ----------------------------------------------------------------------------------
  2-1 . TABLE 만들기
        1) 기존의 테이블을 복사 (데이터값_테이블형태)
           CREATE TABLE table_name
           AS
           SELECT ~
        2) 테이블형태만 복사 
           CREATE TABLE table_name
           AS
           SELECT ~
           WHERE 1=2; ==> WHERE문장이 false가 되게 만들면 됨
        3) 사용자 정의
        -------------------- COMMIT(AUTO)
  3. 수정, 삭제, 데이터 자르기
*/
-- 복사
/*CREATE TABLE myEmp
AS
SELECT * FROM emp;
SELECT * FROM myEmp;
DESC myEmp;*/
/*CREATE TABLE myEmp2
AS
SELECT * FROM emp
WHERE 1=2;

SELECT * FROM myEmp2;
DESC myEmp2;*/
/*
삭제
DROP TABLE myEmp;
DROP TABLE myEmp2;
*/
/*
CREATE TABLE myEmp
AS
SELECT emp.*,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;

SELECT * FROM myEmp;
TRUNCATE TABLE myEmp; 
DROP TABLE myEmp;
*/
/*
    필요없는 데이터 삭제 : DELETE ===> 취소가능
    전체 데이터 삭제 : TRUNCATE ==> 취소불가(복구 불가)
    테이블 자체 삭제 : DROP ==> 취소불가
    => DML(복구 가능), DDL(복구 불가) ==> 백업
*/
DESC myEmp;
--테이블명 변경 => RENAME old_name TO new_name
RENAME myEmp TO myEmp2;
/*
    사용자 정의 테이블
    --------------- 
    형식
       CREATE TABLE table_name(
            컬럼명 데이터형 [제약조건], ==> 컬럼레벨(컬럼과 동시에 생성) => NOT NULL, DEFAULT
            컬럼명 데이터형 [제약조건],
            컬럼명 데이터형 [제약조건],
            컬럼명 데이터형 [제약조건],
            [제약조건] ==> 테이블레벨 => 테이블이 만들어진 다음 생성 => PK,FK,CHECK,UNIQUE
       );
    => 약식
    CREATE TABLE member
    (
        id VARCHAR2(20) PRIMARY KEY,
        pwd VARCHAR2(10) NOT NULL,
        name VARCHAR2(34) NOT NULL,
        sex CHAR(10) CHECK(sex IN('남자','여자')),
        email VARCHAR2(100) UNIQUE,
        tel VARCHAR2(13) UNIQUE,
        regdate DATE DEFAULT SYSDATE
    );
    => 제약조건에 이름을 부여 ==> 권장 (제약조건만 수정,삭제에 용이하다)
    CREATE TABLE member
    (
        id VARCHAR2(20),
        pwd VARCHAR2(10) CONSTRAINT member_pwd_nn NOT NULL,
                                    -------------  중복을 허용하지 않는다
                                    테이블명_컬럼명_제약조건약자
                                    => pk (PRIMARY KEY)
                                    => nn (NOT NULL)
                                    => fk (FOREIGN KEY)
                                    => ck (CHECK)
                                    => uk (UNIQUE)
        name VARCHAR2(34) CONSTRAINT member_name_nn NOT NULL,
        sex CHAR(10),
        email VARCHAR2(100),
        tel VARCHAR2(13),
        regdate DATE DEFAULT SYSDATE,
        CONSTRAINT member_id_pk PRIMARY KEY(id),
        CONSTRAINT member_sex_ck CHECK(IN('남자','여자'))
        CONSTRAINT member_et_uk UNIQUE(email,tel)
    );
    
     emp
    EMPNO    NOT NULL NUMBER(4)    
    ENAME             VARCHAR2(10) 
    JOB               VARCHAR2(9)  
    MGR               NUMBER(4)    
    HIREDATE          DATE         
    SAL               NUMBER(7,2)  
    COMM              NUMBER(7,2)  
    DEPTNO            NUMBER(2)   

    dept
    DEPTNO NOT NULL NUMBER       
    DNAME           VARCHAR2(20) 
    LOC             VARCHAR2(20) 
    
    CREATE TABLE dept(
        deptno NUMBER(2),
        dname VARCHAR2(20) CONSTRAINT dept_dname_nn NOT NULL,
        loc VARCHAR2(20) CONSTRAINT dept_loc_nn NOT NULL,
        CONSTRAINT dept_deptno_pk PRIMARY KEY(deptno)
    );
    
    CREATE TABLE emp(
        empno NUMBER(4),
        ENAME             VARCHAR2(10) CONSTRAINT emp_ename_nn NOT NULL, 
        JOB               VARCHAR2(9) CONSTRAINT emp_job_nn NOT NULL,  
        MGR               NUMBER(4), -- NULL값을 허용  
        HIREDATE          DATE DEFAULT SYSDATE,         
        SAL               NUMBER(7,2) CONSTRAINT emp_sal_nn NOT NULL,  
        COMM              NUMBER(7,2),  
        DEPTNO            NUMBER(2),
        CONSTRAINT emp_empno_pk PRIMARY KEY(empno),
        CONSTRAINT emp_deptno_fk FOREIGN KEY(deptno)
        REFERENCES dept(deptno)
    );
*/
/*
    참조하는 테이블
    ***참조되는 테이블 (우선 생성)
    설계
    게시물번호 => 중복이 안되는 데이터 PK => 자동증가 (구분자) => MAX
    이름 => NOT NULL
    제목 => NOT NULL
    내용 => NOT NULL CLOB
    비밀번호 => 수정/삭제시 본인 확인 ==> NOU NULL
    등록일 => DEFAULT SYSDATE
    조회수 => DEFAULT 0
    
*/
DROP TABLE board;
CREATE TABLE board(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT board_name_nn NOT NULL, 
    subject VARCHAR2(4) CONSTRAINT board_subject_nn NOT NULL,
    content CLOB CONSTRAINT board_content_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT board_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    address VARCHAR2(100),
    CONSTRAINT board_no_pk PRIMARY KEY(no)
);
-- ALTER => 컬럼을 수정, 컬럼을 삭제, 컬럼추가, 제약조건 변경
--추가
ALTER TABLE board ADD hit NUMBER DEFAULT 0;
DESC board;
--수정
ALTER TABLE board MODIFY subject VARCHAR(4000);
--삭제
ALTER TABLE board DROP COLUMN address;
ALTER TABLE board ADD address VARCHAR2(100) CONSTRAINT board_address_no NOT NULL;
--컬럼명 변경
ALTER TABLE board RENAME COLUMN address TO email;
-- 제약조건을 추가하는 경우에 => 데이터가 없는 경우에는 문제 없다,
-- => 문제가 있는 경우 : NOT NULL, PRIMARY KEY, FOREIGN KEY, CHECK
/*
    ALTER
      추가 : ADD
      삭제 : DROP COLUMN
      수정 : MODIFY
*/
SELECT * FROM tab;
DROP TABLE member;
/*
    member
    id ==> PK
    pwd ==> NN
    sex ==> CHECK
    name == NN
    address 
    tel
*/
CREATE TABLE member(
    id VARCHAR2(20),
    pwd VARCHAR2(10) CONSTRAINT member_pwd_nn NOT NULL,
    sex VARCHAR(6),
    name VARCHAR2(34) CONSTRAINT member_name_nn NOT NULL,
    CONSTRAINT member_id_pk PRIMARY KEY(id),
    CONSTRAINT member_sex_ck CHECK(sex IN('남자','여자'))
);
INSERT INTO member VALUES('bbb',' ','남자','홍길동');
-- ''(NULL) , ' '(공백)
SELECT * FROM member;
ALTER TABLE member ADD address VARCHAR2(100) DEFAULT ' ' CONSTRAINT member_address_nn NOT NULL;
-- 제약조건은 한개만 사용하는것이 아니고 여러개 사용 가능
-- 데이터 NOT NULL, UNIQUE, CHECK 
DROP TABLE board;
CREATE TABLE board(
    no NUMBER,
    name VARCHAR2(34), 
    subject VARCHAR2(4000),
    content CLOB,
    pwd VARCHAR2(10),
    regdate DATE,
    address VARCHAR2(100)
);
--ALTER를 이용해서 제약조건 추가
-- PRIMARY KEY 추가
DESC board;
ALTER TABLE board ADD CONSTRAINT board_no_pk PRIMARY KEY(no);
-- NOT NULL 
-- PRIMARY KEY, FOREIGN KEY, CHECK, UNIQUE ===> ADD를 줘야함
-- NOT NULL ===> MODIFY로 수정해야함
ALTER TABLE board MODIFY name CONSTRAINT board_name_nn NOT NULL;
-- DEFAULT는 제약조건이 아니다
ALTER TABLE board MODIFY regdate DATE DEFAULT SYSDATE;
-- 제약조건 삭제
ALTER TABLE board DROP CONSTRAINT board_name_nn;
DROP TABLE member2;
CREATE TABLE member2(
    id VARCHAR2(20),
    name VARCHAR2(30) CONSTRAINT mem_name_nn NOT NULL,
    email VARCHAR2(100),
    pwd VARCHAR2(10) CONSTRAINT mem_pwd_nn NOT NULL,
    CONSTRAINT mem_id_pk PRIMARY KEY(id),
    CONSTRAINT mem_email_pk PRIMARY KEY(email)
);

CREATE TABLE member2(
    id VARCHAR2(20),
    name VARCHAR2(30) CONSTRAINT mem_name_nn NOT NULL,
    email VARCHAR2(100),
    pwd VARCHAR2(10) CONSTRAINT mem_pwd_nn NOT NULL,
    CONSTRAINT mem_id_email_pk PRIMARY KEY(id,email)
);
--INSERT INTO member2 VALUES('aaa','hong','hong@co.kr','1234');
INSERT INTO member2 VALUES('aaa','shim','shim@co.kr','1234');
INSERT INTO member2 VALUES('bbb','park','park@co.kr','1234');
INSERT INTO member2 VALUES('ccc','kim','park@co.kr','1234');
/*
INSERT INTO member2 VALUES('aaa','hong','','1234');
SELECT * FROM member2;
DELETE FROM member2 WHERE id='aaa';*/