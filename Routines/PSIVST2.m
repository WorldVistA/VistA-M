PSIVST2 ;BIR/PR-COMP IV STATS FILE ;16 DEC 97 / 1:40 PM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
ENCT ;Need DFN, PSIVS, ON, PSIVNOL,W42, PSIVC AND PSIVD
 Q:'$D(^PS(55,DFN,"IV",ON))  S X=^PS(55,DFN,"IV",ON,0),P16=$P(X,U,6),P4=$P(X,U,4),IV=PSIVS,PNL=PSIVNOL
 ;
DATE ;Set up date node.
 S $P(^PS(50.8,IV,2,0),U,1,3)="^50.803D^"_PSIVD S:'$D(^(PSIVD,0)) ^(0)=PSIVD,$P(^(0),U,4)=$P(^PS(50.8,IV,2,0),U,4)+1
 ;
W1 ;Set up ward dispensed node.
 I 'W42 S W42=$S($D(^DPT(DFN,.1)):$O(^DIC(42,"B",$P(^(.1),U),0)),1:.5)
 S $P(^PS(50.8,IV,2,PSIVD,1,0),U,1,3)="^50.804P^"_W42 S:'$D(^(W42,0)) ^(0)=W42,$P(^(0),U,4)=$P(^PS(50.8,IV,2,PSIVD,1,0),U,4)+1 S WPC=$S(P4="P":2,P4="A":3,P4="H":4,P4="C":5,1:6)
 I PSIVC=1 S $P(^(0),U,WPC)=$P(^PS(50.8,IV,2,PSIVD,1,W42,0),U,WPC)+PNL G DRUG
 ;
W2 ;Set up ward destroyed,recycled,cancelled node.
 S NODE=$S(PSIVC=2:"R",PSIVC=3:"D",1:"C") S:'$D(^PS(50.8,IV,2,PSIVD,1,W42,NODE)) ^(NODE)=W42 S $P(^(NODE),U,WPC)=$P(^(NODE),U,WPC)+PNL
 ;
DRUG ;Get the order drugs.
 F FI=52.6,52.7 F I=0:0 S I=$O(^PS(55,DFN,"IV",ON,$S(FI[6:"AD",1:"SOL"),I)) Q:'I  S PDR=^(I,0) D CT
 K W42,P4,P16,FI,PDR,A,PIECE,PCE,NODE,WPC Q
 ;
CT ;Set up 0 node, get drug node if not already there.
 S:'$D(^PS(50.8,IV,2,PSIVD,2,0)) ^(0)="^50.805" S DA=$O(^PS(50.8,IV,2,PSIVD,2,"AC",FI,+PDR,0)) G:DA OV F DA=$P(^PS(50.8,IV,2,PSIVD,2,0),U,3)+1:1 Q:'$D(^(DA,0))
 S $P(^PS(50.8,IV,2,PSIVD,2,0),U,3,4)=DA_"^"_DA
 ;
OV ;Update or set drug node.
 S X=^PS(FI,+PDR,0),$P(^PS(50.8,IV,2,PSIVD,2,DA,0),U)=$P(X,U)_$S(FI=52.7:" "_$P(X,U,3)_$S($P(X,U,4)]"":" "_$P(X,U,4),1:""),1:""),Y=^(0),DPC=$S(PSIVC=1:2,PSIVC=2:3,PSIVC=3:4,1:12)
 S $P(Y,U,DPC)=PNL*$P(PDR,U,2)+$P(Y,U,DPC),$P(Y,U,5,11)=$P(X,U,7)_U_$S(FI=52.7:1,1:$P(X,U,3))_U_FI_"^"_($P(Y,U,8)+$S(PSIVC=1:PNL,1:0))_U_($P(Y,U,9)+$S(PSIVC=2:PNL,1:0))_U_($P(Y,U,10)+$S(PSIVC=3:PNL,1:0))_U_($P(Y,U,11)+$S(PSIVC=4:PNL,1:0))
 S ^PS(50.8,IV,2,PSIVD,2,DA,0)=Y
 S ^PS(50.8,IV,2,PSIVD,2,"AC",FI,+PDR,DA)="",^PS(50.8,IV,2,PSIVD,2,"B",$P(X,U,1),$P(X,U,2),DA)=$P(^PSDRUG($P(X,U,2),0),U,9)
 ;
SUB3 ;Set up the patient,provider,and ward subfiles of the drug.
 F PSIV=1,2,3 S X=$S(PSIV=1:DFN,PSIV=2:P16,1:W42) D CT1
 K DA Q
CT1 ;
 S $P(^PS(50.8,IV,2,PSIVD,2,DA,PSIV,0),U,1,3)="^50.80"_(5+PSIV)_"^"_X S:'$D(^(X,0)) ^(0)=X,$P(^(0),U,4)=$P(^PS(50.8,IV,2,PSIVD,2,DA,PSIV,0),U,4)+1 D:PSIV=3 WARD
 I PSIV=1 S PCE=$S(PSIVC=1:2,PSIVC=2:3,PSIVC=3:4,1:6)
 I PSIV=2 S PCE=$S(PSIVC=1:2,PSIVC=2:3,PSIVC=3:4,1:5)
 S $P(^(0),U,PCE)=PNL*$P(PDR,U,2)+$P(^PS(50.8,IV,2,PSIVD,2,DA,PSIV,X,0),U,PCE) I PSIV=1 S $P(^PS(50.8,IV,2,PSIVD,2,DA,PSIV,X,0),U,5)=W42
 Q
WARD S:'$D(^PS(50.8,IV,2,PSIVD,2,DA,PSIV,X,1,0)) ^(0)="^50.809"
 S:'$D(^PS(50.8,IV,2,PSIVD,2,DA,PSIV,X,"B",P4)) (A,Z)=$P(^PS(50.8,IV,2,PSIVD,2,DA,PSIV,X,1,0),U,3)+1,$P(^(0),U,3,4)=Z_"^"_X,^PS(50.8,IV,2,PSIVD,2,DA,PSIV,X,"B",P4,Z)=""
 S A=$O(^PS(50.8,IV,2,PSIVD,2,DA,PSIV,X,"B",P4,0)) S LO=$S($D(^PS(50.8,IV,2,PSIVD,2,DA,PSIV,X,1,A,0)):^(0),1:"")
 S PIECE=$S(PSIVC=1:2,PSIVC=2:3,PSIVC=3:4,1:5)
 S $P(LO,U)=P4,$P(LO,U,PIECE)=(PNL*$P(PDR,U,2)+$P(LO,U,PIECE)),PIECE=$S(PSIVC=1:8,PSIVC=2:9,PSIVC=3:10,1:11),$P(LO,U,PIECE)=$P(LO,U,PIECE)+PNL,^PS(50.8,IV,2,PSIVD,2,DA,PSIV,X,1,A,0)=LO Q
