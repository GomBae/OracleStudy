/*
    1. %TYPE : 실제 테이블에 설정된 데이터형을 읽어온다
        vEmpno emp.empno%TYPE
    2. %ROWTYPE : 테이블을 전체의 데이터형을 가지고 올때 ==> ~VO
        => 한개의 테이블 컬럼 (JOIN,Subquery는 사용할 수 없는 경우도 있다)
            테이블명%ROWTYPE
    3. RECORD : 사용자 정의 (테이블 여러개를 묶어서 데이터 제어)
       ------ JOIN / Subquery
       형식) TYPE 변수명 IS RECORD(
                필요한 데이터 설정
            )
    4. CURSOR : 전체 ROW에 대한 데이터를 저장할 수 있는 변수 (자바 => ResultSet)
       형식) 
            CURSOR cur명 IS
            SELECT ~~ => VIEW와 유사
    
    프로시저
        CREATE [OR REPLACE] PROCEDURE pro_name(
            매개변수
        )
        IS | AS
            지역변수
        BEGIN
            구현부 : SQL
        END;
        /
        
    사용자 정의 함수 => 서브쿼리를 대체 (SELECT, WHERE)
    CREATE [OR REPLACE] FUNCTION func_name(
        매개변수
    ) RETURN 데이터형
    IS | AS 
        지역변수
    BEGIN
        구현부
        RETURN 값
    END;
    /
    
    = 트리거
        = 자동 이벤트 처리
        = 미리 설정된 조건에 맞는 경우 자동으로 실행 (오라클 자체에서 실행)
        = INSERT, UPDATE, DELETE에서만 사용이 가능
        = 입고 => INSERT => 재고(자동변경)
        = 출고 => INSERT => 재고(자동변경)
        형식)
            CREATE [OR REPLACE] TRIGGER tri_name
            BEFORE | AFTER (INSERT|UPDATE|DELETE) ON table_name
            FOR EACH ROW--전체 ROW에 대한 처리
            ----------------------------------------------------
            DECLARE
                변수 선언 => 설정할 변수가 없는 경우 (생략 가능)
            BEGIN -- 블록 열리는 부분
                구현부
            END; - 블록 닫히는 부분
            /
            
        = 삭제
            DROP TRIGGER tri_name
        = 수정
            ALTER TRIGGER tri_name ==> OR REPLACE
*/
CREATE TABLE 상품(
    품번 NUMBER,
    상품명 VARCHAR2(30),
    단가 NUMBER
);
CREATE TABLE 입고(
    품번 NUMBER,
    수량 NUMBER,
    금액 NUMBER
);
CREATE TABLE 출고(
    품번 NUMBER,
    수량 NUMBER,
    금액 NUMBER
);
CREATE TABLE 재고(
    품번 NUMBER,
    수량 NUMBER,
    금액 NUMBER,
    누적금액 NUMBER
);
--상품
INSERT INTO 상품 VALUES(100,'새우깡',1500);
INSERT INTO 상품 VALUES(200,'감자깡',1000);
INSERT INTO 상품 VALUES(300,'맛동산',2000);
INSERT INTO 상품 VALUES(400,'포카칩',1500);
INSERT INTO 상품 VALUES(500,'눈을감자',2500);
COMMIT;
-- 입고시에 재고를 처리
/*
    입고 ==> 재고 (상품이 존재하는지 확인)
            존재 : UPDATE
            미존재 : INSERT
    출고 ==> 재고 (상품의 갯수가 몇개?)
            0 => DELETE
            >0 => UPDATE
            
            => INSERT, UPDATE, DELETE => :NEW.품번
                INSERT INTO 입고 VALUES(100,10,1500)
                                       --- --  -----
                                       :NEW.품번
                                       :NEW.수량
                                       :NEW.금액 
            => 재고 테이블에 있는 기존의 컬럼값 읽기 
                                        :OLD.품번
*/
CREATE OR REPLACE TRIGGER input_trigger
AFTER INSERT ON 입고
FOR EACH ROW
DECLARE
    v_cnt NUMBER:=0;
BEGIN
    SELECT COUNT(*) INTO v_cnt
    FROM 재고
    WHERE 품번=:NEW.품번; -- :NEW 
    
    IF v_cnt=0 THEN
    --INSERT
    INSERT INTO 재고 VALUES(:NEW.품번,:NEW.수량,:NEW.금액,:NEW.수량*:NEW.금액);
    ELSE
    --UPDATE
    UPDATE 재고 SET
    수량 = 수량+:NEW.수량,
    누적금액=누적금액+(:NEW.수량*:NEW.금액)
    WHERE 품번=:NEW.품번;
    --주의점 : 
    END IF;
END;
/

INSERT INTO 입고 VALUES(100,3,1500);
SELECT * FROM 입고;
SELECT * FROM 재고;

--출고 : UPDATE/DELETE
CREATE OR REPLACE TRIGGER output_trigger
AFTER INSERT ON 출고
FOR EACH ROW
DECLARE
 v_cnt NUMBER:=0;
BEGIN
 SELECT 수량 INTO v_cnt
 FROM 재고
 WHERE 품번=:NEW.품번;
 
 IF :NEW.수량=v_cnt THEN
 -- 처리 => 재고가 없는 상태 => DELETE
    DELETE FROM 재고
    WHERE 품번=:NEW.품번;
 ELSE
 -- 처리 => 수량-:NEW.수량, 누적금액-:NEW.. => UPDATE
    UPDATE 재고 SET
    수량=수량-:NEW.수량,
    누적금액=누적금액-(:NEW.수량*:NEW.금액)
    WHERE 품번=:NEW.품번;
 END IF;
END;
/

SELECT * FROM 재고;
INSERT INTO 출고 VALUES(100,4,1500);
DESC seoul_nature;
DESC seoul_shop;
DESC seoul_guest;
DESC seoul_hotel;

DESC food_location;

SELECT fno,name,poster,score,num
FROM (SELECT fno,name,poster,score,rownum as num
FROM (SELECT /*+ INDEX_ASC(food_location pk_food_location)*/ fno,name,poster,score
FROM food_location))
WHERE num BETWEEN 21 AND 40;