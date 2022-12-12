-- DML
/*
    DQL : SELECT (데이터검색)
          SELECT 컬럼명,(SELECT~) => 스칼라 서브쿼리
          FROM table_name|(SELECT~) => 인라인뷰
          WHERE 컬럼명 연산자 (SELECT~) => 서브쿼리 (단일, 다중)
    DDL : 정의언어 (table, view, index)
          CREATE
          ALTER
          DROP
          TRUNCATE
          RENAME
*/
/*
CREATE TABLE 판매전표(
    전표번호 VARCHAR2(13),
    판매일자 DATE  DEFAULT SYSDATE CONSTRAINT 판매전표_판매일자_nn NOT NULL,
    고객명 VARCHAR2(34) CONSTRAINT 판매전표_고객명_nn NOT NULL,
    총액 NUMBER,
    CONSTRAINT 판매전표_전표번호_pk PRIMARY KEY(전표번호),
    CONSTRAINT 판매전표_총액_ck CHECK(총액>0)
);
*/
/*
CREATE TABLE 제품(
    제품번호 VARCHAR2(12),
    제품명 VARCHAR2(100) CONSTRAINT 제품_제품명_nn NOT NULL,
    제품단가 NUMBER,
    CONSTRAINT 제품_제품번호_pk PRIMARY KEY(제품번호),
    CONSTRAINT 제품_제품단가_ck CHECK(제품단가>0)
);
*/
/*
CREATE TABLE 전표상세(
    전표번호 VARCHAR2(13),
    제품번호 VARCHAR2(100),
    수량 NUMBER CONSTRAINT 전표상세_수량_nn NOT NULL,
    단가 NUMBER CONSTRAINT 전표상세_단가_nn NOT NULL,
    금액 NUMBER,
    CONSTRAINT 전표상세_전표번호_pk PRIMARY KEY(전표번호),
    CONSTRAINT 전표상세_금액_ck CHECK(금액>0),
    CONSTRAINT 전표상세_전표번호_fk FOREIGN KEY(전표번호)
    REFERENCES 판매전표(전표번호),
    CONSTRAINT 전표상세_제품번호_fk FOREIGN KEY(제품번호)
    REFERENCES 제품(제품번호)
);
*/
--테이블의 제약조건 확인
SELECT * FROM user_constraints
WHERE table_name='전표상세';
/*
    CONSTRAINT Type
    C : CHECK, NOT NULL
    P : PRIMARY KEY
    R : FOREIGN
    U : UNIQUE
*/
DROP TABLE 판매전표;
DROP TABLE 제품;
DROP TABLE 전표상세;

CREATE TABLE 판매전표(
    전표번호 VARCHAR2(13),
    판매일자 DATE,
    고객명 VARCHAR2(34),
    총액 NUMBER
);
DESC 판매전표;
ALTER TABLE 판매전표 ADD CONSTRAINT 판매전표_전표번호_pk PRIMARY KEY(전표번호); --PK 변경
ALTER TABLE 판매전표 MODIFY 판매일자 DATE CONSTRAINT 판매전표_판매일자_nn NOT NULL;
ALTER TABLE 판매전표 MODIFY 고객명 VARCHAR2(34) CONSTRAINT 판매전표_고객명_nn NOT NULL;
ALTER TABLE 판매전표 ADD CONSTRAINT 판매전표_총액_ck CHECK(총액>0);

CREATE TABLE 제품(
    제품번호 VARCHAR2(12),
    제품명 VARCHAR2(100),
    제품단가 NUMBER
);
ALTER TABLE 제품 ADD CONSTRAINT 제품_제품번호_pk PRIMARY KEY(제품번호);
ALTER TABLE 제품 ADD CONSTRAINT 제품_제품명_uk UNIQUE(제품명);
ALTER TABLE 제품 ADD CONSTRAINT 제품_제품단가_ck CHECK(제품단가>0);
CREATE TABLE 전표상세(
    전표번호 VARCHAR2(13),
    제품번호 VARCHAR2(100),
    수량 NUMBER,
    단가 NUMBER,
    금액 NUMBER
);
DESC 전표상세;
ALTER TABLE 전표상세 ADD CONSTRAINT 전표상세_전표번호_pk PRIMARY KEY(전표번호);
ALTER TABLE 전표상세 ADD CONSTRAINT 전표상세_전표번호_fk FOREIGN KEY(전표번호)
REFERENCES 판매전표(전표번호);
ALTER TABLE 전표상세 ADD CONSTRAINT 전표상세_제품번호_fk FOREIGN KEY(제품번호)
REFERENCES 제품(제품번호);
ALTER TABLE 전표상세 MODIFY 수량 CONSTRAINT 전표상세_수량_nn NOT NULL;
ALTER TABLE 전표상세 MODIFY 단가 CONSTRAINT 전표상세_단가_nn NOT NULL;
ALTER TABLE 전표상세 ADD CONSTRAINT 전표상세_금액_ck CHECK(금액>0);
/*
    ALTER : 테이블 수정
      컬럼 추가
      컬럼 수정
      컬럼 삭제
      컬럼 이름 변경
      컬럼 제약조건 변경
      
    데이터만 삭제 : TRUNCATE
      형식
        TRUNCATE TABLE table_name; => 테이블 구조는 남아있다
    테이블 삭제 : DROP
      형식
        DROP TABLE table_name; => 테이블 구조까지 삭제
    테이블 이름변경 : RENAME
        RENAME old_name TO new_name
*/
CREATE TABLE student(
    hakbun NUMBER,
    name VARCHAR2(34) CONSTRAINT std_name_nn NOT NULL,
    CONSTRAINT std_hakbun_pk PRIMARY KEY(hakbun)
);
--컬럼 추가
ALTER TABLE student ADD kor NUMBER DEFAULT 0;
ALTER TABLE student ADD eng NUMBER DEFAULT 0;
ALTER TABLE student ADD math NUMBER DEFAULT 0;
ALTER TABLE student ADD avg NUMBER NOT NULL;
--컬럼 수정
ALTER TABLE student MODIFY avg NUMBER(5,2);
ALTER TABLE student MODIFY kor NUMBER(3);
ALTER TABLE student MODIFY eng NUMBER(3);
ALTER TABLE student MODIFY math NUMBER(3);
DESC student;
--컬럼 삭제
ALTER TABLE student DROP COLUMN avg;
--컬럼명 변경
ALTER TABLE student RENAME COLUMN hakbun TO hak;
