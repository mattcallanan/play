//    val filesHere = (new java.io.File(".")).listFiles

    val filesHere = for { file <- new java.io.File(".").listFiles if file.getName.endsWith("scala") } yield file

    def fileLines(file: java.io.File) = 
      scala.io.Source.fromFile(file).getLines.toList
  
    def grep(pattern: String) =
      for (
        file <- filesHere
        if file.getName.endsWith(".scala");
        line <- fileLines(file)
        if line.trim.matches(pattern) 
      ) println(file +": "+ line.trim)
  
    def grep2(pattern: String) = {
      for (file <- filesHere) {
          for (line <- fileLines(file) if line.trim.matches(pattern))
              println(file +": "+ line.trim)
      }
    }
  
    def grep3(pattern: String) = {
      for {
          file <- filesHere
          line <- fileLines(file) 
          trimmed = line.trim        // mid-stream variable (implied "val")
          if trimmed.matches(pattern)
      }
      println(file +": "+ trimmed)
    }
  
//    grep(".*gcd.*")
//    grep2(".*" + args(0) + ".*")
   grep3(".*" + args(0) + ".*")
