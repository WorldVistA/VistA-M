PSSGSGUI ;BIR/CML3-SCHEDULE PROCESSOR FOR GUI ONLY ;05/29/98
 ;;1.0;PHARMACY DATA MANAGEMENT;**12,27,38,44,56,59,94**;9/30/97;Build 26
 ;
 ; Reference to ^PS(53.1 supported by DBIA #2140
 ; Reference to ^PSIVUTL supported by DBIA #4580
 ; Reference to ^PS(59.6 supported by DBIA #2110
 ; Reference to ^DIC(42 is supported by DBIA# 10039
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
EN(X,PSSGUIPK) ; validate
 ;I X[""""!($A(X)=45)!(X?.E1C.E)!($L(X," ")>2)!($L(X)>70)!($L(X)<1)!(X["P RN")!(X["PR N")!($E(X,1)=" ") K X Q
 I $G(PSSGUIPK)="O" D  Q
 .Q:$G(X)=""
 .I X[""""!($A(X)=45)!(X?.E1C.E)!($L(X," ")>3)!(X["^")!($L(X)>20)!($L(X)<1) K X Q
 .N PSSUPGUI S X=$$UPPER(X)
 ;I X[""""!($A(X)=45)!(X?.E1C.E)!($L(X," ")>3)!($L(X)>70)!($L(X)<1)!(X["P RN")!(X["PR N")!($E(X,1)=" ") K X Q
 I $TR(X," ")="PRN" S X="PRN"
 S X=$$TRIM^XLFSTR(X,"R"," ")
 I X?.E1L.E S X=$$ENLU^PSSGMI(X)
 ;I X["Q0" K X Q
 ;
ENOS ; order set entry
 ; NSS
 ; * GUI 27 CHANGES * Check for admin times to be derived from 'base' schedule
 N TMPAT I X["@" S TMPAT=$P(X,"@",2) I TMPAT]"" D
 .I '$D(^PS(51.1,"AC","PSJ",TMPAT)) K TMPAT Q
 .N II I '$$DOW^PSIVUTL($P(X,"@")) K TMPAT Q
 .N WARD I $G(DFN) S WARD=$G(^DPT(DFN,.1)) I WARD]"" D
 ..N DIC,X,Y S DIC="^DIC(42,",DIC(0)="BOXZ",X=WARD D ^DIC S WARD=+Y Q:WARD=0
 ..S WARD=$O(^PS(59.6,"B",WARD,0))
 .N TMPIEN S TMPIEN=$O(^PS(51.1,"AC","PSJ",TMPAT,0)),TMPAT=$P($G(^PS(51.1,+TMPIEN,0)),"^",2) D
 ..I $G(WARD) I $P($G(^PS(51.1,+TMPIEN,1,WARD,0)),"^",2) S TMPAT=$P($G(^(0)),"^",2)
 I $G(TMPAT) S (PSGS0Y,$P(X,"@",2))=TMPAT,PSGS0XT="D"
 ; * GUI 27 CHANGES END *
 S (PSGS0XT,PSGS0Y,XT,Y)="" ;I X["PRN"!(X="ON CALL")!(X="ONCALL")!(X="ON-CALL")!($D(^PS(51.1,"APPSJ",X))) G Q
 I $L(X)>63!(X?.E1C.E) S OK=0 G Q
 I X["PRN",$$PRNOK^PSSGS0(X) G Q
 I $D(^PS(51.1,"APPSJ",X)) S OK=1 G Q
 I X="PRN" S OK=1 G Q
 I X["PRN" D  I OK G Q
 . S OK=0 F I=1:1:2 S A=$P($TR(X," "),"PRN",I) Q:A]""
 . Q:A=""  N X S X=A
 . I $D(^PS(51.1,"APPSJ",X)) S OK=1 Q
 . I X?2.4N1"-".E!(X?2.4N) D ENCHK I $D(X) S OK=1 Q
 . D DW I $D(X) S OK=1
 S X0=X I X,X'["X",(X?2.4N1"-".E!(X?2.4N)) D ENCHK S:$D(X) Y=X G Q
 I $S($D(^PS(51.1,"AC","PSJ",X)):1,1:$E($O(^(X)),1,$L(X))=X) D DIC I XT]"" G Q
 I X?2.4N1"-".E!(X?2.4N) D ENCHK S:$D(X) Y=X G Q
 ;D DW G Q
 N TMPSCHX S TMPSCHX=X S TMPX=X D DW I $G(X)]"" K PSJNSS S PSGSCH=X S:'$D(^PS(51.1,"AC","PSJ",$P(TMPSCHX,"@"))) (PSGS0XT,XT)="D" S Y=$P(TMPSCHX,"@",2) G Q
 ;I Y'>0,$S(X="NOW":1,X="ONCE":1,X="STAT":1,X="ONE TIME":1,X="ONETIME":1,X="1TIME":1,X="1 TIME":1,X="1-TIME":1,1:X="ONE-TIME") W:'$D(PSGOES) "  (ONCE ONLY)" S Y="",XT="O" G Q
 ;I $G(PSGSCH)=X S PSGS0Y=$G(PSGAT) Q
 K X Q
 ;
NS I (X="^")!(X="") K X Q
 I Y'>0 S X=X0,Y=""
 I $E(X,1,2)="AD" K X G Q
 I $E(X,1,3)="BID"!($E(X,1,3)="TID")!($E(X,1,3)="QID") S XT=1440/$F("BTQ",$E(X)) G Q
 S:$E(X)="Q" X=$E(X,2,99) S:'X X="1"_X S X1=+X,X=$P(X,+X,2),X2=0 S:X1<0 X1=-X1 S:$E(X)="X" X2=1,X=$E(X,2,99)
 S XT=$S(X["'":1,(X["D"&(X'["AD"))!(X["AM")!(X["PM")!(X["HS"&(X'["THS")):1440,X["H"&(X'["TH"):60,X["AC"!(X["PC"):480,X["W":10080,X["M":40320,1:-1) I XT<0,Y'>0 K X G Q
 S X=X0 I XT S:X2 XT=XT\X1 I 'X2 S:$E(X,1,2)="QO" XT=XT*2 S XT=XT*X1
 ;
Q ;
 S PSGS0XT=$S(XT]"":XT,1:""),PSGS0Y=$S(Y:Y,1:"") K QX,SDW,SWD,X0,XT,Z Q
 ;
ENCHK ;
 I $S($L($P(X,"-"))>4:1,$L(X)>119:1,$L(X)<2:1,X'>0:1,1:X'?.ANP) K X Q
 S X(1)=$P(X,"-") I X(1)'?2N,X(1)'?4N K X Q
 S X(1)=$L(X(1)) I X'["-",X>$E(2400,1,X(1)) K X Q
 F X(2)=2:1:$L(X,"-") S X(3)=$P(X,"-",X(2)) I $S($L(X(3))'=X(1):1,X(3)>$E(2400,1,X(1)):1,1:X(3)'>$P(X,"-",X(2)-1)) K X Q
 K:$D(X) X(1),X(2),X(3) Q
 ;
DIC ;
 K DIC S DIC="^PS(51.1,",DIC(0)=$E("E",'$D(PSGOES))_"ISZ"_"X",DIC("W")="W ""  "","_$S('$D(PSJPWD):"$P(^(0),""^"",2)",'PSJPWD:"$P(^(0),""^"",2)",1:"$S($D(^PS(51.1,+Y,1,+PSJPWD,0)):$P(^(0),""^"",2),1:$P(^PS(51.1,+Y,0),""^"",2))"),D="APPSJ"
 S DIC("W")=""
 ; Naked reference below refers to global reference ^PS(51.1 stored in variable DIC. 
 I $D(PSGST) S DIC("S")="I $P(^(0),""^"",5)"_$E("'",PSGST'="O")_"=""O"""
 D IX^DIC K DIC S:$D(DIE)#2 DIC=DIE Q:Y'>0
 S XT=$S("C"[$P(Y(0),"^",5):$P(Y(0),"^",3),1:$P(Y(0),"^",5)),X=+Y,Y="" I $D(PSJPWD),$D(^PS(51.1,X,1,+PSJPWD,0)) S Y=$P(^(0),"^",2)
 S (X,X0)=Y(0,0) S:Y="" Y=$P(Y(0),"^",2) Q
 ;DW     ;
 ;S SWD="SUNDAYS^MONDAYS^TUESDAYS^WEDNESDAYS^THURSDAYS^FRIDAYS^SATURDAYS",SDW=X,X=$P(X,"@",2)
 ;I X]"" D ENCHK Q:'$D(X)
 ;S X=$P(SDW,"@"),X(1)="-" I X?.E1P.E,X'["-" F QX=1:1:$L(X) I $E(X,QX)?1P S X(1)=$E(X,QX) Q
 ;F Q=1:1:$L(X,X(1)) K:SWD="" X Q:SWD=""  S Z=$P(X,X(1),Q) D DWC Q:'$D(X)
 ;K X(1) S:$D(X) X=SDW Q
 ;DWC    I $L(Z)<2 K X Q
 ;F QX=1:1:$L(SWD,"^") S Y=$P(SWD,"^",QX) I $P(Y,Z)="" S SWD=$P(SWD,Y,2) S:$L(SWD) SWD=$E(SWD,2,50) Q
 ;E  K X
 ;Q
 ;
DW ;
 S SWD="SUNDAYS^MONDAYS^TUESDAYS^WEDNESDAYS^THURSDAYS^FRIDAYS^SATURDAYS",SDW=X,X=$P(X,"@",2) N XABB S XABB=""
 I X]"" D ENCHK Q:'$D(X)
 S X=$P(SDW,"@"),X(1)="-"  ;I X?.E1P.E,X'["-" F QX=1:1:$L(X) I $E(X,QX)?1P S X(1)=$E(X,QX) Q
 F Q=1:1:$L(X,X(1)) K:SWD="" X Q:SWD=""  S Z=$P(X,X(1),Q) D DWC Q:'$D(X)
 I $D(X) F II=1:1:$L(X,X(1)) S XABB=$G(XABB)_$E($P(X,X(1),II),1,2)_"-"
 K X(1) S:$D(X) X=SDW I $G(X)]"" I $TR(XABB,"-")]"" S X=$E($G(XABB),1,$L(XABB)-1)
 Q
DWC I $L(Z)<2 K X Q
 F QX=1:1:$L(SWD,"^") S Y=$P(SWD,"^",QX) I $P(Y,Z)="" S SWD=$P(SWD,Y,2) S:$L(SWD) SWD=$E(SWD,2,50) Q
 E  K X
 Q
 ;
UPPER(PSSUPGUI) ;
 Q $TR(PSSUPGUI,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
