YSPROB2 ;SLC/DKG-PROB LIST CONTINUED ;4/20/92  17:51 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
UN ; Called by routine YSPROB, YSPROB1
 W $C(7),!!!,"Uncertain indicates insufficient information to make a decision"
 W !!?3,"Do you want ",X
 W !!?3,"With indicator '",Z,"'"
 R !!?3,"on the problem list? Y// ",YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" S YSA=$TR($E(YSA_"Y"),"yn","YN") Q:YSTOUT!YSUOUT  W ! I "YN"'[YSA W:YSA'["?" $C(7)," ?" G UN
 I "N"[YSA W "  ?? " Q
 I '$D(^YS(615,YSDFN,P4)) D IN Q:Y'>0
 S DIE="^YS(615,YSDFN,P4,",DA(1)=YSDFN,(DA,P5)=10 S S3="J"
 I '$D(^YS(615,YSDFN,P4,DA,0)) S DR=".01///"_DA_";2///"_P5_";3;4///NOW;5///^S X=""`""_DUZ;6///"_S3 D IN1
 E  W $C(7),!!?3,"Problem '",X,"' is already on the problem list." S DR="3;4;"
 W ! L +^YS(615,YSDFN) D ^DIE S YSTOUT=$D(DTOUT) S:'$D(^YS(615,YSDFN,P4,DA,1,0)) ^(0)="^615.02P^^" L -^YS(615,YSDFN)
 Q:YSTOUT  S SCR=S3,DIC="^YS(615,YSDFN,P4,DA,1,",DIC(0)="LMZ",DLAYGO=615,X=Z D ^DIC
 W !!?3 W:'$P(Y,U,3) $C(7) W "Indicator '",Z,"'",!?3,$S($P(Y,U,3):"has been added to",1:"is already on")," the problem list.",!
IS ;
 S DA(1)=YSDFN,DA=P5,DIE="^YS(615,YSDFN,P4,",DR="8///NOW",DR(2,615.03)=".01//NOW;1"_";4///^S X=""`""_DUZ" L +^YS(615,YSDFN) D ^DIE L -^YS(615,YSDFN) S YSTOUT=$D(DTOUT)
 Q
 ;
EP ; Called by routine YSPROB, YSPROB1
 I '$D(^YS(615,YSDFN,P4)) D IN Q:Y'>0
 S DA(1)=YSDFN,DIC="^YS(615,YSDFN,P4,",DIC(0)="LMQZ",DLAYGO=615 D ^DIC Q:Y'>0
AP ; Called by routine YSPROB, YSPROB1, YSPROB3
 I '$D(^YS(615,YSDFN,P4)) D IN Q:Y'>0
 S DIE="^YS(615,YSDFN,P4,",DA(1)=YSDFN,(DA,P5)=+Y S S3=$P(^DIC(620,P5,0),U,2)
 I '$D(E2) W $C(7),!!?3,X," is already on the problem list",!
 S DR="2///"_P5_";3;4///"_DT_";5///^S X=""`""_DUZ;6///"_S3
 D R1 I E3 K S4,E3 Q
 W ! S DIE("NO^")=1 L +^YS(615,YSDFN) D ^DIE I DA=27 S DR=1 D ^DIE
 L -^YS(615,YSDFN) S YSTOUT=$D(DTOUT) I YSTOUT D CLNUP Q
AP1 ;
 S YSA="N" R !!,"Do you want to see the INDICATORS associated with this problem? N// ",YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G:YSTOUT!YSUOUT CLNUP G:"Nn"[YSA IND I "YyNn"'[YSA W:YSA'["?" $C(7)," ?" G AP1
 S N7="",I3=0 W @IOF,!!,"INDICATORS for ",$P(^DIC(620,DA,0),U)," problem. ",!
N7N ;
 S N7=$O(^DIC(625,"A",N7)) G:N7="" IND G:N7'[S3 N7N
 S I3=0
I3 ;
 S I3=$O(^DIC(625,"A",N7,I3)) G:'I3 N7N W !?3,$P(^DIC(625,I3,0),U) G I3
IND ;
 S DR=7,DR(2,615.02)=".01;I X'=217 S Y=2;1;2///`"_DUZ_";3///"_DT L +@(DIE_"DA)") D ^DIE L -@(DIE_"DA)") S YSTOUT=$D(DTOUT) Q:YSTOUT
 D ENDTM^YSUTL S DA(1)=YSDFN,DA=P5,DIE="^YS(615,YSDFN,P4,",DR="8//NOW",DR(2,615.03)=".01//NOW;1;S:X'=""RF"" Y=4;2;S R=X;4///^S X=""`""_DUZ" L +@(DIE_"DA)") D ^DIE L -@(DIE_"DA)") S YSTOUT=$D(DTOUT) Q:YSTOUT
 I $D(^YS(615,YSDFN,P4,DA,2,D1,0)),$P(^(0),U)["." L +^YS(615,YSDFN) S ^YS(615,YSDFN,P4,DA,2,D1,0)=YSDTM_U_$P(^(0),U,2,6) L -^YS(615,YSDFN)
 K DIE("NO^") D:$D(R) ^YSPROB3
 K R,DIC("A"),N1 Q
ENH ;
 S H="PROBLEM LIST FOR "_YSNM_"   "_YSSEX_"   AGE "_YSAGE
 Q
 ;
IN ;  Called by routine YSPROB
 N DIC,DLAYGO,X
 S DIC="^YS(615,",DIC(0)="XL",X="`"_YSDFN,DLAYGO=615 D ^DIC Q:Y'>0  S:'$D(^YS(615,YSDFN,P4,0)) ^(0)="^615.01PA^^"
 Q
R1 ;
 S (S4,E3)=0
S4 ;
 S S4=$O(^YS(615,YSDFN,P4,DA,2,S4)) Q:'S4  S R1=$P(^(S4,0),U,2)
 I R1="RF"!(R1="RS") S R2=$S(R1="RF":"reformulated!",R1="RS":"resolved!",1:"permanently changed!") W $C(7),!!?3,$P(^DIC(620,+Y,0),U)," has been ",R2
S41 ;
 I R1="RF"!(R1="RS") W !!?3,"Are you sure you want to edit ",$P(^DIC(620,+Y,0),U) R "? N// ",YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" S:YSA="" YSA="N" S:YSUOUT!("Nn"[YSA) E3=1 Q:"YyNn^"[YSA  W:YSA'["?" " ?",$C(7) G S41
 G S4
IN1 ;
 S P1=$P(^YS(615,YSDFN,P4,0),U,3),P2=$P(^(0),U,4)
 S:DA>P1 P1=DA L +^YS(615,YSDFN) S ^YS(615,YSDFN,P4,0)=$P(^YS(615,YSDFN,P4,0),U,1,2)_U_P1_U_(P2+1) L -^YS(615,YSDFN) K P1,P2
 Q
CLNUP ;
 K ^YS(615,YSDFN,P4,DA) S YSNO=$P(^YS(615,YSDFN,P4,0),U,4) S $P(^YS(615,YSDFN,P4,0),U,4)=YSNO-1 K YSNO
 Q
HELP1 ; Called by routine YSPROB
 W !!?3,"""YES"" will display potential problem areas." Q
HELP2 ; Called by routine YSPROB
 W !!?3,"""YES"" will display a list of problems presently recorded." Q
HELP3 ; Called by routine YSPROB, YSPROB1
 W !!?3,"""YES"" will permit change of presently recorded data." Q
HELP4 ; Called by routine YSPROB, YSPROB1
 W !!,"""YES"" will allow further refinement of this problem area.",!,"""NO"" will by pass this problem area.",!,"""U"" indicates insufficient information to make a decision.",! Q
HELP5 ; Called by routine YSPROB, YSPROB1
 W !!,"""D"" accesses the coding struture of the DSM.",!,"The alternate entry accesses the ""Problem List"" as defined by this system.",! Q
HELP6 ; Called by routine YSPROB1
 W !!,"""D"" access the coding structure of the ICD-9.",!,"The alternate entry accesses the ""Problem List"" as defined by this system.",! Q
