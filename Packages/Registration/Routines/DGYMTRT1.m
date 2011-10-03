DGYMTRT1 ;ALB/CAW/LD - Print changed specialty report ; 9/8/94
 ;;5.3;Registration;**39**;Aug 13, 1993
 ;
 ; This routine will print the changed treating specialty report after
 ; completing the Specialty file (#42.4) and Facility Treating Specialty
 ; file (#45.7) update in routine DGYMTRT.
 ;
EN ; Print changed treating specialty report
 D FTSP
 W !!?2,"The following report will list all existing entries in the FACILITY TREATING",!?2,"SPECIALTY file (#45.7) that point to entries in the SPECIALTY file (#42.4)",!?2,"which have been changed."
 S %ZIS="PMQ" D ^%ZIS K %ZIS G:POP ENQ
 I '$D(IO("Q")) D PRINT,^%ZISC G ENQ
 S Y=$$QUE
ENQ K DGTSP,POP,Y,ZTDESC,ZTRTN,ZTSAVE
 Q
FTSP ; Facility Treating Specialty
 N DGY
 S DGY=0
 F  S DGY=$O(^DIC(45.7,DGY)) Q:'DGY  I "^33^72^73^74^"[(U_$P(^(DGY,0),U,2)_U) S DGTSP(DGY)=""
 Q
QUE() ; -- queue job
 ; return: did job queue [ 1|yes   0|no ]
 ;
 K ZTSK,IO("Q")
 S ZTDESC="Treating Specialty Report",ZTRTN="PRINT^DGYMTRT1"
 S ZTSAVE("DGTSP(")=""
 D ^%ZTLOAD W:$D(ZTSK) "   (Task: ",ZTSK,")"
 Q $D(ZTSK)
PRINT ;Print any facility treating specialties that point to changed
 ;specialties.
 ;
 U IO
 S $P(DGDASH,"=",80)=""
 W @IOF,!?24,"CHANGED TREATING SPECIALTY REPORT"
 W !!,"FACILITY TREATING SPECIALTY (#45.7)",?45,"CHANGED SPECIALTY (#42.4)"
 W !,DGDASH
 N DGY,DGX S DGY=""
 F  S DGY=$O(DGTSP(DGY)) Q:'DGY  S DGX=$G(^DIC(45.7,DGY,0)) D
 .W !,$P(DGX,U),?45,$P($G(^DIC(42.4,$P(DGX,U,2),0)),U)
 I '$D(DGTSP) W !!?2,"No entries found in File #45.7 which correspond to changed treating",!?2,"specialties in File #42.4."
 K DGDASH
 Q
