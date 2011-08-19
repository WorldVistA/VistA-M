LRBLJLG ;AVAMC/REG/CYM - BB INVENTORY LOG-IN 11/12/96  07:49 ; 11/22/00 2:21pm
 ;;5.2;LAB SERVICE;**72,139,247,267,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D END I '$G(DUZ(2)) W $C(7),!,"I need to know the name of your site (In the INSTITUTION file)." G END
 S LR("M")=1,X="BLOOD BANK" D ^LRUTL G:Y=-1 END K LRDPAF
 W !!?28,"Blood Component Log-In",!!?15,"Division: ",LRAA(4) D BAR^LRBLB
 I LRCAPA S X="UNIT LOG-IN/SEND-OUT" D X^LRUWK G:'$D(X) END D S^LRBLW
I R !!,"Enter INVOICE (or order) NUMBER: ",X:DTIME G:X=""!(X[U) END S LRI=X D
 . N IPTR,HLP D FIELD^DID(65,.03,"","INPUT TRANSFORM","IPTR") S IPTR=IPTR("INPUT TRANSFORM") X IPTR  I $D(X),X["?" K X
 . I '$D(X) D FIELD^DID(65,.03,"","HELP-PROMPT","HLP") S HLP=HLP("HELP-PROMPT") W !!,$C(7),HLP
 I '$D(X) G I
D R !,"DATE/TIME RECEIVED: NOW// ",X:DTIME G:X[U!'$T END S:X="" X="N" S %DT="ETX",%DT(0)="-N" D ^%DT K %DT S LRK=Y I Y<1!('$P(Y,".",2)) W $C(7),!,"Must enter a TIME. Future DATE/TIME not allowed.",! G D
C K LRL,X S LRC="",LRL=0 W !!,"Invoice number: ",LRI,! S X=$$READ^LRBLB("Select BLOOD COMPONENT: ") G:X=""!(X[U) I
 I LR,$E(X,1,$L(LR(2)))=LR(2) D P^LRBLB I '$D(X) W $C(7),!,"Code not entered in BLOOD PRODUCT file or not product label.",! G C
 W:'LR $$STRIP^LRBLB(.X)  ; Remove data identifiers just in case
 W ! I LRC="" S DIC=66,DIC(0)="EQMZ",DIC("S")="I $P(^(0),U,4)=""BB""" D ^DIC K DIC G I:X=""!(X[U),C:X["?"!(Y<1) S LRC=+Y,P=$P(Y,U,2),LRR=$P(Y(0),U,19),LRV=$P(Y(0),U,10),Z=$P(Y(0),U,25),LRJ=$S(Z=1:"A",Z=2:"D",1:""),LRBLISBT=+$P(Y(0),U,29)
 S X(1)=+$O(^LAB(66,LRC,"SU",0)) I X(1)<1 W $C(7),!!,"Must have at least one supplier for this component",!,"Please have appropriate person enter supplier(s) in ",$P(^LAB(66,0),U)," FILE (#66)",! G C
 S DIC="^LAB(66,"_LRC_",""SU"",",DIC(0)="AEQMZ",DIC("B")=$P(@(DIC_X(1)_",0)"),U) D ^DIC K DIC G:X=""!(X[U) C S LRW=$P(Y,U,2),LRM=$P(Y(0),U,2),LR(1)=$P(Y(0),"^",10),LR(3)=$P(Y(0),U,12),LR(4)=$L(LR(1))+1 K Y
 D EN^LRBLJLG1
 N IPTR,HLP S DA=0 D FIELD^DID(65,.01,"","INPUT TRANSFORM","IPTR") S IPTR=IPTR("INPUT TRANSFORM")
 D FIELD^DID(65,.01,"","HELP-PROMPT","HLP") S HLP=HLP("HELP-PROMPT")
E W !! S X=$$READ^LRBLB("UNIT ID: ",13) I X=""!(X[U) D ^LRBLJLG1 G C
 I LR,$E(X,1,$L(LR(2)))=LR(2) D U^LRBLB
 W:'LR $$STRIP^LRBLB(.X)  ; Remove data identifiers just in case
 I X[" " W $C(7),"  No spaces allowed." G E
 I X["?" W $C(7)," Enter the Unit ID Without the Prefix" G E
 X IPTR I $D(X),X["?" K X G E
 I '$D(X) W !!,$C(7),HLP G E
 S:'LRBLISBT X=LR(1)_X ;concatinate supplier prefix #
 S LRP=X,DIC=65,DIC(0)="EFMXZ" D ^DIC K DIC S DA=+Y,W=$S($D(Y(0)):Y(0),1:"")
 I Y'>1 F C=0:0 S C=$O(^LRD(65,"B",X,C)) Q:'C  I $D(^LRD(65,C,0)),$P(^(0),"^",4)=LRC W $C(7),!!,"I might have that unit already in inventory.  Let's try that again ",! G E
 I Y>0 S X=$P(Y(0),U) F C=0:0 S C=$O(^LRD(65,"B",X,C)) Q:'C  I $D(^LRD(65,C,0)),$P(^(0),"^",4)=LRC W $C(7),!,$P(^LAB(66,LRC,0),U)," already in inventory with same Unit ID !" D EN1^LRBLJLG1 K Y G E
 K Y(0) I Y>0 W $C(7),!,"Entry in INVENTORY file.",!,"Add ",P," for this DONOR ID# " S %=2 D YN^LRU G:%'=1 E W !!,"Are you SURE ? " S %=2 D YN^LRU G:%'=1 E S LRABO=$P(W,U,7),LRRH=$P(W,U,8) G ED
A K X S (LRABO,LRRH)="" W ! S X=$$READ^LRBLB("ABO/Rh: ",14) G:X=""!(X[U) E
 I LR,$E(X,1,$L(LR(2)))=LR(2) D A^LRBLB I '$D(X) W !,$C(7),"No such ABO/Rh bar code",!! G A
 I LRABO="" W $$STRIP^LRBLB(.X) D T^LRBLB G:'$D(X) A
ED S (LRA,LRH)="" W ! S X=$$READ^LRBLB("EXPIRATION DATE/TIME: ") G:X=""!(X[U) E
 I LR,$E(X,1,$L(LR(2)))=LR(2) D D^LRBLB I '$D(X) W $C(7),!,"Not Date bar code",! G ED
 W:'LR $$STRIP^LRBLB(.X)  ; Remove data identifiers just in case
 I 'LRH S %DT="ETX" D ^%DT K %DT G ED:X["?",E:Y<1 S LRH=Y
 I LRS,LRH>LRS W $C(7),!?4,"Expiration date exceeds allowable limit !" G ED
 L +^LRD(65,0):8 I '$T W $C(7),!!,"We can't do this right now...",!!,"Someone else is creating a new entry in the INVENTORY file ",!!,"Try again..",!! G E
 S (UNIT,TYPE)=""
 I $D(^LRD(65,"B",LRP)) S UNIT=$O(^LRD(65,"B",LRP,0)) D
 . S TYPE=$P($G(^LRD(65,UNIT,0)),U,4) I TYPE=LRC D
 .. W $C(7),!!,"I think someone else is trying to log this unit in" K UNIT,TYPE L -^LRD(65,0)
 I '$D(UNIT) G E
 S DA=+$P(^LRD(65,0),"^",3) F  S DA=DA+1 Q:'$D(^LRD(65,DA))
 L +^LRD(65,DA):1 I '$T W $C(7),!!,"Can't do this now...",!!,"Looks like 2 of you are creating the same record.",!!,"Try again..." G E
 S ^LRD(65,DA,0)=LRP,^LRD(65,"B",LRP,DA)="",^LRD(65,0)="BLOOD INVENTORY^65I^"_DA_"^"_($P(^LRD(65,0),"^",4)+1)
 L -^LRD(65,0)
 S:LR(4)>1 ^LRD(65,"C",$E(LRP,LR(4),$L(LRP)),DA)=""
 S DIE="^LRD(65,",DIE("NO^")="OUTOK",(^LRD(65,"AT",LRP,10,DA),^LRD(65,"AT",LRP,11,DA))=""
 S DR=".02///"_LRW_";.03///"_LRI_";.04////"_LRC_";.05///"_LRK_";.09////"_DUZ_";.1///"_LRM_";.11///"_LRV_";.07///"_LRABO_";.08///"_LRRH_";.06///"_LRH_";.16////"_DUZ(2) D ^DIE
 I LRJ]"" S DR="8;I X="""" D H^LRBLJLG S Y=8;8.1;I X="""" D H^LRBLJLG S Y=8.1;8.3///"_LRJ D ^DIE I $D(Y) W $C(7),!!,"Entry deleted." S DIK="^LRD(65," D ^DIK K DIK G E
 D:LRR=1 S S LRL=LRL+1,LRL(LRL)=DA_"^"_LRP_"^"_LRABO_"^"_LRRH_"^"_LRH_"^"_LRA_"^"_LRC G E
 ;
S S:'$D(^LRO(69.2,LRAA,6,0)) ^(0)="^69.26A^^"
 L +^LRO(69.2,LRAA,6):5 I '$T W $C(7),!!,"I can't add this to the ABO/Rh typing worksheet",!!,"Someone else is editing that worksheet",!!,"Add this unit Manually when printing the ABO/Rh typing worksheet",!! Q
 S X=^LRO(69.2,LRAA,6,0)
 S ^LRO(69.2,LRAA,6,DA,0)=DA,^LRO(69.2,LRAA,6,0)="^69.26A^"_DA_"^"_($P(X,"^",4)+1) L -^LRO(69.2,LRAA,6) Q
H W $C(7),!!,"Answer prompt.  To quit enter '^' and unit will be deleted.",! Q
END D V^LRU Q
