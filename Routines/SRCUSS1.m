SRCUSS1 ;TAMPA/CFB - SCREEN SERVER ; [ 03/11/02  13:40 PM ]
 ;;3.0; Surgery ;**14,31,48,66,108**;24 Jun 93
B G BQ:Q(13)=2 Q:$D(Q("X"))  S DR="" W:'Q("ED") !! I Q(1)="Q" S Q(1)="" Q
 I '$D(Q(12,12)),Q(1,Q)=3,Q(7)["(MULTIPLE)" S Q7=1 G BP2
 I Q=1,$D(Q3("DIVE")) S Q7=$P(Q3("DIVE"),"P",2) K Q3("DIVE") G BP10
BP1 S DX=1,DY=22 X:Q("ED") Q("XY") I $D(Q3("VIEW")) S Q3("VIEW")=""
 K QPQPQ W "Enter Screen Server Function:  " R Q7:DTIME S:'$T Q7="^^" I Q7?.N S:$L(Q7)>2 Q7="?" S:Q7>15 Q7="?"
 S:Q7="a" Q7="A" S:$E(Q7)="p" Q7="P"_$E(Q7,2,99)
 S:$L(Q7)&("^-+123456789AP"'[$E(Q7)) Q7="?" S:$P(Q7,":",2)>15 Q7="?" S:Q7?.E1C.E Q7="?"
 I Q7[";" F Q8=2:1 S QQ=$P(Q7,";",Q8) S:"123456789"'[$E(QQ) Q7="?" Q:'QQ
 I Q7["?" D QUES G BP2
 K SRCUSS("OUT")
 I Q7'?.N1";".E,(Q7'?.N),(Q7'?.N1":".E),(Q7'="A"),("^^"'[Q7),(Q7'?1"+".N),(Q7'?1"-".N),(Q7'?1"P"1N.N) D QUES G BP2
 W Q("LO")
BP10 I Q7="A" S Q7="1:"_(Q(1,Q)-1)
 S:$S(Q7="^^":1,$E(Q7)'="L":0,+$E(Q7,2,99)<Q:1,1:0) Q(12,4)=$E(Q7,2,99) S Q(13)=1 G BQ:((Q7=""&('$D(Q0(Q,Q0(0,Q)+1))))!(Q7[U))
 I $E(Q7)="P",$L(Q7)>1,('+$E(Q7,2,99)!('$D(Q0(Q,+$E(Q7,2,99))))) D QUES G BP2
 I $E(Q7)="P",$L(Q7)>1,+$E(Q7,2,99) S Q0(0,Q)=$E(Q7,2,99),Q(1,Q)=1 X Q(0) G A^SRCUSS
 S:Q7="" Q7="+1" I $E(Q7,1)="+" S Q0(0,Q)=Q0(0,Q)+Q7,Q(1,Q)=1 G BQ:'$D(Q0(Q,Q0(0,Q))) X Q(0) G A^SRCUSS
 K Q(12,12) I $E(Q7,1)="-" S:Q7="-" Q7="-1" S Q0(0,Q)=$S(Q0(0,Q)+Q7<2:1,1:Q0(0,Q)+Q7),Q(1,Q)=1 X Q(0) G A^SRCUSS
BP2 S (Q2(Q),DR)="" F Q8=1:1 S Q6=$P(Q7,";",Q8) D:Q6[":" BCOM Q:Q6=""!(Q6'=+Q6)  I $P(Q0(Q,Q0(0,Q)),";",Q6+1)'="" D BM
 S:$D(Q("S",Q,Q0(0,Q),Q(1,Q))) DIC("S")=Q("S",Q,Q0(0,Q),Q(1,Q)) D CNG K DIC("S") S @("Q(7)=$D("_Q(8,Q)_Q(9,Q)_",0))") I 'Q(7) G BQ
 I Q2(Q)="",Q("ED") X ^TMP("SRCUSS",$J,^TMP("SRCUSS",$J,0),1),^(2) W !,Q("EPE") G B
 S QPQPQ=1,Q(1,Q)=1 F EMILY=1:1 S Q2(Q,1)=+$P(Q2(Q),U,1),Q2(Q)=$P(Q2(Q),U,2,99) Q:Q2(Q,1)<1  S Q(3)=Q(2,Q,Q2(Q,1)) D M^SRCUSS0 S Q(1,Q)=1
 X:$S('$D(Q(12,4)):1,+Q(12,4)=Q:1,1:0) Q(0) G A^SRCUSS
BCOM S Q(12,2)=+$P(Q6,":",2),Q6=+Q6,Q(12,1)=0 Q:Q(12,2)'>Q6  F Q(12,0)=Q6:1:Q(12,2) S Q7=$S(Q(12,1)+Q8>1:$P(Q7,";",1,Q8+Q(12,1)-1)_";",1:"")_Q(12,0)_";"_$P(Q7,";",Q(12,1)+Q8+$S(Q(12,1)=0:1,1:0),99) S Q(12,1)=Q(12,1)+1
 Q
BM I $D(Q(2,Q,Q6)),$P(@("^DD("_+$P(Q(2,Q,Q6),U,2)_",.01,0)"),U,2)'["W" S Q2(Q)=Q2(Q)_Q6_U Q
 I $D(Q(2,Q,Q6)),$P(@("^DD("_+$P(Q(2,Q,Q6),U,2)_",.01,0)"),U,2)["W",$D(Q3("VIEW")) S Q3("VIEW")=Q3("VIEW")_$P($P(Q(2,Q,Q6),U,4),";",1)_";"
 S DR=DR_$P(Q0(Q,Q0(0,Q)),";",Q6+1)_";Q;" Q
BQ W:Q=1 @IOF W:$D(Q("NOR")) Q("NOR") K:$D(Q0(0,Q)) Q("S",Q,Q0(0,Q)) K:Q=1 Q,Q0,Q1,DE,DP,DQ,Q2,Q3,Q4,Q5,Q6,Q7,Q8,QQ,QQQ,DX,DY,SRCUSS K ^TMP("SRCUSS",$J) Q  ;WITH NEW K:Q=1  Q
CNG W Q("HI") S (DIE,DIC)=Q(8,Q),DA=Q(9,Q) I $D(Q3("VIEW")) Q:Q3("VIEW")=""  S DR=Q3("VIEW") D EN^DIQ R !!,"Press <RET> to continue  ",Q8:DTIME Q
 I $D(Q("S",Q,"IX")) D IX Q
 I 'Q("ED") D SET,^DIE S SRCUSS("OUT")=1 D RET Q
 G ^SRCUSS2
ID Q:'$D(^DD(+Q(4)))  Q:('(+Q(4)\1=80!(+Q(4)=45.3)))&'($P(^DD(+Q(4),.01,0),U,2)["N"&($D(^DD(+Q(4),0,"ID"))))  S Q(11)=$O(@("^DD("_$S(+Q(4)'="":+Q(4),1:+Q(0,Q))_",0,""ID"","_Q(11)_")")) Q:Q(11)=""  I ^(Q(11))["^(""0"")" S Q(11)=^(Q(11)) Q
 G ID
IX X Q("S",Q,"IX") Q:Q6<1  S DR=".01///"_$P(Q6,U,2) D ^DIE,SET Q
SET S QQ=$S(Q>1:Q-1,1:1) F Q8=1:1:QQ S QQQ=$S(Q>1:Q-Q8,1:1),DA(Q8)=Q(9,QQQ)
 Q
QUES ;
 W:'$D(Q3("VIEW")) !,"To change entries, enter your choices (numbers) separated by a ';', or use",!,"a ':' for ranges.  i.e. 2;3 or 1:3.  Enter 'A' to enter/edit all.",!
 W !,"If there is more than one page to this screen, entering '+' or '-' followed",!,"by the number of pages or entering 'P' followed by the page number will",!,"take you to the desired page."
 W !!,"Enter '^' to quit, or '^^' to return to the menu options."
 R !!,"Press <RET> to continue  ",Q("QUESTION"):DTIME I Q("QUESTION")["?" W !!,"Forget it." H 2
 S Q7="?" Q
RET ; pause for display
 I ($D(DR(1,130))&($E(DR,$L(DR)-6,$L(DR)-4)="27T"))!($D(DR(1,130.16))&($E(DR,$L(DR)-5,$L(DR)-4)="3T")) W Q("NOR"),!!,"Press <RET> to continue  " R Q8:DTIME
 Q
