SROCL1 ;BIR/SJA - LOAD CARDIAC LAB DATA ;07/15/10
 ;;3.0; Surgery ;**95,125,153,160,174**;24 Jun 93;Build 8
 ;
 ; Reference to ^LR( supported by DBIA #194
 ;
 Q:'$D(SRTN)  N SRBLUD K SRAD,SRAT S SRSOUT=0
 W !!,"This selection loads the most recent cardiac lab data for tests performed",!,"preoperatively."
YEP W !!,"Do you want to automatically load cardiac lab data ?  YES//" R SRYN:DTIME G:'$T!(SRYN["^") END
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !!,"Enter <RET> to automatically load cardiac lab data from the patient's lab",!,"record, or 'NO' to return to the menu." G YEP
 I "Yy"'[SRYN W !!,"Lab data NOT loaded." G END
START S SRALR=$S($D(^DPT($P(^SRF(SRTN,0),"^"),"LR")):$P(^("LR"),"^"),1:"")
 S SRAOP=$P($G(^SRF(SRTN,.2)),U,2) I 'SRAOP S SRAOP=$P($G(^(0)),U,9) I 'SRAOP S SRSOUT=1 W !!,"No Date of Operation found !" G END
 N SREND0,SREND1,SREND2,SREND3 S SRST=9999999-SRAOP,X1=SRAOP,X2=-90 D C^%DTC S SREND0=9999999-X
 S X1=SRAOP,X2=-30 D C^%DTC S SREND1=9999999-X
 S X1=SRAOP,X2=-1000 D C^%DTC S SREND2=9999999-X
 S X1=SRAOP,X2=-180 D C^%DTC S SREND3=9999999-X
SRAT ; Get test and data name(s) for test from file 139.2.
 W !!,"..Searching lab record for latest test data...."
 K DIC S DIC=61,DIC(0)="",X="SERUM" D ^DIC S SRSER=+Y K DIC S DIC=61,DIC(0)="",X="PLASMA" D ^DIC K DIC S SRP=+Y
 K DIC S DIC=61,DIC(0)="",X="BLOOD" D ^DIC S SRBLUD=+Y
 F SRAT=1,5,7,11,14,21:1:24,27,28 S SREND=$S("117"[SRAT:SREND1,SRAT=28:SREND3,SRAT>20:SREND2,1:SREND0) D SP^SROAL1
 D CARDIAC^SROAL11 S SRCON=$P($G(^SRF(SRTN,"CON")),"^") I SRCON D CONCC
END I 'SRSOUT W !!,"Press <RET> to continue  " R X:DTIME
 W @IOF
 Q
CONCC ; update concurrent case
 S SRTN1=SRTN,SRTN=SRCON D CARDIAC^SROAL11 S SRTN=SRTN1
 Q
SP S SRASP=$P(^SRO(139.2,II,2),"^") K SRADT F SRADN=0:0 S SRADN=$O(^SRO(139.2,II,1,SRADN)) Q:SRADN'>0  S SRATN=$P(^(SRADN,0),"^") D LABCHK
 Q
LABCHK ; Get latest test values from patient's lab record.
 I SRALR F SRAIDT=SRST:0 S SRAIDT=$O(^LR(SRALR,"CH",SRAIDT)) Q:SRAIDT'>0!(SRAIDT>SREND)  I $D(^(SRAIDT,SRATN)) S SRSP=$P(^(0),"^",5) D
 .I SRSP=SRSER!(SRSP=SRP) D COMP Q
 I '$D(SRAT(SRAT)) S SRAT(SRAT)="NS",SRAD(SRAT)=""
 Q
COMP S SRX=$P(^LR(SRALR,"CH",SRAIDT,SRATN),"^") I $P(^LR(SRALR,"CH",SRAIDT,0),"^",3)'="","canccommentpending"'[SRX,SRX'["CANC" D DATA
 Q
DATA I $D(SRADT),SRAIDT>SRADT Q
 I +SRX'=SRX D
 .N X1,X2 S SRZ="" I "<>"[$E(SRX) S SRZ=$E(SRX),SRX=$E(SRX,2,99)
 .I SRX?.N0.1".".N D  Q
 ..S X1=$P(SRX,"."),X1=+X1 S:X1=0 X1=""
 ..S X2="."_$P(SRX,".",2),X2=+X2 S:X2=0 X2=""
 ..S SRX=X1_X2,SRX=+SRX,SRX=SRZ_SRX
 .S SRX="*"
 S SRAT(SRAT)=SRX D:SRAT(SRAT)["." DEC S SRAD(SRAT)=$E($P(^LR(SRALR,"CH",SRAIDT,0),"^"),1,7),SRADT=SRAIDT
 Q
DEC ; convert to proper decimal place
 I +SRAT(SRAT)=SRAT(SRAT)  S SRAT(SRAT)=SRAT(SRAT)+.05\.1*.1 Q
 S SR1=$E(SRAT(SRAT)),SR2=$E(SRAT(SRAT),2,99),SR2=SR2+.05\.1*.1,SRAT(SRAT)=SR1_SR2
 Q
