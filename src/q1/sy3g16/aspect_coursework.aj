package q1.sy3g16;

import q1.B;
import q1.Test;
import org.aspectj.lang.Signature;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public aspect aspect_coursework {
	
	public String nodes;
	public String targetnode;
	public String filename = "./file.csv";
	public String edgefile = "./edge.csv";
	
	pointcut callnodes(B b, int x)
						: cflowbelow(call(public int q1..*(int)))
							 && args(x) && target(b)
								&& within(B || Test);
	
	before(B b, int x) : callnodes(b, x) {
		
		Signature sig = thisJoinPointStaticPart.getSignature();
		Signature sig_2 = thisEnclosingJoinPointStaticPart.getSignature();
		
		nodes = "B" + "." + sig.getName() + "(" + x + ")";
		targetnode = "B" + "." + sig_2.getName() + "(" + x + ")";
		System.out.println("Current method:" + nodes);
		System.out.println(
				"JoinPoint at:" + thisJoinPointStaticPart.getSourceLocation().getWithinType().getCanonicalName()
				+ "-->" + thisJoinPointStaticPart.getSourceLocation().getLine());
		System.out.println("Target method:" + targetnode);
		
		System.out.println(
				"JoinPoint at:" + thisEnclosingJoinPointStaticPart.getSourceLocation().getWithinType().getCanonicalName()
				+ "-->" + thisEnclosingJoinPointStaticPart.getSourceLocation().getLine());
		
		System.out.println("Before called ------");
		
		try(FileWriter fw = new FileWriter(filename, true);
			BufferedWriter bw = new BufferedWriter(fw);
			PrintWriter out = new PrintWriter(bw))
		{
			out.println(nodes);
			
		}catch(IOException e){
			System.out.println("Error Message.");
		}
	}
}
