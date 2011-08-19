PXRMG2R2 ;SLC/JVS -GEC #2-REPORT PROMPTS ;2/13/05  20:05
 ;;2.0;CLINICAL REMINDERS;**2**;Feb 04, 2005
 Q
 ;
HOME ;#8 Start of Home Help Eligibility Programs Report
 ;^DISV(  = DBIA #510
 N POP,DIROUT,DIRUT,DUOUT,LOCNP,MENU,PROV,Y
 N REPORT
 ;
 S TPAT=1
HOMEYER D YER Q:$D(DIROUT)!($D(DIRUT))
HOMEQTR D QTR Q:$D(DIROUT)  I $D(DIRUT) K DIRUT G HOMEYER
HOMENAT ;D NAT Q:$D(DIROUT)!($D(DIRUT))  I $D(DIRUT) K DIRUT G HOMEQTR
HOMEPAT D PAT^PXRMGECP Q:$D(DIROUT)  I $D(DIRUT) K DIRUT G HOMEQTR
HOMTPAT I DFNONLY=0 D TPAT Q:$D(DIROUT)  I $D(DIRUT) K DIRUT G HOMEPAT
HOMEIOO D HOMEIO Q:$D(DIROUT)
 Q
HOMEIO ;=====Select IO device
 N ZTRTN,ZTDESC,ZTSAVE
 ;I REPORT="N" S DFNONLY=0 W !!,"Please wait..." D EN^PXRMG2E2,WRITE^PXRMG2E2
 ;I REPORT="N" Q
 N %ZIS
 S %ZIS="QM" D ^%ZIS
 I POP Q
 I $D(IO("Q")) D
 .S ZTRTN="PRINT^PXRMG2R2"
 .S ZTDESC="GEC HOME HELP ELIGIBILITY REPORT"
 .S ZTSAVE("*")=""
 .D ^%ZTLOAD
 ;=====Call Report
 E  W !,"Please wait ..." D EN^PXRMG2E2,EN^PXRMG2R1
 D HOME^%ZIS
 D ^%ZISC
 S:'$D(DIRUT)&('$D(DUOUT))&('$D(DIROUT)) DIR(0)="E" D ^DIR K DIR(0),Y
 Q
 ;=============================================================
PRINT ;Call for printed report
 D EN^PXRMG2E2,ENP^PXRMG2R1
 Q
NAT ;Select National
 W !
 S DIR("A",1)="Select Local or National Report"
 S DIR("A")="REPORT or ^ to exit"
 I $D(^DISV(DUZ,"PXRMGEC","REPORT")) S DIR("B")=$G(^DISV(DUZ,"PXRMGEC","REPORT"))
 S DIR(0)="S^L:LOCAL;N:NATIONAL"
 D ^DIR
 K DIR("A"),DIR("B"),DIR(0)
 Q:$D(DIROUT)!($D(DIRUT))
 S ^DISV(DUZ,"PXRMGEC","REPORT")=X
 S REPORT=Y
 Q
TPAT ;Select Test patients
 W !
 S DIR("A",1)="Select Show Test Patients in this Report?"
 S DIR("A")="Y or N or ^ to exit"
 I $D(^DISV(DUZ,"PXRMGEC","TPAT")) S DIR("B")=$G(^DISV(DUZ,"PXRMGEC","TPAT"))
 S DIR(0)="S^Y:YES;N:NO"
 D ^DIR
 K DIR("A"),DIR("B"),DIR(0)
 Q:$D(DIROUT)!($D(DIRUT))
 S ^DISV(DUZ,"PXRMGEC","TPAT")=X
 I Y="Y" S Y=1
 I Y="N" S Y=0
 S TPAT=Y
 Q
 ;
YER ;Select Year
 W !
 S DIR("A",1)="Select a year for the report (i.e.2005)"
 S DIR("A")="YEAR or ^ to exit"
 I $D(^DISV(DUZ,"PXRMGEC","YEAR")) S DIR("B")=$G(^DISV(DUZ,"PXRMGEC","YEAR"))
 S DIR(0)="N^2004:2030:0"
 D ^DIR
 K DIR("A"),DIR("B"),DIR(0)
 Q:$D(DIROUT)!($D(DIRUT))
 S ^DISV(DUZ,"PXRMGEC","YEAR")=X
 S YEAR=Y
 Q
 ;
QTR ;Select Quarter
 N Z
 W !
 S DIR("A",1)="Select a Fiscal QUARTER in the year "_YEAR_" (i.e.2)"
 S DIR("A",2)="     Fiscal Years start in October."
 S DIR("A",3)="Fiscal Quarter 1 same as Calendar Quarter 4"
 S DIR("A",4)="Fiscal Quarter 2 same as Calendar Quarter 1"
 S DIR("A",5)="Fiscal Quarter 3 same as Calendar Quarter 2"
 S DIR("A",6)="Fiscal Quarter 4 same as Calendar Quarter 3"
 S DIR("A",7)=""
 S DIR("A")="Fiscal Quarter or ^ to exit"
 I $D(^DISV(DUZ,"PXRMGEC","QUARTER")) S DIR("B")=$G(^DISV(DUZ,"PXRMGEC","QUARTER"))
 S DIR(0)="N^1:4:0"
 D ^DIR
 K DIR("A"),DIR("B"),DIR(0)
 Q:$D(DIROUT)!($D(DIRUT))
 S ^DISV(DUZ,"PXRMGEC","QUARTER")=X
 I Y=1 S Z=4
 I Y=2 S Z=1
 I Y=3 S Z=2
 I Y=4 S Z=3
 S FQUARTER=Y
 S QUARTER=Z
 Q
