DG311RPT ;ALB/JJG-Patch DG*5.3*311 Means Test Update Report ; 07 AUG 2000
 ;;5.3;Registration;**311**;Aug 13, 1993
 ;
 ; This routine will produce a report that displays those Veterans who
 ; had their records in the ANNUAL MEANS TEST file (#408.31) corrected
 ; by routine DG311PIR. The report will display the following fields:
 ;    Veteran Name, Veteran SSN, Income Year, Old Status, New Status
 ; This report is intended to be run immediately after patch DG*5.3*311
 ; is installed at the site.
 ;
MAIN ; Main Driver
 ;
 D SEL   ; Select output device
 Q
SEL ;
 ; Select IO Device
 K DIRUT
 S %ZIS="Q" D ^%ZIS
 I POP W !!?5,"Report cancelled!" Q
 I $D(IO("Q")) D QUEUE Q
 D START,^%ZISC Q
QUEUE ;
 S ZTRTN="START^DG311RPT",ZTDESC="Means Test Update Report"
 D ^%ZTLOAD
 I $D(ZTSK)[0 W !!?5,"Report cancelled!" H 2
 E  W !!?5,"Report queued!" H 2
 D HOME^%ZIS Q
START ;
 ; Produce Report
 N DGVET,DGSSN,DGYR,DGOST,DGNST
 S (DGVET,DGSSN,DGYR,DGOST,DGNST)=""
 D HEADER
 F  S DGVET=$O(^XTMP("DG311PIR",DGVET)) Q:DGVET']""  D
 .F  S DGSSN=$O(^XTMP("DG311PIR",DGVET,DGSSN)) Q:DGSSN']""  D
 ..F  S DGYR=$O(^XTMP("DG311PIR",DGVET,DGSSN,DGYR)) Q:DGYR']""  D
 ...F  S DGOST=$O(^XTMP("DG311PIR",DGVET,DGSSN,DGYR,DGOST)) Q:DGOST']""  D
 ....Q:(DGOST'=4)&(DGOST'=6)&(DGOST'=7)&(DGOST'=8)  ; Only want Cat 'A', Cat 'C', Exempt or Non-exempt
 ....S DGOLDSTA=$$EXTERNAL^DILFD(408.31,.03,,DGOST)
 ....F  S DGNST=$O(^XTMP("DG311PIR",DGVET,DGSSN,DGYR,DGOST,DGNST)) Q:DGNST']""  D
 .....S DGNEWSTA=$$EXTERNAL^DILFD(408.31,.03,,DGNST)
 .....Q:(DGOST=DGNST)  ; Only print those instances where the Status changed
 .....I IOM=80 W !!,$E(DGVET,1,25),?28,DGSSN,?42,DGYR,?48,$E(DGOLDSTA,1,15),?65,$E(DGNEWSTA,1,15)
 .....E  W !!,DGVET,?36,DGSSN,?53,DGYR,?62,DGOLDSTA,?87,DGNEWSTA
 D FOOTER
 Q
HEADER ; Report Header
 N X,Y,NOW
 D NOW^%DTC S Y=X X ^DD("DD") S NOW=Y
 U IO W @IOF,!!!,?(IOM-26/2),"Updated Means Test Listing"
 W !!,"Run Date: ",NOW
 I IOM=80 D
 . W !!,"Veteran Name",?28,"Veteran SSN",?42,"Year",?48,"Old Status",?65,"New Status"
 . W !,"============",?28,"===========",?42,"====",?48,"==========",?65,"=========="
 E  D
 . W !!,"Veteran Name",?36,"Veteran SSN",?49,"Income Year",?62,"Old Means Test Status",?87,"New Means Test Status"
 . W !,"============",?36,"===========",?49,"===========",?62,"=====================",?87,"====================="
 Q
FOOTER ; Report Footer
 U IO W !!!,?(IOM-19/2),"***End Of Report***"
 Q
