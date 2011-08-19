SDM4 ;ALB/BOK - MAKE APPOINTMENT ; 12 APR 1988 1100  ; Compiled April 9, 2007 14:26:51
 ;;5.3;Scheduling;**263,273,327,394,417,496**;Aug 13, 1993;Build 11
 ;
 ;09/15/2002 $N FUNCTION REMOVED AND REPLACED WITH $O - IOFO - BAY PINES - TEH
 ;
 ;DBIA - 1476 For reference to PRIMARY ELIG. ^DPT(IEN,.372).
 ;DBIA - 427  For reference to ^DIC(8).
 ;
 ;09/23/2005 Patch SD*5.3*417 Upper/Lower case useage.
 ;04/09/2007 Patch SD*5.3*496 Accept entry in file 44 without STOP CODE
 ;
 ;
TYPE ;
 D SC
RAT ;Display rated service connected disabilities patch SD*5.3*394
 D 2^VADPT
 W !!,"PATIENT'S SERVICE CONNECTION AND RATED DISABILITIES:"
 IF $$GET1^DIQ(2,DFN_",",.301,"E")="YES"&($P(VAEL(3),"^",2)'="") D
 .W !,"SC Percent: "_$P(VAEL(3),"^",2)_"%"
 IF $$GET1^DIQ(2,DFN_",",.301,"E")="NO"&($P(VAEL(3),"^",2)="") D
 .W !,"Service Connected: No"
 ;Rated Disabilities
 N SDSER,SDRAT,SDPER,SDREC,NN,NUM,ANS,SDELIG,SDATD,SDSCFLG S (ANS,NN,NUM)=0
 F  S NN=$O(^DPT(DFN,.372,NN)) Q:'NN  D
 .S SDREC=$G(^DPT(DFN,.372,NN,0)) IF SDREC'="" D
 ..S SDRAT="" S NUM=$P($G(SDREC),"^",1) IF NUM>0 S SDRAT=$$GET1^DIQ(31,NUM_",",.01)
 ..S SDSER="" S SDSER=$S($P(SDREC,"^",3)="1":"SC",1:"NSC")
 ..W !,"    "_SDRAT_"  ("_SDSER_" - "_$P(SDREC,"^",2)_"%)"
 ..Q
 W !,"Primary Eligibility Code: "_$P(VAEL(1),"^",2)
 IF $P($G(^DPT(DFN,.372,0)),"^",4)<1 W !,"No Service Connected Disabilities Listed"
 W !
 S SDELIG=$$GET1^DIQ(2,DFN_",",.301,"E"),SDSCFLG=0
 IF SDELIG="" W !,"'SERVICE CONNECTED?' field is blank please update patient record." S SDSCFLG=1
 IF $P(VAEL(1),U,2)="" W !,"'PRIMARY ELIGIBILITY CODE' field is blank please update patient record." S SDSCFLG=1
 IF SDELIG="NO",($P(VAEL(3),U,2)>0)!($P(VAEL(1),U,2)="SC LESS THAN 50%")!($P(VAEL(1),U,2)="SERVICE CONNECTED 50% to 100%")!($P(VAEL(1),U,2)="") D
 .W !,"The 'SC Percent','Service Connected' and 'Primary Eligibility Codes' are OUT OF SYNC, Please CORRECT the problem." S SDSCFLG=1
 IF SDELIG="YES",($P(VAEL(3),"^",2)<50),($P(VAEL(1),"^",2)'="SC LESS THAN 50%") D
 .W !,"The 'SC Percent','Service Connected' and 'Primary Eligibility Codes' are OUT OF SYNC, Please CORRECT the problem." S SDSCFLG=1
 IF SDELIG="YES",($P(VAEL(3),"^",2)>49),($P(VAEL(1),"^",2)'="SERVICE CONNECTED 50% to 100%") D
 .W !,"The 'SC Percent','Service Connected' and 'Primary Eligibility Codes' are OUT OF SYNC, Please CORRECT the problem." S SDSCFLG=1
 W !
 ;Ask about service connected appointment
 N STOP,STOPN,SIEN S (ACT,IENACT)="" S STOP=$$GET1^DIQ(44,+SC_",",8,"I")
 I +STOP>0 S STOPN=$$GET1^DIQ(40.7,+STOP_",",1),IENACT=$O(^SD(409.45,"B",STOPN,IENACT))
 E  W "***NO STOP CODE ASSIGNED***" S SDATD="REGULAR" D APT Q
 IF IENACT'="" S SDATD=99999999999,SDATD=$O(^SD(409.45,IENACT,"E",SDATD),-1) D
 .IF SDATD>0 S ACT=$P(^SD(409.45,IENACT,"E",SDATD,0),"^",2)
 IF ACT=1 S SDATD=$$GET1^DIQ(44,+SC_",",2507) GOTO APT
 S SDATD="",SDATD=$$GET1^DIQ(44,+SC_",",2502) IF SDATD="YES" S SDATD=$$GET1^DIQ(44,+SC_",",2507) W "          ***NON-COUNT CLINIC***" GOTO APT
 S SDATD="",SDATD=$$INP^SDAM2(DFN,DT) IF SDATD="I" S SDATD=$$GET1^DIQ(44,+SC_",",2507) W "          ***PATIENT IS CURRENTLY AN INPATIENT***" GOTO APT
 ;STOP EXCEPTION CODES
 S SDATD="",SDATD=$P(VAEL(1),"^",2)
 IF SDATD'="SC LESS THAN 50%"&(SDATD'="SERVICE CONNECTED 50% to 100%") S SDATD="" S SDATD=$S($D(SDAPTYP):SDAPTYP,$D(^SC(+SC,"AT")):$S($D(^SD(409.1,+^("AT"),0)):$P(^(0),U),1:"REGULAR"),1:"REGULAR") D
 .IF SDSCFLG&(SDATD="SERVICE CONNECTED") S SDATD="REGULAR"
 IF SDATD="SC LESS THAN 50%"!(SDATD="SERVICE CONNECTED 50% to 100%") D
 .D SBR K SDANS
 .IF ANS="N" S SDATD=$S($D(SDAPTYP):SDAPTYP,$D(^SC(+SC,"AT")):$S($D(^SD(409.1,+^("AT"),0)):$P(^(0),U),1:"REGULAR"),1:"REGULAR")
 .IF ANS="Y" D
 ..S ANS="" S ANS=$$GET1^DIQ(44,+SC_",",2507) IF ANS="REGULAR"!(ANS="") D
 ...S NN=$O(^SD(409.1,"B","SERVICE CONNECTED",NN)),SDATD=$$GET1^DIQ(409.1,NN_",",.01)
 ..IF ANS'="REGULAR"&(ANS'="") S SDATD=ANS
APT W !,"APPOINTMENT TYPE: "_SDATD_"//" R X:DTIME I X']"" S X=SDATD
 I X["^" W !,"APPOINTMENT TYPE IS REQUIRED" G APT
 I X="S" W !,"PLEASE ENTER MORE THAN ONE CHARACTER" G APT
 I SDSCFLG D
 .S DIC("S")="I $D(X),$E(X,1,2)'[""SE"""
 .S DIC(0)="QEMNZ",DIC=409.1 D ^DIC I Y<0 Q
 .S SDSCFLG=0
 G APT:SDSCFLG
 S SDEC=$S($D(^DIC(8,+VAEL(1),0)):$P(^(0),U,5),1:"")
 S DIC("S")="I '$P(^(0),U,3),$S(SDEC[""Y"":1,1:$P(^(0),U,5)),$S('$P(^(0),U,6):1,$D(VAEL(1,+$P(^(0),U,6))):1,+VAEL(1)=$P(^(0),U,6):1,1:0)",DIC="^SD(409.1,",DIC(0)="EQMZ" D ^DIC K DIC
 I X["^"!(Y'>0) W !,"Appointment type is required",!,"Patient must have the eligibility code EMPLOYEE, COLLATERAL or SHARING AGREEMENT",!,"to choose those types of appointments." G TYPE
 S COLLAT=$S(+Y=1:1,+Y=7:7,1:0),SDAPTYP=+Y,SDDECOD=$P(^SD(409.1,+Y,0),U,6) I COLLAT W !!,"** Note - You are making a ",$P(^SD(409.1,+COLLAT,0),U)," appt.",!
 Q:$D(SDAMBAE)
 I COLLAT=7 S SDCOL=$P(^SD(409.1,SDAPTYP,0),U,6) I '$D(SDMLT)&'$D(SDD) D ^SDM0,END^SDM
 Q
ELIG S SDALLE="",SDEMP=$P(VAEL(1),U,2) W !,"THIS PATIENT HAS OTHER ENTITLED ELIGIBILITIES:" F SDOEL=0:0 S SDOEL=$O(VAEL(1,SDOEL)) Q:SDOEL=""  W !?5,$P(VAEL(1,SDOEL),U,2) S SDALLE=SDALLE_"^"_$P(VAEL(1,SDOEL),U,2)
1 W !,"ENTER THE ELIGIBILITY FOR THIS APPOINTMENT: "_SDEMP_"// " R X:DTIME Q:"^"[X  S X=$$UPPER^VALM1(X) G ELIG:X["?",1:SDALLE'[("^"_X)
 S SDEMP=X_$P($P(SDALLE,"^"_X,2),"^") W $P($P(SDALLE,"^"_X,2),"^")
 F SDOEL=0:0 S SDOEL=$O(VAEL(1,SDOEL)) Q:SDOEL=""  I $P(VAEL(1,SDOEL),U,2)=SDEMP S SDEMP=SDOEL_"^"_SDEMP Q
 Q
SC ;SERVICE CONNECTED MESSAGE/IOFO - BAY PINES/TEH
 I $D(^DPT(DFN,.3)) S SDAMSCN=+$P(^(.3),U,2) I SDAMSCN>49 D
 .W !,?7,"********** THIS PATIENT IS 50% OR GREATER SERVICE-CONNECTED **********",!
 ;I $D(SDWLLIST),SDWLLIST D ^SDWLR       ;Patch SD*5.3*327
 Q
SBR S (ANS,SDANS)=""
 IF SDSCFLG S ANS="N" Q
 IF $D(^DPT(DFN,.3)) S SDANS=$$GET1^DIQ(2,DFN_",",.302) IF SDANS>49 S ANS="Y" Q
 S DIR("A")="IS THIS APPOINTMENT FOR A SERVICE CONNECTED CONDITION",DIR(0)="Y^A0" D ^DIR S ANS=$S(Y=1:"Y",1:"N")
 I ANS'="Y"&(ANS'="N") W !,*7,"ENTER (Y or N) PLEASE!" G SBR
 K DIR Q
