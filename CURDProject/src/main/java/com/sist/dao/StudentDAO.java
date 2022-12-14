package com.sist.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class StudentDAO {

	private Connection conn;
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	//드라이버 등록 : 한번만 실행, 변수 초기화... 생성자 사용
	//자동 로그인, 쿠키읽기 ...
	//웹 => 자바(변경) => 데이터베이스 연결
	public StudentDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch(Exception e) {}
	}
	//오라클 연결
	public void getConnection() {
		try {
			conn=DriverManager.getConnection(URL,"hr","happy");
		}catch(Exception e) {}
	}
	//오라클 연결 해제
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		}catch(Exception e) {}
	}
	////////////////// 필수
	//기능
	//1. 추가
	public void studentInsert(StudentVO vo) {
		try {
			//1. 연결
			getConnection();
			//2. SQL문장 만들기
		    String sql="INSERT INTO student VALUES((SELECT NVL(MAX(hakbun)+1,1) FROM student),?,?,?,?)";
		    //3. SQL문장 전송
		    ps=conn.prepareStatement(sql);
		    //4. 실행전에 ?에 값 채우기
		    ps.setString(1, vo.getName());//setString ==> '홍길동' 자동으로 작은따옴표 붙음
		    ps.setInt(2, vo.getKor());
		    ps.setInt(3, vo.getEng());
		    ps.setInt(4, vo.getMath());
		    //INSERT를 실행
		    ps.executeUpdate(); //INSERT,UPDATE,DELETE => executeUpdate() ==> 자동 COMMIT
		    //SELECT => executeQuery() ==> COMMIT이 없다
		}catch(Exception e) {
			e.printStackTrace();//오류확인
		}finally {
			//닫기
			disConnection();
		}
	}
	//2. 데이터 읽기
	public ArrayList<StudentVO> studentListData(){
		ArrayList<StudentVO> list=new ArrayList<StudentVO>();
		try {
			getConnection();
			String sql="SELECT hakbun,name,kor,eng,math,(kor+eng+math) total, "
					+ "ROUND((kor+eng+math)/3,2) avg "
					+ "FROM student";
			ps=conn.prepareStatement(sql);
			//실행 후 데이터를 요청
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				StudentVO vo=new StudentVO();
				vo.setHakbun(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setKor(rs.getInt(3));
				vo.setEng(rs.getInt(4));
				vo.setMath(rs.getInt(5));
				vo.setTotal(rs.getInt(6));
				vo.setAvg(rs.getDouble(7));
				list.add(vo);
			}
			rs.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			disConnection();
		}
		return list;
	}
	//3. 수정
	//4. 삭제

}
