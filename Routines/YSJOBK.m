YSJOBK ;SLC/TGA-DELETES OLD JOBS FROM JOB BANK ; 12/2/88  09:15 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 ; Called from the top by MENU option YSJOBKILL
 ;
1 ;
 S C=0 W !!,$C(7),"This option will PURGE old entries.",!,"Are you usre you wish to use this option now" S %=2 D YN^DICN I %=2!(%<0) G END
 I '% G 1
2 ;
 S %DT("A")="DELETE JOBS THROUGH WHICH LISTING DATE: ",%DT="AEPX" D ^%DT G:Y<1 1 S D=Y
3 ;
 W !,"I WILL DELETE ALL JOBS LISTED THROUGH " S Y=D D DD^%DT W Y R "  OK?  N// ",X:DTIME S YSTOUT='$T,YSUOUT=X["^" G:YSTOUT!YSUOUT END G:"Nn^"[$E(X) 1 I "Yy"'[$E(X) W $C(7) G 3
 S I=0 F  S I=$O(^YSG("JOB","AC",I)) Q:'I!(I>D)  S J=0 F  S J=$O(^YSG("JOB","AC",I,J)) Q:'J  S N=$P($G(^YSG("JOB",J,0)),U) K ^YSG("JOB",J),^YSG("JOB","B",N,J),^YSG("JOB","AC",I,J) S C=C+1
 I C>0 S X=$P(^YSG("JOB",0),U,4),X=$S(X-C>0:X-C,1:0),^(0)=$P(^(0),U,1,3)_"^"_X
END ;
 W !!,C," JOBS DELETED" K %DT,C,D,I,J,N,X,Y Q
