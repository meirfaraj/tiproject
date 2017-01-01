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

import com.google.common.base.CaseFormat;

public class ExportDoc {
	static final String relativeDir="/tiproject";
	public static void main(String[]args) throws IOException{
		Files.list(Paths.get(relativeDir+"/finance/src/cours/"))
		     .forEach(p->ExportDoc.luatize(p));
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
		   bw.write(name+" = Tmv("+baseId+"_TITLE_ID,"+baseId+"_TITLE_HEADER_ID)\n\n");

		   bw.write("function "+name+":performCalc()\n");
		   
		   Files.lines(p,Charset.forName("ISO-8859-1"))
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
		        .map(s->s.replaceAll("<br>","\\n"))
		        .map(s->s.replaceAll("[Ss]omme[\\[{]([a-zA-Z]+)[= ]+([0-9]+)[ ]*->[ ]*([0-9\".inft_sym]+)[\\]}][ ]*(.*)","\"..sum_sym..\"($4,$1,$2,$3)"))
		        .map(s->s.replaceAll("<math>","\n  self:appendMathToResult(\""))
		        .map(s->s.replaceAll("<u>","\n  self:appendTitleToResult(\""))
		        .map(s->s.replaceAll("<h1>","\n  self:appendTitleToResult(\""))
		        .map(s->s.replaceAll("<h2>","\n  self:appendTitleToResult(\""))
		        .map(s->s.replaceAll("<b>" ,"\n  self:appendBoldToResult(\""))
	            .forEach(s->new BufferedReader(new StringReader(s)).lines().forEach(s2->writeLuaLine(bw,s2)));	        
		   bw.write("\nend\n\n");



        } catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private static void writeLuaLine(BufferedWriter bw, String s) throws UncheckedIOException{
		try {
			if(!s.trim().startsWith("self:")){
				s = "  self:appendToResult(\""+s;
			}
			bw.write(s+"\")\n");
		} catch (IOException e) {
			throw new UncheckedIOException(e);
		}
	}
}
