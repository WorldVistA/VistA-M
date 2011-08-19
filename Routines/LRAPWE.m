LRAPWE ;AVAMC/REG/CYM- DATE/TIME GRIDS SCANNED/PRINTS MADE ;2/13/98  11:07
 ;;5.2;LAB SERVICE;**72,201**;Sep 27, 1994
 S LRDICS="EM" D ^LRAP G:'$D(Y) END D EM^LRAPWE1 G:J END D S^LRAPST K Y
 W !!,"Ask 'Date/time grids scanned:' prompt for each accession " S %=2 D YN^LRU Q:%<1  S LRV=$S(%=2:0,1:1)
ASK S %DT="",X="T" D ^%DT S LRY=$E(Y,1,3)+1700 W !!,"Enter year: ",LRY,"// " R X:DTIME G:'$T!(X[U) END S:X="" X=LRY
 S %DT="EQ" D ^%DT G:Y<1 ASK S LRY=$E(Y,1,3),LRH(0)=LRY+1700 W "  ",LRH(0)
 S LRN="",LRAD=$E(LRY,1,3)_"0000"
 I '$O(^LRO(68,LRAA,1,LRAD,1,0)) W $C(7),!!,"NO ",LRO(68)," ACCESSIONS IN FILE FOR ",LRH(0),!! Q
W K LR("CK") W !!,"Select ",LRO(68)," Accession Number: ",LRN,$S(LRN:"//",1:"") R LRAN:DTIME G:'$T!(LRAN[U)!(LRN=""&(LRAN="")) END S:LRAN="" LRAN=LRN I LRAN'?1N.N S LRN="" W $C(7),!!,"Enter a number." G W
 S LRN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN)) S:LRN'=+LRN LRN="" D REST G W
REST W "  for ",LRH(0) I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) W $C(7),!!,"Accession # ",LRAN," for ",LRH(0)," not in ACCESSION file",!! Q
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRAC=$P($G(^(.2)),U),LRI=$P(^(3),U,5),LRDFN=+X Q:'$D(^LR(LRDFN,0))  S X=^(0) D ^LRUP
 S LRK(1)="" I LRV S %DT("A")="Date/time grids scanned: " D W^LRAPWU S:LRK<1 LRK="" S LRK(1)=LRK
 S %DT("A")="Date/time prints   made: " D W^LRAPWU S:LRK<1 LRK=""
 Q:'LRK(1)&('LRK)  D ^LRAPWU
 I F W $C(7),!!,"Use 'Blocks, Stains, Procedures, anat path' option to enter date",!,"grids (thin sections) processed. This must be done before entering date",!,"grids scanned, photos taken and prints made." Q
B Q:$D(LR("CK"))  K LR S LR=0 I '$D(IOF) S IOP="HOME" D ^%ZIS
 S LRA=^LR(LRDFN,LRSS,LRI,0),Y=+LRA D D^LRU S LRE=Y
 S LRM=0 D H F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A  S LRB=^(A,0) D:$Y>(IOSL-3) M Q:LRM[U  W !,$P(LRB,U) D S
 W !!,"Data displayed ok " S %=2 D YN^LRU Q:%<1  I %=1 D ^LRAPWE1 Q
 I LR S DIE="^LR(LRDFN,LRSS,",DA=LRI D CK^LRU Q:$D(LR("CK"))  W ! D ^LRAPWEA D FRE^LRU
 G B
S F E=0:0 S E=$O(^LR(LRDFN,LRSS,LRI,.1,A,E)) Q:'E  F B=0:0 S B=$O(^LR(LRDFN,LRSS,LRI,.1,A,E,B)) Q:'B!(LRM[U)  S LRB(1)=^(B,0) D:$Y>(IOSL-3) M Q:LRM[U  D T
 Q
T S Y=$G(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,LRW,0)) Q:Y=""  S X=$P(Y,U,2),Z=$P(Y,U,3),V=X+Z,LRZ(5)=$P(Y,U,5),LRZ(6)=$P(Y,U,6),LRZ(8)=$P(Y,U,8),LRZ(10)=$P(Y,U,10),LRZ(11)=$P(Y,U,11)
 S LR=LR+1,LR(LR)=A_U_E_U_B_U_V_U_LRZ(5)_U_LRZ(6)_U_LRZ(8)_U_LRZ(10)_U_LRZ(11)_U_$P(Y,U,13)_U_$P(Y,U,12)
 W !,"*",$J(LR,2),") ",$P(LRB(1),U),?15,$J(+LRZ(6),3),?24,$J(+LRZ(8),3),?33,$J(+LRZ(10),3),?40,$$FMTE^XLFDT(LRZ(5)),?60,$$FMTE^XLFDT(LRZ(11)) Q
 ;
M R !,"'^' TO STOP: ",LRM:DTIME S:'$T LRM=U D:LRM'[U H Q
H W @IOF,LRP," ",SSN(1)," Acc #: ",LRAC," Date: ",LRE,!,?15,"GRIDS",?24,"GRIDS",?32,"PRINTS",?40,"LAST DATE/TIME",?60,"LAST DATE/TIME"
 W !?5,"BLOCK ID",?14,"PREPARED",?23,"SCANNED",?33,"MADE",?44,"SCANNED",?62,"PRINTS MADE" Q
 ;
END D V^LRU Q
