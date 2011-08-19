HLEVSRV2 ;O-OIFO/LJA - Event Monitor SERVER ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
QUERYSTR ; Generate $QUERY strings...
 N IOINHI,IOINORM,STRING,X
 ;
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 ;
 D HD,EX,TELL^HLEVMST0("","0^0^999","Press RETURN to continue... ")
 ;
 F  S STRING=$$STRING QUIT:STRING']""  D
 .  S STRING(STRING)=""
 .  W !!,"Search string = ",IOINHI,STRING,IOINORM
 ;
 QUIT:$O(STRING(""))']""  ;->
 W !!,IOINHI,"Paste the following ""search strings"" into an email message and send to the"
 W !,"S.HLEV-INFORMATION-SERVER@REMOTE-SITE.",IOINORM
 W !!
 ;
 S STRING=""
 F  S STRING=$O(STRING(STRING)) Q:STRING']""  D
 .  W !,STRING
 ;
 Q
 ;
STRING() ; Ask user to input values to be built into a search string
 N FILTER,LIMIT,ROOT,STOP
 S ROOT=$$QUERYRT QUIT:ROOT']"" "" ;->
 S STOP=$$QUERYST(ROOT) QUIT:STOP']"" "" ;->
 S LIMIT=$$QUERYLM
 S FILTER=$$QUERYFL
 Q ROOT_U_STOP_U_LIMIT_U_FILTER
 ;
QUERYRT() ;
 N VAL
 D TAG("$QUERY ROOT")
 D EXRT
 W !
 S VAL=$$FT("Enter $QUERY ROOT") QUIT:VAL']""!(VAL=U) "" ;->
 Q VAL
 ;
EXRT N I,T F I=1:1 S T=$T(EXRT+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;Enter the $QUERY root now.  For example...
 ;;
 ;; - If you want to see all data for ^HL(772,25132), including the zero node
 ;;   and all data, enter "HL(772,25132)".
 ;; - If you want to see all data for HLMA(9132), including the zero node and
 ;;   all data, enter "^HLMA(9132)".
 ;;
 ;;NOTE:  Do not enter the leading up-arrow before a global reference.
 Q
 ;
QUERYST(ROOT) ;
 N VAL
 D TAG("$QUERY Stop Value")
 D EXST
 S VAL=$E(ROOT,$L(ROOT)),VAL=$S(VAL=")":$E(ROOT,1,$L(ROOT)-1)_",",1:ROOT)
 W !
 S VAL=$$FT("Enter $QUERY STOP VALUE",VAL) QUIT:VAL']""!(VAL=U) "" ;->
 Q VAL
 ;
EXST N I,T F I=1:1 S T=$T(EXST+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;Enter the $QUERY stop value now.  For example...
 ;;
 ;; - Assuming you entered "HL(772,25132)" (see helps under root entry above),
 ;;   you would enter a stop value of "HL(772,25132,".
 ;; - Assuming you entered "HLMA(9132)", enter a stop value of "HLMA(9132,".
 Q
 ;
QUERYLM() ;
 N VAL
 D TAG("Data Node Limit")
 D EXLM
 R !!,"Enter LIMIT: ",VAL:60 Q:VAL'>0 "" ;->
 QUIT:VAL>1000 1000 ;->
 Q VAL
 ;
EXLM N I,T F I=1:1 S T=$T(EXLM+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;You can limit the number of nodes that are returned.  This is especially 
 ;;helpful when you don't know how many data nodes exist and will be returned by
 ;;your request.  (You don't want to send a request, thinking you'll get around
 ;;20 data nodes back, when 20,000 data nodes exist!)
 ;;
 ;;Enter the maximum number of nodes you want returned.
 ;;
 ;;NOTE:  The maximum number of data nodes returnable by each $QUERY search 
 ;;       string is 1000.  So, there is no point entering any limit above 1000!
 Q
 ;
QUERYFL() ;
 N VAL
 D TAG("Filter Reference")
 D EXFL
 W !
 S VAL=$$FT("Enter FILTER REFERENCE","","O") QUIT:VAL']""!(VAL=U) "" ;->
 Q VAL
 ;
EXFL N I,T F I=1:1 S T=$T(EXFL+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;$QUERY returns all data nodes no matter the structure of the subscripts.  At
 ;;times you might want to filter out the data nodes whose subscripting does not
 ;;follow a specific format.  You can define such a filter now.  Some filter
 ;;examples are shown below.
 ;;
 ;; - If you only want to see ^HL(772,IEN,"IN",1,0) enter a filter of "HL(772,#,"IN",1,0)".
 ;; - If you want to see the message text in a file 772 entry, enter a filter of
 ;;   "HL(772,#,"IN",#,0)".
 ;;
 ;;You probably noticed that the "#" symbol must be placed at every subscript
 ;;location where you want "any IEN" to be included.
 Q
 ;
TAG(TXT) W !!,$$CJ^XLFSTR("----------- "_IOINHI_TXT_IOINORM_"-----------",IOM+$L(IOINHI)+$L(IOINORM))
 Q
 ;
HD W @IOF,$$CJ^XLFSTR("$QUERY String Generator",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 QUIT
 ;
EX N I,T F I=1:1 S T=$T(EX+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;$QUERY-based search strings can be sent to the S.HLEV-INFORMATION-SERVER at
 ;;remote sites requesting data to be returned to the HL7SystemMonitoring mail
 ;;group.  Structuring $QUERY search strings can be complicated.  This utility
 ;;will assist you in creating these search strings.
 ;;
 ;;The search string(s) created should be pasted into the mail message sent to
 ;;the remote site.
 ;;
 ;;The parts of the $QUERY search string are listed below.
 ;;
 ;;  - $QUERY root
 ;;  - $QUERY stop value
 ;;  - # nodes to return
 ;;  - Node filter format
 QUIT
 ;
MONITOR(TXT) ; User requested that a monitor be run...
 ; XTMP -- req
 N HLEVIENE,MONM,PCE,QTIME,RECIP,VAL
 ;
 ; Email data request format: MONITOR^monitor-name^queue-time^recip's
 ;
 S MONM=$P(TXT,U) QUIT:MONM']""  ;->
 S HLEVIENE=$O(^HLEV(776.1,"B",MONM,0)) QUIT:HLEVIENE'>0  ;->
 QUIT:$P($G(^HLEV(776.1,+HLEVIENE,0)),U,5)'=1  ;-> Not remote requestable
 S QTIME=$P(TXT,U,2) I QTIME'?7N1"."1.N S QTIME=$$NOW^XLFDT
 ;
 D ADDREQHD^HLEVSRV ; Initial header
 D ADDREQ^HLEVSRV("Monitor: "_MONM_" [#"_HLEVIENE_"]")
 ;
 S ^XTMP(XTMP,"MONREQ","MON",HLEVIENE)=MONM
 ;
 S VAL=$P(TXT,U,2,999) Q:VAL']""  ;->
 F PCE=1:1:$L(VAL,U) D
 .  S RECIP=$P(VAL,U,PCE) QUIT:RECIP']""  ;->
 .  S ^XTMP(XTMP,"MONREQ","MON",+HLEVIENE,RECIP)=""
 .  D ADDREQ^HLEVSRV("         recipient = "_RECIP)
 ;
 S ^XTMP(XTMP,"MONREQ","TASK")=$$Q1TIME^HLEVAPI0(HLEVIENE,1,QTIME,XTMP)
 ;
 Q
 ;
FT(PMT,DEF,WAY) ; Return user-input text...
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="F"_$G(WAY)
 S DIR("A")=PMT
 I $G(DEF)]"" S DIR("B")=DEF
 D ^DIR
 I Y?1"^"1.E&($L(Y,U)=2) QUIT $P(Y,U,2) ;->
 QUIT:$D(DIRUT)!($D(DTOUT))!($D(DUOUT)) U ;->
 Q Y
 ;
ADDMAIL(TXT) ; Add TXT, but be sure it is on or after NUM
 N SNO
 QUIT:$G(HLEVOVER)  ;-> Over 5000 line limit...
 S SNO=$O(^XTMP(XTMP,"HLMAIL",":"),-1)+1
 I SNO<100 S SNO=100 ; Leave room at the top for messages
 I SNO>5100 D  QUIT  ;->
 .  S HLEVOVER=1
 .  S TXT="     ***** 5000 Line Limit Reached!  Some text not included. *****"
 .  S ^XTMP(XTMP,"HLMAIL",+SNO)=""
 .  S ^XTMP(XTMP,"HLMAIL",+SNO+1)=""
 .  S ^XTMP(XTMP,"HLMAIL",+SNO+2)=TXT
 .  S ^XTMP(XTMP,"HLMAIL",1)=""
 .  S ^XTMP(XTMP,"HLMAIL",2)=TXT
 .  S ^XTMP(XTMP,"HLMAIL",3)=""
 S ^XTMP(XTMP,"HLMAIL",+SNO)=TXT
 Q
 ;
EOR ;HLEVSRV2 - Event Monitor SERVER ;5/16/03 14:42
