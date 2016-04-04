DIQ1 ;SFISC/XAK-INQUIRY WITH COMPUTED FIELDS ;26JAN2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**19,64,76,133,999,1002,1003,1004**
 ;
A N DIDQ,DICMX,DIQ1W,D,Z,DIQX
 S DIDQ=DD,DICMX="D LF^DIQ K:'S D I S W O,"": "",X S X="""",O=$J(X,$L(O))"
 N DD
 F DIQ1W=0:0 S DIQ1W=$O(^DD(DIDQ,DIQ1W)) Q:DIQ1W'>0  I $D(^(DIQ1W,0))#2 S Z=^(0),C=$P(Z,U,2) I C["C" S X="",O=$$LABEL^DIALOGZ(DIDQ,DIQ1W)_" (c)" X $P(Z,U,5,99) D:X]""&(C'["m")  Q:'S  ;**CCO/NI  LOOP THRU ALL FIELDS TO FIND COMPUTED
 .N Y,W S Y=X,W=DIQ1W
 .I C["p",Y S Y=$$CP(C,Y)
 .E  I C["D" X ^DD("DD")
 .D W2^DIQ
 Q
 ;
CP(C,X) ;
 S:C["p" C=+$P(C,"p",2) I C,$D(^DIC(C,0,"GL")),$D(@(^("GL")_"0)")),$D(^(X,0)) S X=$$EXTERNAL^DIDU(C,.01,"",$P(^(0),U))
 Q X
 ;
EN ;
 Q:'$D(DIC)!($D(DA)[0)!($D(DR)[0)  S DIL=0,(DA(0),D0)=DA,DIQ0=""
 I $D(DIQ)#2 G Q:DIQ["^"!($E(DIQ,1,2)="DI") S:DIQ'["(" DIQ=DIQ_"("
 S:'$D(DIQ(0)) DIQ(0)="",DIQ0="DIQ(0),"
 I $D(DIQ)[0 S DIQ="^UTILITY(""DIQ1"",$J,",DIQ0="DIQ,"
 S DIQ0=DIQ0_"DIQ0"
 I DIC S DIC=$S($D(^DIC(DIC,0,"GL")):^("GL"),1:"") G:DIC="" Q
L G Q:'$D(@(DIC_"0)")) S DI=+$P(^(0),U,2) G Q:'$D(^(DA,0))
 N DII F DII=1:1 S DIQ1=$P(DR,";",DII) Q:DIQ1=""  D C:DIQ1[":",F:DIQ1>0
Q Q:DIL  K %,I,J,X,Y,C,DA(0),DRS,DIL,DI,DIQ1 K:DIQ0]"" @DIQ0 K:$D(DIQ0) DIQ0
 Q
 ;
C S DIQ2=$P(DIQ1,":",2)
 F DIQ1=DIQ1:0 D F S DIQ1=$O(^DD(DI,DIQ1)) I DIQ1'>0!(DIQ1'<DIQ2) S:DIQ1'=DIQ2 DIQ1=0 Q
 Q
F Q:'$D(^DD(DI,DIQ1,0))
 S Y=^(0),C=$P(Y,U,4),X=$P(C,";",2),C=$P(C,";"),J=$P(Y,U,2) G P:J["C"
 I +C'=C S C=""""_C_""""
 I X=0,$D(^DD(+J,.01,0)) G WD:$P(^(0),U,2)["W",S
 S C=$G(@(DIC_DA_","_C_")")),Y=$S(X["E":$E(C,+$P(X,"E",2),+$P(X,",",2)),1:$P(C,U,X))
 I DIQ(0)["I",(DIQ(0)["N"&(Y]"")!(DIQ(0)'["N")) S @(DIQ_"DI,DA,DIQ1,""I"")")=Y
P Q:DIQ(0)'["E"&(DIQ(0)["I")
 I J["C" X $P(Y,U,5,999) K Y S Y=X D:J["D" D^DIQ
 I J'["C" S C=$P(^DD(DI,DIQ1,0),U,2) D:Y]"" Y^DIQ
 Q:Y=""&(DIQ(0)["N")
 S @(DIQ_"DI,DA,DIQ1"_$S(DIQ(0)'["E":"",1:",""E""")_")")=Y
 Q
WD F X=0:0 S X=$O(@(DIC_"DA,"_C_",X)")) Q:X'>0  S @(DIQ_"DI,DA,DIQ1,X)")=^(X,0)
 Q
S ;
 Q:'$D(DR(+J))  Q:'$D(DA(+J))  N DIQ1,I,DI S DIL=DIL+1
 S DRS(DIL)=DR,DIC(DIL)=DIC,DR=DR(+J),DA(DIL)=DA
 S DI=+J,DIC=DIC_DA_","_C_",",DA=DA(+J),@("D"_DIL)=DA
 D L S DR=DRS(DIL),DA=DA(DIL),DIC=DIC(DIL)
 K DRS(DIL),DIC(DIL),DA(DIL),@("D"_DIL)
 S DIL=DIL-1 Q
