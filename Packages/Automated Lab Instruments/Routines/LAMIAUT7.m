LAMIAUT7 ;FHS/SLC - CREATE LOAD LIST FOR VITEK ;7/20/90  09:34
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**42**;Sep 27, 1994
EN ;
 S U="^",(LROPEN,LREND)=0 D DT^LRX S LRAD=DT K ^TMP("LR",$J,"T"),DIC,LRHOLD,LRTSTS
 K DIC S DIC="^LRO(68.2,",DIC(0)="AEMZ" D ^DIC S LRINST=+Y Q:Y<1
 I $P(Y(0),U,12) S LRP=12 D ACCESS I LREND W !!?10,"Access denied to this Load  Work list " G EXIT
 I $S($D(^LRO(68.2,LRINST,3)):$P(^(3),U,1),1:0) W !?10,"Load list is busy now.  Try later" G EXIT
 L ^LRO(68.2,LRINST,3):1 I '$T W !!?7,$C(7),"Some one else is editing this List",!! G EXIT
 S $P(^LRO(68.2,LRINST,3),U,1)=1,LROPEN=1 L
CLEAR ;
 K LRCTRL,LRDSPEC,LRTP
 G:'$D(^LRO(68.2,LRINST,0)) EXIT S Y(0)=^(0),LRTRANS=+$P(Y(0),U,2),LRTYPE=+$P(Y(0),U,3),LRFULL=$P(Y(0),U,5),LRINSTIT=+$P(Y(0),U,7),LRMAXCUP=$S($P(Y(0),U,4):$P(Y(0),U,4),1:30)
 D CLEAR^LAMIAUT8
 S Y(2)=$S($D(^LRO(68.2,LRINST,2)):^(2),1:""),LRTRAY=$S($P(Y(2),U,4):$P(Y(2),U,4),1:1),LRCUP=$S($P(Y(2),U,5):$P(Y(2),U,5),1:0)
 S LRTRANS=$S($D(^LAB(62.07,LRTRANS,.1)):^(.1),1:"S LRCUP=LRCUP+1"),LRINSTIT=$S($D(^LAB(62.07,LRINSTIT,.1)):^(.1),1:"Q")
 S LRP=$P(^LRO(68.2,LRINST,10,$O(^LRO(68.2,LRINST,10,0)),0),U,2),LRP=$P(^LRO(68,LRP,0),U,3)
 S %DT="AEP",%DT("A")=" Accession Date : ",%DT("B")=$S(LRP="D":LRDT0,1:$$FMTE^XLFDT($E(DT,1,3)_"0000","1D")) D DATE^LRWU I Y<1 S LRO(68.2,LRINST,3)=0 G EXIT
 S LRAD=+Y,LRALL=0 S:'LRTYPE LRTRAY=1 I '$O(^LRO(68.2,LRINST,10,0)) W !!?10,"No profile defined for this Load/List ",$C(7) G EXIT
PROF ;
 S LRALL=0 W !?5,"ALL PROFILES " S %=2 D YN^DICN G:%<0 EXIT S:%=1 LRALL=1 I %=2 K DIC S DIC="^LRO(68.2,"_LRINST_",10,",DIC(0)="AQEZ" D ^DIC G:Y<1 EXIT S LRPROF=+Y D PROF^LAMIAUT8 I LREND D EXIT Q
 I %=0 W !!?5,"You may select a single profile or all profiles defined. ",!! G PROF
 I LRALL F LRPROF=0:0 S LRPROF=$O(^LRO(68.2,LRINST,10,LRPROF)) Q:LRPROF<1  D PROF^LAMIAUT8 I LREND D EXIT Q
 I '$D(LRAA) W !!?10,"No Accession area defined ",! D EXIT Q
 I 'LRAA W !!?10,"No Accession area defined",! D EXIT Q
ACCN ;get list of accession numbers
 K LRACNL W !?5,"Enter your list of accession numbers separated by ',' or - ",!,"You can string them together, example  1,2,3-6,7,110. ",!
 F A=1:1 R !,"Enter Acc #(s) ",X:DTIME S:'$T LREND=1 Q:X=""!(LREND)  G EXIT:$E(X)="^" D ^LRWU2 S:$L(X9) LRACNL(A)=X9 I '$L(X9) W !!?10,"Incorrect format ",$C(7),!!
 G EXIT:'$O(LRACNL(0))!(LREND) D CHK G EXIT:LREND
 I $O(^TMP("LR",$J,"T",0)) D STUFF^LAMIAUT8 S LRINSTS=LRINST D ^LRLLP S LRINST=LRINSTS
EXIT ;
 S:LROPEN ^LRO(68.2,LRINST,3)=0 K LROPEN,%,AA,C,DUOUT,I,J,LAST,LRAA,LRAD,LRAN,LRCT,LRCTRL,LRCUP,LRDSPEC,LREND,LRINST,LRKEY,LRP,LRPROF,LRINSTS,LRSPEC,LRTP,LRTRANS,LRTRAY
 K LRURG,T,X,Y,LRFULL,LRACNL,LRALL,LRINSTIT,^TMP("LR",$J,"T")
 Q
ACCESS ;
 S LRKEY=+$P(Y(0),U,LRP),LRKEY=$S($D(^DIC(19.1,LRKEY,0)):$P(^(0),U),1:0),LREND=$S($D(^XUSEC(LRKEY,DUZ)):0,1:1)
 Q
CHK ;
 S P=0 F A=0:0 S A=$O(LRACNL(A)) Q:A=""  X LRACNL(A)_"S:$D(^LRO(68,LRAA,1,LRAD,1,T1,0)) X=+^(0)_U_+^(5,1,0),^TMP(""LR"",$J,""T"",T1)=X"
SHOW ;
 S A=0 D HDR F A=A:0 S A=$O(^TMP("LR",$J,"T",A)) Q:A=""  S LRDFN=+^(A),X=^LR(LRDFN,0),LRDPF=$P(X,U,2),DFN=$P(X,U,3) D PT^LRX W !,A_")",?15,PNM,?35,SSN D:$Y>20 WAIT Q:LREND
WAIT ;
 W !!,?10,$S(A>0:"Is this partial list correct ",1:" All OK ? ") S %=1 D YN^DICN I %=1 D HDR Q
 I %<1 S LREND=1 Q
W1 W !!,"(A)dd OR (D)elete " R W:DTIME I '$T!($E(W)="^") S LREND=1 Q
 Q:W=""  I "AD"'[W W !,$C(7) G W1
 F WW=0:0 W !?5,"Enter number to "_$S(W="A":"Add ",1:"Delete ") R X:DTIME Q:'$T!(X="")!($E(X)="^")  D:X'="?" @($S(W="A":"ADD",1:"DELETE")_"^LAMIAUT8") I X="?" W !?10,"Enter accession number, one at a time."
HDR ;
 W @IOF,!!!,"Acc #)",?15," Patient Name           SSN ",!! Q
