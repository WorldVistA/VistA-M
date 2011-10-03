PSSJSV ;BIR/CML3/WRT-SCHEDULE VALIDATION ;06/24/96
 ;;1.0;PHARMACY DATA MANAGEMENT;**20,38,56,59,110,121,143**;9/30/97;Build 24
 ;
 ; Reference to ^PS(51.15 is supported by DBIA #2132
 ; Reference to $$UP^XLFSTR(P1) is supported by DBIA #10104
 ;
EN ;
 S X=PSJX,(PSJAT,PSJM,PSJTS,PSJY,PSJAX)="" I $S(X["""":1,$A(X)=45:1,X'?.ANP:1,$L(X," ")>2:1,$L(X)>70:1,$L(X)<1:1,X["P RN":1,1:X["PR N") K PSJX,X Q
 I X["PRN"!(X="ON CALL")!(X="ONCALL")!(X="ON-CALL") G DONE
 I X?1."?" D:'$D(PSJNE) ENSVH^PSSJSV0 Q
 I X["@" D DW S:$D(X) PSJAT=$P(X,"@",2) G DONE
 S X0=X,(XT,Y)="" I X,X'["X",(X?2.4N1"-".E!(X?2.4N)) D ENCHK S:$D(X) PSJAT=X G DONE
 I $S($D(^PS(51.1,"AC",PSJPP,X)):1,1:$E($O(^(X)),1,$L(X))=X) D DIC G:$S(PSJY:PSJTS'="C",1:PSJM) DONE
 I $S(X="NOW":1,X="ONCE":1,X="STAT":1,X="ONE TIME":1,X="ONETIME":1,X="1TIME":1,X="1-TIME":1,X="1 TIME":1,1:X="ONE-TIME") S PSJTS="O" W:'$D(PSJNE) "  (ONCE ONLY)" G DONE
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
 Q:'$D(X)
 S X(1)=$L(X,"-")
 S IENS=$S($G(DA(1))]"":DA(1),1:DA)
 S X(4)=$S($G(PSSJSE)&($G(PSSSCT)]""):PSSSCT,1:$$GET1^DIQ(51.1,IENS,5,"I"))
 I X(4)="D" D  Q  ;DOW schedules require at least one admin time
 . I X(1)>0 K:$D(X) X(1),X(2),X(3) Q
 . K X
 I X(4)="O" D  Q
 . I $L(X,"-")>1 K X Q  ;One Time schedules allow one admin time
 . I X="" K X Q  ;One Time schedules require one admin time
 S X(2)=$S($G(PSSJSE)&($G(PSSFRQ)):PSSFRQ,1:$$GET1^DIQ(51.1,IENS,2,"I"))
 I X(2)="" K:$D(X) X(1),X(2),X(3) Q
 I X(2)>0,X(2)<1440,(1440/X(2))'=X(1) K X Q  ;PSS*1*143 Admin times must match frequency
 I X(2)>0,X(2)<1440,(1440#X(2))'=0,X(1)>0 K X Q  ;PSS*1*143 Odd schedules cannot have admin times
 I X(2)>1440,(X(2)#1440)'=0,X(1)>1 K X Q  ;PSS*1*143 Odd schedules cannot have admin times
 I X(2)>1439,$L(X,"-")'=1 K X Q  ;PSS*1*143 Schedules with frequency equal to or greater than 1 day can only have one admin time.
 K:$D(X) X(1),X(2),X(3)
 Q
 ;
DIC ; 51.1 look-up
 S DIC="^PS(51.1,",DIC(0)=$E("E",'$D(PSJNE))_"ISZ",DIC("W")="I '$D(PSJNE) D DICW^PSSJSV0",D="AP"_PSJPP
 D IX^DIC K DIC Q:Y'>0  S PSJY=+Y,(PSJX,X,X0)=Y(0,0),PSJM=$P(Y(0),"^",3),PSJTS=$P(Y(0),"^",5),PSJAX=$P(Y(0),U,7) S:PSJTS="" PSJTS="C" Q:PSJTS="O"!(PSJTS["R")  I $D(PSJW),$D(^PS(51.1,+Y,1,+PSJW,0)) S PSJAT=$P(^(0),"^",PSJTS="S"+2)
 E  S PSJAT=$P(Y(0),"^",PSJTS="S"*4+2)
 Q:PSJTS'="S"
 F Y=1:1:$L(PSJAT,"-") S Y(1)=$P(PSJAT,"-",Y),PSJAT(Y(1))="",Y(2)=$O(^PS(51.15,"ACP",PSJPP,Y(1),0)) I Y(2),$D(^PS(51.15,Y(2),0)) S PSJAT(Y(1))=$P(^(0),"^",3) I $D(PSJW),$D(^(1,PSJW,0)),$P(^(0),"^",2)]"" S PSJAT(Y(1))=$P(^(0),"^",2)
 Q
 ;
DW ;  week days
 S SWD="SUNDAYS^MONDAYS^TUESDAYS^WEDNESDAYS^THURSDAYS^FRIDAYS^SATURDAYS",SDW=X,X=$P(X,"@",2) D ENCHK Q:'$D(X)
 S X=$P(SDW,"@"),X(1)="-" I X?.E1P.E,X'["-" F QX=1:1:$L(X) I $E(X,QX)?1P S X(1)=$E(X,QX) Q
 F Q=1:1:$L(X,X(1)) K:SWD="" X Q:SWD=""  S Z=$P(X,X(1),Q) D DWC Q:'$D(X)
 K X(1) S:$D(X) X=SDW Q
DWC I $L(Z)<2 K X Q
 F QX=1:1:$L(SWD,"^") S Y=$P(SWD,"^",QX) I $P(Y,Z)="" S SWD=$P(SWD,Y,2) S:$L(SWD) SWD=$E(SWD,2,50) Q
 E  K X
 Q
 ;
ENSNV ; schedule name
 I $S(X["""":1,$A(X)=45:1,X'?.ANP:1,$L(X)>20:1,$L(X)<2:1,1:X?1P.E) K X Q
 I $S('$D(PSJPP):0,PSJPP="":1,PSJPP'?.ANP:1,1:'$$VERSION^XPDUTL(PSJPP)) K X
 I $D(DA),$D(^PS(51.1,DA,0)),$P(^(0),"^",5)["D" S ZX=X D DNVX S:$D(X) X=ZX K Z1,Z2,Z3,Z4,ZX
 Q
 ;
ENSHV ;  shift in 51.1
 I $S($L(X)>11:1,$L(X)<1:1,'$D(PSJPP):1,PSJPP="":1,PSJPP'?.ANP:1,1:'$$VERSION^XPDUTL(PSJPP)) K X Q
 F X(1)=1:1:$L(X,"-") S X(2)=$P(X,"-",X(1)) I $S(X(2)="":1,X(2)'?.ANP:1,1:'$D(^PS(51.15,"ACP",PSJPP,X(2)))) K X Q
 K X(1),X(2) Q
 ;
ENVSST ;  shift start/stop times
 I X'?2N1"-"2N,X'?4N1"-"4N K X Q
 F X(1)=1,2 I $P(X,"-",X(1))>$S($L($P(X,"-",X(1)))<4:24,1:2400) K X Q
 K X(1) Q
 ;
ENFQD ; frequency default
 N X1,X2,Z S Z=$S($D(^PS(51.1,DA,0)):$P(^(0),"^"),1:""),X=""
 S X=$P(Z,"^",3) I Z]"" Q
 S Z=DA I $E(Z,1,2)="AD" Q
 I $E(Z,1,3)="BID"!($E(Z,1,3)="TID")!($E(Z,1,3)="QID") S X=1440/$F("BTQ",$E(Z)) Q
 E  S:$E(Z)="Q" Z=$E(Z,2,99) S:'Z Z="1"_Z S X1=+Z,Z=$P(Z,+Z,2),X2=0 S:$E(Z)="X" X2=X1,Z=$E(Z,2,99) I 'X2,$E(Z)="O" S X2=.5,Z=$E(Z,2,99)
 S X=$S(Z["'":1,(Z["D"&(Z'["AD"))!(Z["AM")!(Z["PM")!(Z["HS"&(Z'["THS")):1440,Z["H"&(Z'["TH"):60,Z["AC"!(Z["PC"):480,Z["W":10080,Z["M":40320,1:"") Q:'X  S:X2 X=X\X2 S:'X2 X=X*X1 Q
 ;
ENFREQ ;validate frequency
 K:+X'=X!(X>129600)!(X<1)!(X?.E1"."1N.N) X
 Q
 ;
ENDNV ; day of the week name
 N Z1,Z2,Z3,Z4 S X=$S($D(^PS(51.1,DA,0)):$P(^(0),"^"),1:"") I X="" K X Q
 ;
DNVX S Z2=1,Z4="-" I X'["-",X?.E1P.E F Z1=1:1:$L(X) I $E(X,Z1)?1P S Z4=$E(X,Z1) Q
 F Z1=1:1:$L(X,Z4) Q:'Z2  S Z2=0 I $L($P(X,Z4,Z1))>1 F Z3="MONDAYS","TUESDAYS","WEDNESDAYS","THURSDAYS","FRIDAYS","SATURDAYS","SUNDAYS" I $P(Z3,$P(X,Z4,Z1))="" S Z2=1 Q
 K:'Z2 X S:Z2 X="D" Q
 ;
ENPSJ ;validate schedule names for PSJ package
 N A,B,I
 S X=$$UP^XLFSTR(X)
 I $G(PSJPP)'="PSJ" Q
 S A=$TR(X,".","") I A="OTHER" K X Q
 F I=1:1:$L(A," ") S B=$P(A," ",I) I B="QD"!(B="QOD")!(B="HS")!(B="TIW") K X
 S DOW=0,ZX=X S X=$P(X,"@") D DNVX I $G(X)="" S X=ZX K ZX Q 
 I X="D" S X=ZX,DOW=1 D CHKORD I '$D(X) D  S:$D(X) X=ZX K Z1,Z2,Z3,Z4,ZX
 . N MSG
 . S MSG(1)="The day of the week schedule must be in the correct day of week order."
 . S MSG(2)="The correct order is: SU-MO-TU-WE-TH-FR-SA"
 . D EN^DDIOL(.MSG,"","!")
 Q
 ;
ENPSJT ; Validate schedule type (one-time PRN conflict)
 N A,B
 S A=$$GET1^DIQ(51.1,DA,.01),B=""
 I A["PRN",X'="P" D
 . S B="Conflict: Schedule Name contains PRN but selected Schedule Type is not PRN."
 . K X
 I A'["PRN",X="P" D
 . S B="Conflict: Schedule Name does not contain PRN but selected Schedule Type is PRN."
 . K X
 I $L(B)>0 D EN^DDIOL(.B,"","!") Q
 S A=$$GET1^DIQ(51.1,DA,2),B=""
 Q
 ;
CHKORD ;Check order of days in DOW schedule name
 N I,J,L,N,P,W
 S N=$P(X,"@"),L=0,P=$L(N,"-"),W="SUNDAYS,MONDAYS,TUESDAYS,WEDNESDAYS,THURSDAYS,FRIDAYS,SATURDAYS"
 F I=1:1:P F J=1:1:7 I $P($P(W,",",J),$P(N,"-",I))="" K:J'>L X Q:'$D(X)  S:J>L L=J
 Q
 ;
RMTIME ;Remove ward times when schedule becomes odd
 N R
 S R=0 F  S R=$O(^PS(51.1,D0,1,R)) Q:R=""  K ^PS(51.1,D0,1,R)
 Q
