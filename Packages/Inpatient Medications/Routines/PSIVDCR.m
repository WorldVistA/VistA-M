PSIVDCR ;BIR/PR-BUILD DRUG COST RPT. ;16 DEC 97 / 1:39 PM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
SUB ;Set the sub routine call variable
 S S=$S(I2="ALL":1,I2="NON":2,I2:3,I2["C.":4,I2["V.":5,I2["T.":6,1:1) K ^UTILITY($J),^("PSIV",$J),VA,TYPE
 ;
RM1 ;1 IV room
 I I4 S V=I4 I $D(^PS(50.8,V,2)) F DAT=I7-1:0 S DAT=$O(^PS(50.8,V,2,DAT)) Q:'DAT!(DAT>I8)  I $D(^(DAT,2)) S NA="" D @S
 ;
RMALL ;All IV rooms
 I 'I4 F V=0:0 S V=$O(^PS(50.8,V)) Q:'V  I $D(^(V,2)) F DAT=I7-1:0 S DAT=$O(^PS(50.8,V,2,DAT)) Q:'DAT!(DAT>I8)  I $D(^(DAT,2)) S NA="" D @S
 ;
 I $D(I6) S ZTIO=I6,ZTDESC="IV DRUG COST REPORT (PRINT)",ZTRTN="W^PSIVDCR1",ZTDTH=$H F G="^UTILITY($J,","I7","I8","I2","BRIEF","SMO","PQ","I10","DUZ","I6","LCO","UCO","I15","I4" S ZTSAVE(G)=""
 I  S %ZIS="QN",IOP=I6 D ^%ZIS,^%ZTLOAD G K
 ;
NQ ;No queue so go print.
 D ^PSIVDCR1 G K
1 ;All drugs or high/low cost
 F DA=0:0 S DA=$O(^PS(50.8,V,2,DAT,2,DA)) Q:'DA  I $D(^(DA,0)) D B
 Q
2 ;Non-formulary drugs
 F J=0:0 S NA=$O(^PS(50.8,V,2,DAT,2,"B",NA)) Q:NA=""  S DA=$O(^(+$O(^(NA,0)),0)) I DA,^(DA)=1 D B
 Q
3 ;1 drug
 F J=0:0 S NA=$O(^PS(50.8,V,2,DAT,2,"B",NA)) Q:NA=""  S DA=$O(^(NA,I2,0)) I DA,$D(^PS(50.8,V,2,DAT,2,DA,0)) D B
 Q
4 ;IV category
 F J=0:0 S NA=$O(^PS(50.8,V,2,DAT,2,"B",NA)) Q:NA=""  F D5=0:0 S D5=$O(^PS(50.8,V,2,DAT,2,"B",NA,D5)) Q:'D5  S DA=$O(^(D5,0)) Q:'DA  I $D(^PS(50.2,"AD",$P(I2,".",2),D5)),$D(^PS(50.8,V,2,DAT,2,DA,0)) D B
 Q
5 ;VA drug class code
 ;NOTE: Outpatient 5.6 must be installed for this feature to work.
 F J=0:0 S NA=$O(^PS(50.8,V,2,DAT,2,"B",NA)) Q:NA=""  F D5=0:0 S D5=$O(^PS(50.8,V,2,DAT,2,"B",NA,D5)) Q:'D5  S DA=$O(^(D5,0)) Q:'DA  I $D(^PS(50.8,V,2,DAT,2,DA,0)) D 51
 Q
51 ;VA code continued
 I I2["000" S MT=$E(I2,3,4) I $E($P(^PSDRUG(D5,0),U,2),1,2)=MT D B
 Q:I2["000"
 I $P(^PSDRUG(D5,0),U,2)=$P(I2,".",2) D B
 Q
6 ;IV type A,P,H,C,S NOTE: This report cannot include patient data.
 S TYPE=$P(I2,".",2) F DA=0:0 S DA=$O(^PS(50.8,V,2,DAT,2,DA)) Q:'DA  I $D(^(DA,0)) D 61
 Q
61 ;IV type continued
 F TW=0:0 S TW=$O(^PS(50.8,V,2,DAT,2,DA,3,TW)) Q:'TW  I $D(^(TW,1)) S DA(1)=$O(^PS(50.8,V,2,DAT,2,DA,3,TW,"B",TYPE,0)) I DA(1) S G1=^PS(50.8,V,2,DAT,2,DA,3,TW,1,DA(1),0) D B
 Q
B ;Build utility by the (W)ard or (P)atient subfile of the drug subfile.
 ;If patient data requested ($D(PQ)), build by patient, else by ward.
 ;Note: If report is for IV type I reset B1-B4,U1-U4,C1-C4
 ;
 S G=^PS(50.8,V,2,DAT,2,DA,0),DRUG=$E($P(G,U),1,34),B1=$P(G,U,8),B3=$P(G,U,9),B2=$P(G,U,10),B4=$P(G,U,11),UNCOST=$P(G,U,5),UM=$P(G,U,6),U1=$P(G,U,2),U3=$P(G,U,3),U2=$P(G,U,4),U4=$P(G,U,12)
 I $D(TYPE) S B1=$P(G1,U,8),B3=$P(G1,U,9),B2=$P(G1,U,10),B4=$P(G1,U,11),U1=$P(G1,U,2),U3=$P(G1,U,3),U2=$P(G1,U,4),U4=$P(G1,U,5)
 S:'$D(^UTILITY($J,V,"H",DRUG,0)) ^(0)="" S J=^(0),$P(J,U)=UM,$P(J,U,20)=$P(J,U,20)+B1,$P(J,U,21)=$P(J,U,21)+B3,$P(J,U,23)=$P(J,U,23)+B4,$P(J,U,22)=$P(J,U,22)+B2,$P(J,U,5)=$P(J,U,5)+(U1-U3-U4*UNCOST),^(0)=J
 F W=0:0 S W=$O(^PS(50.8,V,2,DAT,2,DA,3,W)) Q:'W  I $D(^(W,0)) S WD=$S($D(^DIC(42,W,0)):$P(^(0),U),1:"OUTPATIENT") D:'$D(PQ) B1 I $D(PQ) F P=0:0 S P=$O(^PS(50.8,V,2,DAT,2,DA,1,P)) Q:'P  I $D(^(P,0)),$P(^(0),U,5)=W S PD=$P(^DPT(P,0),U)_"/"_P D B1
 Q
B1 ;
 S G=^PS(50.8,V,2,DAT,2,DA,$S($D(PQ):1,1:3),$S($D(PQ):P,1:W),0),U1=$P(G,U,2),U3=$P(G,U,3),U2=$P(G,U,4),U4=$P(G,U,$S($D(PQ):6,1:5)),C1=$P(G,U,2)*UNCOST,C3=$P(G,U,3)*UNCOST,C4=$P(G,U,$S($D(PQ):6,1:5))*UNCOST,C2=$P(G,U,4)*UNCOST
 I $D(TYPE) Q:TW'=W  S U1=$P(G1,U,2),U3=$P(G1,U,3),U2=$P(G1,U,4),U4=$P(G1,U,5),C1=$P(G1,U,2)*UNCOST,C3=$P(G1,U,3)*UNCOST,C2=$P(G1,U,4)*UNCOST,G4=$P(G1,U,5)*UNCOST
 ;
 S:'$D(^UTILITY($J,V,"H",DRUG,WD,$S($D(PQ):PD,1:"NO"),0)) ^(0)="" S J=^(0),$P(J,U)=$P(J,U)+(U1-U3-U4*UNCOST),$P(J,U,8)=$P(J,U,8)+U1,$P(J,U,9)=$P(J,U,9)+U3,$P(J,U,10)=$P(J,U,10)+U2,$P(J,U,11)=$P(J,U,11)+U4 D B2 S ^(0)=J
 Q
B2 ;
 S $P(J,U,40)=$P(J,U,40)+C1,$P(J,U,41)=$P(J,U,41)+C3,$P(J,U,42)=$P(J,U,42)+C2,$P(J,U,43)=$P(J,U,43)+C4
 Q
K ;
 S:$D(ZTQUEUED) ZTREQ="@"
 K %ZIS,B4,B1,B2,B3,C4,C1,C2,C3,D5,DA,DAT,U4,U2,U1,U3,DRUG,G,I2,I6,I7,I8,J,MT,NA,P,PD,PQ,S,U4,U1,U2,UM,UNCOST,U3,V,VA,W,WD,TYPE,G1,TW,DA(1),I4,I15,%,%I,C,US,X,BRIEF,SMO
