/*
    PL/SQL, INDEX
    => 1) SQL문장, 2) 자바 => 화면 출력(브라우저) => HTML
    인덱스 (INDEX) : 자료를 쉽고 빠르게 찾을 수 있게 만든 데이터 구조
     = 검색시에 속도 향상
     = 메모리가 많이 필요하다
     = 자동생성 : UNIQUE,PK => 인덱스 
     
     => 인덱스 생성
        => 시기
        1) 구별되는 값이 많은 경우 (PK)
        2) WHERE 절에서 자주 검색되는 컬럼이 있는 경우
          => 제목, 이름 ... 
        3) JOIN에서 주로 사용되는 컬럼 
        4) NULL값을 포함하는 컬럼이 많은 경우
        => 인덱스를 만들지 않는 부분
        1) INSERT, UPDATE, DELETE가 많은 부분 => 인덱스를 만들경우 성능이 저하됨
    => 형태 : B*트리
              루트
              
              --------
                  |
        ---------------------- 내부루트
        |        |          |
        ---     ----       ---  리프루트
    
    1) 생성
       => PK,UQ => 자동생성
       => 생성
          CREATE INDEX index명 ON 테이블명(컬럼명) => 컬럼명 (ASC), 컬럼명 DESC
          CREATE INDEX index명 ON 테이블명(컬럼명,컬럼명)
       => 삭제
          DROP INDEX index명
       => 정렬
          ORDER BY => 힌트, 조건
          SELECT /* + INDEX_ASC(테이블명 PK)* / 컬럼명... FROM emp
                      INDEX_DESC(테이블명 PK)
          SELECT * ~~ FROM 테이블명 WHERE 인덱스 컬럼명 조건
    
*/
SELECT rowid, ename FROM emp;

--인덱스 생성
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
-- 삭제
DROP INDEX idx_emp_ename;
DROP INDEX idx_emp_sal;
DROP INDEX idx_sh_title;

/*
    1) 인덱스 사용 목적
        => 쉽고 빠르게 검색 결과를 가지고 오기위해 (B Tree 구조)
        => SQL명령문의 처리속도를 향상
        => 최적화
        => 검색어로 많이 사용되는 컬럼이 있는 경우
        => JOIN에서 비교되는 컬럼
        => INSERT,UPDATE,DELETE가 많은 테이블에서 INDEX를 만들면 속도가 저하
        ---------------------------------------------- 인덱스 재구성(빌드)
        CREATE INDEX index명 ON 테이블명(컬럼명) => 컬럼명 (ASC), 컬럼명 DESC
                    ------ idx_테이블명_컬럼명
        CREATE INDEX index명 ON 테이블명(컬럼명,컬럼명)
         예) job, sal ==> ON emp(job,sal DESC)
        삭제
         DROP INDEX 인덱스명
        INSERT, UPDATE, DELETE => 인덱스 재구성
        ALTER INDEX index명 REBUILD
        -------------------> 데이터 수집
        => 정렬
            INDEX_ASC(테이블명 PK), INDEX_DESC(테이블명 PK) ==> ORDER BY 대신 사용(속도 향상)
*/