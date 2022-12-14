package com.sist.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Scanner;

public class FoodDAO {

	private Connection conn;
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	
	public FoodDAO() {
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
	
	//기능
	//1. 페이징 => 인라인뷰 ==> 이미지 (5개)
	public ArrayList<FoodVO> foodListData(int page){
		ArrayList<FoodVO> list=new ArrayList<FoodVO>();
//		try {
//			getConnection();
//			String sql="SELECT fno,name,poster FROM food_location "
//					+ "ORDER BY fno";
//			ps=conn.prepareStatement(sql);
//			ResultSet rs=ps.executeQuery();
//			
//			int i=0; //20개씩 나눠주는 변수
//			int j=0; // while의 횟수
//			final int rowSize=20; 
//			int pagecnt=(page*rowSize)-rowSize; //시작위치 => ArrayList에 저장할 시점
//			//while, for ==> 반복문 => 시작부터 끝까지 수행
//			while(rs.next()) {
//				if(i<rowSize && j>=pagecnt) {
//					FoodVO vo=new FoodVO();
//					vo.setFno(rs.getInt(1));
//					vo.setName(rs.getString(2));
//					String poster=rs.getString(3);
//					poster=poster.substring(0,poster.indexOf("^"));
//					vo.setPoster(poster);
//					list.add(vo);
//					i++;
//				}
//				j++;
//			}
//			
//		}catch(Exception e) {
//			e.printStackTrace();
//		}finally {
//			disConnection();
//		}
		
		//인라인뷰 이용해서 페이징처리 => 상위5개, 페이지(해당 위치)
		//적용되는 위치
		try {
			getConnection();
			String sql="SELECT fno,name,poster,num "
					+ "FROM (SELECT fno,name,poster,rownum as num "
					+ "FROM (SELECT fno,name,poster "
					+ "FROM food_location ORDER BY fno)) "
					+ "WHERE num BETWEEN ? AND ?";
			ps=conn.prepareStatement(sql);
			int rowSize=20;
			int start=(rowSize*page)-(rowSize-1);
			//1page ==> 1
			//2page ==> 21
			int end=rowSize*page;
			ps.setInt(1, start);
			ps.setInt(2, end);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				FoodVO vo=new FoodVO();
				vo.setFno(rs.getInt(1));
				vo.setName(rs.getString(2));
				String poster=rs.getString(3);
				poster.substring(0,poster.indexOf("^"));
				vo.setPoster(poster);
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
	public int foodTotalPage() {
		int total=0;
		try {
			getConnection();
			String sql="SELECT CEIL(COUNT(*)/20.0) FROM food_location";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			total=rs.getInt(1);
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			disConnection();
		}
		return total;
	}
	//2. 검색 => LIKE
	//3. 상세보기 => 주소 자르기
	public FoodVO foodDetailData(int fno) {
		FoodVO vo=new FoodVO();
		try {
			getConnection();
			String sql="SELECT fno,name,tel,score,type,time,parking,menu,poster "
					+ "FROM (SELECT * FROM food_location) "
					+ "WHERE fno="+fno;
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setFno(rs.getInt(1));
			vo.setName(rs.getString(2));
			vo.setTel(rs.getString(3));
			vo.setScore(rs.getDouble(4));
			vo.setType(rs.getString(5));
			vo.setTime(rs.getString(6));
			vo.setParking(rs.getString(7));
			vo.setMenu(rs.getString(8));
			vo.setPoster(rs.getString(9));
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			disConnection();
		}
		return vo;
	}
	public static void main(String[] args) {
		FoodDAO dao=new FoodDAO();
		Scanner sc=new Scanner(System.in);
		int totalpage=dao.foodTotalPage();
		System.out.print("1~"+totalpage+" 사이의 페이지 입력 : ");
		int page=sc.nextInt();
		
		ArrayList<FoodVO> list=dao.foodListData(page);
		System.out.println("====================== 결과값 ===================");
		for(FoodVO vo:list) {
			System.out.println(vo.getFno()+" "+vo.getName());
		}
	}
	
}
