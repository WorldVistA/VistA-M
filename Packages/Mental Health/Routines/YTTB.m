YTTB ;SLC/DKG-CREATE/DELETE TEST BATTERIES ; 7/10/89  11:34 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ; Called from the top by MENU option YSTESTBAT
 ;
 W @IOF,?IOM-$L("Test/Interview Battery Utility")\2,"Test/Interview Battery Utility",!!
 W !?3,"A test battery (e.g., 'BATA') allows administration of a set",!?3,"of tests/interviews by entering just the battery code.",!
OP ;
 R !!?3,"(C)reate battery, (D)elete battery, (P)rint list or (Q)uit: Q// ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" G END:YSTOUT!YSUOUT S A=$TR($E(A_"Q"),"cdpq","CDPQ") G:"Q"=$E(A) END I "CDP"'[A W:A'["?" $C(7)," ?" G OP
 G C:"C"[A,D:"D"[A,P:"P"[A
C ;
 S YSTANO=$$STANO($G(DUZ(2))) I YSTANO'>0 D  QUIT  ;->
 .  W !!!!!,"Batteries cannot be entered because your DUZ(2) is not properly defined!!"
 .  W !,"Please contact your IRM Service for assistance...",!!
 .  N DIR
 .  S DIR(0)="EA",DIR("A")="Hit RETURN to continue... "
 .  D ^DIR
 ;
 S YSLK=$D(^XUSEC("YSP",DUZ))
 R !!?3,"Create battery NAME: ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" G END:YSTOUT!YSUOUT,OP:A=""
 I $L(A)<3!($L(A)>5)!(A'?.UN) W $C(7),!!?3,"Enter 3 to 5 characters - upper case letters and numbers only",!?3,"(e.g., BATA or BAT1)" G C
 I $D(^YTT(601,"B",A)) W $C(7),!!?3,"There is already a test or test battery named ",A," in the package! " G C
 S YSK=0,L1="" K N
NB ;
 S YSK=YSK+1 W !!?3,"TEST ",YSK,"> " R L:DTIME S YSTOUT='$T,YSUOUT=L["^" G END:YSTOUT!YSUOUT,FB:L=""
 I L["?" S YSXT="" D ENTB^YTLIST S YSK=YSK-1 G NB
 S L=$E(L,1,5) S N=$O(^YTT(601,"B",L,0)) I 'N W $C(7),!!?3,"No instrument ",L," in the package" S YSK=YSK-1 G NB
 S N(0)=$G(^YTT(601,N,0)) I $P(N(0),U,14)="N" W $C(7),!!?3,"Copy righted, non-licensed tests can not be in a test battery! " S YSK=YSK-1 G NB
 I $P(N(0),U,9)="B" W $C(7),!!?3,"Batteries may not be included in batteries!" S YSK=YSK-1 G NB
 I 'YSLK&($P(N(0),U,8)'["V") W $C(7),!!?3,"You do NOT have the proper security to put this test on a battery!" S YSK=YSK-1 G NB
 I $D(N(N)) W !!?3,"Duplicate ignored!",$C(7) S YSK=YSK-1 G NB
NB1 ;
 I YSK>4 D  G END:YSTOUT!YSUOUT S A1=$TR($E(A1),"yn","YN") G OP:"N"[A1 I "Y"'[A1 W:A1'["?" $C(7)," ?" G NB1
 .W $C(7),!!?3,"There are now ",YSK," tests in the battery",!!,"Are you sure you want ",YSK R " tests in one battery? N// ",A1:DTIME S YSTOUT='$T,YSUOUT=A1["^"
 S L1=L1_N_U,N(N)="" G NB:YSK<10 W !!,"10 instruments is max!"
FB ;
 I $L(L1,U)<3 W !!?3,"No battery created",$C(7) G LB
FB1 ;
 ;  Get next 601 IEN in Station's number range...
 F YSDINUM=YSTANO_"000":1:YSTANO_999 Q:'$D(^YTT(601,+YSDINUM))
 I YSDINUM>(YSTANO_999) D  G YTTB ;->
 .  W !!,"No MH Instrument (#601) file internal entry numbers available!!"
 .  W !,"Please contact IRM Service for assistance...",!!
 .  N DIR
 .  S DIR(0)="EA",DIR("A")="Hit return to continue... "
 .  D ^DIR
 ;
 ;  All OK.  Enter test battery...
 S DINUM=+YSDINUM
 S X=A,DIC="^YTT(601,",DIC(0)="LX",DLAYGO=601,DIC("DR")="20///^S X=""B"";"
 D ^DIC
 S ^YTT(601,+Y,"A")="S YSXT=YSXT_"_""""_L1_""""
 W !!,"BATTERY ",A," created with ",YSK-1," instruments."
 H 3
LB ;
 K A,A1,DINUM,L,L1,N,X,YSDINUM,YSK,YSLK,YSTANO
 G YTTB
 ;
D ;
 R !!?3,"Delete battery: ",A:DTIME
 S YSTOUT='$T,YSUOUT=A["^" G END:YSTOUT!YSUOUT,OP:A=""
 I A["?" D ENP G D
 S X=$O(^YTT(601,"B",A,0))
 I 'X W $C(7),!!?3,"No battery with name ",A," on file. " G D
 I $P(^YTT(601,X,0),U,9)="B" S DIK="^YTT(601,",DA=X D ^DIK W !!?3,"Battery ",A," deleted! " G D
 W !!?3,$C(7),"There is an instrument by that name but it is not a battery!!"
 G D
 ;
STANO(SIEN) ;  Pass in station's IEN.  Station number returned...
 ;  SIEN = DUZ(2)
 N DA,DIC,DIQ,DR,YSDATA,YSTANO
 QUIT:$G(SIEN)'>0 "" ;->
 S DA=+SIEN,DIC=4,DR=99,DIQ="YSDATA",DIQ(0)="I"
 D EN^DIQ1
 S YSTANO=+$G(YSDATA(4,+SIEN,99,"I"))
 QUIT:YSTANO'>0 "" ;->
 QUIT YSTANO
 ;
P W ! K IOP S %ZIS="Q" D ^%ZIS K %ZIS G:POP END I $D(IO("Q")) K IO("Q") S ZTRTN="ENP^YTTB",ZTDESC="YS PSYCH INST BAT" D ^%ZTLOAD G END
ENP ;
 S:'$D(A) A=0 U IO W !! W:A'["?" @IOF W ?28,"CURRENT BATTERIES",!!,"NAME",?6,"INSTRUMENTS ON BATTERY"
 S I=0 F N=0:1 S I=$O(^YTT(601,"AI","B",I)) G:'I EP W !,$P(^YTT(601,I,0),U) S X=$P(^YTT(601,I,"A"),"""",2) F J=1:1 S Y=$P(X,U,J) Q:Y=""  W ?(J*6),$P(^YTT(601,Y,0),U)
EP ;
 I N=0 U IO(0) W $C(7),!!!?3,"No batteries on file!"
 Q:A["?"  D:IOST?1"C-".E WAIT^YSUTL K A,I,J,N,X,Y D KILL^%ZTLOAD W ! D ^%ZISC G OP:'$G(ZTSK)
END ;
 K A,A1,DA,DIK,I,J,K,L,L1,N,T,T1,X,Y,YSK,YSORD,YSLK,Z,ZTSK Q
