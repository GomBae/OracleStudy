-- 오라클 2일차 정리
/*
    SELECT / INSERT / UPDATE / DELETE
    CREATE / ALTER / DROP / TRUNCATE / RENAME
    GRANT / REVOKE
    COMMIT / ROLLBACK
    -------------------------------------------
    TABLE / VIEW / SEQUENCE / PROCEDURE / FUNCTION / TRIGGER
    ---------------------------------------------------------- JDBC
    *** DESC table명
        ---------- 컬럼명, 데이터형
                         --------
                         숫자형 : NUMBER
                         ---------------
                         문자형 : VARCHAR2, CHAR
                         날짜형 : DATE, TIMESTAMP
                         ----------------------- 값을 입력할 때 반드시 ''
       오라클 문법 => 문법이 종료되면 반드시 ;
                    (자바에서 SQL문장을 전송시에는 ;를 사용하면 오류난다) => 명령문이 다를 경우
       => 권장사항 : 키워드는 대문자 사용 (대소문자 구분을 하지 않는다(SQL문장), 저장된 데이터는 대소문자 구분)
    1) SELECT : 데이터 추출(화면에 출력할 데이터) => 데이터 검색 => 웹
       = 형식
         SELECT [ALL|DISTINCT] [* | column]
                                -------------- 출력에 필요한 컬럼만 가지고 온다
         FROM table_name : table(데이터가 저장되어 있는 최소단위) ==> 파일
         ================================================================= 필수
         [
            1) WHERE 컬럼명 연산자 값 => 조건 검색
            2) GROUP BY 컬럼명,함수 => 그룹을 묶어서 그룹별 처리
            3) HAVING 그룹함수 => 그룹조건
            4) ORDER BY 컬럼명,함수 ASC,DESC;
         ]
       = 연산자
            산술연산자 : +,-,*,/ (정수/실수=실수)
                    '10' 자동으로 숫자로 변환 => TO_NUMBER
            논리연산자 : AND, OR
            IN ==> OR여러개 IN(값..)
            NULL => 연산처리가 안된다 => IS NULL, IS NOT NULL
            NOT => 부정 => NOT IN, NOT BETWEEN, NOT LIKE
            BETWEEN : 기간, 범위
            LIKE : %(글자수 모름) _(글자수 알고있음)
       = 내장함수
       = JOIN (오라클 조인 / ANSI 조인) => SELECT
       = SubQuery (WHERE, 테이블대신, 컬럼대신) => INSERT, UPDATE,DELETE (부속질의)
    
*/
DESC emp;
