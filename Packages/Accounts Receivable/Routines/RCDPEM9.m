RCDPEM9 ;OIFO-BAYPINES/PJH - PAYER SELECTION ;10/18/11 6:17pm
 ;;4.5;Accounts Receivable;**276,284**;Mar 20, 1995;Build 35
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
GETPAY(FILE) ; Let user select payer for filter
 ;
 ; Returned RTNFLG value
 ;
 ; PRCA*4.5*284 - Added pieces 2 & 3 to provide background jobs information to re-calculate payer list.
 ;
 ; Piece 1: -1 = none selected
 ;           1 = range of payers
 ;           2 = all payers selected
 ;           3 = specific payers
 ; Piece 2: From Range (When a from/thru range is selected by user)
 ; Piece 3: Thru Range (When a from/thru range is selected by user)
 ;
 ; Payers selected are returned in ^TMP("RCSELPAY",$J
 ;
 N RCPAY,RCINC,CNT,RTNFLG,I,RCANS,INDX,X,RCANS2,DIR,Y,DTOUT,DUOUT,RCINSF,RCINST,RNG1,RNG2
 ;
 S RTNFLG=0,INDX=1,RNG1="",RNG2=""
 ;
 ;Clear list of selected payers
 K ^TMP("RCSELPAY",$J)
 ;
 ;Select option required (All, Selected or Range)
 S DIR(0)="SA^A:ALL;S:SPECIFIC;R:RANGE",DIR("A")="RUN REPORT FOR (A)LL, (S)PECIFIC, OR (R)ANGE OF INSURANCE COMPANIES?: ",DIR("B")="ALL" W ! D ^DIR K DIR
 ;Abort on ^ exit or timeout
 I $D(DTOUT)!$D(DUOUT) S RTNFLG=-1 Q RTNFLG
 ;
 ;ALL payers
 I Y="A" D
 .; Build list of ALL stations
 .S CNT=0,RCPAY="",RTNFLG=2
 .F  S RCPAY=$O(^RCY(FILE,"C",RCPAY)) Q:RCPAY=""  D
 ..S CNT=CNT+1,^TMP("RCSELPAY",$J,CNT)=RCPAY
 ;
 ;Selected Payers
 I Y="S" D
 .D GLIST(FILE),GETPAYS(CNT)
 ;
 ;Range of Payers
 I Y="R" D
 .D GLIST(FILE),GETPAYR
 ;
 ;Clear list of all payers
 K:RTNFLG'=2 ^TMP("RCPAYER",$J)
 ;If aborting also clear any selected payers
 K:RTNFLG=-1 ^TMP("RCSELPAY",$J)
 ;
 ;Return value
 ; PRCA*4.5*284 - Update return value to include from/thru range. See above for documentation
 Q RTNFLG_"^"_RNG1_"^"_RNG2
 ;
GLIST(FILE) ;Build list for this file
 ;
 ;Clear workfile
 K ^TMP("RCPAYER",$J)
 ;
 ; Build list of available stations
 S CNT=0,RCPAY=""
 F  S RCPAY=$O(^RCY(FILE,"C",RCPAY)) Q:RCPAY=""  D
 .S CNT=CNT+1
 .S ^TMP("RCPAYER",$J,CNT)=RCPAY
 .S ^TMP("RCPAYER",$J,"B",RCPAY,CNT)=""
 ;
 Q
 ;
GETPAYS(CNT) ;select payer for filter, specific
 ;
 N PNAME
 ;
 K ^TMP("RCDPEM9",$J)
 ;
 F  Q:RTNFLG'=0  D
 .N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 .S DIR("A")="SELECT INSURANCE COMPANY"
 .S DIR(0)="FO^1:30"
 .S DIR("?")="ENTER THE NAME OF THE PAYER OR '??' TO LIST PAYERS"
 .S DIR("??")="^D LIST^RCDPEM9(CNT)"
 .D ^DIR K DIR
 .;User pressed ENTER
 .I Y="",'$D(DTOUT) S RTNFLG=$S($D(^TMP("RCSELPAY")):3,1:-1) Q
 .;First check for exits
 .I $D(DUOUT)!$D(DTOUT)!$D(DIRUT)!$D(DIROUT) S RTNFLG=-1 Q
 .;Check for  help
 .S (RCANS,RCANS2)=""
 .S RCANS=Y
 .; Now check for exotic user input
 .I '(RCANS?.N) S RCANS2=$O(^TMP("RCPAYER",$J,"B",RCANS,RCANS2)) D:'RCANS2 PART Q:'$G(RCANS2)
 .S:$G(RCANS2) RCANS=RCANS2 I RCANS="" W "  ??" Q
 .I RCANS?.N&((+RCANS<1)!(+RCANS>CNT)) W "  ??" Q
 .I RCANS'?.N W "  ??" Q
 .I $D(^TMP("RCDPEM9",$J,RCANS)) W "  ?? PAYER ALREADY SELECTED" Q
 .S ^TMP("RCDPEM9",$J,RCANS)=""
 .S PNAME=$G(^TMP("RCPAYER",$J,RCANS))
 .W "  "_PNAME
 .S ^TMP("RCSELPAY",$J,INDX)=$G(^TMP("RCPAYER",$J,RCANS))
 .S INDX=INDX+1
 ;
 K ^TMP("RCDPEM9",$J)
 Q
 ;
LIST(CNT) ;
 ; Prompt users for stations to be used for filtering
 N I
 F I=1:1:CNT D
 .W !,I,".",?5,$G(^TMP("RCPAYER",$J,I))
 Q
 ;
PART ;
 N RCPAR,CNT,IEN
 S RCPAR=0,CNT=0
 F  S RCPAR=$O(^TMP("RCPAYER",$J,"B",RCPAR)) Q:RCPAR=""  D
 .S IEN=$O(^TMP("RCPAYER",$J,"B",RCPAR,""))
 .I $E(RCPAR,1,$L(RCANS))[RCANS W !,?10,IEN,".",^TMP("RCPAYER",$J,IEN) S CNT=1
 I 'CNT W "  ??"
 Q
 ;
GETPAYR ;select payer for filter, range
 ; called from ^RCDPEAR1
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,INDX,X,Y,RCINSF,RCINST,NUM
 S DIR("?")="ENTER THE NAME OF THE PAYER OR '??' TO LIST PAYERS"
 S DIR("??")="^D LIST^RCDPEM9(CNT)"
 S DIR(0)="FA^1:30^K:X'?1.U.E X",DIR("A")="START WITH INSURANCE COMPANY NAME: ",DIR("B")=$E($O(^TMP("RCPAYER",$J,"B","")),1,30)
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)!(Y="") S RTNFLG=-1 Q
 S RCINSF=Y
 S DIR("?")="ENTER THE NAME OF THE PAYER OR '??' TO LIST PAYERS"
 S DIR("??")="^D LIST^RCDPEM9(CNT)"
 S DIR(0)="FA^1:30^K:X'?1.U.E X",DIR("A")="GO TO INSURANCE COMPANY NAME: ",DIR("B")=$E($O(^TMP("RCPAYER",$J,"B",""),-1),1,30)
 F  W ! D ^DIR Q:$S($D(DTOUT)!$D(DUOUT):1,1:RCINSF']Y)  W !,"'GO TO' NAME MUST COME AFTER 'START WITH' NAME"
 K DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)!(Y="") S RTNFLG=-1 Q
 S RCINST=Y_"Z"  ;entry of "ABC" will pick up "ABC INSURANCE" if "Z" is appended
 ;If the first name is an exact match, back up to the previous entry
 I $D(^TMP("RCPAYER",$J,"B",RCINSF)) S RCINSF=$O(^TMP("RCPAYER",$J,"B",RCINSF),-1)
 ; PRCA*4.5*284 - Save from/thru user responses in RNG1 & RNG2 to rebuild after report is queued. Will be returned to the calling program.
 S RNG1=RCINSF,RNG2=RCINST
 S INDX=1 F  S RCINSF=$O(^TMP("RCPAYER",$J,"B",RCINSF)) Q:RCINSF=""  Q:RCINSF]RCINST  D
 . S NUM=$O(^TMP("RCPAYER",$J,"B",RCINSF,""))
 . S ^TMP("RCSELPAY",$J,INDX)=$G(^TMP("RCPAYER",$J,NUM))
 . S INDX=INDX+1
 ;Set return value
 I INDX=1 S RTNFLG=-1 Q  ; no entries in selected range
 S RTNFLG=1
 Q
