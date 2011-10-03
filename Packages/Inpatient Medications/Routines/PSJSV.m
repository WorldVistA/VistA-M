PSJSV ;BIR/CML3-SCHEDULE VALIDATION ;15 May 98 / 9:28 AM
 ;;5.0; INPATIENT MEDICATIONS ;**3,50,73,83**;16 DEC 97
 ;
 ; Reference to ^PS(51.1 is supported by DBIA# 2177.
 ;
EN ;
 ;/S X=PSJX,(PSJAT,PSJM,PSJTS,PSJY,PSJAX)="" I $S(X["""":1,$A(X)=45:1,X'?.ANP:1,$L(X," ")>2:1,$L(X)>70:1,$L(X)<1:1,X["P RN":1,1:X["PR N") K PSJX,X Q
 S X=PSJX,(PSJAT,PSJM,PSJTS,PSJY,PSJAX)="" I $S(X["""":1,$A(X)=45:1,X'?.ANP:1,$L(X," ")>3:1,$L(X)>70:1,$L(X)<1:1,X["P RN":1,1:X["PR N") K PSJX,X Q
 I X["PRN"!(X="ON CALL")!(X="ONCALL")!(X="ON-CALL") G DONE
 I X?1."?" D:'$D(PSJNE) ENSVH^PSJSV0 Q
 S X0=X,(XT,Y)="" I X,X'["X",(X?2.4N1"-".E!(X?2.4N)) D ENCHK S:$D(X) PSJAT=X G DONE
 I X["@" D DW S:$D(X) PSJAT=$P(X,"@",2) G DONE
 I $S($D(^PS(51.1,"AC",PSJPP,X)):1,1:$E($O(^(X)),1,$L(X))=X) D DIC G:$S(PSJY:PSJTS'="C",1:PSJM) DONE
 I $S(X="NOW":1,X="ONCE":1,X="STAT":1,X="ONE TIME":1,X="1TIME":1,X="1 TIME":1,X="1-TIME":1,X="ONETIME":1,1:X="ONE-TIME") S PSJTS="O" W:'$D(PSJNE) "  (ONCE ONLY)" G DONE
 S:PSJTS="" PSJTS="C" I PSJAT="" W:'$D(PSJNE) "  (Non standard schedule)" S X=PSJX
 I $E(X,1,2)="AD" K X G DONE
 I $E(X,1,3)="BID"!($E(X,1,3)="TID")!($E(X,1,3)="QID") S PSJM=1440\$F("BTQ",$E(X)) G DONE
 S:$E(X)="Q" X=$E(X,2,99) S:'X X="1"_X S X1=+X,X=$P(X,+X,2),X2=0 S:X1<0 X1=-X1 S:$E(X)="X" X2=X1,X=$E(X,2,99) I 'X2,$E(X)="O" S X2=.5,X=$E(X,2,99)
 S XT=$S(X["'":1,(X["D"&(X'["AD"))!(X["AM")!(X["PM")!(X["HS"&(X'["THS")):1440,X["H"&(X'["TH"):60,X["AC"!(X["PC"):480,X["W":10080,X["M":40320,1:-1) I XT<0,PSJAT="" K X G DONE
 S X=PSJX I XT S:X2 XT=XT\X2 S:'X2 XT=XT*X1
 S PSJM=XT
 ;
DONE ;
 K:$D(X)[0 PSJX K D,DIC,Q,QX,SDW,SWD,X,X0,X1,X2,XT,Y,Z Q
 ;
ENCHK ; admin times
 I $S($L($P(X,"-"))>4:1,$L(X)>119:1,$L(X)<2:1,X'>0:1,1:X'?.ANP) K X Q
 S X(1)=$P(X,"-") I X(1)'?2N,X(1)'?4N K X Q
 S X(1)=$L(X(1)) F X(2)=2:1:$L(X,"-") S X(3)=$P(X,"-",X(2)) I $S($L(X(3))'=X(1):1,X(3)>$S(X(1)=2:24,1:2400):1,1:X(3)'>$P(X,"-",X(2)-1)) K X Q
 K:$D(X) X(1),X(2),X(3) Q
 ;
DIC ; 51.1 look-up
 S DIC="^PS(51.1,",DIC(0)=$E("E",'$D(PSJNE))_"ISZ",DIC("W")="I '$D(PSJNE) D DICW^PSJSV0",D="AP"_PSJPP
 D IX^DIC K DIC Q:Y'>0  S PSJY=+Y,(PSJX,X,X0)=Y(0,0),PSJM=$P(Y(0),"^",3),PSJTS=$P(Y(0),"^",5),PSJAX=$P(Y(0),U,7) S:PSJTS="" PSJTS="C" Q:PSJTS="O"!(PSJTS["R")  I $D(PSJW),$D(^PS(51.1,+Y,1,+PSJW,0)) S PSJAT=$P(^(0),"^",PSJTS="S"+2)
 E  S PSJAT=$P(Y(0),"^",PSJTS="S"*4+2)
 Q:PSJTS'="S"
 F Y=1:1:$L(PSJAT,"-") S Y(1)=$P(PSJAT,"-",Y),PSJAT(Y(1))="",Y(2)=$O(^PS(51.15,"ACP",PSJPP,Y(1),0)) I Y(2),$D(^PS(51.15,Y(2),0)) S PSJAT(Y(1))=$P(^(0),"^",3) I $D(PSJW),$D(^(1,PSJW,0)),$P(^(0),"^",2)]"" S PSJAT(Y(1))=$P(^(0),"^",2)
 Q
 ;
DW ;  week days
 S SWD="SUNDAYS^MONDAYS^TUESDAYS^WEDNESDAYS^THURSDAYS^FRIDAYS^SATURDAYS",SDW=X,X=$P(X,"@",2) D ENCHK Q:'$D(X)  S X=$P(SDW,"@"),X(1)="-" I X?.E1P.E,X'["-" F QX=1:1:$L(X) I $E(X,QX)?1P S X(1)=$E(X,QX) Q
 F Q=1:1:$L(X,X(1)) K:SWD="" X Q:SWD=""  S Z=$P(X,X(1),Q) D DWC Q:'$D(X)
 K X(1) S:$D(X) X=SDW Q
DWC I $L(Z)<2 K X Q
 F QX=1:1:$L(SWD,"^") S Y=$P(SWD,"^",QX) I $P(Y,Z)="" S SWD=$P(SWD,Y,2) S:$L(SWD) SWD=$E(SWD,2,50) Q
 E  K X
 Q
 ;
ENSNV ; schedule name
 I $S(X["""":1,$A(X)=45:1,X'?.ANP:1,$L(X)>20:1,$L(X)<2:1,1:X?1P.E) K X Q
 ;I $S('$D(PSJPP):0,PSJPP="":1,PSJPP'?.ANP:1,1:'$D(^DIC(9.4,"C",PSJPP))) K X
 ; changed to remove ref to 9.4,"C"
 N PSJRRF S PSJRRF=X
 K:$S('$D(PSJPP):0,PSJPP="":1,PSJPP'?.ANP:1,1:0) X I $D(X) N DA S X=PSJPP,DIC(0)="OX",DIC=9.4,D="C" D IX^DIC K:+Y'>0 X
 S X=PSJRRF
 I $D(DA),$D(^PS(51.1,DA,0)),$P(^(0),"^",5)["D" S ZX=X D DNVX S:$D(X) X=ZX K Z1,Z2,Z3,Z4,ZX
 Q
 ;
ENSHV ;  shift in 51.1
 ;I $S($L(X)>11:1,$L(X)<1:1,'$D(PSJPP):1,PSJPP="":1,PSJPP'?.ANP:1,1:'$D(^DIC(9.4,"C",PSJPP))) K X Q
 ; changed to remove ref to 9.4,"C"
 N PSJRRF S PSJRRF=X
 K:$S($L(X)>11:1,$L(X)<1:1,'$D(PSJPP):1,PSJPP="":1,PSJPP'?.ANP:1,1:0) X
 I $D(X) S X=PSJPP,DIC(0)="OX",DIC=9.4,D="C" D IX^DIC K:+Y'>0 X
 I '$D(X) Q
 S X=PSJRRF
 F X(1)=1:1:$L(X,"-") S X(2)=$P(X,"-",X(1)) I $S(X(2)="":1,X(2)'?.ANP:1,1:'$D(^PS(51.15,"ACP",PSJPP,X(2)))) K X Q
 K X(1),X(2) Q
 ;
ENVSST ;  shift start/stop times
 I X'?2N1"-"2N,X'?4N1"-"4N K X Q
 F X(1)=1,2 I $P(X,"-",X(1))>$S($L($P(X,"-",X(1)))<4:24,1:2400) K X Q
 K X(1) Q
 ;
ENFQD ; frequency default
 N X1,X2,Z S Z=$S($D(^PS(51.1,DA,0)):$P(^(0),"^"),1:""),X="" Q:Z=""
 I $E(Z,1,2)="AD" Q
 I $E(Z,1,3)="BID"!($E(Z,1,3)="TID")!($E(Z,1,3)="QID") S X=1440/$F("BTQ",$E(Z)) Q
 E  S:$E(Z)="Q" Z=$E(Z,2,99) S:'Z Z="1"_Z S X1=+Z,Z=$P(Z,+Z,2),X2=0 S:$E(Z)="X" X2=X1,Z=$E(Z,2,99) I 'X2,$E(Z)="O" S X2=.5,Z=$E(Z,2,99)
 S X=$S(Z["'":1,(Z["D"&(Z'["AD"))!(Z["AM")!(Z["PM")!(Z["HS"&(Z'["THS")):1440,Z["H"&(Z'["TH"):60,Z["AC"!(Z["PC"):480,Z["W":10080,Z["M":40320,1:"") Q:'X  S:X2 X=X\X2 S:'X2 X=X*X1 Q
 ;
ENDNV ; day of the week name
 N Z1,Z2,Z3,Z4 S X=$S($D(^PS(51.1,DA,0)):$P(^(0),"^"),1:"") I X="" K X Q
 ;
DNVX S Z2=1,Z4="-" I X'["-",X?.E1P.E F Z1=1:1:$L(X) I $E(X,Z1)?1P S Z4=$E(X,Z1) Q
 I X["@",X?.E1P.E S X=$P(X,"@")
 F Z1=1:1:$L(X,Z4) Q:'Z2  S Z2=0 I $L($P(X,Z4,Z1))>1 F Z3="MONDAYS","TUESDAYS","WEDNESDAYS","THURSDAYS","FRIDAYS","SATURDAYS","SUNDAYS" I $P(Z3,$P(X,Z4,Z1))="" S Z2=1 Q
 K:'Z2 X S:Z2 X="D" Q
