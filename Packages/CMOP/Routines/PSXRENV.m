PSXRENV ;BIR/BAB-CMOP Pre-Initialization ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
START I ^XMB("NETNAME")?1"CMOP-".E S XPDQUIT=1 Q
 S XQABT1=$H
 I ^XMB("NETNAME")'?1"CMOP-".E W !!,"Consolidated Mail Outpatient Pharmacy Install for Remote Medical Center.",!!
DUZ S PSXDZ=$S(('($D(DUZ)#2)):1,'$D(^VA(200,DUZ,0)):1,'$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) I PSXDZ=1 W !!,"You must be a valid user and ",!,"DUZ(0) must be set to the ""@"" sign!!",!! S XPDABORT=2 Q
CKDT I '$D(DT) S %DT="",X="T" D ^%DT S DT=Y
 I ($G(^PSX(550,0))["CMOP SYSTEM^550I")&($P($G(^PSX(550,0)),"^",3)>0) G CKU
 I XPDENV=0 G CKU
 W !!,"This install of the Consolidated Mail Outpatient Pharmacy",!,"software at your medical center requires that you select the CMOP Host",!,"Facility which will be receiving your Outpatient Pharmacy prescription data.",!!
 S DIR(0)="SX^B:BEDFORD;D:DALLAS;L:LEAVENWORTH;W:WEST LA;M:MURFREESBORO;H:HINES",DIR("A")="Select the CMOP to RECEIVE YOUR DATA " D ^DIR K DIR
 I "BDLWMH"'[$E(X) S XPDABORT=2 Q
 S ^TMP("PSXCMOP",$J)="CMOP-"_$S($E(X)="L":"LEAV",$E(X)="B":"BED",$E(X)="D":"DAL",$E(X)="W":"WLA",$E(X)="M":"MURF",$E(X)="H":"HINES")_".MED.VA.GOV"
 D BMES^XPDUTL("You have chosen "_Y(0)_" CMOP to receive your transmissions.")
 I '$O(^DIC(4.2,"B",^TMP("PSXCMOP",$J),0)) D BMES^XPDUTL("There is no Mailmain Domain entry for "_Y(0)_". Please add this domain to   your system and re-run the CMOP installation. Discontinuing installation....") S XPDABORT=2 Q
CKU S PSX=0 I $D(DUZ),DUZ(0)="@",$D(DT),$D(U),PSXDZ=0 D RXC G QUIT:ERROR D ENV G DONE
QUIT ;
 S XPDABORT=2 I $G(ERROR)=1 K PSX,PSXDZ,ERROR Q
DONE I $G(PSXDZ)=0,HOST=0,OP=1,NDF=1,KNL=1 S PSX=1
 S:ERROR=1 PSX=0 K ERROR
 I PSX=0 S XPDABORT=2 W !,"INITIALIZATION ABORTED"
 K PSX,PKG,KNL,NDF,OP,HOST,PSXDZ,ERROR
 S (XQABT2,XQABT3)=$H
 S XPDQUIT("CMOPH 2.0T5")=1
 Q
ENV ;
 S (HOST,OP,NDF,KNL)=0
 I $D(^DIC(9.4,"B","OUTPATIENT PHARMACY")) S PKG=$O(^DIC(9.4,"B","OUTPATIENT PHARMACY",0)) I $G(^DIC(9.4,+PKG,"VERSION"))'<"6.0" S OP=1
 I OP'=1,(^XMB("NETNAME")'?1"CMOP-".E) W !,"Outpatient Pharmacy Version 6.0 (or greater) not found.  This version is required to continue CMOP installation."
 I $D(^DIC(9.4,"B","KERNEL")) S PKG=$O(^DIC(9.4,"B","KERNEL",0)) I $G(^DIC(9.4,+PKG,"VERSION"))'<"8.0" S KNL=1
 I KNL'=1 W !,"Kernel Version 8.0 (or greater) not found.  This version is required to continue CMOP installation."
 I $D(^DIC(9.4,"B","NATIONAL DRUG FILE")) S PKG=$O(^DIC(9.4,"B","NATIONAL DRUG FILE",0)) I $G(^DIC(9.4,+PKG,"VERSION"))'<"3.16" S NDF=1
 I NDF'=1 W !,"National Drug File Version 3.16 (or greater) not found.  This version is required to continue CMOP installation."
 Q
RXC ;
 W !!,"Validating required RX CONSULT FILE entries......"
 I $G(^DIC(54,0,"GL"))'["^PS(54," W !!,"You must have Outpatient Pharmacy patch PSO*6*148 installed before installing CMOP Software.",!,"...INITIALIZATION ABORTED!",!! S ERROR=1 Q
 S (ERROR,RXC)=0 I '$D(^PS(54)) W !!,"You do not have an RX CONSULT FILE........INITIALIZATION ABORTED!",!! S ERROR=1 Q
 F XC=1:1:20 S YC=$P($T(CON+XC),";;",2) I $P(^PS(54,XC,0),"^")'=YC S ERROR=1 W !,"Your RX CONSULT File entry # "_$G(XC)_" is invalid.!!"
 W:ERROR=1 !!,"INITIALIZATION ABORTED!",!! K RXC,XC,YC
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
