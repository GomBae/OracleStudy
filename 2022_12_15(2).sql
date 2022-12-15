/*
    1. DBMS의 개념
       => 필요한 데이터를 모아서 통합하고 서로 공유할 목적
    2. DBMS에서 하는 역할
       => 검색(추가, 수정, 삭제, 검색) ==> DML
    3. DBMS장점 =>
       => 중복 최소화(정규화)
       => 일관성 유지, 독립성 유지
    4. SQL의 종류
       => DQL : SELECT => 데이터 추출
                => JOIN의 종류 (inner JOIN / outer JOIN)
                => SUBQUERY의 종류 (인라인뷰, 스칼라 서브쿼리)
       => DML : INSERT, UPDATE, DELETE => 데이터 제어
       => DCL : GRANT, REVOKE => 권한제어
       => DDL : CREATE, DROP, ALTER, TRUNCATE, RENAME => 생성
       => TCL : COMMIT, ROLLBACK
                트랜젝션 : 일괄처리
    5. RELATION : 테이블
       => 2차원 구조
          -------------
          컬럼명(속성) ...
          -------------
          값....         => ROW(record) => 행 (한줄 단위)
          -------------
          데이터 무결성 => 중복이 없는 값을 설정하기 (PK)
    6. SQL의 기초
*/
-- 데이터베이스 : 구조 => DESC 테이블명 
DESC book;
DESC customer;
DESC orders;
SELECT * FROM book WHERE publisher='대한미디어';
/*
BOOKID    NOT NULL NUMBER(2)    
BOOKNAME           VARCHAR2(40) 
PUBLISHER          VARCHAR2(40) 
PRICE              NUMBER(8)  

1) DQL : SELECT (검색 후 추출)
         형식) 
         SELECT * | Column1,Column2...
         FROM table_name|view_name|(SELECT~)
         {
            WHERE 조건절(연산자,함수)
            GROUP BY 컬럼명|함수
            HAVING 함수(집합함수)
            ORDER BY 컬럼명|함수
         }
2) DML
3) DDL
4) TCL

*/
/*

-- [질의 3-1] 모든 도서의 이름과 가격을 검색하시오.
SELECT bookname,price
FROM book;

-- [질의 3-2] 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
SELECT bookid,bookname,publisher,price
FROM book;

-- [질의 3-3] 도서 테이블에 있는 모든 출판사를 검색하시오.
SELECT publisher
FROM book;

-- [질의 3-4] 가격이 20,000원 미만인 도서를 검색하시오.
SELECT bookname
FROM book
WHERE price<20000;

-- [질의 3-5] 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오.
SELECT bookname
FROM book
WHERE price BETWEEN 10000 AND 20000;

-- [질의 3-6] 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’ 인 도서를 검색하시오.
SELECT bookname
FROM book
WHERE publisher='굿스포츠' OR publisher='대한미디어';


-- [질의 3-7] ‘축구의 역사’를 출간한 출판사를 검색하시오.
SELECT publisher FROM book
WHERE bookname='축구의 역사';


-- [질의 3-8] 도서이름에 ‘축구’ 가 포함된 출판사를 검색하시오.


--[질의 3-9] 도서이름의 왼쪽 두 번째 위치에 ‘구’라는 문자열을 갖는 도서를 검색하시오.


--[질의 3-10] 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.


--[질의 3-11] 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’ 인 도서를 검색하시오.





--[질의 3-12] 도서를 이름순으로 검색하시오. 



--[질의 3-13] 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
SELECT bookname,publisher,price
FROM book
ORDER BY price, bookname; ==> 같은 값이 있는 경우에만 처리

--[질의 3-14] 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 출력하시오.


DESC orders;
ORDERID   NOT NULL NUMBER(2) 
CUSTID             NUMBER(2) 
BOOKID             NUMBER(2) 
SALEPRICE          NUMBER(8) 
ORDERDATE          DATE     
--[질의 3-15] 고객이 주문한 도서의 총 판매액을 구하시오.
=> 집합함수
COLUMN 전체를 통계
SELECT SUM(saleprice)
FROM orders;

--[질의 3-16] 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice)
FROM orders
WHERE name=2;


--[질의 3-17] 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오.
SELECT SUM(saleprice), AVG(saleprice), MIN(saleprice),MAX(saleprice)
FROM orders;

--[질의 3-18] 마당서점의 도서 판매 건수를 구하시오.
SELECT COUNT(*) FROM orders;

==[질의 3-19] 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
SELECT (SELECT name FROM customer WHERE custid=orders.custid),COUNT(*),SUM(saleprice)
FROM orders
GROUP BY custid;

SELECT * FROM customer;

--[질의 3-20] 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 단, 두 권 이상 구매한 고객만 구하시오.
SELECT (SELECT name FROM customer WHERE custid=orders.custid),COUNT(*)
FROM orders
WHERE saleprice>=8000
GROUP BY custid
HAVING COUNT(*)>=2;

--[질의 3-21] 고객과 고객의 주문에 관한 데이터를 모두 보이시오.
        JOIN : customer/orders
        ------ 한개 이상의 테이블에 필요한 데이터를 추출하는 기법
        INNER JOIN => 교집합(연산자 사용 => NULL값일 경우에 처리를 못한다) => 가장 많이 사용됨
        = EQUI_JOIN
            SELECT A.col,B.col
            FROM A,B
            WHERE A.col=B.col
            ---------------
            SELECT A.col,B.col
            FROM A JOIN B
            ON A.col=B.col
        
        = NON_EQUI_JOIN(포함 => 연산자)
            SELECT A.col,B.col
            FROM A,B
            WHERE A.col BETWEEN 값 AND 값
            ---------------
            SELECT A.col,B.col
            FROM A JOIN B
            ON A.col BETWEEN 값 AND 값
        
        SELECT *
        FROM customer c,orders o
        WHERE c.custid=o.custid;
        
        ----------------------------
        SELECT * 
        FROM customer c NATURAL JOIN orders o;
        
        SELECT *
        FROM customer c JOIN orders o USING(custid);
        -------------------------------------------- 테이블에서 같은 컬럼명이 존재해야 사용한다
        *** 비교시에 컬럼명이 다를 수 있다 (같은 값을 가지고 있으면 된다)
--[질의 3-22] 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 보이시오.
SELECT *
FROM customer c,orders o
WHERE c.custid=o.custid
ORDER BY c.custid;

--[질의 3-23] 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT name,(SELECT bookname FROM book WHERE bookid=o.bookid) bookname,saleprice
FROM customer c,orders o
WHERE c.custid=o.custid
ORDER BY c.custid;
==> 자바에서는 클래스 안에 클래스를 포함해서 읽어온 데이터를 저장(VO)

--[질의 3-24] 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT
FROM
WHERE
GROUP BY
ORDER BY

SELECT name,SUM(saleprice)
FROM customer c,orders o
WHERE c.custid=o.custid
GROUP BY c.name
ORDER BY c.name;


--[질의 3-25] 고객의 이름과 고객이 주문한 도서의 이름을 구하시오. 
SELECT name,bookname
FROM customer c,orders o,book b
WHERE c.custid=o.custid
AND o.bookid=b.bookid;

SELECT name,bookname
FROM customer c JOIN orders o
ON c.custid=o.custid
JOIN book b
ON o.bookid=b.bookid;   

DESC book;
--[질의 3-26] 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT name,bookname,price
FROM customer c, book b, orders o
WHERE c.custid=o.custid
AND b.bookid=o.bookid
AND price=20000;

SELECT name,bookname,price
FROM customer c
JOIN orders o
ON c.custid=o.custid
JOIN book b
ON o.bookid=b.bookid
WHERE price=20000;


--[질의 3-27] 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
SELECT name,saleprice,(SELECT bookname FROM book WHERE bookid=o.bookid) bookname
FROM customer c, Orders o
WHERE c.custid=o.custid(+);

SELECT name,saleprice,(SELECT bookname FROM book WHERE bookid=o.bookid) bookname
FROM customer c LEFT OUTER JOIN orders o
ON c.custid=o.custid;


--[질의 3-28] 가장 비싼 도서의 이름을 보이시오.
SELECT bookname,price
FROM book
WHERE price=(SELECT MAX(price) FROM book);

--29 도서를 구매한 적이 있는 고객의 이름을 검색
도서구매한 고객 아이디
SELECT DISTINCT custid FROM orders;

SELECT name
FROM customer
WHERE custid IN(SELECT DISTINCT custid FROM orders);

--[질의 3-30] ‘대한미디어’에서 출판한 도서를 구매한 고객의 이름을 보이시오.
SELECT bookid
FROM book 
WHERE publisher='대한미디어';

SELECT custid
FROM orders
WHERE bookid IN(SELECT bookid
FROM book 
WHERE publisher='대한미디어');

SELECT name
FROM customer
WHERE custid IN(SELECT custid
FROM orders
WHERE bookid IN(SELECT bookid
FROM book 
WHERE publisher='대한미디어'));



--[질의 3-31] 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오. 
SELECT bookname
FROM book
WHERE price>(SELECT AVG(price) FROM book);

SELECT b1.bookname
FROM book b1
WHERE b1.price>


SELECT b1.publisher,b1.bookname
FROM book b1
WHERE b1.price>(SELECT ROUND(AVG(b2.price))
FROM book b2
WHERE b1.publisher=b2.publisher);



--[질의 3-32] 도서를 주문하지 않은 고객의 이름을 보이시오. 
SELECT name
FROM customer;

SELECT name
FROM customer
WHERE custid NOT IN(SELECT custid FROM orders);


--[질의 3-33] 주문이 있는 고객의 이름과 주소를 보이시오.
SELECT name,address
FROM customer
WHERE custid IN(SELECT custid FROM orders);

--MINUS, INTERSECT, UNION, UNION ALL => 집합연산자
A   B
1   3
2   4
3   5
4   6
5   7
---- INTERSECT : 3,4,5 (교집합) => INNER JOIN
     UNION : 1,2,3,4,5,6,7 => 두개를 합쳐서 데이터 읽기 => 중복 제거
     UNION ALL : 1,2,3,4,5,3,4,5,6,7 => 중복 제거 없이 모든 데이터 읽기
     MINUS
        A-B => 1,2
        B-A => 6,7
--[질의 3-34] Customer 테이블에서 고객번호가 5인 고객의 주소를 ‘대한민국 부산’으로 변경하시오.
UPDATE customer SET(address)='대한민국 부산' WHERE custid=5;
SELECT * FROM customer;

UPDATE table_name SET(컬럼명)=값
DELETE FROM table_name ==> 전체 삭제
DELETE FROM table_name WHERE ~~ => 조건에 맞는 ROW만 삭제


--[질의 3-35] Customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.
UPDATE customer SET(address)=(SELECT address FROM customer WHERE name='김연아') WHERE name='박세리';
SELECT * FROM customer;

--[질의 3-36] Customer 테이블에서 고객번호가 5인 고객을 삭제한 후 결과를 확인하시오.
DELETE FROM customer WHERE custid=5;
SELECT * FROM customer;
--[질의 3-37] 모든 고객을 삭제하시오.
1. 참조하고 있는 테이블을 먼저 삭제
2. 테이블 삭제
3. 테이블제작 => ON DELETE CASCADE
DELETE FROM orders;
DELETE FROM customer;
ROLLBACK;

INSERT INTO customer(custid,name,address) VALUES(5,'박세리','대한민국 대전');
*/