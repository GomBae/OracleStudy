/*
    단일행 함수 ==> 단위 ROW=> 한줄씩 처리
    문자 함수 : LENGTH(), SUBSTR(), INSTR(), RPAD(), REPLACE()
    날짜함수 : SYSDATE,MONTHS_BETWEEN
    숫자함수 : TRUNC(), CEIL, ROUND()
    변환 함수 : TO_CHAR()
        날짜 = 문자열
        YYYY
        MM
        DD
        HH/HH24
        MI
        SS
        숫자 = 문자열
        L999,999 (원 표시)
    기타 함수 : NVL => NULL값 대체
    
              ROWNUM => 오라클 내부적으로 생성 => 가상컬럼 (SQL실행시 ROW의 번호 지정)
              1) 페이징, 2) 이전/다음 => 상세보기
              
              서브쿼리 
              => WHERE 뒤에 => 중첩 서브쿼리
              => 컬럼대신 => 스칼라 서브쿼리
              => 테이블대신 => 인라인뷰
    다중행 함수 ==> 컬럼 단위
    AVG,COUNT,MAX,SUM,MIN
        ---------
    RANK(), CUBE(), ROLLUP() => 통계
    ---------------------------- 두개를 동시에 사용할 수 없다
*/