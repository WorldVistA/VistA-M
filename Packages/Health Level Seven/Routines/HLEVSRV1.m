HLEVSRV1 ;O-OIFO/LJA - Event Monitor SERVER ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
OPENM ; Open/close access to M code...
 D OFFBEF
 D HDM,EXM,STM,SWM
 Q
 ;
OKCODE(CODE) ; Check if license available and if so, mark used...
 N XTMP
 D OFFBEF
 S XTMP=$O(^XTMP("HLEV SERVER M 9999999"),-1) QUIT:XTMP']"" "" ;->
 QUIT:'$D(^XTMP(XTMP,"LIC",CODE)) "" ;->
 QUIT:$G(^XTMP(XTMP,"LIC",CODE))]"" "" ;->
 S ^XTMP(XTMP,"LIC",CODE)=$$NOW^XLFDT_U_.5_U_$G(XMZ)_U_$G(ZTSK)
 Q 1
 ;
OFFBEF ; Turn off all but last M code entry...
 N XTMP
 S XTMP=$O(^XTMP("HLEV SERVER M 9999999"),-1) QUIT:XTMP']""  ;->
 F  S XTMP=$O(^XTMP(XTMP),-1) Q:XTMP']""  D
 .  D SETOFF(XTMP)
 Q
 ;
SWM ; Switch state...
 N STAT
 S STAT=$$MST
 I +STAT=0 D UPM
 I +STAT=1 D DOWNM
 W !
 S X=$$BTE^HLCSMON("Press RETURN to exit... ")
 Q
 ;
DOWNM ; Turn off M code execution...
 ; STAT -- req
 N END,START,XTMP
 S XTMP=$O(^XTMP("HLEV SERVER M 9999999"),-1)
 I XTMP']"" D  QUIT  ;->
 .  W !!,"M code execution is OFF already..."
 W !
 I '$$YN^HLCSRPT4("Turn off M code execution") D  QUIT  ;->
 .  W "  nothing changed..."
 D SETOFF(XTMP)
 W "   M code execution disallowed..."
 Q
 ;
UPM ; Turn on M code execution...
 ; STAT -- req
 N CODES,END,IOBOFF,IOBON,NOC,START,X,XTMP
 ;
 S X="IOBOFF;IOBON" D ENDR^%ZISS
 S XTMP="HLEV SERVER M "_$$NOW^XLFDT
 ;
 W !
 I '$$YN^HLCSRPT4("Turn on M code execution","No") D  QUIT  ;->
 .  W "  nothing changed..."
 ;
 W !!,"Before M code execution can be turned on, you must answer a few questions..."
 W !!,"Please include ",IOBON,"time",IOBOFF
 W " when entering the start and end date/times..."
 ;
 W !
 S START=$$ASKDATE^HLEVAPI2("Enter START TIME","","NOW")
 I START'?7N1"."1.N D  QUIT  ;->
 .  W "  exiting..."
 ;
 W !!,"Prompting START+24 hours..."
 W !
 S END=$$ASKDATE^HLEVAPI2("Enter END TIME","",$$FMTE^XLFDT($$FMADD^XLFDT(START,1)))
 I END'?7N1"."1.N D  QUIT  ;->
 .  W "  exiting..."
 ;
 W !
 S NOC=$$ASKCODES(.CODES) I 'NOC D  QUIT  ;->
 .  W "   exiting..."
 W !!,$S(NOC=1:"The '"_$O(CODES(""))_"' license",1:"These licenses")
 W " will be installed if you turn on M code execution now:"
 ;
 I NOC>1 D
 .  W !!,?5
 .  S CODES=""
 .  F  S CODES=$O(CODES(CODES)) Q:CODES']""  D
 .  .  W:($X+$L(CODES))>IOM !,?5
 .  .  W $E(CODES_"          ",1,10)
 ;
 W !
 I '$$YN^HLCSRPT4("OK to turn on M code execution") D  QUIT  ;->
 .  W "  nothing changed..."
 ;
 D SETON(XTMP,START,END)
 W "   M code execution allowed..."
 ;
 W !!,"Be sure to pass on ",$S(NOC>1:"these licenses",1:"the license")
 W " to the VistA HL7 team..."
 D LICENSE(XTMP,.CODES)
 ;
 W !
 S X=$$BTE^HLCSMON("Press RETURN to exit...")
 ;
 Q
 ;
LICENSE(XTMP,CODES) ; Install licenses
 N CODE
 W !!,"Codes:    "
 ;
 S CODE=""
 F  S CODE=$O(CODES(CODE)) Q:CODE']""  D
 .  S ^XTMP(XTMP,"LIC",CODE)="" ; Mailman server uses stored on this node
 .  S X=$E(CODE_"                   ",1,20) W:($X+$L(X))>IOM !,?10 W X
 ;
 Q
 ;
ASKCODES(CODES) ; Ask user for codes...
 N CODE,NOC
 ;
 W !!,"You must now give the VistA HL7 team ""licences"" for M code execution.  One"
 W !,"license is used for every Mailman server request containing executable M "
 W !,"code."
 W !
 ;
 S NOC=0
 F  D  QUIT:CODE']""
 .  S CODE=$$CODE QUIT:CODE']""  ;->
 .  S ANS=$$YN^HLCSRPT4("Install the license# ["_CODE_"]","Yes")
 .  I ANS'=1 S CODE="" W "   not intalled..." QUIT  ;->
 .  S NOC=NOC+1,CODES(CODE)=""
 ;
 Q NOC
 ;
SETON(XTMP,START,END) ; Allow M code execution
 S ^XTMP(XTMP,0)=$$FMADD^XLFDT($$NOW^XLFDT,7)_U_$$NOW^XLFDT_U_"VistA HL7 Mailman Server M Control"
 S ^XTMP(XTMP,"STATUS")=START_U_END_U_$G(DUZ)
 Q
 ;
SETOFF(XTMP) ; Disallow M code execution...
 S $P(^XTMP(XTMP,"STATUS"),U,4,5)=$$NOW^XLFDT_U_$G(DUZ)
 Q
 ;
STM ; What is the status of M code execution?
 W !!,$$CJ^XLFSTR("------ M Code Execution Status: "_$P($$MST,U,3)_" ------",IOM)
 Q
 ;
MST() ; Status?
 ; Piece 1 = 0 -> DOWN                        UP OR DOWN
 ;         = 1 -> UP
 ; Piece 2 = 1 -> No XTMP data exists...      DOWN REASONS
 ;         = 2 -> Invalid START/ENDs
 ;         = 3 -> Before cutoff time
 ;         = 4 -> After cutoff time
 ;         = 5 -> Inactive date (p4) found
 ;         = 0 -> Not DOWN!!!
 ; Piece 3 = Status text information
 ;
 ; NOW -- req
 N NOW,END,IDATE,START,STAT,XTMP
 S NOW=$$NOW^XLFDT
 S XTMP=$O(^XTMP("HLEV SERVER M 9999999"),-1) QUIT:XTMP']"" "0^1^DOWN" ;->
 S STAT=$G(^XTMP(XTMP,"STATUS")),START=+STAT,END=$P(STAT,U,2),IDATE=$P(STAT,U,4)
 I IDATE?7N1"."1.N QUIT "0^5^DOWN" ;->
 I START'?7N1"."1.N!(END'?7N1"."1.N) QUIT "0^2^DOWN" ;->
 I START>NOW QUIT "0^3^DOWN - (Too early ("_$$SDT^HLEVX001(+START)_")" ;->
 I END<NOW QUIT "0^4^DOWN - (Too late ("_$$SDT^HLEVX001(+END)_")" ;->
 ;
 Q "1^0^UP"
 ;
HDM W @IOF,$$CJ^XLFSTR("Open Access to Mailman Server M Code",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 QUIT
 ;
EXM N I,T F I=1:1 S T=$T(EXM+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;Mailman server requests can be sent to your site requesting HL7 data be 
 ;;returned to the VistA HL7 team.  (These requests are only sent to the VistA
 ;;HL7 team, and under no circumstances are sent to any other mail groups or
 ;;individuals.)  Under very rare circumstances, in order to debug problems on 
 ;;your site, or to collect diagnostic information, it might be desired to run
 ;;some M code embedded in the Mailman server requests.  
 ;;
 ;;In order to provide a high level of security, no M code will ever be run by
 ;;the Mailman server option unless you explicity allow M code execution.  This
 ;;option allows you to allow, or disallow, M code execution.
 QUIT
 ;
CODE() ; Return license code...
 N CODE,EX,NOP,TYPE
 F EX=39,44,95,96 S EX(EX)=""
 S CODE="",NOP=0
 F EX=1:1:6 D
 .  S TYPE=$P("A^P",U,$R(2)+1)
 .  I EX=6,NOP=0 S TYPE="P" ; Must be at least one punctuation
 .  I TYPE="P" S NOP=NOP+1
 .  S:NOP>1 TYPE="A"
 .  S CODE=CODE_$$RNO(TYPE)
 .  I EX=3 S CODE=CODE_"-"
 Q CODE
 ;
RNO(TYPE) ; Return random number between 33 and 122 (w/exceptions)
 ; NOP -- req
 N NO,OK
 F  S NO=$R(89)+33 D  Q:OK
 .  S OK=0
 .  I $D(EX(NO)) QUIT  ;-> Is it in exclusion list?
 .  I TYPE="A" D  QUIT  ;-> Is it an alpha character
 .  .  I $$ALPHA(NO) S OK=1
 .  I '$$ALPHA(NO) S OK=1 ; Need punctuation...
 Q $C(NO)
 ;
ALPHA(NO) ; Is it ALPHA character?
 N X
 S X=$A($$UP^XLFSTR($C(NO))) QUIT:X>64&(X<91) 1 ;->
 Q ""
 ;
GBLTOXM ; Place global data in Mailman message global...
 N DATA,FILE,GBL,IEN,LP,REF,ST,TXT
 ;
 ; Add data found...
 S GBL=$NA(^XTMP(XTMP,"DATA"))
 ;
 S FILE=0
 F  S FILE=$O(@GBL@(FILE)) Q:FILE'>0  D
 .  D ADDMAIL^HLEVSRV("")
 .  D ADDMAIL^HLEVSRV($$CJ^XLFSTR(" "_$P($G(^HLEV(+FILE,0)),U)_" [#"_FILE_"] ",74,"-"))
 .  S IEN=0
 .  F  S IEN=$O(@GBL@(FILE,IEN)) Q:IEN'>0  D
 .  .  S TXT="#"_IEN
 .  .  S LP="^XTMP("""_XTMP_""",""DATA"","_FILE_","_IEN,ST=LP_","
 .  .  S LP=LP_")"
 .  .  F  S LP=$Q(@LP) Q:LP'[ST  D
 .  .  .  S REF="#"_IEN_","_$P(LP,ST,2)_"=",POSX=$L(REF)
 .  .  .  S DATA=@LP
 .  .  .  F  D  QUIT:$TR(REF," ","")']""&(DATA']"")  ;->
 .  .  .  .  S TXT=REF_$E(DATA,1,74-$L(REF))
 .  .  .  .  D ADDMAIL^HLEVSRV(TXT)
 .  .  .  .  S DATA=$E(DATA,74-$L(REF)+1,999)
 .  .  .  .  S REF=$$REPEAT^XLFSTR(" ",POSX)
 ;
 Q
 ;
TEST ; Test server...
 N CT,HLEVQUIT,LASTXTMP,XTMP,XMREC,XMZ
 ;
 W !!,"The current time is ",$$NOW^XLFDT,"..."
 ;
 W !!,"Displaying all existing ^XTMP(""HLEV SERVER ..."") entries..."
 ;
 ; Find last 6 entries to show...
 S XTMP="HLEV SERVER 9999999",CT=0
 F  S XTMP=$O(^XTMP(XTMP),-1) Q:XTMP'?1"HLEV SERVER "7N1"."1.N!(CT>6)  D
 .  S CT=CT+1
 ;
 S CT=0
 S XTMP=$S(XTMP?1"HLEV SERVER "7N1"."1.N:XTMP,1:"HLEV SERVER 0000000")
 F  S XTMP=$O(^XTMP(XTMP)) Q:XTMP'?1"HLEV SERVER "7N1"."1.N  D
 .  W:'CT !!
 .  W $E("^XTMP("""_XTMP_""""_$$REPEAT^XLFSTR(" ",40),1,40)
 .  S CT=CT+1
 ;
 I 'CT W !!,"No XTMP server data exists..." QUIT  ;->
 ;
 S LASTXTMP=$O(^XTMP("HLEV SERVER 9999999"),-1)
 D SHOWXTMP("Last XTMP entry",LASTXTMP)
 ;
T1 W !!,"Enter XTMP to rerun: ",LASTXTMP,"// "
 R XTMP:999 QUIT:XTMP[U  ;->
 S:XTMP']"" XTMP=LASTXTMP
 I '$D(^XTMP(XTMP)) D  G T1 ;->
 .  W "  entry not found..."
 ;
 S XMZ=$P($G(^XTMP(XTMP,"MAIL")),U)
 I $G(^XMB(3.9,+XMZ,0))']"" D  QUIT  ;->
 .  W !!,"There is no Mailman message recorded..."
 ;
 S XMREC="D REC^XMS3"
 ;
 W !!,"Calling SERVER^HLEVSRV with XTMP=",XTMP,"..."
 ;
 D SERVER^HLEVSRV
 ;
 D SHOWXTMP("Last (and newly created) XTMP entry",$O(^XTMP("HLEV SERVER 9999999"),-1))
 ;
 W !!,"The last 776 IEN = ",$O(^HLEV(776,":"),-1),"..."
 W !
 ;
 D ^%G
 ;
 Q
 ;
SHOWXTMP(TXT,XTMP) ; Show the XTMP data...
 N DATA,LP,POSX,ST
 ;
 I '$D(^XTMP(XTMP)) QUIT  ;->
 ;
 W !!,$$CJ^XLFSTR(" "_TXT_" ",IOM,"=")
 ;
 S LP=$NA(^XTMP(XTMP)),ST=$E(LP,1,$L(LP)-1)_","
 F  S LP=$Q(@LP) Q:LP'[ST  D
 .  W !,LP," = "
 .  S POSX=$X,DATA=@LP
 .  F  Q:DATA']""  D
 .  .  W:$X>POSX ! W:$X<POSX ?POSX
 .  .  W $E(DATA,1,IOM-POSX-1)
 .  .  S DATA=$E(DATA,IOM-POSX,999)
 ;
 W !,$$REPEAT^XLFSTR("=",IOM)
 ;
 Q
 ;
EOR ;HLEVSRV1 - Event Monitor SERVER ;5/16/03 14:42
