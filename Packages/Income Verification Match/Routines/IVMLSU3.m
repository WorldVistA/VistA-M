IVMLSU3 ;ALB/MLI/KCL - IVM Functions from List Manager Application ; 7 Jan 94
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 ;
SSNUP ; - upload selected SSNs, reset data in array/file
 N X
 I 'IVMVSSN!(IVMUP'["V") G SPOUSE
 S X=$O(^DPT("SSN",IVMVSSN,0)),X=$$PT^IVMUFNC4(+X)
 I X]"" W !!,*7,"Social Security Number: "_$P(X,"^",2)_" is currently on file!" W !,"This SSN is in use by patient: ",$P(X,"^",1) D PAUSE^VALM1 G SPOUSE
 S DA=DFN,DIE="^DPT(",DR=".09///^S X=IVMVSSN" D ^DIE
 W !!?3,"...patient Social Security Number (SSN) has been updated.",!
 S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 ;
 ; - delete ssa/ssn for patient in the list man array
 S $P(^TMP("IVMUP",$J,IVMNM,IVMSSN,IVMI,IVMJ),"^",6)=""
 ;
 ;
SPOUSE ; - spouse ssn update (falls through)
 ;
 I 'IVMSIEN!(IVMUP'["S") G SSNUPQ
 S X=$P($G(^DGPR(408.12,IVMSIEN,0)),"^",3)
 S DA=+X,DIE="^"_$P(X,";",2),DR=".09///"_IVMSSSN D ^DIE
 W !!?3,"...spouse's Social Security Number (SSN) has been updated.",!
 S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 ;
 ; - delete spouse fields from list man array
 S $P(^TMP("IVMUP",$J,IVMNM,IVMSSN,IVMI,IVMJ),"^",7)="",$P(^(IVMJ),"^",8)="",$P(^(IVMJ),"^",9)=""
 ;
 ;
SSNUPQ ; - if no ssa/ssn for the patient and spouse - delete entry from list
 S X=^TMP("IVMUP",$J,IVMNM,IVMSSN,IVMI,IVMJ)
 I '$P(X,"^",6),'$P(X,"^",9) D DELENT
 K DA,DIE,DR,Y
 Q
 ;
 ;
DELENT ; - once entry is purged or uploaded - delete entry from (#301.5)
 ;   file and delete from list man array
 ;
 ;  Input:  IVMND  --  as pt name^pt ssn^dfn^sp ien^date of death^da(1)^da
 ;
 N X,Y
 K ^TMP("IVMUP",$J,IVMNM,IVMSSN,IVMI,IVMJ)
 S DA(1)=IVMI,DA=IVMJ,DIK="^IVM(301.5,"_DA(1)_",""IN"","
 D ^DIK
 K DA,DIC,DIK
 Q
 ;
 ;
RUSURE ; - Are you sure about UP-upload or PU-purge actions?
 ;
 ;  Input - IVMWHERE = "PU" if from purge, "UP" if from update
 ; Output - IVMOUT = 1 for '^', 2 for time-out, 0 otherwise
 ;          IVMSURE = 1 for yes, 0 for no
 ;
 N X,Y
 ;
 ; - set screen to full scrolling region
 D FULL^VALM1
 W !
 S IVMACT=$S(IVMWHERE="PU":"purge",1:"update")
 S DIR("A")="Are you sure you want to "_IVMACT_" this entry",DIR(0)="Y"
 ;
 ; - purge help
 I IVMACT="purge" D
 .S DIR("?",1)="Entering 'YES' at this prompt will cause the entire entry to"
 .S DIR("?",2)="be removed from the list.  Purging an entry will delete the"
 .S DIR("?",3)="SSA/SSN's that have been received from the IVM Center, for"
 .S DIR("?",4)="both the patient and his or her spouse."
 .S DIR("?",5)=" "
 .S DIR("?",6)="Entering 'NO' at this prompt will cause the entry to remain on"
 .S DIR("?",7)="the list.  The entry will remain on the list until either an"
 .S DIR("?")="'UPDATE' or 'PURGE' action has been taken"
 ;
 ; - update help
 I IVMACT="update" D
 .S DIR("?",1)="Entering 'YES' will update the SSN for "_$S(IVMUP="S":"the spouse.",IVMUP="VS":"both the patient and the spouse.",1:"the patient.")
 .S DIR("?",2)=" "
 .S DIR("?",3)="Entering 'NO' will cause the SSN for "_$S(IVMUP="S":"the spouse.",IVMUP="VS":"both the patient and the spouse.",1:"the patient.")
 .S DIR("?",4)="to remain on the list."
 .S DIR("?",5)=" "
 .S DIR("?",6)="Once an SSN has been updated, the entry will be removed from the"
 .S DIR("?",7)="list and the patient record will be updated with the SSA/SSN that"
 .S DIR("?")="was received from the IVM Center."
 S DIR("B")="NO"
 D ^DIR
 S IVMSURE=$G(Y)
 S IVMOUT=$S($D(DTOUT):2,$D(DUOUT):1,$D(DIROUT):1,1:0)
 K DIR,DIROUT,DTOUT,DUOUT,IVMACT
 Q
