/*
    1. %TYPE : ���� ���̺� ������ ���������� �о�´�
        vEmpno emp.empno%TYPE
    2. %ROWTYPE : ���̺��� ��ü�� ���������� ������ �ö� ==> ~VO
        => �Ѱ��� ���̺� �÷� (JOIN,Subquery�� ����� �� ���� ��쵵 �ִ�)
            ���̺��%ROWTYPE
    3. RECORD : ����� ���� (���̺� �������� ��� ������ ����)
       ------ JOIN / Subquery
       ����) TYPE ������ IS RECORD(
                �ʿ��� ������ ����
            )
    4. CURSOR : ��ü ROW�� ���� �����͸� ������ �� �ִ� ���� (�ڹ� => ResultSet)
       ����) 
            CURSOR cur�� IS
            SELECT ~~ => VIEW�� ����
    
    ���ν���
        CREATE [OR REPLACE] PROCEDURE pro_name(
            �Ű�����
        )
        IS | AS
            ��������
        BEGIN
            ������ : SQL
        END;
        /
        
    ����� ���� �Լ� => ���������� ��ü (SELECT, WHERE)
    CREATE [OR REPLACE] FUNCTION func_name(
        �Ű�����
    ) RETURN ��������
    IS | AS 
        ��������
    BEGIN
        ������
        RETURN ��
    END;
    /
    
    = Ʈ����
        = �ڵ� �̺�Ʈ ó��
        = �̸� ������ ���ǿ� �´� ��� �ڵ����� ���� (����Ŭ ��ü���� ����)
        = INSERT, UPDATE, DELETE������ ����� ����
        = �԰� => INSERT => ���(�ڵ�����)
        = ��� => INSERT => ���(�ڵ�����)
        ����)
            CREATE [OR REPLACE] TRIGGER tri_name
            BEFORE | AFTER (INSERT|UPDATE|DELETE) ON table_name
            FOR EACH ROW--��ü ROW�� ���� ó��
            ----------------------------------------------------
            DECLARE
                ���� ���� => ������ ������ ���� ��� (���� ����)
            BEGIN -- ��� ������ �κ�
                ������
            END; - ��� ������ �κ�
            /
            
        = ����
            DROP TRIGGER tri_name
        = ����
            ALTER TRIGGER tri_name ==> OR REPLACE
*/
CREATE TABLE ��ǰ(
    ǰ�� NUMBER,
    ��ǰ�� VARCHAR2(30),
    �ܰ� NUMBER
);
CREATE TABLE �԰�(
    ǰ�� NUMBER,
    ���� NUMBER,
    �ݾ� NUMBER
);
CREATE TABLE ���(
    ǰ�� NUMBER,
    ���� NUMBER,
    �ݾ� NUMBER
);
CREATE TABLE ���(
    ǰ�� NUMBER,
    ���� NUMBER,
    �ݾ� NUMBER,
    �����ݾ� NUMBER
);
--��ǰ
INSERT INTO ��ǰ VALUES(100,'�����',1500);
INSERT INTO ��ǰ VALUES(200,'���ڱ�',1000);
INSERT INTO ��ǰ VALUES(300,'������',2000);
INSERT INTO ��ǰ VALUES(400,'��īĨ',1500);
INSERT INTO ��ǰ VALUES(500,'��������',2500);
COMMIT;
-- �԰�ÿ� ��� ó��
/*
    �԰� ==> ��� (��ǰ�� �����ϴ��� Ȯ��)
            ���� : UPDATE
            ������ : INSERT
    ��� ==> ��� (��ǰ�� ������ �?)
            0 => DELETE
            >0 => UPDATE
            
            => INSERT, UPDATE, DELETE => :NEW.ǰ��
                INSERT INTO �԰� VALUES(100,10,1500)
                                       --- --  -----
                                       :NEW.ǰ��
                                       :NEW.����
                                       :NEW.�ݾ� 
            => ��� ���̺� �ִ� ������ �÷��� �б� 
                                        :OLD.ǰ��
*/
CREATE OR REPLACE TRIGGER input_trigger
AFTER INSERT ON �԰�
FOR EACH ROW
DECLARE
    v_cnt NUMBER:=0;
BEGIN
    SELECT COUNT(*) INTO v_cnt
    FROM ���
    WHERE ǰ��=:NEW.ǰ��; -- :NEW 
    
    IF v_cnt=0 THEN
    --INSERT
    INSERT INTO ��� VALUES(:NEW.ǰ��,:NEW.����,:NEW.�ݾ�,:NEW.����*:NEW.�ݾ�);
    ELSE
    --UPDATE
    UPDATE ��� SET
    ���� = ����+:NEW.����,
    �����ݾ�=�����ݾ�+(:NEW.����*:NEW.�ݾ�)
    WHERE ǰ��=:NEW.ǰ��;
    --������ : 
    END IF;
END;
/

INSERT INTO �԰� VALUES(100,3,1500);
SELECT * FROM �԰�;
SELECT * FROM ���;

--��� : UPDATE/DELETE
CREATE OR REPLACE TRIGGER output_trigger
AFTER INSERT ON ���
FOR EACH ROW
DECLARE
 v_cnt NUMBER:=0;
BEGIN
 SELECT ���� INTO v_cnt
 FROM ���
 WHERE ǰ��=:NEW.ǰ��;
 
 IF :NEW.����=v_cnt THEN
 -- ó�� => ��� ���� ���� => DELETE
    DELETE FROM ���
    WHERE ǰ��=:NEW.ǰ��;
 ELSE
 -- ó�� => ����-:NEW.����, �����ݾ�-:NEW.. => UPDATE
    UPDATE ��� SET
    ����=����-:NEW.����,
    �����ݾ�=�����ݾ�-(:NEW.����*:NEW.�ݾ�)
    WHERE ǰ��=:NEW.ǰ��;
 END IF;
END;
/

SELECT * FROM ���;
INSERT INTO ��� VALUES(100,4,1500);
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