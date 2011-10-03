PSGORS0 ;BIR/CML3-SCHEDULE PROCESSOR FOR FINISH ;29 Jan 99 / 8:07 AM
 ;;5.0; INPATIENT MEDICATIONS ;**25,50,83,116,111**;16 DEC 97
 ;
 ; Reference to ^PS(51.1 is supported by DBIA 2177
 ; Reference to ^PS(55   is supported by DBIA 2191
 ;
ENA ; entry point for train option
 D ENCV^PSGSETU Q:$D(XQUIT)
 F  S (PSGS0Y,PSGS0XT)="" R !!,"Select STANDARD SCHEDULE: ",X:DTIME W:'$T $C(7) S:'$T X="^" Q:"^"[X  D:X?1."?" ENQ^PSGSH I X'?1."?" D EN W:$D(X)[0 $C(7),"  ??" I $D(X)#2,'PSGS0Y,PSGS0XT ;W "  Every ",PSGS0XT," minutes"
 K DIC,DIE,PSGS0XT,PSGS0Y,Q,X,Y,PSGDT Q
 ;
EN3 ;
 S PSGST=$P($G(^PS(53.1,DA,0)),"^",7) G EN
 ;
EN5 ;
 S PSGST=$P($G(^PS(55,DA(1),5,DA,0)),"^",7)
 ;
EN ; validate
 ;/I X[""""!($A(X)=45)!(X?.E1C.E)!($L(X," ")>2)!($L(X)>70)!($L(X)<1)!(X["P RN")!(X["PR N") K X Q
 I X[""""!($A(X)=45)!(X?.E1C.E)!($L(X," ")>3)!($L(X)>70)!($L(X)<1)!(X["P RN")!(X["PR N") K X Q
 I X?.E1L.E S X=$$ENLU^PSGMI(X) ; I '$D(PSGOES) W "  (",X,")"
 I X["Q0" K X Q
 ;
ENOS ; order set entry
 D ENOS^PSGS0 Q
 ;
 S (PSGS0XT,PSGS0Y,XT,Y)="" I X["PRN"!(X="ON CALL")!(X="ONCALL")!(X="ON-CALL") G Q
 S X0=X I X,X'["X",(X?2.4N1"-".E!(X?2.4N)) D ENCHK S:$D(X) Y=X G Q
 I X["@" D DW S:$D(X) Y=$P(X,"@",2) G Q
 I $S($D(^PS(51.1,"AC","PSJ",X)):1,1:$E($O(^(X)),1,$L(X))=X) D DIC I XT]"" G Q
 I Y'>0,$S(X="NOW":1,X="ONCE":1,X="STAT":1,X="ONE TIME":1,X="ONETIME":1,X="1TIME":1,X="1 TIME":1,X="1-TIME":1,1:X="ONE-TIME") W:'$D(PSGOES) "  (ONCE ONLY)" S Y="",XT="O" G Q
 ;CHANGED LINE BELOW TO FIX THE NON-STANDARD SCHEDULES - RSB 2-10-97
 ;THE FREQUENCY VARIABLE "PSGS0XT" WAS NOT GETTING SET
 ;I $G(PSGSCH)=X S PSGS0Y=$G(PSGAT) Q
 S PSGS0Y=$G(PSGAT)
 ;
NS ;I Y'>0 W:'$D(PSGOES) "  (Nonstandard schedule)" S X=X0,Y=""
 ;I Y'>0 S X=X0,Y="",PSJNSS=1
 ;I $E(X,1,2)="AD" K X G Q
 ;I $E(X,1,3)="BID"!($E(X,1,3)="TID")!($E(X,1,3)="QID") S XT=1440/$F("BTQ",$E(X)) G Q
 S:$E(X)="Q" X=$E(X,2,99) S:'X X="1"_X S X1=+X,X=$P(X,+X,2),X2=0 S:X1<0 X1=-X1 S:$E(X)="X" X2=1,X=$E(X,2,99)
 ;S XT=$S(X["'":1,(X["D"&(X'["AD"))!(X["AM")!(X["PM")!(X["HS"&(X'["THS")):1440,X["H"&(X'["TH"):60,X["AC"!(X["PC"):480,X["W":10080,X["M":40320,1:-1) I XT<0,Y'>0 K X G Q
 S X=X0 I XT S:X2 XT=XT\X1 I 'X2 S:X["QO" XT=XT*2 S XT=XT*X1
 ;
Q ;
 S PSGS0XT=$S(XT]"":XT,1:""),PSGS0Y=$S(Y:Y,1:"")
 I $G(PSJNSS),$G(PSGS0XT)>0,($G(VALMBCK)'="Q") D
 . I $G(PSGOES),$G(PSGS0XT)>0,($G(VALMBCK)'="Q"),'$G(NSFF) D NSSCONT^PSGS0(X,PSGS0XT) Q
 K QX,SDW,SWD,X0,XT,Z,NSFF Q
 ;
ENCHK ;
 I $S($L($P(X,"-"))>4:1,$L(X)>119:1,$L(X)<2:1,X'>0:1,1:X'?.ANP) K X Q
 S X(1)=$P(X,"-") I X(1)'?2N,X(1)'?4N K X Q
 S X(1)=$L(X(1)) I X'["-",X>$E(2400,1,X(1)) K X Q
 F X(2)=2:1:$L(X,"-") S X(3)=$P(X,"-",X(2)) I $S($L(X(3))'=X(1):1,X(3)>$E(2400,1,X(1)):1,1:X(3)'>$P(X,"-",X(2)-1)) K X Q
 K:$D(X) X(1),X(2),X(3) Q
 ;
DIC ;
 S Y="" F TEST=0:0 S TEST=$O(^PS(51.1,"APPSJ",X,TEST)) Q:'TEST!(Y]"")  D
 .I $G(PSGST)="O",$P($G(^PS(51.1,TEST,0)),U,5)'="O" Q
 .S:$D(^PS(51.1,TEST,0)) Y=TEST
 Q:Y=""  K DIC S X="`"_Y,DIC="^PS(51.1,",DIC(0)="XISZ",D="APPSJ"
 D IX^DIC K DIC S:$D(DIE)#2 DIC=DIE Q:Y'>0
 S XT=$S("C"[$P(Y(0),"^",5):$P(Y(0),"^",3),1:$P(Y(0),"^",5)),X=+Y,Y="" I $D(PSJPWD),$D(^PS(51.1,X,1,+PSJPWD,0)) S Y=$P(^(0),"^",2)
 S (X,X0)=Y(0,0) S:Y="" Y=$P(Y(0),"^",2) Q
DW ;
 S SWD="SUNDAYS^MONDAYS^TUESDAYS^WEDNESDAYS^THURSDAYS^FRIDAYS^SATURDAYS",SDW=X,X=$P(X,"@",2) D ENCHK Q:'$D(X)  S X=$P(SDW,"@"),X(1)="-" I X?.E1P.E,X'["-" F QX=1:1:$L(X) I $E(X,QX)?1P S X(1)=$E(X,QX) Q
 F Q=1:1:$L(X,X(1)) K:SWD="" X Q:SWD=""  S Z=$P(X,X(1),Q) D DWC Q:'$D(X)
 K X(1) S:$D(X) X=SDW Q
DWC I $L(Z)<2 K X Q
 F QX=1:1:$L(SWD,"^") S Y=$P(SWD,"^",QX) I $P(Y,Z)="" S SWD=$P(SWD,Y,2) S:$L(SWD) SWD=$E(SWD,2,50) Q
 E  K X
 Q
