ANRVSITE ;BHAM/MAM - ENTER/EDIT PARAMETERS ; 4 Feb 98 / 9:00 AM
 ;;4.0; Visual Impairment Service Team ;;12 Jun 98
CHECK ; check to see if the entry exists
 S ANRVOUT=0 I $O(^ANRV(2041,0)) D EDIT01 I ANRVOUT G END
 I '$O(^ANRV(2041,0)) D CREATE I ANRVOUT G END
EDIT ; edit all information in the VIST PARAMETER file
 K DR S DIE=2041,DA=ANRVIFN,DR="[ANRV PARAM EDIT]" D ^DIE K DR,DIE,DA
END ; clean up variables, quit
 K ANRVSITE,ANRVOUT,DIC
 Q
EDIT01 ; edit the .01 node of the VIST PARAMETERS file
 S ANRVIFN=$O(^ANRV(2041,0)),X=$P(^ANRV(2041,ANRVIFN,0),"^"),ANRVSITE=$P(^DIC(4,X,0),"^")
 W !!,"The site name, "_ANRVSITE_", is already defined in the VIST PARAMETERS",!,"file.",!
 N DIR,DIRUT,DUOUT,DTOUT,X,Y
 S DIR(0)="Y",DIR("A")="Do you want to edit the SITE NAME in the VIST PARAMETER file",DIR("B")="No"
 S DIR("?")="Enter ""Yes"" to edit the site name in the VIST PARAMETERS file, ""No"" to exit."
 D ^DIR
 I $D(DUOUT)!$D(DIRUT) S ANRVOUT=1
 I Y'=1 W ! Q
 W !! K DR S DIE=2041,DA=ANRVIFN,DR=.01 D ^DIE K DR,DIE,DA
 Q
CREATE ; create new entry
 W !!,"There are no entries in the VIST PARAMETER file.  Only one entry can be created",!,"in this file.",!!
 N DIR,DIRUT,DUOUT,DTOUT,X,Y
 S DIR(0)="Y",DIR("A")="Do you want to add the SITE NAME to the VIST PARAMETER file now",DIR("B")="Yes"
 S DIR("?")="Enter ""Yes"" to enter the site name in the VIST PARAMETERS file, ""No"" to exit."
 D ^DIR
 I $D(DUOUT)!$D(DIRUT) S ANRVOUT=1
 I Y'=1 S ANRVOUT=1 Q
NEW ; add new entry to VIST PARAMETER file
 W !! K DIC S DIC=4,DIC(0)="QEAMZ" D ^DIC I Y<0 S ANRVOUT=1 Q
 K DA,DIC,DO,DD,DINUM,ANRVIFN S X=+Y,DIC="^ANRV(2041,",DIC(0)="L",DLAYGO=2041 D FILE^DICN K DIC,DLAYGO S ANRVIFN=+Y
 Q
