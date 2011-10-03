YTKIL ;SLC/TGA-KILL TEST/INTERVIEW DATA ;4/21/92  08:50 ; 10/31/07 12:41pm
 ;;5.01;MENTAL HEALTH;**37,85,100**;Dec 30, 1994;Build 2
 ;
 ; Called from the top by MENU option YSMKIL
 ;
 S YSO=0,YSNOKILL=1 W @IOF,!!,"Delete Patient Data"
 W ! D ^YSLRP G:YSDFN<1 END
 S DIR(0)="Y",DIR("A")="Delete MH administration/test data",DIR("B")="No" D ^DIR
 Q:$G(DIRUT)
 IF Y D EN^YTQKIL Q  ;-->out
 I '$D(^YTD(601.2,YSDFN)),'$D(^YTD(601.4,YSDFN)) W !!,"NO DATA ON THIS PATIENT!" G END
R ;
 R !!,"Delete All tests and interviews? N// ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" G:YSTOUT!YSUOUT END S A=$TR($E(A_"N"),"yn","YN") I "YN"'[A W:A'["?" " ?",$C(7) G R
 I "Y"[A S DIK="^YTD(601.2,",DA=YSDFN D ^DIK S DIK="^YTD(601.4,",DA=YSDFN D ^DIK W !!,"DELETED!" G END
 S T(0)=0 G:'$O(^YTD(601.4,YSDFN,1,0)) C W !!,"Incomplete tests and Interviews",! S YTC=$O(^YTT(601,"B","CLERK",0))
 S T=0
 F  S T=$O(^YTD(601.4,YSDFN,1,T)) G:'T C S T(0)=T(0)+1 G:YSTOUT!YSUOUT END S X=^(T,0),P=$P(X,U),D=$P(X,U,2),DA=P S:P=YTC P=$P(X,U,6),DA=YTC W !!,$$TN(+YSDFN,+T,+P),?10,$$FMTE^XLFDT(D,"5ZD") D DI
DI ;
 R " ...Delete? N// ",K:DTIME S YSTOUT='$T,YSUOUT=K["^",K=$E(K) Q:"Nn"[K  I YSTOUT!YSUOUT Q
 I "Yy"'[K W:K'["?" " ?",$C(7) G DI
 S DIK="^YTD(601.4,YSDFN,1,",DA(1)=YSDFN D ^DIK W ?40,"DELETED!" Q
C ;
 G:'$D(^YTD(601.2,YSDFN,1,0)) E W !!,"Completed Tests and Interviews"
 S T=0
 F  S T=$O(^YTD(601.2,YSDFN,1,T)) G:'T!YSUOUT END F D=0:0 S D=$O(^YTD(601.2,YSDFN,1,T,1,D)) Q:'D  S T(0)=T(0)+1 Q:YSTOUT!YSUOUT  Q:'$D(^YTT(601,T))  W !!,$P(^YTT(601,T,0),U),?10,$$FMTE^XLFDT(D,"5ZD") D DC
DC ;
 R " ...Delete? N// ",K:DTIME S YSTOUT='$T,YSUOUT=K["^",K=$E(K) Q:"Nn"[K  I YSTOUT!YSUOUT Q
 I "Yy"'[K W:K'["?" " ?",$C(7) G DC
 S DIK="^YTD(601.2,YSDFN,1,T,1,",DA=D,DA(1)=T,DA(2)=YSDFN D ^DIK W ?40,"DELETED" Q
E ;
 W:'T(0) !!,"NO TESTS/INTERVIEWS FOUND!"
END ;
 K %,A,D,DA,DIC,DIK,K,P,T,X,YSAGE,YSDFN,YSDOB,YSE,YSN,YSNM,YSNOKILL,YSO,YSS,YSSEX,YSSSN,YTC
 QUIT
 ;
TN(DFN,TN6014,TN601) ;Print test name...
 ; TN6014 = IEN of ^YTD(601.4,+DFN,1,+TN6014...
 ; TN601  = IEN of ^YTT(601,+TN601...
 N TESTNAME,X
 S X=$P($G(^YTT(601,+TN601,0)),U),TESTNAME=$S(X']"":"Unknown",1:X)
 I $G(^YTD(601.4,+DFN,1,+TN6014,99))'="MMPIR" QUIT TESTNAME ;->
 QUIT $S(TN601=60:"MMPIR",TN601=61:"MMPR",1:"Unknown") ;->
 ;
