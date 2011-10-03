SPNCMR ;HIRMFO/WAA,RM-LIST Chart/ID Band mark report ; 2/8/93
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;;
EN1 ;PRIMARY ENTRY POINT
 S SPNLEXIT=0
QST K DIR S DIR(0)="LAO^1:4"
 S DIR(0)=DIR(0)_"^I X[""."" W !,""DO NOT USE DECIMAL VALUES."",$C(7) K X Q"
 S DIR("A",1)="     1 Current Inpatients",DIR("A",2)="     2 Outpatients over Date/Time range",DIR("A",3)="     3 New Admissions over Date/Time range",DIR("A",4)="     4 All of the above"
 S DIR("A")="Enter the number(s) for those groups to be used in this report: (1-4):"
 S DIR("?",1)="   ENTER THE NUMBER(S) FOR THOSE GROUPS TO BE INCLUDED IN THIS REPORT.",DIR("?")="   THIS RESPONSE MUST BE A LIST OR RANGE, E.G., 1,3 OR 2-3"
 D ^DIR K DIR
 I "^^"[Y S SPNLEXIT=1 Q
 S SPNQST=""
 S:Y["4" Y="1,2,3"
 S SPNSEL=Y
 S:SPNSEL["1" SPNQST=SPNQST_"W"
 S:SPNSEL["2" SPNQST=SPNQST_"CM"
 S:SPNSEL["3" SPNQST=SPNQST_"W"
 D DATE Q:SPNLEXIT
 ;Select the ward or clinic
 S Y=$$MDIC^SPNCMR1 I Y<1 S SPNLEXIT=1
 Q:SPNLEXIT
 Q
DATE ;DATE SELECTION
 ;FROM DATE
 Q:'(SPNSEL["2"!(SPNSEL["3"))
 W !," Enter date/time range in which patients were",!,$S(SPNSEL["3":" admitted into the hospital"_$S(SPNSEL["2":" or",1:""),1:""),$S(SPNSEL["2":" seen at an outpatient clinic",1:""),"."
 W !!,"Enter START Date (time optional): " R X:DTIME S:'$T X="^^" I "^^"[X S SPNLEXIT=1 Q
 I X?1"?".E D  G DATE
 .   S %DT="TEX" D HELP^%DTC
 .   W !!?4,"ENTER THE START DATE/TIME OF RANGE TO SEE PATIENTS THAT WERE",!?3,$S(SPNSEL["3":" ADMITTED TO THE HOSPITAL"_$S(SPNSEL["2":" OR",1:""),1:""),$S(SPNSEL["2":" SEEN AT AN OUTPATIENT CLINIC",1:""),".",!
 .   Q
 S %DT="TEX" D ^%DT
 I +Y'>0 G DATE
 S SPNST=Y K %DT,Y
END ;
 W !,"Enter END Date (time optional): T// " R X:DTIME S:'$T X="^^" S:X="" X="T" I "^^"[X S SPNLEXIT=1 Q
 I X?1"?".E D  G END
 .   S %DT="TEX",%DT(0)=SPNST D HELP^%DTC
 .   W !!?4,"ENTER THE END DATE/TIME OF RANGE TO SEE PATIENTS THAT WERE",!?3,$S(SPNSEL["3":" ADMITTED TO THE HOSPITAL"_$S(SPNSEL["2":" OR",1:""),1:""),$S(SPNSEL["2":" SEEN AT AN OUTPATIENT CLINIC",1:""),".",!
 .   Q
 S %DT(0)=SPNST,%DT="TEX" D ^%DT
 I +Y'>0 G END
 S SPNED=Y K %DT,Y
 Q
