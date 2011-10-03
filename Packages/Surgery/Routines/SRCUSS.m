SRCUSS ;TAMPA/CFB - SCREEN SERVER ;  [ 03/11/02  13:33 PM ]
 ;;3.0; Surgery ;**66,108**;24 Jun 93
 K ^TMP("SRCUSS",$J)
 S SRCUSS("OUT")=1
 I '$D(IOF) S IOP="" D ^%ZIS K IOP
 S Q=1 I '$D(Q1) K Q D STOP^SRCUSS3 I $D(Q("DIE")) S Q=1 D BQ^SRCUSS1 S SRCUSS("SRCUSS")="" D ^DIE K SRCUSS("SRCUSS"),Q5 Q
0 S SRCUSS("SRCUSS")="" D START^SRCUSS3
1 S IOP="" D DT^DICRW:'$D(DT),^%ZIS K IOP D 1^SRCUSS3 I $D(Q("Q")) G:Q("Q") BQ^SRCUSS1 K Q("Q")
A S QPQPQ=1,SRCUSS("OUT")=1 K Q("S",Q,Q0(0,Q),Q(1,Q)+1) X:$S('$D(Q(12,4)):0,Q[Q(12,4):1,1:0) Q(0) K:$S('$D(Q(12,4)):0,Q(12,4)=Q:1,1:0) Q(12,4) G BQ^SRCUSS1:$D(Q(12,4))
 I Q=1,$D(Q3("DIVE")),+Q3("DIVE")>1 S Q0(0,Q)=+Q3("DIVE"),Q3("DIVE")="P"_$P(Q3("DIVE"),"P",2) X Q(0)
 S Q(1,Q)=Q(1,Q)+1,Q(13)=Q(13)+1 G:$D(Q(10,Q))&(Q(1,Q)>2) A1 S Q(2)=$P(Q0(Q,Q0(0,Q)),";",Q(1,Q)) G B^SRCUSS1:Q(2)="",X:Q(2)?1U.E
 I Q("ED"),$D(Q("X")),Q("X"),(Q("X")+2=Q(1,Q)) S Q8=$O(^TMP("SRCUSS",$J,Q("X"))) Q:Q8=""  S Q8=$P(^(Q("X"),0),U,1)-$Y+1 G:Q8 ED1^SRCUSS2 Q
 S Q(2)=+Q(2),Q7="^DD("_+Q(0,Q)_",Q(2),0)" G:'$D(@(Q7)) A I $D(@(Q7)) X:$D(^(12.1)) ^(12.1) S:$D(DIC("S")) Q("S",Q,Q0(0,Q),Q(1,Q))=DIC("S") K DIC("S") S Q(3)=@(Q7),Q(4)=$P(Q(3),U,2),Q(1)="" K Q(11)
A0 I "IMRQ*"[$E(Q(4),1) S Q(4)=$E(Q(4),2,99) S:$E(Q(4))="X"!($E(Q(4))="O") Q(4)="F"_Q(4) S:Q(4)="" Q(4)="F" G A0
 S Q("O")=Q(4),Q(5)=$E(Q(4),1) S:Q(5)="" Q(5)="F" G:Q(5)="C" C S:Q(5)'?1N Q(4)=$E(Q(4),2,99) S Q(6)=$P(Q(3),U,4),Q3="(WORD PROCESSING)" K Q(2,Q,Q(1,Q)-1)
 I Q(5)="D",$E(Q(4),1)="C" G C
 I Q(5)?1N S Q(5)=@("^DD("_+Q(4)_",.01,0)"),Q(7)=$S($P(Q(5),U,2)["W":Q3,1:"(MULTIPLE)"),Q(7)=$S($O(@(Q(8,Q)_Q(9,Q)_","_$C(34)_$P(Q(6),";",1)_$C(34)_",0)"))>0:Q(7)_"(DATA)",1:Q(7)),Q(2,Q,Q(1,Q)-1)=Q(3) D OUT:'$D(Q3("DIVE")) G A2
A1 I '$D(Q(11)) S Q(11)=-1 D:Q(5)="P" ID^SRCUSS1 K:Q(11)=-1!(Q(11)="") Q(11)
 S Q(7)=$P(Q(6),";",1),Q(7)=$C(34)_Q(7)_$C(34),Q(7)=$S($D(@(Q(8,Q)_Q(9,Q)_","_Q(7)_")"))#2:$P(@("^("_Q(7)_")"),U,$P(Q(6),";",2)),1:"") D @Q(5):'$D(Q3("DIVE"))
 K SHEMP F MOE=2:1:8 S PIECE=$P(Q(7),";",MOE) I PIECE?1U.E S SHEMP=1
 I $D(SHEMP) S Q(7)=$P(Q(7),";")
 K SHEMP,MOE,PIECE
A2 Q:$D(Q(10,Q))  G A
C D:+Q V X $P(Q(3),U,5,999) S Q(7)=X Q:'+Q  D D:Q(5)="D",OUT:Q(5)'="D" G A
COM S Q7=$O(@("^DD("_+Q(0,Q)_","_Q7_")")) S:Q7'?1NP.NP!(Q7="") Q8=1 Q:Q8!(Q7=+Q(12,2))  S:$E($P(^(Q7,0),U,2),1)'="C" Q(12,0)=Q(12,0)_Q7_";" Q
D G:Q(7)="" OUT S Q6=Q(7),Q(7)="" I $E(Q6,4,5)'="00" S Q(7)=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Q6,4,5))_" "
 I $E(Q6,6,7)'="00" S Q(7)=Q(7)_$E(Q6,6,7)_", "
 K Q7 S Q7=$P(Q6,".",2) S:$L(Q7)=1 Q7=Q7_"0" S:Q7 Q7=$E(Q7,1,2)_":"_$E(Q7,3,4) S Q7=$S($L(Q7)=3:Q7_"00",$L(Q7)=4:Q7_"0",1:Q7) I Q7="" K Q7
 S Q6=Q6\10000+1700,Q(7)=Q(7)_Q6 S:$D(Q7) Q(7)=Q(7)_" AT "_Q7 G OUT
DIE K Q D STOP^SRCUSS3 G:$D(Q("DIE")) DIED S %X="DR(",%Y="Q5(",Q5=DR D %XY^%RCR S Q=$O(DR(1,-1)) S:$E(DR,1,5)="S:DIA" (DR,DR(1,Q))=$P(DR,";",2,999) S @("Q6=$P("_DIE_DA_",0),U,1)"),Q6=DA_U_Q6
 D 0 S:$D(Q5)#2 DR=Q5 I $D(Q5)>9 S %X="Q5(",%Y="DR(" D %XY^%RCR
 K Q5 Q
DIED ; K Q S SRCUSS("SRCUSS")="" D GO^DIE K SRCUSS Q
 Q
EN1 ;N
 S Q7="Q1",Q6=Y G 1
F G OUT
N G OUT
OUT Q:$D(Q("BP"))  D:$D(Q("O")) XO:Q("O")["O" G:Q("ED")&('$D(Q(10))) OUTED^SRCUSS3 W Q("HI"),!,Q(1,Q)-1,?5,Q("LO"),$P(Q(3),U,1),": ",?30 I $D(Q(11)) K:'$D(Q(10)) Q(11)
 W Q("HI"),?30,Q(7),Q("LO") Q
P S Q8=Q(3) K:Q(7)="" Q(11) G:Q(7)="" OUT I $D(Q(11)),$D(@(U_$P(Q(3),U,3)_Q(7)_",0)")) S @("Q(7)=$P"_$P(Q(11),"$P",2)) G OUT
P1 S Q7=U_$P(Q8,U,3),@("Q1=$D("_Q7_"Q("_7_")))"),Q(7)=$S(Q1:$P(^(Q(7),0),U,1),1:Q(7)),@("Q8=^DD("_+$P(@(Q7_"0)"),U,2)_",.01,0)") G P1:$P(Q8,U,2)["P"&(Q1),OUT
S G:Q(7)="" OUT S Q7=$P(Q(3),U,3) F Q8=1:1 Q:Q(7)=$P($P(Q7,";",Q8),":",1)  Q:Q8=50
 G:Q8=50 OUT S Q(7)=$P($P(Q7,";",Q8),":",2) G OUT
V F Q(4)=0:1 Q:'$D(Q(9,Q(4)+1))  Q:'+Q(9,Q(4)+1)  S @("D"_Q(4)_"="_Q(9,Q(4)+1))
 S DA=Q(9,Q) Q
X X Q(2) G A
 Q
XO Q:Q(7)=""  D:+Q V S:$D(Y)#2 Q6(1)=Y S Y=Q(7) X @("^DD("_+Q(0,Q)_","_Q(2)_",2)") S Q(7)=Y S:$D(Q6(1)) Y=Q6(1) K Q6(1) Q
