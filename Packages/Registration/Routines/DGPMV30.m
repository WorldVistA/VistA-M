DGPMV30 ;ALB/MIR - EDITS FOR DATE/TIME ;12 NOV 89 @8
 ;;5.3;Registration;**95,131**;Aug 13, 1993
CHK ;Check new date/time for consistency with other movements
 I DGPMT=6,$P(^DGPM(DGPMDA,0),U,14)=$P(^DGPM(DGPMDA,0),U,24),+Y'=+^DGPM(DGPMCA,0) S DGPME="Cannot change date/time for treating specialty associated with admission." Q
 I $D(^DGPM("APRD",DFN,+Y))!$D(^DGPM("APTT6",DFN,+Y))!$D(^DGPM("APTT4",DFN,+Y))!$D(^DGPM("APTT5",DFN,+Y)) S DGPME="There is already a movement at that date/time entered for this patient" Q
 S X1=$O(^DGPM("APRD",DFN,+DGPMP+.0000005)) I X1 S X=$O(^DGPM("APRD",DFN,X1,0)) I X,$D(^DGPM(+X,0)) S Z=^(0),X=$P(Z,"^",2) I Y>Z D WR S DGPME=" "_DGPMUC_" must be before next movement." Q
 S X1=$O(^DGPM("APTT4",DFN,+DGPMP+.0000005)) I X1 S X=$O(^DGPM("APTT4",DFN,X1,0)) I X,$D(^DGPM(+X,0)) S Z=^(0),X=$P(Z,"^",2) I Y>Z D WR S DGPME=" "_DGPMUC_" must be before next movement." Q
 S X1=10000000-DGPMP,X1=$O(^DGPM("APID",DFN,X1)) I X1 S X=$O(^DGPM("APID",DFN,X1,0)) I X,$D(^DGPM(+X,0)) S Z=^(0),X=$P(Z,"^",2) I Y<Z D WR S DGPME=" "_DGPMUC_" must be after last movement." Q
 S X1=10000000-DGPMP,X1=$O(^DGPM("ATID5",DFN,X1)) I X1 S X=$O(^DGPM("ATID5",DFN,X1,0)) I X,$D(^DGPM(+X,0)) S Z=^(0),X=$P(Z,"^",2) I Y<Z D WR S DGPME=" "_DGPMUC_" must be after last movement." Q
 I DGPMT=6,$$CHKLAST(DFN,DGPMCA,+Y,+DGPMP) S DGPME="Cannot change treating specialty while patient is on absence." Q
 I DGPMT=6 N DGXTS S DGXTS=$$CHKTS(DFN,+DGPMP,+Y) I DGXTS S DGPME="Cannot change date/time to "_$S(DGXTS=1:"before previous",1:"after next")_" treating specialty change." Q
 S D0=$P(DGPMP,"^",6) I D0 S DGPMOS=+DGPMP D WIN^DGPMDDCF I X S DGPME="Ward was inactive on this date." Q
 S D0=$P(DGPMP,"^",7) I D0 S DGPMOS=+DGPMP D RIN^DGPMDDCF I X S DGPME="Room-bed was inactive on this date." Q
 I DGPMT=4!(DGPMT=5) Q
 S DGPMTYP=$P(DGPMP,"^",18)
 ;I DGPMTYP=40 D ASIHADM^DGPMV300
 I "^41^46^"[("^"_DGPMTYP_"^") S DGPME="Edit through corresponding NHCU/DOM transfer or discharge" Q
 ;if first transfer to ASIH, make sure it remains within 30 days of return
 S K=0 I "^13^43^"[("^"_DGPMTYP_"^") F I=0:0 S I=$O(^DGPM("APCA",DFN,DGPMCA,I)) Q:'I  I $D(^DGPM(+$O(^(I,0)),0)),("^14^42^47^"[("^"_$P(^(0),"^",18)_"^")) S K=+^(0) S:K>DGNOW K=DGNOW Q
 I K S X1=+DGPMY,X2=30 D C^%DTC I X<K S DGPME="Transfer must be within 30 days of return from ASIH" Q
 I $P(DGPMAN,"^",21) D SET^DGPMV32 S X1=+DGPMAB,X2=30 D C^%DTC I DGPMP>X,DGPMY'>X S DGPME="Delete and redo discharge for less than 30 days" Q
 I DGPMP'>X,DGPMY>X S DGPME="Delete and redo discharge for greater than 30 days" Q
 ; no edit of d/t of adm mvt if census rec exist
 I DGPMT=1,$O(^DGPT("ACENSUS",+$P(DGPMAN,"^",16),0)) S DGPME="Cannot change admission date/time while PTF Census record #"_$O(^(0))_" is closed" Q
 ;
 I DGPMTYP=42,(DGPMP'>DGPMY) S DGPME="Must be prior to original discharge date/time" Q
 Q:(DGPMTYP'=42)
 ;No edit if hospital admission discharged...must back out
 S X=$O(^DGPM("APMV",DFN,DGPMCA,+DGPMP)),X=$O(^(+X,0)) I $D(^DGPM(+X,0)),("^13^44^"[$P(^(0),"^",18)),$D(^DGPM($P(^(0),"^",15),0)),$P(^(0),"^",17) S DGPME="Patient discharged from hospital...no edit of NHCU/DOM discharge allowed" Q
ASK W !!?5,"WARNING:  By changing the date/time of this 'WHILE ASIH' discharge,",!?15,"you are permanently discharging this patient from the NHCU/DOM"
 W !?15,"prior to the 30 days of ASIH allotted.  The patient can not be",!?15,"returned to the NHCU/DOM except by readmission.",!!?15,"Are you sure you want to continue" S %=2 D YN^DICN I %<0 S DGPME="" Q
 I '% W !!?5,"Enter 'Y'es to discharge the patient from the NHCU/DOM or 'N'o to",!?15,"continue patient's ASIH stay." G ASK
 I %=2 S DGPMY=+DGPMP W !?5,*7,"NO CHANGE TO DATE/TIME MADE" Q
 S DGMAS=47 D FAMT I 'DGFAC H 5 G H^XUS
 S DIE="^DGPM(",DA=DGPMDA,DR=".04////"_DGFAC D ^DIE K DGFAC
 Q
WR W !,*7," There is a",$S(X=1:"n admission",X=2:" transfer",X=3:" discharge",X=4:" check-in lodger",X=5:" check-out lodger",X=6:" specialty transfer",1:"")," movement on file for this patient on " S X=Y,Y=+Z X ^DD("DD") W Y,"." S Y=X
 Q
 ;
FAMT ;find active movement type
 ;
 ;input:    DGMAS = IFN of 405.2 entry
 ;output:   DGFAC = IFN of active 405.1 entry
 ;
 N I S DGFAC=""
 F I=0:0 S I=$O(^DG(405.1,"AM",DGMAS,I)) Q:'I  I $D(^DG(405.1,+I,0)),$P(^(0),"^",4) S DGFAC=I Q
 I 'DGFAC W !!,"You ASIH movement types are not properly defined...Contact your site manager!","There is no movement type define for ",$P(^DG(405.2,DGMAS,0),"^",1)
 K DGMAS
 Q
 ;
CHKLAST(DFN,DGCA,DGY,DGP) ;Function to confirm that patient is not on absence for time/date selected for TS transfer
 ;
 ;Input  DFN
 ;       DGCA - Corres. Adm.
 ;       DGY - Time/Date being checked
 ;       DGP - date/time before editing
 ;
 ;Output  0 - Pt. not on Absence
 ;        1 - Pt. on Absence
 ;
 N DGFAC,DGMAS,DGX,DGX0,DGZ,X
 S X=0,DGX=$O(^DGPM("APCA",DFN,DGCA,DGY),-1),DGZ=$O(^(DGX,0)),DGX0=$P(^DGPM(DGZ,0),U,4)
 S DGMAS=20 D FAMT
 I '$D(^DG(405.1,+DGFAC,"F",DGX0)) S X=1
 I +$G(DGP)=DGY S X=0
 Q X
 ;
CHKTS(DFN,DGP,DGY) ;check previous and next ts transfer date/time
 ;Output : 0 = acceptable
 ;         1 = before previous ts change
 ;         2 = after next ts change
 N DGTS1,DGTS2,X
 S X=0
 S DGTS1=$O(^DGPM("APTT6",DFN,DGP),-1) I DGY'>DGTS1 S X=1 G CHKTSQ
 S DGTS2=$O(^DGPM("APTT6",DFN,DGP)) I DGTS2,DGY'<DGTS2 S X=2
CHKTSQ Q X
