ghc ch9b_mirror && ch9b_mirror abc.txt abc.out && ch9b_mirror abc.out abc.back && diff abc.txt abc.back
@echo ERRORLEVEL: %ERRORLEVEL%