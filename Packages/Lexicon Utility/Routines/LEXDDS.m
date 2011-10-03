LEXDDS ; ISL Display Defaults - Single User       ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; Entry:  D EN^LEXDDS              LEXAP is unknown
 ;
 ; Entry:  D EN1^LEXDDS(LEXAP)     LEXAP is known
 ;
 ; Print/Display User Defaults - Single User
 ;
 ; Where 
 ;
 ;      LEXAP     Pointer to file 757.2
 ;
 ;
EN ; Display Single User Defaults, LEXAP is unknown
 N LEXAP,X,Y S LEXAP=$$DFI^LEXDM4 Q:+LEXAP=0  W ! D EN1(LEXAP) Q
EN1(LEXAP) ; Display Single User Defaults, LEXAP is unknown
 W ! D DEV,HOME^%ZIS
 K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE Q
DEV ; Select a device
 N %,%ZIS,IOP,ZTRTN,ZTSAVE,ZTDESC,ZTDTH,ZTIO,ZTSK
 S ZTRTN="DISP^LEXDDSP",(ZTSAVE("LEXAP"),ZTSAVE("DUZ"))=""
 S ZTDESC="LEXICON DEFAULTS FOR "_$P(^VA(200,DUZ,0),"^",1)
 S ZTIO=ION,ZTDTH=$H,%ZIS="PQ" D ^%ZIS Q:POP  S ZTIO=ION
 I $D(IO("Q")) D QUE,^%ZISC Q
 D NOQUE Q
NOQUE ; Do not que task
 W @IOF W:IOST["P-"&('$D(IO("S"))) !,"< Not queued, printing user defaults >",!
 H 2 U:IOST["P-" IO D @ZTRTN,^%ZISC Q
QUE ; Task queued to print user defaults
 K IO("Q") D ^%ZTLOAD
 W !,$S($D(ZTSK):"Request Queued",1:"Request Cancelled"),! H 2 Q
