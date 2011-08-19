YSDIZ ;SLC/RWF-ONE FIELD ^DIE FORMAT QUES. ASKER ; 7/6/89  17:04 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 ;  Called from YSPHY1
 ;CALL DQ = ^DD(FILE#, FIELD#, 0) FORMAT STRING TO ASK
 ;     DE = CURRENT VALUE
 ;     DP = FILE # OR,  -1 AND  DQ(3) HAS THE HELP MESSAGE
 G EN
RD ;
 W !,$P(DQ,U),": " W:$L(YSDE) Y,"// " R X:DTIME S YSTOUT='$T,YSUOUT=X["^" Q
EN ;
 S DV=$P(DQ,U,2),DU=$P(DQ,U,3) S:'$D(YSDE) YSDE="" G PR:$L(YSDE)
EN1 ;
 D RD IF X=""!X["^" W:DV["R" $C(7),"  REQUIRED" G EN1:DV["R",END
E ;
 G QS:X="?",D:X="@",END:X[U,P:DV'["S" S YSDH=DU,Y=$F(";"_DU,";"_X_":") IF Y W " (",$P($E(DU,Y-1,256),";"),")" G V
S ;
 S Y=$P(YSDH,";"),YSDH=$P(YSDH,";",2,99),YSDG=$F(Y,":"_X) G:'YSDG S:Y]"",X W $E(Y,YSDG,999) S X=$P(Y,":") G V
P ;
 IF DV["P" S DIC=U_DU,DIC(0)="EQM" D ^DIC S X=+Y G X:X<0
V ;
 X $P(DQ,U,5,99) I $D(X) S YSDE=X G END
X ;
 W $C(7),"??" G EN
END ;
 K DU,YSDG,D,DV Q
 ;
PR ;
 S YSDG=DV,Y=YSDE,X=DU
R ;
 I YSDG["P",@("$D(^"_X_"0))") S X=+$P(^(0),U,2) G RP:'$D(^(Y,0)) S Y=$P(^(0),U),X=$P(^DD(X,.01,0),U,3),YSDG=$P(^(0),U,2) G R
 I YSDG["S" S X=$F(";"_DU,";"_Y_":") S:X Y=$P($E(DU,X-1,999),";") G RP
 I YSDG["D" S X=Y,Y=Y\10000+1700 S:$E(X,6,7) Y=+$E(X,6,7)_"-"_Y S:$E(X,4,5) Y=+$E(X,4,5)_"-"_Y I X#1 S Y=Y_"@"_$E(X_0,9,10)_":"_$E(X_"000",11,12)
RP ;
 D RD G E:X]"" S X=YSDE G END
 ;
D ;
 W $C(7)," ",!?3,"SURE YOU WANT TO DELETE"
 R "? ",X:DTIME S YSTOUT='$T,YSUOUT=X["^" Q:YSTOUT  I X'?1"Y".E W:$X>55 !?9 W $C(7),"  <NOTHING DELETED>" G EN
 S YSDE="" G EN:DV["R",END
 ;
QS ;
 IF DP<0 W:$D(DQ(3)) !?5,DQ(3) X:$D(DQ(4)) DQ(4)
 E  S D=$P(DQ,U,4),D=$O(^DD(DP,"GL",$P(D,";"),$P(D,";",2),0)) I D W:$D(^DD(DP,D,.1)) !?5,^(.1) W:$D(^(3)) !?5,^(3) X:$D(^(4)) ^(4)
 I DV["P" K DO S DIC=U_DU,D="B",DIC(0)="LM",DLAYGO=$$FN(DIC) D DQ^DICQ K DIC,DO,DS,DX
 I DV["D" W !,"  ENTER DATE AS 'MONTH-DAY-YEAR'" I $P($P($P(DQ(DQ),U,5),"%DT=""",2),"""",1)'["X" W ", OR 'MONTH-YEAR'"
 I DV["S" W !,"CHOOSE FROM: " F YSDG=1:1 S Y=$P(DU,";",YSDG) Q:Y=""  W !?7,$P(Y,":"),?15," ",$P(Y,":",2)
 G EN
 ;
FN(ROOT) ;
 S X="S RNUM=+$P("_ROOT_"0),U,2)\1" X X K X
 QUIT RNUM
