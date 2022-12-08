package com.sist.dao;
//오라클 연결하는 클래스
/*
 * ~DAO => table당 한개 => 데이터베이스 연결
 * ~VO, ~DTO => 데이터를 모아서 전송
 * ~Manager => 외부 데이터읽기
 * ~Service => DAO여러개를 묶어서 한번에 처리
 * 
 */
/*  C/S => network(오라클 서버) ServerSocket
 * 		   DAO(클라이언트) Socket, BufferedReader, OutputStream ==> TCP 
 * 
 * 	1. Connection (interface) => 연결
 *  2. Statement (interface) => SQL문장 전송 => 결과값을 받아온다
 *     Statement : SQL문장+데이터값을 동시에 전송
 *     PreparedStatement : SQL문장을 먼저 전송, 나중에 값을 채움
 *     CallableStatement : PL/SQL => 오라클함수(프로시저)를 호출
 *  3. ResultSet (interface) => 결과값을 메모리에 저장
 *     ------------------------
 *        id    sex   name
 *     ------------------------
 *              BOF
 *        1     2       3
 *     ------------------------
 *       aaa   man     hong ===> next()
 *       출력하는게
 *       => 문자열 => getString(1)
 *       => 정수 => getInt(2)
 *       => 실수 => getDouble(3)
 *       => 날짜 => getDate(4)
 *     ------------------------
 *       bbb   woman   shim
 *     ------------------------
 *       ccc   man     park ===> previous()
 *     ------------------------
 *            EOF
 *     ------------------------
 *     | 커서위치
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class EmpDAO {
	//연결 객체 => 한사람당 한개만 사용
	private Connection conn;
	//송수신 객체
	private PreparedStatement ps;
	//오라클 주소 설정
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	//싱글톤 패턴 ==> 메모리 한개만 생성 => 재사용
	private static EmpDAO dao; // static 이용하면 메모리를 한개만 생성이 가능
	//메모리 누수현상(사용하지 않는 메모리가 없게) 방지
	/*
	 * class A
	 * 
	 * A a=new A()
	 * 
	 * a=new A();
	 * a=new A();
	 */
	//1. 드라이버 등록 Class.forName("") ==> 드라이버가 소프트웨어 형식(클래스등록) = 한번만 등록
	// JDBC (원시소스) ==> 라이브러리 (MyBatis,JPA)
	public EmpDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// ==> 클래스의 모든 정보를 읽어서 메모리할당, 멤버변수, 메소드를 제어할때 사용 => 리플렉션
			//패키지명.클래스
			//패키지명.클래스 ==> 등록 (메모리 할당 요청)
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	//1-1 싱글톤 ==> newInstance(), getInstance() 
	//Calendar.getInstance()
	public static EmpDAO newInstance() {
		if(dao==null)
			dao=new EmpDAO();
		return dao;
	}
	//2. 연결
	public void getConnection() {
		try {
			conn=DriverManager.getConnection(URL,"hr","happy");
		}catch(Exception e) {e.printStackTrace();}
	}
	//3. 해제
	public void disConnection() {
		try {
			if(ps!=null) ps.close(); //통신종료
			if(conn!=null) conn.close();
			//exit()
		}catch(Exception e) {}
	}
	//4. 기능 => SQL
	//사원정보 묶어서 클라이언트로 전송
	public ArrayList<EmpVO> empListData(){
		ArrayList<EmpVO> list=new ArrayList<EmpVO>();
		try {
			//1.연결
			getConnection();
			//2.SQL문장
			String sql="SELECT empno,ename,job,mgr,hiredate,sal,comm,emp.deptno,dname,loc,grade "
					+"FROM emp,dept,salgrade "
					+"WHERE emp.deptno=dept.deptno " //EQUI_JOIN
					+"AND sal BETWEEN losal AND hisal";//NON_EQUI_JOIN
			//3.오라클 전송
			ps=conn.prepareStatement(sql);
			//4.실행 후 결과값 받기
			ResultSet rs=ps.executeQuery(); //Record단위 => 
			//5. 결과값 => ArrayList에 첨부
			while(rs.next()) {
				EmpVO vo=new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.setJob(rs.getString(3));
				vo.setMgr(rs.getInt(4));
				vo.setHiredate(rs.getDate(5));
				vo.setSal(rs.getInt(6));
				vo.setComm(rs.getInt(7));
				vo.setDeptno(rs.getInt(8));
				vo.getDvo().setDname(rs.getString(9));
				vo.getDvo().setLoc(rs.getString(10));
				vo.getSvo().setGrade(rs.getInt(11));
				list.add(vo);
			}
			rs.close();
			//
			
		}catch(Exception e) {
			//확인
			System.out.println(e.getMessage());
		}
		finally {
			//해제
			disConnection();
		}
		return list;
	}
	//검색 => LIKE
	public ArrayList<EmpVO> empFindData(String ename){
		ArrayList<EmpVO> list=new ArrayList<EmpVO>();
		try {
			//1.연결
			getConnection();
			//2.SQL문장 제작
			String sql="SELECT empno,ename,job,hiredate,sal "
					+"FROM emp "
					+"WHERE ename LIKE '%'||?||'%'";
			ps=conn.prepareStatement(sql);
			ps.setString(1, ename);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				EmpVO vo=new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.setJob(rs.getString(3));
				vo.setHiredate(rs.getDate(4));
				vo.setSal(rs.getInt(5));
				list.add(vo);
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}finally {
			//해제
			disConnection();
		}
		return list;
	}
	
	//subquery
	//한명의 정보만 가져오기
	public EmpVO empSubQueryData(String ename){
		EmpVO vo=new EmpVO();
		try {
			//1.연결
			getConnection();
			//2.SQL문장
			String sql="SELECT empno,ename,job,hiredate,sal,"
					+ "(SELECT dname FROM dept WHERE deptno=emp.deptno) dname,"
					+ "(SELECT dname FROM dept WHERE deptno=emp.deptno) loc "
					+ "FROM emp "
					+ "WHERE ename=?";
			//3.오라클전송
			ps=conn.prepareStatement(sql);
			ps.setString(1, ename);
			//4.결과값 가져오기
			ResultSet rs=ps.executeQuery();
			//5.EmpVO에 값을 대입
			rs.next();
			vo.setEmpno(rs.getInt(1));
			vo.setEname(rs.getString(2));
			vo.setJob(rs.getString(3));
			vo.setHiredate(rs.getDate(4));
			vo.setSal(rs.getInt(5));
			vo.getDvo().setDname(rs.getString(6));
			vo.getDvo().setLoc(rs.getString(7));
			rs.close();
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		finally {
			disConnection();
		}
		return vo;
	}
	//인라인뷰 ==> FROM (SELECT~~ )
	public ArrayList<EmpVO> empInlineView(int num){
		ArrayList<EmpVO> list=new ArrayList<EmpVO>();
		try {
			//연결
			getConnection();
			//sql작성
			String sql="SELECT empno,ename,job,hiredate,sal,rownum "
					+ "FROM (SELECT * FROM emp ORDER BY sal DESC) "
					+ "WHERE rownum<=?";
			//오라클전송
			ps=conn.prepareStatement(sql);
			ps.setInt(1,num);
			//결과값 가져오기
			ResultSet rs=ps.executeQuery();
			//ArrayList에 대입
			while(rs.next()) {
				EmpVO vo=new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.setJob(rs.getString(3));
				vo.setHiredate(rs.getDate(4));
				vo.setSal(rs.getInt(5));
				list.add(vo);
			}
			rs.close();
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}finally {
			disConnection();
		}
		return list;
	}

}
