VBECRL ;HOIFO/BNT - VBECS VistALink Client RawLink Methods ;07/27/2002  13:00
 ;;1.0;VBECS;;Apr 14, 2005;Build 35
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ;  Call to $$XMLHDR^XOBVLIB Supported by IA 4090
 ;  Call to %ZISTCP is supported by IA: 10104
 ;  Call to %ZISUTL is supported by IA: 2119
 ;  Call to ^%ZOSF is supported by IA: 10096
 ;
 QUIT
 ;
 ; ------------------------------------------------------------------------------------
 ;                          Methods for Read fromto TCP/IP Socket
 ; ------------------------------------------------------------------------------------
READ(VBECROOT,VBECREAD,VBECTO,VBECFRST,VBECSTOP) ;
 NEW X,EOT,OUT,STR,LINE,PIECES,DONE,TOFLAG,VBECCNT,VBECLEN,VBECBH,VBECEH,BS,ES,VBECOK,VBECX
 ;
 SET STR="",EOT=$C(4),DONE=0,LINE=0,VBECOK=1
 ;
 ; -- READ tcp stream to global buffer | main calling tags are EXECUTE^VBECVLC and NXTCALL^VBECVLL
 FOR  READ VBECX#VBECREAD:VBECTO SET TOFLAG=$T DO:VBECFRST CHK DO:'VBECSTOP  QUIT:DONE
 . ;
 . ; -- if length of (new intake + current) is too large for buffer then store current
 . ;IF $L(STR)+$L(VBECX)>400 DO ADD(STR) S STR=""
 . F  Q:$L(STR)+$L(VBECX)<512  D  Q:$L(STR)+$L(VBECX)<512
  . . I $L(STR),STR'[">" D ADD($E(STR,1,512)) S STR=$E(STR,513,99999) Q
  . . S VBECK1=$F(STR,">") D ADD($E(STR,1,(VBECK1-1))) S STR=$E(STR,VBECK1,99999)
 . SET STR=STR_VBECX
 . ;
 . ; -- add node at each line-feed character
 . FOR  QUIT:STR'[$C(10)  DO ADD($P(STR,$C(10))) SET STR=$P(STR,$C(10),2,999)
 . ;
 . ; -- if end-of-text marker found then wrap up and quit
 . IF STR[EOT SET STR=$P(STR,EOT) DO ADD(STR) SET DONE=1 QUIT
 . ; 
 . ; -- M XML parser cannot handle an element or attribute
 . ; -- name split across nodes
 . SET PIECES=$L(STR,">")
 . ;IF PIECES>1 DO ADD($P(STR,">",1,PIECES-1)_">") SET STR=$P(STR,">",PIECES,999)
 . I PIECES>1 D
  . . S VBECK1=$F(STR,">") D ADD($E(STR,1,(VBECK1-1)))
  . . S STR=$E(STR,VBECK1,99999)
 ;
 QUIT VBECOK
 ;
ADD(TXT) ; -- add new intake line
 SET LINE=LINE+1
 SET @VBECROOT@(LINE)=TXT
 QUIT
 ;
CHK ; -- check if first read and change timeout and chars to read
 IF 'TOFLAG,VBECFRST,$GET(VBECX)="" SET VBECSTOP=1,DONE=1 QUIT
 SET VBECFRST=0
 SET VBECREAD=100,VBECTO=1
 QUIT
 ;
 ; ------------------------------------------------------------------------------------
 ;                      Methods for Openning and Closing Socket
 ; ------------------------------------------------------------------------------------
OPEN(VBECPRMS) ; -- Open tcp/ip socket
 NEW I,POP
 SET POP=1
 DO INIT
 ;
 DO SAVDEV^%ZISUTL("VBECS CLIENT")
 FOR I=1:1:VBECPRMS("RETRIES") DO CALL^%ZISTCP(VBECPRMS("ADDRESS"),VBECPRMS("PORT")) QUIT:'POP
 ; Device open
 IF 'POP USE IO QUIT 1
 ; Device not open
 QUIT 'POP
 ;
CLOSE(VBECPRMS) ; -- close tcp/ip socket
 ; -- tell server to Stop() connection if close message is needed to close
 IF $GET(VBECPRMS("CLOSE MESSAGE"))]"" DO
 . DO PRE
 . DO WRITE($$XMLHDR^XOBVLIB()_VBECPRMS("CLOSE MESSAGE"))
 . DO POST
 ;
 DO FINAL
 DO CLOSE^%ZISTCP
 DO USE^%ZISUTL("VBECS CLIENT")
 DO RMDEV^%ZISUTL("VBECS CLIENT")
 QUIT
 ;
INIT ; -- set up variables needed in tcp/ip processing
 SET VBECOS=$S(^%ZOSF("OS")["DSM":"DSM",^("OS")["UNIX":"UNIX",^("OS")["OpenM":"OpenM",1:"MSM")
 QUIT
 ;
FINAL ; -- kill variables used in tcp/ip processing
 KILL VBECOS
 QUIT
 ;
 ; ------------------------------------------------------------------------------------
 ;                          Methods for Writing to TCP/IP Socket
 ; ------------------------------------------------------------------------------------
PRE ; -- prepare socket for writing
 SET $X=0
 QUIT
 ;
WRITE(STR) ; -- Write a data string to socket
 IF VBECOS="MSM" WRITE STR QUIT
 WRITE:($X+$L(STR))>511 !
 WRITE STR
 QUIT
 ;
POST ; -- send eot and flush socket buffer
 DO WRITE($C(4))
 WRITE:$X>0 !
 QUIT
 ;
