SROVAR ;BIR/MAM,ADM - SITE PARAMETERS ; 7/21/09 1:37pm
 ;;3.0;Surgery;**17,38,48,67,77,50,87,88,102,107,100,134,144,157,171,187**;24 Jun 93;Build 4
 ;
 ; Reference to ^TMP("CSLSUR1" supported by DBIA #3498
 ;
 K ^TMP("CSLSUR1",$J),^TMP("SRPFSS",$J) D CLEAR
 I $D(SRSITE) Q
 D CPT
 K SRL S (SRCNT,X)=0 F  S X=$O(^SRO(133,X)) Q:'X  I '$P($G(^SRO(133,X,0)),"^",21) S SRCNT=SRCNT+1,SRL(SRCNT)=X
 I SRCNT=1 S SRSITE=SRL(1) G SET
 K XQUIT,DIR W ! I SRCNT>1 S DIR("?",1)="  Because there is more than one division in the SURGERY SITE PARAMETERS",DIR("?")="  file, a division must be selected."
 S DIR(0)="P^133:EM",DIR("A")="Select Division",DIR("S")="I '$P(^SRO(133,+Y,0),U,21)" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) D ^SRSKILL S XQUIT="" Q
 S SRSITE=+Y
SET ; set site parameters
 S S(0)=^SRO(133,SRSITE,0),SRSITE("AML")=$P(S(0),"^",4),SRSITE("REQ")=$P(S(0),"^",2) K:SRSITE("REQ")="" SRSITE("REQ")
 S SRSITE("IV")=$P(S(0),"^",7) K:SRSITE("IV")="" SRSITE("IV")
 S SRSITE("DIV")=$P(S(0),"^"),SRSITE("SITE")=$$GET1^DIQ(4,SRSITE("DIV"),.01)
 S SRSITE("NRPT")=$P(S(0),"^",6) I SRSITE("NRPT")="" S SRSITE("NRPT")=1
 I '$D(SRSITE("OPTION")),$D(XQY) S SRSITE("OPTION")=XQY
 K S
 Q
CPT ; display CPT copyright notice
 N SRCPT,SRDIV S (SRCPT,SRDIV)=0 F  S SRDIV=$O(^SRO(133,SRDIV)) Q:'SRDIV  I $D(^SRO(133,SRDIV,6,DT,1,DUZ)) S SRCPT=1 Q
 Q:SRCPT  D COPY^ICPTAPIU I $G(IOST)'["P-" W ! K DIR S DIR("A")="Press the 'Return' key to continue",DIR(0)="FOA" D ^DIR K DIR
 K DD,DO,DA,DIC S SRDIV=$O(^SRO(133,0))
 I '$D(^SRO(133,SRDIV,6,DT,0)) S X=DT,DA(1)=SRDIV,DIC="^SRO(133,SRDIV,6,",DIC("P")=$P(^DD(133,36,0),"^",2),DIC(0)="L",DINUM=X D FILE^DICN K DD,DO,DA,DIC I Y=-1 Q
 S X=DUZ,DA(2)=SRDIV,DA(1)=DT,DIC="^SRO(133,SRDIV,6,DT,1,",DIC("P")=$P(^DD(133.036,1,0),"^",2),DIC(0)="L",DINUM=X D FILE^DICN K DA,DD,DIC,DO
 Q
EN2 ; set view only and titles for screens
 I '$D(^XUSEC("SROEDIT",DUZ)) S Q3("VIEW")=""
 Q:'$D(SRTN)  Q:SRTN<1  S:'$D(ST) ST="SCHEDULING" S DFN=$P(^SRF(SRTN,0),"^") D DEM^VADPT S SRN=$E(VADM(1),1,20),Q3(1)="** "_ST_" **   CASE #"_SRTN_"  "_SRN_" "
 Q
DEV S SRION=$S($D(ION):ION,1:"HOME") K %ZIS S %ZIS="QN",IOP=X D ^%ZIS I POP S IOP=SRION D ^%ZIS K %ZIS,IOP,SRION,X Q
 W $S(X=$E(ION,1,$L(X)):$E(ION,$L(X)+1,$L(ION)),1:"  "_ION) S X=ION D ^%ZISC K %ZIS,SRION,IOP Q
 Q
TIME ; transform time to date of operation at that time
 I $D(SRSMED) S DA=SRTN
 S:$D(SRTN) SRTDA=DA,DA=SRTN S X=$S(X?1.4N.A!(X?1.2N1":"2N.A):Z_"@"_X,1:X)
 S %DT="EPTXR" D ^%DT S X=Y G:'$D(^SRF(DA,.2)) RESET I X>0 S SRSTART=$P(^SRF($S($D(SRTN):SRTN,1:DA),.2),"^",15) I SRSTART'="" D BEFORE
 S:$D(SRTDA) DA=SRTDA Q
BEFORE W:X<SRSTART !!,"The time entered is before the 'TIME PAT IN HOLD AREA'.  Please check the",!,"DATE/TIME entered for this field." H 2
 Q
RESET S:$D(SRTDA) DA=SRTDA Q
INPUT ; input transfor for ASA CLASS
 S:'$D(DA) DA=SRTN S SRFLD=1.13 I $D(^SRF(DA,"CON")),$P(^("CON"),"^") D ^SROCON Q
 Q
PARAM ; enter/edit site parameters
 W @IOF K DIC,DINUM S DIC=133,DIC(0)="QEAMZL",DLAYGO=133,DIC("A")="Edit Parameters for which Surgery Site: " D ^DIC K DIC I Y<0 W @IOF Q
 N SRDIV,SRN,SRNAME,SRNUM S SRDIV=+Y,SRN=+Y(0),SRNAME=Y(0,0),SRNUM=$$GET1^DIQ(4,SRN,99),Q3(1)=" "_SRNAME_"  ("_SRNUM_") "
 K DIE,DR,DA,Y S DA=SRDIV,DR="[SRPARAM]",DIE=133 D ^SRCUSS K DR,DIE,DA,ST W @IOF I $D(SRSITE) D SET
 Q
EXIT ; exit action for all Surgery options
 I $D(XQY),$G(SRSITE("OPTION"))=XQY K SRSITE,SRTN,^TMP("SRCUSS",$J)
 D CLEAR
 Q
SITE() ; extrinsic call to output Institution file pointer (from Default Institution field in file 4.3)^Institution name^Station number
 N SITE,SRI,SRX,SRY
 S SITE=$$KSP^XUPARAM("INST") I 'SITE Q SITE
 S X=SITE,DIC="^SRO(133,",DIC(0)="UBZ" D ^DIC Q:Y<0 ""
 S SRX=+Y I $P($G(^SRO(133,SRX,0)),U,21) S SITE="" D  I 'SITE Q SITE
 .S SRX=0 F  S SRX=$O(^SRO(133,SRX)) Q:SRX'>0  I $D(^(SRX,0)),'$P(^(0),U,21) S SITE=$P(^(0),U) Q
 S SRX=SITE F SRI=.01,99 S SRY=$$GET1^DIQ(4,SRX,SRI),SITE=SITE_"^"_SRY
 Q SITE
OFF1 ; compare time off with time on
 S Z=$E($P(^SRF($S($D(SRTN):SRTN,1:DA(1)),0),"^",9),1,7),X=$S(X?1.4N.A!(X?1.2N1":"2N.A):Z_"@"_X,1:X) K %DT,Z S %DT="PTXR" D ^%DT S X=Y I Y<1 D OUT Q
 S SRSTART=$P(^SRF(DA(1),SRSUB,DA,0),"^",SRP) D COMP
 Q
OFF2 ; compare time off with time on
 S Z=$E($P(^SRF($S($D(SRTN):SRTN,1:DA(2)),0),"^",9),1,7),X=$S(X?1.4N.A!(X?1.2N1":"2N.A):Z_"@"_X,1:X) K %DT,Z S %DT="PTXR" D ^%DT S X=Y I Y<1 D OUT Q
 S SRSTART=$P(^SRF(DA(2),SRSUB,DA(1),1,DA,0),"^",SRP)
COMP I X<SRSTART W !!,"Time Off should be later than Time On.",! S X=-1
OUT K %DT,SR130,SRN,SRP,SRSTART,SRSUB
 Q
TERM ; compare stop time with start time
 N SRINOR,SRSTART,SRV,SRY,T,Z
 I $D(DA) S SRINOR=$S($P($G(^SRF(DA,"NON")),"^")="Y":$P($G(^SRF(DA,"NON")),"^",4),1:$P($G(^SRF(DA,.2)),"^",10)) I 'SRINOR D  K X D OUT Q
 .D EN^DDIOL(">>> Please enter 'TIME "_$S($P($G(^SRF(DA,"NON")),"^")="Y":"PROCEDURE BEGAN",1:"PAT IN OR")_"' first !! <<<","","!!?5")
 .D EN^DDIOL("","","!")
 S Z=$E(SRINOR,1,7),X=$S(X?1.4N.A!(X?1.2N1":"2N.A):Z_"@"_X,1:X)
 K %DT,Z S %DT="PTXR" D ^%DT S X=Y I Y<1 D OUT Q
 I $D(DA) S Z=$P($G(^SRF(DA,SRN)),"^",SRP),SRSTART=$S(Z:Z,1:SRINOR),SRNULL=$S(Z:0,1:1) I X<SRSTART S Z=$P(SRINOR,"."),T=$P(X,".",2),X1=Z_"."_T,X2=1 D C^%DTC D PLUS24 I '$D(X) D OUT Q
 K %DT S %DT="EPTXR" D ^%DT S X=Y D OUT
 Q
PLUS24 S:SRNULL SR130="TIME PAT IN OR" S (SRV,Y)=X X ^DD("DD") S SRY=Y
 N DIR S DIR("A",1)="",DIR("A",2)="The time you have entered is earlier than "_SR130_".",DIR("A")="Do you mean "_SRY_" (Y/N) ? ",DIR(0)="YA" D ^DIR K DIR I 'Y!$D(DTOUT)!$D(DUOUT) K X Q
 S X=SRV
 Q
CLEAR ; clean-up case edit/lock flags in ^XTMP
 N SRC,SRJ,SRL,SRNOW,SRNOW1,SRZ S SRNOW=$$NOW^XLFDT
 S SRC="SRLOCK-0" F  S SRC=$O(^XTMP(SRC)) Q:SRC'["SRLOCK-"  D
 .S SRJ=0 F  S SRJ=$O(^XTMP(SRC,DUZ,SRJ)) Q:'SRJ  D
 ..I SRJ=$J L -^XTMP(SRC,DUZ,SRJ) K ^XTMP(SRC,DUZ,SRJ) I '$O(^XTMP(SRC,0)) L -^XTMP(SRC) K ^XTMP(SRC) Q
 ..S SRNOW1=$P($G(^XTMP(SRC,0)),"^") I SRNOW>SRNOW1 L -^XTMP(SRC) K ^XTMP(SRC)
 Q
EN3 ; the Sterility Expiration Date should be after the Date of Operation
 S:$D(SRTN) SRTDA=DA,DA=SRTN S X=$S(X?1.4N.A!(X?1.2N1":"2N.A):Z_"@"_X,1:X)
 S %DT="E" D ^%DT S X=Y I X>0 S SRSTART=$E($P(^SRF($S($D(SRTN):SRTN,1:D0),0),U,9),1,7) I SRSTART'="" D BEF
 S:$D(SRTDA) DA=SRTDA Q
BEF I X<SRSTART W !!,"The date entered is before the 'DATE OF OPERATION'.  Please check the",!,"DATE entered for this field." K X H 2
 Q
