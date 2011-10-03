SROAL1 ;BIR/ADM - LOAD PREOPERATIVE LAB DATA ;02/14/07
 ;;3.0; Surgery ;**18,38,47,54,65,71,81,88,100,125,153,160**;24 Jun 93;Build 7
 ;
 ; Reference to ^LR( supported by DBIA #194
 ;
 Q:'$D(SRTN)  N SRBLUD K SRAD,SRAT S SRSOUT=0
 W !!,"This selection loads the most recent lab data for tests performed",!,"within 90 days before the operation unless otherwise specified."
YEP W !!,"Do you want to automatically load preoperative lab data ?  YES//  " R SRYN:DTIME G:'$T!(SRYN["^") END
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !!,"Enter <RET> to automatically load preoperative lab data from the patient's lab record, or 'NO' to return to the menu." G YEP
 I "Yy"'[SRYN W !!,"Lab data NOT loaded." G END
START S SRALR=$S($D(^DPT($P(^SRF(SRTN,0),"^"),"LR")):$P(^("LR"),"^"),1:"")
 S SRAOP=$P($G(^SRF(SRTN,.2)),"^",2) I 'SRAOP W !!,"The 'Time the Operation Began' must be entered before continuing." D TMCHK G:SRSOUT END
 S SRST=9999999-SRAOP,X1=SRAOP,X2=-90 D C^%DTC S SREND=9999999-X
SRAT ; Get test and data name(s) for test from file 139.2.
 W !!,"..Searching lab record for latest preoperative test data...."
 K DIC S DIC=61,DIC(0)="",X="SERUM" D ^DIC S SRSER=+Y K DIC S DIC=61,DIC(0)="",X="PLASMA" D ^DIC K DIC S SRP=+Y
 K DIC S DIC=61,DIC(0)="",X="BLOOD" D ^DIC S SRBLUD=+Y
 F SRAT=1,4,7,8,11,13:1:20,25 D SP
 S SRAT=26,X1=SRAOP,X2=-2 D C^%DTC S SREND=9999999-X D SP
 S SRAT=27,X1=SRAOP,X2=-1000 D C^%DTC S SREND=9999999-X D SP
 I $$LOCK^SROUTL(SRTN) D ^SROAL11 S SRCON=$P($G(^SRF(SRTN,"CON")),"^") D:SRCON CONCC D UNLOCK^SROUTL(SRTN)
END I 'SRSOUT W !!,"Press <RET> to continue  " R X:DTIME
 W @IOF
 Q
CONCC ; update concurrent case
 S SRTN1=SRTN,SRTN=SRCON D N4^SROAL11 S SRTN=SRTN1
 Q
SP S SRASP=$P(^SRO(139.2,SRAT,2),"^") K SRADT F SRADN=0:0 S SRADN=$O(^SRO(139.2,SRAT,1,SRADN)) Q:SRADN'>0  S SRATN=$P(^(SRADN,0),"^") D LABCHK
 D NS
 Q
LABCHK ; Get latest test values from patient's lab record.
 I SRALR F SRAIDT=SRST:0 S SRAIDT=$O(^LR(SRALR,"CH",SRAIDT)) Q:SRAIDT'>0!(SRAIDT>SREND)  I $D(^(SRAIDT,SRATN)) S SRSP=$P(^(0),"^",5) D
 .I (SRAT>1&(SRAT<16))!(SRAT=26)!(SRAT>20&(SRAT<25)),SRSP=SRSER!(SRSP=SRP)!(SRSP=SRBLUD) D COMP Q
 .I SRSP=SRASP D COMP
 Q
NS ; check for no sample
 I '$D(SRAT(SRAT)) S SRAT(SRAT)="NS",SRAD(SRAT)=""
 Q
COMP S SRX=$P(^LR(SRALR,"CH",SRAIDT,SRATN),"^") I $P(^LR(SRALR,"CH",SRAIDT,0),"^",3)'="","canccommentpending"'[SRX,SRX'["CANC" D DATA
 Q
DATA I $D(SRADT),SRAIDT>SRADT Q
 I +SRX'=SRX D
 .N X1,X2 S SRZ="" I " <>"[$E(SRX) S SRZ=$E(SRX),SRX=$E(SRX,2,99)
 .I SRX?.N0.1".".N D  Q
 ..S X1=$P(SRX,"."),X1=+X1 S:X1=0 X1=""
 ..S X2="."_$P(SRX,".",2),X2=+X2 S:X2=0 X2=""
 ..S SRX=X1_X2,SRX=+SRX,SRX=SRZ_SRX
 .S SRX="*"
 S SRAT(SRAT)=SRX D:SRAT(SRAT)["." DEC S SRAD(SRAT)=$E($P(^LR(SRALR,"CH",SRAIDT,0),"^"),1,7),SRADT=SRAIDT
 Q
TMCHK W !!,"Do you want to enter 'Time the Operation Began' at this time ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN)
 I "YyNn"'[SRYN W !!,"The time that the operation began must be entered prior to capturing the",!,"preoperative lab data.  Enter 'YES' to input 'Time the Operation Began',",!,"or 'NO' to return to the menu." G TMCHK
 I "Yy"'[SRYN S SRSOUT=1 Q
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .W ! K DR S DR=".22T",DA=SRTN,DIE=130 D ^DIE K DR
 S SRAOP=$P($G(^SRF(SRTN,.2)),"^",2) I 'SRAOP S SRSOUT=1
 Q
DEC ; convert to proper decimal place
 I +SRAT(SRAT)=SRAT(SRAT)  S SRAT(SRAT)=SRAT(SRAT)+.005\.01*.01 Q
 S SR1=$E(SRAT(SRAT)),SR2=$E(SRAT(SRAT),2,99),SR2=SR2+.005\.01*.01,SRAT(SRAT)=SR1_SR2
 Q
CREAT ; from SROACL1 for creatinine
 N SRSER,SRP K DIC S DIC=61,DIC(0)="",X="SERUM" D ^DIC S SRSER=+Y K DIC S DIC=61,DIC(0)="",X="PLASMA" D ^DIC K DIC S SRP=+Y
 S SRLB=0 F SRLB=4,8,20 D
 .S VALUE=$P($G(^SRF(SRTN,201)),"^",SRLB),SRAOPDT=$P(^SRF(SRTN,0),"^",9) I DT>SRAOPDT,VALUE Q
 .S SRSOUT=0,SRALR=$S($D(^DPT($P(^SRF(SRTN,0),"^"),"LR")):$P(^("LR"),"^"),1:"")
 .S SRAOP=SRAOPDT,SRST=9999999-SRAOP,X1=SRAOP,X2=-30 D C^%DTC S SREND=9999999-X
 .S SRAT=$S(SRLB=4:7,SRLB=8:11,1:1),SRASP=$P(^SRO(139.2,SRAT,2),"^") K SRADT F SRADN=0:0 S SRADN=$O(^SRO(139.2,SRAT,1,SRADN)) Q:'SRADN  S SRATN=$P(^(SRADN,0),"^") D LABCHK
 .I $D(SRAT(SRAT)),$$LOCK^SROUTL(SRTN) S $P(^SRF(SRTN,201),"^",SRLB)=SRAT(SRAT),$P(^(202),"^",SRLB)=SRAD(SRAT) D UNLOCK^SROUTL(SRTN)
 K SRLB
 Q
