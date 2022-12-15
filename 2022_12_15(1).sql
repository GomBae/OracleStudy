/*
    PL/SQL, INDEX
    => 1) SQL����, 2) �ڹ� => ȭ�� ���(������) => HTML
    �ε��� (INDEX) : �ڷḦ ���� ������ ã�� �� �ְ� ���� ������ ����
     = �˻��ÿ� �ӵ� ���
     = �޸𸮰� ���� �ʿ��ϴ�
     = �ڵ����� : UNIQUE,PK => �ε��� 
     
     => �ε��� ����
        => �ñ�
        1) �����Ǵ� ���� ���� ��� (PK)
        2) WHERE ������ ���� �˻��Ǵ� �÷��� �ִ� ���
          => ����, �̸� ... 
        3) JOIN���� �ַ� ���Ǵ� �÷� 
        4) NULL���� �����ϴ� �÷��� ���� ���
        => �ε����� ������ �ʴ� �κ�
        1) INSERT, UPDATE, DELETE�� ���� �κ� => �ε����� ������ ������ ���ϵ�
    => ���� : B*Ʈ��
              ��Ʈ
              
              --------
                  |
        ---------------------- ���η�Ʈ
        |        |          |
        ---     ----       ---  ������Ʈ
    
    1) ����
       => PK,UQ => �ڵ�����
       => ����
          CREATE INDEX index�� ON ���̺��(�÷���) => �÷��� (ASC), �÷��� DESC
          CREATE INDEX index�� ON ���̺��(�÷���,�÷���)
       => ����
          DROP INDEX index��
       => ����
          ORDER BY => ��Ʈ, ����
          SELECT /* + INDEX_ASC(���̺�� PK)* / �÷���... FROM emp
                      INDEX_DESC(���̺�� PK)
          SELECT * ~~ FROM ���̺�� WHERE �ε��� �÷��� ����
    
*/
SELECT rowid, ename FROM emp;

--�ε��� ����
CREATE INDEX idx_emp_ename ON emp(ename DESC);
SELECT * FROM emp;

--sort
SELECT * FROM emp WHERE ename>='A';

CREATE INDEX idx_emp_sal ON emp(sal);
SELECT * FROM emp WHERE sal>=0;

SELECT title FROM seoul_hotel ORDER BY title ASC;
SELECT /*+ INDEX_DESC(seoul_hotel sh_no_pk) */ no,title FROM seoul_hotel;
CREATE INDEX idx_sh_title ON seoul_hotel(title);
SELECT title FROM seoul_hotel WHERE title>='A';
-- ����
DROP INDEX idx_emp_ename;
DROP INDEX idx_emp_sal;
DROP INDEX idx_sh_title;

/*
    1) �ε��� ��� ����
        => ���� ������ �˻� ����� ������ �������� (B Tree ����)
        => SQL��ɹ��� ó���ӵ��� ���
        => ����ȭ
        => �˻���� ���� ���Ǵ� �÷��� �ִ� ���
        => JOIN���� �񱳵Ǵ� �÷�
        => INSERT,UPDATE,DELETE�� ���� ���̺��� INDEX�� ����� �ӵ��� ����
        ---------------------------------------------- �ε��� �籸��(����)
        CREATE INDEX index�� ON ���̺��(�÷���) => �÷��� (ASC), �÷��� DESC
                    ------ idx_���̺��_�÷���
        CREATE INDEX index�� ON ���̺��(�÷���,�÷���)
         ��) job, sal ==> ON emp(job,sal DESC)
        ����
         DROP INDEX �ε�����
        INSERT, UPDATE, DELETE => �ε��� �籸��
        ALTER INDEX index�� REBUILD
        -------------------> ������ ����
        => ����
            INDEX_ASC(���̺�� PK), INDEX_DESC(���̺�� PK) ==> ORDER BY ��� ���(�ӵ� ���)
*/