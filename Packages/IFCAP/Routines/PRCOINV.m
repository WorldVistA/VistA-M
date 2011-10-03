PRCOINV ;WISC/DJM/LEM-INV Server Interface to IFCAP ;12/15/93  1:59 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
SERV N A,AC,ACD,B,CC,CU,CU1,CU2,C1L,DA,DC,DIE,DR,EE,ERR,FOB,G,G1,I,IT,KD,KP,L,LINE,LN,MPM,M1,N,N1,N1L,N2,N2L,N3,N3L,PC,PN,CI,CI1,PPM,PPT,PRCOI,PU,QT,QTFLG,RP,S1,UC,UC1,UC2,UNIT,UP,UPN,VP,V1,V2
 K ERR S (QTFLG,LN)=0 F  S LN=$O(^PRCF(423.6,PRCDA,1,LN)) G:LN="" S1 S LINE=^(LN,0) D  G:QTFLG>0 S1
 .S A=$P(LINE,U),A="SEG"_$S(A="INV":"1",A="HE":"2",A="VE":"3",A="AC":"4",A="SF":"5",A="IT":"6",A="DE":"7",A="AK":"8",A="CO":"9",1:"10") G @A
SEG1 .S B=$P(LINE,U,4) G:B'="INV" SEG10 S CC=$P(LINE,U,7) F  Q:$A(CC,$L(CC))'=32  S CC=$E(CC,1,$L(CC)-1)
 .S CC=$E(CC,1,3)_"-"_$E(CC,4,$L(CC)),ERR(CC,0)="",CI=$O(^PRCF(421.5,"B",CC,0)) S:CI="" ERR(CC,0)="*",QTFLG=1 Q:QTFLG>0
 .S CI1=$G(^PRCF(421.5,CI,1)) S:CI1="" ERR(CC,0)="*",QTFLG=1 Q:QTFLG>0
 .S PPM=$P(CI1,U,10) D BUL^PRCOINV1 Q
SEG2 .Q
SEG3 .Q
SEG4 .S ERR(CC,"AC")="" I $P(LINE,U,3)]"" S FOB=$G(^PRCF(421.5,CI,1)) S:FOB="" ERR(CC,"AC")="*" S:$P(FOB,U,6)="" ERR(CC,"AC")="*" I $P(FOB,U,6)'=$P(LINE,U,3) S $P(ERR(CC,"AC"),U,2)="*"
 .I $P(LINE,U,3)="" S FOB=$G(^PRCF(421.5,CI,1)) S:$P(FOB,U,6)'="" $P(ERR(CC,"AC"),U,3)="*"
 .S KP=$P(LINE,U,5),KD=$P(LINE,U,6),(EE,G1,PC)="" D  Q
 ..S AC=$G(^PRCF(421.5,CI,5,0)) S:AC="" $P(ERR(CC,"AC"),U,4)="*" S:$P(AC,U,4)'>0 $P(ERR(CC,"AC"),U,4)="*" I $P(ERR(CC,"AC"),U,4)]"" Q
 ..F ACD=1:1:$P(AC,U,4) S PPT(ACD)=$G(^PRCF(421.5,CI,5,ACD,0)) I +$P(PPT(ACD),U)=$P(PPT(ACD),U) S EE=$S(EE]"":EE_"^"_ACD,1:ACD)
 ..I EE]"" S G=$P(EE,U),PC=$P(PPT(ACD),U)/100,G1=$P(PPT(ACD),U,2)
 ..I KP]"",PC'>0 S $P(ERR(CC,"AC"),U,7)="*"
 ..I EE]"",KP]"",KP'=PC S $P(ERR(CC,"AC"),U,5)="*"
 ..I KD]"",G1="" S $P(ERR(CC,"AC"),U,8)="*"
 ..I EE]"",KD]"",KD'=G1 S $P(ERR(CC,"AC"),U,6)="*"
 ..I KP="",PC>0 S $P(ERR(CC,"AC"),U,9)="*"
 ..I KD="",G1>0 S $P(ERR(CC,"AC"),U,10)="*"
 ..Q
SEG5 .Q
SEG6 .S B=$P(LINE,U,2),ERR(CC,B)="",IT=$O(^PRCF(421.5,CI,2,"B",B,0)) S:IT="" $P(ERR(CC,B),U,2)="*" Q:IT=""  S IT=$G(^PRCF(421.5,CI,2,IT,0)) S:IT="" $P(ERR(CC,B),U,2)="*" Q:IT=""
 .S VP=$P(IT,U,6) S:VP="" $P(ERR(CC,B),U,3)="*" S:$E(VP,1)="#" VP=$E(VP,2,99) S:VP'=$P(LINE,U,5) $P(ERR(CC,B),U,9)="*"
 .S QT=$P(IT,U,2) S:QT="" $P(ERR(CC,B),U,5)="*" S QT=QT\1+(QT#1>0)_"00" S:QT'=$P(LINE,U,8) $P(ERR(CC,B),U,10)="*"
 .S PN=$P(LINE,U,6) I PN]"" S RP=$P(IT,U,5) S:RP="" $P(ERR(CC,B),U,8)="*" I RP]"" S MPN=$G(^PRC(441,RP,3)) S:MPN="" $P(ERR(CC,B),U,8)="*" I MPN]"" S MPN=$P(MPN,U,5) S:$E(MPN,1)="#" MPN=$E(MPN,2,99) S:MPN'=PN $P(ERR(CC,B),U,8)="*"
 .S DC=$P(LINE,U,7) I DC]"" S N=$P(IT,U,15) S:N="" $P(ERR(CC,B),U,4)="*" I N]"" S N1=$P(N,"-"),N2=$P(N,"-",2),N3=$P(N,"-",3),N1="000000"_N1,N1L=$L(N1),N1=$E(N1,N1L-5,N1L) D  S:N'=DC $P(ERR(CC,B),U,4)="*"
 ..S N2="0000"_N2,N2L=$L(N2),N2=$E(N2,N2L-3,N2L),N3="00"_N3,N3L=$L(N3),N3=$E(N3,N3L-1,N3L),N=N1_N2_N3
 .S UC=$P(LINE,U,10),UC1=$E(UC,1,$L(UC)-4),UC2=$E(UC,$L(UC)-3,99),UC1=$E(UC1+1000000,2,7) I UC2="0000" S UC=UC1_UC2 G S6B
 .S UC2="."_UC2,UC2=$E($E(UC2+.005,2,3)_"0000",1,4),UC=UC1_UC2
S6B .S CU=$P(IT,U,9) S:CU="" $P(ERR(CC,B),U,7)="*" G:CU="" S6A I CU]"",CU="N/C" S CU="0000000000" S:UC'=CU $P(ERR(CC,B),U,12)="*" G S6A
 .S CU1=$P(CU,"."),CU2=$P(CU,".",2),CU1="000000"_CU1,C1L=$L(CU1),CU1=$E(CU1,C1L-5,C1L),CU2=CU2_"0000",CU2=$E(CU2,1,4),CU=CU1_CU2 S:UC'=CU $P(ERR(CC,B),U,12)="*"
S6A .S PU=$P(LINE,U,9),UP=$P(IT,U,3) S:UP="" $P(ERR(CC,B),U,6)="*" I UP]"" S UPN=$G(^PRCD(420.5,UP,0)) S:UPN="" $P(ERR(CC,B),U,6)="*" I UPN]"" S UNIT=$P(UPN,U) S:UNIT'=PU $P(ERR(CC,B),U,11)="*"
 .S DA(1)=CI,DIE="^PRCF(421.5,DA(1),2,",DR="12///@;12.5///@;13///@;13.5///@",DA=B D ^DIE Q
SEG7 .Q
SEG8 .K DIE,DA,DR S B=$P(LINE,U,2),DA(1)=CI,DA=B,DIE="^PRCF(421.5,DA(1),2,"
 .I $P(ERR(CC,B),U,2)="" S V1=$P(LINE,U,3),V2=$P(LINE,U,4) S:$P(^PRCF(421.5,CI,2,B,2),U,9)="" DR="12///^S X=V1;12.5///^S X=V2" S:'$D(DR) DR="13///^S X=V1;13.5///^S X=V2" D ^DIE
 .Q
SEG9 .Q
SEG10 .Q
S1 D ^PRCOINV1
S2 Q
