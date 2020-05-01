**<h4>Simple Lexical Analyzer for VC Language for Compiler class </h4>**
<h5>Files</h5>
  src/jar/Compiler.jar: sample compiled jar.
  src/main/java/GUI: simple GUI components, written in javaFX.
  src/main/java/Lex: generated Lexer files, modified to be compatible with the GUI.s
  src/main/cup/VC.cup: just for demonstration here, but needed for jflex to generate the lexer.
  src/main/jflex/VC.flex: just for demonstration here, but needed for jflex to generate the lexer.
  src/test/data/test.txt: simple sample input.

<h5>Package</h5>
  > mvn package

The package phase does everything above and packages the jar archive of the Java classes. You can then run
    
  > java -jar target/Compiler-SNAPSHOT-1.0.jar src/test/data/test.txt(or file path) 

This command will run the GUI, simply click the button to choose a filee (.txt) and the result will be shown in the text area.
