ORLP2 ; SLC/Staff - Remove Autolinks from Team List ; [1/2/01 11:43am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**47,98**;Dec 17, 1997
 ;from option ORLP REMOVE AUTOLINKS - remove autolinks from team lists
 N %X,%Y,ACT,ALINK,CNT,DA,DIC,DIE,DIK,DIR,DLAYGO,DR,DTOUT,DUOUT,FILE,K,LINK,LIST,LNAME,LNK,LST,ORLPT,ORSTOP,ORUS,REF,TEAM,USER,VP,Y
 D CLEAR^ORLP
 W @IOF
 W !,"A team list is a list containing patients related to several providers.",!,"These providers are the list's users.  You may select one of these lists"
 W !,"and remove one or more autolinks.  Removal of autolinks will stop the",!,"automatic addition or deletion of patients with ADT movements associated",!,"with the deleted autolink."
 W !!,"Patients that were placed on the list using the deleted autolink will be",!,"removed from the list if they were not placed on the list by another Autolink.",!!
 D ASKLIST I $D(DTOUT)!($G(ORSTOP)) D END Q
 D ASKLINK(LIST) I $D(DTOUT)!($G(ORSTOP)) D END Q
 D END
 Q
 ;
ASKLIST ;ask for team list
 N DIC,DA,DIE
 S DIC="^OR(100.21,",DIC(0)="AEFMQ",DIC("S")="I $P(^(0),U,2)[""A""",DIC("A")="Enter team list name: "
 D GETDEF^ORLPL ;get list default, if one exists
 D ^DIC I Y'>0 S ORSTOP=1 Q
 S LIST=Y,^TMP("ORLP",$J,"TLIST")=+Y
 I '$O(^OR(100.21,+LIST,2,0)) W !,"No Autolinks established for this team",! S ORSTOP=1 Q
 I $O(^OR(100.21,+Y,10,0)) D
 . F  D  Q:%
 .. S ORSTOP=0 W !,"List ",$P(Y,"^",2)," already contains patients and/or users.",!,"Do you want to remove some of them" S %=1 D YN^DICN I %=1 L +^OR(100.21,+LIST) Q
 .. I '% W !,"Answer 'YES' to delete existing 'Autolinks' and the associated patients,",!,"'NO' to return to the menus.",!
 .. S ORSTOP=%'=1
 Q
 ;
ASKLINK(LIST) ;ask for autolinks
 I +$G(LIST)'>0 Q
 S ORUS="^OR(100.21,+LIST,2,",ORUS(0)="40MN",ORUS("T")="W @IOF,?31,""TEAM AUTOLINK LIST"",!",ORUS("A")="Enter Autolink(s) to REMOVE from list: "
 D ^ORUS S %X="Y(",%Y="ALINK(" D %XY^%RCR I '$O(ALINK(0)) Q
 K ^TMP("ORLP",$J,"LINK"),^TMP("ORLP",$J,"UNLINK")
 ;
 ; Build ^TMP global of all patients that would be on list because
 ; of the deleted autolinks and delete autolinks
 S LNK=0 F  S LNK=$O(ALINK(LNK)) Q:'LNK  D
 . I $P(^OR(100.21,+LIST,0),U,2)["A",'$O(^OR(100.21,+LIST,2,0)) Q
 . S VP=$G(^OR(100.21,+LIST,2,+ALINK(LNK),0)),VP(1)="^"_$P($P(VP,";",2),U),VP(2)=+VP,LNAME=$P(ALINK(LNK),U,3) D PTS(.VP,"UNLINK")
 . S DA=+ALINK(LNK),DA(1)=+LIST,DIE="^OR(100.21,"_DA(1)_",2,",DR=".01///@" D ^DIE W !,"  Autolink "_$P(ALINK(LNK),U,3)_" deleted!"
 ;
 ; Build ^TMP global of all patients that would be on list because
 ; of remaining autolinks.
 S DA(1)=+LIST,DIC="^OR(100.21,"_DA(1)_",2,",DIC(0)="NZ"
 S LST=0 F  S LST=$O(^OR(100.21,+LIST,2,LST)) Q:'LST  S X="`"_LST D ^DIC   S VP=Y(0),VP(1)="^"_$P($P(VP,";",2),U),VP(2)=+VP,LNAME=Y(0,0) D PTS(.VP,"LINK")
 K DIC
 ; if the patient is on list because of remaining autolink leave them 
 ; there otherwise delete them
 S CNT=0,K="" F  S K=$O(^TMP("ORLP",$J,"UNLINK",K)) Q:K=""  D
 . I '$D(^TMP("ORLP",$J,"LINK",K)) S DA=$O(^OR(100.21,+LIST,10,"B",K,0)) I DA S DA(1)=+LIST,DIK="^OR(100.21,"_DA(1)_",10," D ^DIK K DIK S CNT=CNT+1
 W !,"  "_CNT_" patient(s) removed from list.",!
 Q
 ;
PTS(VP,ACT) ;
 ; set or kill entries out of temp global 
 ; set for patients found to be on a deleted link
 ; kill for patients to be on another autolink.
 ; ("Clinic" addition to $SELECT function added by PKS-6/99:)
 I ACT="UNLINK" W !,"[ADT movements linked to "_$S(VP["DIC(42":"Ward Location ",VP["DG(405":"Room Bed ",VP["VA(200":"Provider ",VP["SC(":"Clinic ",1:"Treating Speciality ")_LNAME_" will now be discontinued.]"
 I VP(1)="^DIC(42," D LOOPTS("CN",LNAME,ACT) Q
 I VP(1)="^DG(405.4," D LOOPTS("RM",LNAME,ACT) Q
 I VP(1)="^VA(200," D  Q
 . I $P(VP,U,2)="B" D LOOPTS("APR",+VP,ACT),LOOPTS("AAP",+VP,ACT) Q
 . I $P(VP,U,2)="P" D LOOPTS("APR",+VP,ACT) Q
 . I $P(VP,U,2)="A" D LOOPTS("AAP",+VP,ACT) Q
 I VP(1)="^DIC(45.7," D LOOPTS("ATR",+VP,ACT) Q
 ; Next line added by PKS on 6/99:
 I VP(1)="^SC(" D LOOPCL("SC",+VP,ACT) Q
 Q
 ;
LOOPTS(REF,DEX,ACT) ;
 S ORLPT=0 F  S ORLPT=$O(^DPT(REF,DEX,ORLPT)) Q:'ORLPT  S X=ORLPT_";DPT(" S ^TMP("ORLP",$J,ACT,X)=""
 Q
 ;
LOOPCL(REF,CLINIC,ACT) ; slc/PKS - 6/99
 ;
 ; Add CLINIC linked patients to ^TMP list of all Autolink patients,
 ;    so they can be evaluated for deletion if not duplicated
 ;    by another Autolink.
 ;
 ; Variables used:
 ;
 ;    REF     = Passed as "SC" for code clarity but not used herein.
 ;    CLINIC  = Clinic to search.
 ;    ACT     = Action to take ("LINK" or "UNLINK").
 ;    ORLIST  = Array, returned by call to PTCL^SCAPMC.
 ;    ORERR   = Array for errors, returned by call to PTCL^SCAPMC.
 ;    RESULT  = Holds result of PTCL^SCAPMC call (1=OK, 0=error).
 ;    RCD     = Holder for each record in ^TMP of PTCL^SCAPMC.
 ;    PATIENT = Patient IEN.
 ;    X       = Temp value holder variable.
 ;
 N ORLIST,ORERR,RESULT,RCD,PATIENT,X
 ;
 ; Process the Autolink entries:
 K ^TMP("SC TMP LIST") ; Clean up potential leftover data.
 S RESULT=$$PTCL^SCAPMC(CLINIC,,.ORLIST,.ORERR)
 I RESULT=0 W !,"Processing ERROR - patients NOT deleted for this autolink." Q  ; Abort if there's a problem.
 ; Clinic patients should now be in ^TMP("SC TMP LIST",$J file.
 ;
 ; Write patients to the new, second ^TMP file for further processing.
 S RCD=0 ; Initialize.
 F  S RCD=$O(^TMP("SC TMP LIST",$J,RCD)) Q:'RCD  D  ; Read each record from first ^TMP file.
 .S PATIENT=$P(^TMP("SC TMP LIST",$J,RCD),"^") ; Patient IEN.
 .S X=PATIENT_";DPT(" ; Add to patient string.
 .S ^TMP("ORLP",$J,ACT,X)="" ; Write to second ^TMP file.
 .Q  ; Loop for each record in ^TMP file written to new ^TMP file.
 ;
 K ^TMP("SC TMP LIST",$J) ; Clean up first ^TMP file entries.
 ;
 Q
 ;
REN ; SLC/PKS - 7/99
 ; 
 ; Allow users to rename a Team List.
 ;    Shows as a selection on menu of ORLP TEAM MENU option,
 ;    Called by option ORLP TEAM RENAME shown on that menu.
 ;
 ; Variables used:
 ;
 ;    DIC    = Fileman call.
 ;    Y      = DIC output variable containing existing Team List name.
 ;    DIE    = Fileman call.
 ;    DR     = DIE input variable.
 ;    ORTEAM = Selected team.
 ;    ORNEW  = New name to use in renaming of Team List.
 ;
 N DIC,DIR,DIE,DR,ORTEAM,ORNEW
 ;
 ; Allow selection of a Team List to rename:
 S DIC="^OR(100.21,"
 S DIC(0)="AEFQ"
 S DIC("A")="Enter team list name: "
 D ^DIC ; Call Fileman function for lookup of Team List name.
 I ($D(DTOUT))!($D(DUOUT)) Q  ; Punt if there's a problem.
 I '(Y>0) Q                   ; Punt if no entry selected.
 S ORTEAM=$P(Y,"^")           ; Assign IEN of list selected by user.
 K DIC
 ;
 ; Call Fileman's DIR to get formatted user input:
 ;
 S DIR(0)="FA^3:30^KILL:(X?.N)!'(X'?1P.E) X"
 S DIR("A")="Enter new team list name: "
 S DIR("?")="Name must be from 3-30 characters and not begin with punctuation or consist wholly of numbers"
 S DIR("??")=DIR("?")
 D ^DIR
 I ($D(DTOUT))!($D(DUOUT)) Q  ; Punt if there's a problem.
 I Y=-1 K DIR Q  ; Punt if no input is made.
 S ORNEW=X
 K DIR
 ;
 L +^OR(100.21,ORTEAM):3 ; Lock the file at the Team List level.
 I ('$TEST) W !,"Another user is editing this entry." QUIT  ; Punt if there's a file locking conflict.
 ;
 ; Call Fileman function to implement renaming:
 S DIE="^OR(100.21,"
 S DA=ORTEAM
 S DR=".01///^S X=ORNEW"
 D ^DIE ; Writes to first field of .01 record.
 S DR=".1///^SET X=ORNEW"
 D ^DIE ; Writes to third field of .01 record.
 ;
 L -^OR(100.12,ORTEAM) ; Unlock file.
 K DIE
 Q
 ;
END ;
 I '$G(LIST) Q
 L -^OR(100.21,+LIST)
 Q
 ;
