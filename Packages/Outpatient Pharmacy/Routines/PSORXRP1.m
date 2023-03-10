PSORXRP1 ;BIR/SAB-rx speed reprint listman ;Aug 31, 2021
 ;;7.0;OUTPATIENT PHARMACY;**11,27,120,156,148,367,641,441**;DEC 1997;Build 208
 ;External references PSOL and PSOUL^PSSLOCK supported by DBIA 2789
SEL N PSODISP,PSOMGREP,VALMCNT,Y I '$G(PSOCNT) S VALMSG="This patient has no Prescriptions!" S VALMBCK="" Q
 S RXCNT=0 K PSOFDR,DIR,DUOUT,DIRUT S DIR("A")="Select Orders by number",DIR(0)="LO^1:"_PSOCNT D ^DIR S LST=Y I $D(DTOUT)!($D(DUOUT)) K DIR,DIRUT,DTOUT,DUOUT S VALMBCK="" Q
 K PSOSUSID N CNT,LSTCNT,ORD,ORN,PSOOELSE,TMP
 S CNT=0
 I +LST S PSOOELSE=1 S LSTCNT=$L(LST,",") F ORD=1:1:LSTCNT Q:$P(LST,",",ORD)']""  S ORN=$P(LST,",",ORD) I +$G(PSOLST(ORN))=52,$P($G(PSOLST(ORN)),U,3)="ACTIVE" D
 .N CHKPARK,LNG,ORD1,PSDRG,PSRX0,RXNUM,TMPLST
 .S CHKPARK=$P($G(PSOLST(+ORN)),"^",2)  ;PAPI441
 .I CHKPARK'="",$G(^PSRX(CHKPARK,"PARK")),+$P($G(^PSRX(CHKPARK,"STA")),"^")=0 D
 ..S CNT=CNT+1,TMPLST=""
 ..S ORD1=0 I ORD>1 S ORD1=ORD-1
 ..S LNG=$L($P(LST,",",1,ORD))+2
 ..I ORD1>0 S TMPLST=$E(LST,1,$L($P(LST,",",1,ORD1)))
 ..I ORD<LSTCNT S TMPLST=$S($G(TMPLST)'="":TMPLST_",",1:"")_$E(LST,LNG,$L(LST))
 ..S LST=TMPLST
 ..S LSTCNT=LSTCNT-1,ORD=ORD-1
 ..;S VALMSG="Cannot Reprint! Medication is currently PARKED.",VALMBCK=""
 ..I CNT=1 D
 ...D FULL^VALM1
 ...;W !!,"Cannot Reprint! Medication is currently PARKED."
 ...;S VALMSG="Cannot Reprint! Medication is currently PARKED."
 ..;S X=""  F  S X=$O(PSOSD("ACTIVE",X)) Q:X=""  I +PSOSD("ACTIVE",X)=+ORN D
 ..S PSRX0=$G(^PSRX(CHKPARK,0))
 ..S RXNUM=$P(PSRX0,U,1)
 ..S PSDRG=+$P(PSRX0,U,6)
 ..S PSDRG=$P($G(^PSDRUG(PSDRG,0)),U,1)
 ..;W !,"   #"_+ORN_"   Rx #: "_RXNUM_"   "_$G(PSDRG)
 ..S TMP("PSOSEL",(CNT+1))="   #"_+ORN_$E("      ",1,(6-$L(+ORN)))_"Rx #: "_RXNUM_$E("            ",1,(12-$L(RXNUM)))_$G(PSDRG)
 S Y=1
 I CNT>0 D
 .N LN
 .W !
 .S TMP("PSOSEL",1)="Cannot Reprint! Medication"_$S(CNT=1:" is",1:"s are")_" currently PARKED."
 .S LN=0 F  S LN=$O(TMP("PSOSEL",LN)) Q:LN=""  W !,$G(TMP("PSOSEL",LN))
 .W !!
 .N DIR,DIRUT,DUOUT
 .S DIR(0)="E" D ^DIR
 .W !!
 I Y=0 S (PSOOELSE,PSOREPX)=1 G SEL1
 K DIR,DIRUT,DTOUT,PSOREPX I +LST S PSOOELSE=1 D
 .I CNT=0 D FULL^VALM1
 .K DIR S DIR("A")="Number of Copies? ",DIR(0)="N^1:99:0",DIR("?")="Enter the number of copies you want (1 TO 99)",DIR("B")=1
 .D ^DIR K DIR S:$D(DIRUT) PSOREPX=1 Q:$D(DIRUT)  S COPIES=Y
 .K DIR S DIR("A")="Print adhesive portion of label only? ",DIR(0)="Y",DIR("B")="No",DIR("?",1)="If entire label, including trailers are to print press RETURN for default."
 .S DIR("?")="Else if only bottle and mailing labels are to print enter Y or YES." D ^DIR K DIR S:$D(DIRUT) PSOREPX=1 Q:$D(DIRUT)  S SIDE=Y
 .I $P(PSOPAR,"^",30),$$GET1^DIQ(59,PSOSITE_",",105,"I")=2.4 D  Q:$G(PSOREPX)
 ..K DIR,DIRUT S DIR("A")="Do you want to resend to Dispensing System Device",DIR(0)="Y",DIR("B")="No"
 ..D ^DIR K DIR S:$D(DIRUT) PSOREPX=1 Q:$D(DIRUT)  S PSODISP=$S(Y:0,1:1)
 .I $$GET1^DIQ(59,PSOSITE,134)'="" D  Q:$D(DIRUT)
 ..K DIR,DIRUT S DIR("A")="Reprint the FDA Medication Guide",DIR(0)="Y",DIR("B")="No"
 ..D ^DIR K DIR S:$D(DIRUT) PSOREPX=1 Q:$D(DIRUT)  S PSOMGREP=Y
 .K DIRUT,DIR S DIR("A")="Comments: ",DIR(0)="FA^5:60",DIR("?")="5-60 characters input required for activity log." S:$G(PCOMX)]"" DIR("B")=$G(PCOMX)
 .D ^DIR K DIR S:$D(DIRUT) PSOREPX=1 Q:$D(DIRUT)  S (PCOM,PCOMX)=Y
 .S PSOCLC=DUZ
 .F ORD=1:1:$L(LST,",") Q:$P(LST,",",ORD)']""  S ORN=$P(LST,",",ORD),QFLG=0 D:+PSOLST(ORN)=52 RX
 .S VALMBCK="R"
 I '+LST,CNT>0 D
 .S VALMBCK="R"
 .S VALMSG="Cannot Reprint! Medication"_$S(CNT=1:" is",1:"s are")_" currently PARKED."
 .;I CNT=1 S VALMSG="Cannot Reprint! Medication is currently PARKED."
 .;I CNT>1 S VALMSG="Cannot Reprint! Medications are currently PARKED."
SEL1 I $G(PSOREPX) S VALMBCK="R",VALMSG="No Labels Reprinted."
 K PSOREPX
 I '$G(PSOOELSE) S VALMBCK=""
 D ^PSOBUILD
 K PSOMSG,PSORPSRX,QFLG,%,DIR,DUOUT,DTOUT,DIROUT,DIRUT,PCOM,PCOMX,C,I,J,JJJ,K,RX,RXF,X,Z,P,PDA,PSPRXN,COPIES,SIDE,PPL,REPRINT,LST,PSOSUSID D KVA^VADPT
 Q
RX ;process reprint request
 Q:$P(^PSRX($P(PSOLST(ORN),"^",2),"STA"),"^")>11
 I $$LMREJ^PSOREJU1($P(PSOLST(ORN),"^",2)) W $C(7),!!,"Rx "_$$GET1^DIQ(52,$P(PSOLST(ORN),"^",2),.01)_" has OPEN/UNRESOLVED 3rd Party Payer Rejects!" K DIR D PAUSE^VALM1 Q
 ;PSO*7*641 Suspense warning msg 
 S PSOSUSID=$O(^PS(52.5,"B",$P(PSOLST(ORN),"^",2),0))
 I PSOSUSID,'$G(^PS(52.5,PSOSUSID,"P")) D  Q
 . W $C(7),!!,"#"_ORN_"  Rx "_$P(^PSRX($P(PSOLST(ORN),U,2),0),U)_" MAY NOT BE PRINTED using this option" W !,"use SUSPENSE FUNCTIONS Options." K DIR D PAUSE^VALM1 Q
 S PSORPSRX=$P(PSOLST(ORN),"^",2) D PSOL^PSSLOCK(PSORPSRX) I '$G(PSOMSG) W $C(7),!!,$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing Rx "_$P($G(^PSRX(PSORPSRX,0)),"^")),! D PAUSE^VALM1 K PSORPSRX,PSOMSG Q
 S RX=$P(PSOLST(ORN),"^",2),STA=$P(^PSRX($P(PSOLST(ORN),"^",2),"STA"),"^") D CHK I $G(QFLG) D ULR Q
 S RXF=0,ZD(RX)=DT,REPRINT=1
 S RXRP($P(PSOLST(ORN),"^",2))=1_"^"_COPIES_"^"_SIDE
 I $G(PSODISP)=1 S RXRP($P(PSOLST(ORN),"^",2),"RP")=1
 I $G(PSOMGREP)=1 S RXRP($P(PSOLST(ORN),"^",2),"MG")=1
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
