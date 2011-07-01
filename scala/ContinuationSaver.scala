object ContinuationSaver {
    var numberOfSavedContinuations = 0
    var savedContinuation:Option[()=>Unit] = None
    def save(saveCont: =>Unit):Int = {
        savedContinuation = saveCont _
        numberOfSavedContinuations = numberOfSavedContinuations + 1
        numberOfSavedContinuations
    }
    
    def sub(m:M,x:X, subCont: (Y) => Unit):Int = {
        val y:Y = substuff(m,x)
        ContinuationSaver.save { subCont(y) }
    }

}
