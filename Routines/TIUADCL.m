TIUADCL ; SLC/AJB - UNK Addenda Cleanup ; 10/01/04
 ;;1.0;TEXT INTEGRATION UTILITIES;**173,233**;Jun 20, 1997;Build 3
 ;
 ; Cleanup Utility for OPERATION REPORT addenda.
 ; Finds parentless/unknown addenda and attaches to user
 ; selected parent.
 ;
 Q
EN ; main entry point for TIU UNK ADDENDA CLEANUP
 N DTR1,TIUQUIT
 D DTRANGE(.DTR1) Q:$D(TIUQUIT)
 D EN^VALM("TIU UNK ADDENDA CLEANUP")
 Q
EXIT ;
 D XQORM
 Q
HDR ; sets header
 N HDR
 S HDR="UNKNOWN ADDENDA from "_$$FMTE^XLFDT(DTR1("BEGDT"),"D")_" to "_$$FMTE^XLFDT(DTR1("ENDDT"),"D")
 S VALMHDR(1)=$$SETSTR^VALM1(HDR,"",(IOM-$L(HDR))/2,$L(HDR))
 D XQORM
 Q
HELP ; help code
 N DIR
 I X="?" S DIR("A")="Enter RETURN to continue or '^' to exit",DIR(0)="E"
 D FULL^VALM1
 W !!,"The following actions are available:"
 W !,"Browse a Document  - View a selected document (if authorized)"
 W !,"Change View        - Modify search criteria"
 W !,"Detailed Display   - View detailed display of a document (if authorized)"
 W !,"Find Parent        - Find available OPERATION REPORTS to assign as parent",!
 I $D(DIR("A")) D ^DIR
 S VALMBCK="R"
 Q
INIT ; finds unknown addenda & creates list
 N ADDENDUM,STRTDT,TIUDA,TIU
 S TIU("IOCUOFF")=$C(27)_"[?25l",TIU("IOCUON")=$C(27)_"[?25h"
 W TIU("IOCUOFF")
 W !!,"Searching for the documents."
 S ADDENDUM=$$CHKFILE(8925.1,"ADDENDUM","I $P(^(0),U,4)=""DOC"""),TIUDA="",STRTDT=DTR1("BEGDT"),VALMCNT=0
 F  S STRTDT=$O(^TIU(8925,"F",STRTDT)) Q:STRTDT=""!(STRTDT>DTR1("ENDDT"))  F  S TIUDA=$O(^TIU(8925,"F",STRTDT,TIUDA)) Q:TIUDA=""  I +$G(^TIU(8925,TIUDA,0))=ADDENDUM,'+$P($G(^TIU(8925,TIUDA,0)),U,6) D
 . N DISPLAY
 . S VALMCNT=VALMCNT+1 W:VALMCNT#3=0 "."
 . S DISPLAY=$$SETSTR^VALM1(VALMCNT,"",1,4)
 . S DISPLAY=$$SETSTR^VALM1($$PATIENT^TIU144($P($G(^TIU(8925,TIUDA,0)),U,2)),DISPLAY,6,38)
 . S DISPLAY=$$SETSTR^VALM1(TIUDA,DISPLAY,40,50)
 . S DISPLAY=$$SETSTR^VALM1($$FDATE^VALM1($$GET1^DIQ(8925,TIUDA,1201,"I")),DISPLAY,52,62)
 . S DISPLAY=$$SETSTR^VALM1($$GET1^DIQ(8925,TIUDA,.05),DISPLAY,62,73)
 . S DISPLAY=$$SETSTR^VALM1("NO",DISPLAY,74,76)
 . D SET^VALM10(VALMCNT,DISPLAY,TIUDA)
 I VALMCNT=0 D
 . D SET^VALM10(2,$$SETSTR^VALM1("No records found to satisfy search criteria.","",(IOM-$L("No records found to satisfy search criteria."))/2,$L("No records found to satisfy search criteria.")),0)
 Q
XQORM ; default action for list manager
 S XQORM("#")=$O(^ORD(101,"B","TIU UNK ADDENDA SELECT",0))_U_"1:"_VALMCNT
 Q
ACTIONS ; user selectable actions
 N ACTION,TIUCONT
 D   I ACTION=-1 S VALMBCK="R" Q
 . N DIR,DIRUT,POP,X,Y
 . S DIR(0)=$S(VALM("TITLE")="TIU/Surgery Cleanup":"SA^1:Browse Document;2:Detailed Display;3:Find Parent",1:"SA^1:Browse Document;2:Detailed Display;3:Attach to Parent")
 . S DIR("A")="Select Action: "
 . S DIR("B")=$S(VALM("TITLE")="TIU/Surgery Cleanup":"Find Parent",1:"Attach to Parent")
 . S DIR("L",1)="1.   Browse a Document"
 . S DIR("L",2)=$S(VALM("TITLE")="TIU/Surgery Cleanup":"2.   Detailed Display                   3.   Find Parent",1:"2.   Detailed Display                   3.   Attach to Parent")
 . S DIR("L",4)=""
 . S DIR("L")="Enter selection by typing the name, number, or abbreviation"
 . S DIR("?",1)="The following actions are available:"
 . S DIR("?",2)=""
 . S DIR("?",3)="Browse a Document  - View a selected document (if authorized)"
 . S DIR("?",4)="Detailed Display   - Detailed View of a selected document (if authorized)"
 . S DIR("?")=$S(VALM("TITLE")="TIU/Surgery Cleanup":"Find Parent        - Find OPERATION REPORT to attach as parent",1:"Attach to Parent   - Attach selected addenda to parent")
 . F  D ^DIR D  Q:$G(TIUCONT)!$D(DIRUT)
 . . I VALM("TITLE")="Operation Reports",$$MULTI("TIUDOCS")>1,+Y=3 D  Q
 . . . W !!,"You may only attach addenda to one parent at a time."
 . . . W !,"Select only one parent for this action.",!
 . . . I $$READ^TIUU("EA","Press <RETURN> to continue")
 . . I $$MULTI("TIUDOCS")>1,(+Y=1!(+Y=2)) D  Q
 . . . W !!,"You may only view one document at a time."
 . . . W !,"Select only one document for this action.",!
 . . . I $$READ^TIUU("EA","Press <RETURN> to continue")
 . . S TIUCONT=1
 . I VALM("TITLE")="TIU/Surgery Cleanup" S ACTION=$S(+Y=1:"BROWSE",+Y=2:"DETDISP",+Y=3:"FNDPRNT",Y=U:-1,1:-1)
 . E  S ACTION=$S(+Y=1:"BROWSE",+Y=2:"DETDISP",+Y=3:"ATTACH^TIUADCL1",Y=U:-1,1:-1)
 I $G(TIUCONT)=1 D @ACTION
 S VALMBCK=$S(ACTION="ATTACH^TIUADCL1":"Q",1:"R")
 Q
BROWSE ; browse document
 N TIUDA S TIUDA=+$$ONEDOC()
 D EN^VALM("TIU BROWSE FOR READ ONLY")
 Q
CHKFILE(FILE,NAME,SCREEN) ; checks entry in file and returns IEN
 ; VMP/RJT - *233 - added Forget Lookup Value flag to DIC call since its affecting the value in the ^DISV global (spacebar return function)
 N DIC,X,Y S DIC=FILE,DIC(0)="FX",DIC("S")=$G(SCREEN),X=NAME D ^DIC
 Q +Y
CHNGVIEW ; allows user to change search parameters
 D FULL^VALM1
 W @IOF
 I VALM("TITLE")="TIU/Surgery Cleanup" D  I $D(TIUQUIT) S VALMBCK="R" Q
 . D DTRANGE(.DTR1) Q:$D(TIUQUIT)
 . D CLEAN^VALM10,INIT,HDR S VALMBG=1
 I VALM("TITLE")="Operation Reports" D  I $D(TIUQUIT) S VALMBCK="R" Q
 . D DTRANGE(.DTR2) Q:$D(TIUQUIT)
 . D CLEAN^VALM10,INIT^TIUADCL1,HDR^TIUADCL1 S VALMBG=1
 Q
DATE(TIUDT,TIUSEQ) ; if date is year entry only, appends Jan 01/Dec 31@2400 respectively
 I TIUDT["0000" S TIUDT=TIUDT/10000,TIUDT=TIUDT_$S(TIUSEQ=1:"0101",TIUSEQ=2:"1231")
 I TIUSEQ=2 S TIUDT=TIUDT_".24"
 Q TIUDT
DTRANGE(DTRANGE) ; prompts user for date range input
 N %DT,CNT,POP,X,Y
 S %DT="AE",%DT(0)=$$NOW^XLFDT*-1
 W @IOF
 F CNT=1:1:2 D
 . S %DT("A")=$S(CNT=1:"START WITH REFERENCE DATE:  ",CNT=2:"     GO TO REFERENCE DATE:  ")
 . S %DT("B")=$S(CNT=1:"Jan 01, 2003",CNT=2:$P($$HTE^XLFDT($H),"@"))
 . D ^%DT
 . I Y=-1 S CNT=2,TIUQUIT=1 Q
 . I CNT=1 S DTRANGE("BEGDT")=$$DATE(Y,CNT),%DT(0)=DTRANGE("BEGDT") Q
 . S DTRANGE("ENDDT")=$$DATE(Y,CNT),X=$P($$NOW^XLFDT,".")_".24" I DTRANGE("ENDDT")>X S CNT=1 W !!,?42,"Future dates are not allowed.",!
 Q
DETDISP ; detailed display
 N D0,DIROUT,RSTRCTD,TIUDA,TIUD,TIUDATA,TIUGDATA,TIUSEL,TIUI,TIUQUIT,Y
 S TIUDA=+$$ONEDOC()
 D
 . N TIUVIEW
 . D CLEAR^VALM1
 . S TIUVIEW=$$CANDO^TIULP(TIUDA,"VIEW")
 . I +TIUVIEW'>0 D  Q
 . . W !!,$C(7),$P(TIUVIEW,U,2),!
 . . I $$READ^TIUU("EA","Press <RETURN> to continue")
 . S RSTRCTD=$$DOCRES^TIULRR(TIUDA)
 . I RSTRCTD D  Q
 . . W !!,$C(7),"Ok, no harm done...",!
 . . I $$READ^TIUU("EA","Press <RETURN> to continue")
 . D EN^TIUAUDIT
 . I +$G(TIUQUIT) D FIXLSTNW^TIULM Q
 K VALMY S VALMBCK="R"
 Q
FNDPRNT ; executes LM for TIU UNK ADDENDA ATTACH
 N PARENT,TIUDISP,TIUTMP
 D EN^TIUADCL1
 S TIUTMP=""
 F  S TIUTMP=$O(TIUDOCS(TIUTMP)) Q:TIUTMP=""  D
 . S TIUDISP=@VALMAR@(TIUTMP,0)
 . S PARENT=+$P($G(^TIU(8925,TIUDOCS(TIUTMP),0)),U,6)
 . S TIUDISP=$$SETSTR^VALM1($S(PARENT=0:"NO",PARENT>0:"#"_PARENT),TIUDISP,74,80)
 . D SET^VALM10(TIUTMP,TIUDISP,TIUDOCS(TIUTMP))
 D RE^VALM4
 Q
MULTI(TIUCHK) ;
 N TIUCNT,TIUTMP
 S TIUCNT=0,TIUTMP=""
 F  S TIUTMP=$O(@TIUCHK@(TIUTMP)) Q:TIUTMP=""  S TIUCNT=TIUCNT+1
 Q TIUCNT
ONEDOC() ;
 N TIUTMP
 S TIUTMP=""
 F  S TIUTMP=$O(TIUDOCS(TIUTMP)) Q:+TIUTMP
 Q TIUDOCS(TIUTMP)
SELECT(ACTION) ; selects document(s) and calls ACTION
 N TIUDOCS,TIUSEL,TIUQUIT
 D FULL^VALM1
 I VALMCNT=0 W !,"No documents to select." H 3 Q
 S TIUSEL=$P(XQORNOD(0),"=",2)
 I TIUSEL="" D  Q:$D(TIUQUIT)
 . I VALMLST=1 S TIUDOCS(1)=$O(@VALMAR@("IDX",1,"")) Q
 . N DIR,X,Y
 . S DIR("A")="Select Document(s): (1-"_VALMLST_") "
 . S DIR(0)="LAC^1:"_VALMLST
 . D ^DIR I $D(DIRUT)!(Y=U) S TIUQUIT=1 Q
 . S TIUSEL=Y(0)
 I $A($E(TIUSEL,$L(TIUSEL)))<48!($A($E(TIUSEL,$L(TIUSEL)))>57) S TIUSEL=$E(TIUSEL,1,$L(TIUSEL)-1)
 F X=1:1  Q:$P(TIUSEL,",",X)=""  D
 . N TIUCNT
 . I $P(TIUSEL,",",X)["-" F TIUCNT=+$P(TIUSEL,",",X):1:$P($P(TIUSEL,",",X),"-",2) S:TIUCNT<VALMLST TIUDOCS(TIUCNT)=$O(@VALMAR@("IDX",TIUCNT,""))
 . E  S:$P(TIUSEL,",",X)'>VALMLST TIUDOCS($P(TIUSEL,",",X))=$O(@VALMAR@("IDX",$P(TIUSEL,",",X),""))
 I $$MULTI("TIUDOCS")>1,VALM("TITLE")="Operation Reports" D  Q
 . W !!,"You may not select multiple OPERATION Reports to view or attach addenda to."
 . W !,"Select only one document to view or attach addenda.",!
 . I $$READ^TIUU("EA","Press <RETURN> to continue")
 . S VALMBCK="R"
 I $$MULTI("TIUDOCS")>1,(ACTION="BROWSE"!(ACTION="DETDISP")) D  Q
 . W !!,"You may only view one document at a time."
 . W !,"Select only one document for this action.",!
 . I $$READ^TIUU("EA","Press <RETURN> to continue")
 I VALM("TITLE")'="Operation Reports" S VALMBCK="R"
 S TIUDOCS="" F  S TIUDOCS=$O(TIUDOCS(TIUDOCS)) Q:TIUDOCS=""  I $$GET1^DIQ(8925,TIUDOCS(TIUDOCS),.06)'="" K TIUDOCS(TIUDOCS)
 I $D(TIUDOCS)'>1 S VALMBCK="R" Q
 D @ACTION
 Q
