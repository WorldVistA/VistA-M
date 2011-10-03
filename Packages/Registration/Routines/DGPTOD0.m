DGPTOD0 ;ALB/AS - PTF DRG REPORTS  ; 9/5/01 11:38am
 ;;5.3;Registration;**158,164,238,375**;Aug 13, 1993
 W !!,*7,"THIS REPORT REQUIRES 132 COLUMN OUTPUT."
 D LO^DGUTL,Q,ASK G Q:DGQ S DGPGM="^DGPTOD1",DGVAR="DGSD^DGED^DGCR^DGB^DGS^DGD^DUZ^DGPTFR^DGCST" D ZIS^DGUTQ G:POP Q U IO S X=132 X ^%ZOSF("RM") D ^DGPTOD1,CLOSE^DGUTQ K DGPTFR
Q K ^UTILITY($J),X,Y,Z,DG1,DG2,DG3,DG4,DGD,DGSD,DGED,DGCR,DGS,DGB,DGQ,DG1DAWW,DGHIWW,DGWWCST,DGCST,DGFY,DGFT,DGFY2K,DGSDFY Q
RD S X="" R X:DTIME I X["^"!('$T) S DGQ=1 Q
 S X=$E(X) Q
ASK S DGQ="" W !!,"For (A)CTIVE ADMISSIONS or",!?4,"(D)ISCHARGED PATIENTS: DISCHARGED// " S Z="^ACTIVE ADMISSIONS^DISCHARGED PATIENTS" D RD Q:DGQ  I X="" S X="D" W X
 D IN^DGHELP I %=-1 W !!?12,"CHOOSE FROM:",!?12,"A - Active Admissions (all current inpatients)",!?12,"D - Discharged Patients within a date range",! S %="" G ASK
 S DGD=$S(X="D":1,1:0) I 'DGD S DGSD=0,DGED=(DT_.9),DGCR="AADA",DGB=1 G SVC
DC W ! S DGCR="ADS",%DT="AEXP",%DT(0)=-DT S %DT("A")="Start with DISCHARGE DATE: " D ^%DT S:X["^" DGQ=1 Q:DGQ  G:Y<0 DC S DGSD=Y-.1
 I Y<3001001 W *7,!?12,"Discharge dates may not begin prior to October 1,2000" G DC
 S %DT("A")="  End with DISCHARGE DATE: ",%DT="AEXP",%DT(0)=DGSD D ^%DT S:X["^" DGQ=1 Q:DGQ  G:Y<0 DC I (DGSD+10000)<Y W *7,!?12,"Please limit your date range to no more than 1 year" G DC
 S DGED=Y_.9
 ; check that range does not overlap fiscal years
 I $$FY(DGSD)'=$$FY(DGED) W *7,!?12,"Please do not select dates that overlap fiscal years" G DC
DRG W !!,"For (T)RANSFER DRGs or",!?4,"(D)RG from 701/702/703 TRANSACTIONS: TRANSFER DRGs// " S Z="^TRANSFER DRGs^DRGs from 701/702/703 TRANSACTIONS" D RD Q:DGQ  I X="" S X="T" W X
 D IN^DGHELP I %=-1 W !!?12,"CHOOSE FROM:",!?12,"D - to include DRGs calculated using diagnosis codes from",!?16,"701/702/703 transactions",!?12,"T - to include TRANSFER DRGs based on diagnosis codes from",!?16,"501 transactions",! S %="" G DRG
 S DGB=$S(X="T":1,1:0)
SVC I DGPTFR="*4" S X="M" G CONT   ;no choice for Case Mix Report
 W !!,"Sort Report by DRG for:",!?3,"(M)EDICAL CENTER ONLY or",!?3,"(S)ERVICE WITH SPECIALTY BREAKOUT or",!?3,"(B)OTH MEDICAL CENTER AND SERVICE WITH SPECIALTY: BOTH// " S Z="^MEDICAL CENTER ONLY^SERVICE WITH SPECIALTY^BOTH^"
 D RD Q:DGQ  I X="" S X="B" W X
 D IN^DGHELP I %=-1 W !!?12,"CHOOSE FROM:",!?12,"M - to have report sorted by DRG for entire medical center or",!?12,"S - for service with specialties or",!?12,"B - for both medical center and service with specialties",! S %="" G SVC
CONT S DGS=$S(X="B":"B",X="M":"D",1:"S"),DGFY=$$FY(DGED),DGFY2K=$$DGY2K(DGFY),DGCST=$S($D(^DG(43,1,"FY",DGFY2K)):^(DGFY2K,0),1:"")
 ;I '$D(^ICD("AFY",DGFY2K))!(DGCST']"") D NOFY G ASK
 ;I $P(DGCST,"^",2)'>0!($P(DGCST,"^",3)'>0)!($P(DGCST,"^",5)'>0) D NOFY G ASK
 W !!,"You have selected output for: ",!?4,$S(DGD:"Patients discharged between ",1:"Active admissions")
 I DGD S Y=(DGSD+.1) X ^DD("DD") W ?4,Y," and " S Y=$P(DGED,".") X ^DD("DD") W Y,!?4,$S('DGB:"not ",1:""),"including TRANSFER DRGs."
 I DGPTFR="*4" G OK1
 W !?4,"With breakout by ",$S(DGS="B":"Both Medical Center and Service with Specialties",DGS="D":"Medical Center Only",1:"Service with Specialties Only"),"."
OK1 W !,"IS THIS CORRECT" S %=1 D YN^DICN I '% W !!,"Enter <RET> if this information is correct",!?10,"Enter 'N' for N0 to exit",!! G OK1
 S:%'=1 DGQ=1 Q
 Q
NOFY ; this no longer applies
 W !!,*7,"RAM COSTS and/or DRG WEIGHTS/TRIMS are not entered for Fiscal Year ",DGFY,".",!,"PROCESSING CAN NOT BE DONE FOR SELECTED TIME FRAME"
 W !,"The following RAM values must be entered in your MAS PARAMETERS File",!,"for whatever fiscal year you select: $ PER WWU; COST FOR 1 DAY LOS;",!,"HIGH OUTLIER COST PER DAY.",!,"DRG fy weights and trims must be entered in your DRG File."
 Q
DGY2K(X) ;  convert date to fm
 N %DT,Y
 D ^%DT
 Q Y
 ;
FY(X) ;Return FY
 ;Input: X=date
 S:$E(X,4,5)>9 X=$E(X,1,3)+1
 Q (17+$E(X))_$E(X,2,3)
