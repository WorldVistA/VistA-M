PRCFACXL ;WISC@ALTOONA/CTB-LOG CODE SHEET STRING GENERATOR ;10 Sep 89/3:08 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S U="^" K PRCFDEL,TERM S:'$D(DA) DA=PRCFA("CSDA") K Q,Q0,Q1 F I=-1:0 S I=$O(^PRCF(423,DA,I)) Q:I=""!(I'=+I)  S:$D(^(I))'["0" Q(I)=^(I) I $D(^PRCF(423,DA,I,0)) D D1
 S Q=$P(Q(0),U,3),Q=$E(Q,2,($L(Q)-1)),Q("MAP")=$O(^PRCD(422,"AD",Q,0)) F I=0:0 S I=$O(^PRCD(422,Q("MAP"),1,I)) Q:I=""  S:$D(^(I,0)) Q("MAPSTR",I)=^(0)
 S X=0,XL1=81,Q1(X)="",S=";",C=",",DEL="." I $D(PRCHLOG) S DEL="",XL1=80
 S N1=0 F I=1:1 S N1=$O(Q("MAPSTR",N1)) Q:'N1  F N2=1:1 Q:$P(Q("MAPSTR",N1),"\",N2)=""  S A=$P(Q("MAPSTR",N1),"\",N2) D @($S(A'[",":"SINGLE",1:"MULTI")) Q:$D(TERM)
 S:$E(Q1(0),1)="." Q1(0)=$P(Q1(0),".",2,999)
 F I=0:1:X I Q1(I)["$" D A Q
 F K=I+1:1:X K Q1(K)
TRANSMIT G:'$D(^PRCF(423,DA,"TRANS")) ^PRCFACX0 I $D(^PRCF(423,DA,"TRANS")),$P(^("TRANS"),U,1)'="Y" G ^PRCFACX0
 S ^PRCF(423,DA,"TRANS")="N"
 W $C(7) S %A="THIS CODE SHEET HAS ALREADY BEEN PRINTED.",%A(1)="DO YOU WISH TO RETRANSMIT IT",%B="'YES' to mark for retransmission.",%B(1)="'NO' or '^' to hold in file."
 S %=2 D ^PRCFYN I %'=1 W !,$C(7),"NO ACTION TAKEN " R X:3 K PRCFA("PODA") Q
 S DR=".3////N;.4///@",DIE="^PRCF(423," D ^DIE
 G ^PRCFACX0
SINGLE S B=$P(A,S,2,3) S:'$D(Q(+B)) Q(+B)="" S Q=$P(Q(+B),U,$P(B,S,2))
 I $P(A,S)["T",$D(^DD(423,+A,2.1)),^(2.1)["PRCHLOG" S Y=Q X ^(2.1) S Q=Y
S1 S Q1(X)=Q1(X)_DEL_Q I $L(Q1(X))>XL1 S Q1(X+1)=$E(Q1(X),XL1+1,999),Q1(X)=$E(Q1(X),1,XL1) S X=X+1,XL1=80 K QX1,QX2 I Q="$" S TERM=1 Q
 Q
MULTI S NODE1=$P(A,S,2) F D1=0:0 S D1=$O(Q(NODE1,D1)) Q:'D1  F J1=2:1 Q:$P(A,C,J1)=""  S A1=$P(A,C,J1),B1=$P(A1,S,2,3) S:'$D(Q(NODE1,D1,+B1)) Q(NODE1,D1+B1)="" D M2
 Q
M2 S Q=$P(Q(NODE1,D1,+B1),U,$P(B1,S,2)) D S1 Q
 Q
D1 F J=0:0 S J=$O(^PRCF(423,DA,I,J)) Q:'J  F K=-1:0 S K=$O(^(J,K)) Q:K=""!(K'=+K)  S:$D(^PRCF(423,DA,I,J,K)) Q(I,J,K)=^(K)
 Q
OUT K B,D,D0,DG,DIC,DIE,DIG,DIH,DIU,DIV,DIW,DLAYGO,DR,K,Q,Q1,S,X,XL1 Q
A I Q1(I)="$" S I=I-1,Q1(I)=$E(Q1(I),1,$L(Q1(I))-1)_"$" Q
 S Q1(I)=$P(Q1(I),"$",1),Q1(I)=$E(Q1(I),1,$L(Q1(I))-1)_"$" Q
DEL ;KILL THE CODE SHEET AND CROSS REFERENCES
