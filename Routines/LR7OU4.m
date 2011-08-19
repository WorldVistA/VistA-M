LR7OU4 ;DALOI/DCM/FHS/RLM-NLT LINKING UTILITY AUTO ;8/11/97
 ;;5.2;LAB SERVICE;**127,163,272**;Sep 27, 1994
 ; Reference to ^DIC supported by IA #10007
 ; Reference to YN^DICN supported by IA #10009
 ; Reference to ^DIE supported by IA #10018
 ; Reference to ^DIK supported by IA #10013
 ; Reference to ^DIR supported by IA #10026
 ; Reference to $$CJ^XLFSTR supported by IA #10104
 ; Reference to $$LOW^XLFSTR supported by IA #10104
EN ;
64 ;Find matches between file 64 and 60
 W !,$$CJ^XLFSTR("This option will look for potential matches between file 64 (NLT) and file 60.",80),!,$$CJ^XLFSTR("You will be allowed to create a permanent link between matching entries in",80)
 W !,$$CJ^XLFSTR("these files. Tests with the type of NEITHER will be omitted during link phase.",80)
 W !!,$$CJ^XLFSTR("ONLY GENERIC NLT CODES CAN BE LINKED TO LAB TEST ",80),!!
 W !,$$CJ^XLFSTR("Those LAB TEST already linked to the NLT file will also be omitted.",80),!
LIST ;
 K DIR S DIR("A")="Would you like a list of WKLD CODES from LABORATORY TEST file",DIR(0)="Y",DIR("B")="No"
 D ^DIR G:$D(DIRUT)!($D(DTOUT))!($D(DUOUT)) END I Y=1 D   G:$D(DIRUT)!($D(DTOUT))!($D(DUOUT))!(Y=0) END G LK
 . D ^LRCAPD K DIR S DIR("A")="Ready to start linkage procedure ",DIR(0)="Y"
 . D ^DIR
 W ! K DIR S DIR("A")="Ready to proceed",DIR(0)="Y"
 D ^DIR G:$D(DTOUT)!($D(DUOUT))!($D(DIROUT))!(Y'=1) END
LK W !!,$$CJ^XLFSTR("Do you want to automatically link entries when there is an exact match",80)
 W !,$$CJ^XLFSTR("on the NAME in both files",80) S %=2 D YN^DICN G:%=-1 END
 I %=0 W !!,$$CJ^XLFSTR("Answer YES to automatically link the entries, or NO to be prompted for each",80) G LK
 S AUTO=$S(%=1:1,1:0)
LAB ;
 S (END,LRN)="" F  S LRN=$O(^LAB(60,"B",LRN)) Q:LRN=""!($G(END))  D
 . S LRIEN="" F  S LRIEN=+$O(^LAB(60,"B",LRN,LRIEN)) Q:LRIEN<1!($G(END))  I '$G(^(LRIEN)) D CHECK
 W:'$G(END) !!,$$CJ^XLFSTR("End of loop",80),!
 G END
 Q
CHECK ;
 Q:'$D(^LAB(60,LRIEN,0))#2!($G(^LAB(60,LRIEN,64)))!($G(END))
 S LRDATA=$P(^LAB(60,LRIEN,0),U),LRTY=$P(^(0),U,3) Q:LRTY=""!(LRTY="N")
 S LRNU=$$UPPER(LRN),LRMIEN=+$O(^LAM("D",LRNU,0)) D:'LRMIEN 91 Q:(('LRMIEN)!($G(END)))
 Q:'$D(^LAM(LRMIEN,0))#2  S LRCODE=$P($P(^(0),U,2),".",1)_".0000 " Q:'LRCODE
 S LRMIEN=$O(^LAM("C",LRCODE,0)) Q:('LRMIEN)!('$D(^LAM(LRMIEN,0))#2)
 S LRMNAME=$P(^LAM(LRMIEN,0),U)
 Q:'$D(^LAM(LRMIEN,0))  S LRMNAME=$P(^(0),U)
 W !!,"60 = ",LRDATA,!,"64 = ",LRMNAME_"   "_LRCODE
 D LINK(LRIEN,LRMIEN,AUTO)
 Q
91 ;Look for Accession WKLD codes
 G:'$O(^LAB(60,LRIEN,9.1,0)) 9
 W !!,$C(7),?5,"Did not find a exact name match for Lab Test "_LRDATA
 W !," Want to use a Accession WKLD code instead?",!
 S I=0 F  S I=$O(^LAB(60,LRIEN,9.1,I)) Q:I<1  W:$D(^LAM(I,0))#2 !?2,$P(^(0),U),?50,$P(^(0),U,2)
 W ! K DIC S DIC="^LAB(60,"_LRIEN_",9.1,",DIC(0)="AQNMZ",DIC("A")="Select Accession WKLD if appropriate " D ^DIC W !
 S:$E(X)=U!($G(DTOUT)) END=1 Q:$G(END)  I Y>0 S LRMIEN=+Y Q
9 ;Look for Verify WKLD codes
 Q:'$O(^LAB(60,LRIEN,9,0))
 W !!,$C(7),?5,"Did not find a exact name match for Lab Test "_LRDATA
 W !," Want to use a Verify WKLD code instead?",!
 S I=0 F  S I=$O(^LAB(60,LRIEN,9,I)) Q:I<1  W:$D(^LAM(I,0))#2 !?2,$P(^(0),U),?50,$P(^(0),U,2)
 W ! K DIC S DIC="^LAB(60,"_LRIEN_",9,",DIC(0)="AQNMZ",DIC("A")="Select Verify WKLD if appropriate " D ^DIC W !
 S:$E(X)=U!($G(DTOUT)) END=1 Q:$G(END)!(Y<1)  S LRMIEN=+Y
 Q
LINK(X60,X64,DOIT) ;Link the 2 files
 S LRDATA="`"_X60 I DOIT S %=1 G L2
L1 W !?5,"Link the two entries" S %=2 D YN^DICN Q:%=2  I %=-1 S END=1 Q
 I $G(DTOUT) S END=1 Q
 I %=0 W !,"Enter Yes to link the entries, No to leave it alone." G L1
L2 D:$G(^LAB(60,X60,64)) DXSS
 K DIE,DA,DR,DIC S DIE="^LAB(60,",DA=X60,DR="64////^S X=X64",DLAYGO=60 D ^DIE K DLAYGO
XSS K DIE,DA,DR,DIC S DIE="^LAM(",DA=X64,DR="23///^S X=LRDATA;",DR(1,64)="23///^S X=LRDATA;",DR(2,64.023)=".01////LRDATA;",DLAYGO=64
 S DIC("V")="I +Y(0)=60" D ^DIE K DIC K DLAYGO
 I $G(^LAB(60,X60,64))&($D(^LAM("AE","LAB(60,",X60))) W !?32,"o----LINKED----o",! H 1 Q
 W !!?15,"***************** NOT LINKED ***************",!
 W !!?5,"Press Return to continue" R X:DTIME S:$G(DTOUT)!($E(X)=U) END=1
 Q
DXSS N DIE,DA,DR,DIC,DIK,DLAYGO
 S DA(1)=+$G(^LAB(60,X60,64)),DIK="^LAM("_DA(1)_",7,",DLAYGO=64
 S DA=$O(^LAM(DA(1),7,"B",X60_";LAB(60,",0))
 D:DA&(DA(1)) ^DIK
 Q
END ;
 Q:$G(LRDBUG)
 K %,AUTO,DA,DIC,DIE,DIR,DOIT,DR,END,LRDATA,LRIEN,LRMIEN,LRN,LRNU
 K LRSUF,LRTY,X,X60,X64,Y,LRMNAME,D1,D0,DLAYGO,I,LRCODE,END
 K FLG,XXX,ZZ,ZZ1,X,Y,Y64,DLAYGO
 Q
UPPER(X) ; Convert lower case X to UPPER CASE
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
60(X) ;Find matching item in file 60
 N XXX S XXX=X K SSS
 S X=$O(^LAB(60,"B",X,0)),ZZ1="",ZZ=""
 I 'X S X=$O(^LAB(60,"B",XXX)),X=$S($E(X,$L(X))="S"&($E(X,1,$L(X)-1)=XXX):$O(^LAB(60,"B",XXX,0)),1:"") S:$L(X) SSS=1
 I X S ZZ=X,X=$P(^LAB(60,X,0),"^"),ZZ1=$P($G(^(64)),"^")
 I ZZ1 W !,$P(^LAM(ZZ1,0),"^")_" => "_X,?60,"Already linked" S X="",LINKED=1
 Q X
MIXED(X,FLG) ;Return mixed case
 ;X=TEXT
 ;FLG-1 all text lower case, 0 mixed case, 2 1st letter of each word caps
 N Z,I
 I 'FLG S X=$E(X,1)_$$LOW^XLFSTR($E(X,2,$L(X)))
 I FLG=1 S X=$$LOW^XLFSTR($E(X,1,$L(X)))
 I FLG=2 S Z="" D
 . F I=1:1:$L(X," ") S Z=Z_$S(I>1:" ",1:"")_$$MIXED($P(X," ",I),0)
 . S X=Z
 Q X
