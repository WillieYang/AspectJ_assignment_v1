package q1.sy3g16;

import q1.B;
import test.Test_q1;

import org.aspectj.lang.Signature;
import org.aspectj.lang.reflect.CodeSignature;
import org.aspectj.lang.reflect.MethodSignature;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

public aspect Aspect_Part_One {
	
	public String current_node;
	public String enclosing_node;
	public String nodefile = "./node.csv";
	public String edgefile = "./edge.csv";
	public String par_tp;
	public String par_tp_2;
	public String retn_tp;
	public String retn_tp_2;
	
	pointcut callnodes(B b): cflowbelow(call(public int q1..*(int)))
							 && target(b)
								&& within(B || Test_q1);
	
	before(B b) : callnodes(b) {
		
			// The signature of current join point. (To get the method name(node) of current invoked method and the declaring type name.)
		Signature sig = thisJoinPointStaticPart.getSignature();
			// The signature of enclosing join point. (To get the method name(node) of enclosing method and and the declaring type name.)
		Signature sig_2 = thisEnclosingJoinPointStaticPart.getSignature();
			// The method signature of current join point. (To get the return type of current invoked method.)
		MethodSignature m_sig = (MethodSignature) thisJoinPoint.getSignature();
			// The method signature of enclosing join point. (To get the return type of enclosing method.)
		MethodSignature m_sig_2 = (MethodSignature) thisEnclosingJoinPointStaticPart.getSignature();
			// The code signature of current join point. (To get the parameter type of current invoked method.)
		CodeSignature par_sig = (CodeSignature) thisJoinPoint.getSignature();
			// The code signature of enclosing join point. (To get the parameter type of enclosing invoked method.)
		CodeSignature par_sig_2 = (CodeSignature) thisEnclosingJoinPointStaticPart.getSignature();
			// Parameter type of current invoked method.
		par_tp = Arrays.toString(par_sig.getParameterTypes()).replace("[", "(").replace("]", ")");
			// Parameter type of enclosing invoked method.
		par_tp_2 = Arrays.toString(par_sig_2.getParameterTypes()).replace("[", "(").replace("]", ")");
		
			// Current invoked method.
		current_node = sig.getDeclaringTypeName() + "." + sig.getName() + par_tp;
			// Enclosing method.
		enclosing_node = sig_2.getDeclaringTypeName() + "." + sig_2.getName() + par_tp_2;
			// 	Return type of current invoked method.
		retn_tp = m_sig.getMethod().getGenericReturnType().toString();
			//	Return type of enclosing method.
		retn_tp_2 = m_sig_2.getMethod().getGenericReturnType().toString();
			//output......
		
		System.out.println("-----------------------------");
		
		System.out.println("Current node:" + current_node);
		System.out.println(
				"JoinPoint at:" + thisJoinPointStaticPart.getSourceLocation().getWithinType().getCanonicalName()
				+ "-->" + thisJoinPointStaticPart.getSourceLocation().getLine());
			
		System.out.println("Return type of current node:" + retn_tp);
		System.out.println("Return type of enclosing node:" + retn_tp_2);
		System.out.println("Parameter type of current node:" + par_tp);
		System.out.println("Parameter type of enclosing node:" + par_tp_2);
		
		System.out.println("Exclosing node:" + enclosing_node);
		
		System.out.println(
				"JoinPoint at:" + thisEnclosingJoinPointStaticPart.getSourceLocation().getWithinType().getCanonicalName()
				+ "-->" + thisEnclosingJoinPointStaticPart.getSourceLocation().getLine());
		
		//output......
			
			
		try(FileWriter fw = new FileWriter(nodefile, true);
			BufferedWriter bw = new BufferedWriter(fw);
			PrintWriter out = new PrintWriter(bw))
		{
			out.println(current_node);
			
		}catch(IOException e){
			System.out.println("Error Message.");
		}
		
		if(current_node.equals(enclosing_node)){}
		else{
			if(par_tp.equals(par_tp_2) && retn_tp.equals(retn_tp_2)){
			
				try(FileWriter fw_edge = new FileWriter(edgefile, true);
						BufferedWriter bw_edge = new BufferedWriter(fw_edge);
						PrintWriter out_edge = new PrintWriter(bw_edge))
					{
						out_edge.println(enclosing_node + "-->" + current_node);
						
					}catch(IOException e){
						System.out.println("Error Message.");
					}
				}
			else{
				System.out.println("No edge existing !!!");
				}
			}
	}
}
