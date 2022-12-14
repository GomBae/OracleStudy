SELECT * FROM book; -- å����
SELECT * FROM customer; --����� ����
SELECT * FROM orders;--å�Ǹ�

DESC book;
/*
BOOKID    NOT NULL NUMBER(2)    ==> å ����
BOOKNAME           VARCHAR2(40) ==> å �̸�
PUBLISHER          VARCHAR2(40) ==> ���ǻ�
PRICE              NUMBER(8)   ==> ����
*/
DESC customer;

/*
CUSTID  NOT NULL NUMBER(2)    ==> ����ȣ(������)
NAME             VARCHAR2(40) ==> ���̸�
ADDRESS          VARCHAR2(50) ==> �ּ�
PHONE            VARCHAR2(20) ==> ��ȭ��ȣ
*/
DESC orders;
/*
ORDERID   NOT NULL NUMBER(2) ==> �ֹ���ȣ(������)
CUSTID             NUMBER(2) ==> �����(����)
BOOKID             NUMBER(2) ==> å (����)
SALEPRICE          NUMBER(8) ==> ���űݾ�
ORDERDATE          DATE   ==> ���ų�¥
*/
SELECT name,address,phone,saleprice,orderdate,bookname,publisher,price
FROM customer,orders,book
WHERE customer.custid=orders.custid
AND book.bookid=orders.bookid;

-- View ���� => SQL������ ����
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
    1. TABLE : �����͸� �����ϴ� ����
                SELECT / INSERT / UPDATE / DELETE
                CREATE / DROP / ALTER / RENAME / TRUNCATE
                ------ �������� 
                NOT NULL : NULL �Ұ�
                PRIMARY KEY : �⺻Ű (ROW�� �����ϴ� ������) => ����/������ �����Ͱ� �����Ǵ°� �����ؾ���
                FOREIGN KEY : ����Ű (���� ���� ���� ���̺�� ���� ����)
                --------------------------------------------------
                PRIMARY KEY <===================> FOREIGN KEY
                                     1:N
                UNIQUE : �ߺ��� ���� �� , NULL ���
                CHECK : ������ ���� ���� �� �ִ�
                DEFAULT : ���������� �ƴϴ� => ���� �Է����� �ʴ� ��� => �ڵ�����
                *** ��������
                    NOT NULL, DEFAULT ==> �÷� �ڿ� ����
                    CHECK, PK,FK,UQ => �÷������� ���� ������ ����
                    CREATE TABLE table��(
                        �÷��� �������� [��������] NN, DEFAULT,
                        �÷��� �������� [��������],
                        �÷��� �������� [��������],
                        [��������] => CHECK,PK,FK,UQ
                    )
    2. VIEW : ������ ���̺��� ���� 
        => �Ѱ� (�ܼ���) => DML ����� ����
        => ������ (���պ�) ==> JOIN, SUBQUERY ==> ���� : DML�� ������ ����
           ---------------------------------------------------------- SQL������ ����� ������ ����
        => �����Ͱ� ������ �Ǿ��ִ°� �ƴϱ� ������ ������ ���� (SQL���� ����Ǿ�����)
        => �ζ��κ� : ���̺��� SELECT�� �̿��ؼ� ������ ���� => TOP-N, ����¡ 
        => VIEW�� ����Ǵ� ��ġ => user_views , user_tables, user_constraints
        => ������ ���ÿ� ����
           CREATE OR REPLACE VIEW view_name
           AS
           SELECT ~~ 
        => ����
            DROP VIEW view_name
        *** ����, �ڹ����α׷����� ������ SQL������ �ܼ�ȭ
    3. SEQUENCE : �ڵ� ���� ��ȣ
        1) ����
            => �����ø��� ���� ��ȣ�� �����ȴ� : PK(��ȣ) => MAX()+1
            CREATE SEQUENCE seq_name ==> ���̺��_�÷���_seq
                START WITH
                INCREMENT BY
                NOCYCLE ==> ���Ѵ�
                NOCACHE ==> �������� �ʰ� �ٷ� ����
        2) ����
            DROP SEQUENCE seq_name
        3) ���� ����� �� : currVal
        4) ������ : nextVal
*/