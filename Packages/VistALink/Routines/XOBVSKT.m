XOBVSKT ;alb/mjk - VistaLink Socket Methods ;07/27/2002
 ;;1.6;VistALink;**3**;May 08, 2009;Build 17
 ;Per VHA Directive 6402, this routine should not be modified
 Q
 ;
 ; ------------------------------------------------------------------------------------
 ;                          Methods for Read from/to TCP/IP Socket
 ; ------------------------------------------------------------------------------------
READ(XOBROOT,XOBREAD,XOBTO,XOBFIRST,XOBSTOP,XOBDATA,XOBHDLR) ;
 N X,EOT,OUT,STR,LINE,PIECES,DONE,TOFLAG,XOBCNT,XOBLEN,XOBBH,XOBEH,BS,ES,XOBOK,XOBX,SAML
 ;
 S STR="",EOT=$C(4),DONE=0,LINE=0,XOBOK=1,SAML=0
 ;
 ; -- READ tcp stream to global buffer | main calling tag NXTCALL^XOBVLL
 F  R XOBX#XOBREAD:XOBTO S TOFLAG=$T D:XOBFIRST CHK D:'XOBSTOP!('DONE)  Q:DONE
 . ;
 . ; -- if length of (new intake + current) is too large for buffer then store current
 . I $L(STR)+$L(XOBX)>400 D ADD(STR) S STR=""
 . S STR=STR_XOBX
 . ;
 . ; -- if end-of-text marker found then wrap up and quit
 . I STR[EOT S STR=$P(STR,EOT) D ADD(STR) S DONE=1 Q
 . ; 
 . ; -- M XML parser cannot handle an element name split across nodes
 . S PIECES=$L(STR,">")
 . I PIECES>1 D ADD($P(STR,">",1,PIECES-1)_">") S STR=$P(STR,">",PIECES,999)
 .Q
 ;
 K ^TMP($J,"SAML")
 I $G(^XTMP($J,"SAML")) D
 . S NC=2,NC1=1 F  S NC=$O(^XTMP($J,"SAML",NC)) Q:$G(NC)'>0  S ^TMP($J,"SAML",NC1)=$G(^XTMP($J,"SAML",NC)),NC1=NC1+1
 ;
 Q XOBOK
 ;
ADD(TXT) ; -- add new intake line
 S LINE=LINE+1
 S @XOBROOT@(LINE)=TXT
 S:TXT["SAML"&($G(SAML)'=2) SAML=1 S:$G(SAML)=1&($G(TXT)["<soapenv:Envelope") SAML=2
 S:TXT["]]" SAML=3
 S:$G(SAML)=2 ^XTMP($J,"SAML",LINE)=$G(TXT)
 S:$G(SAML)=3 ^XTMP($J,"SAML",LINE)=$P(TXT,"]]",1)_"]]"
 Q
 ;
CHK ; -- check if first read and change timeout and chars to read
 S XOBFIRST=0
 ;
 ; -- abort if time out occurred and nothing was read
 I 'TOFLAG,$G(XOBX)="" S XOBSTOP=1,DONE=1,XOBOK=0 Q
 ;
 ; -- intercept for transport sinks
 I $E(XOBX)'="<" D SINK
 ;
 ; -- set up for subsequent reads
 S XOBREAD=200,XOBTO=1
 Q
 ;
 ; ------------------------------------------------------------------------------------
 ;                      Execute Proprietary Format Reader
 ; ------------------------------------------------------------------------------------
SINK ;
 ; -- get size of sink indicator >> then get sink indicator >> load req handler
 S XOBHDLR=$$MSGSINK^XOBVRH($$GETSTR(+$$GETSTR(2,.XOBX),.XOBX),.XOBHDLR)
 ;
 ; -- execute proprietary stream reader
 I $G(XOBHDLR(XOBHDLR)) X $G(XOBHDLR(XOBHDLR,"READER"))
 ;
 S DONE=1
 Q
 ;
 ; -- get string of length LEN from stream buffer
GETSTR(LEN,XOBUF) ;
 N X
 F  Q:($L(XOBUF)'<LEN)  D RMORE(LEN-$L(XOBUF),.XOBUF)
 S X=$E(XOBUF,1,LEN)
 S XOBUF=$E(XOBUF,LEN+1,999)
 Q X
 ;
 ; -- read more from stream buffer but only needed amount
RMORE(LEN,XOBUF) ;
 N X
 R X#LEN:1 S XOBUF=XOBUF_X
 Q
 ;
 ; ------------------------------------------------------------------------------------
 ;                      Methods for Opening and Closing Socket
 ; ------------------------------------------------------------------------------------
OPEN(XOBPARMS) ; -- Open tcp/ip socket
 N I,POP
 S POP=1
 ;
 ; -- set up os var
 D OS
 ;
 ; -- preserve client io
 D SAVDEV^%ZISUTL("XOB CLIENT")
 ;
 F I=1:1:XOBPARMS("RETRIES") D CALL^%ZISTCP(XOBPARMS("ADDRESS"),XOBPARMS("PORT")) Q:'POP
 ; -- device open
 I 'POP U IO Q 1
 ; -- device not open
 Q 0
 ;
CLOSE(XOBPARMS) ; -- close tcp/ip socket
 ; -- tell server to Stop() connection if close message is needed to close
 I $G(XOBPARMS("CLOSE MESSAGE"))]"" D
 . D PRE
 . D WRITE($$XMLHDR^XOBVLIB()_XOBPARMS("CLOSE MESSAGE"))
 . D POST
 ;
 D FINAL
 D CLOSE^%ZISTCP
 D USE^%ZISUTL("XOB CLIENT")
 D RMDEV^%ZISUTL("XOB CLIENT")
 Q
 ;
INIT ; -- set up variables needed in tcp/ip processing
 K XOBNULL
 ;
 ; -- setup os var
 D OS
 ;
 ; -- set RPC Broker os variable (so $$BROKER^XWBLIB returns true)
 S XWBOS=XOBOS
 ;
 ; -- setup null device called "NULL"
 S %ZIS="0H",IOP="NULL" D ^%ZIS
 I 'POP D
 . S XOBNULL=IO
 . D SAVDEV^%ZISUTL("XOBNULL")
 Q
 ;
OS ; -- os var
 S XOBOS=$S(^%ZOSF("OS")["OpenM":"OpenM",^("OS")["DSM":"DSM",^("OS")["UNIX":"UNIX",^("OS")["MSM":"MSM",1:"")
 Q
 ;
FINAL ; -- kill variables used in tcp/ip processing
 ;
 ; -- close null device
 I $D(XOBNULL) D
 . D USE^%ZISUTL("XOBNULL")
 . D CLOSE^%ZISUTL("XOBNULL")
 . K XOBNULL
 ;
 K XOBOS,XWBOS
 ;
 Q
 ;
 ; ------------------------------------------------------------------------------------
 ;                          Methods for Writing to TCP/IP Socket
 ; ------------------------------------------------------------------------------------
PRE ; -- prepare socket for writing
 S $X=0
 Q
 ;
WRITE(STR) ; -- Write a data string to socket
 I XOBOS="MSM" W STR Q
 ; 
 ; -- handle a short string
 I $L(STR)<511 D:($X+$L(STR))>511 FLUSH W STR Q
 ;
 ; -- handle a long string
 D FLUSH
 F  Q:'$L(STR)  W $E(STR,1,511) D FLUSH S STR=$E(STR,512,99999)
 ;
 Q
 ;
POST ; -- send eot and flush socket buffer
 D WRITE($C(4))
 D FLUSH
 Q
 ;
FLUSH ; flush buffer
 I XOBOS="OpenM" W ! Q
 I XOBOS="DSM" W:$X>0 ! Q
 ;IF XOBOS="GTM" WRITE # QUIT
 Q
 ;
