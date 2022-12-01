package com.sist.client;

import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JTextField;

public class Login extends JPanel{
	JTextField tf1,tf2; //포함클래스
//	JRadioButton rb1,rb2;
	JButton b1,b2;
	JLabel la1,la2;
	public Login() {
		//초기화 => 메모리 할당
		la1=new JLabel("ID");
		la2=new JLabel("비번");
//		la3=new JLabel("성별");
		tf1=new JTextField();
		tf2=new JTextField();
//		rb1=new JRadioButton("남자");
//		rb2=new JRadioButton("여자");
//		ButtonGroup bg=new ButtonGroup();
////		bg.add(rb1);
////		bg.add(rb2);
////		rb1.setSelected(true);
		b1=new JButton("로그인");
		b2=new JButton("취소");
		
		//배치 ==> Layout
		setLayout(null);//직접 배치
		la1.setBounds(10, 15, 50, 30);
		tf1.setBounds(65,15,150,30);
		
		la2.setBounds(10, 50, 50, 30);
		tf2.setBounds(65,50,150,30);
		
//		la3.setBounds(10, 62, 50, 30);
//		rb1.setBounds(65,62,70,30);
//		rb2.setBounds(140,62,70,30);
		
		add(la1);add(tf1);
		add(la2);add(tf2);
//		add(la3);add(rb1);add(rb2);
		
		JPanel p=new JPanel();
		p.add(b1);
		p.add(b2);
		p.setBounds(10, 93, 225, 30);
		add(p);
		
		
	}
}
