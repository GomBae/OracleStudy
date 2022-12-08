-- SQL (DML => 저장된 데이터를 조작하는 프로그램) => 검색,추가,수정,삭제
/*
    DML (데이터 조작)
      = SELECT (데이터를 검색 => 추출)
      ** 컬럼명 확인 => DESC table명
      = 1) 형식
          SELECT * 또는 컬럼명
          FROM table_name (table데이터 저장 공간)
          [
            WHERE => 조건 검색
            GROUP BY => 그룹으로 나눠서 처리(분기별,부서별,직위별)
            HAAVING => 그룹 검색 => 반드시 GROUP BY가 있어야 사용 가능 
            ORDER BY(ASC,DESC) 
          ]
        2) 조건 검색(연산자)
           WHERE 조건절 (컬럼명 연산자 값)
           산술연산자
           비교연산자
           논리연산자
           IN
           BETWEEN AND
           LIKE
           NOT
           NULL
        3) 내장함수
*/