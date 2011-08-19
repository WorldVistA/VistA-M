GECSETUP ;WISC/RFJ-initialize a code sheet                          ;30 Jan 89
 ;;2.0;GCS;;MAR 14, 1995
 N %,D,D0,D1,DA,DI,DIC,DIE,DQ,DR,GECS,I,J,X,Y
 W !,"First, you should use File Manager's 'Modify File Attributes' option",!,"and set up the fields used for this code sheet.  Use the field numbers",!,"and global nodes assigned to the application and ISC.  Also, use any"
 W !,"necessary input transforms for manipulating the data for the code sheet."
 W !!,"Secondly, you should use File Manager's 'Enter or Edit File Entries' option",!,"and create the Input Template corresponding to the fields used in the",!,"Generic Code Sheet system.  Selected fields should be in the order they"
 W !,"are to be coded."
 W !!,"Setting Up File 2101.7 GENERIC CODE SHEET SITE..."
 S (DIC,DIE)="^GECS(2101.7,",DIC(0)="QEALM" D ^DIC Q:+Y<0
 S DA=+Y,DR=".01;1" D ^DIE I $D(Y) Q
 ;
 W !!,"Setting Up File 2101.1 GENERIC CODE SHEET BATCH TYPE..."
 S (DIC,DIE)="^GECS(2101.1,",DIC(0)="QEALM" D ^DIC Q:+Y<0
 S (DA,GECS("DA"))=+Y,DR=".01:3" D ^DIE I $D(Y) Q
 ;
 W !!,"Setting Up File 2101.2 GENERIC CODE SHEET TRANSACTION TYPE/SEGMENT..."
 S (DIC,DIE)="^GECS(2101.2,",DIC(0)="QEALM" D ^DIC Q:+Y<0
 S DA=+Y,DR=".01:2" S $P(^GECS(2101.2,DA,0),"^",4)=GECS("DA") D ^DIE
 Q
