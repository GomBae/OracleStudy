package com.sist.dao;
/*
 * book, customer, orders => VO는 따로 제작
 * ---------------------- BookDAO
 * emp, dept, salgrade => VO는 따로 제작
 * ---------------------- empDAO
 */

import java.awt.print.Book;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
/*
 * 1. 드라이버 등록 Class.forName()
 * 2. 연결 : DriverManager.getConnection(URL,"id","pwd")
 * 3. SQL문장 만들기
 * 4. SQL문장 전송 conn.preparedStatement(sql)
 * 5. 결과값 읽기
 * 		결과값 있는 경우 (SELECT ) => executeQuery()
 * 		결과값 없는 경우 (INSERT,UPDATE,DELETE) ==> executeUpdate() => COMMIT을 포함하고있다
 * 		저장되는 메모리 : ResultSet
 * 		ResultSet rs=ps.executeQuery()
 *      => SELECT empno,ename,job,sal,hiredate FROM emp;;
 *      
 *      rs.next() => 커서를 데이터가 있는 맨 윗줄로 이동 후 데이터 읽기
 *      rs.previous() => 마지막 이전줄로 이동 후 데이터 읽기
 */
import java.util.ArrayList;
public class BookDAO {

	private Connection conn;
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	
	public BookDAO() {
		/*
		 * 멤버변수에 대한 초기화 , 한번만 수행, 연결, 드라이버 ...
		 */
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			//클래스 정보를 읽어서 제어할때 주로 사용
			//메모리 할당(new 대신 사용)
			//메소드 호출
			//변수 초기값
			//--------- 리플렉션
			//new연산자를 이용하면 (결합성이 높은 프로그램 => 사용하지 말라고 권장)
			//결합성이 낮은 프로그램 => 리플렉션
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
	//3-1
	public ArrayList<BookVO> book3_1(){
		ArrayList<BookVO> list=new ArrayList<BookVO>();
		try {
			getConnection();
			String sql="SELECT bookname,price FROM book";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				BookVO vo=new BookVO();
				vo.setBookname(rs.getString(1));
				vo.setPrice(rs.getInt(2));
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
	//3-2
	public ArrayList<BookVO> book3_2(){
		ArrayList<BookVO> list=new ArrayList<BookVO>();
		try {
			getConnection();
			String sql="SELECT bookid,bookname,publisher,price FROM book";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				BookVO vo=new BookVO();
				vo.setBookid(rs.getInt(1));
				vo.setBookname(rs.getString(2));
				vo.setPublisher(rs.getString(3));
				vo.setPrice(rs.getInt(4));
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
	//3-3
	//컬럼이 여러개 => VO
	//컬럼이 한개 => 해당 데이터형
	public ArrayList<String> book3_3(){
		ArrayList<String> list=new ArrayList<String>();
		try {
			getConnection();
			String sql="SELECT DISTINCT publisher FROM book";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				list.add(rs.getString(1));
			}
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			disConnection();
		}
		return list;
	}
	//3-4
	public ArrayList<BookVO> book3_4(){
		ArrayList<BookVO> list=new ArrayList<BookVO>();
		try {
			getConnection();
			String sql="SELECT bookname FROM book WHERE price<20000";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				BookVO vo=new BookVO();
				vo.setBookname(rs.getString(1));
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
	//3-5
	public ArrayList<BookVO> book3_5(){
		ArrayList<BookVO> list=new ArrayList<BookVO>();
		try {
			getConnection();
			String sql="SELECT bookname FROM book WHERE price BETWEEN 10000 AND 20000";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				BookVO vo=new BookVO();
				vo.setBookname(rs.getString(1));
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
	//3-6
	public ArrayList<BookVO> book3_6(){
		ArrayList<BookVO> list=new ArrayList<BookVO>();
		try {
			getConnection();
			String sql="SELECT bookname FROM book WHERE publisher='굿스포츠' OR publisher='대한미디어'";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				BookVO vo=new BookVO();
				vo.setBookname(rs.getString(1));
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
	//조인 => 고객과 고객의 주문에 관한 데이터를 모두 보이시오
	public ArrayList<CustomerVO> book3_21(){
		ArrayList<CustomerVO> list=new ArrayList<CustomerVO>();
		try {
			getConnection();
			/*
			 * SQL 명령어가 올바르게 종료되지 않았습니다 ==> 공백
			 * 내부변환 안됨 => 데이터형이 틀리다
			 * IN OUT => ?에 값을 지정하지 않는 경우
			 * NULL => URL주소가 틀린경우
			 */
			String sql="SELECT name,address,phone,bookid,saleprice,orderdate "
					+ "FROM customer,orders "
					+ "WHERE customer.custid=orders.custid "
					+ "ORDER BY customer.custid";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				CustomerVO vo=new CustomerVO();
				vo.setName(rs.getString(1));
				vo.setAddress(rs.getString(2));
				vo.setPhone(rs.getString(3));
				vo.getOvo().setBookid(rs.getInt(4));
				vo.getOvo().setSaleprice(rs.getInt(5));
				vo.getOvo().setOrderdate(rs.getDate(6));
				list.add(vo);
			}
			rs.close();
		}catch(Exception e) {
			
		}finally {
			disConnection();
		}
		return list;
	}
	
	//3_22
	public ArrayList<CustomerVO> book3_23(){
		ArrayList<CustomerVO> list=new ArrayList<CustomerVO>();
		try {
			getConnection();
			String sql="SELECT name,(SELECT bookname FROM book WHERE bookid=o.bookid) bookname,saleprice "
					+ "FROM customer c, orders o "
					+ "WHERE c.custid=o.custid "
					+ "ORDER BY c.custid";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				CustomerVO vo=new CustomerVO();
				vo.setName(rs.getString(1));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			disConnection();
		}
		return list;
	}
	
}
