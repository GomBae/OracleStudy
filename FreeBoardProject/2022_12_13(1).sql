/*
    DML
        INSERT : 데이터 추가
                 게시판 글쓰기, 회원가입, 찜하기, 예매하기, 댓글쓰기
                 형식)
                    = 전체 데이터 추가
                        INSERT INTO table_name VALUES(값,값,값...) => 문자열,날짜 ==> ''
                            => 무조건 모든 컬럼에 값을 추가
                    = 필요한 데이터만 추가 (디폴트 설정이 된 경우)
                        INSERT INTO table_name(컬럼명,컬럼명,컬럼명...) VALUES(값,값....)
                        ** 추가후 => 반드시 COMMIT을 해줘야함
        UPDATE : 데이터 수정
                 게시판 수정, 댓글 수정, 회원 수정, 장바구니 수정, 예매 수정
                 형식)
                    UPDATE table_name SET
                    컬럼명=값, 컬럼명='문자'
        DELETE : 데이터 삭제
                 게시물 삭제, 댓글 삭제, 회원탈퇴, 예매취소 ....
                 
*/
CREATE TABLE emp_update
AS
SELECT * FROM emp;
SELECT * FROM emp_update;

--직위 변경
UPDATE emp_update SET
job='CLERK';
ROLLBACK;

--INSERT
INSERT INTO emp_update VALUES ((SELECT MAX(empno)+1 FROM emp_update),'홍길동','CLERK',7788,SYSDATE,2000,100,40);
INSERT INTO emp_update VALUES ((SELECT MAX(empno)+1 FROM emp_update),'심청이','MANAGER',7788,'21/10/10',3000,500,40);
INSERT INTO emp_update VALUES ((SELECT MAX(empno)+1 FROM emp_update),'박문수','CLERK',7788,SYSDATE,2000,100,40);
COMMIT;

--박문수 update
UPDATE emp_update SET
job='SALESMAN',mgr=7698,hiredate='20/01/05',sal=3500,comm=700,deptno=30
WHERE empno='7937';
SELECT * FROM emp_update;
COMMIT;

INSERT INTO emp_update VALUES ((SELECT MAX(empno)+1 FROM emp_update),'홍길동1','CLERK',7788,SYSDATE,2000,100,40);
INSERT INTO emp_update VALUES ((SELECT MAX(empno)+1 FROM emp_update),'홍길동5','CLERK',7788,SYSDATE,2000,100,40);
INSERT INTO emp_update VALUES ((SELECT MAX(empno)+1 FROM emp_update),'홍길동2','CLERK',7788,SYSDATE,2000,100,40);
INSERT INTO emp_update VALUES ((SELECT MAX(empno)+1 FROM emp_update),'홍길동3','CLERK',7788,SYSDATE,2000,100,40);
INSERT INTO emp_update VALUES ((SELECT MAX(empno)+1 FROM emp_update),'홍길동4','CLERK',7788,SYSDATE,2000,100,40);

UPDATE emp_update SET
deptno=60
WHERE deptno=(SELECT deptno FROM emp_update WHERE empno=7938);

--전체 삭제
DELETE FROM emp_update;
SELECT * FROM emp_update;
ROLLBACK;

DELETE FROM emp_update;
DROP TABLE emp_update;
/*
    COMMIT/ROLLBACK => INSERT, UPDATEm DELETE
    ALTER, CREATE, RENAME, DROP, TRUNCATE ==> ROLLBACK이 먹히지않는다
*/