/*
    = VIEW : ���� ���̺� (������ ���̺��� �����ؼ� ���)
            1�� ��� : �ܼ���
            ������ ��� : ���պ�
            -------------------- �信�� SQL���常 ���� => ������ ����
            �ζ��κ�
            => �������, ����
            => user_views(view�� �����ϰ� �ִ� ���̺�)
            => CREATE VIEW view_name
                AS
                SELECT~~
            => CREATE OR REPLACE VIEW view_name
                AS
                SELECT~~
            => SELECT ~~ 
                FROM (SELECT~~)
            => DROP VIEW view_name
            => VIEW�� ������ Ȯ��
                SELECT text FROM user_views WHERE view_name='�빮��';
    = SEQUENCE : �ڵ� ���� ��ȣ PK => ��ȣ����
                => ����
                    CREATE SEQUENCE seq_name
                    START WITH 1
                    INCREMENT BY 1
                    NOCACHE
                    NOCYCLE
                => ���б�
                    ���簪 : currVal
                    ������ : nextVal
                => ����
                    DROP SEQUENCE seq_name
    --------------------------------------------------------------
    = SYNONYM : ���̺��� ��Ī ==> �ǹ�(���Ǿ�)
        = ����
          CREATE SYNONYM ��Ī��
          FOR ���̺�
        = ����
          DROP SYNONYM ��Ī��
    = INDEX
    = PL/SQL : FUNCTION, PROCEDURE / TRIGGER
*/
/*
    ���� �ο�
    system/happy => �������� ����
    GRANT CREATE FUNCTION TO hr;
    
    ���� ���
    REVOKE CREATE FUNCTION FROM hr;
*/
CREATE SYNONYM �������
FOR emp;

SELECT * FROM �������;
DROP SYNONYM �������;

DESC food_location;

SELECT name,hit FROM food_location ORDER BY hit DESC;
SELECT CEIL(COUNT(*)/20.0) FROM food_location;