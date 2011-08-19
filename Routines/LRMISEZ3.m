LRMISEZ3 ;AVAMC/REG/SLC/BA - MICRO INF CTRL SURVEY CONT'D ; 10/1/87  17:15 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;from LRMISEZ2
A I LRM("L")'="A"!(LRM("O")'="A") S S="ORG" D ^LRMISEZ4
 S LRPG=0 D HDR1 I LRM("O")="S" S LRBG=0 F I=0:0 S LRBG=$O(^TMP($J,"SE",LRBG)) Q:LRBG=""  I LRM("O","S")=+$E(LRBG,4,25) S LRBUG=$P(^LAB(61.2,+$E(LRBG,4,25),0),U) D M
 I LRM("O")'="S" S LRBG=0 F I=0:0 S LRBG=$O(^TMP($J,"SE",LRBG)) Q:LRBG=""  S LRBUG=$P(^LAB(61.2,+$E(LRBG,4,25),0),U) D M
 Q
M S M=0 F I=0:0 S M=$O(^TMP($J,"SE",LRBG,M)),LRSUM=1 Q:M=""  S LRAD=$E(M,1,3)_"0000",Y=M_"00" D D^LRU S LRMY=Y D:$Y>61 HDR1 W !!,LRBUG,?34," ",LRMY S X=43 W ! D LIN,LLOC
 Q
LLOC S LRLLOC=0 F I=0:0 S LRLLOC=$O(^TMP($J,"SE",LRBG,M,LRLLOC)) Q:LRLLOC=""  D:$Y>61 HDR1,LD W !,LRLLOC D SIT
 Q
SIT S LRSIT=0 F I=0:0 S LRSIT=$O(^TMP($J,"SE",LRBG,M,LRLLOC,LRSIT)) Q:LRSIT=""  D:$Y>61 HDR1,LD,LC W !,?5,$S(LRSIT="Unknown":"Unknown",LRSIT(1)="S":$P(^LAB(61,$P(LRSIT,U,2),0),U),1:$P(^LAB(62,$P(LRSIT,U,2),0),U)) D AC
 Q
AC S LRAC=0 F I=0:0 S LRAC=$O(^TMP($J,"SE",LRBG,M,LRLLOC,LRSIT,LRAC)) Q:LRAC=""  D:$Y>61 HDR1,LD,LC,SITE D OR S LRSUM=LRSUM+1
 Q
OR S LROR=0 F I=0:0 S LROR=$O(^TMP($J,"SE",LRBG,M,LRLLOC,LRSIT,LRAC,LROR)) Q:LROR=""  S LRNAME=$O(^(LROR,0)),LRDAT=^(LRNAME) D:$Y>61 HDR1,LD,LC,SITE W !,?11,$J(LRSUM,4),")" D LIST
 Q
LIST W ?17,$J(LRAC,5),?23,$E($P(LRNAME,U),1,13),?38 S Y=+LRDAT,Y=+$E(Y,4,5)_"/"_+$E(Y,6,7) W Y,?43
 S LRLIN="",$P(LRLIN,"| ",O+1)="|"
 S LRYA=0 F I=0:0 S LRYA=$O(^TMP($J,"SE",LRBG,M,LRLLOC,LRSIT,LRAC,LROR,LRNAME,LRYA)) Q:LRYA=""  D NOD
 W LRLIN,!
 Q
NOD Q:'$D(LRZ(LRYA))  S $P(LRLIN,"|",LRZ(LRYA)+1)=^TMP($J,"SE",LRBG,M,LRLLOC,LRSIT,LRAC,LROR,LRNAME,LRYA)
 Q
HDR1 S LRPG=LRPG+1,%DT="T",X="N" D ^%DT,D^LRU W @IOF,!,Y,?21,"INFECTION CONTROL SURVEY REPORT BY ORGANISM",?70,"PAGE ",$J(LRPG,5)
 I LRLOS W !,?2,"** Reports only those specimens collected > ",LRLOS,$S(LRLOS>1:" days",1:" day")," from admission date **"
 W !,LRAAN,?6,"From: ",LRST," To: ",LRLST,?43 F I=0:0 S I=$O(B(I)) Q:I=""  W "|",$E($P(B(I),U,2),1)
 W "|",!,"Organism",?32,"Month/Year",?43 F I=0:0 S I=$O(B(I)) Q:I=""  W "|",$E($P(B(I),U,2),2)
 W "|",!,"Loc",?5,$S(LRSIT(1)="S":"Spec",1:"Sample"),?12,"Num",?17,"AC#",?23,"Patient",?38,"Date",?43 F I=0:0 S I=$O(B(I)) Q:I=""  W "|",$E($P(B(I),U,2),3)
 I $D(LRAP) W "|",!,?10,"** ANTIBIOTIC PATTERN **",?43 F I=0:0 S I=$O(B(I)) Q:I=""  W "|",$S($L($P(B(I),U,3)):$P(B(I),U,3),1:" ")
 W "|",! F A1=1:1:IOM-1 W "-"
 Q
LD W !!,LRBUG,?34," ",LRMY S X=43 W ! D LIN
 Q
LIN F A1=1:1:X W "-"
 Q
LC W !,LRLLOC
 Q
SITE W !,?5,$S(LRSIT="Unknown":"Unknown",LRSIT(1)="S":$P(^LAB(61,$P(LRSIT,U,2),0),U),1:$P(^LAB(62,$P(LRSIT,U,2),0),U))
 Q
