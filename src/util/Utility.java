package util;

import java.security.MessageDigest;

//��ȣȭ ����
public class Utility {
	//���ڿ��� ���޹޾� ��ȣȭ�Ͽ� ��ȯ�ϴ� �޼ҵ�
	//�ܹ��� ��ȣ �˰�����(MD5, SHA-1, SHA-256, SHA-512��) ���
	//MessageDigest Ŭ���� �̿�
		public static String encoding(String str) {
			String encodeString = "";
			try{
				//MessageDigest ��ü ����
				//��ȣȭ �˰������� �����Ͽ� ��ü ����
				MessageDigest md = MessageDigest.getInstance("SHA-512");
				
				//MessageDigest ��ü�� ��ȣȭ �Ϸ��� �������ڿ��� update()�޼ҵ带 ���� ����
				//String ��ü�� �ƴ� byte �迭 ���·� ����(���ڿ���ü.getBytes())
				//System.out.println(str);
				md.update(str.getBytes());
				
				//�������ڿ��� digest()�޼ҵ�� ��ȣȭ�Ͽ� byte�迭�� ��ȯ�޾� ����
				byte[] encodeData = md.digest();
				
				//��ȣȭ�� byte �迭�� string ��ü�� ��ȯ�Ͽ� ����
				for(int i=0; i<encodeData.length; i++)
				{//byte �����͸� 16���� ���ڿ��� ��ȯ�Ͽ� ��ȯ ���ڿ��� �߰�(�ѹ� �� ��ȣȭ)
					encodeString += Integer.toHexString(encodeData[i]&0xFF);
				}
				
			}catch(Exception e)
			{
				e.printStackTrace();
			}
			return encodeString;
		}
}