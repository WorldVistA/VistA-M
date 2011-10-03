LRBLJLA ;AVAMC/REG/CYM - CROSSMATCH LABELS ;6/17/96  14:21 ;
 ;;5.2;LAB SERVICE;**72,247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D END,CK^LRBLPUS G:Y=-1 END S:'$D(^LRO(69.2,LRAA,9,0)) ^(0)="^69.25A^^"
 W !?30,"PRINT XMATCH LABELS" S X=$P(^LRO(69.2,LRAA,9,0),"^",4) W:X !?25,"(There ",$S(X>1:"are",1:"is")," ",X," label",$S(X>1:"s",1:"")," to print)"
 W !?3,"Add labels for emergency transfusion " S %=2 D YN^LRU I %=1 D E
 W !! I '$O(^LRO(69.2,LRAA,9,0)) W $C(7),!!,"THERE ARE NO LABELS TO PRINT !",!,"DO WANT TO ADD SOME OF YOUR OWN" S %=2 D YN^LRU G:%'=1 END D C G ED
 W !,"Do you want to delete the list of labels " S %=2 D YN^LRU I %=1 W $C(7),!,"Are you sure " S %=2 D YN^LRU I %=1 W "  OK, List DELETED." K ^LRO(69.2,LRAA,9) D END Q
ED W !,"Edit LABELS " S %=2 D YN^LRU G:%<1 END D:%=1 C
 W !!,"Save list for repeat printing " S %=2 D YN^LRU G:%<1 END S:%=1 LRQ=1
 W !!?33,"REMEMBER TO",!?13,"ALIGN THE PRINT HEAD ON THE FIRST LINE OF THE LABEL"
 S LR(1)=$S($D(^LRO(69.2,LRAA,0)):$P(^(0),U,7),1:"")
I W !!?20,"ENTER  NUMBER OF LINES  FROM",!?20,"TOP OF ONE LABEL TO ANOTHER: ",LR(1),$S(LR(1):"// ",1:"") R X:DTIME G:'$T!(X[U) END S X=$S(X="":LR(1),$L(X)>2:X=1,1:X)
ASK W ! X $P(^DD(69.2,.07,0),"^",5,99) I '$D(X) W:$D(^DD(69.2,.07,3)) !,$C(7),^(3) X:$D(^(4)) ^(4) G I
 I X["?" S X="ZZZ" G ASK
 S LR(1)=X
 S ZTRTN="QUE^LRBLJLA" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO
 F A=0:0 S A=$O(^LRO(69.2,LRAA,9,A)) Q:'A  S X=^(A,0) F B=1:1:LR(1) W $P(X,"^",B),!
OUT K:'$D(LRQ) ^LRO(69.2,LRAA,9) K %ZIS S (LR("FORM"),LR("LINE"))=1 D END^LRUTL,END Q
 ;
C W ! S DIC="^LRO(69.2,LRAA,9,",DLAYGO=69,DIC(0)="AEQLM",DIC("A")="Select Unit ID: " D ^DIC K DIC,DLAYGO Q:X=""!(X[U)  S DA=+Y
 S DIE="^LRO(69.2,LRAA,9,",DR=".01:.05",DA=+Y D ^DIE K DIC,DIE,DR,DA,D G C
 ;
E S:'$D(^LRO(69.2,LRAA,9,0)) ^(0)="^69.25A^^"
A K DIC D ^LRDPA Q:LRDFN=-1  S X=^LR(LRDFN,0),Y=$P(X,"^",3),LRABO=$P(X,"^",5),LRRH=$P(X,"^",6),(LRDPF,X)=$P(X,"^",2),X=^DIC(X,0,"GL"),Z=$S($D(@(X_Y_",.35)")):+^(.35),1:0),X=@(X_Y_",0)"),LRP=$P(X,"^"),SSN=$P(X,"^",9) D SSN^LRU
 I Z W $C(7),! G A
B R !!,"Enter number of crossmatch labels wanted: ",LRB:DTIME Q:LRB=""!(LRB[U)  I LRB<1!(LRB>99) W $C(7),!,"Enter a number from 1 to 99." G B
 S %DT="T",X="N" D ^%DT,D^LRU
 L +^LRO(69.2,LRAA,9):5 I '$T W $C(7),!!,"I can't make those extra labels now.",!!,"Someone else started this first",!!,"Try again later if you still need extras",!! Q
 S X=^LRO(69.2,LRAA,9,0),LRC=$P(X,"^",3)+1,Z=$P(X,"^",3)+LRB,^(0)=$P(X,"^",1,2)_"^"_Z_"^"_Z
 F A=LRC:1:Z S ^LRO(69.2,LRAA,9,A,0)=Y_"^"_LRP_" "_SSN_"^"_"Patient ABO/Rh: "_LRABO_" "_LRRH_"^"_"Unit    ABO/Rh:        Unit#:"_"^"_"Crossmatch:            Tech :"
 L -^LRO(69.2,LRAA,9) Q
 ;
END D V^LRU Q
