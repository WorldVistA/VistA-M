PSORXRP2 ;BIR/SAB-main menu entry reprint of a Rx label ;10/5/07 7:45am
 ;;7.0;OUTPATIENT PHARMACY;**11,27,120,138,135,156,185,280,251,367**;DEC 1997;Build 62
 ;External references PSOL and PSOUL^PSSLOCK supported by DBIA 2789
 ;External reference ^PS(55 supported by DBIA 2228
 ;External reference to ^PSDRUG supported by DBIA 221
 I '$D(PSOPAR) D ^PSOLSET I '$D(PSOPAR) G KILL
LRP N PSODISP,PSOMGREP
 K REPRINT W !! S DIC("S")="I $P($G(^(0)),""^"",2),$D(^(""STA"")),$P($G(^(""STA"")),""^"")<10",DIC="^PSRX(",DIC("A")="Reprint Prescription Label: ",DIC(0)="QEAZ" D ^DIC K P,DIC("A") I Y<0!("^"[X) K PCOM,PCOMX G KILL
 S (PPL,DA,RX,PSORPRX)=+Y,PDA=Y(0),RXF=0,ZD(DA)=DT,REPRINT=1,STA=+$G(^PSRX(+Y,"STA"))
 D PSOL^PSSLOCK(PSORPRX) I '$G(PSOMSG) W !!,$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing this order."),! K PSOMSG G LRP
 I $P(^PSRX(RX,"STA"),"^")=14 W $C(7),!,"Cannot Reprint! Discontinued by Provider." D ULR,KILL Q
 I $P(^PSRX(RX,"STA"),"^")=15 W $C(7),!,"Cannot Reprint! Discontinued due to editing." D ULR,KILL Q
 I $P(^PSRX(RX,"STA"),"^")=16 W $C(7),!,"Cannot Reprint! Placed on HOLD by Provider." D ULR,KILL Q
 I DT>$P(^PSRX(RX,2),"^",6) D  D ULR,KILL G LRP
 .W !,$C(7),"Medication Expired on "_$E($P(^PSRX(RX,2),"^",6),4,5)_"-"_$E($P(^(2),"^",6),6,7)_"-"_$E($P(^(2),"^",6),2,3) I $P(^PSRX(DA,"STA"),"^")<11 S $P(^PSRX(DA,"STA"),"^")=11 D
 ..S COMM="Medication Expired on "_$E($P(^PSRX(RX,2),"^",6),4,5)_"-"_$E($P(^(2),"^",6),6,7)_"-"_$E($P(^(2),"^",6),2,3) D EN^PSOHLSN1(DA,"SC","ZE",COMM) K COMM
 S DFN=$P(PDA,"^",2) D DEM^VADPT I $P(VADM(6),"^",2)]"" D  G LRP
 .W $C(7),!!,$P(^DPT($P(PDA,"^",2),0),"^")_" Died "_$P(VADM(6),"^",2)_".",!
 .S $P(^PSRX(RX,"STA"),"^")=12,PCOM="Patient Expired "_$P(VADM(6),"^",2),ST="C" D EN^PSOHLSN1(RX,"OD","",PCOM,"A")
 .D ACT1,ULR,KILL
 S X=$O(^PS(52.5,"B",DA,0)) I X,'$G(^PS(52.5,X,"P")) W !,$C(7),"Rx may NOT be printed using this option, use SUSPENSE FUNCTIONS Options." K X D ULR,KILL G LRP
 I $G(X)'>0 G GOOD
 S XX=$P($G(^PS(52.5,X,0)),U,7) I $G(XX)']"" G GOOD
 I $G(XX)="Q" W !,"RX CAN NOT BE PRINTED using this option, use SUSPENSE FUNCTIONS Options." K X,XX D ULR,KILL G LRP
 I $G(XX)="L" W !,"RX is being transmitted to the CMOP and can not be reprinted now." K X,XX D ULR,KILL G LRP
GOOD K X
 I $D(^PS(52.4,DA)) W !,"Prescription is Non-Verified",!! D ULR,KILL G LRP
 S DFN=$P(^PSRX(DA,0),"^",2) I $D(^PS(52.4,"AREF",DFN,DA)) W !,"Prescription is waiting for others to be verified",!! D ULR,KILL G LRP
 I $G(PSODIV),$D(^PSRX(DA,2)),+$P(^(2),"^",9),+$P(^(2),"^",9)'=PSOSITE S PSPOP=0,PSPRXN=DA D CHK1^PSOUTLA I PSPOP D ULR,KILL G LRP
 I STA=3 W !?3,"Prescription is on Hold" D ULR,KILL G LRP
 I STA=4 W !?3,"Prescription is Pending Due to Drug Interactions" D ULR,KILL G LRP
 I STA=12 W !?3,"Prescription is Discontinued" D ULR,KILL G LRP
 I $G(^PS(55,"ASTALK",DFN)) W !,"Patient is a ScripTalk patient. Use ScripTalk label for prescription bottle.",!
 D ICN^PSODPT(DFN)
 S COPIES=$S($P(PDA,"^",18)]"":$P(PDA,"^",18),1:1)
 K DIR S DIR("A")="Number of Copies? ",DIR("B")=COPIES,DIR(0)="N^1:99:0",DIR("?")="Enter the number of copies you want (1 TO 99)"
 D ^DIR K DIR I $D(DIRUT) D ULR,KILL G LRP
 S COPIES=Y
 K DIR S DIR("A")="Print adhesive portion of label only? ",DIR(0)="Y",DIR("B")="No",DIR("?",1)="If entire label, including trailers are to print press RETURN for default."
 S DIR("?")="Else if only bottle and mailing labels are to print enter Y or YES." D ^DIR K DIR I $D(DUOUT) D ULR,KILL G LRP
 I $D(DIRUT) D ULR G KILL
 S SIDE=Y
 I $P(PSOPAR,"^",30),$$GET1^DIQ(59,PSOSITE_",",105,"I")=2.4 D
 .I $S($P(PSOPAR,"^",30)=3:1,$P(PSOPAR,"^",30)=4:1,1:0),'$$GET1^DIQ(50,$P(PDA,"^",6),28,"I") Q
 .K DIR,DIRUT S DIR("A")="Do you want to resend to Dispensing System Device",DIR(0)="Y",DIR("B")="No" D ^DIR K DIR Q:$D(DIRUT)  S PSODISP=$S(Y:0,1:1)
 I $D(DIRUT) D ULR,KILL G LRP
 ;
 ; FDA Medication Guide Reprint
 I $$GET1^DIQ(59,PSOSITE,134)'="",$$MGONFILE^PSOFDAUT(DA) D  I $D(DIRUT) D ULR,KILL G LRP
 . K DIR,DIRUT S DIR("A")="Reprint the FDA Medication Guide",DIR(0)="Y",DIR("B")="No"
 . D ^DIR K DIR Q:$D(DIRUT)  S PSOMGREP=Y
 ; 
 D ACT I $D(DIRUT) D ULR,KILL G LRP
 I $D(PCOM) D ULR,KILL G LRP
 F I=1,2,4,6,7,9,13,16 S P(I)=$P(PDA,"^",I)
 S P(6)=+P(6) I $D(^PSRX(DA,"TN")),^("TN")]"" S P(6)=^("TN")
 W !!,"Rx # "_P(1),?23,$E(P(13),4,5)_"/"_$E(P(13),6,7)_"/"_$E(P(13),2,3),!,$S($D(^DPT(+P(2),0)):$P(^(0),"^"),1:"Not on File"),?30,"#"_P(7),!
 I $P($G(^PSRX(DA,"SIG")),"^",2) S D=0 D  K D,FSIG
 .D FSIG^PSOUTLA("R",DA,75) F  S D=$O(FSIG(D)) W !,FSIG(D) Q:'$O(FSIG(D))
 E  D EN3^PSOUTLA1(DA,75) S D=0 F  S D=$O(BSIG(D)) W !,BSIG(D) Q:'$O(BSIG(D))
 K D,BSIG
 ;PSO*7*280 If Trade name, don't lookup in ^PSDRUG
 W !!,$S($G(^PSRX(DA,"TN"))]"":P(6),(P(6)=+P(6))&$D(^PSDRUG(P(6),0)):$P(^(0),"^"),1:P(6)),! S PHYS=$S($D(^VA(200,+P(4),0)):$P(^(0),"^"),1:"Unknown") W PHYS K PHYS
 W ?25,$S($D(^VA(200,+P(16),0)):$P(^(0),"^"),1:"Unknown"),!,"# of Refills: "_$G(P(9))
 I $G(RX) D
 .S RXRP(RX)=1_"^"_COPIES_"^"_SIDE
 .I $G(PSOMGREP)=1 S RXRP(RX,"MG")=1
 .I $G(PSODISP)=1 S RXRP(RX,"RP")=1
 .S RXFL(RX)=0 F ZZZ=0:0 S ZZZ=$O(^PSRX(RX,1,ZZZ)) Q:'ZZZ  S RXFL(RX)=ZZZ
 D @$S($P($G(PSOPAR),"^",26):"^PSORXL",1:"Q^PSORXL") K PSPOP,PPL,COPIES,SIDE,REPRINT,PCOM,IOP,PSL,PSNP,ZZZ,RXFL(+$G(RX)) D ULR,KILL G LRP
 ;
ACT K DIR S DIR("A")="Comments: ",DIR(0)="FA^5:60",DIR("?")="5-60 characters input required for activity log." S:$G(PCOMX)]"" DIR("B")=$G(PCOMX)
 D ^DIR K DIR Q:$D(DIRUT)!($D(DIROUT))  S (PCOM,PCOMX)=X
 I '$D(PSOCLC) S PSOCLC=DUZ
ACT1 S RXF=0 F J=0:0 S J=$O(^PSRX(DA,1,J)) Q:'J  S RXF=J S:J>5 RXF=J+1
 S IR=0 F J=0:0 S J=$O(^PSRX(DA,"A",J)) Q:'J  S IR=J
 S IR=IR+1,^PSRX(DA,"A",0)="^52.3DA^"_IR_"^"_IR
 D NOW^%DTC S ^PSRX(DA,"A",IR,0)=%_"^"_$S($G(ST)'="C":"W",1:"C")_"^"_DUZ_"^"_RXF_"^"_PCOM_$S($G(ST)'="C":" ("_COPIES_" COPIES)",1:""),PCOMX=PCOM K PC,IR,PS,PCOM,XX,%,%H,%I,RXF
 S:$P(^PSRX(DA,2),"^",15)&($G(ST)'="C") $P(^PSRX(DA,2),"^",14)=1
 Q
 ;
KILL K %,DIR,DUOUT,DTOUT,DIROUT,DIRUT,C,DA,DIC,I,J,JJJ,K,RX,RXF,X,Y,Z,ZD,DFN,P,PDA,PSPRXN,COPIES,SIDE,PPL,REPRINT,PSXSTAT,PSORPRX,PSOMSG D KVA^VADPT Q
 ;
ULR ;
 I $G(PSORPRX) D PSOUL^PSSLOCK(PSORPRX)
 Q
