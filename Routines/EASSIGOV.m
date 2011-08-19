EASSIGOV ; ALB/RTK - Means Test Signature summary report ; 1/29/02 11:33am ; 07/22/02 9:40am
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**4,8,13,28**;Mar 15, 2001
 ;
 N YRSEL,SIGYES,SIGNO,SIGDEL,SIGNUL,CHKDT,MTIEN,MTSIG,NOW,SITE,CATA,CATC,PENDA,GMT
 S NOW=$P($$NOW^XLFDT,"."),SITE=$P($$SITE^VASITE,"^",3)
 S (SIGYES,SIGNO,SIGDEL,SIGNUL)=0
 N DIR S DIR("A")="Please select income year",DIR(0)="SM^A:PREVIOUS INCOME YEAR;B:CURRENT INCOME YEAR;C:NEXT INCOME YEAR",DIR("B")="B"
 D ^DIR S YRSEL=Y G END:$D(DTOUT)!($D(DUOUT))
 D DEVSEL
END Q
EN W:$E(IOST,1)="C" @IOF
 S (CATA,CATC,PENDA,GMT)=""
 S CATA=$O(^DG(408.32,"B","MT COPAY EXEMPT",CATA))
 S CATC=$O(^DG(408.32,"B","MT COPAY REQUIRED",CATC))
 S PENDA=$O(^DG(408.32,"B","PENDING ADJUDICATION",PENDA))
 S GMT=$O(^DG(408.32,"B","GMT COPAY REQUIRED",GMT))
 ;Set start date:
 S CHKDT=$S(YRSEL="A":($E(NOW,1,3)-1)_"0100",YRSEL="B":$E(NOW,1,3)_"1232",YRSEL="C":($E(NOW,1,3)+1)_"1232",1:""),DISPDT=CHKDT
 I YRSEL="A" D PASTYR
 I YRSEL'="A" D OTHERYR
 Q
PASTYR F  S CHKDT=$O(^DGMT(408.31,"B",CHKDT)) Q:$E(CHKDT,1,3)=($E(DISPDT,1,3)+1)  D
 .S MTIEN="" F  S MTIEN=$O(^DGMT(408.31,"B",CHKDT,MTIEN)) Q:+MTIEN=0  D
 ..;Is test primary?
 ..I $G(^DGMT(408.31,MTIEN,"PRIM"))'=1 Q
 ..;Is test from this site?
 ..I +$P($G(^DGMT(408.31,MTIEN,2)),"^",5)'=SITE Q
 ..;If not a Means Test, ignore
 ..I $P($G(^DGMT(408.31,MTIEN,0)),"^",19)'=1 Q
 ..;Check category
 ..S CAT=$P(^DGMT(408.31,MTIEN,0),"^",3) I CAT'=CATA,CAT'=CATC,CAT'=PENDA,CAT'=GMT Q
 ..S MTSIG=$P(^DGMT(408.31,MTIEN,0),"^",29)
 ..;Set counters
 ..I MTSIG=1 S SIGYES=SIGYES+1 Q
 ..I MTSIG=0 S SIGNO=SIGNO+1 Q
 ..I MTSIG=9 S SIGDEL=SIGDEL+1 Q
 ..I MTSIG="" S SIGNUL=SIGNUL+1
 D PRINT
 Q
OTHERYR F  S CHKDT=$O(^DGMT(408.31,"B",CHKDT),-1) Q:$E(CHKDT,1,3)=($E(DISPDT,1,3)-1)  D
 .S MTIEN="" F  S MTIEN=$O(^DGMT(408.31,"B",CHKDT,MTIEN)) Q:+MTIEN=0  D
 ..;Is test primary?
 ..I $G(^DGMT(408.31,MTIEN,"PRIM"))'=1 Q
 ..;Is test from this site?
 ..I +$P($G(^DGMT(408.31,MTIEN,2)),"^",5)'=SITE Q
 ..;If not a Means Test, ignore
 ..I $P($G(^DGMT(408.31,MTIEN,0)),"^",19)'=1 Q
 ..;Check category
 ..S CAT=$P(^DGMT(408.31,MTIEN,0),"^",3) I CAT'=CATA,CAT'=CATC,CAT'=PENDA,CAT'=GMT Q
 ..S MTSIG=$P(^DGMT(408.31,MTIEN,0),"^",29)
 ..;Set counters
 ..I MTSIG=1 S SIGYES=SIGYES+1 Q
 ..I MTSIG=0 S SIGNO=SIGNO+1 Q
 ..I MTSIG=9 S SIGDEL=SIGDEL+1 Q
 ..I MTSIG="" S SIGNUL=SIGNUL+1
 D PRINT
 Q
PRINT ;
 U IO
 W !,?2,"The purpose of this report is to help sites monitor the Means Test images"
 W !?2,"returned to them by the HEC.  The report only shows signature indicators"
 W !?2,"for MTs that were submitted by the local site (which may or may not be"
 W !?2,"designated as the primary site).  It does NOT take into account that the"
 W !?2,"HEC may already have a signature on file for the vet as sent from a"
 W !?2,"different, primary site."
 W !!,?2,"Means Test Signature Data for Income Year ",$E(DISPDT,1,3)+1699,":",!
 W !,?2,"Local Site Means Test with Signature Indicator = YES",?60,SIGYES
 W !,?2,"Local Site Means Test with Signature Indicator = NO",?60,SIGNO
 W !,?2,"Local Site Means Test with Signature Indicator = DELETED",?60,SIGDEL
 W !,?2,"Local Site Means Test with Signature Indicator = NULL",?60,SIGNUL
 W ! F I=1:1:80 W "_"
 W !,?50,"Total",?60,(SIGYES+SIGNO+SIGDEL+SIGNUL)
 D ^%ZISC
 Q
DEVSEL ;Select IO Device
 K DIRUT
 S %ZIS="Q" D ^%ZIS
 I POP W !!?5,"Report cancelled!" D ^%ZISC Q
 I $D(IO("Q")) D QUEUE Q
 D EN
 Q
QUEUE ;
 S ZTRTN="EN^EASSIGOV",ZTDESC="MT Signature Summary Rpt"
 S (ZTSAVE("YRSEL"),ZTSAVE("NOW"),ZTSAVE("SIGNO"),ZTSAVE("SIGNUL"),ZTSAVE("SIGYES"),ZTSAVE("SIGDEL"),ZTSAVE("SITE"))=""
 D ^%ZTLOAD
 I $D(ZTSK)[0 W !!?5,"Report cancelled!"
 E  W !!?5,"Report queued!"
 D HOME^%ZIS Q
