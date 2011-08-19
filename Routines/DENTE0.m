DENTE0 ;ISC2/SAW,HAG-EDIT/DELETE DENTAL NON CLINICAL TIME DATA ;4/29/96  13:54
 ;;1.2;DENTAL;**14,20**;Apr 15, 1996
NCLIN ;NON CLINICAL TIME
 S DLAYGO=226
NCLIN1 W !! S DIC="^DENT(226,",DIC("S")="I '$D(^DENT(226,+Y,.1))",DIC(0)="AELMNQ" D ^DIC K DLAYGO G:Y<0 EXIT S DA=+Y D LOCK^DENTE1 G:DENTL=0 NCLIN S DR="[DENT NONCLIN]",DIE("NO^")=1,DIE=DIC D ^DIE W ! L  G NCLIN
SITE ;SITE PARAMETERS
 W !! S DIC="^DENT(225,",DIC(0)="AELMQ",DLAYGO=225 D ^DIC K DLAYGO G:Y<0 EXIT S DA=+Y D LOCK^DENTE1 G:DENTL=0 SITE S DR=".01;1;2",DIE=DIC D ^DIE W ! L  G SITE
DELNC ;DELETE NON CLINICAL TIME
 W !! S DIC="^DENT(226,",DIC(0)="AEMNQ" D ^DIC G:Y<0 EXIT S DA=+Y D LOCK^DENTE1 G:DENTL=0 DELNC
NC0 W !!,"Would you like a display of the data for this Non Clinical Time entry" S %=1 D YN^DICN D:%=0 Q1 G NC0:%=0 I %<0 L  G DELNC
 I %=1 W !! S DR=0 D EN^DIQ
NC1 W !!,"Are you sure you want to delete this entry" S %=2 D YN^DICN D:%=0 Q2 G NC1:%=0 I %'=1 L  W !,"Nothing deleted." G DELNC
 S DIK=DIC D ^DIK W !!,"Entry deleted." R X:2 G DELNC
 Q
CHK S TEMP=Y,TEMP(0)=Y(0),TEMP(0,0)=Y(0,0),D=$P(TEMP,"^",2),DT1=$E(D,1,5)_"00",DENTSTA=$P(TEMP(0),"^",STA) D CHK1
 I $D(DENTF) S DIK="^DENT(H,",DA=DENTDA D ^DIK K DIK W *7,!!,"An entry already exists for station ",DENTSTA," for ",$P(TEMP(0,0)," ")," ",$P(TEMP(0,0)," ",4),".  Only one entry allowed",!,"per station per month."
 K TEMP
 Q
CHK1 F I=0:0 S DT1=$O(^DENT(H,"B",DT1)) Q:DT1=""!($D(DENTF))!($E(DT1,1,5)>$E(D,1,5))  I DT1'=D S F=$O(^DENT(H,"B",DT1,"")),DENTSTA2=$P(^DENT(H,F,0),"^",STA) S:DENTSTA=DENTSTA2 DENTF=1 Q:$D(DENTF)
 Q
Q1 W !!,"Press return or enter 'Y' or 'Yes' to display the data entry.",!,"Enter 'N' or 'No' if you do not want to display the data entry.",!,"Enter an uparrow (^) to exit." Q
Q2 W !!,"Press return or enter 'N' or 'No' if you do not want to delete the",!,"data entry.  Enter 'Y' or 'Yes' if you want to delete the data entry.",!,"Enter an uparrow (^) to exit." Q
EXIT Q
