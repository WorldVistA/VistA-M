LRSORA1 ;SLC/KCM - CREATE SEARCH LOGIC ; 8/5/87  11:40 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
EN W ! F J=1:1:LRTST W !,"-",$C(64+J),"-","   ",$P(LRTST(J,2),U,1) W:$P(LRTST(J,2),U,2)]"" " (",$P(LRTST(J,2),U,2),")" W " ",$P(LRTST(J,2),U,3)
 S LRA="A" F I=1:1:LRTST-1 S LRA=LRA_" OR "_$C(65+I)
 S Y=-1 F I=0:0 W !!,"Enter SEARCH LOGIC: ",LRA,"// " R X:DTIME S:'$T X="^" S:X["^" LREND=1 D:X["?" HLP0 S:'$L(X) X=LRA D:(X'["?")&(X'["^") PLOG Q:Y'<0!LREND
 S LRTST(0)=Y Q
PLOG F %=1:1 S T=$T(SWAP+%) Q:$P(T,";",3)="ZZZZ"  S LROLD=$P(T,";",3),LRNEW=$P(T,";",4) D PARSE
 S Y="" F %=1:1:$L(X) S:$E(X,%)'=" " Y=Y_$E(X,%)
 F %=1:1:$L(Y) S T=$A(Y,%) S LROK=0 D TSTLIM I 'LROK S Y=-1 Q
 I Y'=-1 S X="I "_Y D ^DIM S:'$D(X) Y=-1
STOP W:Y<0 " ??" K LRPNT,LROLD,LRNEW,LROK,LRI,LRJ,X,T,% Q
TSTLIM F LRJ=33,38,39,40,41,65:1:64+LRTST S:T=LRJ LROK=1
 Q
PARSE F LRI=1:1:$L(LROLD)-$L(LRNEW) S LRNEW=LRNEW_" "
 S LRPNT(0)=0 F LRI=1:1 S LRPNT(LRI)=$F(X,LROLD,LRPNT(LRI-1)) Q:LRPNT(LRI)=0
 F LRJ=1:1:LRI-1 S X=$E(X,1,LRPNT(LRJ)-$L(LROLD)-1)_LRNEW_$E(X,LRPNT(LRJ),99)
 Q
SWAP ;;LROLD;LRNEW; NOTE:  $L(LROLD) MUST BE >= $L(LRNEW)
 ;;AND;&
 ;;OR;!
 ;;NOT;'
 ;;,;&
 ;;ZZZZ
HLP0 W !!,"Enter a logical expression (i.e., A AND B OR C or A&B!C)."
 W !,"  NOTE:  AND will compare only values from the -same- accession."
 W !,"         To print all results that fall within the search criteria,"
 W !,"         accept the default search logic (OR)."
SUMMARY ;
 Q
SORTBY ;
 K DIR S DIR("B")="P",DIR("A")="Sort by PATIENT or by LOCATION"
 S DIR(0)="S^P:PATIENT;L:LOCATION",DIR("?")="Choose print sorting order."
 D ^DIR S:($D(DUOUT))!($D(DTOUT)) LREND=1 S:'LREND LRSRT=Y Q
PATS ;
 S LRPTS=0
 K DIC S DIC="^DPT(",DIC(0)="AEMQ",DIC("A")="Select PATIENT NAME: All//"
 F I=1:1 D ^DIC Q:Y=-1  S LRPTS(+Y)=$P(Y,U,2),DIC("A")="Select another PATIENT: ",LRPTS=I
 S:($D(DUOUT))!($D(DTOUT)) LREND=1 Q
LOCS ;
 S LRLCS=0
 K DIC S DIC="^SC(",DIC(0)="AEMQZ",DIC("A")="Select LOCATION: All//"
 F I=1:1 D ^DIC Q:Y=-1  D
 .S DIC("A")="Select another LOCATION: "
 .I $P(Y(0),U,2)="" D NOABRV Q:%'=1
 .S LRLCS($S($L($P(Y(0),U,2)):$P(Y(0),U,2),1:"NO ABRV"))=+Y,LRLCS=I
 S:($D(DUOUT))!($D(DTOUT)) LREND=1 K %,%Y  Q
NOABRV ;
 W !!,"The location you have selected does not have an abbreviation."
 W !,"If you use this location, the report will list all records without"
 W " location",!,"abbreviations (as long as they also meet the date and"
 W " patient selections)",!,"This may include data from several "
 W "locations, with no way to be sure which is",!,"which.  They will be "
 W "listed with the abbreviation of 'NO ABRV' or 'UNK'."
 S %=1 W !!,"Do you still want to select this location (Y/N)?//"
 D YN^DICN
 Q
