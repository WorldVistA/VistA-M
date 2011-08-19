XOBVSKT ;; mjk/alb - VistaLink Socket Methods ; 07/27/2002  13:00
 ;;1.6;VistALink;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ; ------------------------------------------------------------------------------------
 ;                          Methods for Read from/to TCP/IP Socket
 ; ------------------------------------------------------------------------------------
READ(XOBROOT,XOBREAD,XOBTO,XOBFIRST,XOBSTOP,XOBDATA,XOBHDLR) ;
 NEW X,EOT,OUT,STR,LINE,PIECES,DONE,TOFLAG,XOBCNT,XOBLEN,XOBBH,XOBEH,BS,ES,XOBOK,XOBX
 ;
 SET STR="",EOT=$CHAR(4),DONE=0,LINE=0,XOBOK=1
 ;
 ; -- READ tcp stream to global buffer | main calling tag NXTCALL^XOBVLL
 FOR  READ XOBX#XOBREAD:XOBTO SET TOFLAG=$TEST DO:XOBFIRST CHK DO:'XOBSTOP!('DONE)  QUIT:DONE
 . ;
 . ; -- if length of (new intake + current) is too large for buffer then store current
 . IF $LENGTH(STR)+$LENGTH(XOBX)>400 DO ADD(STR) SET STR=""
 . SET STR=STR_XOBX
 . ;
 . ; -- add node at each line-feed character
 . ; COMMENTED OUT: Not needed anymore, and has side effect of stripping out line feeds in input
 . ;                array-type parameter values (in XML mode)
 . ; FOR  QUIT:STR'[$CHAR(10)  DO ADD($PIECE(STR,$CHAR(10))) SET STR=$PIECE(STR,$CHAR(10),2,999)
 . ;
 . ; -- if end-of-text marker found then wrap up and quit
 . IF STR[EOT SET STR=$PIECE(STR,EOT) DO ADD(STR) SET DONE=1 QUIT
 . ; 
 . ; -- M XML parser cannot handle an element name split across nodes
 . SET PIECES=$LENGTH(STR,">")
 . IF PIECES>1 DO ADD($PIECE(STR,">",1,PIECES-1)_">") SET STR=$PIECE(STR,">",PIECES,999)
 ;
 QUIT XOBOK
 ;
ADD(TXT) ; -- add new intake line
 SET LINE=LINE+1
 SET @XOBROOT@(LINE)=TXT
 QUIT
 ;
CHK ; -- check if first read and change timeout and chars to read
 SET XOBFIRST=0
 ;
 ; -- abort if time out occurred and nothing was read
 IF 'TOFLAG,$GET(XOBX)="" SET XOBSTOP=1,DONE=1,XOBOK=0 QUIT
 ;
 ; -- intercept for transport sinks
 IF $EXTRACT(XOBX)'="<" DO SINK
 ;
 ; -- set up for subsequent reads
 SET XOBREAD=200,XOBTO=1
 QUIT
 ;
 ; ------------------------------------------------------------------------------------
 ;                      Execute Proprietary Format Reader
 ; ------------------------------------------------------------------------------------
SINK ;
 ; -- get size of sink indicator >> then get sink indicator >> load req handler
 SET XOBHDLR=$$MSGSINK^XOBVRH($$GETSTR(+$$GETSTR(2,.XOBX),.XOBX),.XOBHDLR)
 ;
 ; -- execute proprietary stream reader
 IF $GET(XOBHDLR(XOBHDLR)) XECUTE $GET(XOBHDLR(XOBHDLR,"READER"))
 ;
 SET DONE=1
 QUIT
 ;
 ; -- get string of length LEN from stream buffer
GETSTR(LEN,XOBUF) ;
 NEW X
 FOR  QUIT:($LENGTH(XOBUF)'<LEN)  DO RMORE(LEN-$LENGTH(XOBUF),.XOBUF)
 SET X=$EXTRACT(XOBUF,1,LEN)
 SET XOBUF=$EXTRACT(XOBUF,LEN+1,999)
 QUIT X
 ;
 ; -- read more from stream buffer but only needed amount
RMORE(LEN,XOBUF) ;
 NEW X
 READ X#LEN:1 SET XOBUF=XOBUF_X
 QUIT
 ;
 ; ------------------------------------------------------------------------------------
 ;                      Methods for Opening and Closing Socket
 ; ------------------------------------------------------------------------------------
OPEN(XOBPARMS) ; -- Open tcp/ip socket
 NEW I,POP
 SET POP=1
 ;
 ; -- set up os var
 DO OS
 ;
 ; -- preserve client io
 DO SAVDEV^%ZISUTL("XOB CLIENT")
 ;
 FOR I=1:1:XOBPARMS("RETRIES") DO CALL^%ZISTCP(XOBPARMS("ADDRESS"),XOBPARMS("PORT")) QUIT:'POP
 ; -- device open
 IF 'POP USE IO QUIT 1
 ; -- device not open
 QUIT 0
 ;
CLOSE(XOBPARMS) ; -- close tcp/ip socket
 ; -- tell server to Stop() connection if close message is needed to close
 IF $GET(XOBPARMS("CLOSE MESSAGE"))]"" DO
 . DO PRE
 . DO WRITE($$XMLHDR^XOBVLIB()_XOBPARMS("CLOSE MESSAGE"))
 . DO POST
 ;
 DO FINAL
 DO CLOSE^%ZISTCP
 DO USE^%ZISUTL("XOB CLIENT")
 DO RMDEV^%ZISUTL("XOB CLIENT")
 QUIT
 ;
INIT ; -- set up variables needed in tcp/ip processing
 KILL XOBNULL
 ;
 ; -- setup os var
 DO OS
 ;
 ; -- set RPC Broker os variable (so $$BROKER^XWBLIB returns true)
 SET XWBOS=XOBOS
 ;
 ; -- setup null device called "NULL"
 SET %ZIS="0H",IOP="NULL" DO ^%ZIS
 IF 'POP DO
 . SET XOBNULL=IO
 . DO SAVDEV^%ZISUTL("XOBNULL")
 QUIT
 ;
OS ; -- os var
 SET XOBOS=$SELECT(^%ZOSF("OS")["OpenM":"OpenM",^("OS")["DSM":"DSM",^("OS")["UNIX":"UNIX",^("OS")["MSM":"MSM",1:"")
 QUIT
 ;
FINAL ; -- kill variables used in tcp/ip processing
 ;
 ; -- close null device
 IF $DATA(XOBNULL) DO
 . DO USE^%ZISUTL("XOBNULL")
 . DO CLOSE^%ZISUTL("XOBNULL")
 . KILL XOBNULL
 ;
 KILL XOBOS,XWBOS
 ;
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
 IF XOBOS="MSM" WRITE STR QUIT
 ; 
 ; -- handle a short string
 IF $LENGTH(STR)<511 DO:($X+$LENGTH(STR))>511 FLUSH WRITE STR QUIT
 ;
 ; -- handle a long string
 DO FLUSH
 FOR  QUIT:'$LENGTH(STR)  WRITE $EXTRACT(STR,1,511) DO FLUSH SET STR=$EXTRACT(STR,512,99999)
 ;
 QUIT
 ;
POST ; -- send eot and flush socket buffer
 DO WRITE($CHAR(4))
 DO FLUSH
 QUIT
 ;
FLUSH ; flush buffer
 IF XOBOS="OpenM" WRITE ! QUIT
 IF XOBOS="DSM" WRITE:$X>0 ! QUIT
 ;IF XOBOS="GTM" WRITE # QUIT
 QUIT
 ;
