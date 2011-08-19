PSORXRP1 ;BIR/SAB-rx speed reprint listman ;03/06/95
 ;;7.0;OUTPATIENT PHARMACY;**11,27,120,156,148**;DEC 1997
 ;External references PSOL and PSOUL^PSSLOCK supported by DBIA 2789
SEL N PSODISP,VALMCNT I '$G(PSOCNT) S VALMSG="This patient has no Prescriptions!" S VALMBCK="" Q
 S RXCNT=0 K PSOFDR,DIR,DUOUT,DIRUT S DIR("A")="Select Orders by number",DIR(0)="LO^1:"_PSOCNT D ^DIR S LST=Y I $D(DTOUT)!($D(DUOUT)) K DIR,DIRUT,DTOUT,DUOUT S VALMBCK="" Q
 K DIR,DIRUT,DTOUT,PSOOELSE,PSOREPX I +LST S PSOOELSE=1 D
 .D FULL^VALM1 K DIR S DIR("A")="Number of Copies? ",DIR(0)="N^1:99:0",DIR("?")="Enter the number of copies you want (1 TO 99)",DIR("B")=1
 .D ^DIR K DIR S:$D(DIRUT) PSOREPX=1 Q:$D(DIRUT)  S COPIES=Y
 .K DIR S DIR("A")="Print adhesive portion of label only? ",DIR(0)="Y",DIR("B")="No",DIR("?",1)="If entire label, including trailers are to print press RETURN for default."
 .S DIR("?")="Else if only bottle and mailing labels are to print enter Y or YES." D ^DIR K DIR S:$D(DIRUT) PSOREPX=1 Q:$D(DIRUT)  S SIDE=Y
 .I $P(PSOPAR,"^",30),$$GET1^DIQ(59,PSOSITE_",",105,"I")=2.4 D  Q:$G(PSOREPX)
 ..K DIR,DIRUT S DIR("A")="Do you want to resend to Dispensing System Device",DIR(0)="Y",DIR("B")="No"
 ..D ^DIR K DIR S:$D(DIRUT) PSOREPX=1 Q:$D(DIRUT)  S PSODISP=$S(Y:0,1:1)
 .K DIRUT,DIR S DIR("A")="Comments: ",DIR(0)="FA^5:60",DIR("?")="5-60 characters input required for activity log." S:$G(PCOMX)]"" DIR("B")=$G(PCOMX)
 .D ^DIR K DIR S:$D(DIRUT) PSOREPX=1 Q:$D(DIRUT)  S (PCOM,PCOMX)=Y
 .S PSOCLC=DUZ
 .F ORD=1:1:$L(LST,",") Q:$P(LST,",",ORD)']""  S ORN=$P(LST,",",ORD),QFLG=0 D:+PSOLST(ORN)=52 RX
 .S VALMBCK="R"
 I $G(PSOREPX) S VALMBCK="R",VALMSG="No Labels Reprinted."
 K PSOREPX
 I '$G(PSOOELSE) S VALMBCK=""
 D ^PSOBUILD
 K PSOMSG,PSORPSRX,QFLG,%,DIR,DUOUT,DTOUT,DIROUT,DIRUT,PCOM,PCOMX,C,I,J,JJJ,K,RX,RXF,X,Y,Z,P,PDA,PSPRXN,COPIES,SIDE,PPL,REPRINT,PSOOELSE,ORD,LST,ORN D KVA^VADPT
 Q
 ;
RX ;process reprint request
 Q:$P(^PSRX($P(PSOLST(ORN),"^",2),"STA"),"^")>11
 I $$LMREJ^PSOREJU1($P(PSOLST(ORN),"^",2)) W $C(7),!!,"Rx "_$$GET1^DIQ(52,$P(PSOLST(ORN),"^",2),.01)_" has OPEN/UNRESOLVED 3rd Party Payer Rejects!" K DIR D PAUSE^VALM1 Q
 S PSORPSRX=$P(PSOLST(ORN),"^",2) D PSOL^PSSLOCK(PSORPSRX) I '$G(PSOMSG) W $C(7),!!,$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing Rx "_$P($G(^PSRX(PSORPSRX,0)),"^")),! D PAUSE^VALM1 K PSORPSRX,PSOMSG Q
 S RX=$P(PSOLST(ORN),"^",2),STA=$P(^PSRX($P(PSOLST(ORN),"^",2),"STA"),"^") D CHK I $G(QFLG) D ULR Q
 S RXF=0,ZD(RX)=DT,REPRINT=1
 S RXRP($P(PSOLST(ORN),"^",2))=1_"^"_COPIES_"^"_SIDE
 I $G(PSODISP)=1 S RXRP($P(PSOLST(ORN),"^",2),"RP")=1
 S RXFL($P(PSOLST(ORN),"^",2))=0 F ZZZ=0:0 S ZZZ=$O(^PSRX($P(PSOLST(ORN),"^",2),1,ZZZ)) Q:'ZZZ  S RXFL($P(PSOLST(ORN),"^",2))=ZZZ
 K ZZZ
 I $G(PSORX("PSOL",1))']"" S PSORX("PSOL",1)=RX_"," S ST="" D ACT1,ULR Q
 F PSOX1=0:0 S PSOX1=$O(PSORX("PSOL",PSOX1)) Q:'PSOX1  S PSOX2=PSOX1
 I $L(PSORX("PSOL",PSOX2))+$L(RX)<220 S PSORX("PSOL",PSOX2)=PSORX("PSOL",PSOX2)_RX_","
 E  S PSORX("PSOL",PSOX2+1)=RX_","
 S ST="" D ACT1
 D ULR
 Q
CHK ;check for valid reprint
 I DT>$P(^PSRX(RX,2),"^",6) D  S QFLG=1 Q
 .I $P(^PSRX(RX,"STA"),"^")<11 S $P(^PSRX(RX,"STA"),"^")=11 D
 ..S COMM="Medication Expired on "_$E($P(^PSRX(RX,2),6),4,5)_"-"_$E($P(^(2),"^",6),6,7)_"-"_$E($P(^(2),"^",6),2,3) D EN^PSOHLSN1(RX,"SC","ZE",COMM) K COMM
 S DFN=PSODFN D DEM^VADPT I $P(VADM(6),"^",2)]"" D  S QFLG=1 Q
 .S $P(^PSRX(RX,"STA"),"^")=12,PCOM="Patient Expired "_$P(VADM(6),"^",2),ST="C" D EN^PSOHLSN1(RX,"OD","",PCOM,"A")
 .D ACT1
 I $D(RXPR($P(PSOLST(ORN),"^",2)))!$D(RXRP($P(PSOLST(ORN),"^",2))) S QFLG=1 Q
 D VALID Q:$G(QFLG)
 S X=$O(^PS(52.5,"B",RX,0)) I X,'$G(^PS(52.5,X,"P")) S QFLG=1 Q
 I $G(X)'>0 G GOOD
 I $P($G(^PS(52.5,X,0)),"^",7)']"" G GOOD
 I $P($G(^PS(52.5,X,0)),"^",7)="Q" K X,XX S QFLG=1 Q
 I $P($G(^PS(52.5,X,0)),"^",7)="L" K X,XX S QFLG=1 Q
GOOD K X
 I $D(^PS(52.4,RX)) S QFLG=1 Q
 I $D(^PS(52.4,"AREF",PSODFN,RX)) S QFLG=1 Q
 I $G(PSODIV),$D(^PSRX(RX,2)),+$P(^(2),"^",9),+$P(^(2),"^",9)'=PSOSITE S PSPOP=0,PSPRXN=RX D CHK1^PSOUTLA I $G(POERR)&(PSPOP) S QFLG=1 Q
 I STA=3!(STA=4)!(STA=12) S QFLG=1 Q
 Q
ACT1 S RXF=0 F J=0:0 S J=$O(^PSRX(RX,1,J)) Q:'J  S RXF=J S:J>5 RXF=J+1
 S IR=0 F J=0:0 S J=$O(^PSRX(RX,"A",J)) Q:'J  S IR=J
 S IR=IR+1,^PSRX(RX,"A",0)="^52.3DA^"_IR_"^"_IR
 D NOW^%DTC S ^PSRX(RX,"A",IR,0)=%_"^"_$S($G(ST)'="C":"W",1:"C")_"^"_DUZ_"^"_RXF_"^"_PCOM_$S($G(ST)'="C":" ("_COPIES_" COPIES)",1:""),PCOMX=PCOM K PC,IR,PS,XX,%,%H,%I,RXF
 S:$P(^PSRX(RX,2),"^",15)&($G(ST)'="C") $P(^PSRX(RX,2),"^",14)=1
 Q
VALID ;check for rx in label array
 I $O(PSORX("PSOL",0)) D
 .F PSOX1=0:0 S PSOX1=$O(PSORX("PSOL",PSOX1)) Q:'PSOX1  I PSORX("PSOL",PSOX1)[RX_"," S QFLG=1 Q
 Q
ULR ;
 I $G(PSORPSRX) D PSOUL^PSSLOCK(PSORPSRX)
 Q
