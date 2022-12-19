/*
    1. DBMS�� ����
       => �ʿ��� �����͸� ��Ƽ� �����ϰ� ���� ������ ����
    2. DBMS���� �ϴ� ����
       => �˻�(�߰�, ����, ����, �˻�) ==> DML
    3. DBMS���� =>
       => �ߺ� �ּ�ȭ(����ȭ)
       => �ϰ��� ����, ������ ����
    4. SQL�� ����
       => DQL : SELECT => ������ ����
                => JOIN�� ���� (inner JOIN / outer JOIN)
                => SUBQUERY�� ���� (�ζ��κ�, ��Į�� ��������)
       => DML : INSERT, UPDATE, DELETE => ������ ����
       => DCL : GRANT, REVOKE => ��������
       => DDL : CREATE, DROP, ALTER, TRUNCATE, RENAME => ����
       => TCL : COMMIT, ROLLBACK
                Ʈ������ : �ϰ�ó��
    5. RELATION : ���̺�
       => 2���� ����
          -------------
          �÷���(�Ӽ�) ...
          -------------
          ��....         => ROW(record) => �� (���� ����)
          -------------
          ������ ���Ἲ => �ߺ��� ���� ���� �����ϱ� (PK)
    6. SQL�� ����
*/
-- �����ͺ��̽� : ���� => DESC ���̺�� 
DESC book;
DESC customer;
DESC orders;
SELECT * FROM book WHERE publisher='���ѹ̵��';
/*
BOOKID    NOT NULL NUMBER(2)    
BOOKNAME           VARCHAR2(40) 
PUBLISHER          VARCHAR2(40) 
PRICE              NUMBER(8)  

1) DQL : SELECT (�˻� �� ����)
         ����) 
         SELECT * | Column1,Column2...
         FROM table_name|view_name|(SELECT~)
         {
            WHERE ������(������,�Լ�)
            GROUP BY �÷���|�Լ�
            HAVING �Լ�(�����Լ�)
            ORDER BY �÷���|�Լ�
         }
2) DML
3) DDL
4) TCL

*/
/*

-- [���� 3-1] ��� ������ �̸��� ������ �˻��Ͻÿ�.
SELECT bookname,price
FROM book;

-- [���� 3-2] ��� ������ ������ȣ, �����̸�, ���ǻ�, ������ �˻��Ͻÿ�.
SELECT bookid,bookname,publisher,price
FROM book;

-- [���� 3-3] ���� ���̺� �ִ� ��� ���ǻ縦 �˻��Ͻÿ�.
SELECT publisher
FROM book;

-- [���� 3-4] ������ 20,000�� �̸��� ������ �˻��Ͻÿ�.
SELECT bookname
FROM book
WHERE price<20000;

-- [���� 3-5] ������ 10,000�� �̻� 20,000 ������ ������ �˻��Ͻÿ�.
SELECT bookname
FROM book
WHERE price BETWEEN 10000 AND 20000;

-- [���� 3-6] ���ǻ簡 ���½������� Ȥ�� �����ѹ̵� �� ������ �˻��Ͻÿ�.
SELECT bookname
FROM book
WHERE publisher='�½�����' OR publisher='���ѹ̵��';


-- [���� 3-7] ���౸�� ���硯�� �Ⱓ�� ���ǻ縦 �˻��Ͻÿ�.
SELECT publisher FROM book
WHERE bookname='�౸�� ����';


-- [���� 3-8] �����̸��� ���౸�� �� ���Ե� ���ǻ縦 �˻��Ͻÿ�.


--[���� 3-9] �����̸��� ���� �� ��° ��ġ�� ��������� ���ڿ��� ���� ������ �˻��Ͻÿ�.


--[���� 3-10] �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��Ͻÿ�.


--[���� 3-11] ���ǻ簡 ���½������� Ȥ�� �����ѹ̵� �� ������ �˻��Ͻÿ�.





--[���� 3-12] ������ �̸������� �˻��Ͻÿ�. 



--[���� 3-13] ������ ���ݼ����� �˻��ϰ�, ������ ������ �̸������� �˻��Ͻÿ�.
SELECT bookname,publisher,price
FROM book
ORDER BY price, bookname; ==> ���� ���� �ִ� ��쿡�� ó��

--[���� 3-14] ������ ������ ������������ �˻��Ͻÿ�. ���� ������ ���ٸ� ���ǻ��� ������������ ����Ͻÿ�.


DESC orders;
ORDERID   NOT NULL NUMBER(2) 
CUSTID             NUMBER(2) 
BOOKID             NUMBER(2) 
SALEPRICE          NUMBER(8) 
ORDERDATE          DATE     
--[���� 3-15] ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
=> �����Լ�
COLUMN ��ü�� ���
SELECT SUM(saleprice)
FROM orders;

--[���� 3-16] 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice)
FROM orders
WHERE name=2;


--[���� 3-17] ���� �ֹ��� ������ �� �Ǹž�, ��հ�, ������, �ְ��� ���Ͻÿ�.
SELECT SUM(saleprice), AVG(saleprice), MIN(saleprice),MAX(saleprice)
FROM orders;

--[���� 3-18] ���缭���� ���� �Ǹ� �Ǽ��� ���Ͻÿ�.
SELECT COUNT(*) FROM orders;

==[���� 3-19] ������ �ֹ��� ������ �� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT (SELECT name FROM customer WHERE custid=orders.custid),COUNT(*),SUM(saleprice)
FROM orders
GROUP BY custid;

SELECT * FROM customer;

--[���� 3-20] ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�. ��, �� �� �̻� ������ ���� ���Ͻÿ�.
SELECT (SELECT name FROM customer WHERE custid=orders.custid),COUNT(*)
FROM orders
WHERE saleprice>=8000
GROUP BY custid
HAVING COUNT(*)>=2;

--[���� 3-21] ���� ���� �ֹ��� ���� �����͸� ��� ���̽ÿ�.
        JOIN : customer/orders
        ------ �Ѱ� �̻��� ���̺� �ʿ��� �����͸� �����ϴ� ���
        INNER JOIN => ������(������ ��� => NULL���� ��쿡 ó���� ���Ѵ�) => ���� ���� ����
        = EQUI_JOIN
            SELECT A.col,B.col
            FROM A,B
            WHERE A.col=B.col
            ---------------
            SELECT A.col,B.col
            FROM A JOIN B
            ON A.col=B.col
        
        = NON_EQUI_JOIN(���� => ������)
            SELECT A.col,B.col
            FROM A,B
            WHERE A.col BETWEEN �� AND ��
            ---------------
            SELECT A.col,B.col
            FROM A JOIN B
            ON A.col BETWEEN �� AND ��
        
        SELECT *
        FROM customer c,orders o
        WHERE c.custid=o.custid;
        
        ----------------------------
        SELECT * 
        FROM customer c NATURAL JOIN orders o;
        
        SELECT *
        FROM customer c JOIN orders o USING(custid);
        -------------------------------------------- ���̺��� ���� �÷����� �����ؾ� ����Ѵ�
        *** �񱳽ÿ� �÷����� �ٸ� �� �ִ� (���� ���� ������ ������ �ȴ�)
--[���� 3-22] ���� ���� �ֹ��� ���� �����͸� ������ �����Ͽ� ���̽ÿ�.
SELECT *
FROM customer c,orders o
WHERE c.custid=o.custid
ORDER BY c.custid;

--[���� 3-23] ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
SELECT name,(SELECT bookname FROM book WHERE bookid=o.bookid) bookname,saleprice
FROM customer c,orders o
WHERE c.custid=o.custid
ORDER BY c.custid;
==> �ڹٿ����� Ŭ���� �ȿ� Ŭ������ �����ؼ� �о�� �����͸� ����(VO)

--[���� 3-24] ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
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


--[���� 3-25] ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�. 
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
--[���� 3-26] ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
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


--[���� 3-27] ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���Ͻÿ�.
SELECT name,saleprice,(SELECT bookname FROM book WHERE bookid=o.bookid) bookname
FROM customer c, Orders o
WHERE c.custid=o.custid(+);

SELECT name,saleprice,(SELECT bookname FROM book WHERE bookid=o.bookid) bookname
FROM customer c LEFT OUTER JOIN orders o
ON c.custid=o.custid;


--[���� 3-28] ���� ��� ������ �̸��� ���̽ÿ�.
SELECT bookname,price
FROM book
WHERE price=(SELECT MAX(price) FROM book);

--29 ������ ������ ���� �ִ� ���� �̸��� �˻�
���������� �� ���̵�
SELECT DISTINCT custid FROM orders;

SELECT name
FROM customer
WHERE custid IN(SELECT DISTINCT custid FROM orders);

--[���� 3-30] �����ѹ̵����� ������ ������ ������ ���� �̸��� ���̽ÿ�.
SELECT bookid
FROM book 
WHERE publisher='���ѹ̵��';

SELECT custid
FROM orders
WHERE bookid IN(SELECT bookid
FROM book 
WHERE publisher='���ѹ̵��');

SELECT name
FROM customer
WHERE custid IN(SELECT custid
FROM orders
WHERE bookid IN(SELECT bookid
FROM book 
WHERE publisher='���ѹ̵��'));



--[���� 3-31] ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�. 
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



--[���� 3-32] ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�. 
SELECT name
FROM customer;

SELECT name
FROM customer
WHERE custid NOT IN(SELECT custid FROM orders);


--[���� 3-33] �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
SELECT name,address
FROM customer
WHERE custid IN(SELECT custid FROM orders);

--MINUS, INTERSECT, UNION, UNION ALL => ���տ�����
A   B
1   3
2   4
3   5
4   6
5   7
---- INTERSECT : 3,4,5 (������) => INNER JOIN
     UNION : 1,2,3,4,5,6,7 => �ΰ��� ���ļ� ������ �б� => �ߺ� ����
     UNION ALL : 1,2,3,4,5,3,4,5,6,7 => �ߺ� ���� ���� ��� ������ �б�
     MINUS
        A-B => 1,2
        B-A => 6,7
--[���� 3-34] Customer ���̺��� ����ȣ�� 5�� ���� �ּҸ� �����ѹα� �λꡯ���� �����Ͻÿ�.
UPDATE customer SET(address)='���ѹα� �λ�' WHERE custid=5;
SELECT * FROM customer;

UPDATE table_name SET(�÷���)=��
DELETE FROM table_name ==> ��ü ����
DELETE FROM table_name WHERE ~~ => ���ǿ� �´� ROW�� ����


--[���� 3-35] Customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����Ͻÿ�.
UPDATE customer SET(address)=(SELECT address FROM customer WHERE name='�迬��') WHERE name='�ڼ���';
SELECT * FROM customer;

--[���� 3-36] Customer ���̺��� ����ȣ�� 5�� ���� ������ �� ����� Ȯ���Ͻÿ�.
DELETE FROM customer WHERE custid=5;
SELECT * FROM customer;
--[���� 3-37] ��� ���� �����Ͻÿ�.
1. �����ϰ� �ִ� ���̺��� ���� ����
2. ���̺� ����
3. ���̺����� => ON DELETE CASCADE
DELETE FROM orders;
DELETE FROM customer;
ROLLBACK;

INSERT INTO customer(custid,name,address) VALUES(5,'�ڼ���','���ѹα� ����');
*/