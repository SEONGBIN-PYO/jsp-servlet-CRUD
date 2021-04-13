package auth.security;

public class TemporaryPassword {
	
	public static String getRamdomPassword() {
		char[] charSet = new char[] 
				{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
				 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
				 'U', 'V', 'W', 'X', 'Y', 'Z' };
		
		int idx = 0;
		StringBuffer sb = new StringBuffer();
		
		for (int i = 0; i < 10; i++) {
			idx = (int) (charSet.length * Math.random());
			sb.append(charSet[idx]);
		}
		
		return sb.toString();
	}
}
