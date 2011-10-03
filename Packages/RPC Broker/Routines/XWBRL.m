XWBRL ;OIFO-Oakland/REM - M2M Link Methods ;05/31/2005  15:13
 ;;1.1;RPC BROKER;**28,34**;Mar 28, 1997
 ;
 QUIT
 ;
 ;p34 -make sure that XWBOS is define - WRITE.
 ;    -modified code to support the new meaning of $X in Cache 
 ;     5.x - WRITE.
 ;    -removed intervening lines that call WBF - WRITE.
 ;    -added code to include option for GTM - WBF.
 ;    -add line for XWBTCPM to read by Wally's non-call back service.
 ; 
 ; ---------------------------------------------------------------------
 ;                    Methods for Read from and to TCP/IP Socket
 ; ---------------------------------------------------------------------
READ(XWBROOT,XWBREAD,XWBTO,XWBFIRST,XWBSTOP) ;
 NEW X,EOT,OUT,STR,LINE,PIECES,DONE,TOFLAG,XWBCNT,XWBLEN
 SET STR="",EOT=$C(4),DONE=0,LINE=0
 ;From XWBTCPM startup, One time thing *p34
 I $D(XWBRBUF)=1 S STR=XWBRBUF,XWBTO=0,XWBFIRST=0 K XWBRBUF
 ;
 ; -- READ needs work for length checking ; This needs work!!
 FOR  READ XWBX#XWBREAD:XWBTO SET TOFLAG=$T DO CHK DO:'XWBSTOP  QUIT:DONE
 . IF $L(STR)+$L(XWBX)>400 DO ADD(STR) S STR=""
 . SET STR=STR_XWBX
 . FOR  Q:STR'[$C(10)  DO ADD($P(STR,$C(10))) SET STR=$P(STR,$C(10),2,999)
 . IF STR[EOT SET STR=$P(STR,EOT) DO ADD(STR) SET DONE=1 QUIT
 . SET PIECES=$L(STR,">")
 . IF PIECES>1 DO ADD($P(STR,">",1,PIECES-1)_">") SET STR=$P(STR,">",PIECES,999)
 ;
 QUIT 1
 ;
ADD(TXT) ; -- add new intake line
 SET LINE=LINE+1
 SET @XWBROOT@(LINE)=TXT
 QUIT
 ;
CHK ; -- check if first read and change timeout and chars to read
 IF 'TOFLAG,XWBFIRST SET XWBSTOP=1,DONE=1 QUIT  ; -- could cause small msg to not process
 SET XWBFIRST=0
 SET XWBREAD=100,XWBTO=2 ;M2M changed XWBTO=2 
 QUIT
 ;
 ;
 ; ---------------------------------------------------------------------
 ;                      Methods for Opening and Closing Socket
 ; ---------------------------------------------------------------------
OPEN(XWBPARMS) ; -- Open tcp/ip socket
 NEW I,POP
 SET POP=1
 DO INIT
 DO SAVDEV^%ZISUTL("XWBM2M CLIENT") ;M2M changed name
 FOR I=1:1:XWBPARMS("RETRIES") DO CALL^%ZISTCP(XWBPARMS("ADDRESS"),XWBPARMS("PORT")) QUIT:'POP
 ; Device open
 ;
 IF 'POP USE IO QUIT 1
 ; Device not open
 QUIT 0
 ;
CLOSE ; -- close tcp/ip socket
 ; -- tell server to Stop() connection
 I $G(XWBOS)="" D INIT
 DO PRE
 DO WRITE($$XMLHDR^XWBUTL()_"<vistalink type='Gov.VA.Med.Foundations.CloseSocketRequest' ></vistalink>")
 DO POST
 ;
 ; -Read results from server close string.  **M2M
 IF $G(XWBPARMS("CCLOSERESULTS"))="" SET XWBPARMS("CCLOSERESULTS")=$NA(^TMP("XWBM2MRL",$J,"XML"))
 SET XWBROOT=XWBPARMS("CCLOSERESULTS") K @XWBROOT
 SET XWBREAD=20,XWBTO=1,XWBFIRST=0,XWBSTOP=0
 SET XWBCOK=$$READ^XWBRL(XWBROOT,.XWBREAD,.XWBTO,.XWBFIRST,.XWBSTOP)
 ;
 DO FINAL
 DO CLOSE^%ZISTCP
 DO USE^%ZISUTL("XWBM2M CLIENT") ; Change name **M2M
 DO RMDEV^%ZISUTL("XWBM2M CLIENT")
 QUIT
 ;
INIT ; -- set up variables needed in tcp/ip processing
 SET XWBOS=$S(^%ZOSF("OS")["DSM":"DSM",^("OS")["UNIX":"UNIX",^("OS")["OpenM":"OpenM",1:"MSM")
 QUIT
 ;
FINAL ; -- kill variables used in tcp/ip processing
 KILL XWBOS,XWBOS,XWBPARMS,XWBPARMS
 QUIT
 ;
 ; ---------------------------------------------------------------------
 ;                          Methods for Writing to TCP/IP Socket
 ; ---------------------------------------------------------------------
PRE ; -- prepare socket for writing
 SET $X=0
 QUIT
 ;
WRITE(STR) ; -- Write a data string to socket
 ;*p34-removed intervening lines that call WBF.
 ;
 I $G(XWBOS)="" D INIT ;*p34-make sure XWBOS is defined.
 IF XWBOS="MSM" WRITE STR QUIT
 ; send data for DSM (requires buffer flush (!) every 511 chars)
 ; GT.M is the same as DSM. 
 ; Use an arbitrary value of 255 as the Write limit.
 ;IF XWBOS="DSM"!(XWBOS="UNIX")!(XWBOS="OpenM) next line
 ;
 ;*p34-modified write to for Cache 5 in case less then 255 char.
 F  Q:'$L(STR)  W $E(STR,1,255) D WBF S STR=$E(STR,256,99999)
 ;
 ;Old code**
 ;;I $L(STR)<255 D:($X+$L(STR))>255 WBF W STR Q
 ;;D:$X>0 WBF ;Flush what is in the buffer
 ;;F  D WBF Q:'$L(STR)  W $E(STR,1,255) S STR=$E(STR,256,$L(STR))
 ;;F  Q:'$L(STR)  W $E(STR,1,255) D WBF S STR=$E(STR,256,99999)
 ;
 QUIT
 ;
WBF ;Write Buffer Flush - W !
 ;p34-included option for GTM
 I $G(XWBOS)="" D INIT
 W @$S(XWBOS'["GTM":"!",1:"#") ;*p34
 Q
 ;
POST ; -- send eot and flush socket buffer
 DO WRITE($C(4)),WBF:$X>0
 QUIT
