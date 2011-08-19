GMRCITR ;SLC/JAK - IFC transactions ; 09/27/02 15:50
 ;;3.0;CONSULT/REQUEST TRACKING;**22,28**;DEC 27, 1997
EN ; -- main entry point for GMRC IF TRANSACTION
 N GMRCDAS,GMRCLOG,GMRCQUT,GMRCS,X,Y
 N GMRCDT1,GMRCDT2,GMRCEDT1,GMRCEDT2
 D CON I $D(GMRCQUT) D EXIT^GMRCINC Q
 ;Ask for date range
 D ^GMRCSPD
 I $D(GMRCQUT) D EXIT^GMRCINC Q
 D LISTDATE^GMRCSTU1(GMRCDT1,GMRCDT2,.GMRCEDT1,.GMRCEDT2)
 D VIEW I $D(GMRCQUT) D EXIT^GMRCINC Q
 I GMRCSEL="ALL" D
 . S GMRCNUM=0 F  S GMRCNUM=$O(^GMR(123.6,"C",GMRCNUM)) Q:'GMRCNUM  D
 .. D BLD(GMRCNUM)
 E  D
 . S GMRCNUM=GMRCSEL
 . D BLD(GMRCNUM)
 I '$O(GMRCLOG(0)) D
 . S ^TMP("GMRCINC",$J,1,0)="No transactions for consult#: "_GMRCSEL
 E  D
 . D DATA(GMRCS)
 D EN^VALM("GMRC IF TRANSACTION")
 Q
 ;
CON ; ask for consult number or all
 S GMRCSEL=0
 F  D ASK S:X["^" GMRCQUT=1 Q:X["^"  Q:X="ALL"  D LKUP Q:GMRCSEL
 Q
ASK ; write prompt, do read
 W !!,"Select Consult/Request Number: ALL// "
 R X:DTIME
 I '$T S X="^"
 I X'["^" S X=$S('$L(X):"ALL",1:X)
 S:X="ALL" GMRCSEL="ALL"
 Q
LKUP ; use value of x for lookup
 N DIC
 S DIC="^GMR(123,",DIC(0)="MNEQZ"
 D ^DIC I '$D(Y(0)) W "...invalid entry"
 S:Y>0 GMRCSEL=+Y
 Q
VIEW ; ask for sort/view
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K GMRCQUT
 ;old code
 ; S DIR(0)="SA^C:CONSULT;D:DATE;A:ACTIVITY;M:MESSAGE STATUS"
 ; S DIR("A")="View by (C)onsult, (D)ate, (A)ctivity or (M)essage Status: "
 ;new code w/ patch 28
 S DIR(0)="SA^C:CONSULT;D:DATE;A:ACTIVITY"
 S DIR("A")="View by (C)onsult, (D)ate, or (A)ctivity: "
 S DIR("B")="Consult"
 S DIR("?")="Data will be sorted by your selection."
 D ^DIR I $D(DIRUT) S GMRCQUT=1 Q
 S GMRCS=Y
 Q
BLD(GMRCDA) ; get list of IF transactions for one or all consults
 ; Input:
 ;   GMRCDA = ien of consult from file 123
 ;
 N ACT,ENT,GMRCDTE
 S ACT=0
 F  S ACT=$O(^GMR(123.6,"C",GMRCDA,ACT)) Q:'ACT  D
 . S ENT=$O(^GMR(123.6,"C",GMRCDA,ACT,0)) Q:'ENT
 . I $S(GMRCDT1="ALL":0,1:1) D  Q:GMRCDTE<GMRCDT1!(GMRCDTE'<GMRCDT2)
 .. S GMRCDTE=+$P($G(^GMR(123.6,ENT,0)),"^")
 .. S GMRCDT2=GMRCDT2+1
 . S GMRCLOG(GMRCDA,ACT)=ENT
 Q
DATA(GMRCS) ; get data for IF transaction(s)
 ; Input:
 ;   GMRCS = sort/view by selection
 ; Output:
 ;   ^TMP("GMRCINC",$J array
 N ACT,GMRCSV,TAB
 I $O(GMRCLOG(0)) D
 . K GMRCDAS
 . K ^TMP("GMRCS",$J),^TMP("GMRCINC",$J)
 S (GMRCDA,LINE)=0
 S TAB="",$P(TAB," ",30)=""
 F  S GMRCDA=$O(GMRCLOG(GMRCDA)) Q:'GMRCDA  D
 . S ACT=0
 . F  S ACT=$O(GMRCLOG(GMRCDA,ACT)) Q:'ACT  D
 .. S GMRCLOG=$G(GMRCLOG(GMRCDA,ACT)) D
 ... N ACTTXT,EDT,IERR,STA,GMRCACT,GMRCLOG0
 ... S GMRCLOG0=$G(^GMR(123.6,GMRCLOG,0)) Q:'GMRCLOG0
 ... S GMRCDA(0)=$G(^GMR(123,GMRCDA,40,ACT,0)) Q:'GMRCDA(0)
 ... S LINE=LINE+1
 ... S X=$P(GMRCLOG0,"^") D REGDTM^GMRCU
 ... S EDT=$S(X]"":X,1:"No Date/Time")
 ... S GMRCACT=$P(GMRCDA(0),"^",2)
 ... S ACTTXT=$P($G(^GMR(123.1,+GMRCACT,0)),"^",1)
 ... S:'$L(ACTTXT) ACTTXT=GMRCACT_" action?"
 ... S STA=$P(GMRCLOG0,"^",3),STA=$$MSGSTAT^HLUTIL(STA) ; IA #3098
 ... S STA=$S(+STA>0:$E($$GET1^DIQ(771.6,+STA,.01),1,22),1:"No Status")
 ... S IERR=$T(@("ERR"_$P(GMRCLOG0,"^",8)_"^GMRCIUTL"))
 ... S IERR=$S(IERR]"":$E($P(IERR,";",2),1,45),1:"No Error")
 ... ;
 ... S GMRCDAS(GMRCDA)=""
 ... ; sort data
 ... S GMRCSV=$S(GMRCS="C":GMRCDA,GMRCS="D":EDT,GMRCS="A":ACTTXT,1:STA)
 ... S ^TMP("GMRCS",$J,GMRCSV,GMRCLOG)=GMRCDA
 ... S ^TMP("GMRCS",$J,GMRCSV,GMRCLOG)=^TMP("GMRCS",$J,GMRCSV,GMRCLOG)_$E(TAB,1,13-$L(^(GMRCLOG)))_EDT_$E(TAB,1,5)_ACTTXT
 ... ;S ^TMP("GMRCS",$J,GMRCSV,GMRCLOG)=^TMP("GMRCS",$J,GMRCSV,GMRCLOG)_$E(TAB,1,56-$L(^(GMRCLOG)))_STA  ;msg status not included after patch 28
 ... S ^TMP("GMRCS",$J,GMRCSV,GMRCLOG)=^TMP("GMRCS",$J,GMRCSV,GMRCLOG)_$E(TAB,1,56-$L(^(GMRCLOG)))_IERR
 .. Q
 . ; set data in array name
 . N GMRC1,LINE
 . S GMRC1="",LINE=0
 . F  S GMRC1=$O(^TMP("GMRCS",$J,GMRC1)) Q:GMRC1=""  D
 .. N GMRC2
 .. S GMRC2=""
 .. F  S GMRC2=$O(^TMP("GMRCS",$J,GMRC1,GMRC2)) Q:GMRC2=""  D
 ... S LINE=LINE+1
 ... S ^TMP("GMRCINC",$J,LINE,0)=$G(^TMP("GMRCS",$J,GMRC1,GMRC2))
 .. Q
 . Q
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Transaction(s) for consult#: "_GMRCSEL
 S VALMHDR(2)="From: "_$G(GMRCEDT1)_"   To: "_$G(GMRCEDT2)
 Q
LM ; set caption line
 D CHGCAP^VALM("CAPTION LINE","Consult     Entry Date/Time    Activity                Error")
 ;D CHGCAP^VALM("CAPTION LINE 1","Error") ; error moved over w/ patch 28
 Q
SELECT ; select a consult for detailed display of information
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,GMRCDDS
 K GMRCLOG
 S DIR(0)="NO^1:9999999^D CKSEL^GMRCITR(X) K:'GMRCDDS X"
 S DIR("A")="Select a Consult number from the display"
 S DIR("?")="This response must be a number from the display."
 D ^DIR I $D(DIRUT) Q
 K ^TMP("GMRCINC",$J)
 S GMRCSEL=Y
 D BLD(GMRCSEL)
 N ACT,ENT,GMRCND,LINE
 S (ACT,LINE)=0
 F  S ACT=$O(^GMR(123.6,"C",GMRCSEL,ACT)) Q:'ACT  D
 . S ENT=$O(^GMR(123.6,"C",GMRCSEL,ACT,0)) Q:'ENT  D
 .. Q:'$D(^GMR(123.6,ENT,0))
 .. N DIC,DR,DA,DIQ,GMRCA
 .. S DIC="^GMR(123.6,",DR=".01:.08",DA=ENT,DIQ="GMRCA"
 .. D EN^DIQ1
 .. S LINE=LINE+1
 .. S GMRCND="^TMP(""GMRCINC"",$J,LINE,0)"
 .. S @GMRCND="ENTRY DATE/TIME: "_GMRCA(123.6,ENT,.01),LINE=LINE+1
 .. S @GMRCND="FACILITY: "_GMRCA(123.6,ENT,.02),LINE=LINE+1
 .. S @GMRCND="MESSAGE #: "_GMRCA(123.6,ENT,.03),LINE=LINE+1
 .. S @GMRCND="ACTIVITY #: "_GMRCA(123.6,ENT,.05),LINE=LINE+1
 .. S @GMRCND="INCOMPLETE: "_GMRCA(123.6,ENT,.06),LINE=LINE+1
 .. S @GMRCND="TRANS. ATTEMPTS: "_GMRCA(123.6,ENT,.07),LINE=LINE+1
 .. S @GMRCND="ERROR: "_GMRCA(123.6,ENT,.08),LINE=LINE+1
 .. S @GMRCND=""
 S VALMHDR(1)="Detailed Display"
 S VALMHDR(2)="Consult#: "_GMRCSEL
 D CHGCAP^VALM("CAPTION LINE","")
 D CHGCAP^VALM("CAPTION LINE 1","")
 S VALMCNT=$O(^TMP("GMRCINC",$J," "),-1)
 S VALMBG=1
 Q
CKSEL(X) ; check selection
 N GMRCDA
 S (GMRCDA,GMRCDDS)=0
 F  S GMRCDA=$O(GMRCDAS(GMRCDA)) Q:'GMRCDA!GMRCDDS  D
 . I GMRCDA=X S GMRCDDS=1
 Q
