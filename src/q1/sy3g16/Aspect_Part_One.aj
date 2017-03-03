package q1.sy3g16;

import q1.B;
import q1.Test;
import org.aspectj.lang.Signature;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public aspect Aspect_Part_One {
	
	public String currentnode;
	public String targetnode;
	public String nodefile = "./node.csv";
	public String edgefile = "./edge.csv";
	
	pointcut callnodes(B b): cflowbelow(call(public int q1..*(int)))
							 && target(b)
								&& within(B || Test);
	
	before(B b) : callnodes(b) {
		
		Signature sig = thisJoinPointStaticPart.getSignature();
		Signature sig_2 = thisEnclosingJoinPointStaticPart.getSignature();
		
		System.out.println("Before called ------");
		
		currentnode = "B" + "." + sig.getName() + "(int)";
		targetnode = "B" + "." + sig_2.getName() + "(int)";
		System.out.println("Current method:" + currentnode);
		System.out.println(
				"JoinPoint at:" + thisJoinPointStaticPart.getSourceLocation().getWithinType().getCanonicalName()
				+ "-->" + thisJoinPointStaticPart.getSourceLocation().getLine());
		System.out.println("Target method:" + targetnode);
		
		System.out.println(
				"JoinPoint at:" + thisEnclosingJoinPointStaticPart.getSourceLocation().getWithinType().getCanonicalName()
				+ "-->" + thisEnclosingJoinPointStaticPart.getSourceLocation().getLine());
			
			
		try(FileWriter fw = new FileWriter(nodefile, true);
			BufferedWriter bw = new BufferedWriter(fw);
			PrintWriter out = new PrintWriter(bw))
		{
			out.println(currentnode);
			
		}catch(IOException e){
			System.out.println("Error Message.");
		}
		
		if(currentnode.equals(targetnode)){}
		else{
			try(FileWriter fw_edge = new FileWriter(edgefile, true);
					BufferedWriter bw_edge = new BufferedWriter(fw_edge);
					PrintWriter out_edge = new PrintWriter(bw_edge))
				{
					out_edge.println(targetnode + "-->" + currentnode);
					
				}catch(IOException e){
					System.out.println("Error Message.");
				}
		}
		
		System.out.println("Close ------");
	}
}
