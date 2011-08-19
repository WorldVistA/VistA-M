IBAHVE3 ;WOIFO/SS - CV EXPIRATION REPORT ;06/16/04
 ;;2.0;INTEGRATED BILLING;**275**;21-MAR-94
 ;
START ;start report
 N Y
 S Y=+$$CHNGDATE(DT,-90)\1 X ^DD("DD")
 S DIR(0)="DA^:NOW:EX",DIR("B")=Y,DIR("A")="From DATE: " D ^DIR K DIR I $D(DIRUT) D EXIT Q
 S IBBEGDT=+Y
 S DIR(0)="DA^"_+Y_":NOW:EX"
 S Y=+DT\1 X ^DD("DD")
 S DIR("B")=Y,DIR("A")="To DATE: " D ^DIR K DIR I $D(DIRUT) D EXIT Q
 S IBENDDT=+Y
 D PRNINFO(IBBEGDT,IBENDDT)
 D OPEN I POP D EXIT Q
 I $D(IO("Q")) D QUEUED,HOME^%ZIS D END Q
 U IO
 D REPORT
 Q
 ;
REPORT ;
 D PREPRPT
 D PRINTRPT
 D END
 D EXIT
 Q
 ;
END ;
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 D EXIT
 Q
 ;
EXIT ; kills all vars
 K IBOUT,IBPAGE,POP,IBBEGDT,IBENDDT
 K IBX,IBXX,Y,DFN,IBCOL2,IBCOL3,IBCOL4,IBCOLPG,IBDONE,^TMP($J,"IBACVEXP"),DIRUT
 K ZTDESC,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK,%ZIS,IO("Q")
 D KVAR^VADPT
 Q
 ;
OPEN ;
 S %ZIS="QM" D ^%ZIS
 Q
 ;
QUEUED ;
 S ZTRTN="REPORT^IBAHVE3",ZTDESC="Current Continuous Pt Report",ZTSAVE("IBENDDT")="",ZTSAVE("IBBEGDT")=""
 D ^%ZTLOAD W !!,$S($D(ZTSK):"Request Queued!",1:"Request Cancelled")
 Q
 ;
PREPRPT ;prepare data 
 ; IBBEGDT - begin date ,IBENDDT - end date
 S IBCOL2=23,IBCOL3=37,IBCOL4=57,IBCOLPG=70,IBDONE=0
 N IBDFN,IBDT,IBDFN,IBADMDAT,IB405,IBDISCH,IBCVSTAT,IBEXPDT
 ;scan all admission before ENDDATE
 S IBDT=0 F  S IBDT=$O(^DGPM("AMV1",IBDT)) Q:+IBDT=0  Q:IBDT>IBENDDT  D
 . S IBDFN=0 F  S IBDFN=$O(^DGPM("AMV1",IBDT,IBDFN)) Q:+IBDFN=0  D
 . . S IB405=0 F  S IB405=$O(^DGPM("AMV1",IBDT,IBDFN,IB405)) Q:+IB405=0  D
 . . . S IBADMDAT=$G(^DGPM(IB405,0)) D:IBADMDAT>0
 . . . . S IBDISCH=+$G(^DGPM(+$P(IBADMDAT,U,17),0))
 . . . . ;don't include if discharge before IBBEGDT
 . . . . I IBDISCH,IBDISCH<IBBEGDT Q
 . . . . S IBCVSTAT=$$CVEDT^IBACV(IBDFN)
 . . . . I '$P(IBCVSTAT,U,3) Q  ;check if ever had CV
 . . . . S IBEXPDT=+$P(IBCVSTAT,U,2)
 . . . . I IBEXPDT=0 Q
 . . . . I IBEXPDT<IBBEGDT Q  ;if expired before IBBEGDT
 . . . . I IBEXPDT>IBENDDT Q  ;if expired after IBENDDT
 . . . . I IBDISCH,IBEXPDT>IBDISCH Q  ;if expired after discharge
 . . . . I IBEXPDT<IBADMDAT Q  ;if expired before admission
 . . . . D SETTMP(IBDFN,+IBADMDAT,+$P(IBADMDAT,U,6),IBEXPDT)
 Q
 ;
SETTMP(IBDFN,IBADMDT,IBWARD,IBCVDT) ;additional check and set ^TMP
 ;IBDFN -Pat ID,IBADMDT-admission date
 ;IBWARD-ward location
 I '$D(^DPT(IBDFN,0)) Q
 D
 . N VADM,VA,VAERR,Y
 . N DFN,IBPAT,IBSSN,IBADMIS,IBCVEXP
 . S DFN=+IBDFN
 . D DEM^VADPT
 . S IBPAT=$G(VADM(1))
 . S IBSSN=$P($G(VADM(2)),"^",2)
 . S Y=IBADMDT\1 X ^DD("DD") S IBADMIS=Y ;date in readable form
 . S Y=IBCVDT\1 X ^DD("DD") S IBCVEXP=Y ;date in readable form
 . S ^TMP($J,"IBACVEXP",IBDFN,IBADMDT)=IBPAT_"^"_IBSSN_"^"_IBCVEXP_"^"_IBADMIS
 Q
 ;
PRINTRPT ;print the report
 S Y=DT X ^DD("DD")
 S IBPAGE=1,IBOUT=""
 D HEADER
 N IBADM,IBDFN,IBTOTAL
 S IBTOTAL=0
 S IBDFN=0 F  S IBDFN=$O(^TMP($J,"IBACVEXP",IBDFN)) Q:+IBDFN=0!(IBDONE)  D
 . S IBADM=0 F  S IBADM=$O(^TMP($J,"IBACVEXP",IBDFN,IBADM)) Q:+IBADM=0!(IBDONE)  D
 . . D PRNTLINE($G(^TMP($J,"IBACVEXP",IBDFN,IBADM))) S IBTOTAL=IBTOTAL+1
 I 'IBDONE D PRNTLINE("Total: "_IBTOTAL_" patient(s)")
 Q
 ;
HEADER ;print the header
 I IBPAGE>1,($E(IOST,1,2)="C-") S DIR(0)="E" D ^DIR K DIR I $D(DUOUT) S IBDONE=1 K DUOUT Q
 I $E(IOST,1,2)["C-"!(IBPAGE>1) W @IOF
 W !,?8,"***Inpatient Combat Veteran Status Expiration Report***",?IBCOLPG,"PAGE ",IBPAGE
 W !,?14,"Report from " S Y=IBBEGDT\1 X ^DD("DD") W Y
 W " to " S Y=IBENDDT\1 X ^DD("DD") W Y
 W !,?15,"Run Date/Time: " D NOW^%DTC S Y=% X ^DD("DD") W Y
 W !!,"Patient NAME",?IBCOL2,"SSN",?IBCOL3,"CV exp. date",?IBCOL4,"Date of admission"
 W !!
 S IBX="",$P(IBX,"=",IOM)="" W IBX,!
 S IBPAGE=IBPAGE+1
 Q
 ;
PRNTLINE(IBRECORD) ;print line of the report
 ;Patient NAME
 W $E($P(IBRECORD,"^",1),1,21)
 ;SSN
 W ?IBCOL2,$E($P(IBRECORD,"^",2),1,11)
 ;CV exp. date
 W ?IBCOL3,$E($P(IBRECORD,"^",3),1,14)
 ;Date of admission
 W ?IBCOL4,$E($P(IBRECORD,"^",4),1,14)
 W !
 D:$Y+4>IOSL HEADER
 Q
 ;
CHNGDATE(DATE,CHNG) ;
 N X,X1,X2
 S X1=DATE,X2=CHNG D C^%DTC
 Q X
 ;
 ;
PRNINFO(IBBEG,IBEND) ;
 N Y
 W !,"The following patients whose records indicate that they had CV status, were"
 W !,"admitted for inpatient care with CV status, and their CV status has expired"
 W !,"during their stays in the period of "
 S Y=IBBEG X ^DD("DD")
 W Y," - "
 S Y=IBEND X ^DD("DD")
 W Y
 Q
 ;
