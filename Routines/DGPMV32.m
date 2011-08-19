DGPMV32 ;ALB/MIR - CONTINUE TRANSFER A PATIENT OPTION ;5/7/91  09:08
 ;;5.3;Registration;**418**;Aug 13, 1993
 S DGPMTYP=$P(DGPMA,"^",18) I $S('DGPMTYP:1,'$D(^DG(405.2,+DGPMTYP,"E")):1,'^("E"):1,1:0) I '$P(DGPMA,"^",4)!'$P(DGPMA,"^",6) S DA=DGPMDA,DIK="^DGPM(" D ^DIK W !,"Incomplete Transfer...Deleted" K DIK S DGPMA="" G Q
 I $S($P(DGPMA,"^",6,7)=$P(DGPMP,"^",6,7):0,'DGPMABL:0,1:1) S DGPMND=DGPMA D AB ;if change in room-bed or ward and next movement is to absence, update subsequent absences
CONT S DGPMTYP="^"_DGPMTYP_"^" I "^13^44^"[DGPMTYP D ECA^DGPMV321 ;Edit Corresponding admission when TO ASIH or RESUME ASIH
 I DGPMTYP="^43^" D ASIHOF
 I "^14^45^"[DGPMTYP D UHD^DGPMV321 ;if FROM ASIH or CHANGE ASIH LOCATION (O.F.)
 I $D(^DG(405.1,+$P(DGPMA,"^",4),0)),'$P(^(0),"^",5) G Q
 S Y=DGPMDA D:'DGPMOUT SPEC^DGPMV36
Q I DGPMA'=DGPMP W !,"Patient Transfer",$S('$D(^DGPM(+DGPMDA,0)):" Deleted.",'DGPMP:"red.",1:" Updated.") K ORQUIT
 Q
AB ;update absences upon ward/room-bed change during admit or transfer patient options
 S DGI=$P(DGPMND,"^"),DIE="^DGPM(",DIC(0)="M" W !,"Updating subsequent Absences"
 F DGI=DGI:0 S DGI=$O(^DGPM("APTT2",DFN,DGI)) Q:'DGI  F DGJ=0:0 S DGJ=$O(^DGPM("APTT2",DFN,DGI,DGJ)) Q:'DGJ  I $D(^DGPM(DGJ,0)) S DGJJ=^(0) Q:$P(DGJJ,"^",14)'=DGPMCA  D ABB
 K DA,DGI,DGJ,DGJJ,DGPMND,DIC,DIE,J
 Q
ABB ;absence checks
 I $S($P(DGJJ,"^",18)=23:0,'$D(^DG(405.2,+$P(DGJJ,"^",18),"E")):1,^("E"):0,1:1) Q  ;quit if from pass or not absence mvt
 S J=$S("^1^23^43^45^"[("^"_$P(DGJJ,"^",18)_"^"):1,1:0),DA=+DGJ,DR=".06////"_$P(DGPMND,"^",6)_$S(J:";.07////"_$P(DGPMND,"^",7),1:"") K DQ,DG
 S ^UTILITY("DGPM",$J,$P(DGJJ,"^",2),DA,"P")=DGJJ D ^DIE S ^UTILITY("DGPM",$J,$P(DGJJ,"^",2),DA,"A")=^DGPM(DA,0)
 Q
DICS S DGX=$P(DGPM0,"^",4) I $S('$D(^DG(405.1,+DGX,0)):0,'$D(^DG(405.1,+Y,"F",+DGX)):1,1:0) S DGER=1 Q
 S DGX=$P(DGPM2,"^",4) I $S('$D(^DG(405.1,+DGX,0)):0,'$D(^DG(405.1,+DGX,"F",+Y)):1,1:0) S DGER=1 Q
 S DGX=$P(^DG(405.1,+Y,0),"^",3) I $P(DGPM0,"^",2)=1,$S('$D(^DG(405.2,+DGX,"E")):0,$P(^("E"),"^",2):0,1:1) S DGER=1 Q
 I $P(DGPM0,"^",15),(DGX=14),($P(DGPM0,"^",18)'=45) S DGER=1 Q
 I "^1^2^3^"[("^"_$P(^DGPM(DA,0),"^",18)_"^"),(DGX=4) S DGER=1 Q
 ;I "^13^43^44^45"[("^"_DGX_"^"),("^NH^D^"'[("^"_$S($D(^DIC(42,+$P(DGPMAN,"^",6),0)):$P(^(0),"^",3),1:"")_"^")) S DGER=1 Q
 I "^13^43^44^45^"[("^"_DGX_"^"),("^NH^D^"'[("^"_$S($D(^DIC(42,+$P(DGPMAN,"^",6),0)):$P(^(0),"^",3),1:"")_"^"))&($P(^(0),"^",17)'=1) S DGER=1 Q  ;p-418
 ;I DGX=14,("^NH^D^"'[("^"_$S($D(^DIC(42,+$P(DGPMAN,"^",6),0)):$P(^(0),"^",3),1:"")_"^")) S DGER=1 Q
 I DGX=14,("^NH^D^"'[("^"_$S($D(^DIC(42,+$P(DGPMAN,"^",6),0)):$P(^(0),"^",3),1:"")_"^"))&($P(^(0),"^",17)'=1) S DGER=1 Q  ;p-418
 I $P(DGPMP,"^",15),(DGX'=$P(DGPMP,"^",18)) S DGER=1 Q
 I DGX=44,($P(DGPM2,"^",18)=14) S DGER=1 Q
 S DGER=0 Q
ASIHOF ;if TO ASIH (OTHER FACILITY) update pseudo discharge
 I DGPMN S DGPMTN=DGPMA,DGPMNI=DGPMCA D FINDLAST,ASIHOF^DGPMV321 Q
 S X1=+DGPMA,X2=30 D C^%DTC S DA=$P(DGPMAN,"^",17)
 I $D(^DGPM(+DA,0)) S ^UTILITY("DGPM",$J,3,DA,"P")=$S($D(^UTILITY("DGPM",$J,3,DA,"P")):^("P"),1:^DGPM(DA,0)),DIE="^DGPM(",DR=".01///"_X K DQ,DG D ^DIE S ^UTILITY("DGPM",$J,3,DA,"A")=^DGPM(DA,0) ;update pseudo discharge
 Q
SET ;set variables if coming from hospital admission (for FINDLAST)
 S DGPMAB=0,DGPMTN=$S($D(^DGPM(+$P(DGPMAN,"^",21),0)):^(0),1:""),DGPMNI=$S($D(^DGPM(+$P(DGPMTN,"^",14),0)):+$P(DGPMTN,"^",14),1:"") Q:'DGPMNI
FINDLAST ;find the last transfer which originated ASIH care (either a TO ASIH or TO ASIH (OTHER FACILITY) transfer)
 ;
 ;input:  DGPMNI - IFN of NHCU/DOM admission
 ;        DGPMTN - 0 node of transfer which created hospital admission
 ;output: DGPMAB - the date/time on which ASIH care began.  will be the
 ;                 same date/time for TO ASIH and TO ASIH (O.F.),
 ;                 earlier for RESUME ASIH IN PARENT FACILITY and 
 ;                 CHANGE ASIH LOCATION (OTHER FACILITY) transfers.
 ;
 S DGPMAB=0 I "^13^43^"[("^"_$P(DGPMTN,"^",18)_"^") S DGPMAB=+DGPMTN Q
 I "^44^45^"[("^"_$P(DGPMTN,"^",18)_"^") F I=9999999.999999-+DGPMTN:0 S I=$O(^DGPM("APMV",DFN,DGPMNI,I)) Q:'I  S X=$O(^(I,0)) I $D(^DGPM(+X,0)),("^13^43^"[("^"_$P(^(0),"^",18)_"^")) S DGPMAB=$P(^(0),"^",1) Q
 K DGPMNI,DGPMTN Q
