package com.sist.server;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Vector;

/*
 *  class ChatServer
 *  {
 *     Client의 정보 저장 ==> IP, PORT
 *     ------------------------------- 접속시마다 저장 (담당)
 *     
 *     -------------------------------
 *      class Client extends Thread ==> 접속마다 통신을 담당하는 쓰레드
 *      {
 *        통신만 담당 ==> 내부 클래스
 *      }
 *     -------------------------------
 *  }
 *  
 *  내부 클래스 : 쓰레드, 네트워크 => 공유하는 데이터가 많다 ==> 멤버클래스 이용해서 공유
 *    = 멤버클래스 
 *      class A
 *      {
 *         class B
 *         {
 *            A가 가지고 있는 모든 데이터 공유할 목적
 *         }
 *      }
 *    = 익명의 클래스 : 상속없이 오버라이딩을 할 때 사용
 */
//접속시에 클라이언트 정보 저장 ==> 교환 소켓
public class ChatServer extends Thread{

	//클라이언트 정보 저장
	private Vector<Client> waitVc=new Vector<Client>();
	//서버 가동
	private ServerSocket ss;//교환 소켓 => 접속시만 처리
	//서버는 PORT가 고정, 고정IP
	private final static int PORT=3355;//
	//0~65535
	/*
	 * 0~1023번 알려진 포트 => 사용금지
	 *   = FTP ===> 21
	 *   = SMTP ==> 25
	 *   = HTTP ==> 80
	 *   = TELNET = 23
	 *     p => 프로토콜(약속)
	 * 1521 : 오라클사용
	 * 3306 : MySQL
	 * 3000 : React
	 * 8080 : 스프링
	 * ---------------
	 */
	public ChatServer() {
		try {
			// 서버는 두번 실행하면 안된다 (한번만 실행이 가능) => PORT를 변경해서 사용한다
			/*
			 * 
			 *  서버
			 *    P2P : Client 프로그램 서버를 작동 ==> 게임
			 */
			ss=new ServerSocket(PORT);// 기본은 50명까지 접근
			//new ServerSocket(PORT,100) //100명까지 접근허용
			System.out.println("Server Start");
			//bind(IP,PORT) : 개통, listen() : 대기
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public void run() {//접속시에 정보를 저장
		try {
			while(true) {
				Socket client=ss.accept();//클라이언트가 접속했을 경우에만 호출(특수메소드) => 접속한 클라이언트의 정보를 가지고온다
				            //발신자 전화번호
				            //IP와 PORT를 가지고 있는 클래스 => Socket
//				System.out.println("접속한 클라이언트 IP : "+client.getInetAddress().getHostAddress());
//				System.out.println("접속한 클라이언트 PORT : "+client.getPort());
				// 서버=>고정 PORT, 클라이언트는 자동 PORT
				Client c=new Client(client);
				waitVc.add(c);
				c.start();
			}
		}catch(Exception e) {e.printStackTrace();}
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ChatServer server=new ChatServer();
		new Thread(server).start();
		

	}
	//통신 => 사용자 요청 받기, 사용자 요청 처리후에 응답 ==> 통신 소켓
	class Client extends Thread{
		private Socket s; // 클라이언트 연결 소켓 (쓰레드가 담당하는 클라이언트의 정보를 가지고있다)
		private OutputStream out; //클라이언트로 값을 전송
		private BufferedReader in; //클라이언트로부터 요청값을 받을 경우에 사용
		
		public Client(Socket s) {
			try {
				this.s=s;
				in=new BufferedReader(new InputStreamReader(s.getInputStream()));
				//socket => 클라이언트의 컴퓨터
				out=s.getOutputStream(); //서버에 저장 => 클라이언트에서 읽어간다
				// 메모리에 저장 => 저장된 위치로부터 클라이언트가 읽어 간다 => 신뢰성이 뛰어남
			}catch(Exception e) {e.printStackTrace();}
		}
		public void run()
		{
			try {
				while(true) {
					//클라이언트로부터 요청한 값 받기
					String msg=in.readLine(); //in => 클라이언트가 저장해둔 메모리
					//접속한 모든 클라이언트로 데이터 전송
					for(Client c:waitVc) {
						c.out.write((msg+"\n").getBytes());
						//반드시 \n을 추가한다
					}
				}
			}catch(Exception e) {}
		}
	}

}
