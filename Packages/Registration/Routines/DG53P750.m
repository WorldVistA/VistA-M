DG53P750 ;BAY/JT - Patient full name > 30 characters ; 9/16/03 4:56pm
 ;;5.3;Registration;**750**;Aug 13, 1993;Build 6
 ; update patient name .01 in file #2
 ;
ENV ; do environment check
 S XPDABORT=""
 D PROGCHK(.XPDABORT)
 I XPDABORT="" K XPDABORT
 Q
PROGCHK(XPDABORT) ; checks for necessary programmer variables
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .S XPDABORT=2
 Q
 ;
SEARCH N DGIEN,DGTOT,DGFULLNM,DGLINK,DGZERO,DGONE,DGOTHERS,X1,X2
 N DG20NAME,XUNOTRIG,FDANAME,FDAIEN,DIERR
 K ^XTMP("DG53P750")
 S X1=DT,X2=90 D C^%DTC
 S ^XTMP("DG53P750",0)=X_"^"_DT_"^Patient full name > 30 characters"
 S (DGIEN,DGTOT,DGOTHERS)=0
 D BMES^XPDUTL("...Reading thru entire Patient File...")
 F  S DGIEN=$O(^DPT(DGIEN)) Q:'DGIEN  D
 .S DGTOT=DGTOT+1
 .S DGFULLNM=$P($G(^DPT(DGIEN,0)),U)
 .; skip merge records
 .Q:DGFULLNM["MERGING INTO"
 .Q:$D(^DPT(DGIEN,-9))
 .Q:DGFULLNM=""
 .Q:$L(DGFULLNM)<31
 .; skip if word "error" in family name
 .Q:$P(DGFULLNM,",",1)["ERROR"
 .S DGLINK=+$P($G(^DPT(DGIEN,"NAME")),U)
 .I 'DGLINK Q
 .S DGZERO=$G(^VA(20,DGLINK,0))
 .I DGZERO="" Q
 .; make sure the patient name component record points back to the patient file record
 .I $P(DGZERO,U)'=2!($P(DGZERO,U,2)'=".01")!(+$P(DGZERO,U,3)'=DGIEN) Q
 .S DGONE=$G(^VA(20,DGLINK,1))
 .I DGONE="" Q
 .; get the name components
 .S DG20NAME=$P(DGONE,U)_","
 .I $P(DGONE,U,2)'="" S DG20NAME=DG20NAME_$P(DGONE,U,2)
 .I $P(DGONE,U,3)'="" S DG20NAME=DG20NAME_" "_$P(DGONE,U,3)
 .I $P(DGONE,U,5)'="" S DG20NAME=DG20NAME_" "_$P(DGONE,U,5)
 .; reformat it so it's no more than 30 characters
 .S DG20NAME=$$NAMEFMT^XLFNAME(.DG20NAME,"F","CFL30")
 .S FDAIEN=DGIEN_","
 .S FDANAME(2,FDAIEN,.01)=DG20NAME
 .; set flag so patient name component record will not be updated
 .S XUNOTRIG=1
 .; update the .01 field
 .D FILE^DIE("","FDANAME","DIERR")
 .; store global entry so report can be prepared from it
 .S ^XTMP("DG53P750",DGIEN,DGLINK)=DGFULLNM_"///"_DG20NAME
 .S DGOTHERS=DGOTHERS+1
 ;
 D MES^XPDUTL("Total # of Patient File records read: "_DGTOT)
 D MES^XPDUTL("Total # of corrected patients: "_DGOTHERS)
 Q
 ;
PRTRPT ;
 I $$DEVICE() D PRINT
 Q
DEVICE() ; choose device and whether to queue.
 N OK,IOP,POP,%ZIS,DGX
 S OK=1
 S %ZIS="MQ"
 D ^%ZIS
 S:POP OK=0
 I OK,$D(IO("Q")) D
 .N ZTRTN,ZTDESC,ZTSKM,ZTREQ,ZTSTOP
 .S ZTRTN="PRINT^DG53P750"
 .S ZTDESC="Print of XTMP global for DG53P750."
 .F DGX=1:1:20 D ^%ZTLOAD Q:$G(ZTSK)
 .W !,$S($D(ZTSK):"Request "_ZTSK_" queued!",1:"Request Cancelled!"),!
 .D HOME^%ZIS
 .S OK=0
 Q OK
 ;
PRINT ;
 U IO
 N DGIEN,DGLINK,DGERR,DGQUIT,DGPG,DGDDT
 S (DGQUIT,DGPG)=0
 S DGDDT=$$FMTE^XLFDT($$NOW^XLFDT,"D")
 D HEAD
 S DGIEN=0,DGIEN=$O(^XTMP("DG53P750",DGIEN))
 I DGIEN="" D  Q
 .W !!!,?20,"*** No records to report ***"
 ;
 S DGIEN=0
 F  S DGIEN=$O(^XTMP("DG53P750",DGIEN)) Q:'DGIEN  D  Q:DGQUIT
 .S DGLINK=0
 .F  S DGLINK=$O(^XTMP("DG53P750",DGIEN,DGLINK)) Q:'DGLINK  D
 ..I $Y>(IOSL-4) D HEAD
 ..W DGIEN,?11,DGLINK,?25,^XTMP("DG53P750",DGIEN,DGLINK),!
 ;
 I DGQUIT W:$D(ZTQUEUED) !!,"Report stopped at user's request" Q
 I $G(DGPG)>0,$E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 DGQUIT=1
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
HEAD ;
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQUIT)=1 Q
 I $G(DGPG)>0,$E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 DGQUIT=1
 Q:DGQUIT
 S DGPG=$G(DGPG)+1
 W @IOF,!,DGDDT,?15,"DG*5.3*750 List of patients with long names",?70,"Page:",$J(DGPG,5),! K X S $P(X,"-",132)="" W X,!
 W !,"File 2 IEN",?11,"File 20 IEN",?25,"Patient Name Before///Patient Name After",!
 S $P(X,"-",132)="" W X,!
 Q
