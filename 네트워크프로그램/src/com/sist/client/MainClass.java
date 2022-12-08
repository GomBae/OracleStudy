package com.sist.client;

import java.net.Socket;

public class MainClass {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			Socket s=
					new Socket("localhost",3355);
		}catch(Exception e) {
			e.printStackTrace();
		}

	}

}
