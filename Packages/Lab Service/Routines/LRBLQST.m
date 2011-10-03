LRBLQST ;AVAMC/REG - SINGLE UNIT STATUS ;8/1/95  08:46 ;
 ;;5.2;LAB SERVICE;**72,247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ; References to ^DIC(4 are supported by DBIA 2508
 ; references to ^DD(65 are supported by DBIA 3261
 D V^LRU S IOP="HOME" D ^%ZIS
 W !!?20,"Current status of a unit in inventory file" S LRC=$P(^DD(65,4.1,0),U,3),LRT=$P(^DD(65,8.1,0),U,3),LRD=$P(^DD(65,8.3,0),U,3)
ASK W !! S DIC=65,DIC(0)="AEQMZ" D ^DIC K DIC G:Y<1 END W !,"Is this the unit " S %=1 D YN^LRU G:%'=1 ASK S LRA=+Y
 W @IOF,!,"Unit #:",$P(Y(0),"^"),?25,"Component:" S X=$P(Y(0),"^",4) W $S('X:"??",$D(^LAB(66,X,0)):$P(^(0),"^"),1:"??") W:$P($G(^LAB(69.9,1,8.1,+DUZ(2),0)),U,6) !,$P($G(^DIC(4,+$P(Y(0),U,16),0)),U)
 W !!,"Expiration date:" S Y=$P(Y(0),"^",6) D D^LRU W Y,?40,"ABO:",$P(Y(0),"^",7),?50,"Rh:",$P(Y(0),"^",8)
 I $D(^LRD(65,LRA,4)) S LRB=^(4),X=$P(LRB,"^") I X]"" S Y=$P(LRB,"^",2) D D^LRU W !!,"Disposition date:",Y,?40,"Disposition:",$P($P(LRC,X_":",2),";")
 I $D(^LRD(65,LRA,8)) S X=^(8),Y=+X,W(2)=$P(X,"^",2),W(3)=$P(X,"^",3) D:Y AU I W(2)]""!(W(3)]"") W ! W:W(2)]"" "Positive screening tests:",$P($P(LRT,W(2)_":",2),";") W:W(3)]"" ?40,"Donation type:",$P($P(LRD,W(3)_":",2),";")
 W !! F X=0:0 S X=$O(^LRD(65,LRA,2,X)) Q:'X  S Z=^(X,0) I $P(Z,"^",2) S V=^LR(+Z,0),(LRDPF,W)=$P(V,"^",2),Y=$P(V,"^",3),W=^DIC(W,0,"GL"),W=@(W_Y_",0)"),Y=$P(Z,"^",2) D D^LRU,W
 S X=$O(^LRD(65,LRA,3,0)) I X S L=^LRD(65,LRA,3,X,0),Y=+L D D^LRU W !!,"Current  location:",$P(L,"^",4),!,"Date last located:",Y
 G ASK
W S SSN=$P(W,"^",9) D SSN^LRU
 W !,"Patient:",$P(W,"^")," ",SSN,!?8,"Date assigned:",Y Q
 ;
AU S X=^LR(Y,0),Y=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2),X=^DIC(X,0,"GL"),Y=@(X_Y_",0)") S SSN=$P(Y,"^",9) D SSN^LRU W !,"Restricted for: ",$P(Y,"^")," ",SSN Q
END D V^LRU Q
