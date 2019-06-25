UDEP6TRA ; OSE/SMH - OSEHRA Plan VI Translation API Calls &c;
 ;;1.0;OSEHRA;
 ;
 ;D TRANCPRS("/cygdrive/c/Users/Hp/Documents/Embarcadero/10.2/Projects/VistA/build/CPRS/CPRS-Chart/","CPRSChart.lng","de")
 ;D TRANCPRS("/cygdrive/c/Users/Hp/Documents/Embarcadero/10.2/Projects/VistA/build/CPRS/CPRS-Chart/","CPRSChart.lng","fr")
 ;D TRANCPRS("/cygdrive/c/Users/Hp/Documents/Embarcadero/10.2/Projects/VistA/build/CPRS/CPRS-Chart/","CPRSChart.lng","it")
 ;D TRANCPRS("/cygdrive/c/Users/Hp/Documents/Embarcadero/10.2/Projects/VistA/build/CPRS/CPRS-Chart/","CPRSChart.lng","ru")
 ;D TRANCPRS("/cygdrive/c/Users/Hp/Documents/Embarcadero/10.2/Projects/VistA/build/CPRS/CPRS-Chart/","CPRSChart.lng","ar")
 QUIT
TEST D EN^%ut($T(+0),3) QUIT
T1 ; @TEST Run Translation Test
 n out s out=$$TRAN("Hello, what is your name?","en","de")
 w out,!
 quit
 ;
TRAN(string,from,to,error) ; [Public $$] Translate string to another language
 ; Input: string (req) - string to translate
 ;          from (req) - language to translate from
 ;            to (req) - language to translate to
 ;        .error (opt) - a way to positively identify an error
 ;
 ; output: Translated string; or error number ^ error message
 ;
 ; Put the data into the JSON format the API wants
 ; NB: The VistA JSON encoder ALWAYS assumes that the top level entry is an object
 ;     That's why I add '[' and ']' to create an array rather than let the encoder do it.
 ;     I would like to fix that, but I don't want to today.
 n osedata s osedata("Text")=string
 n oseSendJSON d ENCODE^XLFJSON("osedata","oseSendJSON")
 s oseSendJSON(1)="["_oseSendJSON(1)_"]"
 ;
 ; url
 n url s url="https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&from="_from_"&to="_to
 ;
 ; API secret key & headers
 n key s key=$$ENV^%ZOSV("msTranslateAPIKey")
 i key="" w !!,"MS Translation API key not installed. quitting..." quit
 n oseguid D GETGUID^MDCLIO1(.oseguid)
 n oseSendHeaders
 s oseSendHeaders("Ocp-Apim-Subscription-Key")=key
 s oseSendHeaders("Content-Type")="application/json"
 s oseSendHeaders("X-ClientTraceId")=oseguid
 ;
 ; API call
 n oseOutput,oseHeaders
 n status s status=$$GETURL^XTHC10(url,15,"oseOutput",.oseHeaders,"oseSendJSON",.oseSendHeaders)
 n i f i=0:0 s i=$o(oseOutput(i)) q:'i  do
 . n j f j=0:0 s j=$o(oseOutput(i,j)) q:'j  s oseOutput(i)=oseOutput(i)_oseOutput(i,j)
 ;
 ; Decode JSON
 n oseTran
 d DECODE^XLFJSON("oseOutput","oseTran")
 ;
 ; Send back the translation or the error
 n out
 i status=200 s out=oseTran(1,"translations",1,"text")
 e  d 
 . s out=oseTran("error","code")_U_oseTran("error","message")
 . s error=out
 quit out
 ;
TRANCPRS(path,origfile,lang) ; [Public] Translate CPRS language file from Eng to lang
 ; ZEXCEPT: POP
 ; Clean-up from previous run
 do CLEANUP^XTHC10
 do CLOSE^%ZISH("FILE1")
 do CLOSE^%ZISH("FILE2")
 do RMDEV^%ZISUTL("HOME")
 ;
 new transfile
 set transfile=$p(origfile,".")_"."_lang_".lng"
 ;
 ; Set-up home and save it.
 do HOME^%ZIS
 do SAVDEV^%ZISUTL("HOME")
 ;
 ; Open Read from and write to files
 do OPEN^%ZISH("FILE1",path,origfile,"R")
 if POP write "Error reading origfile",! quit
 do OPEN^%ZISH("FILE2",path,transfile,"W")
 if POP write "Error writing transfile",! quit
 ;
 ; Tell web client not to close when making repeated calls
 d INIT^XTHC10(0)
 ;
 ; Switch to source file
 do USE^%ZISUTL("FILE1")
 ;
 ; Read each line
 new cnt set cnt=0
 new x for  read x:0  quit:$$STATUS^%ZISH  do
 . set cnt=cnt+1
 . ;
 . ; We can translate this...
 . if cnt>7,x["=" do  ; Items to translate start at 7
 . . new textToTranslate s textToTranslate=$piece(x,"=",2)
 . . new translatedText  s translatedText=$$TRAN(textToTranslate,"en",lang)
 . . set $p(x,"=",2)=translatedText
 . . do USE^%ZISUTL("HOME")
 . . write cnt,": ",x,!
 . . do USE^%ZISUTL("FILE1")
 . ;
 . ; Write the line (whether translated or not) to the destination file
 . do USE^%ZISUTL("FILE2")
 . write x,!
 . do USE^%ZISUTL("FILE1")
 ;
 ; Close files and Clean-up and close web client
 do CLOSE^%ZISH("FILE1")
 do CLOSE^%ZISH("FILE2")
 do RMDEV^%ZISUTL("HOME")
 do CLEANUP^XTHC10
 quit
