YSCEN24 ;ALB/ASF-CUSTOM PATIENT LIST ;4/3/90  10:19 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 ; Called from the top by MENU option YSCENCL
 ;
 W @IOF,!!?IOM-$L("P A T I E N T  D A T A   F I E L D   S E A R C H")\2,"P A T I E N T  D A T A   F I E L D   S E A R C H",!!
RD ;
 R !,"Search for (M)issing data or (D)isplay data? M// ",X:DTIME S YSTOUT='$T,YSUOUT=X["^" G:YSTOUT!YSUOUT END S X=$TR($E(X_"M"),"md","MD") I X="M" G MIS
 I X="D" G HERE
 W !!,$C(7),"enter 'M' to list patients with missing data",!,"enter 'D' to list a unique data field for each patient by team",! G RD
1 ;
 S DIC("A")="Select patient data field on which to search: ",DIC="^DD(618.4,",DIC(0)="AEQMNZ" D ^DIC K DIC Q:Y<1  S YSENT=+Y,YSGL1=$P(^DD(618.4,YSENT,0),U,4),YSG=+YSGL1,YSPE=$P(YSGL1,";",2)
 S L=$P(^DD(618.4,YSENT,0),U),YSTP=$P(^(0),U,2),YSPOIN=$P(^(0),U,3)
 Q
 ;
HERE ;
 D 1 G:Y<1 END S YSOPT1L="  "_L_"  listing",YSOPT1="EN^YSCEN24",P=1,(Q3,P1)=0 D UN^YSCEN2 G:Y<1 END K IOP S %ZIS="Q" D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTRTN="ENHR^YSCEN24",ZTDESC="YS IP HERE" F ZZ="L","YSTP","YSPOIN","YSENT","YSGL1","YSG","YSPE","W1","P1","W2","Q3","YSOPT1","YSOPT1L" S ZTSAVE(ZZ)=""
 I  D ^%ZTLOAD W !,$S($D(ZTSK):"QUEUED",1:"Not queued"),$C(7) G END
ENHR ;
 U IO D FS0^YSCEN S YSAOR=0 F  S YSAOR=$O(^YSG("SUB","AOR",W1,YSAOR)) Q:'YSAOR  S T6=$O(^(YSAOR,0)) Q:'T6!Q3  K ^UTILITY($J) W @IOF D L2^YSCEN2,L3^YSCEN2,WAIT^YSCEN1
 G END0^YSCEN2
EN ;
 G EN1:+YSTP,EN22:YSTP?1"C".E S T=$P($G(^YSG("INP",DA,YSG)),U,YSPE) G PT:T="" I YSTP?.E1"P".E S T=@("^"_YSPOIN_"T,0)"),T=$P(T,U)
 I YSTP?.E1"D".E S Y=T D DD^%DT S T=Y
 I YSTP?.E1"S".E F ZZ=1:1 S K=$P(YSPOIN,";",ZZ) Q:K=""  S K1=$P(K,":"),K2=$P(K,":",2) I T=K1 S T=K2 Q
PT ;
 W !?3,L,": ",$S(T]"":T,1:" **missing**") Q
EN1 ;
 G COM^YSCEN22:YSENT=18 S Z=0 F  S Z=$O(^YSG("INP",DA,6,Z)) Q:'Z  S Z1=^(Z,0),Z(1)=$P(^YSG("SUB",+Z1,0),U),Y=$P(Z1,U,2) D DD^%DT,EN11
 W ! Q
EN11 ;
 S YSB=$P(Z1,U,3) S:YSB YSB=$P(^VA(200,YSB,0),U) W !?3,"Past team: ",Z(1)," on ",Y W:YSB?1A.E " by ",YSB
 Q
EN22 ;
 K X S D1=YSDFN,X5=$P(^DD(618.4,YSENT,0),U,5,99) X X5 W !?3,L," : ",$S('$D(X):"Missing",$D(X)&(X]""):X,1:"missing") K X5 Q
 ;
MIS ;
 K YSOPT1,YSOPT2 D 1 G:Y<1 END S (P,P1,Q3)=0 D UN^YSCEN2 G:Y<1 END K IOP S %ZIS="Q" D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTRTN="ENMSQ^YSCEN24",ZTDESC="YS IP MISS" F ZZ="L","YSTP","YSPOIN","YSENT","YSGL1","YSG","YSPE","W1","P1","W2","Q3" S ZTSAVE(ZZ)=""
 I  D ^%ZTLOAD W !,$S($D(ZTSK):"QUEUED",1:"Not queued"),$C(7) G END
ENMSQ ;
 W @IOF D FS0^YSCEN K ^UTILITY($J) S YSAOR=0 F  S YSAOR=$O(^YSG("SUB","AOR",W1,YSAOR)) Q:'YSAOR  S T6=$O(^(YSAOR,0)) Q:'T6  D L2^YSCEN2
MIS1 ;
 D MLB S A5="" F  S A5=$O(^UTILITY($J,A5)) Q:A5=""!Q3  D MIS2
 G END0^YSCEN2
MIS2 ;
 S YSDFN=0 F  S YSDFN=$O(^UTILITY($J,A5,YSDFN)) Q:'YSDFN!Q3  S DA=^UTILITY($J,A5,YSDFN) D MIS3 D:$Y+4>IOSL WAIT^YSCEN1,MLB
 Q
MIS3 ;
 S G=$D(^YSG("INP",DA,YSG)) I 'G D NM Q
 I YSTP?1"C".E S G=$P(^DD(618.4,YSENT,0),U,5,99),D1=YSDFN K X X G S:'$D(X) X="" D NM:X'?1ANP.E Q
 I '+YSTP S T=$P(^YSG("INP",DA,YSG),U,YSPE) I $S($D(T):T="",1:1) D NM Q
 I +YSTP S T=$D(^YSG("INP",DA,YSG)) I T<10 D NM Q
 Q
NM ;
 W !,A5,?33 S T=^YSG("INP",DA,0),T(1)=$P(T,U,4) W:T(1) $P(^YSG("SUB",T(1),0),U) S T=$P(T,U,3) W ?60,$E(T,4,5)_"/"_$E(T,6,7)_"/"_$E(T,2,3)
 Q
MLB ;
 Q:Q3  W @IOF,W2 D TIME^YSCEN2 W !,"The following patients have ",L," missing:",!?3,"name",?33,"team",?60,"ward entry date",! Q
END ;
 G END^YSCEN2
