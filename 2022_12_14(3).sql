/*
    = VIEW : 가상 테이블 (기존의 테이블을 참조해서 사용)
            1개 사용 : 단순뷰
            여러개 사용 : 복합뷰
            -------------------- 뷰에는 SQL문장만 저장 => 보안이 좋다
            인라인뷰
            => 재사용목적, 보안
            => user_views(view를 저장하고 있는 테이블)
            => CREATE VIEW view_name
                AS
                SELECT~~
            => CREATE OR REPLACE VIEW view_name
                AS
                SELECT~~
            => SELECT ~~ 
                FROM (SELECT~~)
            => DROP VIEW view_name
            => VIEW의 내용을 확인
                SELECT text FROM user_views WHERE view_name='대문자';
    = SEQUENCE : 자동 증가 번호 PK => 번호설정
                => 생성
                    CREATE SEQUENCE seq_name
                    START WITH 1
                    INCREMENT BY 1
                    NOCACHE
                    NOCYCLE
                => 값읽기
                    현재값 : currVal
                    다음값 : nextVal
                => 삭제
                    DROP SEQUENCE seq_name
    --------------------------------------------------------------
    = SYNONYM : 테이블의 별칭 ==> 실무(동의어)
        = 생성
          CREATE SYNONYM 별칭명
          FOR 테이블
        = 삭제
          DROP SYNONYM 별칭명
    = INDEX
    = PL/SQL : FUNCTION, PROCEDURE / TRIGGER
*/
/*
    권한 부여
    system/happy => 계정으로 접근
    GRANT CREATE FUNCTION TO hr;
    
    권한 취소
    REVOKE CREATE FUNCTION FROM hr;
*/
CREATE SYNONYM 사원정보
FOR emp;

SELECT * FROM 사원정보;
DROP SYNONYM 사원정보;

DESC food_location;

SELECT name,hit FROM food_location ORDER BY hit DESC;
SELECT CEIL(COUNT(*)/20.0) FROM food_location;