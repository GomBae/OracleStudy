package com.sist.dao;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ViewDAO {

	private Connection conn;
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	// Driver등록 => Properties or Class.forname
	public ViewDAO(){
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
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//전체 목록 => 테이블 4개 연결
	public void empListData() {
		try {
			getConnection();
			String sql="SELECT e1.empno,e1.ename,e2.ename as manager, e1.job, e1.hiredate, e1.sal,e1.comm,dname,loc,grade "
					+ "FROM emp e1 JOIN dept "
					+ "ON e1.deptno=dept.deptno "
					+ "JOIN salgrade "
					+ "ON e1.sal BETWEEN losal AND hisal "
					+ "LEFT OUTER JOIN emp e2 "
					+ "ON e1.mgr=e2.empno";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getInt(1)+" "
						+rs.getString(2)+ " "
						+rs.getString(3)+" "
						+rs.getString(4)+" "
						+rs.getDate(5).toString()+" "
						+rs.getInt(6)+" "
						+rs.getInt(7)+" "
						+rs.getString(8)+" "
						+rs.getString(9)+" "
						+rs.getInt(10));
			}
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			disConnection();
		}
	}
	//상세보기
	public void empDetailData(int empno) {
		try {
			getConnection();
			String sql="SELECT e1.empno,e1.ename,e2.ename as manager, e1.job, e1.hiredate, e1.sal,e1.comm,dname,loc,grade "
					+ "FROM emp e1 JOIN dept "
					+ "ON e1.deptno=dept.deptno "
					+ "JOIN salgrade "
					+ "ON e1.sal BETWEEN losal AND hisal "
					+ "LEFT OUTER JOIN emp e2 "
					+ "ON e1.mgr=e2.empno "
					+ "WHERE e1.empno="+empno;
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
				System.out.println(rs.getInt(1)+" "
						+rs.getString(2)+ " "
						+rs.getString(3)+" "
						+rs.getString(4)+" "
						+rs.getDate(5).toString()+" "
						+rs.getInt(6)+" "
						+rs.getInt(7)+" "
						+rs.getString(8)+" "
						+rs.getString(9)+" "
						+rs.getInt(10));
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			disConnection();
		}
	}
	//VIEW => 전체목록 ==> 응용프로그램 제작시에 SQL문장이 간결해져서 사용이 편하다
	public void viewListData() {
		try {
			getConnection();
			String sql="SELECT * FROM empDeptGrade_1";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getInt(1)+" "
						+rs.getString(2)+ " "
						+rs.getString(3)+" "
						+rs.getString(4)+" "
						+rs.getDate(5).toString()+" "
						+rs.getInt(6)+" "
						+rs.getInt(7)+" "
						+rs.getString(8)+" "
						+rs.getString(9)+" "
						+rs.getInt(10));
			}
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			disConnection();
		}
	}
	//VIEW => 상세보기
	public void viewDetailData(int empno) {
		try {
			getConnection();
			String sql="SELECT * FROM empDeptGrade_1 WHERE empno="+empno;
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getInt(1)+" "
						+rs.getString(2)+ " "
						+rs.getString(3)+" "
						+rs.getString(4)+" "
						+rs.getDate(5).toString()+" "
						+rs.getInt(6)+" "
						+rs.getInt(7)+" "
						+rs.getString(8)+" "
						+rs.getString(9)+" "
						+rs.getInt(10));
			}
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			disConnection();
		}
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ViewDAO dao=new ViewDAO();
//		dao.empListData();
//		dao.viewListData();
//		dao.empDetailData(7788);
		dao.viewDetailData(7788);

	}

}
