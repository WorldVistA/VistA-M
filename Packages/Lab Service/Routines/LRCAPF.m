LRCAPF ;DALISC/FHS-STUFF WKLD CODE INTO FILE 60 61.2 62.07 ETC ;5/2/91  09:03
 ;;5.2;LAB SERVICE;**221**;Sep 27, 1994
EN ;
 L +^LRO(61.2):1 I '$T W !,$C(7),"Someone else is editing ^LRO(61.2) file ",! Q
DOC ;
 W !!,$$CJ^XLFSTR("You must have already defined and ran a search template for the",IOM)
 W !,$$CJ^XLFSTR("ETIOLOGY FIELD (#61.2). This option will use the results of that search",IOM)
 W !,$$CJ^XLFSTR("and automatically stuff WKLD Codes for those organisms. If you wish to edit",IOM)
 W !,$$CJ^XLFSTR("a single organism, use FileMan enter/edit option.",IOM)
 W !!,$$CJ^XLFSTR("This option will automatically add WKLD codes to your",IOM)
 W !,$$CJ^XLFSTR("ETIOLOGY FILE (#61.2).",IOM),!!
 K DIC S DIC="^DIBT(",DIC("S")="I $P(^(0),U,4)=61.2",DIC(0)="AQENM",DIC("A")="Select Sort Template " D ^DIC G:Y<1 END S LRS=+Y
ETIO ;
 K DIC,LRCAPX S LRCAPX=""
ASK W !!,?10,"Select WKLD Code(s) to be added " K DIC
 S DIC="^LAM(",DIC(0)="ZAQENM",DIC("A")="Enter WKLD Code : " F  D ^DIC Q:Y<1  S LRCAPX(+Y)=$P(Y(0),U)_"^"_$P(Y(0),U,2)
 G END:$D(DTOUT)!($D(DUOUT))
 I '$O(LRCAPX(0)) W !,$$CJ^XLFSTR("No WKLD Codes Selected - Continue to purge existing codes. ",IOM),!,$C(7) G PURG
AD D SHOW
 W !!?10,"Wish to delete any selection(s) " S %=2 D YN^DICN G AD:%=0,END:%<0,DEL:%=1
PURG K LRPURG W !!,"Shall I purge already existing Wkld Codes " S %=2 D YN^DICN G END:%<0 S:%=1 LRPURG=1
MULT ;
 G:'$O(LRCAPX(0)) OK
 R !!?10,"Multiply Factor: 1 // ",X:DTIME G END:'$T!($E(X)=U) S:X="" X=1
 D:X'=+X!(X>20)!(X<1)!(X?.E1"."1N.N)  G:'$G(X) MULT
 . W !!,$C(7),"Enter a whole number between 1-20",! K X
 S LRMULT=X
OK W:$O(LRCAPX(0)) !!,$$CJ^XLFSTR("Ready to have the WKLD Codes Added to the Etiology File ",IOM)
 W:$G(LRPURG) !!,$$CJ^XLFSTR($S($O(LRCAPX(0)):"**AND** ",1:"")_"PURGE ALREADY EXISTING WKLD CODES IN FILE",IOM),$C(7)
 S %=2 D YN^DICN G END:%<0,EN:%'=1
 W !!,$$CJ^XLFSTR("PRESS RETURN TO STOP PROCESS",IOM),$C(7),!! R X:2 G END:$T
STUF K STOP,DA S DA=0 F  S DA=$O(^DIBT(LRS,1,DA)) Q:DA<1!($G(LRSTOP))  D
 . I $G(LRPURG) W !?5,"Purging WKLD Code(s) from ",$P($G(^LAB(61.2,DA,0)),U) K ^LAB(61.2,DA,9)  R LRSTOP:1 S:$T LRSTOP=1
 . I $D(^LAB(61.2,DA,0))#2,$O(LRCAPX(0)) W !,"Adding WKLD Codes to : ",$P(^(0),U) D
 . . F LRI=0:0 S LRI=$O(LRCAPX(LRI)) Q:LRI<1  R LRSTOP:1 S:$T LRSTOP=1 Q:$G(LRSTOP)  S LRX=$P(LRCAPX(LRI),U,2) I '$D(^LAB(61.2,DA,9,LRI)) D
 . . . K DIC,DR,DIE S DIC(0)="LMX",DLAYGO=61,DIC="^LAB(61.2,",DIE=DIC,DR="11///^S X=LRX",DR(2,61.211)=".01///^S X=LRX;2///^S X=LRMULT" D ^DIE K DLAYGO W "."
 W:$G(LRSTOP)=1 !!,$$CJ^XLFSTR("PROCESS ABORTED BEFORE UPDATE WAS COMPLETED",IOM),$C(7),!!
 W:'$G(LRSTOP) !!,$$CJ^XLFSTR("Process complete",IOM),!
 G END Q
SHOW ;
 W !!?10,"You have selected ",!!
 K CNT S (CNT,I)=0 F  S I=$O(LRCAPX(I)),CNT=CNT+1 Q:'I  S CNT(CNT)=I W !,CNT,?5,$P(LRCAPX(I),U,2),?20,$P(LRCAPX(I),U)
 Q
DEL ;
 W !!?10,"Select a Number to delete " R LRDEL:DTIME G:'$T!($E(LRDEL)="^") END G:LRDEL="" ASK I $E(LRDEL)="?" D SHOW G DEL
 I LRDEL'=+LRDEL W !!?20,"Positive number only ",$C(7) D SHOW G DEL
 I '$D(CNT(+LRDEL)) W !!?10,"Invalid Number   Retry Please ",$C(7),! D SHOW G DEL
 K LRCAPX(CNT(LRDEL)),CNT(LRDEL) G DEL
END ;
 L -^LRO(61.2)
 Q:$G(LRDBUG)
 K CNT,DIC,DIE,DLAYGO,DA,DR,LRCAPX,LRDEL,LRI,LRMULT,LRPURG,LRS,LRX,LRSTOP
 Q
