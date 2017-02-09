package tiproject;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringReader;
import java.io.UncheckedIOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

import com.google.common.base.CaseFormat;

public class ExportDoc {
	static final String relativeDir="/tiproject";
	public static void main(String[]args) throws IOException{
		Files.list(Paths.get(relativeDir+"/finance/src/cours/"))
		     .forEach(p->ExportDoc.luatize(p));
	}
	
	static class Subject {
		public Subject(String subject) {
			this.subject=subject;
		}
		final String subject;
		List<String> lines = new LinkedList<>();
	}
	
	public static void luatize(Path p){
		String outputName = relativeDir+"/finance/src/finance/tmv/cours/mathfi/gen/"+p.getFileName().toString().replaceAll("é", "e").replaceAll(".txt", ".lua");
		try(BufferedWriter bw = new BufferedWriter(new FileWriter(new File(outputName)))){
		   bw.write("--------------------------------------------------------------------------\n");
		   bw.write("-- cours exported from "+p.getFileName().toString()+"\n");
		   bw.write("--------------------------------------------------------------------------\n\n");
		   bw.write("\n");
		   String name=p.getFileName().toString().replaceAll(".txt", "").replaceAll("é", "e");
		   name = CaseFormat.LOWER_CAMEL.to(CaseFormat.UPPER_CAMEL, name);
		   String baseId = CaseFormat.UPPER_CAMEL.to(CaseFormat.UPPER_UNDERSCORE, name);
           System.out.println(baseId+"_TITLE_ID");
           System.out.println(baseId+"_TITLE_HEADER_ID");
		   bw.write(name+" = Tmv("+baseId+"_TITLE_ID,"+baseId+"_TITLE_HEADER_ID)\n\n");


		   //result
		   LinkedList<Subject> subjects = new LinkedList<>();
		   subjects.add(new Subject("cours"));
		   
		   
		   Files.lines(p,Charset.forName("ISO-8859-1"))
		        .map(s->{
		            if(s.matches("\\s*<[pP]>.*</[pP]>\\s*")){
		            	subjects.add(new Subject(s.replaceAll("(\\s*<[pP]>)(.*)(</[pP]>\\s*)","$2")));
		            	return "<u>"+subjects.getLast().subject+"</u>";
		            }
		            return s;
		        })
		        .map(s->s.replaceAll("é","\"..e_acute..\""))
		        .map(s->s.replaceAll("ê","\"..e_circ ..\""))
		        .map(s->s.replaceAll("è","\"..e_grave..\""))
		        .map(s->s.replaceAll("ù","\"..u_grave..\""))
		        .map(s->s.replaceAll("…","\"..points_susp..\""))
		        .map(s->s.replaceAll("à","\"..a_grave..\""))
		        .map(s->s.replaceAll("€", "\"..euro_sym..\""))
		        .map(s->s.replaceAll("infinity", "\"..infinit_sym..\""))
		        .map(s->s.replaceAll("</math>","\n"))
		        .map(s->s.replaceAll("</h1>","\n"))
		        .map(s->s.replaceAll("</h2>","\n"))
		        .map(s->s.replaceAll("</b>","\n"))
		        .map(s->s.replaceAll("</u>","\n"))
		        .map(s->s.replaceAll("<br>","\\\\n"))
		        .map(s->s.replaceAll("[Ss]omme[\\[{]([a-zA-Z]+)[= ]+([0-9]+)[ ]*->[ ]*([0-9\".inft_sym]+)[\\]}][ ]*(.*)","\"..sum_sym..\"($4,$1,$2,$3)"))
		        .map(s->s.replaceAll("<math>","\n  self:appendMathToResult(\""))
		        .map(s->s.replaceAll("<u>","\n  self:appendTitleToResult(\""))
		        .map(s->s.replaceAll("<h1>","\n  self:appendTitleToResult(\""))
		        .map(s->s.replaceAll("<h2>","\n  self:appendTitleToResult(\""))
		        .map(s->s.replaceAll("<b>" ,"\n  self:appendBoldToResult(\""))
		        .map(s->s.replaceAll("[tT]heta", "\"..c_theta..\""))
		        .map(s->s.replaceAll("[Ss]igma", "\"..c_sigma..\""))
		        .map(s->s.replaceAll("[Rr]ho", "\"..c_rho..\""))
		        .map(s->s.replaceAll("[bB]eta", "\"..c_beta..\""))
		        .map(s->s.replaceAll("[eE]psilon", "\"..c_epsilon..\""))
		        .forEach(s->new BufferedReader(new StringReader(s)).lines().forEach(s2->subjects.getLast().lines.add(getLuaLine(s2))));
		        
		   if(subjects.size()>1){
			   bw.write("function "+name+":widgetsInit()\n");
			   String res=subjects.stream().map(s->"\""+s.subject+"\"").collect(Collectors.joining(",", "     self:add(-1,{", "},\"curTtl\",true)"));
			   bw.write(res);
               bw.write("\nend\n\n");
		   }
		        //.forEach(s->);	        
		   bw.write("function "+name+":performCalc()\n");
		   if(subjects.size()>1){

			   write(bw,"self.operation = \"\"\n");
			   for(Subject s:subjects){
				   write(bw,"  if varValue[\"curTtl\"] == \""+s.subject+"\" then\n");
  	 	  		       s.lines.forEach(s2->write(bw,s2));
  	 	  		  write(bw,"        return\n     end\n\n");
			   }
		   }
		   else{
			   subjects.getLast().lines.forEach(s->write(bw,s));
		   }
		   bw.write("\nend\n\n");



        } catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private static String getLuaLine(String s) {
		if(!s.trim().startsWith("self:")){
			s = "  self:appendToResult(\""+s;
		}
		return s+"\")\n";
	}
	
	private static void write(BufferedWriter bw, String s) throws UncheckedIOException{
		try {
			if(!s.endsWith("\n")){
				s=s+"\n";
			}
			bw.write(s);
		} catch (IOException e) {
			throw new UncheckedIOException(e);
		}
	}
}
