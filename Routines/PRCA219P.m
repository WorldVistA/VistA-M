PRCA219P ;ALB/RRG - REPORT LIKELY BILLS TO PRINT;;
 ;;4.5;Accounts Receivable;**219**;Mar 20, 1995;Build 18
 Q
 ;
REPORT ;
 ;
 W !,"This is a report of older bills that will likely print at the next print cycle"
 N X1,X2
 K ^XTMP("PRCA219P",$J)
 S X1=DT,X2=90 D C^%DTC
 S ^XTMP("PRCA219P",$J,0)=X_"^"_DT_"^LIKELY BILLS TO PRINT"
 I $$DEVICE() D ENTER
 Q
 ;
ENTER ;
 ;
 D BILLFIND
 D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^XTMP("PRCA219P",$J)
 Q
DEVICE() ;
 ;Description: allows the user to select a device.
 ;
 ;Output:
 ;  Function Value - Returns 0 if the user decides not to print or to
 ;       queue the report, 1 otherwise.
 ;
 N OK,IOP,POP,%ZIS
 S OK=1
 S %ZIS="MQ"
 D ^%ZIS
 S:POP OK=0
 D:OK&$D(IO("Q"))
 .N ZTRTN,ZTDESC,ZTSKM,ZTREQ,ZTSTOP
 .S ZTRTN="BILLFIND^PRCA219P",ZTDESC="Likely Bills to Print"
 .D ^%ZTLOAD
 .W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 .D HOME^%ZIS
 .S OK=0
 Q OK
 ;
BILLFIND ;
 ; Find older bills that will most likely print next cycle after *219 installed
 ; Categories are: Adult Day Health Care, C(Means Test), Geriatric Eval-Institutional, Geriatric Eval-Non-Institutional,
 ;      Respite Care-Institutional, Respite Care-Non-Institional, RX Co-Payment/SC Vet, RX Co-Payment/NSC Vet, Hospital Care (NSC),
 ;      Hospital Care Per Diem, Nursing Home Care Per Diem, Nursing Home Care (NSC), Nursing Home Care-LTC, Outpatient Care (NSC),
 ;      Current Employee, Emergency/Humanitarian, Ineligible Hospital, Ex-Employee, Vendor, ChampVA Subsistence, Tricare Patient
 ; 
 N BILLDFN,CAT,LETTER2,LETTER3,CURBAL,PNAME,Z,X,Y,I,COUNT
 S COUNT=0,BILLDFN=0
 F  S BILLDFN=$O(^PRCA(430,"AC",16,BILLDFN)) Q:'BILLDFN  D
 . S Z=$S($D(^PRCA(430,BILLDFN,7)):^(7),1:"") S Y=$P(Z,"^",1)+$P(Z,"^",2)+$P(Z,"^",3)+$P(Z,"^",4)+$P(Z,"^",5)
 . S CURBAL=$J(Y,0,2) Q:CURBAL'>0
 . S LETTER2=$P($G(^PRCA(430,BILLDFN,6)),"^",2) Q:LETTER2=""
 . S %H=+$H-30  D YMD^%DTC Q:LETTER2>X
 . S LETTER3=$P($G(^PRCA(430,BILLDFN,6)),"^",3) Q:LETTER3'=""
 . S CAT=$P(^PRCA(430,BILLDFN,0),"^",2),CAT=","_CAT_","
 . S I=",33,18,37,38,35,36,23,22,5,25,24,3,39,4,"
 . I I'[CAT Q
 . S CAT=$TR(CAT,",","")
 . S ^XTMP("PRCA219P",$J,CAT,BILLDFN)=$P(^PRCA(430,BILLDFN,0),U,1)
 . S COUNT=COUNT+1
 ;
 ;
PRINT ;
 U IO
 N PRCADDT,PRCAQUIT,PRCAPG,BILLNO
 S PRCADDT=$$FMTE^XLFDT($$NOW^XLFDT,"D")
 S (PRCAQUIT,PRCAPG)=0
 D HEAD
 I '$G(COUNT) D  Q
 .W !!!,?20,"*** No bills to report ***"
 W !!,"*** COUNT OF LIKELY BILLS TO PRINT    "_COUNT," ***",!!
 S CAT=0
 F  S CAT=$O(^XTMP("PRCA219P",$J,CAT)) Q:'CAT!PRCAQUIT  S BILLDFN=0 D
 . F  S BILLDFN=$O(^XTMP("PRCA219P",$J,CAT,BILLDFN)) Q:'BILLDFN  D  Q:PRCAQUIT
 . . I $Y>(IOSL-4) D HEAD
 . . S BILLNO=$P($G(^XTMP("PRCA219P",$J,CAT,BILLDFN)),U)
 . . W !,?2,$P(^PRCA(430.2,CAT,0),U,1),?25,BILLNO
 ;
 I PRCAQUIT W:$D(ZTQUEUED) !!,"Report stopped at user's request" Q
 I $G(PRCAPG)>0,$E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 PRCAQUIT=1
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
HEAD ;
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,PRCAQUIT)=1 Q
 I $G(PRCAPG)>0,$E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 PRCAQUIT=1
 Q:PRCAQUIT
 S PRCAPG=$G(PRCAPG)+1
 W @IOF,!,PRCADDT,?15,"PRCA*4.5*219 Older Bills Most Likely to Print",?70,"Page:",$J(PRCAPG,5),! K X S $P(X,"-",81)="" W X,!
 W !
 W !,?2,"Category",?25,"Bill Number",!
 S $P(X,"-",81)="" W X,!
 Q
