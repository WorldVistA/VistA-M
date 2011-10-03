IBCEMCA1 ;ALB/ESG - Multiple CSA Message Management - Actions ;20-SEP-2005
 ;;2.0;INTEGRATED BILLING;**320**;21-MAR-1994
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
REVSTAT ; change review status
 NEW DIR,X,Y,DA,DIRUT,DIROUT,DTOUT,DUOUT,NS,IBRVUST,IBFNRVAC,IBRVCMT
 NEW DIC,DWLW,DWPK,DIWESUB,DIWETXT,LN,IBDA,IBOLD,DIE,DA,DR
 D FULL^VALM1
 S NS=+$G(^TMP($J,"IBCEMCL",4))
 I 'NS D  G REVSTATX
 . W !!?5,"There are no selected messages." D PAUSE^VALM1
 . Q
 ;
 W !!?5,"Number of messages selected:  ",NS,!
 ;
 ; reader call for the new review status field
 S DIR(0)="361,.09"
 S DIR("A")="Enter the REVIEW STATUS for the selected message"_$S(NS>1:"s",1:"")
 D ^DIR K DIR
 I $D(DIRUT) G REVSTATX
 M IBRVUST=Y
 I IBRVUST'=2 G RVCQ    ; skip down to the confirmation
 ;
RSQ2 ; Reader call for the final review action field
 W !
 S DIR(0)="361,.1"
 S DIR("A")="Enter the FINAL REVIEW ACTION for the selected message"_$S(NS>1:"s",1:"")
 D ^DIR K DIR
 I X="",Y="" W !!?5,"This field is required when the review has been completed." G RSQ2
 I $D(DIRUT) G REVSTATX
 M IBFNRVAC=Y
 ;
RSQ3 ; review comment text
 W !
 K ^TMP($J,"IBCEMCA1-COMMENTS"),IBRVCMT
 S DIC="^TMP($J,""IBCEMCA1-COMMENTS"","
 S DWLW=75,DWPK=1,DIWESUB="REVIEW COMMENTS"
 S DIWETXT="These comments are optional"
 I IBFNRVAC="O" S DIWETXT="These comments are required because OTHER ACTION was selected."
 D EN^DIWE
 M IBRVCMT=^TMP($J,"IBCEMCA1-COMMENTS")
 K ^TMP($J,"IBCEMCA1-COMMENTS")
 I IBFNRVAC="O",'$D(IBRVCMT(0)) D  G RSQ3
 . W !!?5,"Comments are required when the Final Review Action is OTHER ACTION."
 . D PAUSE^VALM1
 . Q
 I $P($G(IBRVCMT(0)),U,4) S IBRVCMT=$P($G(IBRVCMT(0)),U,4)
 ;
RVCQ ; display a summary of the user responses and get confirmation
 W !!,"  Number of selected",!,"     Status Messages:  ",NS
 W !?7,"Review Status:  ",$G(IBRVUST(0))
 I IBRVUST=2 D
 . W !," Final Review Action:  ",$G(IBFNRVAC(0))
 . W !?5,"Review Comments:  "
 . I '$D(IBRVCMT(0)) W "<none>"
 . E  S LN=0 F  S LN=$O(IBRVCMT(LN)) Q:'LN  W !?5,IBRVCMT(LN,0)
 . Q
 W !
 S DIR(0)="YO"
 S DIR("A")="OK to proceed",DIR("B")="No"
 D ^DIR K DIR
 I Y'=1 G REVSTATX
 ;
 ; Loop thru selected status messages and update them
 S IBDA=0
 F  S IBDA=$O(^TMP($J,"IBCEMCL",4,1,IBDA)) Q:'IBDA  D
 . S IBOLD=$P($G(^IBM(361,IBDA,0)),U,9)    ; old review status
 . S DIE=361,DA=IBDA
 . S DR=".09////"_IBRVUST
 . I $G(IBFNRVAC)'="" S DR=DR_";.1////"_$G(IBFNRVAC)
 . D ^DIE
 . I $D(IBRVCMT(0)) D NOTECHG^IBCECSA2(IBDA,0,.IBRVCMT,1)
 . I IBOLD'=IBRVUST D NOTECHG^IBCECSA2(IBDA,0)
 . L -^IBM(361,IBDA)       ; unlock
 . Q
 W "   ... Done!"
 ;
 ; rebuild the list
 KILL ^TMP($J,"IBCEMCA"),VALMHDR
 S VALMBG=1
 D INIT^IBCEMCL
 I $G(IBCSAMCS)=1 S IBCSAMCS=2   ; flag to rebuild CSA
 ;
REVSTATX ;
 S VALMBCK="R"
 Q
 ;
COMMENT ; enter review comments
 NEW NS,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,IBRVCMT,DIC,DWLW,DWPK,DIWESUB,IBDA,LN
 D FULL^VALM1
 S NS=+$G(^TMP($J,"IBCEMCL",4))
 I 'NS D  G COMMX
 . W !!?5,"There are no selected messages." D PAUSE^VALM1
 . Q
 ;
 W !!?5,"Number of messages selected:  ",NS,!
 ;
 S DIR(0)="YO",DIR("B")="Yes"
 S DIR("A")="Do you want to add a new Review Comment for all of these messages"
 I NS=1 S DIR("A")="Do you want to add a new Review Comment for this message"
 D ^DIR K DIR
 I Y'=1 G COMMX
 ;
 ; review comment text
 W !
 K ^TMP($J,"IBCEMCA1-COMMENTS"),IBRVCMT
 S DIC="^TMP($J,""IBCEMCA1-COMMENTS"","
 S DWLW=75,DWPK=1,DIWESUB="REVIEW COMMENTS"
 D EN^DIWE
 M IBRVCMT=^TMP($J,"IBCEMCA1-COMMENTS")
 K ^TMP($J,"IBCEMCA1-COMMENTS")
 I $P($G(IBRVCMT(0)),U,4) S IBRVCMT=$P($G(IBRVCMT(0)),U,4)
 I '$D(IBRVCMT(0)) G COMMX    ; no comments entered
 ;
 ; final confirmation
 W !
 S LN=0 F  S LN=$O(IBRVCMT(LN)) Q:'LN  W !?5,IBRVCMT(LN,0)
 W !
 S DIR(0)="YO"
 S DIR("A")="OK to add this comment for all selected status messages",DIR("B")="No"
 I NS=1 S DIR("A")="OK to add this comment for the selected status message"
 D ^DIR K DIR
 I Y'=1 G COMMX
 ;
 ; Loop thru selected status messages and update them
 S IBDA=0
 F  S IBDA=$O(^TMP($J,"IBCEMCL",4,1,IBDA)) Q:'IBDA  D
 . D NOTECHG^IBCECSA2(IBDA,0,.IBRVCMT,1)
 . L -^IBM(361,IBDA)       ; unlock
 . Q
 W "   ... Done!"
 ;
 ; rebuild the list
 KILL ^TMP($J,"IBCEMCA"),VALMHDR
 S VALMBG=1
 D INIT^IBCEMCL
 ;
COMMX ;
 S VALMBCK="R"
 Q
 ;
RETRAN ; retransmit claims
 NEW NS,IBIFN,NSC,DIR,X,Y,DUOUT,DTOUT,DIRUT,DIROUT,IBDA,IB364
 D FULL^VALM1
 S NS=+$G(^TMP($J,"IBCEMCL",4))
 I 'NS D  G RETRANX
 . W !!?5,"There are no selected messages." D PAUSE^VALM1
 . Q
 ;
 ; count number of claims too
 S IBIFN=0 F NSC=0:1 S IBIFN=$O(^TMP($J,"IBCEMCL",4,2,IBIFN)) Q:'IBIFN
 ;
 W !!?5,"Number of messages selected:  ",NS
 W !?7,"Number of claims selected:  ",NSC,!
 ;
 S DIR("A",1)="In order to retransmit these claims, the transmission status for all of these"
 S DIR("A",2)="claims will be reset to be ""READY FOR EXTRACT"".  These claims will then be"
 S DIR("A",3)="sent with the next regularly scheduled claims transmission process."
 S DIR("A",4)=""
 S DIR("A")="Do you want to retransmit these claims"
 I NSC=1 D
 . S DIR("A",1)="In order to retransmit this claim, the transmission status for this claim will"
 . S DIR("A",2)="be reset to be ""READY FOR EXTRACT"".  This claim will then be sent with the"
 . S DIR("A",3)="next regularly scheduled claims transmission process."
 . S DIR("A")="Do you want to retransmit this claim"
 . Q
 S DIR(0)="YO",DIR("B")="No" D ^DIR K DIR
 I Y'=1 G RETRANX
 ;
 ; Loop thru selected claims and add new transmission records in a
 ; "Ready to Extract" status
 S IBIFN=0
 F  S IBIFN=$O(^TMP($J,"IBCEMCL",4,2,IBIFN)) Q:'IBIFN  D
 . S IBDA=+$O(^TMP($J,"IBCEMCL",4,2,IBIFN,""),-1)  ; most recent 361 ien
 . S IB364=+$P($G(^IBM(361,IBDA,0)),U,11)          ; transmit bill 364 ien
 . I 'IBDA!'IB364 Q
 . D UPDEDI^IBCEM(IB364,"R")        ; update EDI files for transmission
 . S Y=$$ADDTBILL^IBCB1(IBIFN,1)    ; add new transmission record
 . Q
 W "   ... Done!"
 ;
 ; rebuild the list
 KILL ^TMP($J,"IBCEMCA"),VALMHDR
 S VALMBG=1
 D UNLOCK^IBCEMCL
 D INIT^IBCEMCL
 I $G(IBCSAMCS)=1 S IBCSAMCS=2   ; flag to rebuild CSA
 ;
RETRANX ;
 S VALMBCK="R"
 Q
 ;
