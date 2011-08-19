GMRACMR ;HIRMFO/WAA,RM-LIST Chart/ID Band mark report ;9/29/97  08:11
 ;;4.0;Adverse Reaction Tracking;**8,35**;Mar 29, 1996
 ;;
EN1 ;PRIMARY ENTRY POINT
 S GMRAOUT=0
QST K DIR S DIR(0)="LAO^1:4"
 S DIR(0)=DIR(0)_"^I X[""."" W !,""DO NOT USE DECIMAL VALUES."",$C(7) K X Q"
 S DIR("A",1)="     1 Current Inpatients",DIR("A",2)="     2 Outpatients over Date/Time range",DIR("A",3)="     3 New Admissions over Date/Time range",DIR("A",4)="     4 All of the above"
 S DIR("A")="Enter the number(s) for those groups to be used in this report: (1-4):"
 S DIR("?",1)="   ENTER THE NUMBER(S) FOR THOSE GROUPS TO BE INCLUDED IN THIS REPORT.",DIR("?")="   THIS RESPONSE MUST BE A LIST OR RANGE, E.G., 1,3 OR 2-3"
 D ^DIR K DIR
 I "^^"[Y S GMRAOUT=1 Q
 S GMRAQST=""
 S:Y["4" Y="1,2,3"
 S GMRASEL=Y
 S:GMRASEL["1" GMRAQST=GMRAQST_"W"
 S:GMRASEL["2" GMRAQST=GMRAQST_"CM"
 S:GMRASEL["3" GMRAQST=GMRAQST_"W"
 D DATE Q:GMRAOUT
 ;Select the ward or clinic
 S Y=$$MDIC^GMRACMR1 I Y<1 S GMRAOUT=1
 Q:GMRAOUT
 Q
DATE ;DATE SELECTION
 ;FROM DATE
 Q:'(GMRASEL["2"!(GMRASEL["3"))
 W !," Enter date/time range in which patients were",!,$S(GMRASEL["3":" admitted into the hospital"_$S(GMRASEL["2":" or",1:""),1:""),$S(GMRASEL["2":" seen at an outpatient clinic",1:""),"."
 W !!," Please note! This report will show patients as not having received an"
 W !,"assessment if the assessment was entered after the end date of"
 W !,"the range.  For this reason, it is recommended to end the range"
 W !,"with today. This can be done with an entry of 'T' (for Today) at"
 W !,"the 'Enter END Date (time optional): T//' prompt."
 W !!,"Enter START Date (time optional): " R X:DTIME S:'$T X="^^" I "^^"[X S GMRAOUT=1 Q
 I X?1"?".E D  G DATE
 .   S %DT="TEX" D HELP^%DTC
 .   W !!?4,"ENTER THE START DATE/TIME OF RANGE TO SEE PATIENTS THAT WERE",!?3,$S(GMRASEL["3":" ADMITTED TO THE HOSPITAL"_$S(GMRASEL["2":" OR",1:""),1:""),$S(GMRASEL["2":" SEEN AT AN OUTPATIENT CLINIC",1:""),".",!
 .   Q
 S %DT="TEX" D ^%DT
 I +Y'>0 G DATE
 S GMRAST=Y K %DT,Y
END ;
 W !,"Enter END Date (time optional): T// " R X:DTIME S:'$T X="^^" S:X="" X="T" I "^^"[X S GMRAOUT=1 Q
 I X?1"?".E D  G END
 .   S %DT="TEX",%DT(0)=GMRAST D HELP^%DTC
 .   W !!?4,"ENTER THE END DATE/TIME OF RANGE TO SEE PATIENTS THAT WERE",!?3,$S(GMRASEL["3":" ADMITTED TO THE HOSPITAL"_$S(GMRASEL["2":" OR",1:""),1:""),$S(GMRASEL["2":" SEEN AT AN OUTPATIENT CLINIC",1:""),".",!
 .   Q
 S %DT(0)=GMRAST,%DT="TEX" D ^%DT
 I +Y'>0 G END
 S GMRAED=Y_$S(Y=(Y\1):".24",1:"") K %DT,Y
 Q
