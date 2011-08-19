SROAL2 ;BIR/ADM - LOAD POSTOPERATIVE LAB DATA ;02/14/07
 ;;3.0; Surgery ;**18,38,47,54,65,71,88,100,125,153,160**;24 Jun 93;Build 7
 ;
 ; Reference to ^LR( supported by DBIA #194
 ;
 Q:'$D(SRTN)  N SRBLUD K SRAD,SRAT S SRSOUT=0
 W !!,"This selection loads highest or lowest lab data for tests performed within",!,"30 days after the operation."
YEP W !!,"Do you want to automatically load postoperative lab data ?  YES//  " R SRYN:DTIME G:'$T!(SRYN["^") END
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !!,"Enter <RET> to automatically load postoperative lab data from the patient's lab record, or 'NO' to return to the menu." G YEP
 I "Yy"'[SRYN W !!,"Lab data NOT loaded." G END
START S SRALR=$S($D(^DPT($P(^SRF(SRTN,0),"^"),"LR")):$P(^("LR"),"^"),1:"")
 S SRAOP=$P($G(^SRF(SRTN,.2)),"^",3) I 'SRAOP W !!,"'Time the Operation Ends' must be entered before continuing." D TMCHK G:SRSOUT END
 S SREND=9999999-SRAOP,X1=SRAOP,X2=30 D C^%DTC S SRST=9999999-X
SRAT ; Get test from file 139.2.
 W !!,"..Searching lab record for postoperative lab test data...."
 K DIC S DIC=61,DIC(0)="",X="SERUM" D ^DIC S SRSER=+Y K DIC S DIC=61,DIC(0)="",X="PLASMA" D ^DIC K DIC S SRP=+Y
 K DIC S DIC=61,DIC(0)="",X="BLOOD" D ^DIC S SRBLUD=+Y
 S SRFLG="H" F SRAT=2,3,4,5,7,9,10,14,16,26 S SRASP=$P(^SRO(139.2,SRAT,2),"^") D SRADN,NS
 S SRFLG="L" F SRAT=4,5,17 S SRASP=$P(^SRO(139.2,SRAT,2),"^") D SRADN,NS
 I $$LOCK^SROUTL(SRTN) D ^SROAL21,UNLOCK^SROUTL(SRTN)
END I 'SRSOUT W !!,"Press <RET> to continue  " R X:DTIME
 W @IOF
 Q
SRADN ; Get data name(s) for test, make call to check lab record.
 F SRADN=0:0 S SRADN=$O(^SRO(139.2,SRAT,1,SRADN)) Q:SRADN'>0  S SRATN=$P(^(SRADN,0),"^") D LABCHK
 Q
LABCHK ; Get test values from patient's lab record.
 S SRX="" I SRALR F SRAIDT=SRST:0 S SRAIDT=$O(^LR(SRALR,"CH",SRAIDT)) Q:SRAIDT'>0!(SRAIDT>SREND)  I $D(^(SRAIDT,SRATN)) S SRSP=$P(^(0),"^",5) D  Q:(SRFLG="H"&(SRX[">"))!(SRFLG="L"&(SRX["<"))  I SRX="*" D STAR
 .I (SRAT>1&(SRAT<16))!(SRAT=26)!(SRAT>20&(SRAT<25)),SRSP=SRSER!(SRSP=SRP)!(SRSP=SRBLUD) D COMP Q
 .I SRSP=SRASP D COMP Q
 Q
COMP S SRAVAL=$P(^LR(SRALR,"CH",SRAIDT,SRATN),"^") I $P(^LR(SRALR,"CH",SRAIDT,0),"^",3)'="","canccommentpending"'[SRAVAL,SRAVAL'["CANC" D DATA
 I $D(SRAT(SRFLG,SRAT)),SRAT(SRFLG,SRAT)["." D
 .I SRAT(SRFLG,SRAT)=+SRAT(SRFLG,SRAT) S SRAT(SRFLG,SRAT)=SRAT(SRFLG,SRAT)+.005\.01*.01 Q
 .S SR1=$E(SRAT(SRFLG,SRAT)),SR2=$E(SRAT(SRFLG,SRAT),2,99),SR2=SR2+.005\.01*.01,SRAT(SRFLG,SRAT)=SR1_SR2
 Q
NS ; check for no sample
 I '$D(SRAT(SRFLG,SRAT)) S SRAT(SRFLG,SRAT)="NS",SRAD(SRFLG,SRAT)=""
 Q
STAR ; questional result, require manual input
 S (SRAT(SRFLG,SRAT),SRAD(SRFLG,SRAT))=""
 Q
DATA ; Decide to save test result or not
 N SRSWAP,SRVAL S SRSWAP=0
 S (SRT,SRX)=SRAVAL I +SRAVAL'=SRAVAL D CONV Q:SRX="*"  S (SRT,SRAVAL)=SRZ_SRX
 I $D(SRAT(SRFLG,SRAT)) S SRT1=SRAT(SRFLG,SRAT) D  I SRSWAP S SRAT(SRFLG,SRAT)=SRAVAL,SRAD(SRFLG,SRAT)=$E($P(^LR(SRALR,"CH",SRAIDT,0),"^"),1,7) Q
 .I SRFLG="H" Q:SRT1[">"  D
 ..I SRT[">" S SRSWAP=1 Q
 ..S SRVAL=SRX,SRX=SRT1 D CONV I SRVAL>SRX S SRSWAP=1 Q
 .I SRFLG="L" Q:SRT1["<"  D
 ..I SRT["<" S SRSWAP=1 Q
 ..S SRVAL=SRX,SRX=SRT1 D CONV I SRVAL<SRX S SRSWAP=1 Q
 I '$D(SRAT(SRFLG,SRAT)) S SRAT(SRFLG,SRAT)=SRAVAL,SRAD(SRFLG,SRAT)=$E($P(^LR(SRALR,"CH",SRAIDT,0),"^"),1,7)
 Q
TMCHK W !!,"Do you want to enter the time that the operation was completed at ",!,"this time ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !!,"Enter 'YES' to input 'Time the Operation Ends' or ",!,"'NO' to return to the menu." G TMCHK
 I "Yy"'[SRYN S SRSOUT=1 Q
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .W ! K DR S DR=".23T",DA=SRTN,DIE=130 D ^DIE K DR S SRAOP=$P($G(^SRF(SRTN,.2)),"^",3) I 'SRAOP S SRSOUT=1
 Q
CONV ; convert value to numeric for comparison
 N SRELSE,X1,X2 S SRZ="" I " <>"[$E(SRX) S SRZ=$E(SRX),SRX=$E(SRX,2,99)
 I SRX?.N0.1".".N D  Q
 .I SRX'["." S SRX=+SRX Q
 .S X1=$P(SRX,"."),X1=+X1 S:X1=0 X1=""
 .S X2="."_$P(SRX,".",2),X2=+X2 S:X2=0 X2=""
 .S SRX=X1_X2,SRX=+SRX
 S SRX="*"
 Q
