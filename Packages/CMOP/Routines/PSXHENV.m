PSXHENV ;BIR/BAB-CMOP Environment Check-HOST ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
START I ^XMB("NETNAME")'["CMOP-" S XPDQUIT=1 Q
 S XQABT1=$H
 S ERROR=0
 I ^XMB("NETNAME")?1"CMOP-".E W !!,"Consolidated Mail Outpatient Pharmacy Install for Host Facility.",!!
 E  S XPDABORT=2 Q
DUZ S PSXDZ=$S(('($D(DUZ)#2)):1,'$D(^VA(200,DUZ,0)):1,'$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) I PSXDZ=1 W !!,"You must be a valid user and ",!,"DUZ(0) must be set to the ""@"" sign!!",!! S XPDABORT=2 Q
CKDT I '$D(DT) S %DT="",X="T" D ^%DT S DT=Y
CKU S PSX=0 I $D(DUZ),DUZ(0)="@",$D(DT),$D(U),PSXDZ=0 G QUIT:$G(ERROR) D ENV G DONE
QUIT ;
 S XPDABORT=2 I $G(ERROR)=1 K PSX,PSXDZ,ERROR Q
DONE I $G(PSXDZ)=0,HOST=1,OP=0,NDF=1,KNL=1 S PSX=1
 I $G(PSXDZ)=0,HOST=0,OP=1,NDF=1,KNL=1 S PSX=1
 S:ERROR=1 PSX=0 K ERROR
 I PSX=0 S XPDABORT=2 W !,"INITIALIZATION ABORTED"
 K PSX,PKG,KNL,NDF,OP,HOST,PSXDZ,ERROR
 S (XQABT2,XQABT3)=$H
 Q
ENV ;
 S (HOST,OP,NDF,KNL)=0
 S:^XMB("NETNAME")?1"CMOP-".E HOST=1
 ;I $D(^DIC(9.4,"B","OUTPATIENT PHARMACY")) S PKG=$O(^DIC(9.4,"B","OUTPATIENT PHARMACY",0)) I $G(^DIC(9.4,+PKG,"VERSION"))'<"6.0" S OP=1
 ;I OP'=1,(^XMB("NETNAME")'?1"CMOP-".E) W !,"Outpatient Pharmacy Version 6.0 (or greater) not found.  This version is required to continue CMOP installation."
 I $D(^DIC(9.4,"B","KERNEL")) S PKG=$O(^DIC(9.4,"B","KERNEL",0)) I $G(^DIC(9.4,+PKG,"VERSION"))'<"8.0" S KNL=1
 I KNL'=1 W !,"Kernel Version 8.0 (or greater) not found.  This version is required to continue CMOP installation."
 I $D(^DIC(9.4,"B","NATIONAL DRUG FILE")) S PKG=$O(^DIC(9.4,"B","NATIONAL DRUG FILE",0)) I $G(^DIC(9.4,+PKG,"VERSION"))'<"3.16" S NDF=1
 I NDF'=1 W !,"National Drug File Version 3.16 (or greater) not found.  This version is required to continue CMOP installation."
 Q
