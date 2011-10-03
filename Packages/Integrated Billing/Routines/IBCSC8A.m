IBCSC8A ;BP/YMG - ADD/ENTER CHIROPRACTIC DATA ;06/08/2007
 ;;2.0;INTEGRATED BILLING;**371**;21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ;
 N DAM,DIT,EC,LXD,OK,PCC,PCCI,UO,UR
 S UO="UNSPECIFIED [OPTIONAL]",UR="UNSPECIFIED [REQUIRED]"
 S EC="000"
EN1 ;
 S OK=1
 S DIT=$$GET1^DIQ(399,IBIFN,246) S:DIT="" DIT=UR
 S PCCI=$P($G(^DGCR(399,IBIFN,"U3")),U,7)
 S PCC=$S(PCCI'="":PCCI_" ("_$$EXTERNAL^DILFD(399,248,"",PCCI)_")",1:UR)
 S DAM=$$GET1^DIQ(399,IBIFN,247) S:DAM="" DAM=$S("AM"'[PCCI!(PCCI=""):UO,1:UR)
 S LXD=$$GET1^DIQ(399,IBIFN,245) S:LXD="" LXD=UO
 D DISP,EDIT G:'OK EN1
 D CLEAN^DILF
 Q
 ;
DISP ; display existing values
 W @IOF,!,"============================= CHIROPRACTIC DATA ==============================",!
 D:+EC DSPERR
 W !!,?3,"----------------------  Current values for Bill  -----------------------",!
 W !,?3,"Date of initial treatment   : ",DIT
 W !,?3,"Patient condition code      : ",PCC
 W !,?3,"Date of acute manifestation : ",DAM
 W !,?3,"Last x-ray date             : ",LXD,!
 Q
 ;
EDIT ; edit data
 N DEL,TOUT,UOUT
 S DIE="^DGCR(399,",DR="246;248;247;245",DA=IBIFN D ^DIE S TOUT=$D(DTOUT),UOUT=$D(Y) K DIE,DR,DA D CHK
 ; if all data is valid, we are done here
 Q:'+EC
 ; we get here if:
 ; - all prompts have been answered, but data is invalid, or
 ; - editing was interrupted by user ("^" exit), or
 ; - editing timed out
 ;
 ;if "^"-exit and user doesn't want to discard data, or all prompts answered, go back to the same screen
 I 'TOUT S DEL=1 D  I DEL=0!('UOUT) S OK=0 Q
 .; if "^"-exit, ask if data should be discarded
 .I UOUT S DIR(0)="Y",DIR("A")="Delete Chiropractic Data",DIR("B")="YES" D ^DIR S DEL=$G(Y) K DIR
 .Q
 ; if user requested to delete data or entry prompt timed out, clear out chiro fields
 S DIE="^DGCR(399,",DR="246///@;248///@;247///@;245///@",DA=IBIFN D ^DIE K DIE,DR,DA
 Q
 ;
CHK ; check data integrity
 ; sets 3 char error code in EC, each position containing 0 means no error
 ; positions containing 1 trigger the following errors:
 ; position 1 - Date of Initial Treatment is missing
 ; position 2 - Patient Condition Code is missing
 ; position 3 - Date of Acute manifestation is missing (for Patient Condition Code = A or M)
 N IBX,PCC
 S IBX=$P($G(^DGCR(399,IBIFN,"U3")),U,4,7),EC="000"
 ; chiropractic claim if any of the fields are populated
 S:$TR(IBX,U)'="" PCC=$P(IBX,U,4),$E(EC,1)=($P(IBX,U,2)=""),$E(EC,2)=(PCC=""),$E(EC,3)=($P(IBX,U,3)=""&(PCC]"")&("AM"[PCC))
 Q
DSPERR ; display errors
 W !,?3,"Errors detected:"
 W:+$E(EC,1) !,?5,"Date of Initial Treatment is required"
 W:+$E(EC,2) !,?5,"Patient Condition Code is required"
 W:+$E(EC,3) !,?5,"Condition code A or M requires Date of Acute Manifestation"
 Q
