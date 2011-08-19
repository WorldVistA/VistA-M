LRBLDAA ;AVAMC/REG/CYM - DONOR/DEFERRAL LETTERS ;6/28/96  19:11 ;
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D EN1^LRBLY S X=$P(^LRO(69.2,LRAA,8,65.9,1,0),"^",4)
 W !!?29,"Post-visit letter list",! I X>0 W ?25,"There ",$S(X>1:"are ",1:"is "),X," donor",$S(X>1:"s",1:"")," on the list",!
ASK W !?25,"1. Add    a donor to   the list",!?25,"2. Remove a donor from the list",!?25,"3. Show the donors in  the list",!?25,"4. Delete the donor letter list",!?25,"5. Print  the donor letters"
 R !!,"Select 1, 2, 3, 4, or 5: ",X:DTIME G:X=""!(X[U) END I X<1!(X>5)&("ARSDP"'[$E(X))&("arsdp"'[$E(X)) W $C(7),!!,"Select a number from 1 to 5",! G ASK
 S LRX=$E(X) S:$A(LRX)>96 LRX=$C($A(LRX)-32) I LRX S LRX=$E("ARSDP",LRX)
 G:LRX="P" P D @LRX G LRBLDAA
 ;
P W " Print post-visit donor letters" S X=0 D F I X W $C(7),!,"There are no letters to print." G LRBLDAA
 S %DT="AEQP",%DT("A")="Print letters for visits no earlier than: " D ^%DT K %DT G:Y<1 END S LRSDT=9999999-Y
 S ZTRTN="QUE^LRBLDAA" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D T
 S LRP=0 F LRA=0:0 S LRP=$O(^LRO(69.2,LRAA,8,65.9,1,"B",LRP)) Q:LRP=""  F LRI=0:0 S LRI=$O(^LRO(69.2,LRAA,8,65.9,1,"B",LRP,LRI)) Q:'LRI  I $D(^LRE(LRI,0)),'$P(^(0),"^",10) D B
 D END^LRUTL,END Q
B S LRW=$O(^LRE(LRI,5,0)) Q:LRW>LRSDT  S LRW=^(LRW,0),LRY=$P(LRW,"^",2) Q:LRY=""  I LRY'="N" Q:$P(LRW,"^",11)'="H"
 S LRL=LRY(LRY) Q:'LRL  D SET^LRBLDAL,EN1^LRBLDAL Q
 ;
A W " Add a donor to the list"
A1 S DIC("A")="Select BLOOD DONOR to add to list: ",DIC=65.5,DIC(0)="AEQM",DIC("S")="I '$P(^(0),U,10)" D ^DIC K DIC Q:Y<1
 S LRP=$P(Y,U,2),X=+Y G:$D(^LRO(69.2,LRAA,8,65.9,1,X,0)) A1
 L +^LRO(69.2,LRAA,8,65.9) S ^LRO(69.2,LRAA,8,65.9,1,X,0)=LRP,^LRO(69.2,LRAA,8,65.9,1,"B",LRP,X)="",Y=^LRO(69.2,LRAA,8,65.9,1,0),^(0)=$P(Y,"^",1,2)_"^"_X_"^"_($P(Y,"^",4)+1) L -^LRO(69.2,LRAA,8,65.9) G A1
 ;
R W " Remove a donor from list"
R1 S X=0 D F I X W !,"All donors have been removed from the list." Q
 W ! S DIC="^LRO(69.2,LRAA,8,65.9,1,",DIC(0)="AEQM",DIC("A")="Select BLOOD DONOR to remove: " D ^DIC K DIC Q:Y<1  S X=+Y,LRP=$P(Y,U,2)
 L +^LRO(69.2,LRAA,8,65.9) K ^LRO(69.2,LRAA,8,65.9,1,X),^LRO(69.2,LRAA,8,65.9,1,"B",LRP,X) S Y=^LRO(69.2,LRAA,8,65.9,1,0),X(1)=$O(^(0)),^(0)=$P(Y,"^",1,2)_"^"_X(1)_"^"_($P(Y,"^",4)-1) L -^LRO(69.2,LRAA,8,65.9) G R1
 ;
S W " Show the donors in the list" S X=0 D F I X W $C(7),!,"There are no blood donors in the list." Q
 W @IOF S A(1)=21,X="" S P=0 F R=1:1 S P=$O(^LRO(69.2,LRAA,8,65.9,1,"B",P)) Q:P=""!(X["^")  F L=0:0 S L=$O(^LRO(69.2,LRAA,8,65.9,1,"B",P,L)) Q:'L!(X["^")  D W
 Q
W W:R#2=1 !,$J(R,2),")",?5,P W:R#2=0 ?40,$J(R,2),")",?44,P S L(R)=L D:$Y>A(1) M Q
M S A(1)=$Y+21 R !,"Enter return to continue: ",X:DTIME W $C(13),$J("",80),$C(13) Q
 ;
D W " Delete the donor letter list" S X=0 D F I X W $C(7),!,"There is no list to delete." Q
 W !,"Are you sure you want to delete the donor letter list " S %=2 D YN^LRU Q:%'=1  K ^LRO(69.2,LRAA,8,65.9,1) Q
 ;
T D FIELD^DID(65.54,1,"","POINTER","X") S X=X("POINTER") F Y=1:1 S Z=$P(X,";",Y) Q:Z=""  S Z(1)=$P(Z,":"),Z(2)=$P(Z,":",2),Z(3)=$O(^LAB(65.9,"B",Z(2),0)),LRY(Z(1))=Z(3)_"^"_Z(2)
 Q
F S:'$P(^LRO(69.2,LRAA,8,65.9,1,0),"^",4) X=1 Q
 ;
END D V^LRU Q
