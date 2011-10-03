GMRCINC ;SLC/JFR - list incomplete IFC transactions ; 2/12/02 15:05
 ;;3.0;CONSULT/REQUEST TRACKING;**22**;DEC 27, 1997
EN ; -- main entry point for GMRCIF INCOMPLETE TRANSACTION
 N DIR,X,Y,DIRUT,DIROUT
 S DIR(0)="PO^123:EMQ",DIR("A")="Select a consult request"
 S DIR("?")="Type in the number, date of request or patient name"
 S DIR("S")="I $D(^GMR(123.6,""AC"",+Y))"
 D ^DIR
 I $D(DIRUT) Q
 I '$D(^GMR(123,+Y,0)) D  Q
 . W !,"There is no such consult request number"
 . K DIR S DIR(0)="E" D ^DIR
 S GMRCNUM=+Y
 D BLD(GMRCNUM)
 D EN^VALM("GMRC IF INCOMPLETE TRANSACTION")
 Q
 ;
BLD(GMRCDA) ;get list of incomplete IF transactions for a consult #
 ; Input: 
 ;   GMRCDA = ien of consult from file 123
 ;
 ; Output:
 ;    some kind of ^TMP( array
 N GMRCLOG,ACT,ENT,LINE
 S ACT=0
 F  S ACT=$O(^GMR(123.6,"AC",GMRCDA,ACT)) Q:'ACT  D
 . S ENT=$O(^GMR(123.6,"AC",GMRCDA,ACT,1,0)) Q:'ENT
 . S GMRCLOG(ACT)=ENT
 I '$O(GMRCLOG(0)) D  Q
 .S ^TMP("GMRCINC",$J,1,0)="No incomplete transactions for request #"_GMRCDA
 S GMRCLOG=GMRCLOG($O(GMRCLOG(0)))
 D EN^GMRCIERR(GMRCLOG,GMRCDA,$O(GMRCLOG(0)),1)
 M ^TMP("GMRCINC",$J)=^TMP("GMRCIERR",$J)
 S ACT=0
 F  S ACT=$O(GMRCLOG(ACT)) Q:'ACT  D
 . K ^TMP("GMRCIERR",$J)
 . S LINE=$O(^TMP("GMRCINC",$J," "),-1)+1
 . D ACTLG^GMRCIERR(GMRCDA,ACT,GMRCLOG(ACT),.LINE)
 . I '$D(^TMP("GMRCIERR",$J)) Q
 . S ^TMP("GMRCINC",$J,"B",ACT)=$O(^TMP("GMRCIERR",$J,0))+1
 . S LINE=0 F  S LINE=$O(^TMP("GMRCIERR",$J,LINE)) Q:'LINE  D
 .. S ^TMP("GMRCINC",$J,LINE+1,0)=^TMP("GMRCIERR",$J,LINE,0)
 .. Q
 . Q
 K ^TMP("GMRCIERR",$J)
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Incomplete transaction(s) for consult#: "_GMRCNUM
 Q
 ;
INIT ; -- init variables and list array
 N ACT,LIN
 S VALMBG=1
 S VALMCNT=$O(^TMP("GMRCINC",$J," "),-1)
 S ACT=0 F  S ACT=$O(^TMP("GMRCINC",$J,"B",ACT)) Q:'ACT  D
 . S LIN=^TMP("GMRCINC",$J,"B",ACT)
 . D CNTRL^VALM10(LIN,1,14,IORVON,IORVOFF)
 S VALMBCK="R"
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K GMRCNUM,GMRCSEL
 K ^TMP("GMRCINC",$J),^TMP("GMRCS",$J)
 Q
 ;
NEWCSLT ; pick new consult number to check for inc. trans.
 N DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 D FULL^VALM1
 S DIR(0)="PO^123:EMQ",DIR("A")="Select a new Consult number"
 S DIR("?")="Type in the number, date of request or patient name"
 D ^DIR
 I $D(DIRUT) Q
 I '$D(^GMR(123,+Y,0)) D  Q
 . W !,"There is no such consult request number"
 . K DIR S DIR(0)="E" D ^DIR
 K ^TMP("GMRCINC",$J),^TMP("GMRCS",$J)
 S GMRCNUM=+Y
 I '$D(GMRCSEL) D
 . D BLD(GMRCNUM)
 . D INIT
 . D HDR
 E  D
 . S GMRCSEL=GMRCNUM
 . K GMRCLOG
 . D BLD^GMRCITR(GMRCNUM)
 . I '$O(GMRCLOG(0)) D
 .. S ^TMP("GMRCINC",$J,1,0)="No transactions for consult#: "_GMRCNUM
 . E  D
 .. D DATA^GMRCITR(GMRCS)
 . D HDR^GMRCITR,LM^GMRCITR
 S VALMCNT=$O(^TMP("GMRCINC",$J," "),-1)
 S VALMBG=1
 Q
 ;
RETRAN ;resend a particular transaction
 N DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y,GMRCACT
 D FULL^VALM1
 S GMRCACT=$$SELACT(GMRCNUM) I 'GMRCACT Q
 I $O(^GMR(123.6,"AC",GMRCNUM,GMRCACT),-1)>0 D  Q
 . W !!,"There is at least one earlier incomplete transaction for this"
 . W !,"consult, all incomplete transactions should be processed in "
 . W !,"order.",!
 . S DIR(0)="E" D ^DIR
 W !
 S DIR(0)="YA"
 S DIR("A")="Are you sure you want to retransmit this activity? "
 S DIR("A",1)="You have selected the following activity:"
 S DIR("A",2)=$$GET1^DIQ(123.1,$P(^GMR(123,GMRCNUM,40,GMRCACT,0),U,2),.01)_" entered "_$$FMTE^XLFDT($P(^GMR(123,GMRCNUM,40,GMRCACT,0),U))
 S DIR("A",3)=" "
 D ^DIR
 I +Y'=1 Q
 D DELALRT^GMRCIBKG($O(^GMR(123.6,"AC",GMRCNUM,GMRCACT,1,0)))
 D TRIGR^GMRCIEVT(GMRCNUM,GMRCACT)
 S VALMBG=1
 Q
 ;
SELACT(GMRCDA)  ;select an incomplete activity
 N DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y,GMRC40
 S DIR(0)="N",DIR("A")="Select an activity number" D ^DIR
 I $D(DIRUT) Q ""
 S GMRC40=+Y
 K DIR
 I '$D(^GMR(123,GMRCDA,40,GMRC40)) D  Q ""
 . W !,"There is no such activity number for consult# "_GMRCNUM
 . S DIR(0)="E" D ^DIR
 I '$D(^GMR(123.6,"AC",GMRCDA,GMRC40)) D  Q ""
 . W !,"There is no incomplete IFC transaction for that activity"
 . S DIR(0)="E" D ^DIR
 Q GMRC40
 ;
MKCOMP ; mark a particular transaction complete
 N DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y,GMRCACT,FDA,GMRCLOG,GMRCERR
 D FULL^VALM1
 S GMRCACT=$$SELACT(GMRCNUM) I 'GMRCACT Q
 W !
 S DIR(0)="YA"
 S DIR("A")="Are you sure you want to mark this activity complete? "
 S DIR("A",1)="You have selected the following activity:"
 S DIR("A",2)=$$GET1^DIQ(123.1,$P(^GMR(123,GMRCNUM,40,GMRCACT,0),U,2),.01)_" entered "_$$FMTE^XLFDT($P(^GMR(123,GMRCNUM,40,GMRCACT,0),U))
 S DIR("A",3)=" "
 S DIR("A",4)="Use Caution marking a transaction complete!"
 S DIR("A",5)=" "
 D ^DIR
 I +$G(Y)'=1 Q
 S GMRCLOG=$O(^GMR(123.6,"AC",GMRCNUM,GMRCACT,1,0))
 I 'GMRCLOG Q
 S FDA(1,123.6,GMRCLOG_",",.06)="@"
 D UPDATE^DIE("","FDA(1)",,"GMRCERR")
 K ^TMP("GMRCINC",$J),^TMP("GMRCS",$J)
 D BLD(GMRCNUM)
 D INIT
 S VALMBG=1
 Q
