PRCFSDR ;WOIFO/SAB/LKG - IFCAP 1358 SEGREGATION OF DUTIES REPORT ;12/29/10  10:48
 ;;5.1;IFCAP;**154**;OCT 20, 2000;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; IAs
 ;  #10003  DD^%DT
 ;  #10000  NOW^%DTC
 ;  #10086  %ZIS, HOME^%ZIS
 ;  #10089  %ZISC
 ;  #10063  %ZTLOAD, $$S^%ZTLOAD
 ;  #2056   $$GET1^DIQ
 ;  #10026  DIR
 ;  #5574   $$EV1358^PRCEMOA
 ;  #10103  $$FMADD^XLFDT, $$FMTE^XLFDT
 ;  #5582   ^PRC(411,
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,PRCALL,PRCDT1,PRCDT2,%ZIS,POP,X,Y
 ;
 ; ask from date
 S DIR(0)="D^::EX",DIR("A")="From Date"
 ;   default from date is first day of previous month
 S DIR("B")=$$FMTE^XLFDT($E($$FMADD^XLFDT($E(DT,1,5)_"01",-1),1,5)_"01")
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S PRCDT1=Y
 ;
 ; ask to date
 S DIR(0)="DA^"_PRCDT1_"::EX",DIR("A")="To Date: "
 ;   default to date is last day of specified month
 S X=PRCDT1 D DAYS
 S DIR("B")=$$FMTE^XLFDT($E(PRCDT1,1,5)_X)
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S:$P(Y,".",2)="" $P(Y,".",2)="235959"
 S PRCDT2=Y
 ;
 ; ask if all stations
 S DIR(0)="Y",DIR("A")="For all stations",DIR("B")="YES"
 D ^DIR K DIR G:$G(DIRUT) EXIT
 S PRCSTALL=Y
 S PRCSTN=""
 ; if not all stations ask station
 I 'PRCSTALL D  G:PRCSTN="" EXIT
 . S PRCSTN=""
 . S DIC="^PRC(411,",DIC(0)="AQEM"
 . D ^DIC Q:Y<0
 . S PRCSTN=$P(Y,U,2)
 ;
 ; ask if violations only
 S DIR(0)="Y",DIR("A")="Only list 1358s with a violation (Y/N)"
 S DIR("B")="YES"
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S PRCORV=Y
 ;
 ; ask device
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 . S ZTRTN="QEN^PRCFSDR",ZTDESC="IFCAP 1358 Segregation of Duties Report"
 . F PRCX="PRCDT*","PRCORV","PRCSTALL","PRCSTN" S ZTSAVE(PRCX)=""
 . D ^%ZTLOAD,HOME^%ZIS
 ;
QEN ; queued entry
 U IO
 ;
GATHER ; collect and sort data
 N %
 K ^TMP($J)
 ;
 S PRCC("CER")=0 ; initialize count of certifications
 S PRCC("OBL")=0 ; initialize count of obligations
 S PRCC("VIO")=0 ; initialize count of obligations with a violation
 ;
 ; find invoice certification events during specified period
 ; Loop through Invoice Tracking file #421.5 using "AF" index on CERTIFIED BY SIG DATE/TIME (#61.9)
 S PRCSDT=PRCDT1-.000001
 F  S PRCSDT=$O(^PRCF(421.5,"AF",PRCSDT)) Q:PRCSDT=""!(PRCSDT>PRCDT2)  D
 . S PRCDA=0
 . F  S PRCDA=$O(^PRCF(421.5,"AF",PRCSDT,PRCDA)) Q:'PRCDA  D
 . . N PRCNOD0,PRCNOD1,PRCNOD2,PRCNOD21,PRCPO,PRCDT,PRCSTB
 . . S PRCNOD0=$G(^PRCF(421.5,PRCDA,0)),PRCNOD1=$G(^(1)),PRCNOD2=$G(^(2)),PRCNOD21=$G(^(2.1))
 . . S PRCPO=$P(PRCNOD0,U,7) Q:PRCPO'>0  Q:$$GET1^DIQ(442,PRCPO_",",.02)'["1358"
 . . Q:$P(PRCNOD2,U,10)'>0  S PRCDT=$P(PRCNOD21,U,5) Q:PRCDT<PRCDT1  Q:PRCDT>PRCDT2
 . . S PRCOB=$P(PRCNOD1,U,3) ; full 1358 obligation number
 . . ;
 . . ; if report not for all stations, skip invoice certification from different station
 . . I 'PRCSTALL D  I PRCSTB'=PRCSTN Q
 . . . S PRCSTB=$$GET1^DIQ(442,PRCPO_",",31) S:PRCSTB="" PRCSTB=$P(PRCNOD1,U,2)
 . . . I PRCSTB="" S PRCSTB=+PRCOB
 . . ;
 . . ; add event to ^TMP($J,1358 #,date/time,invoice #)=certifier
 . . S ^TMP($J,PRCOB,PRCDT,$P(PRCNOD0,U))=$P(PRCNOD2,U,10)
 . . S PRCC("CER")=PRCC("CER")+1 ; incr count of certifications
 ;
 ; loop thru obligations and add IFCAP events and actors to ^TMP
 S PRCOB="" F  S PRCOB=$O(^TMP($J,PRCOB)) Q:PRCOB=""  D
 . S PRCC("OBL")=PRCC("OBL")+1 ; incr count of 1358s
 . N PRCARRAY,PRCX
 . S PRCX=$$EV1358^PRCEMOA(PRCOB,"PRCARRAY")
 . I PRCX'=1 S ^TMP($J,PRCOB)=PRCX Q  ; error reported by the API
 . S PRCDT=""
 . F  S PRCDT=$O(PRCARRAY(PRCDT)) Q:PRCDT=""!($P(PRCDT,".")>PRCDT2)  D
 . . S PRCEV="" F  S PRCEV=$O(PRCARRAY(PRCDT,PRCEV)) Q:PRCEV=""  D
 . . . S ^TMP($J,PRCOB,PRCDT,PRCEV)=PRCARRAY(PRCDT,PRCEV)
 ;
 ; loop thru obligations and add segregation of duty violations to ^TMP
 S PRCOB="" F  S PRCOB=$O(^TMP($J,PRCOB)) Q:PRCOB=""  D
 . Q:$P($G(^TMP($J,PRCOB)),U)="E"  ; skip because missing IFCAP events
 . ;
 . N PRCAPP,PRCOBL,PRCREQ,PRCVIO
 . S PRCVIO=0 ; init violation flag for the 1358
 . ; loop thru date/time stamps
 . S PRCDT="" F  S PRCDT=$O(^TMP($J,PRCOB,PRCDT)) Q:PRCDT=""  D
 . . ; loop thru events
 . . S PRCEV="" F  S PRCEV=$O(^TMP($J,PRCOB,PRCDT,PRCEV)) Q:PRCEV=""  D
 . . . N PRCX
 . . . S PRCX=$G(^TMP($J,PRCOB,PRCDT,PRCEV))
 . . . ; process IFCAP certification event
 . . . I PRCEV D
 . . . . ; check fo violation
 . . . . I PRCX,$D(PRCREQ(PRCX)) S PRCVIO=1,^TMP($J,PRCOB,PRCDT,PRCEV,"V1")="User previously acted as requestor on a prior 1358 event."
 . . . . I PRCX,$D(PRCAPP(PRCX)) S PRCVIO=1,^TMP($J,PRCOB,PRCDT,PRCEV,"V2")="User previously acted as approver on a prior 1358 event."
 . . . . I PRCX,$D(PRCOBL(PRCX)) S PRCVIO=1,^TMP($J,PRCOB,PRCDT,PRCEV,"V3")="User previously acted as obligator on a prior 1358 event."
 . . . ; process an IFCAP event
 . . . I "^O^A^"[(U_PRCEV_U) D
 . . . . ; save IFCAP actors in lists
 . . . . I $P(PRCX,U,1) S PRCREQ($P(PRCX,U,1))=""
 . . . . I $P(PRCX,U,2) S PRCAPP($P(PRCX,U,2))=""
 . . . . I $P(PRCX,U,3) S PRCOBL($P(PRCX,U,3))=""
 . . . . ; check for violation on IFCAP event
 . . . . I $P(PRCX,U,2)=$P(PRCX,U,1) S PRCVIO=1,^TMP($J,PRCOB,PRCDT,PRCEV,"V1")="Approver previously acted as requestor on this transaction."
 . . . . I $P(PRCX,U,3)=$P(PRCX,U,1) S PRCVIO=1,^TMP($J,PRCOB,PRCDT,PRCEV,"V2")="Obligator previously acted as requester on this transaction."
 . . . . I $P(PRCX,U,3)=$P(PRCX,U,2) S PRCVIO=1,^TMP($J,PRCOB,PRCDT,PRCEV,"V3")="Obligator previously acted as approver on this transaction."
 . ;
 . I PRCVIO D  ; violation was found
 . . S ^TMP($J,PRCOB)="V" ; flag 1358
 . . S PRCC("VIO")=PRCC("VIO")+1 ; incr count of 1358 with violation
 ;
PRINT ; report data
 S (PRCQUIT,PRCPG)=0 D NOW^%DTC S Y=% D DD^%DT S PRCDTR=Y
 K PRCDL
 S PRCDL="",$P(PRCDL,"-",80)=""
 S PRCDL("CH")=$E(PRCDL,1,10)_" "_$E(PRCDL,1,14)_" "_$E(PRCDL,1,11)_" "_$E(PRCDL,1,9)_"  "_$E(PRCDL,1,30)
 ;
 ; build page header text for selection criteria
 K PRCHDT
 S PRCHDT(1)="  Including Certifications from "
 S PRCHDT(1)=PRCHDT(1)_$$FMTE^XLFDT(PRCDT1)_" to "_$$FMTE^XLFDT(PRCDT2)
 S PRCHDT(1)=PRCHDT(1)_" for "
 S PRCHDT(1)=PRCHDT(1)_$S(PRCSTALL:"all stations",1:"Station "_PRCSTN)
 S:PRCORV PRCHDT(2)="  Only 1358s with a segregation of duty violation shown."
 ;
 D HD
 ;
 ; loop thru obligations
 S PRCOB="" F  S PRCOB=$O(^TMP($J,PRCOB)) Q:PRCOB=""  D  Q:PRCQUIT
 . N PRCERR,PRCEVFP,PRCOBX,PRCVIO
 . S PRCOBX=$G(^TMP($J,PRCOB))
 . S PRCERR=$S($P(PRCOBX,U)="E":1,1:0) ; set true if error from IFCAP
 . S PRCVIO=$S($P(PRCOBX,U)="V":1,1:0) ; set true if violation was found
 . ;
 . ; if only reporting violations then skip 1358 when no error/violation
 . I PRCORV,'PRCERR,'PRCVIO Q
 . ;
 . ; check for page break
 . I $Y+7>IOSL D HD Q:PRCQUIT
 . ; 
 . W !,PRCDL("CH")
 . W !,PRCOB
 . ;
 . I PRCERR D
 . . W !,"IFCAP events for this 1358 missing due to following error:"
 . . W !,$P(PRCOBX,U,2),!
 . ;
 . S PRCEVFP=1 ; init flag as true (Event - First Printed for 1358)
 . ; loop thru date/times
 . S PRCDT="" F  S PRCDT=$O(^TMP($J,PRCOB,PRCDT)) Q:PRCDT=""  D  Q:PRCQUIT
 . . ; loop thru events
 . . S PRCEV=""
 . . F  S PRCEV=$O(^TMP($J,PRCOB,PRCDT,PRCEV)) Q:PRCEV=""  D  Q:PRCQUIT
 . . . N PRCX,PRCV
 . . . ; if only reporting violations, don't print certify event without
 . . . I PRCORV,PRCEV,$O(^TMP($J,PRCOB,PRCDT,PRCEV,"V"))="" Q
 . . . I 'PRCEVFP,$Y+5>IOSL D HD Q:PRCQUIT  D HDEV
 . . . I 'PRCEVFP W !
 . . . I PRCEVFP S PRCEVFP=0
 . . . S PRCX=$G(^TMP($J,PRCOB,PRCDT,PRCEV))
 . . . W ?11,$$FMTE^XLFDT(PRCDT,"2MZ")
 . . . W ?26,$S(PRCEV="O":"OBLIGATE",PRCEV="A":"ADJUST",1:PRCEV)
 . . . I PRCEV W ?38,"CERTIFIER",?49,$$GET1^DIQ(200,PRCX,.01)
 . . . I PRCEV="O"!(PRCEV="A") D
 . . . . W ?38,"REQUESTOR" W:$P(PRCX,U) ?49,$$GET1^DIQ(200,$P(PRCX,U),.01)
 . . . . W !,?38,"APPROVER" W:$P(PRCX,U,2) ?49,$$GET1^DIQ(200,$P(PRCX,U,2),.01)
 . . . . W !,?38,"OBLIGATOR" W:$P(PRCX,U,3) ?49,$$GET1^DIQ(200,$P(PRCX,U,3),.01)
 . . . ; list any violations found for this event (max is 3)
 . . . S PRCV="" F  S PRCV=$O(^TMP($J,PRCOB,PRCDT,PRCEV,PRCV)) Q:PRCV=""  D
 . . . . N PRCXV
 . . . . S PRCXV=$G(^TMP($J,PRCOB,PRCDT,PRCEV,PRCV))
 . . . . I PRCXV]"" W !,?8,"***",PRCXV
 ;
 I PRCQUIT W !!,"REPORT STOPPED AT USER REQUEST"
 E  D  ; report footer
 . I $Y+5>IOSL D HD Q:PRCQUIT
 . W !,PRCDL("CH")
 . W !!,"  ",PRCC("CER")," invoice certification",$S(PRCC("CER")=1:" was",1:"s were")," found during the report period."
 . Q:PRCC("OBL")=0
 . W !,"  ",PRCC("OBL")," 1358 Obligation",$S(PRCC("OBL")=1:" is",1:"s are")," referenced."
 . W !,"  A violation of segregation of duties was detected on ",$S(PRCC("VIO")=0:"none",1:PRCC("VIO"))," of the 1358s."
 I 'PRCQUIT,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J)
 K PRCC,PRCDA,PRCDL,PRCDT,PRCDT1,PRCDT2,PRCDTR,PRCEV,PRCHDT,PRCOB,PRCORV
 K PRCPG,PRCSDT,PRCSTALL,PRCSTN,PRCQUIT
 K DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
 ;
HD ; page header
 N PRCI
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,PRCQUIT=1 Q
 I $E(IOST,1,2)="C-",PRCPG S DIR(0)="E" D ^DIR K DIR I 'Y S PRCQUIT=1 Q
 I $E(IOST,1,2)="C-"!PRCPG W @IOF
 S PRCPG=PRCPG+1
 W !,"IFCAP 1358 Segregation of Duties",?49,PRCDTR,?72,"page ",PRCPG
 S PRCI=0 F  S PRCI=$O(PRCHDT(PRCI)) Q:'PRCI  W !,PRCHDT(PRCI)
 W !!,"1358",?11,"DATE/TIME",?26,"EVENT/INV#",?38,"ROLE",?49,"NAME"
 Q
 ;
HDEV ; page header for continued event
 W !,PRCOB," (continued from previous page)"
 Q
 ;
DAYS ;CALCULATES THE NUMBER OF DAYS IN MONTH - Copied from routine FBAAUTL1
 N X1
 S X1=X,X=+$E(X,4,5),X=$S("^1^3^5^7^8^10^12^"[("^"_X_"^"):31,X=2:28,1:30)
 I X=28 D
 . N YEAR
 . S YEAR=$E(X1,1,3)+1700
 . I $S(YEAR#400=0:1,YEAR#4=0&'(YEAR#100=0):1,1:0) S X=29
 Q
 ; 
 ;PRCFSDR
