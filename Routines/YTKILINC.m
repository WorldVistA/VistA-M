YTKILINC ;SLC/TGA-KILL INCOMPLETE TESTS ;11/19/90  16:41 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 ; Called from the top by MENU option YSKILLINC
S ;
 W !!,"This option deletes incomplete tests and interviews which",!,"have been incomplete for longer than 30 days."
 W !!,"Are you sure you wish to delete discontinued sessions now? N// " R A:DTIME S YSTOUT='$T,YSUOUT=A["^" G:YSTOUT!YSUOUT END S A=$TR($E(A_"N"),"yn","YN") G END:"N"[A I "Y"'[A W:A'["?" " ?",$C(7) G S
 W !!,"I will list any instruments I delete.",!! S %ZIS="Q" D ^%ZIS G:POP END I $D(IO("Q")) S ZTRTN="ENP^YTKILINC",ZTDESC="YS MH INST DELETE" D ^%ZTLOAD G END
ENP ;
 S YSLFT=0 U IO D HD F P=0:0 S P=$O(^YTD(601.4,P)) Q:'P  F T=0:0 S T=$O(^YTD(601.4,P,1,T)) Q:'T  S X2=$P($G(^(T,0)),U,2) D D
 Q:YSLFT  I IOST?1"C-".E D WAIT^YSUTL
 W ! D KILL^%ZTLOAD,^%ZISC
END ;
 K %Y,A,DA,DIK,P,T,X,X1,X2,YSLFT,YSX,Z,ZTSK Q
D ;
 K %Y S X1=DT D ^%DTC I $D(%Y),%Y,X<31 Q
 I $Y+$S(IOST?1"C-".E:3,1:5)>IOSL D WAIT^YSUTL:IOST?1"C-".E G:YSLFT END D HD
 S YSX=X,DIK="^YTD(601.4,P,1,",DA(1)=P,DA=T D ^DIK W !,"DELETED ",$S($D(^YTT(601,T,0)):$P(^(0),U),1:"UNKOWN INSTRUMENT")," FOR ",$S($D(^DPT(P,0)):$P(^(0),U),1:"UNKNOWN PATIENT")," - ",$S(YSX:YSX,1:"?")," DAYS OLD" Q
HD ;
 W @IOF,!,"Deleted Incomplete Tests/Interviews",!!
