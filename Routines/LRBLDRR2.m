LRBLDRR2 ;AVAMC/REG/CYM - DO NOT RELEASE BLOOD COMPONENT ;6/26/96  12:06 ;
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
A R !?5,"COMPONENT DISPOSITION: ",X:DTIME Q:X=""!(X[U)  I X["?" D C G A
 S Y=$S(X=1:"QUARANTINE",X=2:"DISCARD",$E("DISCARD",1,$L(X))=X:"DISCARD",$E("QUARANTINE",1,$L(X))=X:"QUARANTINE",1:"") W:X " ",Y W:'X $E(Y,$L(X)+1,$L(Y))
 I Y="" W $C(7) D C G A
 S Z=Y,DIE="^LRE(LRQ,5,LRI,66,",DA(2)=LRQ,DA(1)=LRI,DA=C,DR=".08///^S X=Z;.07////^S X=DUZ;.02//^S X=""NOW"";1" D ^DIE
 Q
EN ;from LRBLDRR1
 W !,"COMPONENT DISPOSITION & COMPONENT DISPOSITION COMMENT DELETED"
 S X=^LRE(LRQ,5,LRI,66,C,0),^(0)=+X_"^^"_$P(X,U,3)_U_$P(X,U,4)_U_$P(X,U,5)_U_$P(X,U,6) K ^LRE(LRQ,5,LRI,66,C,1) Q
C W !,"CHOOSE FROM:",!?7,1,?16,"QUARANTINE",!?7,2,?16,"DISCARD" Q
EN1 ;from LRBLDRR
 I LRJ(10.4)=""!("ABO"'[LRJ(10.4))!(LRJ(11.4)="")!("POSNEG"'[LRJ(11.4)) W $C(7),!!,"Must perform ABO/Rh recheck !!",! S A=1 Q
 I LRJ(10.4)'=LRJ(10) W $C(7),!!,"ABO Interpretation Recheck not same as ABO Interpretation " S A=1
 I LRJ(11)'[LRJ(11.4) W $C(7),!!,"Rh Interpretation Recheck not same as Rh Interpretation" S A=1
 Q
