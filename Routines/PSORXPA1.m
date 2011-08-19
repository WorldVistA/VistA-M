PSORXPA1 ;BIR/SAB - listman partial prescriptions ;07/14/93
 ;;7.0;OUTPATIENT PHARMACY;**11,27,56,77,130,152,181,174,287**;DEC 1997;Build 77
 ;External references L,UL, PSOL, and PSOUL^PSSLOCK supported by DBIA 2789
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^DD(52 supported by DBIA 999
 I $D(RXRP($P(PSOLST(ORN),"^",2))) S VALMBCK="",VALMSG="A Reprint Label has been requested!" Q
 ;I $D(RXPR($P(PSOLST(ORN),"^",2))) S VALMBCK="",VALMSG="A Partial has already been requested!" Q
 I $D(RXRS($P(PSOLST(ORN),"^",2))) S VALMBCK="",VALMSG="Rx is being pulled from suspense!" Q
 S PSORPDFN=+$P($G(^PSRX($P(PSOLST(ORN),"^",2),0)),"^",2)
 S PSOPLCK=$$L^PSSLOCK(PSORPDFN,0) I '$G(PSOPLCK) D LOCK^PSOORCPY S VALMSG=$S($P($G(PSOPLCK),"^",2)'="":$P($G(PSOPLCK),"^",2)_" is working on this patient.",1:"Another person is entering orders for this patient.") K PSOPLCK,PSORPDFN D  Q
 .S VALMBCK=""
 K PSOPLCK D PSOL^PSSLOCK($P(PSOLST(ORN),"^",2)) I '$G(PSOMSG) D UL^PSSLOCK(PSORPDFN) S VALMSG=$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing this order."),VALMBCK="" K PSOMSG,PSORPDFN Q
 I '$G(RXPR($P(PSOLST(ORN),"^",2))) S RX=$P(PSOLST(ORN),"^",2) D VALID^PSORXRP1 I $G(QFLG) S VALMBCK="",VALMSG="A New Label has been requested already!" K QFLG,RX D ULK Q
 D FULL^VALM1 I '$D(PSOPAR) D ^PSOLSET D:'$D(PSOPAR) ULK G:'$D(PSOPAR) KL
 S DA=$P(PSOLST(ORN),"^",2),RX0=^PSRX(DA,0),J=DA,RX2=$G(^(2)),R3=$G(^(3)) S:'$G(BBFLG) BBRX(1)=""
 N PSORF,PSOTRIC D TRIC^PSORXL1(DA) I PSOTRIC&($$STATUS^PSOBPSUT(DA,PSORF)'["PAYABLE") D  Q
 . S VALMBCK="",VALMSG="Partial cannot be filled on Tricare non-payable Rx."
 I +$P($G(^PSRX(DA,2)),"^",6)<DT D
 .S:$P($G(^PSRX(DA,"STA")),"^")<12 $P(^PSRX(DA,"STA"),"^")=11
 .S COMM="Medication Expired on "_$E($P(^PSRX(DA,2),"^",6),4,5)_"/"_$E($P(^(2),"^",6),6,7)_"/"_$E($P(^(2),"^",6),2,3)
 .S STAT="SC",PHARMST="ZE" D EN^PSOHLSN1(DA,STAT,PHARMST,COMM) K STAT,PHARMST,COMM,RX0,J,RX2,R3
 ;I +$P($G(^PSRX(DA,2)),"^",6)<PSODTCUT D  K DA S VALMBCK="R" Q
 ;.S VALMSG="Medication Expired on "_$E($P(^PSRX(DA,2),"^",6),4,5)_"/"_$E($P(^(2),"^",6),6,7)_"/"_$E($P(^(2),"^",6),2,3)
 I +^PSRX(DA,"STA"),+^("STA")'=5,+^("STA")'=11 D  K DA S VALMBCK="R" D ULK Q
 .S C=";"_+^PSRX(DA,"STA")_":",X=$P(^DD(52,100,0),"^",3),E=$F(X,C),D=$P($E(X,E,999),";")
 .S VALMSG="Prescription is in a "_D_" status."
 I $G(PSXSYS),($O(^PS(52.5,"B",DA,""))) S PSOZ1=$O(^PS(52.5,"B",DA,"")) D
 .I $P($G(^PS(52.5,PSOZ1,0)),"^",7)="Q"!($P($G(^(0)),"^",7)="L") D
 ..W !!,"A partial entered for this Rx cannot be suspended."
 ..W !,"A fill for this Rx is already suspended for CMOP transmission."
 ..W !,"You may pull this fill from suspense or enter a partial and print the label.",!!
 ;..S PSOZZ=1 K PSOZ1
CLC S PSOCLC=DUZ,PHYS=$P(^PSRX(DA,0),"^",4),DRG=$P(^(0),"^",6)
 I 'PHYS,$O(^PSRX(DA,1,0)) F I=0:0 S I=$O(^PSRX(DA,1,I)) Q:'I  S PHYS=$S($P(^PSRX(DA,1,I,0),"^",17):$P(^PSRX(DA,1,I,0),"^",17),1:PHYS)
 S PSOPRZ=0 I $O(^PSRX(DA,"P",0)) N Z2 F Z2=0:0 S Z2=$O(^PSRX(DA,"P",Z2)) Q:'Z2  S PSOPRZ=Z2
 K Z1,PRMK S PM=1,RXN=DA,RXF=6,DIE("NO^")="BACKOUTOK",DIE=52
 ;DR="[PSO PARTIAL]"
 S DR="K PM,PQ;60;Q;S:$O(Y(1))]""""!($G(PM)) Y=""@1"";35;@1;K PM;"
 S DR(2,52.2)=".01;S Z1=D1;.02;S:X=""M""!('$P($G(PSOPAR),U,12)) PM=1;.04;S:X=U PQ=1;.041R;S:X=U PQ=1;.05;.07////^S X=DUZ;6////^S X=PHYS;Q;.08///^S X=""NOW"";S PDT=X;.09////^S X=PSOSITE;.03;S:X=U PQ=1;S PRMK=X"
 D ^DIE
 I $D(RXPR(DA)),'$D(^PSRX(DA,"P",$G(RXPR(DA)))) D RMP^PSOCAN3
 G:'$G(Z1) CLCX
 I $G(PRMK)']"",Z1>PSOPRZ D ULK G KILL
 I Z1,$G(PRMK)]"" D  D:$T(EN^PSOHDR)]"" EN^PSOHDR("PPAR",RXN) K DIE,RXN,RXF
 .D ACT S:$P($G(^PSRX(RXN,"P",Z1,0)),"^",2)["W" PSODFN=$P(^PSRX(RXN,0),"^",2),BINGRTE="W",BBFLG=1,BBRX(1)=$G(BBRX(1))_RXN_","
 .S ZD(RXN)=+^PSRX(RXN,"P",Z1,0),^PSRX(RXN,"TYPE")=Z1,$P(^PSRX(RXN,"P",Z1,0),"^",11)=$P($G(^PSDRUG(DRG,660)),"^",6),RXF=6,RXP=Z1,RXPR(RXN)=RXP
 .;I $G(PSOZZ)=1,($G(Z1)) D Q1^PSORXL K Z1,PSOZZ Q
 .I $G(PSORX("PSOL",1))']"" S PSORX("PSOL",1)=RXN_"," Q
 .F PSOX1=0:0 S PSOX1=$O(PSORX("PSOL",PSOX1)) Q:'PSOX1  Q:PSORX("PSOL",PSOX1)[RXN_","  S PSOX2=PSOX1
 .I PSOX1 Q
 .I $L(PSORX("PSOL",PSOX2))+$L(RXN)<220 S:PSORX("PSOL",PSOX2)'[RXN_"," PSORX("PSOL",PSOX2)=PSORX("PSOL",PSOX2)_RXN_","
 .E  S PSORX("PSOL",PSOX2+1)=RXN_","
 S:'$D(PSOFROM) PSOFROM="PARTIAL" S BINGCRT=1 ;D:$D(BINGRTE)&($D(DISGROUP)) ^PSOBING1 K BINGRTE,TM,TM1
CLCX D ULK K DR,DIE,DRG,PPL,RXP,IOP,DA,PHYS,PSOPRZ S VALMBCK="R" Q
 ;
KILL S DA=Z1,DIK="^PSRX("_RXN_",""P""," D ^DIK S ^PSRX(RXN,"TYPE")=0
 D ULK S VALMSG="No Partial Fill Dispensed",VALMBCK="R" Q
KL K DFN,RFDAT,RLL,%,PRMK,PM,%Y,%X,D0,D1,DA,DI,DIC,DIE,DLAYGO,DQ,DR,I,II,J,JJJ,N,PHYS,PS,PSDATE,RFL,RFL1,RXF,ST,ST0,Z,Z1,X,Y,PDT,PSL,PSNP
 K PSOM,PSOP,PSOD,PSOU,DIK,DUOUT,IFN,RXN,DRG,HRX,I1,PSOCLC,PSOLIST,PSOLST,PSPAR,RXP D KVA^VADPT Q
ACT ;adds activity info for partial rx
 S RXF=0 F I=0:0 S I=$O(^PSRX(RXN,1,I)) Q:'I  S RXF=I S:I>5 RXF=I+1
 S DA=0 F FDA=0:0 S FDA=$O(^PSRX(RXN,"A",FDA)) Q:'FDA  S DA=FDA
 S DA=DA+1,^PSRX(RXN,"A",0)="^52.3DA^"_DA_"^"_DA,^PSRX(RXN,"A",DA,0)=DT_"^"_"P"_"^"_DUZ_"^"_RXF_"^"_PRMK
EX K RXF,I,FDA S DA=RXN
 Q
ULK ;
 D UL^PSSLOCK(+$G(PSORPDFN))
 D PSOUL^PSSLOCK($P(PSOLST(ORN),"^",2))
 K PSOMSG,PSOPLCK,PSORPDFN
 Q
