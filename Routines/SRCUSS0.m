SRCUSS0 ;TAMPA/CFB - SCREEN SERVER ; [ 03/11/02  13:37 PM ]
 ;;3.0; Surgery ;**66,108,118,130**;24 Jun 93
CO S Q(12,1)=$P(Q(2),":",1),Q(12,2)=$P(Q(2),":",2),Q(12,0)="",Q(12,8)=0 F Q(12,7)=+Q(12,1):0:+Q(12,2) D COM Q:Q(12,8)!(Q(12,7)>+Q(12,2))  I $L(Q(12,0))+$L(Q0(Q,0))>100 D COM1 Q
 S Q(2)=Q(12,1),Q0(Q,0)=Q(12,1)_";"_Q(12,0)_Q(12,2)_";"_Q0(Q,0) Q
COM S Q(12,7)=$O(@("^DD("_+Q(0,Q)_","_Q(12,7)_")")) S:Q(12,7)'?1NP.NP!(Q(12,7)="")!(Q(12,7)'<Q(12,2)) Q(12,8)=1 Q:Q(12,8)  S Q(12,0)=Q(12,0)_Q(12,7)_";" Q
COM1 S Q(12,0)=$E(Q(12,0),1,$L(Q(12,0))-1)_":" Q
M S Q("LIMIT")=75,Q("LINE")=0
 W:Q("ED") Q("NOR") S Q=Q+1,(Q(1,Q),Q(13),Q0(0,Q))=1,Q(0,Q)=$P(Q(3),U,2)
 I $D(^DD(+Q(0,Q),.01,12.1)) X ^(12.1) S Q("S",Q,"MUL")=DIC("S") K DIC("S")
 S Q(8,Q)=Q(8,Q-1)_Q(9,Q-1)_","_$C(34)_$P($P(Q(3),U,4),";",1)_$C(34)_",",Q3(Q)=$P(Q(3),U,1),Q0(Q,Q0(0,Q))=Q3(Q)_";.01;",Q(10,Q)=0
 K:$S('$D(Q(12,4)):0,+Q(12,4)=Q&(Q(12,4)["S"):1,1:0) Q(12,4) G:$D(Q(12,4)) MQ1
 I @("'($D("_Q(8,Q)_"0))#2)") S @(Q(8,Q)_"0)")=$P(Q(3),U,1,2)
 I $D(Q(14)),'$D(^DIE(Q(14),"DR",Q,+Q(0,Q))) G MQ1
M00 X Q(0)
 I Q("LIMIT")=19,$P(@(Q(8,Q)_"0)"),U,4)>14 W Q("HI") S DIC=Q(8,Q),DIC(0)="QAEM" K DIC("V") D ^DIC G MP
M0 I Q("LIMIT")>19,Q("1",Q)>16 D CONT G:+Q(1)>0 M11A I Q(1)="^" S Q(13)=1 K Q(11),Q(13,0) G M11
 K Q(13,0) G:Q(10,Q)'=+Q(10,Q) MQ1 S (DA(Q),Q(7,Q(1,Q)),Q(9,Q),Q(10,Q))=$O(@(Q(8,Q)_Q(10,Q)_")")) G:Q(10,Q)'=+Q(10,Q)!(Q(10,Q)<1) M1 D A^SRCUSS S Q4(-4,Q(1,Q)-1)=Q(7) I Q(13)#Q("LIMIT") G M0
M1 W !,Q(1,Q),?5,"NEW ENTRY" S Q(7,Q(1,Q))=$S(Q(1,Q)=1:1,1:Q(7,Q(1,Q)-1)+1),Q(13)=1 K Q(11),Q(13,0)
 S:$P(Q(3),"^",5,99)["D IX^DIC" Q("S",Q,"IX")=$P(Q(3),"^",5,99)
M11 K QPQPQ W Q("HI") W !!,"Enter Screen Server Function:  " R Q(1):DTIME S:'$T Q(1)="" S:Q(1)=0 Q(1)="?" S:Q(1)="a" Q(1)="A" I Q("LIMIT")=19,Q(1)>15 S Q(1)="?"
M11A S:Q(1)?.E1C.E Q(1)="?" I Q(1)["?"!(Q(1)?2.99A) D QUES^SRCUSS5 G MQ
 S:$S(Q(1)="^^":1,$E(Q(1))'="L":0,+$E(Q(1),2,99)<Q:1,1:0) Q(12,4)=$E(Q(1),2,99) G:$D(Q(13,0))&(Q(1)="") M00 K Q(13,0)
 S Q8(2)=0 I Q(1,Q)=+Q(1),Q(1)["N" S Q8(2)=1 S:+Q(1)=1 Q(3)=^DD(+$P(Q(3),U,2),.01,0) G M110
 I +Q(1)>0,$E(Q(1),$L(Q(1)))="R",+Q(1)<Q(1,Q),$D(Q4(-4,+Q(1))) G M110
 I (Q(1)=""&(Q(13)=1))!(Q(1)[U) G MQ1
 G M11:Q(1)'=+Q(1)!(Q(1)<1)!(Q(1)>Q(1,Q)),M0:Q(1)="" S (DA(Q),Q(9,Q))=Q(7,Q(1)),Q(13)=1
M110 I '$D(Q3("VIEW")),(+Q(1)=Q(1,Q)!(Q(1)["R")) S:Q(1)=1 @("Q(3)=^DD("_+$P(Q(3),U,2)_",.01,0)") S DIC=Q(8,Q),DIC(0)="ZMEL"_$S(Q(1)'["R":"QA",1:""),DIC("DR")=.01
 S Q(1)=+Q(1)
 I $T S:$D(Q("S",Q,"MUL")) DIC("S")=Q("S",Q,"MUL")
 I $T S:$D(Q4(-4,Q(1))) X=$C(34)_Q4(-4,Q(1))_$C(34) K DIC("V") D SET,^DIC K DIC("S") G MQ:+Y<1 G SET2
M111 ;
 I $D(Q3("VIEW")),Q(1)=Q(1,Q) G MQ
 S Q3(Q)=$E(Q3(Q)_"  ("_Q4(-4,Q(1)),1,60)_")" K Q4
M12 I $D(Q(14)) K Q(10) S (Q(1,Q),Q(13),Q0(0,Q))=1 X Q(0) D TEMC^SRCUSS4,A^SRCUSS:'(+$P(Q0(Q,1),";",2)'=".01"&($P(Q0(Q,1),";",3)="")) G MQ
 I $E(Q(12,5),1,2)="DR",$D(DR(Q,+Q(0,Q)))#2 K Q(10) S Q7="DR("_Q_","_+Q(0,Q)_")",(Q(1,Q),Q(13),Q0(0,Q))=1 X Q(0) D PAGE^SRCUSS4,A^SRCUSS:'($P(Q0(Q,1),";",2)=".01"&($P(Q0(Q,1),";",3)="")) G MQ
 S (Q("P",Q),Q8,Q6)=1,Q0(Q,0)=".01:999999999" D PA1^SRCUSS4
M2 K Q(10,Q) S (Q(1,Q),Q(13))=1 X Q(0) D A^SRCUSS K Q(1,Q) S Q=Q-1,Q(1,Q)=1 S Q(1)="Q",Q(3)=Q(2,Q,Q2(Q,1)) G M
MQ W:Q("ED") Q("HI") K Q8(2),Q(10,Q),Q0(Q),Q("S",Q) S Q=Q-1,Q(1)="Q",Q(13)=1,Q(3)=Q(2,Q,Q2(Q,1)),Q(0,Q+1)=$P(Q(3),U,2) G M
MQ1 W:Q("ED") Q("HI") K Q8(2),Q(10,Q),Q0(Q),Q("S",Q) S Q=Q-1,Q(1)="Q",Q(13)=1,Q(12,12)="" Q
MP X Q(0) S Q(1,Q)=1 G M1:Y<1 S (DA(Q),Q(7,Q(1,Q)),Q(9,Q),Q(10,Q))=+Y D A^SRCUSS S Q4(-4,Q(1,Q)-1)=Q(7) G M1
SET S QQ=$S(Q>1:Q-1,1:1) F Q8=1:1:QQ S QQQ=$S(Q>1:Q-Q8,1:1),DA(Q8)=Q(9,QQQ)
 Q
SET2 I Q(5)="P"&(Q(7,Q(1))'=+Y) D  G M11A:'$D(Y)
 .S Q(999)=0
 .F  S Q(999)=$O(Q(7,Q(999))) Q:'Q(999)  D
 ..S PSDPTR=Q(7,Q(999))
 ..S:PSDPTR=+Y Q(1)=Q(999),Q(999)=99
 .K Y,Q(999),PSDPTR
 S @("Q(9,Q)=$P("_DIC_"0),U,3)"),Q4(-4,Q(1))=+Y(0),Q(7)=Q4(-4,Q(1)),Q("BP")="" D:$P(Q(3),U,2)["P" P^SRCUSS S Q4(-4,Q(1))=Q(7) K Q("BP") G M110:Q8(2)
 G M111
 Q
CONT ;
 S:Q("LINE")>15 Q("LINE")=0
 I Q("LINE")=0 W !!,"Press <RETURN> to see more, '^' to exit this list, OR",!,"CHOOSE 1-",Q("1",Q)-1,": " R Q(1):DTIME S:'$T Q(1)="" S:+Q(1)'>0&(Q(1)'="^") Q(1)=""
 S Q("LINE")=Q("LINE")+1
 S:Q(1)>(Q("1",Q)-1) Q(1)=""
 Q
