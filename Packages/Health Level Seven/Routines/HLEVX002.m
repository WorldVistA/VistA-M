HLEVX002 ;O-OIFO/LJA - HL7 Xref Check ;02/04/2004 15:25
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
 ; Event Types... AC-HUNG, AC-PROC'D, AC-NO 773, AC-NO 870
 ;
CHECKAC ; Check file 773 AC xref...
 N ABRT,CTERR,CTXREF,ERRNO,GBL,IEN773,IEN870,NOW,XTMP,WAY,X
 ;
 D DEBUG^HLEVAPI2("CHECKAC")
 D START^HLEVAPI("CTERR^CTXREF")
 ;
 KILL ^TMP($J,"HLEV REP"),^TMP($J,"HLEVREP"),^TMP($J,"HLMAIL773")
 ;
 ; Current XMTP
 S NOW=$$NOW^XLFDT
 S XTMP="HLEV CHK773AC "_NOW
 S ^XTMP(XTMP,0)=$$FMADD^XLFDT(NOW,3)_U_NOW_U_"VistA HL7 773 AC Xref Check"_U_"Task# "_$G(ZTSK)
 ;
 ; Previous XTMP...
 S X=$O(^XTMP(XTMP),-1),XTMP(1)=$S(X["HLEV CHK773AC":X,1:"")
 ;
 S GBL="^HLMA(""AC"")"
 ; Check Xref...
 S WAY="",(ABRT,CTERR,ERRNO)=0
 F  S WAY=$O(@GBL@(WAY)) Q:WAY']""!(ABRT)  D
 .  S IEN870=0
 .  F  S IEN870=$O(@GBL@(WAY,IEN870)) Q:'IEN870!(ABRT)  D
 .  .  S IEN773=0,CTXREF=0
 .  .  F  S IEN773=$O(@GBL@(WAY,IEN870,IEN773)) Q:'IEN773!(ABRT)  D
 .  .  .  S CTXREF=CTXREF+1
 .  .  .  I '(CTXREF#1000) D  I $$S^%ZTLOAD S ABRT=1 QUIT  ;->
 .  .  .  .  D CHECKIN^HLEVAPI
 .  .  .  .  S $P(^XTMP(XTMP,0),U,5)=$$NOW^XLFDT
 .  .  .  S ^XTMP(XTMP,"CURR",WAY,IEN870,IEN773)=NOW ; Next run record
 .  .  .  D CHKAC(WAY,IEN870,IEN773)
 ;
 D CHECKOUT^HLEVAPI
 ;
 S X("HLEV REP")=$NA(^TMP($J,"HLEV REP")) D DEBUG^HLEVAPI2("CHECKAC-3",.X)
 ;
 ; Create report global, and move into ^TMP($J,"HLEVREP")...
 D GENREP^HLEVUTI0($NA(^TMP($J,"HLEV REP")),$NA(^TMP($J,"HLEVREP")),4,1)
 D MAIL773
 D MSGTEXT^HLEVAPI1($NA(^TMP($J,"HLEVREP")))
 ;
 ; Send email if errors exist...
 I ERRNO>0 D
 .  S HLEVTXT(1)="MESSAGETEXT"
 .  D MAILIT^HLEVAPI
 ;
 S X("HLEV REP")=$NA(^TMP($J,"HLEV REP")) D DEBUG^HLEVAPI2("CHECKAC-3",.X)
 ;
 KILL ^TMP($J,"HLEV REP"),^TMP($J,"HLEVREP"),^TMP($J,"HLMAIL773")
 ;
 Q
 ;
CHKAC(WAY,IEN870,IEN773) ; Check AC xref...
 ;
 ; Record in ^XTMP... (Next run compared to this for "hangarounds")
 S ^XTMP(XTMP,"CURR",WAY,IEN870,IEN773)=NOW
 ;
 S WAY(1)=$S(WAY="I":"IN",1:"OUT")
 ;
 ; Does link exist?
 I $G(^HLCS(870,+IEN870,0))']"" D  QUIT  ;->
 .  D ERR(WAY(1),IEN870,IEN773,"No 870","AC-NO 870")
 ;
 ; Make sure zero node exists...
 I $G(^HLMA(+IEN773,0))']"" D  QUIT  ;->
 .  D ERR(WAY(1),IEN870,IEN773,"No 773","AC-NO 773")
 ;
 ; Make sure AC xref should exist...
 I $G(^HLMA(+IEN773,"P"))?7N1"."1.N D  QUIT  ;->
 .  D ERR(WAY(1),IEN870,IEN773,"Proc'd","AC-PROC'D")
 ;
 ; Check only for first entry...
 QUIT:CTXREF>1  ;->
 ;
 ; Check for "hang around" AC xrefs...
 I $G(XTMP(1))]"" D
 .  ; Quit if didn't exist last run...
 .  QUIT:'$D(^XTMP(XTMP(1),"CURR",WAY,IEN870,IEN773))  ;->
 .  QUIT:$P($$UP^XLFSTR($G(^HLCS(870,+IEN870,0))),U,5)["SHUTDOWN"  ;->
 .  D ERR($S(WAY=1:"IN",1:"OUT"),IEN870,IEN773,"Hung#","AC-HUNG")
 ;
 Q
 ;
ERR(WAY,IEN870,IEN773,REA,ETYPE) ;
 ; ERRNO -- req
 ;
 ; Has this problem already been logged?
 QUIT:'$$LOG^HLEVAPI2($G(ETYPE),"WAY^IEN870^IEN773")  ;->
 ;
 ; $$LOG creates (where AC-HUNG = ETYPE)...
 ; ^HLEV(776.4,"AH","AC-HUNG","IN",25,15333) = 100
 ; ^HLEV(776.4,"AH","AC-HUNG","X776",1183,100) = 100
 ; ^HLEV(776.4,"AH","AC-HUNG","X7764",100,1183) = 100
 ; 1183 = 776 ien    100 = 776.4 ien
 ;
 S ERRNO=$G(ERRNO)+1
 D RECORD^HLEVX000("773 AC-"_REA,WAY,IEN870,IEN773)
 S ^TMP($J,"HLMAIL773",IEN870,WAY,+IEN773)=$$NEXTACS(WAY,IEN870,IEN773)
 ;
 Q
 ;
NEXTACS(WAY,IEN870,I773) ; Store the next two entries...
 N CT,NEXTIENS
 S WAY=$E(WAY),NEXTIENS="",CT=0
 F  S I773=$O(^HLMA("AC",WAY,IEN870,I773)) Q:'I773!(CT=2)  D
 .  S CT=CT+1
 .  S NEXTIENS=NEXTIENS_$S(NEXTIENS]"":U,1:"")_I773
 Q NEXTIENS
 ;
MAIL773 ; Add collected 773 entry data to email message...
 N CT,I773,IEN773,IEN870,LINKNM,NEXTACS,WAY
 ;
 D ADD("")
 ;
 S IEN870=0
 F  S IEN870=$O(^TMP($J,"HLMAIL773",IEN870)) Q:IEN870'>0  D
 .  S DATA=$G(^HLCS(870,+IEN870,0))
 .  S LINKNM=$P(DATA,U)_" [#"_IEN870_"] "
 .  D ADD("")
 .  D ADD($$CJ^XLFSTR(LINKNM_" ",74,"="))
 .  F NODE=0,100,200,300,400 D ADDNODE(NODE,NODE,IEN870)
 .  S WAY=""
 .  F  S WAY=$O(^TMP($J,"HLMAIL773",IEN870,WAY)) Q:WAY']""  D
 .  .  S IEN773=0,CT=0
 .  .  F  S IEN773=$O(^TMP($J,"HLMAIL773",IEN870,WAY,IEN773)) Q:IEN773'>0  D
 .  .  .  S CT=CT+1
 .  .  .  I CT=1 D ADD($$CJ^XLFSTR(" "_$S($E(WAY)="I":"INCOMING",1:"OUTGOING")_" ",74,"="))
 .  .  .  D DATA773(+IEN773," Problem AC Entry ") ; Problem entry...
 .  .  .  ; Add next two 773s...
 .  .  .  S NEXTACS=$G(^TMP($J,"HLMAIL773",IEN870,WAY,IEN773)) QUIT:NEXTACS']""  ;->
 .  .  .  F PCE=1:1:$L(NEXTACS,U) D
 .  .  .  .  S I773=+$P(NEXTACS,U,PCE) QUIT:I773'>0  ;->
 .  .  .  .  D DATA773(I773," Entry After AC Problem ")
 ;
 Q
 ;
ADDNODE(NODE,NAME,IEN870) ; Add node data prefixed by node name...
 N DATA,PFX
 S PFX=$S(NODE=+NODE:"",1:"""")
 S DATA="^HLCS(870,"_IEN870_","_PFX_NAME_PFX_")="_$G(^HLCS(870,+IEN870,NODE))
 D ADD(DATA)
 Q
 ;
DATA773(IEN773,PROBL) ; Add critical data to Email message...
 N DATA773,NO
 ;
 D ADD($$CJ^XLFSTR($G(PROBL),74,"="))
 ;
 KILL ^TMP($J,"HLDATA773")
 ;
 ; Collect 773 informaiton...
 D ENDIQ1^HLEVUTIL(773,+IEN773,"HLDATA773")
 ;
 S ^TMP($J,"HLDATA773",1)="       "_$$CJ^XLFSTR(" 773# "_IEN773_" ",60,"-")_"       "
 S NO=0
 F  S NO=$O(^TMP($J,"HLDATA773",NO)) Q:NO'>0  D
 .  D ADD(^TMP($J,"HLDATA773",+NO))
 ;
 KILL ^TMP($J,"HLDATA773")
 ;
 Q
 ;
ADD(TXT,TRAIL) ; Add TXT to ^TMP($J,"HLEVREP",#)...
 N COL,LEN,NO,TXTOLD
 ;
 S LEN=$L($P(TXT,"=")),LEN=$S('LEN:3,LEN<55:LEN+1,1:3)
 ;
 F  D  QUIT:TXT']""
 .  S NO=$O(^TMP($J,"HLEVREP",":"),-1)+1
 .  S ^TMP($J,"HLEVREP",+NO)=$E(TXT,1,74)
 .  S TXT=$E(TXT,75,999) QUIT:TXT']""  ;->
 .  S TXT=$$REPEAT^XLFSTR(" ",LEN)_TXT
 ;
 Q
 ;
EOR ;HLEVX002 - VistA HL7 Event Monitor Code ;5/30/03 15:25
