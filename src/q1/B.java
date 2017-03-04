package q1;

public class B {

	public int foo(int a){
		bar(1);
		return 0;
	}
	
	public int bar(int b){
		
		return baz(4);
	}
	
	public int baz(int a){
		
		return a + a;
	}
}
