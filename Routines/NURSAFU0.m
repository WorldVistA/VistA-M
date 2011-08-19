NURSAFU0 ;HIRMFO/RM,FT-SITE FILES Continued ;6/11/96
 ;;4.0;NURSING SERVICE;**41**;Apr 25, 1997
EN1 ; ENTRY FROM OPTION NURSFL-PRIV PRIVILEGE FILE EDIT
 Q:'$D(^DIC(213.9,1,"OFF"))  Q:$P(^DIC(213.9,1,"OFF"),"^",1)=1
 W ! S DLAYGO=212.6,DIC="^NURSF(212.6,",DIC(0)="AELQMNZ",DIC("A")="Enter Privilege: " D ^DIC K DIC G:+Y'>0 Q1 S DIE="^NURSF(212.6,",DR=".01;",DA=+Y D ^DIE G EN1
Q1 D ^NURSKILL Q
EN2 ; ENTRY FROM OPTION NURSSP-CONVPR CONVERSION NAME CHANGE PRINT
 W ! S DIC="^NURSF(219.7,",L=0,BY="[NURS-SORT BY TYPE/OLD NAME]",(FR,TO)="?,?",FLDS="[NURS-PRINT ENTRIES]"
 W !,"Enter (B)ulletin,(H)elp Frame,(O)ption, or (R)outine to define the type sort",!,"parameter. The default FIRST// will display all types in the above sequence."
 W !,"The letters N/A in the type field indicates that an item is inapplicable to",!,"this version of the package.",!
 D EN1^DIP,^NURSKILL
 Q
EN3 ; ENTRY FROM NURAFL-SPO SERVICE POSITION FILE EDIT
 S X=$G(^DIC(213.9,1,"OFF")) Q:X=""!(X=1)
 W ! S DLAYGO=211.3,DIC="^NURSF(211.3,",DIC(0)="AELQM",DIC("A")="Select Service Position abbreviation: "
 S DIC("DR")="" ;S DIC("DR")="1NAME;2PRIORITY SEQUENCE;S:$$EN7^NURSAFU0()'=""Y"" Y=""@1"";6R~PRODUCT LINE;S:X=1 Y=""@2"";@1;6///^S X=""NURSING"";@2;4SERVICE CATEGORY;S:X'=""R"" Y=0;3AMIS POSITION"
 D ^DIC K DIC G:+Y'>0 Q3 S NURANEW=+$P(Y,"^",3),DDSFILE="^NURSF(211.3,",DR="[NURA-I-SERVICE]",DA=+Y D ^DDS G EN3 ;S DIE="^NURSF(211.3,",DR="[NURA-I-SERVICE]",DIE("NO^")="OUTOK",DA=+Y D ^DIE G EN3
Q3 K NURSWT,NURANEW D ^NURSKILL Q
REQD ; Code called from post action of Page 1 of NURA-I-SERVICE form.
 ; This code will delete an entry in 211.3, if all required data not
 ; present, and entry is new.
 N NURADATA,DIK
 Q:+$G(DA)'>0
 ;VMP OIFO BAY PINES;ELR;NUR*4.0*41 ADDED NEXT LINE
 Q:+$G(NURANEW)'>0
 S NURADATA=$G(^NURSF(211.3,DA,0))
 I $P(NURADATA,"^",1)=""!($P(NURADATA,"^",2)="")!($P(NURADATA,"^",3)="")!($P(NURADATA,"^",5)="")!($P(NURADATA,"^",7)="") S DIK="^NURSF(211.3," D ^DIK W $C(7),!!,"ALL REQUIRED DATA NOT PRESENT, ENTRY DELETED!!"
 Q
EN4 ; ENTRY FROM NURAFL-TOD TOUR OF DUTY FILE EDIT
 Q:'$D(^DIC(213.9,1,"OFF"))  Q:$P(^DIC(213.9,1,"OFF"),U,1)=1
 W ! S DLAYGO=211.6,DIC="^NURSF(211.6,",DIC(0)="AELQMZ",DIC("A")="Enter Tour of Duty: " D ^DIC K DIC G:+Y'>0 Q4 S DIE="^NURSF(211.6,",DR=".01;1",DA=+Y,DIE("NO^")="OUTOK" D ^DIE G EN4
Q4 D ^NURSKILL Q
EN5 ; ENTRY FROM NURAFL-VAC VACANCY REASON FILE EDIT
 Q:'$D(^DIC(213.9,1,"OFF"))  Q:$P(^DIC(213.9,1,"OFF"),U,1)=1
 W ! S DLAYGO=211.9,DIC="^NURSF(211.9,",DIC(0)="AELQMZ",DIC("A")="Enter Vacancy Reason Code: " D ^DIC K DIC G:+Y'>0 Q5 S DIE="^NURSF(211.9,",DR=".01;1;2",DA=+Y,DIE("NO^")="OUTOK" D:'$P(Y,"^",3) ^DIE G EN5
Q5 D ^NURSKILL Q
EN6 ; Entry from NURSFL-PROD-LINE, PRODUCT LINE FILE EDIT
 Q:'$D(^DIC(213.9,1,"OFF"))  Q:$P(^DIC(213.9,1,"OFF"),U,1)=1
 S NURSEDIT=1
 W ! K DIC S DIC="^NURSF(212.7,",DIC(0)="AELMQZ",DLAYGO=212.7,DIC("A")="Select PRODUCT LINE NAME: "
 D ^DIC I +Y'>0 K DIC,DLAYGO Q
 I +Y=1,Y(0)="NURSING" W !,"NAME: NURSING//  (Uneditable)" G EN6
 S DA=+Y,DIE="^NURSF(212.7,",DR=.01 D ^DIE K DA,DIE,DR Q:$D(Y)
 G EN6
EN7() ; Return PRODUCT LINE site parameter value
 ; values are: Y - Yes
 ;             N - No
 ;               - Null
 Q $P($G(^DIC(213.9,1,0)),U,8)
 ;
EN8() ; Return FACILITY site parameter value
 ; values are: Y - Yes
 ;             N - No
 ;               - Null
 Q $P($G(^DIC(213.9,1,0)),U,9)
 ; 
