PSXPRE ;BIR/BAB-CMOP Pre-Initialization ;[ 02/22/96  1:09 PM ]
 ;;1.0;CONSOLIDATED MAIL OUTPATIENT PHARMACY;**3**;10 May 95
START S XQABT1=$H
 I ^XMB("NETNAME")?1"CMOP-".E W !!,"Consolidated Mail Outpatient Pharmacy Install for Host Facility.",!!
 I ^XMB("NETNAME")'?1"CMOP-".E W !!,"Consolidated Mail Outpatient Pharmacy Install for Remote Medical Center.",!!
DUZ S PSXDZ=$S(('($D(DUZ)#2)):1,'$D(^VA(200,DUZ,0)):1,'$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) I PSXDZ=1 W !!,"You must be a valid user and ",!,"DUZ(0) must be set to the ""@"" sign!!",!! K DIFQ Q
CKDT I '$D(DT) S %DT="",X="T" D ^%DT S DT=Y
ASK I ^XMB("NETNAME")?1"CMOP-".E G CKU
 I ($G(^PSX(550,0))["CMOP SYSTEM^550I")&($P($G(^PSX(550,0)),"^",3)>0) G CKU
 W !!,*7,"This install of the Consolidated Mail Outpatient Pharmacy",!,"software at your medical center requires that you select the CMOP Host",!,"Facility which will be receiving your Outpatient Pharmacy prescription data.",!!
 S DIR(0)="SX^B:BEDFORD;D:DALLAS;L:LEAVENWORTH;W:WEST LA",DIR("A")="Select the CMOP to RECEIVE YOUR DATA " D ^DIR K DIR
 I "BDLW"'[$E(X) K DIFQ Q
 S ^TMP("PSXCMOP",$J)="CMOP-"_$S($E(X)="L":"LEAV",$E(X)="B":"BED",$E(X)="D":"DAL",$E(X)="W":"WLA")_".MED.VA.GOV"
CKU S PSX=0 I $D(DUZ),DUZ(0)="@",$D(DT),$D(U),PSXDZ=0 D RXC G QUIT:ERROR D ENV G DONE
QUIT ;
 K DIFQ I $G(ERROR)=1 K PSX,PSXDZ,ERROR Q
DONE I $G(PSXDZ)=0,HOST=1,OP=0,NDF=1,KNL=1 S PSX=1
 I $G(PSXDZ)=0,HOST=0,OP=1,NDF=1,KNL=1 S PSX=1
 S:ERROR=1 PSX=0 K ERROR
 K:PSX=0 DIFQ
 K PSX,PKG,KNL,NDF,OP,HOST,PSXDZ,ERROR
 S (XQABT2,XQABT3)=$H
 Q
ENV ;
 S (HOST,OP,NDF,KNL)=0
 S:^XMB("NETNAME")?1"CMOP-".E HOST=1
 I $D(^DIC(9.4,"B","OUTPATIENT PHARMACY")) S PKG=$O(^DIC(9.4,"B","OUTPATIENT PHARMACY",0)) S:$G(^DIC(9.4,+PKG,"VERSION"))="6.0" OP=1
 I $D(^DIC(9.4,"B","KERNEL")) S PKG=$O(^DIC(9.4,"B","KERNEL",0)) S:$G(^DIC(9.4,+PKG,"VERSION"))'<7.1 KNL=1
 I $D(^DIC(9.4,"B","NATIONAL DRUG FILE")) S PKG=$O(^DIC(9.4,"B","NATIONAL DRUG FILE",0)) S:$G(^DIC(9.4,+PKG,"VERSION"))["3.1" NDF=1
 Q
RXC ;
 I $P(^XMB("NETNAME"),"-")="CMOP" S ERROR=0 Q
 W !!,"Validating required RX CONSULT FILE entries......"
 I $G(^DIC(54,0,"GL"))'["^PS(54," W !!,"You must have Outpatient Pharmacy patch PSO*6*148 installed before installing CMOP Software.",!,"...INITIALIZATION ABORTED!",!! S ERROR=1 Q
 K ^TMP("PSXDIC",$J),^TMP("PSXDD",$J),^TMP("PSXPS",$J)
 S (ERROR,RXC)=0 I '$D(^PS(54)) W !!,"You do not have an RX CONSULT FILE........INITIALIZATION ABORTED!",!! S ERROR=1 Q
 F X=1:1:20 S Y=$P($T(CON+X),";;",2) I $P(^PS(54,X,0),"^")'=Y S ERROR=1 W !,"Your RX CONSULT File entry # "_X_" is invalid.!!"
 W:ERROR=1 !!,"INITIALIZATION ABORTED!",!! K RXC,X,Y
 N %X,%Y S %X="^DIC(54,",%Y="^TMP(""PSXDIC"",$J," D %XY^%RCR
 N %X,%Y S %X="^DD(54,",%Y="^TMP(""PSXDD"",$J," D %XY^%RCR
 N %X,%Y S %X="^PS(54,",%Y="^TMP(""PSXPS"",$J," D %XY^%RCR
 Q
CON ;
 ;;DROWSINESS
 ;;FINISH
 ;;EMPTY STOMACH
 ;;NO DAIRY PRODUCTS
 ;;WATER
 ;;DISCOLORATION
 ;;DIURETIC K
 ;;NO ALCOHOL
 ;;ADVICE
 ;;WITH FOOD
 ;;SUNLIGHT
 ;;SHAKE WELL
 ;;EXTERNAL
 ;;STRENGTH
 ;;REFRIGERATE
 ;;DUPLICATE
 ;;EXPIRATION DATE
 ;;NO REFILL
 ;;SAME DRUG
 ;;NO TRANSFER
