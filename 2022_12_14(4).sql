SELECT * FROM book; -- 책정보
SELECT * FROM customer; --사용자 정보
SELECT * FROM orders;--책판매

DESC book;
/*
BOOKID    NOT NULL NUMBER(2)    ==> 책 구분
BOOKNAME           VARCHAR2(40) ==> 책 이름
PUBLISHER          VARCHAR2(40) ==> 출판사
PRICE              NUMBER(8)   ==> 가격
*/
DESC customer;

/*
CUSTID  NOT NULL NUMBER(2)    ==> 고객번호(구분자)
NAME             VARCHAR2(40) ==> 고객이름
ADDRESS          VARCHAR2(50) ==> 주소
PHONE            VARCHAR2(20) ==> 전화번호
*/
DESC orders;
/*
ORDERID   NOT NULL NUMBER(2) ==> 주문번호(구분자)
CUSTID             NUMBER(2) ==> 사용자(구분)
BOOKID             NUMBER(2) ==> 책 (구분)
SALEPRICE          NUMBER(8) ==> 구매금액
ORDERDATE          DATE   ==> 구매날짜
*/
SELECT name,address,phone,saleprice,orderdate,bookname,publisher,price
FROM customer,orders,book
WHERE customer.custid=orders.custid
AND book.bookid=orders.bookid;

-- View 제작 => SQL문장을 저장
CREATE OR REPLACE VIEW book_all
AS
SELECT name,address,phone,saleprice,orderdate,bookname,publisher,price
FROM customer,orders,book
WHERE customer.custid=orders.custid
AND book.bookid=orders.bookid;

SELECT * FROM book_all;

SELECT text FROM user_views WHERE view_name='BOOK_ALL';
DROP VIEW book_all;
/*
    1. TABLE : 데이터를 저장하는 공간
                SELECT / INSERT / UPDATE / DELETE
                CREATE / DROP / ALTER / RENAME / TRUNCATE
                ------ 제약조건 
                NOT NULL : NULL 불가
                PRIMARY KEY : 기본키 (ROW를 구분하는 데이터) => 수정/삭제시 데이터가 변질되는걸 방지해야함
                FOREIGN KEY : 참조키 (같은 값을 가진 테이블과 연결 가능)
                --------------------------------------------------
                PRIMARY KEY <===================> FOREIGN KEY
                                     1:N
                UNIQUE : 중복이 없는 값 , NULL 허용
                CHECK : 지정된 값만 들어올 수 있다
                DEFAULT : 제약조건은 아니다 => 값을 입력하지 않는 경우 => 자동설정
                *** 제약조건
                    NOT NULL, DEFAULT ==> 컬럼 뒤에 설정
                    CHECK, PK,FK,UQ => 컬럼설정이 끝난 다음에 설정
                    CREATE TABLE table명(
                        컬럼명 데이터형 [제약조건] NN, DEFAULT,
                        컬럼명 데이터형 [제약조건],
                        컬럼명 데이터형 [제약조건],
                        [제약조건] => CHECK,PK,FK,UQ
                    )
    2. VIEW : 기존의 테이블을 참조 
        => 한개 (단순뷰) => DML 사용이 가능
        => 여러개 (복합뷰) ==> JOIN, SUBQUERY ==> 단점 : DML에 제약이 있음
           ---------------------------------------------------------- SQL문장을 만들어 저장후 재사용
        => 데이터가 저장이 되어있는게 아니기 때문에 보안이 좋다 (SQL문이 저장되어있음)
        => 인라인뷰 : 테이블대신 SELECT를 이용해서 데이터 추출 => TOP-N, 페이징 
        => VIEW가 저장되는 위치 => user_views , user_tables, user_constraints
        => 수정과 동시에 생성
           CREATE OR REPLACE VIEW view_name
           AS
           SELECT ~~ 
        => 삭제
            DROP VIEW view_name
        *** 보안, 자바프로그램에서 복잡한 SQL문장을 단순화
    3. SEQUENCE : 자동 증가 번호
        1) 생성
            => 생성시마다 따로 번호가 증가된다 : PK(번호) => MAX()+1
            CREATE SEQUENCE seq_name ==> 테이블명_컬럼명_seq
                START WITH
                INCREMENT BY
                NOCYCLE ==> 무한대
                NOCACHE ==> 저장하지 않고 바로 증가
        2) 삭제
            DROP SEQUENCE seq_name
        3) 현재 저장된 값 : currVal
        4) 다음값 : nextVal
*/