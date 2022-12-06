--2022-12-06 ����Ŭ �����Լ�
--�����Լ� , GROUP BY, HAVING
-- JOIN, SUBQUERY
-- DDL => DML
-- VIEW, SEQUENCE, INDEX
-- PL/SQL
-- �����ͺ��̽� �𵨸�
/*
    �����Լ�, ����� ���� �Լ�(PL/SQL) => ��ü���� �ٸ���
    ------ ����Ŭ���� �����ϴ� �Լ�
      |
    �������Լ� �������Լ�
    ------------------ ���ó ��) COUNT -> �α���
    ������ �Լ�
    ---------
      1) ����Ŭ���� �����ϴ� ��������
      --------------------------
      ������ / ������ / ��¥�� / ��Ÿ��
      
      2) ���������� �°� �Լ� ����
         1) �����Լ� => String
            => ��ȯ�Լ�
               1. UPPER() => �빮�ں�ȯ
               2. LOWER() => �ҹ��ں�ȯ
               3. INITCAP() =>�̴ϼ� ����
                  INITCAP("ABC") => Abc
                  
            => �����Լ�
               1. SUBSTR()
               2. INSTR() =>indexOf()
               3. REPLACE()
               4. TRIM() ==> LTRIM(), RTRIM()
               5. PAD() ==> LPAD(), RPAD()
                                    ------- ���̵�ã�� 
                                           admin => ad***
               6. LENGTH()
            
            => ���Խ�
         2) �����Լ� => Math
         3) ��¥�Լ� => Date,Calendar
         4) ��ȯ�Լ� => Format
         5) ��Ÿ�Լ� => 
*/
--�빮��, �ҹ���, �̴ϼ� ���
SELECT ename "����� ������", UPPER (ename) "�빮��", LOWER (ename) "�ҹ���", INITCAP(ename) "�̴ϼ�"
FROM emp;

--SELECT INITCAP('hello java!!') FROM DUAL;
--LENGTH => ���ڰ���, LENGTHB => ������ BYTE��
SELECT ename,LENGTH(ename),LENGTHB(ename) FROM emp;
--�ѱ��� ���ڴ� 3byte(����Ŭ������)
SELECT ename
FROM emp
WHERE LENGTH(ename) BETWEEN 4 AND 5;

--REPLACE : ����, ���ڿ� ����
-- ||, &
SELECT REPLACE('Hello Java&Spring','&','^') FROM DUAL;
SELECT REPLACE('Hello Java','a','b') FROM DUAL;
SELECT REPLACE('Hello Java','Java','Spring') FROM DUAL;
-- SUBSTR : ���ڿ��� �ڸ��� ��쿡 ��� (substring())
--- 1������ ����
/*
    HELLO JAVA
    0123456789 ==> �ڹ�
    HELLO JAVA
    12345678910 ==> ����Ŭ
*/
SELECT SUBSTR('Hello Java',1,1) FROM DUAL;
--81�⿡ �Ի��� ��� ���
SELECT ename,hiredate
FROM emp
WHERE SUBSTR(hiredate,1,2)=81;

--12���� �Ի��� ��� �̸�,�Ի���
SELECT ename,hiredate
FROM emp
WHERE SUBSTR(hiredate,4,2)=12;

SELECT ename,SUBSTR(hiredate,7,2)
FROM emp;

SELECT ename,SUBSTR(hiredate,-2,2)
FROM emp;
/*
    81 /12 /01
    123 45 678
           -3 -2 -1
*/
/*SELECT SUBSTR(hiredate,1,2), SUM(sal),ROUND(AVG(sal),1)
FROM emp
GROUP BY SUBSTR(hiredate,1,2)
ORDER BY SUBSTR(hiredate,1,2) DESC;
*/
--LPAD / RPAD => ���ڼ��� ���� Ư�����ڸ� ���
SELECT LPAD('Hello Oracle',15,'#'),RPAD('Hello Oracle',15,'#') FROM DUAL;
SELECT ename,RPAD(SUBSTR(ename,1,2),LENGTH(ename),'*') FROM emp;
-- ��й�ȣ => �缳��, �̸��� ����(JavaMail)
-- trim() (�¿�), LTRIM(),RTRIM => ������ ���ڸ� ���� => ���ڸ� �������� ������ ����
SELECT LTRIM('AAABBBCCC','A'),RTRIM('AAABBBCCC','C') FROM DUAL;
SELECT TRIM('A' FROM 'AAABBBAAA') FROM DUAL;
-- CONCAT
SELECT CONCAT('Hello ','Java') FROM DUAL;
SELECT 'Hello ' || 'Java' FROM DUAL;
-- INSTR => indexOf()
SELECT ename, INSTR(ename,'A',1,2) FROM emp; --indexOf
SELECT INSTR('Hello Java','l',-1,1) FROM DUAL; -- lastIndexOf