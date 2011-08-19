PSSDSFDB ;WOIFO/Steve Gordon - Allows for a user to disable FDB interface during an FDB update ;03/17/09
 ;;1.0;PHARMACY DATA MANAGEMENT;**136**;9/30/97;Build 89
 ;
 ;
EN ;driver
 ; Called from PSS ENABLE/DISABLE DB LINK option
 ;
 I '$G(DUZ) D DUZMSG Q  ;if no DUZ, cannot continue
 N OLDVAL
 ;get original value, if one exists
 S OLDVAL=+$G(^PS(59.73,1,0))
 Q:'$$LOCK()  ;lock file
 D
 .;if no entry create new one
 .I '$D(^PS(59.73,1,0)) D NEW
 .Q:'$$QSTION(OLDVAL)
 .D CHANGE('OLDVAL)
 .;if the connection is turned on, check for link 
 .I OLDVAL'=0,+$G(^PS(59.73,1,0))=0 D  Q
 ..N BASE
 ..S BASE="PSPRE"
 ..D PING^PSSHRIT(BASE)
 ..I $G(^TMP($J,BASE,"OUT",0))=0 W !!,"Connected to Vendor database successfully."
 ..E  W !!,"Connection could not be made to Vendor database."
 ..K ^TMP($J,BASE)
 ;
 D PRSRTN
 D UNLOCK
 Q
 ;
DUZMSG ;
 ;
 ;Writes a message that a DUZ is required
 W !,"You are not logged into the system."
 W !,"This option requires a DUZ (user ID) to be defined!"
 D PRSRTN
 Q
 ;
QSTION(OLDVAL) ;
 ;input: OLDVAL-original value of the .01 field of 59.73
 ;output-response to verification question (1 for yes, 0 for no)
 N NEWSTAT,FINAL,CURSTAT,ENFLAG
 K DIR,Y
 S FINAL=0  ;DEFAULT AS NO
 S NEWSTAT=$S(OLDVAL:"ENABLE",1:"DISABLE")
 S CURSTAT=$S(OLDVAL:"DISABLE",1:"ENABLE")
 S ENFLAG=$S(CURSTAT="ENABLE":1,1:0)
 D HELP(.DIR)
 D
 .I 'OLDVAL D DISMSG(.DIR) Q
 .D ENMSG(.DIR)
 S DIR(0)="Y^A"
 S DIR("B")=$S(ENFLAG:"NO",1:"YES")
 D ^DIR
 D
 .I $G(Y),ENFLAG S FINAL=$$ASK(NEWSTAT) Q
 .I 'ENFLAG S FINAL=+Y
 D
 .I ENFLAG D  Q
 ..I $G(FINAL) D
 ...W !!,?5,"Vendor database connection "_NEWSTAT_"D"_"."
 ...I NEWSTAT="DISABLE" D
 ....W !!,"REMEMBER to ENABLE the Vendor database connection AFTER task completed."
 ..I '$G(FINAL) W !!,?5,"The connection to the Vendor database remains ENABLED."
 .I 'ENFLAG D  Q
 ..;I FINAL W !!,"Vendor database connection reestablished." Q
 ..I FINAL W !!,"Vendor database connection enabled." Q
 ..I 'FINAL D
 ...W !!,"   WARNING! The connection to the Vendor Database remains DISABLED"
 ...I $T(DS^PSSDSAPI)]"",$$DS^PSSDSAPI() W !!,"NO Drug-Drug Interactions, Duplicate Therapy or Dosing Order Checks will be"
 ...E  W !!,"NO Drug-Drug Interactions or Duplicate Therapy Checks will be"
 ...W !,"performed while the connection is disabled!!!"
 Q FINAL
 ;
ASK(NEWSTAT) ;
 ;
 ;input: NEWSTAT-Either ENABLE or DISABLE
 ;output: Either 1 or 0 for yes or no
 K DIR,Y
 S DIR(0)="Y^A"
 S DIR("B")="NO"
 I $T(DS^PSSDSAPI)]"",$$DS^PSSDSAPI() S DIR("A",1)="NO Drug-Drug Interactions, Duplicate Therapy or Dosing Order Checks"
 E  S DIR("A",1)="NO Drug-Drug Interactions or Duplicate Therapy Order Checks"
 S DIR("A",2)="will be performed while the connection is disabled!!!"
 S DIR("A",3)=" "
 S DIR("A")="Are you sure you want to "_NEWSTAT_" the connection to the Vendor Database"
 D ^DIR
 Q Y
 ;
DISMSG(DIR) ;
 ;input: DIR Array
 ;output: sets up DIR message array
 S DIR("A",1)="The connection to the Vendor database is currently ENABLED."
 S DIR("A",2)=" "
 ;S DIR("A",3)="NO Drug-Drug Interactions, Duplicate Therapy or Dosing Order Checks"
 ;S DIR("A",4)="will be performed while the connection is disabled!!"
 S DIR("A",3)=""
 S DIR("A")="Do you wish to DISABLE the connection to the Vendor database"
 ;
ENMSG(DIR) ;
 ;;input: DIR Array
 ;output: sets up DIR message array
 S DIR("A",1)="    WARNING! The connection to the Vendor database is currently DISABLED."
 S DIR("A",2)=" "
 I $T(DS^PSSDSAPI)]"",$$DS^PSSDSAPI() S DIR("A",3)="NO Drug-Drug Interactions, Duplicate Therapy or Dosing Order Checks"
 E  S DIR("A",3)="NO Drug-Drug Interactions or Duplicate Therapy Order Checks"
 S DIR("A",4)="will be performed while the connection is disabled!!!"
 S DIR("A",5)=" "
 S DIR("A")="Do you wish to ENABLE the Vendor database connection"
 ;
NEW ;
 ;There will only be one entry at the top level
 N DINUM,DIC,DO,X
 K D0
 S DINUM=1,X=0,DIC="^PS(59.73,",DIC(0)="Z" D FILE^DICN
 Q
 ;
CHANGE(NEWVAL) ;
 ;edit flag once it is created.
 N DIE,DR,DA
 S DA=1
 S DIE="^PS(59.73,",DR=".01///^S X=NEWVAL"
 D ^DIE
 D ACT(NEWVAL)
 Q
ACT(NEWVAL) ;
 ;creates an activity log whenever FDB flag is reset to a new value
 ;
 N DIC,DA,X,ACTION,DIE,DO,DR
 S DIC="^PS(59.73,1,1,",DIC(0)="L",DA(1)=1
 S X=$$GETNOW()
 D FILE^DICN
 S ACTION=$S(NEWVAL:"D",1:"E")
 S DIE="^PS(59.73,1,1,",DA=+Y,DR="1///^S X=+DUZ;2///^S X=ACTION"
 D ^DIE
 Q
 ;
GETNOW() ;
 N PSNOW
 D NOW^%DTC
 S PSNOW=% K %
 Q PSNOW
 ;
LOCK() ;
 ;locks 59.73 file
 N LOCKED
 S LOCKED=1   ;SUCCESSFUL
 D
 .L +^PS(59.73,0):0
 .Q:$T
 .W !,"Another terminal is modifying this field!"
 .S LOCKED=0
 Q LOCKED
UNLOCK ;
 L -^PS(59.73,0)
 Q
 ;
HELP(DIR) ;
 ;Returns array of help for DIR call
 I $T(DS^PSSDSAPI)]"",$$DS^PSSDSAPI()  S DIR("?")="Enter either 'Y' or 'N'.  No Drug-Drug Interactions, Duplicate Therapy or Dosing Order Checks will be performed while the connection is disabled!!!"
 E  S DIR("?")="Enter either 'Y' or 'N'.  No Drug-Drug Interactions or Duplicate Therapy Order Checks will be performed while the connection is disabled!!!"
 Q
CHKSTAT() ;
 ; Called from IN^PSSHRQ2 routine
 ;RETURNS A -1 if FDB is disabled and 0 if enabled
 ;along with a standard message in PSSHRVL1
 N STAT
 S STAT=+$G(^PS(59.73,1,0))*-1  ;Returns either -1 or 0
 I STAT S STAT=STAT_U_$$STATMSG^PSSHRVL1()
 Q STAT
 ;
PRSRTN ;
 ;calls std routine to ask user to hit return 
 K DIR S DIR(0)="E" S DIR("A")="Press Return to Continue" D ^DIR
 Q
