ONCOFLF ;Hines OIFO/GWB - FOLLOWUP LETTER FUNCTIONS ;11/1/93
 ;;2.11;ONCOLOGY;**5,6,11,36,37,48,50**;Mar 07, 1995;Build 29
 ;
AED ;[EL Add/Edit Follow-up Letter]
 W !
 S (DIC,DLAYGO)="^ONCO(165.1,"
 S DIC("A")="Select letter to Add/Edit: ",DIC(0)="AELQZ",D="B"
 D IX^DIC G EX:Y<0
 S DA=+Y,DIE=DIC,DR="[ONCO FOLL ADD/EDIT LETTER]" K DC
 S DIA(1)=+Y,DIA=DIC,DIA("P")="165.1" D ^DIE
 G AED
 ;
UP ;[UP Update Contact File]
 W @IOF,!?15,"*************** UPDATE CONTACT FILE ***************"
 K DIR
 S DIR("A")="     Select function"
 S DIR(0)="SO^1:Add/Edit;2:Delete;3:Print;4:Cleanup"
 D ^DIR
 G EX:($D(DUOUT))!($D(DTOUT))!($D(DIRUT))!($D(DIROUT)) G @Y
 ;
1 ;Edit
 W !
 S (DIC,DIE)="^ONCO(165,"
 S DIC(0)="AELMQZ"
 S DLAYGO=165
 D ^DIC G UP:Y=-1 S DA=+Y
 W ! S DR="[ONCO UPDATE CONTACT]" D ^DIE G UP:$D(Y)'=0,1
 ;
2 ;Delete
 W !
 S DIC="^ONCO(165,"
 S DIC(0)="AEZQ"
 D ^DIC G EX:Y<0
 I ($D(^ONCO(165,"ACP",+Y)))!($D(^ONCO(160,"AC",+Y)))!($D(^ONCO(160,"AE",+Y))) W !!?10,"You may only delete contacts which are not being used." G 2
 S DA=+Y,DIK=DIC W !!?10,"Deleting Contact ",Y(0,0) D ^DIK G 2
 ;
3 ;Print
 K DIR
 S DIR("A")="Type of List"
 S DIR(0)="SO^A:Alphabetic;T:By Type"
 D ^DIR
 G EX:($D(DUOUT))!($D(DTOUT))!($D(DIRUT))!($D(DIROUT)) G @Y
 ;
A ;Alphabetic
 S BY="[ONCO CONTACT LIST-A]",L=0
 S DIC="^ONCO(165,",L=0 D EN1^DIP
 G EX
 ;
T ;By Type
 S BY="[ONCO CONTACT LIST-T]",L=0
 S DIC="^ONCO(165,",L=0 D EN1^DIP
 G EX
 ;
4 ;Cleanup
 W @IOF,?15,"************ Cleanout Unused Contacts ***********",!!
 G DAC^ONCOFDP
 ;
EX ;Exit
 K ADDED,BY,D,DA,DIC,DIA,DIE,DIK,DIR,DIROUT,DIRUT,DLAYGO,DR,DTOUT,DUOUT
 K FIEN,L,LIEN,NEWIEN,OP,TMP,X,Y
 Q
 ;
HP ;THE CONTACT (160.06,2) EXECUTABLE HELP
 K DIC,DXS,DIOT
 D ^ONCOXPC
 W !
 Q
 ;
EEACOS ;[AC Enter/Edit Facility file]
 W !
 W !,?3,"E      Edit an existing entry"
 W !,?3,"A      Add a new entry"
 W ! K DIR
 S DIR(0)="FAO^1:1",DIR("A")="Select Enter/Edit Facility file Option: "
 S DIR("?")=" Enter 'E' to edit an existing FACILITY or 'A' to add a new FACILITY"
 D ^DIR
 I $D(DIRUT) G EX
 I "AE"'[Y G EEACOS
 I Y="A" S ADDED=0 D ADD G EX:ADDED=0 G EEACOS:ADDED=1
 I Y="E" D EDIT G EX
 ;
EDIT ;Edit FACILITY file (160.19)
 W ! S (DIC,DIE)="^ONCO(160.19,",DIC(0)="AELMQZ",DLAYGO=160.19 D ^DIC
 Q:Y=-1
 S DA=+Y
 W ! S DR=".01;.02;.03;.04;101" D ^DIE
 G EDIT
 Q
ADD ;Add new FACILITY file (160.19) entry
 S FIEN=$O(^ONCO(160.19,"B",6999000,"")) I FIEN="" S NEWIEN=6999000
 I FIEN'="" S LIEN=6998999 F X=0:0 S LIEN=$O(^ONCO(160.19,"B",LIEN)) Q:LIEN=9999999  S TMP=LIEN
 I $G(TMP) S NEWIEN=TMP+1
 W !!,"NEXT AVAILABLE LOCAL FIN NUMBER IS ",NEWIEN,"."
 W !
 K DIR
 S DIR(0)="Y",DIR("A")="Do you want to add a new entry",DIR("B")="NO"
 D ^DIR I $D(DIRUT)!(Y=0) Q
 K DD,DO
 S DIC="^ONCO(160.19,",DIC(0)="L",X=NEWIEN D FILE^DICN K DIC,DLAYGO,DO
 W ! K DIE S DIE="^ONCO(160.19,",DA=+Y,DR=".01;.02;.03;.04" D ^DIE
 S ADDED=1
 Q
 ;
HELP ;EXCUTABLE HELP to display next available local FACILITY number
 S FIEN=$O(^ONCO(160.19,"B",6999000,"")) I FIEN="" S NEWIEN=6999000
 I FIEN'="" S LIEN=6998999 F X=0:0 S LIEN=$O(^ONCO(160.19,"B",LIEN)) Q:LIEN=9999999  S TMP=LIEN
 I $G(TMP) S NEWIEN=TMP+1
 W !
 W !?3,"If you wish to add a new facility, enter either the 7-digit"
 W !?3,"(6020009-6953290) or 8-digit (10000000+) assigned COC FIN"
 W !?3,"number."
 W !
 W !?3,"If the new facility does not have an assigned COC FIN number,"
 W !?3,"use the next available local FIN number.",!
 W !?3,"THE NEXT AVAILABLE LOCAL FIN NUMBER IS ",NEWIEN,".",!
 Q
