DGOVBC1 ;ALB/MRL - VBC OUTPUT ; 12 FEB 87
 ;;5.3;Registration;**162,489**;Aug 13, 1993
 N VAPA
 K DGLN S $P(DGLN," ",80)="",DGU="UNKNOWN",DGPP=""
 F DGPP1=0:0 S DGPP=$O(^UTILITY($J,"DGOVBC",DGPP)) Q:(DGPP="")!($G(ZTSTOP)=1)  S DFN=^UTILITY($J,"DGOVBC",DGPP) D DIS,ENDREP^DGUTL
Q K DGCA,I,DGX,X,Y,%DT,DGFR,DGHD,DGHD1,DGHOW,DGIOM,DGLIN,DGLN,DGPP,DGPP1,DGTO,DGU,DGVAR,DIC,DFN,DGCT,DGDFN,DGP,DGPGM,ZTSTOP,^UTILITY($J,"DGOVBC") D CLOSE^DGUTQ Q
 G Q^DGOVBC2
DIS I $$FIRST^DGUTL Q
 D NOW^%DTC S Y=$E(%,1,12) W !,"VETERANS ASSISTANCE UNIT RECORD",?53,"PRINTED: ",$$FMTE^XLFDT(Y,1),?DGHD1,DGHD,!,DGLIN,! K Y
 D DEM^VADPT D L W !,"1. Patient Name:  ",$S(VADM(1)]"":VADM(1),1:"UNSPECIFIED PATIENT #"_DFN),?55,"| 2. DOB: ",$P(VADM(3),"^",2)
 D PID^VADPT6 W ?80,"| 3. PT ID: ",$S(VA("PID"):VA("PID"),1:DGU),?106,"| 4. Claim #: " S DGMS=$S(VADM(10):$P(VADM(10),"^",2),1:DGU) K VA,VADM D ELIG^VADPT W $S(VAEL(7):VAEL(7),1:DGU),! S DGSC=+VAEL(3),DGMT=$P(VAEL(9),"^",2) K VAEL
 W "_______________________________________________________|________________________|_________________________|_______________________"
 D ADD^VADPT,A W !,"5. Address Information [Street, City, State, Zip Code]:" F I=0:0 S I=$O(DGA(I)) Q:'I  W:I>1 ! W ?57,DGA(I),!
 I VAPA(12)=1 D
 .D L
 .D AC W !,"5A. Confidential Address Information [Street, City, State, Zip Code]:" F I=0:0 S I=$O(DGA(I)) Q:'I  W:I>1 ! W ?57,DGA(I)
 K DGA W ! D SVC^VADPT,L W !,"6. Service Record",?35,"Service #",?55,"Entry Date",?75,"Separation Date",?108,"Discharge Type"
 W $C(13),"   ","______________",$E(DGLN,1,18),"_________",$E(DGLN,1,11),"__________",$E(DGLN,1,10),"_______________",$E(DGLN,1,18),"______________" S DGPOW=VASV(4)
 F I=6:1:8 I VASV(I) W !?3,$S(VASV(I,1):$P(VASV(I,1),"^",2),1:DGU),?35,$S($L(VASV(I,2)):VASV(I,2),1:DGU),?55,$S('VASV(I,4):DGU,1:$P(VASV(I,4),"^",2)),?75,$S('VASV(I,5):DGU,1:$P(VASV(I,5),"^",2)),?108,$S(VASV(I,3):$P(VASV(I,3),"^",2),1:DGU)
 K VASV W ! D L S DGCT=0 F I=0:0 S I=$O(^DGPM("ATID1",DFN,I)) Q:'I!(DGCT=2)  F DGCA=0:0 S DGCA=$O(^DGPM("ATID1",DFN,I,DGCA)) Q:'DGCA!(DGCT=2)  I $D(^DGPM(DGCA,0)) S DGCT=DGCT+1,DGADM(DGCT)=^(0),DGADM(DGCT,4)=$P(^(0),"^",12)
 S DGSCOND=0 W !,"7.  Admission Date" I 'DGCT W ":  NO ADMISSIONS ON FILE FOR THIS APPLICANT." G ^DGOVBC2
 W ?20,"Admission Type",?55,"Ward",?70,"Admitting Diagnosis",?105,"Admission Authority"
 W $C(13),"    ","______________","  ","______________",$E(DGLN,1,21),"____",$E(DGLN,1,11),"___________________",$E(DGLN,1,16),"___________________"
 F I=1:1:DGCT S DGD=DGADM(I),DGD1=DGADM(I,4) D AS W !?3,DGD(1),?20,DGD(2),?55,$E(DGD(3),1,10),?70,DGD(4),?105,$E(DGD(5),1,25)
 D H^DGUTL S DGT=DGTIME K DGTIME D ^DGINPW W !?4,"NOTE:  ",$S('DG1:"NOT CURRENTLY AN INPATIENT.",1:$S($D(^DIC(42,+DG1,0)):"CURRENTLY AN INPATIENT ON WARD '"_$P(^(0),"^",1)_"'."),1:"INPATIENT ON UNKNOWN WARD.")
 I DGSCOND W !?4,"NOTE:  Asterisk [*] indicates admission for Service Connected Condition."
 K DGSCOND G ^DGOVBC2
L F DGL=1:1:$S($D(IOM):(IOM-2),1:130) W "_"
 Q
PT F I=0,.11,.15,.3,.31,.32,.36,.361,.362,.52,"VET" S DGP(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 S DGSC=$S($P(DGP(.3),"^",1)="Y":1,1:0) Q
A S DGA=1 F I=1:1:3 Q:'$L(VAPA(I))  S:I=3 DGA(2)=DGA(2)_", "_VAPA(I) S:DGA<3 DGA(I)=VAPA(I),DGA=DGA+1
 I VAPA(1)']"" S DGA(1)="STREET ADDRESS UNKNOWN",DGA=2
 S DGA(DGA)=$S($L(VAPA(4))&(VAPA(5)):VAPA(4)_", "_$P(VAPA(5),"^",2),$L(VAPA(4)):VAPA(4),VAPA(5):$P(VAPA(5),"^",2),1:"CITY STATE UNKNOWN")
 S:$L(DGA(DGA)) DGA(DGA)=DGA(DGA)_"  "_VAPA(6)
 I VAPA(12)=0 K I,J
 Q
AC ;Formatting Confidential Address Information
 K DGA
 I VAPA(12)=1 D
 .N DGASEQ,SEQ
 .S DGA=13 F I=13:1:15 Q:'$L(VAPA(I))  S:I=15 DGA(14)=DGA(14)_", "_VAPA(I) S:DGA<15 DGA(I)=VAPA(I),DGA=DGA+1
 .S DGA(19)="______________________________________________"
 .S DGA(20)="Confidential Start Date: "_$P(VAPA(20),"^",2)
 .S DGA(21)="Confidential End Date: "_$P(VAPA(21),"^",2)
 .S DGA(22)="Confidential Address Categories:"
 .S SEQ="",DGASEQ=23 F  S SEQ=$O(VAPA(22,SEQ)) Q:SEQ=""  D
 ..I $P(VAPA(22,SEQ),"^",3)="Y" S DGA(DGASEQ)=$P(VAPA(22,SEQ),"^",2),DGASEQ=DGASEQ+1
 .I VAPA(13)']"" S DGA(1)="STREET ADDRESS UNKNOWN",DGA=2
 .S DGA(DGA)=$S($L(VAPA(16))&(VAPA(17)):VAPA(16)_", "_$P(VAPA(17),"^",2),$L(VAPA(16)):VAPA(16),VAPA(17):$P(VAPA(17),"^",2),1:"CITY STATE UNKNOWN")
 .S:$L(DGA(DGA)) DGA(DGA)=DGA(DGA)_"  "_$P(VAPA(18),"^",2)
 K I,VAPA Q
 Q
AS S Y=$P(DGD,"^",1),Y=$P(Y,".",1) X ^DD("DD") S:$P(DGD,"^",11) DGSCOND=1 S DGD(1)=$S($P(DGD,"^",11):"*",1:" ")_Y,DGD(2)=$S($D(^DG(405.2,+$P(DGD,"^",18),0)):$P(^(0),"^",1),1:DGU)
 S DGD(3)=$S($D(^DIC(42,+$P(DGD,"^",6),0)):$P(^(0),"^",1),1:DGU)
 S DGD(4)=$S($P(DGD,"^",10)]"":$E($P(DGD,"^",10),1,30),1:"ADMITTING DIAGNOSIS UNSPECIFIED"),DGD(5)=$S($D(^DIC(43.4,+$P(DGADM(I,4),"^",1),0)):$P(^(0),"^",1),1:DGU) Q
