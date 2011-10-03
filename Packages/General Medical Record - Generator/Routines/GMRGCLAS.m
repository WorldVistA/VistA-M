GMRGCLAS ;HIRMFO/RM-TERM CLASSIFICATION FILE EDIT ;1/23/96
 ;;3.0;Text Generator;;Jan 24, 1996
EN1 ; ENTRY TO ADD DATA TO AGGREGATE TERM FILE IF PACKAGE IS KNOWN
 ; PACKAGE IN VARIABLE GMRGPK.
 Q:'$D(GMRGPK)
 S DIC("S")="I $P(^(0),U,2)=GMRGPK",DIC("A")="Select Classification to be modified: ",DIC="^GMRD(124.25,",DIC(0)="AEQML",DLAYGO=124.25
 S DIC("DR")="1///^S X=GMRGPK"
 W ! D ^DIC K DIC Q:+Y'>0  S DA=+Y,DIE="^GMRD(124.25,",DR=".01;2;S:DUZ(0)'=""@"" Y=""@1"";7;8;9;10;@1" D ^DIE
 G EN1
EN2 ; SELECT PACKAGE FOR WHICH ADDING TERMS
 W !!,"PACKAGE REFERENCE: " R X:DTIME G Q3:"^^"[X!'$T
 I $L(X)<2!($L(X)>5)!(X?1P.E) W !?5,$C(7),"This is a reference for which to identify which package an aggregate",!?5,"term entry belongs.  Answer must be 2-5 characters in length.",!!?5,"References already used include: " D LP G EN2
 S GMRGPK=X D EN1
Q3 K GMRGLP,GMRGPK
 Q
LP ;
 S X="" F GMRGLP=0:0 S X=$O(^GMRD(124.2,"AA",X)) Q:X=""  W !?18,X
 Q
