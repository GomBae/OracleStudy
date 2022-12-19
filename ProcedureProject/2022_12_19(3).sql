-- ���ν��� : ���
-- �������� ���� �Լ�, �ڹ��� �޼ҵ� (���ν����� �ش�ȴ�) => PL
/*
    = ������ ������ �Լ�(��)
                      ---- �Խ���, ���, ����¡, ���, ����, ��õ
    
    ����)
        CREATE [OR REPLACE] PROCEDURE pro_name(
            �Ű�����
        )
        IS
            ��������
        BEGIN
            ������
        END;
        /
*/
DROP TABLE student;
CREATE TABLE student(
    hakbun NUMBER,
    name VARCHAR2(34) CONSTRAINT std_name_nn NOT NULL,
    kor NUMBER(3),
    eng NUMBER(3),
    math NUMBER(3),
    CONSTRAINT std_hakbun_pk PRIMARY KEY(hakbun),
    CONSTRAINT std_kor_ck CHECK(kor>=0),
    CONSTRAINT std_eng_ck CHECK(eng>=0),
    CONSTRAINT std_math_ck CHECK(math>=0)
);
-- INSERT
/*
    IN : INSERT,UPDATE,DELETE => ���� �����Ҷ� ����ϴ� ���� => �Ϲ� ���� (Call By Value)
        ==> �޸� �ּҰ� �ٸ� ���
    OUT : SELECT => ���� �Ű������� �̿��ؼ� ������ ���� ���� => ���� ���� (Call By Reference)
        ==> ���� �޸� �ּҸ� �̿��Ѵ�
*/
CREATE OR REPLACE PROCEDURE studentInsert(
    pName IN student.name%TYPE,
    pKor IN student.kor%TYPE,
    pEng IN student.eng%TYPE,
    pMath IN student.math%TYPE
)
IS
    pMax NUMBER:=0;
BEGIN
    SELECT NVL(MAX(hakbun)+1,1) INTO pMax
    FROM student;
    
    INSERT INTO student VALUES(pMax,pName,pKor,pEng,pMath);
    COMMIT;
END;
/
--÷��
CALL studentInsert('ȫ�浿',90,89,78);
CALL studentInsert('��û��',89,78,67);
SELECT * FROM student;
-- UPDATE 
CREATE OR REPLACE PROCEDURE studentUpdate(
    pHakbun IN student.hakbun%TYPE,
    pName IN student.name%TYPE,
    pKor IN student.kor%TYPE,
    pEng IN student.eng%TYPE,
    pMath IN student.math%TYPE
)
IS
BEGIN
    UPDATE student SET
    name=pName,kor=pKor,eng=pEng,math=pMath
    WHERE hakbun=pHakbun;
    COMMIT;
END;
/

CALL studentUpdate(1,'ȫ�浿',100,90,90);
SELECT * FROM student;
-- DELETE
CREATE OR REPLACE PROCEDURE studentDelete(
    pHakbun IN student.hakbun%TYPE
)
IS
BEGIN
    DELETE FROM student
    WHERE hakbun=pHakbun;
    COMMIT;
END;
/
CALL studentDelete(1);
SELECT * FROM student;
-- SELECT
CREATE OR REPLACE PROCEDURE studentDetailData(
    pHakbun student.hakbun%TYPE,
    pName OUT student.name%TYPE,
    pKor OUT student.kor%TYPE,
    pEng OUT student.eng%TYPE,
    pMath OUT student.math%TYPE,
    pTotal OUT NUMBER,
    pAvg OUT NUMBER
)
IS
BEGIN
    SELECT name,kor,eng,math,(kor+eng+math),ROUND((kor+eng+math)/3) INTO pName,pKor,pEng,pMath,pTotal,pAvg
    FROM student
    WHERE hakbun=pHakbun;
END;
/
/*
VARIABLE pName VARCHAR2(34);
VARIABLE pKor NUMBER;
VARIABLE pEng NUMBER;
VARIABLE pMath NUMBER;
VARIABLE pTotal NUMBER;
VARIABLE pAvg NUMBER;

EXECUTE studentDetailData(2,:pName,:pKor,:pEng,:pMath,:pTotal,:pAvg);
PRINT pName;
PRINT pKor;
*/
CREATE OR REPLACE PROCEDURE studentListData(
    pResult OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN pResult FOR
    SELECT * FROM student;
END;
/