SDSCLST ;ALB/JAM/RBS - ASCD Review List ; 4/24/07 4:29pm
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 ;**Program Description**
 ;  This program will build a list of entries to review
 Q
EN ;  Entry Point
 N DIR,X,Y,DTOUT,DUOUT
 ;  Ask which records should be reviewed.
 S SCOPT=$$SCSEL^SDSCUTL()
 I SCOPT="" G EXIT
 ;  Get start and end date for encounter list.
 D GETDATE^SDSCOMP I SDSCTDT="" G EXIT
 ;  Ask for division
 D DIV^SDSCUTL
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) G EXIT
 S SDSCDVSL=Y,SDSCDVLN=SCLN
 K SCLN,DIR
 ;  Determine type of user
 D TYPE^SDSCUTL
 ;  Call ListMan Screen
 D EN^SDSCLM
 ;
EXIT D END^SDSCEDT
 K EXIT,VALMBCK,VALMSG,SDCNT,SDEDT,SDSCBDT,SDSCDVLN,SDSCDVSL,SDSCEDT
 K SDSCTAT,SDSCTDT,SDANS,SCOPT
 Q
 ;
SEL ;  Select entry to review
 N DIR,SDSCMSG,DFN,SDOE,SDOE0,IEN,SDOEDT,SDEFLG
 S DIR("A")="Select Number to Review"
 S DIR(0)="NO^1:"_SDCNT D ^DIR K DIR
 I $D(DIRUT) K DIRUT D EXT Q
 I $G(DUOUT)!($G(DTOUT)) D EXT Q
 I $G(Y)<1 D EXT Q
 S IEN=^TMP($J,"SDSCENC",Y)
 ;  Call display build
 S SDOE=IEN,SDOE0=$$GETOE^SDOE(SDOE),SDOEDT=$P(SDOE0,U)
 I SDOEDT="" S VALMSG="Encounter has been deleted.",VALMBCK="R" Q
 I $$STDGET^SDSCRPT1() D  Q:'SDEFLG
 . S SDEFLG=0 D CHECK^SDSCEDT
 . I 'SDEFLG S VALMSG="Cannot edit."_$G(SDSCMSG),VALMBCK="R" Q
 . D DISPLAY^SDSCEDT
 ;Check if data came from an ancillary package and okay to edit
 I '$$ANCPKG^SDSCUTL(IEN) S VALMSG="Cannot edit encounter.",VALMBCK="R" Q
 ;  Check for sensitive patient and call ListMan if OK
 S DFN=$P(SDOE0,U,2)
 I DFN="" S VALMSG="Encounter has been deleted.",VALMBCK="R" Q
 I '$$SENS^SDSCUTL(DFN,1) D EN^SDSCLM1
 D RBLD^SDSCLM
 S VALMBCK="R"
 Q
 ;
EXT ;  Exit
 S VALMBCK=""
 S EXIT=1
 Q
 ;
EDT ; Edit SC Flag
 S SDANS="Y"
 D LEDT^SDSCEDT
 S VALMBCK="Q"
 Q
 ;
REV ;  Send to Review
 S SDANS="R"
 D LEDT^SDSCEDT
 S VALMBCK="Q"
 Q
 ;
ACC ;  Accept SC Flag
 S SDANS="N"
 D LEDT^SDSCEDT
 S VALMBCK="Q"
 Q
