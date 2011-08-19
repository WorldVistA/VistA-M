HLEVSRV ;O-OIFO/LJA - Event Monitor SERVER ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
 ; Send email to S.XQSCHK@SITE.VA.GOV to check server status.
 ; (Include the name of server (w/o S.) in body of message.)
 ;
SERVER ; Called to get information about local monitoring system
 N ADDREQHD,MXEC,NOW,XMER,XMPOS,XMRG,XTMP
 ;
 ;[M]S MXEC=$$MST^HLEVSRV1 ; Is M code execution allowed?
 ;
 S NOW=$$NOW^XLFDT,XTMP="HLEV SERVER "_NOW
 S ^XTMP(XTMP,0)=$$FMADD^XLFDT(NOW,2)_U_NOW_"^HLEV SERVER REQUEST^"_$G(XMFROM)
 ;
 I $G(XMZ)'>0!($G(XMREC)']"") D  QUIT  ;->
 .  S ^XTMP(XTMP,"ERR")="No XMZ or XMREC"
 ;
 S ^XTMP(XTMP,"MAIL")=XMZ
 ;
 S XMPOS=""
 ;
READ ; Sequentially read thru message
 X XMREC
 I $D(XMER) G PROCESS:XMER<0 ;->
 D ADDLINE(XMRG)
 G READ ;->
 ;
 ;======================================================================
 ;
PROCESS ; Multiple "data request" formats possible...
 ;[M]; MXEC -- req
 N SUB
 ;
 D EXTRACT
 D REQBACK ; Echo what was requested
 ;
 ;[M]S MXEC=$P(MXEC,U)+$P(MXEC,U,4)
 ;[M]I MXEC=2 D  QUIT:$G(HLEVQUIT)  ;-> Pre-load M code execution
 ;[M].  D MPRE^HLEVSRV0
 D LOADATA
 ;[M]I MXEC=2 D  QUIT:$G(HLEVQUIT)  ;-> Post-load M code execution
 ;[M].  D MPST^HLEVSRV0
 ;[M].  D MCOND^HLEVSRV0
 ;[M].  D MCALLREC^HLEVSRV0
 ;[M].  D MTEXT^HLEVSRV0
 D XTMPMAIL ; Place at bottom of message XTMP value
 D MAILIT
 D KILLS
 ;
 Q
 ;
 ;======================================================================
 ;
EXTRACT ; Extract out the work list...
 ; XTMP -- req
 N CT,FILE,LNO,TXT
 S LNO=0,CT=0
 F  S LNO=$O(^XTMP(XTMP,"RQ",LNO)) Q:LNO'>0  D
 .  S TXT=$$CHKREQ($G(^XTMP(XTMP,"RQ",LNO))) QUIT:TXT']""  ;->
 .  S FILE=$P(TXT,U) ; Type of request in "FILE"...
 .
 .  ; There are 3 types of "data requests"...
 .  I FILE="QUERY" D EXTQUERY($P(TXT,U,2,99)) QUIT  ;-> $QUERY format...
 .  I FILE="UNIT" D UNIT^HLEVSRV0($P(TXT,U,2,99)) QUIT  ;-> Msg ID
 .  I $$OKFILE(+FILE) D EXTFILE(TXT) QUIT  ;->
 .
 .  ; If not a data request, must be a non-VistA HL7 request.  And,
 .  ; if so, they have to pass a license
 .  I FILE="LICENSE" D CHKLIC^HLEVSRV4($P(TXT,U,2,99),$G(XMFROM)) QUIT  ;->
 .
 .  D ADDREQHD,ADDREQ("Error (HEADER)^"_TXT)
 Q
 ;
CHKREQ(TXT) ; Check request, strip comments, etc...
 N I
 ;
 ; Strip comments...
 I $L(TXT,";")>1 S TXT=$P(TXT,";",1,$L(TXT,";")-1)
 ;
 ; Ignore blank lines, and dashed lines...
 QUIT:$TR(TXT," -=;")']"" "" ;->
 ;
 ; Strip leading and trailing spaces...
 X "F I=1:1:$L(TXT) Q:$E(TXT,I)'="" """ S TXT=$E(TXT,I,999) ; Leading
 X "F I=$L(TXT):-1:1 Q:$E(TXT,I)'="" """ S TXT=$E(TXT,1,I) ;  Trailing
 ;
 Q TXT
 ;
LOADATA ; Process the work list...
 D LOADFNO
 D LOADQRY
 D LOADUNIT^HLEVSRV0 ; Msg ID-related data
 D GBLTOXM^HLEVSRV1 ; 776 format data to send back
 Q
 ;
LOADFNO ; Load data from file number...
 N FILE,NODE,WHAT
 D ADDMAIL("")
 S FILE=0
 F  S FILE=$O(^XTMP(XTMP,"HLEV PROC","F",FILE)) Q:FILE'>0  D
 .  S WHAT=""
 .  F  S WHAT=$O(^XTMP(XTMP,"HLEV PROC","F",FILE,WHAT)) Q:WHAT']""  D
 .  .  S NODE=""
 .  .  F  S NODE=$O(^XTMP(XTMP,"HLEV PROC","F",FILE,WHAT,NODE)) Q:NODE']""  D
 .  .  .  S LIMIT=$G(^XTMP(XTMP,"HLEV PROC","F",FILE,WHAT,NODE))
 .  .  .  D LOAD(FILE,WHAT,NODE,LIMIT)
 Q
 ;
LOADQRY ; Load $QUERY data...
 N NO
 ;
 QUIT:'$D(^XTMP(XTMP,"HLQUERY"))  ;->
 D ADDMAIL("")
 D ADDMAIL("$QUERY Data"),ADDMAIL($$REPEAT^XLFSTR("-",74))
 ;
 ; Load $QUERY format data...
 S NO=0
 F  S NO=$O(^XTMP(XTMP,"HLQUERY",NO)) Q:NO'>0  D
 .  D LOADQ(^XTMP(XTMP,"HLQUERY",+NO))
 ;
 Q
 ;
REQBACK ; Send back what was requested...
 N SNO
 ;
 S SNO=0
 F  S SNO=$O(^XTMP(XTMP,"HLREQ",SNO)) Q:SNO'>0  D
 .  D ADDMAIL(^XTMP(XTMP,"HLREQ",SNO))
 ;
 Q
 ;
XTMPMAIL ; Add XTMP reference to bottom of email...
 D ADDMAIL(""),ADDMAIL("")
 D ADDMAIL("Remote request by: "_$G(XMFROM)),ADDMAIL("")
 D ADDMAIL("[Query log stored in ^XTMP("""_XTMP_""") at site.]")
 Q
 ;
MAILIT ; Mail report back to HL7 mail group...
 ; XTMP -- req
 N NO,TEXT,X,XMDUZ,XMSUB,XMTEXT,XMZ
 S XMDUZ=.5,XMTEXT="^XTMP("""_XTMP_""",""HLMAIL"","
 S X=$$SITE^VASITE,XMSUB="HLEV SERVER REQUEST "_$P(X,U,2)_" [#"_$P(X,U,3)_"]"
 ;
 ; Only send to VistA HL7 team members!!!!
 S XMY("HL7SystemMonitoring@med.va.gov")=""
 ;
 D ^XMD
 ;
 S $P(^XTMP(XTMP,"MAIL"),U,2)=$G(XMZ)
 ;
 QUIT
 ;
KILLS ; Remove unwanted ^XTMP subscripts...
 F SUB="DATA","HLEV PROC","HLMAIL","HLUNIT","HLQUERY","HLREQ","M","MTXT" D
 .  KILL ^XTMP(XTMP,SUB)
 ;
 Q
 ;
 ; =====================================================================
 ;
LOAD(FILE,WHAT,NODE,LIMIT) ;
 N CT,DATA,GBL,IEN
 ;
 S LIMIT=$G(LIMIT)
 S GBL=$$GBLFILE(+FILE) QUIT:GBL']""  ;->
 ;
 ; If passed in an IEN...
 I WHAT=+WHAT D LOADONE(FILE,+WHAT,NODE),ADDMAIL("")
 ;
 ; Check to make sure it is ALL...
 QUIT:WHAT'["ALL"  ;->
 ;
 S IEN=0,CT=0,LIMIT=$S(LIMIT:LIMIT,1:99999)
 F  S IEN=$O(@GBL@(IEN)) Q:IEN'>0!(CT>(LIMIT-1))  D
 .  D LOADONE(FILE,+IEN,NODE,LIMIT)
 .  S CT=CT+1
 ;
 I CT D ADDMAIL("")
 ;
 Q
 ;
LOADONE(FILE,IEN,NODE,LIMIT) ; Load one entry...
 N DATA,GBL,MIEN,MONM,ND,TXT
 ;
 S LIMIT=$G(LIMIT)
 S GBL=$$GBLFILE(+FILE) QUIT:GBL']""  ;->
 ;
 ; Node (not multiple or WP) requested...
 I $D(@GBL@(+IEN,NODE))#2 D  QUIT  ;->
 .  S DATA=$G(@GBL@(+IEN,NODE))
 .  S ^XTMP(XTMP,"DATA",FILE,+IEN,NODE)=DATA
 ;
 Q
 ;
 ; =====================================================================
 ;
EXTFILE(TXT) ; Extract 776 data...
 N FILE,GBL,LIMIT,LOOPI,NODES,WHAT
 ;
 ; Sets...
 S FILE=+TXT,GBL=$$GBLFILE(FILE) QUIT:GBL']""  ;->
 S WHAT=$P(TXT,U,2)
 I WHAT']"" S WHAT="ALL"
 I WHAT=+WHAT QUIT:$G(@GBL@(+WHAT,0))']""  ;->
 S NODES=$TR($P(TXT,U,3),"~",U),LIMIT=$P(TXT,U,4)
 ;
 ; Build nodes requested list...
 F LOOPI=1:1:$L(NODES,U) S NODE=$P(NODES,U,LOOPI) I NODE]"" D
 .  S ^XTMP(XTMP,"HLEV PROC","F",FILE,WHAT,NODE)=LIMIT
 .  D ADDREQHD
 .  S TXT=$E("[#1] "_FILE_$S(LIMIT:" #"_LIMIT,1:"")_$$REPEAT^XLFSTR(" ",18),1,18)
 .  I LOOPI>1 S LIMIT=""
 .  S TXT=TXT_$E("[#2] "_$S(WHAT=+WHAT:"#"_WHAT,1:WHAT)_$$REPEAT^XLFSTR(" ",18),1,18)
 .  S TXT=TXT_"[#3] "_NODE
 .  D ADDREQ(TXT)
 ;
 Q
 ;
GBLFILE(FILE) ; Return closed global root...
 N CH,GBL
 S GBL=$G(^DIC(+FILE,0,"GL"))
 S CH=$E(GBL,$L(GBL))
 I CH="," QUIT $E(GBL,1,$L(GBL)-1)_")" ;->
 I CH="(" QUIT $E(GBL,1,$L(GBL)-1)
 Q ""
 ;
EXTQUERY(VAL) ; Extract $QUERY format requests...
 ;
 ; Format:  p(1) = $QUERY reference.  (E.g., "^DPT(25)")
 ;          p(2) = $QUERY stop value. (E.g., "^DPT(25,")
 ;          p(3) = # lines limit
 ;          p(4) = Screen format (E.g., "^DPT(#,0)")
 ;
 N LPVAL,NO,NOLINE,SCREEN,STOP
 ;
 ; Get values...
 QUIT:'$$OKVARSQ(VAL)  ;->
 ;
 ; Loop and collect now...
 S NO=$O(^XTMP(XTMP,"HLQUERY",":"),-1)+1
 S ^XTMP(XTMP,"HLQUERY",+NO)=VAL
 ;
 ; Add to list of items being queried...
 S TXT=""
 F PCE=1:1:$L(VAL,U) D
 .  S DATA=$P(VAL,U,PCE)
 .  I PCE=1!(PCE=2)!(PCE=4) S DATA=U_DATA
 .  I PCE=3 D
 .  .  I DATA']"" S DATA="[1000]"
 .  .  S DATA=" "_DATA
 .  S DATA="[#"_PCE_"]"_DATA
 .  I $L(DATA)>15 S DATA=$P(DATA,"]",2,99)
 .  S DATA=$S($L(DATA)>15:DATA_" ",1:$E(DATA_$$REPEAT^XLFSTR(" ",15),1,15))
 .  S TXT=TXT_$S(TXT]"":"   ",1:"")_DATA
 ;
 I TXT]"" D
 .  D ADDREQHD
 .  D ADDREQ(TXT)
 ;
 Q
 ;
OKVARSQ(VAL)  ; Are variables OK for $QUERY looping?
 ; Defines (and "leaves around") LPVAL,STOP,NOLINE,SCREEN...
 S (LPVAL,NOLINE,SCREEN,STOP)=""
 S LPVAL=U_$P(VAL,U) S X="W "_LPVAL D ^DIM QUIT:'$D(X) "" ;->
 QUIT:$E(LPVAL,1,3)'="^HL"&($E(LPVAL,1,8)'="^ORD(101") "" ;->
 S STOP=U_$P(VAL,U,2) S X="W "_STOP_"25)" D ^DIM QUIT:'$D(X) "" ;->
 S X=$P(VAL,U,3),NOLINE=$S(X>1000:1000,X>0:X,1:1000)
 S SCREEN=$P(VAL,U,4) I SCREEN]"" D  QUIT:'$D(X) "" ;->
 .  S SCREEN=U_SCREEN
 .  S X="W "_$TR(SCREEN,"#",1) D ^DIM
 QUIT 1
 ;
LOADQ(VAL) ; Load $QUERY format data...
 N CT,LPVAL,NO,NOLINE,POSX,REF,SCREEN,STOP,TXT
 ;
 ; Already checked format. But, this call sets up looping variables...
 QUIT:'$$OKVARSQ(VAL)  ;->
 ;
 S CT=0
 F  S LPVAL=$Q(@LPVAL) Q:$$QUITQ^HLEVSRV0(LPVAL,STOP,NOLINE,CT)  D
 .  I SCREEN]"" QUIT:$$QUITS^HLEVSRV0(LPVAL,SCREEN)  ;->
 .  S REF=LPVAL_"=",POSX=$L(REF)
 .  S DATA=@LPVAL,CT=CT+1
 .  F  D  QUIT:$TR(REF," ","")']""&(DATA']"")
 .  .  S TXT=REF_$E(DATA,1,74-$L(REF))
 .  .  D ADDMAIL(TXT)
 .  .  S CT=CT+1
 .  .  S DATA=$E(DATA,74-$L(REF)+1,999)
 .  .  S REF=$$REPEAT^XLFSTR(" ",POSX)
 ;
 I CT D ADDMAIL("")
 ;
 Q
 ;
 ; =====================================================================
 ;
ADDREQHD ; Add Header to request record in email...
 S ADDREQHD=$G(ADDREQHD)+1 QUIT:ADDREQHD>1  ;->
 D ADDREQ(""),ADDREQ("Data Requests")
 D ADDREQ($$REPEAT^XLFSTR("-",74))
 Q
 ;
ADDLINE(XMRG) ; Add read line of text to ^TMP...
 N LNO
 S LNO=$O(^XTMP(XTMP,"RQ",":"),-1)+1
 S ^XTMP(XTMP,"RQ",+LNO)=XMRG
 Q
 ;
ADDREQ(TXT) ; Add data request to be added to ^XTMP(XTMP,"HLMAIL") later
 N SNO
 S SNO=$O(^XTMP(XTMP,"HLREQ",":"),-1)+1
 S ^XTMP(XTMP,"HLREQ",+SNO)=TXT
 Q
 ;
ADDMAIL(TXT) D ADDMAIL^HLEVSRV2(TXT)
 Q
 ;
OKFILE(FILE) QUIT:+FILE=101 1 ;->
 I FILE>769.99999&(FILE<870) QUIT 1 ;->
 Q ""
 ;
EOR ;HLEVSRV - Event Monitor SERVER ;5/16/03 14:42
