DGANHD4 ;ALB/RMO - Print NHCU and DOM AMIS's 345-346 ; 01 SEP 90 10:47 am
 ;;5.3;Registration;;Aug 13, 1993
 ;==============================================================
 ;Print NHCU and DOM AMIS segment fields for each division.
 ;
 ;Input:
 ; DGMYR   -Month/Year being printed in internal date format
 ; ^UTILITY-Contains stats by Month/Year, Segment and Division
 ;==============================================================
 S DGPGE=0,DGLNE="",DGIOM=$S('IOM:80,1:IOM),$P(DGLNE,"=",(DGIOM-1))="",DGX="",DGMAR=DGIOM-38
 F DGSEG=0:0 S DGSEG=$O(^UTILITY($J,"DGANHD",DGMYR,DGSEG)) Q:'DGSEG!(DGX["^")  D SET,PRT
 ;
Q K DGDIVNB,DGFLD,DGIOM,DGFLD,DGLNE,DGMAR,DGPGE,DGSEG,DGTAB,DGX,I,X,Y
 Q
 ;
SET ;Set Tab Variable for Print
 K DGFLD S DGDIVNB=0 F I=0:0 S I=$O(^UTILITY($J,"DGANHD",DGMYR,DGSEG,I)) Q:'I  S DGDIVNB=DGDIVNB+1
 S DGTAB=$S(DGMAR\DGDIVNB>20:20,1:DGMAR\DGDIVNB)
 Q
 ;
PRT ;Print AMIS Segment
 D HD Q:DGX["^"
 S DGFLD="001^ADMIS AFTER REHOSP >30 DAYS" D FLD Q:DGX["^"
 S DGFLD="002^ADMISSIONS - ALL OTHER" D FLD Q:DGX["^"
 S DGFLD="003^TRANSFERS IN SIMAL FACIL" D FLD Q:DGX["^"
 S DGFLD="004^FROM ASIH" D FLD Q:DGX["^"
 S DGFLD="005^DISCHARGES" D FLD Q:DGX["^"
 S DGFLD="006^DEATHS,BO AND ABO" D FLD Q:DGX["^"
 S DGFLD="007^TRANSFERS OUT-SIMILAR FACIL" D FLD Q:DGX["^"
 S DGFLD="008^TO ASIH" D FLD Q:DGX["^"
 S DGFLD="009^BED OCCUPANTS EOM" D FLD Q:DGX["^"
 S DGFLD="010^ABSENT BED OCCUPANTS EOM" D FLD Q:DGX["^"
 S DGFLD="011^ASIH" D FLD Q:DGX["^"
 S DGFLD="012^FEMALE PATIENTS REMAINING EOM" D FLD Q:DGX["^"
 S DGFLD="013^DISCHARGES-ASIH" D FLD Q:DGX["^"
 S DGFLD="014^DIED-ASIH" D FLD Q:DGX["^"
 S DGFLD="015^PATIENT DAYS OF CARE" D FLD Q:DGX["^"
 S DGFLD="016^DAYS OF AUTH ABS <96 HRS" D FLD Q:DGX["^"
 S DGFLD="017^OPERATING BEDS EOM" D FLD Q:DGX["^"
 D LEG
 Q
 ;
FLD ;Print Field for AMIS Segment
 D HD:($Y+7)>IOSL Q:DGX["^"  W !,"(",$P(DGFLD,"^"),")  ",$P(DGFLD,"^",2),?38
 F I=0:0 S I=$O(^UTILITY($J,"DGANHD",DGMYR,DGSEG,I)) Q:'I  W $J(+$P(^(I),"^",+DGFLD),DGTAB-2)
 Q
 ;
HD D CRCHK Q:DGX["^"  W @IOF,!?30,"AMIS ",DGSEG," REPORT" S DGPGE=DGPGE+1 S Y=DT X ^DD("DD") W ?60,"DATE: ",Y
 W !?30,$S(DGSEG=345:"NURSING HOME",DGSEG=346:"DOMICILIARY",1:"UNKNOWN")
 S Y=DGMYR X ^DD("DD") W !?32,"for ",Y
 W !!?38 F I=0:0 S I=$O(^UTILITY($J,"DGANHD",DGMYR,DGSEG,I)) Q:'I  W $J($E($S($D(^DG(40.8,I,0)):$P(^(0),"^"),1:"UNKNOWN"),1,DGTAB-2),DGTAB)
 W !,DGLNE
 Q
 ;
LEG D CRCHK:($Y+7)>IOSL Q:DGX["^"  W !,DGLNE,!,"FOR THIS SEGMENT FIELDS SHOULD BALANCE AS FOLLOWS:"
 W !!,?3,"Fields 009 and 010 prior period plus 001,002,003,004 current period"
 W !,?3,"less fields 005 thru 008 current period must equal fields",!?3,"009 and 010 current period."
 I $D(^DGAM(345,DGMYR,"SE",DGSEG,0)),'$P(^(0),"^",2) W !!,"*** This segment ",$S($P(^(0),"^",2)="":"has Not been Balanced",1:"is Out of Balance"),". ***"
 W !,DGLNE
 Q
 ;
CRCHK I DGPGE,$E(IOST,1)="C" W !!,*7,"Press RETURN to continue or '^' to stop " R X:DTIME S:'$T X="^" S DGX=X
 Q
