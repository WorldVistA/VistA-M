PRCTFLD ;WISC@ALTOONA/RGY-HANDLE ENTER/EDIT TO 446.5 ;01 Jun 90/3:26 PM
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S PRCTF=+$P(^PRCT(446.5,DA(1),0),"^",2),PRCTFLDS="",PRCTEXT=0 S PRCTDEF=$P(^(2,DA,0),"^",4) I 'PRCTF W *7 D NOFIL^PRCTMES2 G Q
 I PRCTDEF]"" W !!,"The following field translates as the" S PRCTE=PRCTDEF,FL=PRCTF F Y=0:0 S Y=$S($E(PRCTE,1,6)="NUMBER":"NUMBER",1:+PRCTE),PRCTE=$P(PRCTE,Y,2,999) Q:Y=0  D DIS S PRCTE=$E(PRCTE,2,999)
A S X="  "_$S($D(^DIC(PRCTF,0,"GL")):$P(@(^("GL")_"0)"),"^"),1:$P(^DD(PRCTF,0),"^"))_" FIELD:"_$S(PRCTDEF]"":" "_PRCTDEF_"//",1:"")_"^^^^^^1" D ^PRCTQUES G:X="^" Q
 I X="NUMBER" S $P(^PRCT(446.5,DA(1),2,DA,0),"^",4)=PRCTFLDS_"NUMBER" G Q
 I X=0,$E(PRCTFLDS,$L(PRCTFLDS))="," S $P(^PRCT(446.5,DA(1),2,DA,0),"^",4)=PRCTFLDS_0 G Q
 S DIC("W")="I $P(^(0),U,2) W $P(""  (multiple)^  (word-processing)"",U,$P(^DD(+$P(^(0),U,2),.01,0),U,2)[""W""+1)"
 S:$L(X,":")-1 PRCTEXT=1,X=$P(X,":",1,$L(X,":")-1) S DIC="^DD("_PRCTF_",",DIC(0)="QEM" D ^DIC G A:X["?",Q:X=""&(Y<0) G:Y<0 A S X=+Y
 I PRCTEXT S PRCTEXT=0,Y=+$P($P(^DD(PRCTF,X,0),"^",2),"P",2) W:'Y *7," ... Field not a pointer !" S:Y PRCTF=Y,PRCTDEF="",PRCTFLDS=PRCTFLDS_X_":" G A
 I $P(^DD(PRCTF,+X,0),"^",2) S PRCTFLDS=PRCTFLDS_X_",",PRCTF=+$P(^DD(PRCTF,+X,0),"^",2),PRCTDEF="" G A
 S $P(^PRCT(446.5,DA(1),2,DA,0),"^",4)=PRCTFLDS_X
Q K FL,PRCTDEF,PRCTFLDS,PRCTF,PRCTEXT,DIC Q
DIS ;
 W !,$S(Y="NUMBER":Y,$D(^DD(FL,Y,0))#2:$P(^(0),"^"),1:"*** UNKNOWN ***")," field of the ",$S($D(^DIC(FL,0))#2:$P(^(0),"^")_" file",$D(^DD(FL,0))#2:$P(^(0),"^")_" multiple",1:"*** UNKNOWN ***")
 I $E(PRCTE)]"" W " which extends to the" S FL=$S($D(^DD(FL,Y,0)):$S($E(PRCTE)=":":+$P($P(^(0),"^",2),"P",2),1:+$P(^(0),"^",2)),1:-1)
 Q
