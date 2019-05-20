VPRHSX ;SLC/MKB -- HS Options ;09/18/18 4:36pm
 ;;1.0;VIRTUAL PATIENT RECORD;**8**;Sep 01, 2011;Build 87
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; DIE                          10018
 ; DIR                          10026
 ; XUPROD                        4440
 ;
ON ; -- Turn monitoring on/off
 N X0,DA,DR,DIE,X,Y
 S X0=$G(^VPR(1,0)) I $P(X0,U,2),$$PROD^XUPROD D
 . W !,$C(7) ;On in production
 . W !,"WARNING: Turning off data monitoring will cause the Regional Health Connect"
 . W !,"         server to become out of synch with VistA!!"
 W ! S DA=1,DR=.02,DIE="^VPR(" D ^DIE
 Q
 ;
LAST ; -- Reset Last# for AVPR update list
 ; ^VPR("AVPR",seq#,DFN) = ICN ^ TYPE ^ ID ^ U/D ^ VISIT#
 N LAST,TOTAL,X0
 S LAST=+$G(^VPR(1,1)),TOTAL=LAST-(+$O(^VPR("AVPR",0)))+1
 ;
 I '$D(^VPR("AVPR")) D  Q
 . W !!,"There are no records in the update list."
 . I LAST,$$RESET S ^VPR(1,1)=0
 ;
 W !!,TOTAL_" records awaiting update, last sequence number is "_LAST
 S X0=$G(^VPR(1,0)) I $P(X0,U,2),$$PROD^XUPROD D
 . W !,$C(7) ;On in production
 . W !,"WARNING: Resetting the update list will cause the Regional Health Connect"
 . W !,"         server to become out of synch with VistA!!"
 W ! I $$SURE D
 . K ^VPR("AVPR") S ^VPR(1,1)=0
 . W !," ... queue cleared, list counter reset to 0."
 Q
 ;
SURE() ; -- delete update list?
 N X,Y,DIR,DUOUT,DTOUT
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Are you sure you want to clear the update list? "
 S DIR("?")="Enter YES to empty the list of records to update and reset the counter, or NO to exit without making any changes."
 D ^DIR S:$D(DUOUT)!$D(DTOUT) Y="^"
 Q Y
 ;
RESET() ; -- Reset sequence#?
 N X,Y,DIR,DUOUT,DTOUT
 S DIR(0)="YA",DIR("A")="Reset the list counter? ",DIR("B")="NO"
 S DIR("?")="Last sequence number used is "_LAST_"; select YES to reset the list counter to start over from 0."
 D ^DIR S:$D(DUOUT)!$D(DTOUT) Y="^"
 Q Y
 ;
GET ; -- Add patient/container/record to GET list
 N DFN,ICN,TYPE,ACT,VST,X
 I '$P($G(^VPR(1,0)),U,2) W !,"WARNING: Data Monitoring is currently disabled!",!
 ;
 S DFN=+$$PATIENT^VPRHST Q:DFN<1
 S ICN=$$GETICN^MPIF001(DFN) I ICN<0 W !,"ICN is required!",! Q
 ;
 I $$SUBS^VPRHS(DFN) D  Q
 . S TYPE=$$CONTNR^VPRHST,ACT="U" Q:"^"[TYPE
 . D P1^VPRHS W !," ... request added to update queue."
 ;
 W !,$C(7),"WARNING: This patient is not currently in the Edge Cache Repository (ECR)!",!
 S X=+$G(^DPT(DFN,.35)) I X D  Q
 . W !,"This patient has a Date of Death: "_$$FMTE^XLFDT(X)
 . W !,"Cannot add to ECR",!
 Q:'$$CONT  D NEW^VPRHS
 W !," ... request added to update queue."
 Q
 ;
CONT() ; -- continue?
 N X,Y,DIR,DUOUT,DTOUT
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Are you sure you want to continue with this patient? "
 S DIR("?")="Enter YES to add this patient to the ECR and subscribe to VistA updates, or NO to exit."
 D ^DIR S:$D(DUOUT)!$D(DTOUT) Y="^"
 Q Y
