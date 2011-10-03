FBAASDR ;WOIFO/SAB - FEE 1358 SEGREGATION OF DUTIES REPORT ;11/18/2010
 ;;3.5;FEE BASIS;**117**;JAN 30, 1995;Build 9
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
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,FBALL,FBDT1,FBDT2,%ZIS,POP,X,Y
 ;
 ; ask from date
 S DIR(0)="D^::EX",DIR("A")="From Date"
 ;   default from date is first day of previous month
 S DIR("B")=$$FMTE^XLFDT($E($$FMADD^XLFDT($E(DT,1,5)_"01",-1),1,5)_"01")
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S FBDT1=Y
 ;
 ; ask to date
 S DIR(0)="DA^"_FBDT1_"::EX",DIR("A")="To Date: "
 ;   default to date is last day of specified month
 S X=FBDT1 D DAYS^FBAAUTL1
 S DIR("B")=$$FMTE^XLFDT($E(FBDT1,1,5)_X)
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S FBDT2=Y
 ;
 ; ask if all stations
 S DIR(0)="Y",DIR("A")="For all stations",DIR("B")="YES"
 D ^DIR K DIR G:$G(DIRUT) EXIT
 S FBSTALL=Y
 S FBSTN=""
 ; if not all stations ask station
 I 'FBSTALL D  G:FBSTN="" EXIT
 . S FBSTN=""
 . S DIC="^PRC(411,",DIC(0)="AQEM"
 . D ^DIC Q:Y<0
 . S FBSTN=$P(Y,U,2)
 ;
 ; ask if violations only
 S DIR(0)="Y",DIR("A")="Only list 1358s with a violation (Y/N)"
 S DIR("B")="YES"
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S FBORV=Y
 ;
 ; ask device
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 . S ZTRTN="QEN^FBAASDR",ZTDESC="Fee 1358 Segregation of Duty Report"
 . F FBX="FBDT*","FBORV","FBSTALL","FBSTN" S ZTSAVE(FBX)=""
 . D ^%ZTLOAD,HOME^%ZIS
 ;
QEN ; queued entry
 U IO
 ;
GATHER ; collect and sort data
 N %
 K ^TMP($J)
 ;
 S FBC("CER")=0 ; initialize count of certifications
 S FBC("OBL")=0 ; initialize count of obligations
 S FBC("VIO")=0 ; initialize count of obligations with a violation
 ;
 ; find fee certification events during specified period
 ; loop thru Fee Basis Batch by "ADS" x-ref (DATE SUPERVISOR CLOSED)
 S FBDT=FBDT1-.000001
 F  S FBDT=$O(^FBAA(161.7,"ADS",FBDT)) Q:FBDT=""!($P(FBDT,".")>FBDT2)  D
 . S FBDA=0
 . F  S FBDA=$O(^FBAA(161.7,"ADS",FBDT,FBDA)) Q:'FBDA  D
 . . N FBSTB
 . . S FBY0=$G(^FBAA(161.7,FBDA,0))
 . . ;
 . . ; skip batch that is only pricer released and not yet certified
 . . ;  if TYPE = "B9" and CONTRACT HOSPITAL BATCH = "Y" and
 . . ;     BATCH EXEMPT '= "Y" then STATUS must be R, T, or V to proceed
 . . I $P(FBY0,U,3)="B9",$P(FBY0,U,15)="Y",$P(FBY0,U,18)'="Y","^R^T^V^"'[(U_$P($G(^FBAA(161.7,FBDA,"ST")),U)_U) Q
 . . ;
 . . S FBOB=$P(FBY0,U,8)_"-"_$P(FBY0,U,2) ; full 1358 obligation number
 . . ;
 . . ; if report not for all stations, skip batch from different station
 . . I 'FBSTALL D  I FBSTB'=FBSTN Q
 . . . S FBSTB=$$SUB^FBAAUTL5(FBOB)
 . . . I FBSTB="" S FBSTB=+FBOB
 . . ;
 . . ; add event to ^TMP($J,1358 #,date/time,batch #)=certifier
 . . S ^TMP($J,FBOB,FBDT,$P(FBY0,U))=$P(FBY0,U,7)
 . . S FBC("CER")=FBC("CER")+1 ; incr count of certifications
 ;
 ; loop thru obligations and add IFCAP events and actors to ^TMP
 S FBOB="" F  S FBOB=$O(^TMP($J,FBOB)) Q:FBOB=""  D
 . S FBC("OBL")=FBC("OBL")+1 ; incr count of 1358s
 . N FBARR,FBX
 . S FBX=$$EV1358^PRCEMOA(FBOB,"FBARR")
 . I FBX'=1 S ^TMP($J,FBOB)=FBX Q  ; error reported by the API
 . S FBDT=""
 . F  S FBDT=$O(FBARR(FBDT)) Q:FBDT=""!($P(FBDT,".")>FBDT2)  D
 . . S FBEV="" F  S FBEV=$O(FBARR(FBDT,FBEV)) Q:FBEV=""  D
 . . . S ^TMP($J,FBOB,FBDT,FBEV)=FBARR(FBDT,FBEV)
 ;
 ; loop thru obligations and add segregation of duty violations to ^TMP
 S FBOB="" F  S FBOB=$O(^TMP($J,FBOB)) Q:FBOB=""  D
 . Q:$P($G(^TMP($J,FBOB)),U)="E"  ; skip because missing IFCAP events
 . ;
 . N FBAPP,FBOBL,FBREQ,FBVIO
 . S FBVIO=0 ; init violation flag for the 1358
 . ; loop thru date/time stamps
 . S FBDT="" F  S FBDT=$O(^TMP($J,FBOB,FBDT)) Q:FBDT=""  D
 . . ; loop thru events
 . . S FBEV="" F  S FBEV=$O(^TMP($J,FBOB,FBDT,FBEV)) Q:FBEV=""  D
 . . . N FBX
 . . . S FBX=$G(^TMP($J,FBOB,FBDT,FBEV))
 . . . ; process fee certification event
 . . . I FBEV D
 . . . . ; check fo violation
 . . . . I FBX,$D(FBREQ(FBX)) S FBVIO=1,^TMP($J,FBOB,FBDT,FBEV,"V1")="User previously acted as requestor on a prior 1358 event."
 . . . . I FBX,$D(FBAPP(FBX)) S FBVIO=1,^TMP($J,FBOB,FBDT,FBEV,"V2")="User previously acted as approver on a prior 1358 event."
 . . . . I FBX,$D(FBOBL(FBX)) S FBVIO=1,^TMP($J,FBOB,FBDT,FBEV,"V3")="User previously acted as obligator on a prior 1358 event."
 . . . ; process an IFCAP event
 . . . I "^O^A^"[(U_FBEV_U) D
 . . . . ; save IFCAP actors in lists
 . . . . I $P(FBX,U,1) S FBREQ($P(FBX,U,1))=""
 . . . . I $P(FBX,U,2) S FBAPP($P(FBX,U,2))=""
 . . . . I $P(FBX,U,3) S FBOBL($P(FBX,U,3))=""
 . . . . ; check for violation on IFCAP event
 . . . . I $P(FBX,U,2)=$P(FBX,U,1) S FBVIO=1,^TMP($J,FBOB,FBDT,FBEV,"V1")="Approver previously acted as requestor on this transaction."
 . . . . I $P(FBX,U,3)=$P(FBX,U,1) S FBVIO=1,^TMP($J,FBOB,FBDT,FBEV,"V2")="Obligator previously acted as requester on this transaction."
 . . . . I $P(FBX,U,3)=$P(FBX,U,2) S FBVIO=1,^TMP($J,FBOB,FBDT,FBEV,"V3")="Obligator previously acted as approver on this transaction."
 . ;
 . I FBVIO D  ; violation was found
 . . S ^TMP($J,FBOB)="V" ; flag 1358
 . . S FBC("VIO")=FBC("VIO")+1 ; incr count of 1358 with violation
 ;
PRINT ; report data
 S (FBQUIT,FBPG)=0 D NOW^%DTC S Y=% D DD^%DT S FBDTR=Y
 K FBDL
 S FBDL="",$P(FBDL,"-",80)=""
 S FBDL("CH")=$E(FBDL,1,10)_" "_$E(FBDL,1,14)_" "_$E(FBDL,1,11)_" "_$E(FBDL,1,9)_"  "_$E(FBDL,1,30)
 ;
 ; build page header text for selection criteria
 K FBHDT
 S FBHDT(1)="  Including Certifications from "
 S FBHDT(1)=FBHDT(1)_$$FMTE^XLFDT(FBDT1)_" to "_$$FMTE^XLFDT(FBDT2)
 S FBHDT(1)=FBHDT(1)_" for "
 S FBHDT(1)=FBHDT(1)_$S(FBSTALL:"all stations",1:"Station "_FBSTN)
 S:FBORV FBHDT(2)="  Only 1358s with a segregation of duty violation shown."
 ;
 D HD
 ;
 ; loop thru obligations
 S FBOB="" F  S FBOB=$O(^TMP($J,FBOB)) Q:FBOB=""  D  Q:FBQUIT
 . N FBERR,FBEVFP,FBOBX,FBVIO
 . S FBOBX=$G(^TMP($J,FBOB))
 . S FBERR=$S($P(FBOBX,U)="E":1,1:0) ; set true if error from IFCAP
 . S FBVIO=$S($P(FBOBX,U)="V":1,1:0) ; set true if violation was found
 . ;
 . ; if only reporting violations then skip 1358 when no error/violation
 . I FBORV,'FBERR,'FBVIO Q
 . ;
 . ; check for page break
 . I $Y+7>IOSL D HD Q:FBQUIT
 . ; 
 . W !,FBDL("CH")
 . W !,FBOB
 . ;
 . I FBERR D
 . . W !,"IFCAP events for this 1358 missing due to following error:"
 . . W !,$P(FBOBX,U,2),!
 . ;
 . S FBEVFP=1 ; init flag as true (Event - First Printed for 1358)
 . ; loop thru date/times
 . S FBDT="" F  S FBDT=$O(^TMP($J,FBOB,FBDT)) Q:FBDT=""  D  Q:FBQUIT
 . . ; loop thru events
 . . S FBEV=""
 . . F  S FBEV=$O(^TMP($J,FBOB,FBDT,FBEV)) Q:FBEV=""  D  Q:FBQUIT
 . . . N FBX,FBV
 . . . ; if only reporting violations, don't print certify event without
 . . . I FBORV,FBEV,$O(^TMP($J,FBOB,FBDT,FBEV,"V"))="" Q
 . . . I 'FBEVFP,$Y+5>IOSL D HD Q:FBQUIT  D HDEV
 . . . I 'FBEVFP W !
 . . . I FBEVFP S FBEVFP=0
 . . . S FBX=$G(^TMP($J,FBOB,FBDT,FBEV))
 . . . W ?11,$$FMTE^XLFDT(FBDT,"2MZ")
 . . . W ?26,$S(FBEV="O":"OBLIGATE",FBEV="A":"ADJUST",1:FBEV)
 . . . I FBEV W ?38,"CERTIFIER",?49,$$GET1^DIQ(200,FBX,.01)
 . . . I FBEV="O"!(FBEV="A") D
 . . . . W ?38,"REQUESTOR" W:$P(FBX,U) ?49,$$GET1^DIQ(200,$P(FBX,U),.01)
 . . . . W !,?38,"APPROVER" W:$P(FBX,U,2) ?49,$$GET1^DIQ(200,$P(FBX,U,2),.01)
 . . . . W !,?38,"OBLIGATOR" W:$P(FBX,U,3) ?49,$$GET1^DIQ(200,$P(FBX,U,3),.01)
 . . . ; list any violations found for this event (max is 3)
 . . . S FBV="" F  S FBV=$O(^TMP($J,FBOB,FBDT,FBEV,FBV)) Q:FBV=""  D
 . . . . N FBXV
 . . . . S FBXV=$G(^TMP($J,FBOB,FBDT,FBEV,FBV))
 . . . . I FBXV]"" W !,?8,"***",FBXV
 ;
 I FBQUIT W !!,"REPORT STOPPED AT USER REQUEST"
 E  D  ; report footer
 . I $Y+5>IOSL D HD Q:FBQUIT
 . W !,FBDL("CH")
 . W !!,"  ",FBC("CER")," batch certification",$S(FBC("CER")=1:" was",1:"s were")," found during the report period."
 . Q:FBC("OBL")=0
 . W !,"  ",FBC("OBL")," 1358 Obligation",$S(FBC("OBL")=1:" is",1:"s are")," referenced."
 . W !,"  A violation of segregation of duties was detected on ",$S(FBC("VIO")=0:"none",1:FBC("VIO"))," of the 1358s."
 I 'FBQUIT,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J)
 K FBC,FBDA,FBDL,FBDT,FBDT1,FBDT2,FBDTR,FBEV,FBHDT,FBOB,FBORV
 K FBPG,FBSTALL,FBSTN,FBQUIT,FBY0
 K DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
 ;
HD ; page header
 N FBI
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,FBQUIT=1 Q
 I $E(IOST,1,2)="C-",FBPG S DIR(0)="E" D ^DIR K DIR I 'Y S FBQUIT=1 Q
 I $E(IOST,1,2)="C-"!FBPG W @IOF
 S FBPG=FBPG+1
 W !,"Fee Basis 1358 Segregation of Duties",?49,FBDTR,?72,"page ",FBPG
 S FBI=0 F  S FBI=$O(FBHDT(FBI)) Q:'FBI  W !,FBHDT(FBI)
 W !!,"1358",?11,"DATE/TIME",?26,"EVENT/BATCH",?38,"ROLE",?49,"NAME"
 Q
 ;
HDEV ; page header for continued event
 W !,FBOB," (continued from previous page)"
 Q
 ;
 ;FBAASDR
