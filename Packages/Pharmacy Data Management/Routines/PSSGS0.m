PSSGS0 ;BIR/CML3-SCHEDULE PROCESSOR ;06/01/98
 ;;1.0;PHARMACY DATA MANAGEMENT;**12,27,38,44,56,69,59,143,119**;9/30/97;Build 9
 ;Reference to $$TRIM^XLFSTR supported by DBIA #10104
 ;Reference to ^PS(53.1 supported by DBIA #2140
 ;
ENA ; entry point for train option
 ;N X S X="PSGSETU" X ^%ZOSF("TEST") I  D ENCV^PSGSETU Q:$D(XQUIT)
 ;F  S (PSGS0Y,PSGS0XT)="" R !!,"Select STANDARD SCHEDULE: ",X:DTIME W:'$T $C(7) S:'$T X="^" Q:"^"[X  D:X?1."?" ENQ^PSSGSH I X'?1."?" D EN W:$D(X)[0 $C(7),"  ??" I $D(X)#2,'PSGS0Y,PSGS0XT W "  Every ",PSGS0XT," minutes"
 ;K DIC,DIE,PSGS0XT,PSGS0Y,Q,X,Y,PSGDT Q
 Q
 ;
EN3 ;
 S PSGST=$P($G(^PS(53.1,DA,0)),"^",7) G EN
 ;
EN5 ;
 S PSGST=$P($G(^PS(55,DA(1),5,DA,0)),"^",7)
 ;
EN(X,PSSLSTPK) ; validate
 ;I X[""""!($A(X)=45)!(X?.E1C.E)!($L(X," ")>2)!($L(X)>70)!($L(X)<1)!(X["P RN")!(X["PR N")!($E(X,1)=" ") K X Q
 I $G(PSSLSTPK)="O"!(PSSLSTPK="X") Q:$G(X)=""  G ENOP
 ;*119 Allow multi-word schedules
 I X[""""!($A(X)=45)!(X?.E1C.E)!($L(X," ")>$S(X["PRN":4,1:3))!($L(X)>70)!($L(X)<1) K X Q
 S X=$$TRIM^XLFSTR(X,"R"," ")
 I X?.E1L.E S X=$$ENLU^PSSGMI(X)
 ;
ENOS ; order set entry
 S (PSGS0XT,PSGS0Y,XT,Y)=""
 I X="OTHER" G Q
 I X["PRN",$$PRNOK(X) G Q
 I X["@" D DW S:$D(X) Y=$P(X,"@",2) G Q
 S X0=X I X,X'["X",(X?2.4N1"-".E!(X?2.4N)) D ENCHK S:$D(X) Y=X G Q
 I $S($D(^PS(51.1,"AC","PSJ",X)):1,1:$E($O(^(X)),1,$L(X))=X) D DIC I XT]"" G Q
 I $G(PSGSCH)=X S PSGS0Y=$G(PSGAT) Q
 K X Q
 ;
NS I (X="^")!(X="") K X Q
 I Y'>0 S X=X0,Y=""
Q ;
 S PSGS0XT=$S(XT]"":XT,1:""),PSGS0Y=$S(Y:Y,1:"") K QX,SDW,SWD,X0,XT,Z Q
 ;
ENCHK ;Ward times
 I $S($L($P(X,"-"))>4:1,$L(X)>119:1,$L(X)<2:1,X'>0:1,1:X'?.ANP) K X Q
 S X(1)=$P(X,"-") I X(1)'?2N,X(1)'?4N K X Q
 S X(1)=$L(X(1)) I X'["-",X>$E(2400,1,X(1)) K X Q
 F X(2)=2:1:$L(X,"-") S X(3)=$P(X,"-",X(2)) I $S($L(X(3))'=X(1):1,X(3)>$E(2400,1,X(1)):1,1:X(3)'>$P(X,"-",X(2)-1)) K X Q
 K:$D(X) X(1),X(2),X(3)
 Q
 ;
ENOP ;
 ;*119 Allow multi-word schedules
 I X[""""!($A(X)=45)!(X?.E1C.E)!($L(X," ")>$S(X["PRN":4,1:3))!($L(X)>20)!($L(X)<1) K X Q
 N PSSUPPER S X=$$UPPER(X)
 K Y,DIC S DIC="^PS(51.1,",DIC(0)="E",D="APPSJ",DIC("W")="D DICW^PSSGS0" D IX^DIC I Y>0 S X=$P(Y,"^",2) Q
 K Y,DIC S DIC=51,DIC(0)="ME" D ^DIC I Y>0 S X=$P(Y,"^",2)
 Q
 ;
DIC ;
 K DIC S DIC="^PS(51.1,",DIC(0)=$E("E",'$D(PSGOES))_"ISZ",DIC("W")="W ""  "","_$S('$D(PSJPWD):"$P(^(0),""^"",2)",'PSJPWD:"$P(^(0),""^"",2)",1:"$S($D(^PS(51.1,+Y,1,+PSJPWD,0)):$P(^(0),""^"",2),1:$P(^PS(51.1,+Y,0),""^"",2))"),D="APPSJ"
 S DIC("W")=""
 I $D(PSGST) S DIC("S")="I $P(^(0),""^"",5)"_$E("'",PSGST'="O")_"=""O"""
 D IX^DIC K DIC S:$D(DIE)#2 DIC=DIE Q:Y'>0
 S XT=$S("C"[$P(Y(0),"^",5):$P(Y(0),"^",3),1:$P(Y(0),"^",5)),X=+Y,Y="" I $D(PSJPWD),$D(^PS(51.1,X,1,+PSJPWD,0)) S Y=$P(^(0),"^",2)
 S (X,X0)=Y(0,0) S:Y="" Y=$P(Y(0),"^",2) Q
 ;
DW ;
 S SWD="SUNDAYS^MONDAYS^TUESDAYS^WEDNESDAYS^THURSDAYS^FRIDAYS^SATURDAYS",SDW=X,X=$P(X,"@",2) D ENCHK Q:'$D(X)  S X=$P(SDW,"@"),X(1)="-" I X?.E1P.E,X'["-" F QX=1:1:$L(X) I $E(X,QX)?1P S X(1)=$E(X,QX) Q
 F Q=1:1:$L(X,X(1)) K:SWD="" X Q:SWD=""  S Z=$P(X,X(1),Q) D DWC Q:'$D(X)
 K X(1) S:$D(X) X=SDW Q
 ;
DWC I $L(Z)<2 K X Q
 F QX=1:1:$L(SWD,"^") S Y=$P(SWD,"^",QX) I $P(Y,Z)="" S SWD=$P(SWD,Y,2) S:$L(SWD) SWD=$E(SWD,2,50) Q
 E  K X
 Q
 ;
UPPER(PSSUPPER) ;
 Q $TR(PSSUPPER,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
DICW ; 
 S Z=^PS(51.1,+Y,0) W $P(Z,"^",8) Q
 ;
PRNOK(PSCH) ;
 Q:PSCH'["PRN" 0
 I $TR(PSCH," ")="PRN" Q 1
 N BASE,I,OK S OK=0 S I=$P(PSCH," PRN") I I]"",$D(^PS(51.1,"AC","PSJ",I)) S OK=1
 I 'OK D
 .I PSCH["@" I $D(^PS(51.1,"AC","PSJ",$P(PSCH,"@")))!$$DOW^PSIVUTL($P(PSCH,"@")) S OK=1 Q
 .I $$DOW^PSIVUTL($TR(PSCH," PRN")) S OK=1
 Q OK
