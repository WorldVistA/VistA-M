RAPURGE ;HISC/CAH - AISC/MJK - Schedule Data Purge ;4/17/03  08:45
 ;;5.0;Radiology/Nuclear Medicine;**34,41**;Mar 16, 1998
SCH ;Edit purge parameters and schedule Rad/Nuc Med data purge
 I '($D(DUZ)#2) W !!,$C(7),"No 'DUZ' code. Purging not allowed.",! Q
 I '$D(^VA(200,DUZ,0)) W !!,$C(7),"Not a valid 'DUZ' code. Purging not allowed.",! Q
 F I=1:1:15 W !?9,$P($T(REMIND+I),";;",2)
 S DIR(0)="Y",DIR("B")="Yes",DIR("?")="Enter 'YES' or 'RETURN' to edit purge parameters, or 'NO' not to.",DIR("A")="Do you want to edit the Imaging Type purge parameters" D ^DIR K DIR G QB:$D(DIRUT),PURGE:'Y
EDIT W !! S DIC="^RA(79.2,",DIC(0)="AEQM",DIC("A")="Select IMAGING TYPE: " D ^DIC K DIC I Y>0 S DA=+Y,DIE="^RA(79.2,",DIE("NO^")="",DR="[RA ON-LINE CRITERIA]" D ^DIE K DE,DQ,DIC,DIE,DR G EDIT
PURGE W ! S DIR(0)="Y",DIR("B")="No",DIR("A")="Do you wish to schedule the data purge",DIR("?")="Enter 'YES' to schedule the data purge, or 'NO' not to."
 D ^DIR K DIR I $D(DIRUT)!(Y=0) G QB
 D RECORD
 ; Display entries from 79.2 for selection
 N I,J,CNT,RAX S (I,J,CNT)=0 K RAPUR
 W !!?12,"IMAGING TYPES",!?12,"-------------",!
 ; RAX(sequential no.)=ien file 79.2
 F  S I=$O(^RA(79.2,"B",I)) Q:I=""  F  S J=$O(^RA(79.2,"B",I,J)) Q:'J  S CNT=CNT+1 W !?3,CNT,") ",I S RAX(CNT)=J
 W ! S DIR(0)="L^1:"_CNT,DIR("A")="Select Imaging Type(s) to Purge",DIR("?")="Select by number, one or more imaging types to be purged" D ^DIR K DIR I $D(DIRUT) G QB
 ; RAPUR(ien file 79.2)=""
 S I="" F J=1:1 S I=$P(Y,",",J) Q:'I  S RAPUR(RAX(I))=""
 W ! S DIR(0)="Y",DIR("B")="No",DIR("A")="Do you wish to re-purge records that have been purged in the past",DIR("?")="Enter 'YES' to re-purge records purged in the past, or 'NO' not to."
 D ^DIR K DIR G QB:$D(DIRUT) S RAREPURG=Y
 D ASKF
 G:'RAGO QB
 K RAX S RAX="" F  S RAX=$O(RAPUR(RAX)) Q:'RAX  S DA=RAX,DIE="^RA(79.2,",DR="100///""NOW""",DR(2,79.23)="2///S;3////"_DUZ D ^DIE
 K DA,DE,DIE,DQ,DR
 S ZTRTN="START^RAPURGE1",ZTSAVE("RAPUR*")="",ZTSAVE("RAREPURG")="",ZTDESC="Rad/Nuc Med Data Purge" W ! D ZIS^RAUTL G Q:RAPOP
 G START^RAPURGE1
QB W !,"--Nothing Done--"
Q K D0,D1,DA,DLAYGO,POP,RAPOP,RAPR,RAPUR,RAREPURG,X,Y,ZTDESC,ZTRTN,ZTSAVE,RAMES,RAGO,RAPURTYP Q
 ;
RECORD ; select which records to purge
 S DIR(0)="S^E:Exams only;R:Reports only;B:Both exams & reports;"
 S DIR("?")="Do you want to purge Exams, Reports, Exams & Reports ?"
 S DIR("A")="Enter type of data to purge"
 S DIR("B")="Reports only"
 D ^DIR K DIR
 S RAPURTYP=Y
 Q
ASKF ;ask final question
 S RAGO=0
 W !!,"You have chosen to purge ",$S(RAPURTYP="E":"Exam",RAPURTYP="R":"Report",RAPURTYP="B":"Exam & Report",1:"?")," records from "
 S I=""
 F  S I=$O(RAPUR(I)) Q:'I  W " ",$P(^RA(79.2,I,0),U) W:$O(RAPUR(I)) ","
 W !
 S DIR(0)="Y",DIR("B")="No",DIR("A")="Do you wish to proceed with the purge"
 S DIR("?")="Enter 'YES' to go ahead with the purge, or 'NO' to exit from this option."
 D ^DIR K DIR
 S RAGO=Y
 Q
REMIND ;
 ;;+--------------------------------------------------------+
 ;;| This option is used to remove data from one or all of  |
 ;;| these globals:  ^RADPT, ^RARPT                         |
 ;;|                                                        |
 ;;| Make sure IRM keeps the backup that was made prior to  |
 ;;| running this option, and NOT overwrite that backup for |
 ;;| at least 6 months.  Data from ^RADPT and ^RARPT can be |
 ;;| recovered.                                             |
 ;;|                                                        |
 ;;| The cut-off dates for the 4 items (activity log,       |
 ;;| report, clinical history, tracking time) are           |
 ;;| compared to the exam date of those items.  If the      |
 ;;| exam date for an item is older than the cut-off date   |
 ;;| for that item, then that item would be purged.         |
 ;;+--------------------------------------------------------+
 ;;
 Q
