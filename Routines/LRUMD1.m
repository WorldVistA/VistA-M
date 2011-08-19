LRUMD1 ;AVAMC/REG - MD SELECTED TESTS/PATIENTS ;6/16/93  13:24 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 W @IOF S A(1)=21,LRJ="" D L I $D(L)'=11 W !,"You have no patient list.  To enter patients answer the following prompt:" G A
ASK W !!,"(R)emove a patient",?19,"(A)dd/edit patients",?45,"(T)ransfer list to  another user",!,"(D)elete list",?19,"(P)atient group deletion",?45,"(M)erge   list with another user",!,"(S)end list to printer",!
 R "Enter R, A, T, D, P, M, S or <CR> to accept list: ",X:DTIME I X=""!(X[U) S:X[U LRV=1 Q
 S X=$A(X) S:X>84 X=X-32 I X=83 S LRV=2 Q
 G A:X=65,K:X=68,R:X=82,T:X=84,C:X=80,M:X=77 Q:X=76  W $C(7) G LRUMD1
A S LRA="" F LR=0:0 D ^LRDPA Q:LRDFN<1  S X=^LRO(69.2,LRAA,7,DUZ,1,0),^(0)=$P(X,U,1,2)_U_LRDFN_U_($P(X,U,4)+1),^(LRDFN,0)=LRDFN_U_$P(Y(0),U,1,3)_"^^^^^^"_$P(Y(0),U,9),^LRO(69.2,LRAA,7,DUZ,1,"C",$P(Y(0),U,1),LRDFN)="" D G
B Q:'$O(^LRO(69.2,LRAA,7,DUZ,1,0))  G LRUMD1
K W !,"Are you sure you want to delete the entire list " S %=2 D YN^LRU G:%'=1 B
 K ^LRO(69.2,LRAA,7,DUZ,1) S ^LRO(69.2,LRAA,7,DUZ,1,0)="^69.3PA^0^0" W !,"Your patient list has been deleted" Q
R D ^LRUMD2 G LRUMD1
C D EN^LRUMD2 G LRUMD1
T W !!?3,"Transfer patient list to another user (current user list is saved)"
 S DIC=200,DIC(0)="AEQM" D ^DIC K DIC Q:X=""!(X[U)  S N=+Y
 I '$D(^LRO(69.2,LRAA,7,N,0)) S ^(0)=N_"^"_DT L +^LRO(69.2,LRAA,7) S X=^LRO(69.2,LRAA,7,0),^(0)=$P(X,"^",1,2)_"^"_N_"^"_($P(X,"^",4)+1) L -^LRO(69.2,LRAA,7)
 I '$D(^LRO(69.2,LRAA,7,N,1,0)) S ^(0)="^69.3PA^0^0"
 L +^LRO(69.2,LRAA,7,N,1) S B=0 W !,"Transferring"
 F A=0:0 S A=$O(^LRO(69.2,LRAA,7,DUZ,1,A)) Q:'A  S X=^(A,0) I '$D(^LRO(69.2,LRAA,7,N,1,A,0)) S ^(0)=X,^LRO(69.2,LRAA,7,N,1,"C",$P(X,"^",2),A)="",B=B+1,B(1)=A I $D(^LRO(69.2,LRAA,7,DUZ,1,A,1)) S X=^(1),Z=N D H
 I B S X=^LRO(69.2,LRAA,7,N,1,0),^(0)=$P(X,"^",1,2)_"^"_B(1)_"^"_($P(X,"^",4)+B)
 L -^LRO(69.2,LRAA,7,N,1) W !,"Transfer completed." H 2 G LRUMD1
H Q:X=""  S ^LRO(69.2,LRAA,7,Z,1,A,1)=X,^LRO(69.2,LRAA,7,Z,1,"D",$P(X,"^"),A)="" W "." Q
M W !!?3,"Merge patient list with another user's list"
 S DIC=200,DIC(0)="AEQM" D ^DIC K DIC G:X=""!(X[U) LRUMD1 S N=+Y
 I '$O(^LRO(69.2,LRAA,7,N,1,0)) W $C(7),!,"No patient list for ",$P(Y,U,2) G LRUMD1
 S B=0 W !,"Merging"
 F A=0:0 S A=$O(^LRO(69.2,LRAA,7,N,1,A)) Q:'A  S X=^(A,0) I '$D(^LRO(69.2,LRAA,7,DUZ,1,A,0)) S ^(0)=X,^LRO(69.2,LRAA,7,DUZ,1,"C",$P(X,"^",2),A)="",B=B+1,B(1)=A I $D(^LRO(69.2,LRAA,7,N,1,A,1)) S X=^(1),Z=DUZ D H
 I B S X=^LRO(69.2,LRAA,7,DUZ,1,0),^(0)=$P(X,"^",1,2)_"^"_B(1)_"^"_($P(X,"^",4)+B)
 W !,"Merge completed." H 2 G LRUMD1
EN ;from LRUMD, LRUMDP
 G:$O(LR(0)) SEL F A=0:0 S A=$O(^LRO(69.2,LRAA,7,DUZ,60,A)) Q:'A  F B=0:0 S B=$O(^LRO(69.2,LRAA,7,DUZ,60,A,1,B)) Q:'B  S C=+^(B,0),^TMP($J,"N",A,B)=$P(^LAB(60,C,.1),"^"),^TMP($J,"L",A,B)=$P($P(^LAB(60,C,0),"^",5),";",2)
 I '$O(^TMP($J,"L",0)) F A=0:0 S A=$O(^LRO(69.2,LRAA,60,A)) Q:'A  F B=0:0 S B=$O(^LRO(69.2,LRAA,60,A,1,B)) Q:'B  S C=+^(B,0),^TMP($J,"N",A,B)=$P(^LAB(60,C,.1),"^"),^TMP($J,"L",A,B)=$P($P(^LAB(60,C,0),U,5),";",2)
 Q
SEL F A=0:0 S A=$O(LR(A)) Q:'A  F B=0:0 S B=$O(^LRO(69.2,LRAA,7,DUZ,60,A,1,B)) Q:'B  S C=+^(B,0),^TMP($J,"N",A,B)=$P(^LAB(60,C,.1),"^"),^TMP($J,"L",A,B)=$P($P(^LAB(60,C,0),"^",5),";",2)
 Q
L S P=0 F R=1:1 S P=$O(^LRO(69.2,LRAA,7,DUZ,1,"C",P)) Q:P=""!(LRJ["^")  F L=0:0 S L=$O(^LRO(69.2,LRAA,7,DUZ,1,"C",P,L)) Q:'L!(LRJ["^")  D W
 Q
W S P(1)=$E(P,1,28),X=$S($D(^LRO(69.2,LRAA,7,DUZ,1,L,1)):"("_$E(^(1),1,3)_")",1:"") S:X="()" X="" W:R#2=1 !,$J(R,2),")",?5,P(1),?33,X W:R#2=0 ?40,$J(R,2),")",?44,P(1),?74,X S L(R)=L D:$Y>A(1) P Q
P S A(1)=$Y+21 R !,"Press <CR>, <RETURN>, or <ENTER> key ",LRJ:DTIME W $C(13),$J("",80),$C(13) Q
G S DIE="^LRO(69.2,LRAA,7,DUZ,1,",DA(2)=LRAA,DA(1)=DUZ,DA=LRDFN,DR="1//^S X=LRA;S LRA=X" D ^DIE K DIC,DIE,DR,DA Q
