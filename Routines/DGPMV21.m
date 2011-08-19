DGPMV21 ;ALB/MRL/MIR - PASS/FAIL MOVEMENT DATE; 8 MAY 89
 ;;5.3;Registration;**40,95,131**;Aug 13, 1993
 I $S('$D(DGPMY):1,DGPMY?7N:0,DGPMY'?7N1".".N:1,1:0) S DGPME="DATE EITHER NOT PASSED OR NOT IN EXPECTED VA FILEMANAGER FORMAT" G Q
 I $S('$D(DGPMT):1,'DGPMT:1,1:0) S DGPME="TRANSACTION TYPE IS NOT DEFINED" G Q
 D PTF^DGPMV22(DFN,DGPMDA,.DGPME,DGPMCA) G:$G(DGPME)]"" Q K DGPME
 G CONT:("^4^5^"[("^"_DGPMT_"^"))!DGPMN D PTF I $D(DGPME),DGPME="***" Q
CONT Q:'DGPMN  D CHK I $D(DGPME) G Q
 I DGPM1X Q  ;Don't ask to add a new one if discharge or check-out
ADD S Y=DGPMY X ^DD("DD")
ADD1 W !!,"SURE YOU WANT TO ADD '",Y,"' AS A NEW ",DGPMUC," DATE" S:"^1^4^"'[("^"_DGPMT_"^") %=1 D YN^DICN Q:%=1  I '% W !?4,"Answer YES if you wish to add this new entry otherwise answer NO!" G ADD1
 S DGPME="NOTHING ADDED" G Q
 ;
CHK ;Check new date/time for consistency with other movements
 I $D(^DGPM("APRD",DFN,DGPMY))!$D(^DGPM("APTT6",DFN,DGPMY))!$D(^DGPM("APTT4",DFN,DGPMY))!$D(^DGPM("APTT5",DFN,DGPMY)) S DGPME="There is already a movement at that date/time" Q
 I "^1^4^"'[("^"_DGPMT_"^"),(DGPMY<+DGPMAN) S DGPME="Not before "_$S(DGPMT<4:"admission",DGPMT>5:"admission",1:"check-in")_" movement" Q
 I "^3^5^"'[("^"_DGPMT_"^"),DGPMCA I DGPMDCD,(DGPMY>DGPMDCD) S DGPME="Not after "_$S(DGPMT<4:"discharge",DGPMT>5:"discharge",1:"check-out")_" movement" Q
 I DGPMT=3 S I=$O(^DGPM("APMV",DFN,DGPMCA,0)),I=$O(^(+I,0)) I $D(^DGPM(+I,0)),(+^(0)>DGPMY) S DGPME="Not before last movement" Q
 I DGPMT=3 S I=$O(^DGPM("ATS",DFN,DGPMCA,0)),I=$O(^(+I,0)),I=$O(^(+I,0)) I $D(^DGPM(+I,0)),(+^(0)>DGPMY) S DGPME="Not before last movement" Q
 I $D(^DGPM(+$P(DGPMAN,"^",21),0)),$D(^DGPM(+$P(^(0),"^",14),0)),$D(^DGPM(+$P(^(0),"^",17),0)) S X=^(0) I $P(X,"^",18)=47,(DGPMY'>+X) S DGPME="Must be after NHCU/DOM discharge" Q
 I DGPMT=6,$$CHKLAST^DGPMV30(DFN,DGPMCA,+DGPMY) S DGPME="Cannot change treating specialty while patient is on absence." Q
 I "^1^4^"'[("^"_DGPMT_"^") Q
 S X=$O(^DGPM("APTT3",DFN,DGPMY)),Y=$O(^DGPM("APTT5",DFN,DGPMY)) I X!Y S DGPME="New "_$S(DGPMT=1:"admission",1:"check-in")_" ...must enter after last "_$S(X:"discharge",1:"check-out") G Q
 S DGX=$P(DGPMAN,"^",21) Q:'$D(^DGPM(+DGX,0))  S DGX=^(0),X=$S($D(^DGPM(+$P(DGX,"^",14),0)):^(0),1:"") Q:'X  I $D(^DGP(45.84,+$P(X,"^",16))) S DGPME="Can't edit.  Corresponding NHCU/DOM PTF Record is Closed." G Q
 I $D(^DGPM(+$P(DGPMAN,"^",17),0)),+^(0) S DGPME="After discharge.  Must edit movement through NHCU/DOM transfer." G Q
 Q
 ;
 ;
PTF S PTF=+$P(DGPMAN,"^",16) I $S('PTF:1,'$D(^DGPT(PTF,0)):1,1:0) D NOPTF Q
 I $D(^DGP(45.84,PTF)) S DGPME="***" W !,"PTF record is closed for this admission...cannot edit" G Q
 Q
 ;
NOPTF W *7 F I=1:1 S J=$P($T(NP+I),";;",2) Q:J=""  W !?4,J
 S DGPME="***"
Q S DGPMY=0 Q
 ;
NP ;
 ;;WARNING:  This  admission has no corresponding  PTF record.
 ;;A  PTF record is  required in order to continue  processing
 ;;this movement activity.   If you have the PTF option called
 ;;"Establish PTF record from Past Admission" on your menu, it
 ;;may be used to  create the PTF  record for this  admission.
 ;;Otherwise appropriate  Medical  Information  Section  (MIS)
 ;;personnel  and/or your supervisor  will need to be notified
 ;;that the PTF record is missing as soon as possible in order
 ;;to continue processing this movement.
