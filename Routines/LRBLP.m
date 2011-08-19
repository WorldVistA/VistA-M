LRBLP ;AVAMC/REG - BLOOD BANK PATIENT OPTS ;4/11/94  07:55 ;
 ;;5.2;LAB SERVICE;**247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
B Q  D END,Z G:Y=-1 END W !!?10,"Edit transfusions entered via Previous records option" K DIC D ^LRDPA G:LRDFN=-1 END
 K ^TMP($J) S (E,B)=0 F A=0:0 S A=$O(^LR(LRDFN,1.6,A)) Q:'A  I $P(^(A,0),"^",9) S B=B+1,X=^(0),^TMP($J,B)=A_"^"_X D C Q:E["^"
 I '$D(^TMP($J)) W $C(7),!,"There are no transfusion records entered via previous records option." G B
E W !,"Select from (1-",B,"): " R X:DTIME G:X["^"!(X="") B I X<1!(X>B)!(+X'=X) W $C(7),!,"Enter a number from 1 - ",B," to edit selection." G E
 K DA S LRI=+^TMP($J,X),DIE="^LR(",DA=LRDFN,DR="[LRBLSPP]" D ^DIE G B
 ;
C S Y=+X,C=$P(X,"^",2) D D^LRU W !,$J(B,3),") ",Y,?25,$P(X,"^",3)," ",$P(X,"^",5)," ",$P(X,"^",6)," " I C,$D(^LAB(66,C,0)) W $P(^(0),"^") D:B#20=0 M Q
 ;
O Q  D END,Z G:Y=-1 END W !!?10,"Blood bank patient data from old records"
PT K DIC,DA W ! D ^LRDPA G:LRDFN=-1 END S DIE="^LR(",DA=LRDFN,DR="[LRBLPOLD]" D ^DIE
 F W=0:0 S W=$O(W(W)) Q:'W  F M=0:0 S M=$O(W(W,M)) Q:'M  I '$D(^LR(LR,W,M)) S O=M,X="deleted",Z=W(W,M)_",.01" D EN^LRUD
 K M,W,O,LR,DIE,DR,DA S:'$D(^LR(LRDFN,1.6,0)) ^(0)="^63.017DAI^^"
ASK W ! S DA(1)=LRDFN,DIC="^LR(LRDFN,1.6,",DIC(0)="AEQL",DLAYGO=63 D ^DIC K DIC,DLAYGO G:Y<1 PT I '$P(Y,U,3) W $C(7),!,"For new entries only.  No editing." G ASK
 K DA S LRI=+Y,DA=LRDFN,DIE="^LR(",DR="[LRBLPT]" D ^DIE G ASK
S W !!?10,"Blood bank patient special instructions" K DIC W ! D ^LRDPA G:LRDFN=-1 END S DIE="^LR(",DA=LRDFN,DR=".076" W ! D ^DIE G S
P Q  I $D(LRLOKVAR) D FRE^LRU
 D END,Z W !!?25,"Edit blood bank patient ABO/Rh" K DIC,DA D ^LRDPA G:LRDFN<1 END S DIE="^LR(",DA=LRDFN,X=^LR(LRDFN,0),LRABO=$P(X,U,5),LRRH=$P(X,U,6) D CK^LRU G:$D(LR("CK")) P
ABO S LRP=5,Z="63,.05",LRF=$P(^DD(63,.05,0),U,3) W !!,"ABO GROUP: ",LRABO,$S(LRABO]"":"// ",1:" ") R X:DTIME G:'$T!(X[U) P S:X="" X=LRABO S LRD=LRABO D F G:Y="" ABO
RH S LRP=6,Z="63,.06",LRF=$P(^DD(63,.06,0),U,3) W !!,"RH TYPE: ",LRRH,$S(LRRH]"":"// ",1:" ") R X:DTIME G:'$T!(X[U) P S:X="" X=LRRH S A=$S($A(X)=80:$P("POS",X,2),1:$P("NEG",X,2)),X=X_A,LRD=LRRH W A D F G:Y="" RH
 G P
 ;
TX Q  D END,Z G:Y=-1 END  W !!?8,"Enter/edit transfusion reactions that do not have specific",!?18,"units associated with the reaction",!
T K DIC W ! D ^LRDPA G:LRDFN=-1 END S:'$D(^LR(LRDFN,1.9,0)) ^(0)="^63.0171DAI^^" S DIC="^LR(LRDFN,1.9,",DIC(0)="AEQLMZ",DLAYGO=63 W ! D ^DIC K DIC,DLAYGO G:Y<1 T S LR=Y(0),LRI=+Y
 W ! S DIE="^LR(",DA=LRDFN,DR="[LRBLPTXR]" D ^DIE I '$D(^LR(LRDFN,1.9,LRI,0)) S O=$P(LR,U),X="Deleted",Z="63.0171,.01" D EN^LRUD
 G T
 ;
F I X="@",LRD="" W $C(7),"  NOTHING TO DELETE !" S Y="" Q
 I X="@" F A=1.8,1,1.7,3,1.5,1.6 I $O(^LR(LRDFN,A,0)) S LRK=1 Q
 I X="@",$D(^LRD(65,"AP",LRDFN)) W $C(7),!!,"Units assigned/crossmatched." S LRK=1
 I $D(LRK) K LRK W !!,$C(7),"Any component requests, units assigned/crossmatched, transfusion records,",!,"RBC antigens present or absent, antibodies identified or blood bank comments",!,"must be removed before deletion allowed.",! S Y="" Q
 S LRI=$O(^LR(LRDFN,"BB",0)) I X="@",LRI D A I $D(LRK) W $C(7),!!,"Blood bank data entered for this patient.  Deletion not allowed!",! S Y="" Q
 I $D(LRM) K LRM Q
 I X="@" W $C(7),!,"ARE YOU SURE YOU WANT TO DELETE " S %=2 D YN^LRU I %=1 S $P(^LR(LRDFN,0),"^",LRP)="",O=LRD,X="deleted" D EN^LRUD S Y="@" Q
 Q:X="@"!(X="")  S X=X_":",Y=$P($P(LRF,X,2),";") I Y]"",LRD'=Y S $P(^LR(LRDFN,0),"^",LRP)=Y,X=Y,O=LRD D EN^LRUD
 Q:Y]""  W !?5,"CHOOSE FROM: " F X=1:1 S Y=$P(LRF,";",X) Q:Y=""  S A=$P(Y,":",2),Y=$P(Y,":",1) W !?7,Y,?15," ",A
 S Y="" Q
A K LRK I $P(^LR(LRDFN,"BB",0),"^",4)>1 S LRK=1 Q
 Q:$D(LRK)  S X=^LR(LRDFN,"BB",LRI,0),$P(^(0),"^",3)="" W $C(7),!!,"Remove blood bank accession number ",$P(X,"^",6),!,"And then you can delete the ABO & RH entries.",! S LRM=1 Q
 ;
Z S X="BLOOD BANK" D ^LRUTL Q
M W !,"'^' TO STOP: " R E:DTIME Q:E["^"
 W $C(13),$J("",15),$C(13) Q
 ;
END D V^LRU Q
