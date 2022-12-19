package com.sist.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import oracle.jdbc.OracleTypes;

public class StudentDAO {

	private Connection conn;
	private PreparedStatement ps;
	private CallableStatement cs; //프로시저 호출
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	
	public StudentDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void getConnection() {
		try {
			conn=DriverManager.getConnection(URL,"hr","happy");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void disConnection() {
		try {
			if(cs!=null) cs.close();
			if(conn!=null) conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//기능 설정
	//1. 목록 출력
	/*
	 * CREATE OR REPLACE PROCEDURE studentListData(
		    pResult OUT SYS_REFCURSOR
		)
		IS
		BEGIN
		    OPEN pResult FOR
		    SELECT * FROM student;
		END;
		/
	 */
	public ArrayList<StudentVO> StudentListData(){
		ArrayList<StudentVO> list=new ArrayList<StudentVO>();
		try {
			getConnection();
			String sql="{CALL studentListData(?)}";
			cs=conn.prepareCall(sql);
			//?에 값 채우기
			cs.registerOutParameter(1, OracleTypes.CURSOR);//OUT 메소드 //오라클 데이터형과 동일
			//실행 요청
			cs.executeQuery();
			//임시로 저장된 메모리에서 데이터를 가지고 온다
			ResultSet rs=(ResultSet)cs.getObject(1);
			while(rs.next()) {
				StudentVO vo=new StudentVO();
				vo.setHakbun(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setKor(rs.getInt(3));
				vo.setEng(rs.getInt(4));
				vo.setMath(rs.getInt(5));
				list.add(vo);
			}
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			disConnection();
		}
		return list;
	}
	//2. 데이터 추가
	/*
	 * CREATE OR REPLACE PROCEDURE studentInsert(
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
	 */
	public void studentInsert(StudentVO vo) {
		try {
			getConnection();
			String sql="{CALL studentInsert(?,?,?,?)}";
			//프로시저 호출
			cs=conn.prepareCall(sql);
			//?에 값 채우기
			cs.setString(1, vo.getName());
			cs.setInt(2, vo.getKor());
			cs.setInt(3, vo.getEng());
			cs.setInt(4, vo.getMath());
			
			//실행 요청
			cs.executeQuery();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			disConnection();
		}
	}
	//3. 데이터 수정
	/*
	 * CREATE OR REPLACE PROCEDURE studentUpdate(
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
	 */
	//4. 데이터 삭제
	/*
	 * CREATE OR REPLACE PROCEDURE studentDelete(
		    pHakbun IN student.hakbun%TYPE
		)
		IS
		BEGIN
		    DELETE FROM student
		    WHERE hakbun=pHakbun;
		    COMMIT;
		END;
		/
	 */
	//5. 데이터 검색
}
