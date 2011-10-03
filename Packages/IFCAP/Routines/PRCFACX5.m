PRCFACX5 ;WISC@ALTOONA/CTB-BUILD OUTPUT MAP ;4/12/93  14:15
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
ONE ;BUILD MAP FOR ONE TEMPLATE
 K MAP,Q S:$D(PRCF("X")) X=PRCF("X")
 S MAP=1,MAP(1)="",DIC("A")="Select Template Name: ",DIC=.402,DIC(0)=$S($D(PRCF("X")):"M",1:"AEM"),DIC("S")="S ZXX=^(0) I $P(ZXX,U,4)=423,""PRCH""=$E(ZXX,1,4)!(""PRCFA TT""=$E(ZXX,1,8))!(""PRCA""=$E(ZXX,1,4))" D ^DIC K DIC,ZXX G:Y<0 OUT
 S X=$P(Y,"^",2),Y=$O(^PRCD(422,"B",X,0)) I Y="" S DIC(0)="LM",(DIC,DLAYGO)=422 D ^DIC K DIC,DLAYGO G:+Y<0 OUT
 S DA=+Y D BUILD I $D(PRCF("X")) K PRCF("X") G OUT
 S X="---Done---" D MSG^PRCFQ G ONE
ALL ;REBUILD ALL MAPS
 S %A="This program deletes all template maps and recreates them from the",%A(1)="input templates found in file 420.4.  OK to continue",%B="" D ^PRCFYN Q:%'=1
INIT ;ENTRY POINT TO INITIALIZE ALL MAPS WITHOUT INTERACTION
 K ^TMP($J) S A=$P(^PRCD(422,0),"^",1,2) K ^PRCD(422) S ^PRCD(422,0)=A K A
 W ! S TEM=0 F XI=1:1 S TEM=$O(^PRCD(420.4,TEM)) Q:'TEM  W "." S X=$P(^(TEM,0),"^",3) I X]"" S X=$P($P(X,"]"),"[",2) I '$D(^TMP($J,X)) D A
 K ^TMP($J) Q
A S (DIC,DLAYGO)=422,DIC(0)="MZL" D ^DIC K DLAYGO I Y>0,$P(Y,"^",3)=1 W !,Y(0,0) S ^TMP($J,X)="" K MAP,Q S MAP=1,MAP(1)="" S DA=+Y D BUILD K C,DA,I,Y Q
 Q
OUT K PRCF("X"),C,D0,D1,DA,DDD,DIC,DIE,DIR,DR,I,IOY,MAP,M,POP,X,Y,Z Q
BUILD S X=$P(^PRCD(422,DA,0),"^"),DIC=.402,DIC(0)="X" D ^DIC K DIC I Y<0 S X="Unable to locate template in file .402, no action taken.*" D MSG^PRCFQ Q
 S DIEDA=+Y
 F I=0:0 S I=$O(^DIE(DIEDA,"DR",I)) Q:I=""  F M=0:0 S M=$O(^DIE(DIEDA,"DR",I,M)) Q:M=""  S Q("DRSTRING",I,M)=^DIE(DIEDA,"DR",I,M) F N=0:0 S N=$O(^DIE(DIEDA,"DR",I,M,N)) Q:'N  S Q("DRSTRING",I,M,N)=^(N)
 S STRING=Q("DRSTRING",1,423) D X S N=0 F J=1:1 S N=$O(Q("DRSTRING",1,423,N)) Q:'N  S STRING=Q("DRSTRING",1,423,N) D X
 K ^PRCD(422,DA,1) S N=0 F I=1:1 S N=$O(MAP(N)) Q:'N  S ^PRCD(422,DA,1,N,0)=MAP(N)
 S ^PRCD(422,DA,1,0)="^422.01A^"_(I-1)_"^"_(I-1)
 K A,B,C,DA,DIEDA,I,J,M,N,Q,STR,STRING,X,Y
 Q
 ;S N=0,N=$O(^DIE(DA,"DR",I,M,N)) Q:N=""  S Q("DRSTRING",I,N)=^(N)
 Q
SINGLE S B=$P(B,U,3),X=+A I $D(^DD(423,+A,2.1)),^(2.1)["PRCHLOG"!(^(2.1)["PRCF(""OUT"")") S X=X_"T"
 S X=X_";"_B_"\" I $L(MAP(MAP))+$L(X)>200 S MAP=MAP+1,MAP(MAP)=""
 S MAP(MAP)=MAP(MAP)_X
 Q
MULTI S X=A_";"_+$P(B,"^",3)_";"_+B,STR=Q("DRSTRING",2,+B) D
  . I $L(MAP(MAP))+$L(X)>200 S MAP=MAP+1,MAP(MAP)=""
  . S MAP(MAP)=MAP(MAP)_X S X=""
  . Q
 F JJ=1:1 S AA=$P(STR,";",JJ) Q:AA=""  I +AA>0,$D(^DD(+B,+AA,0)) D
  . S BB=$P(^DD(+B,+AA,0),"^",4),X=","_+AA_";"_BB
  . I $L(MAP(MAP)_X)>200 S MAP(MAP)=MAP(MAP)_"~",X="~"_$P(X,",",2,999),MAP=MAP+1,MAP(MAP)=""
  . S MAP(MAP)=MAP(MAP)_X
  . Q
 S MAP(MAP)=MAP(MAP)_"\" K II,JJ,AA,BB Q
X F I=1:1 S A=$P(STRING,";",I) Q:A=""  I +A>0,$D(^DD(423,+A,0)) S B=$P(^(0),"^",2,4),B(3)=$S(+$P(B,U)=0:"SINGLE",1:"MULTI") D @(B(3))
