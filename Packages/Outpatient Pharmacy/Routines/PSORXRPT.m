PSORXRPT ;BIR/SAB-reprint of a prescription label ;9/20/07 9:40am
 ;;7.0;OUTPATIENT PHARMACY;**3,21,27,34,120,138,156,148,280**;DEC 1997;Build 5
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External references PSOL and PSOUL^PSSLOCK supported by DBIA 2789
BCK I $G(PSOBEDT) W $C(7),$C(7) S VALMSG="Invalid Action at this time !",VALMBCK="" Q
 N PSODISP S PSORPLRX=$P(PSOLST(ORN),"^",2)
 I $$LMREJ^PSOREJU1(PSORPLRX,,.VALMSG,.VALMBCK) Q
 D PSOL^PSSLOCK(PSORPLRX) I '$G(PSOMSG) S VALMSG=$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing this order."),VALMBCK="" K PSOMSG Q
 I $G(POERR) K QFLG D  I $G(QFLG) D ULR G KILL
 .D FULL^VALM1 S X=$P(^PSRX($P(PSOLST(ORN),"^",2),0),"^"),Y=$P(PSOLST(ORN),"^",2)_"^"_X,Y(0)=$G(^PSRX($P(PSOLST(ORN),"^",2),0))
 .I $D(RXPR($P(PSOLST(ORN),"^",2))) S VALMBCK="",VALMSG="A Partial Rx has been requested!",QFLG=1 Q
 .I $D(RXRP($P(PSOLST(ORN),"^",2))) S VALMBCK="",VALMSG="A Reprint Label has been requested!",QFLG=1 Q
 .I $D(RXRS($P(PSOLST(ORN),"^",2))) S VALMBCK="",VALMSG="Rx is being pulled from suspense!",QFLG=1 Q
 .S RX=$P(PSOLST(ORN),"^",2) D VALID^PSORXRP1 S:$G(QFLG) VALMBCK="",VALMSG="A New Label has been requested already!"
 S (PPL,DA,RX)=+Y,PDA=Y(0),RXF=0,ZD(DA)=DT,REPRINT=1,STA=+$G(^PSRX(+Y,"STA"))
 I $P(^PSRX(RX,"STA"),"^")=14 S VALMBCK="",VALMSG="Cannot Reprint! Discontinued by Provider.",QFLG=1 D ULR,KILL Q
 I $P(^PSRX(RX,"STA"),"^")=15 S VALMBCK="",VALMSG="Cannot Reprint! Discontinued due to editing.",QFLG=1 D ULR,KILL Q
 I $P(^PSRX(RX,"STA"),"^")=16 S VALMBCK="",VALMSG="Cannot Reprint! Placed on HOLD by Provider.",QFLG=1 D ULR,KILL Q
 I DT>$P(^PSRX(RX,2),"^",6) D  G PAUSE
 .W !,$C(7),"Medication Expired on "_$E($P(^PSRX(RX,2),"^",6),4,5)_"-"_$E($P(^(2),"^",6),6,7)_"-"_$E($P(^(2),"^",6),2,3) I $P(^PSRX(DA,"STA"),"^")<11 S $P(^PSRX(DA,"STA"),"^")=11 D
 ..S COMM="Medication Expired on "_$E($P(^PSRX(RX,2),"^",6),4,5)_"-"_$E($P(^(2),"^",6),6,7)_"-"_$E($P(^(2),"^",6),2,3) D EN^PSOHLSN1(DA,"SC","ZE",COMM) K COMM
 S DFN=$P(PDA,"^",2) D DEM^VADPT I $P(VADM(6),"^",2)]"" D  G PAUSE
 .W $C(7),!!,$P(^DPT($P(PDA,"^",2),0),"^")_" Died "_$P(VADM(6),"^",2)_".",!
 .S $P(^PSRX(RX,"STA"),"^")=12,PCOM="Patient Expired "_$P(VADM(6),"^",2),ST="C" D EN^PSOHLSN1(RX,"OD","",PCOM,"A")
 .D ACT1,ULR,KILL
 S X=$O(^PS(52.5,"B",DA,0)) I X,'$G(^PS(52.5,X,"P")) W !,$C(7),"RX MAY NOT BE PRINTED using this option, use SUSPENSE FUNCTIONS Options." K X G PAUSE
 S PSX=0 F J=0:0 S J=$O(^PSRX(DA,1,J)) Q:'J  S PSX=J
 K X
 I $D(^PS(52.4,DA)) W !,"Prescription is Non-Verified",!! G PAUSE
 S DFN=$P(^PSRX(DA,0),"^",2) I $D(^PS(52.4,"AREF",DFN,DA)) W !,"Prescription is waiting for others to be verified",!! G PAUSE
 I $G(PSODIV),$D(^PSRX(DA,2)),+$P(^(2),"^",9),+$P(^(2),"^",9)'=PSOSITE S PSPOP=0,PSPRXN=DA D CHK1^PSOUTLA G:$G(POERR)&(PSPOP) PAUSE G:PSPOP PAUSE
 I STA=3 W !?3,"Prescription is on Hold" G PAUSE
 I STA=4 W !?3,"Prescription is Pending Due to Drug Interactions" G PAUSE
 I STA=12 W !?3,"Prescription is Discontinued" G PAUSE
 S COPIES=$S($P(PDA,"^",18)]"":$P(PDA,"^",18),1:1)
 K DIR S DIR("A")="Number of Copies? ",DIR("B")=COPIES,DIR(0)="N^1:99:0",DIR("?")="Enter the number of copies you want (1 to 99)"
 D ^DIR K DIR I $D(DIRUT) D ULR G KILL
 S COPIES=Y
 K DIR S DIR("A")="Print adhesive portion of label only? ",DIR(0)="Y",DIR("B")="No",DIR("?",1)="If entire label, including trailers are to print press RETURN for default."
 S DIR("?")="Else if only bottle and mailing labels are to print enter Y or YES." D ^DIR K DIR I $D(DUOUT) D ULR,KILL G PAUSE
 I $D(DIRUT) D ULR G KILL
 S SIDE=Y
 I $P(PSOPAR,"^",30),$$GET1^DIQ(59,PSOSITE_",",105,"I")=2.4 D
 .I $S($P(PSOPAR,"^",30)=3:1,$P(PSOPAR,"^",30)=4:1,1:0),'$$GET1^DIQ(50,$P(PDA,"^",6),28,"I") Q
 .K DIR,DIRUT S DIR("A")="Do you want to resend to Dispensing System Device",DIR(0)="Y",DIR("B")="No"
 .D ^DIR K DIR Q:$D(DIRUT)  S PSODISP=$S(Y:0,1:1)
 I $D(DIRUT) D ULR G KILL
 D ACT I $D(DIRUT) D ULR,KILL G PAUSE
 Q:$G(POERR)&($D(PCOM))  G PAUSE:$D(PCOM)
 F I=1,2,4,6,7,9,13,16 S P(I)=$P(PDA,"^",I)
 S P(6)=+P(6) I $D(^PSRX(DA,"TN")),^("TN")]"" S P(6)=^("TN")
 W !!,"Rx # "_P(1),?23,$E(P(13),4,5)_"/"_$E(P(13),6,7)_"/"_$E(P(13),2,3),!,$S($D(^DPT(+P(2),0)):$P(^(0),"^"),1:"Not on File"),?30,"#"_P(7),!
 I $P($G(^PSRX(DA,"SIG")),"^",2) S D=0 D  K D,FSIG
 .D FSIG^PSOUTLA("R",DA,75) F  S D=$O(FSIG(D)) W !,FSIG(D) Q:'$O(FSIG(D))
 E  D EN3^PSOUTLA1(DA,75) S D=0 F  S D=$O(BSIG(D)) W !,BSIG(D) Q:'$O(BSIG(D))
 K D,BSIG
 ;PSO*7*280 If trade name is used Stop the DRUG Lookup.
 W !!,$S($G(^PSRX(DA,"TN"))]"":P(6),(P(6)=+P(6))&$D(^PSDRUG(P(6),0)):$P(^(0),"^"),1:P(6)),! S PHYS=$S($D(^VA(200,+P(4),0)):$P(^(0),"^"),1:"Unknown") W PHYS K PHYS
 W ?25,$S($D(^VA(200,+P(16),0)):$P(^(0),"^"),1:"Unknown"),!,"# of Refills: "_$G(P(9))
 I $G(RX) S RXFL(RX)=0 F ZZZ=0:0 S ZZZ=$O(^PSRX(RX,1,ZZZ)) Q:'ZZZ  S RXFL(RX)=ZZZ
 K PSOELSE I '$G(POERR) S PSOELSE=1 D @$S($P($G(PSOPAR),"^",26):"^PSORXL",1:"Q^PSORXL")
 I '$G(PSOELSE) D
 .S RXRP($P(PSOLST(ORN),"^",2))=1_"^"_COPIES_"^"_SIDE
 .I $G(PSODISP)=1 S RXRP($P(PSOLST(ORN),"^",2),"RP")=1
 .I $G(PSORX("PSOL",1))']"" S PSORX("PSOL",1)=DA_"," Q
 .F PSOX1=0:0 S PSOX1=$O(PSORX("PSOL",PSOX1)) Q:'PSOX1  S PSOX2=PSOX1
 .I $L(PSORX("PSOL",PSOX2))+$L(DA)<220 S PSORX("PSOL",PSOX2)=PSORX("PSOL",PSOX2)_DA_","
 .E  S PSORX("PSOL",PSOX2+1)=DA_","
 K PCOMX,PSPOP,PPL,COPIES,SIDE,PCOM,IOP,PSL,PSNP,PSOELSE,ZZZ
PAUSE K RX,PPL,ZD(+$G(DA)),DA I $G(POERR) K DIR,DIRUT,DUOUT,DTOUT S DIR(0)="E",DIR("A",1)=" ",DIR("A")="Press Return to Continue" D ^DIR K DIR,DIRUT,DUOUT,DTOUT S VALMBCK="R"
 D ULR K PSORPLRX
 Q
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
KILL K QFLG,%,DIR,DUOUT,DTOUT,DIROUT,DIRUT,PCOM,PCOMX,C,DA,DIC,I,J,JJJ,K,RX,RXF,X,Y,Z,DFN,P,PDA,PSPRXN,COPIES,SIDE,PPL,REPRINT,PSOMSG,PSORPLRX D KVA^VADPT Q
 ;
ULR ;
 I $G(PSORPLRX) D PSOUL^PSSLOCK(PSORPLRX)
 Q
