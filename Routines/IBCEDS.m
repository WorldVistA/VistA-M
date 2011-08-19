IBCEDS ;ALB/ESG - EDI CLAIM STATUS REPORT - SELECTION ;13-DEC-2007
 ;;2.0;INTEGRATED BILLING;**377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 ;
 NEW STOP,IBMETHOD,IBSORT1,IBSORT2,IBSORT3,IBSORTOR
 S STOP=0
 K ^TMP($J,"IBCEDS")
 W @IOF,!,"EDI Claim Status Report"
 ;
DS10 D CLAIM I STOP G:$$STOP EX G DS10
 I IBMETHOD="C" G DS70   ; skip down to the Sort questions
DS20 D DIV I STOP G:$$STOP EX G DS10
DS30 D PAYER I STOP G:$$STOP EX G DS20
DS40 D TXDATE I STOP G:$$STOP EX G DS30
DS50 D EDISTAT I STOP G:$$STOP EX G DS40
DS60 D CANCEL I STOP G:$$STOP EX G DS50
DS70 D SORT I STOP G:$$STOP EX G:IBMETHOD="C" DS10 G DS60
DS80 D DEVICE I STOP G:$$STOP EX G DS70
 ;
EX ; exit point
 Q
 ;
STOP() ; Determine if user wants to exit out of the whole option
 ; 1=yes, get out entirely
 ; 0=no, just go back to the previous question
 N DIR,X,Y,DIRUT
 ;
 W !
 S DIR(0)="Y"
 S DIR("A")="Do you want to exit out of this option entirely"
 S DIR("B")="YES"
 S DIR("?",1)="  Enter YES to immediately exit out of this option."
 S DIR("?")="  Enter NO to return to the previous question."
 D ^DIR K DIR
 I $D(DIRUT) S (STOP,Y)=1 G STOPX
 I 'Y S STOP=0
 ;
STOPX ; STOP exit pt
 Q Y
 ;
CLAIM ; enter in multiple claim#'s or generate a report
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,IBDONE,Z
CLM1 ;
 W !!,"CLAIM SELECTION METHOD"
 K ^TMP($J,"IBCEDS","CLAIM") S IBMETHOD=""
 S DIR(0)="SA^C:Select Specific Claims;R:Regular Selection Criteria"
 S DIR("A")="Method to Select Claims: "
 S DIR("B")="Regular Selection Criteria"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G CLAIMX
 S IBMETHOD=Y
 I IBMETHOD="R" K ^TMP($J,"IBCEDS","CLAIM") G CLAIMX   ; regular selection method
 ;
 ; select specific claims
 ;
 W !
 S IBDONE=0
 F  D  Q:IBDONE!STOP
 . S DIR(0)="PAO^364:AEMQZ"
 . S DIR("S")="I '$O(^IBA(364,""B"",+$G(^(0)),Y))"   ; prevent multiple 364 entries from listing
 . S DIR("A")="   Select a Claim: "
 . I $O(^TMP($J,"IBCEDS","CLAIM","")) S DIR("A")="   Select Another Claim: "
 . D ^DIR K DIR
 . I $D(DUOUT)!$D(DTOUT) S STOP=1 Q    ; up arrow or timeout
 . I +Y'>0 S IBDONE=1 Q                ; null response
 . S Z=$G(^IBA(364,+Y,0))
 . I $P(Z,U,7) W *7,!!?3,"Test Claim Transmissions are not Allowed.",! Q
 . I $P(Z,U,3)="X" W *7,!!?3,"This Claim is still in a READY FOR EXTRACT status.",! Q
 . I '$P(Z,U,2) W *7,!!?3,"This Claim has no Batch#.",! Q
 . I '$P(Z,U,1) W *7,!!?3,"This Claim is Corrupted.",! Q
 . ;
 . S ^TMP($J,"IBCEDS","CLAIM",+Z)=+Y
 . Q
 ;
 I STOP G CLAIMX
 ;
 I '$O(^TMP($J,"IBCEDS","CLAIM","")) D  G CLM1
 . W *7,!!?3,"No claims have been selected.  Please try again."
 . Q
 ;
CLAIMX ;
 Q
 ;
DIV ; division selection
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,IBDONE,DIC
DV1 ;
 K ^TMP($J,"IBCEDS","DIV")
 W !!,"DIVISION SELECTION"
 S DIR(0)="SA^A:All Divisions;S:Selected Divisions"
 S DIR("A")="Include All Divisions or Selected Divisions? "
 S DIR("B")="All Divisions"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G DIVX
 I Y="A" K ^TMP($J,"IBCEDS","DIV") G DIVX
 ;
 W !
 S IBDONE=0
 F  D  Q:IBDONE!STOP
 . S DIC=40.8,DIC(0)="AEMQ",DIC("A")="   Select Division: "
 . I $O(^TMP($J,"IBCEDS","DIV","")) S DIC("A")="   Select Another Division: "
 . D ^DIC K DIC                       ; lookup
 . I $D(DUOUT)!$D(DTOUT) S STOP=1 Q   ; up arrow or timeout
 . I +Y'>0 S IBDONE=1 Q               ; user is done
 . S ^TMP($J,"IBCEDS","DIV",+Y)=$P(Y,U,2)
 . Q
 ;
 I STOP G DIVX
 ;
 I '$O(^TMP($J,"IBCEDS","DIV","")) D  G DV1
 . W *7,!!?3,"No divisions have been selected.  Please try again."
 . Q
 ;
DIVX ;
 Q
 ;
PAYER ; payer selection
 NEW IBPAYER,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,IBDONE,DIC,EDI,PROF,INST
PY1 ;
 K ^TMP($J,"IBCEDS","INS")
 W !!,"PAYER SELECTION"
 S IBPAYER=""
 S DIR(0)="SA^A:All Payers;S:Selected Payers"
 S DIR("A")="Include All Payers or Selected Payers? "
 S DIR("B")="All Payers"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G PAYERX
 I Y="A" K ^TMP($J,"IBCEDS","INS") G PAYERX
 W !
 S DIR(0)="Y"
 S DIR("A")="   Include all payers with the same electronic Payer ID"
 S DIR("B")="Yes"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G PAYERX
 S IBPAYER=Y
 W !
 ;
 S IBDONE=0
 F  D  Q:IBDONE!STOP
 . S DIC=36,DIC(0)="AEMQ",DIC("A")="   Select Insurance Company: "
 . I $O(^TMP($J,"IBCEDS","INS",1,"")) S DIC("A")="   Select Another Insurance Company: "
 . S DIC("W")="D INSLIST^IBCEMCA(Y)"
 . D ^DIC K DIC                       ; lookup
 . I $D(DUOUT)!$D(DTOUT) S STOP=1 Q   ; up arrow or timeout
 . I +Y'>0 S IBDONE=1 Q               ; user is done
 . S ^TMP($J,"IBCEDS","INS",1,+Y)=$P(Y,U,2)
 . I 'IBPAYER Q
 . S EDI=$$UP^XLFSTR($G(^DIC(36,+Y,3)))
 . S PROF=$P(EDI,U,2)
 . S INST=$P(EDI,U,4)
 . I PROF'="",PROF'["PRNT" S ^TMP($J,"IBCEDS","INS",2,PROF,+Y)=""
 . I INST'="",INST'["PRNT" S ^TMP($J,"IBCEDS","INS",2,INST,+Y)=""
 . Q
 ;
 I STOP G PAYERX
 ;
 I '$O(^TMP($J,"IBCEDS","INS",1,"")) D  G PY1
 . W *7,!!?3,"No payers have been selected.  Please try again."
 . Q
 ;
PAYERX ;
 Q
 ;
TXDATE ; date range for the last transmission date
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,TDEF
 K ^TMP($J,"IBCEDS","ALTDT")
 W !!,"LAST TRANSMIT DATE RANGE SELECTION"
 S DIR(0)="DAO^:"_DT_":AEX"
 S DIR("A")="   Start with Date Last Transmitted: "
 S DIR("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT,-14),"5Z")
 D ^DIR K DIR
 I $D(DIRUT)!'Y S STOP=1 G TXDATEX
 S $P(^TMP($J,"IBCEDS","ALTDT"),U,1)=Y
 ;
 S DIR(0)="DAO^"_Y_":"_DT_":AEX"
 S DIR("A")="   Go to Date Last Transmitted: "
 S TDEF=$$FMADD^XLFDT(DT,-7)       ; normal to date default
 I TDEF'>Y S TDEF=DT               ; if to date default is on or before from date, set default=today
 S DIR("B")=$$FMTE^XLFDT(TDEF,"5Z")
 D ^DIR K DIR
 I $D(DIRUT)!'Y S STOP=1 G TXDATEX
 S $P(^TMP($J,"IBCEDS","ALTDT"),U,2)=Y
TXDATEX ;
 Q
 ;
EDISTAT ; selection of one or all of the EDI claim statuses
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,IBDONE,EDILST
EDI1 ;
 W !!,"EDI CLAIM STATUS SELECTION"
 K ^TMP($J,"IBCEDS","EDI")
 S DIR(0)="SA^A:All EDI Statuses;S:Selected EDI Statuses"
 S DIR("A")="Include All EDI Statuses or Selected EDI Statuses? "
 S DIR("B")="Selected EDI Statuses"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G EDISTATX
 I Y="A" K ^TMP($J,"IBCEDS","EDI") G EDISTATX
 ;
 W !
 K EDILST D FIELD^DID(364,.03,,"POINTER","EDILST")
 S IBDONE=0
 F  D  Q:IBDONE!STOP
 . S DIR(0)="364,.03AO"
 . I $G(EDILST("POINTER"))'="" S DIR(0)="SAO^"_EDILST("POINTER")
 . S DIR("A")="   Select Status: "
 . I $O(^TMP($J,"IBCEDS","EDI",""))'="" S DIR("A")="   Select Another Status: "
 . I $O(^TMP($J,"IBCEDS","EDI",""))="" S DIR("B")="RECEIVED IN AUSTIN"
 . D ^DIR K DIR
 . I $D(DUOUT)!$D(DTOUT) S STOP=1 Q   ; up arrow or timeout
 . I Y="" S IBDONE=1 Q
 . S ^TMP($J,"IBCEDS","EDI",Y)=$G(Y(0))
 . Q
 ;
 I STOP G EDISTATX
 ;
 I $O(^TMP($J,"IBCEDS","EDI",""))="" D  G EDI1
 . W *7,!!?3,"No EDI statuses have been selected.  Please try again."
 . Q
 ;
EDISTATX ;
 Q
 ;
CANCEL ; Include cancelled claims?
 W !!,"CANCELLED CLAIM SELECTION"
 K ^TMP($J,"IBCEDS","CANCEL")
 S DIR(0)="Y"
 S DIR("A")="Include Cancelled Claims"
 S DIR("B")="YES"
 S DIR("?",1)="  Enter No to omit claims that have been cancelled in IB and/or AR."
 S DIR("?")="  Enter Yes to include claims that have been cancelled in IB and/or AR."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G CANCELX
 S ^TMP($J,"IBCEDS","CANCEL")=Y
CANCELX ;
 Q
 ;
SORT ; Gather the primary, secondary, and tert sorts
 W @IOF
 W !!,"SORT CRITERIA"
 K IBSORTOR
 D SORTSEL^IBCEDS1(1) I STOP G SORTX
 D SORTSEL^IBCEDS1(2) I STOP G SORTX
 I $G(IBSORT2)'="" D SORTSEL^IBCEDS1(3) I STOP G SORTX
SORTX ;
 Q
 ;
DEVICE ; Device selection
 NEW ZTRTN,ZTDESC,ZTSAVE,POP
 W !!!,"This report is 132 characters wide.  Please choose an appropriate device.",!
 S ZTRTN="EN^IBCEDC"
 S ZTDESC="COMPILE/PRINT EDI CLAIM STATUS DETAIL REPORT"
 S ZTSAVE("IBMETHOD")=""
 S ZTSAVE("IBSORT1")=""
 S ZTSAVE("IBSORT2")=""
 S ZTSAVE("IBSORT3")=""
 S ZTSAVE("IBSORTOR")=""
 S ZTSAVE("^TMP($J,""IBCEDS"",")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM")
 I POP S STOP=1
DEVICEX ;
 Q
 ;
