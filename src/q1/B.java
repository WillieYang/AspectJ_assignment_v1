package q1;

public class B {

	public int foo(int a){
		bar();
		return 0;
	}
	
	public void bar(){
		
		baz(2);
	}
	
	public int baz(int a){
		
		return a + a;
	}
	
	public void tell(){
		System.out.println("shengyang");
	}
}
