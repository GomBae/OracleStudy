package com.sist.main;

import java.util.ArrayList;

import com.sist.dao.BookDAO;
import com.sist.dao.BookVO;
import com.sist.dao.CustomerVO;

public class BookMainClass {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		BookDAO dao=new BookDAO();
//		ArrayList<BookVO> list=dao.book3_1();
//		for(BookVO vo:list) {
//			System.out.println(vo.getBookname() + " "+ vo.getPrice());
//		}
//		ArrayList<BookVO> list=dao.book3_2();
//		for(BookVO vo:list) {
//			System.out.println(vo.getBookid()+" "+vo.getBookname()+" "+vo.getPublisher()+" "+vo.getPrice());
//		}
//		ArrayList<String> list=dao.book3_3();
//		for(String s:list) {
//			System.out.println(s);
//		}
//		ArrayList<BookVO> list=dao.book3_4();
//		for(BookVO vo:list) {
//			System.out.println(vo.getBookname());
//		}
//		ArrayList<BookVO> list=dao.book3_5();
//		for(BookVO vo:list) {
//			System.out.println(vo.getBookname());
//		}
//		ArrayList<BookVO> list=dao.book3_6();
//		for(BookVO vo:list) {
//			System.out.println(vo.getBookname());
//		}
		ArrayList<CustomerVO> list=dao.book3_21();
		for(CustomerVO vo:list) {
			System.out.println(vo.getName()+" "+vo.getAddress()+" "+vo.getPhone()+" "+vo.getOvo().getBookid()+" "+vo.getOvo().getSaleprice()+" "+vo.getOvo().getOrderdate().toString());
		}

	}

}
