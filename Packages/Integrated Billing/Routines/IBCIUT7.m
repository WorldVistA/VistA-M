IBCIUT7 ;DSI/ESG - COMMENTS FIELD UTILITIES ;16-JULY-2001
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
COMMENT(IBIFN,TYPE) ; Capture the comments
 ; This procedure will capture and file all comments to be stored
 ; in field 2.01 of the ClaimsManager file (#351.9).
 ;
 ; TYPE=1 indicates Exit comments:
 ; This procedure is called from IBCSCP and from IBCB2 whenever
 ; the status of the bill in the ClaimsManager file is 4 (returned
 ; with errors) and the user is trying to exit out of the screens
 ; without correcting the errors found.
 ; This is also called from the ListMan screen routine IBCIMG.
 ;
 ; TYPE=2 indicates overriding the CM errors:
 ; This procedure is called from IBCIMG whenever the user wants to
 ; override the ClaimsManager errors.
 ;
 ; TYPE=3 indicates the bill is being cancelled:
 ; This procedure is called from IBCIST in order to move the cancel
 ; comments into this file when cancelling a bill that has been thru
 ; the ClaimsManager interface.
 ;
 ; TYPE=4 indicates that the bill was sent from the multiple claim
 ; send option and some ClaimsManager errors were found.  Record a
 ; comment indicating how this bill was sent to ClaimsManager.  This
 ; procedure is called from IBCIUT2 in this case.
 ;
 ; TYPE=5 indicates that the bill is being reassigned by a user, 
 ; typically a coder, to another user, typically a biller, 
 ; from a standalone option which allows only users to
 ; re-assign a bill.  This procedure is called from IBCIASN, which
 ; as indicated above, is a standalone option available only from 
 ; menus which are assigned at sites.
 ;
 NEW CMNT,D0,DA,DI,DIC,DIE,DN,DQ,DR,LASTONE,LASTTXT
 NEW NOCOMMSG,NOW,REASON,X
 NEW COMMCHG,NEWCOMCT,OLDCOMCT,CMT,PREVCHG
 NEW WHO,WHEN,AUDITMSG
 ;
 ; Intro text and set-up to read WP field for exit comments
 I TYPE=1 D
 . W !!?2,"There are still some unresolved errors reported by ClaimsManager."
 . W !?2,"Please enter some comments before exiting this option.",!
 . Q
 ;
 ; Intro text and set-up to read WP field for override comments
 I TYPE=2 D
 . W !!?2,"Please enter some comments indicating why you are overriding"
 . W !?2,"the errors reported by ClaimsManager.",!
 . Q
 ;
 ; for cancel processing, just grab the reason cancelled field and
 ; stuff it in here
 I TYPE=3 D
 . S REASON=$P($G(^DGCR(399,IBIFN,"S")),U,19)
 . D DCOM^IBCIUT4(IBIFN)   ; delete whatever's in there
 . S DIE="^IBA(351.9,",DA=IBIFN,DR="2.01///^S X=REASON"
 . D ^DIE
 . Q
 ;
 ; for bills with errors from the multiple claim send option,
 ; just stuff in some text.
 I TYPE=4 D
 . S DIE="^IBA(351.9,",DA=IBIFN,DR="2.01///This Bill was sent to ClaimsManager from the Multiple Claim Send Option."
 . D ^DIE
 . Q
 ;
 ; for bills that a coder is re-assigning
 I TYPE=5 D
 . W !!?2,"Please enter some comments for the person to whom this"
 . W !?2,"bill will be assigned.",!
 . Q
 ;
 ; Define a variable for the "no comments entered" text
 S NOCOMMSG="   << No Comments Entered >>"
 ;
 ; Capture and file just the word-processing field here.
 ; If the user made an illegal edit, then do it again.
WP I $F(".1.2.5.","."_TYPE_".") D  I PREVCHG G WP
 . ;
 . ; if the only comment currently in there is the message about
 . ; there being no comments, then blow that stuff away before
 . ; reading in the new comments.
 . S LASTONE=+$O(^IBA(351.9,IBIFN,2,99999999),-1)
 . S LASTTXT=$P($G(^IBA(351.9,IBIFN,2,LASTONE,0)),U,1)
 . I LASTONE=1,LASTTXT=NOCOMMSG D DCOM^IBCIUT4(IBIFN)
 . ;
 . ; esg - 7/16/01
 . ; add an audit text line in the comment text field.
 . ; this audit text line should be in the comments field before
 . ; the user gets the chance to add/edit comment text.
 . ;
 . S WHO=$P($G(^VA(200,DUZ,0)),U,1)
 . S WHEN=$$FMTE^XLFDT($$NOW^XLFDT,5)
 . S AUDITMSG="*---"_WHO_"---"_$P(WHEN,"@",1)_"---"_$P(WHEN,"@",2)_"---*"
 . S DIE="^IBA(351.9,",DA=IBIFN,DR="2.01///+"_AUDITMSG
 . D ^DIE
 . ;
 . ; Save off the before version of the comments so we can compare
 . ; later on.
 . KILL ^TMP($J,"IBCICOMMENTS")
 . M ^TMP($J,"IBCICOMMENTS")=^IBA(351.9,IBIFN,2)
 . ;
 . ; set up the variables for editing the comments field
 . S DIE="^IBA(351.9,",DA=IBIFN,DR=2.01
 . D ^DIE
 . ;
 . ; Compare the new comments with the old comments and set variable
 . ; COMMCHG appropriately.  COMMCHG=1 if the comments were modified in
 . ; any way.  COMMCHG=0 if there were no changes to the comments.
 . ;
 . S PREVCHG=0     ; flag indicating if old comment text was changed
 . S COMMCHG=0
 . S NEWCOMCT=$P($G(^IBA(351.9,IBIFN,2,0)),U,4)      ; new comment count
 . S OLDCOMCT=$P($G(^TMP($J,"IBCICOMMENTS",0)),U,4)  ; old comment count
 . I NEWCOMCT'=OLDCOMCT S COMMCHG=1
 . E  F CMT=1:1:NEWCOMCT I $G(^IBA(351.9,IBIFN,2,CMT,0))'=$G(^TMP($J,"IBCICOMMENTS",CMT,0)) S COMMCHG=1 Q
 . ;
 . ; If the user made no changes at all to the comment text, then
 . ; append the "no comments entered" message to the text and then quit.
 . I 'COMMCHG D  Q
 .. S DIE="^IBA(351.9,",DA=IBIFN,DR="2.01///+"_NOCOMMSG
 .. D ^DIE
 .. Q
 . ;
 . ; At this point, we know the user made some changes to the comment
 . ; text.  Variable PREVCHG is calculated to see if the user
 . ; modified previously existing lines of comment text.  This is
 . ; not allowed and the user will be forced to re-enter their
 . ; comment text if they do this.
 . ;
 . I NEWCOMCT<OLDCOMCT S PREVCHG=1
 . E  F CMT=1:1:OLDCOMCT I $G(^IBA(351.9,IBIFN,2,CMT,0))'=$G(^TMP($J,"IBCICOMMENTS",CMT,0)) S PREVCHG=1 Q
 . ;
 . ; If the user didn't change old comment text, then we're OK
 . I 'PREVCHG Q
 . ;
 . ; Here, we know the user did a bad thing.  We need to display
 . ; an error message to the user and restore the old comments.
 . W !!?8,"You are not allowed to modify previously entered comments."
 . W !?8,"Any comments that you may have just entered have been discarded."
 . W !!?8,"Please remember to start adding your comments on the line"
 . W !?8,"following the audit stamp which contains your name and the"
 . W !?8,"current date and time."
 . W !!
 . S DIR("A")="Press RETURN to continue",DIR(0)="E" D ^DIR K DIR
 . ;
 . ; Remove the last line of the original version of the comments.
 . ; This should be the audit message.  A new one will get created
 . ; upon re-edit.
 . KILL ^TMP($J,"IBCICOMMENTS",OLDCOMCT,0)
 . S CMT=OLDCOMCT-1
 . S $P(^TMP($J,"IBCICOMMENTS",0),U,3,4)=CMT_U_CMT
 . ;
 . ; Restore the original comments
 . D DCOM^IBCIUT4(IBIFN)
 . M ^IBA(351.9,IBIFN,2)=^TMP($J,"IBCICOMMENTS")
 . Q
 ;
 ; remove the scratch global
 KILL ^TMP($J,"IBCICOMMENTS")
 ;
 ; store the user/date/time stamp information in all cases
 S NOW=$$NOW^XLFDT
 S CMNT(351.9,IBIFN_",",.13)=NOW       ; comment date/time
 S CMNT(351.9,IBIFN_",",.14)=DUZ       ; comment user
 S CMNT(351.9,IBIFN_",",.08)=NOW       ; last edited date/time
 S CMNT(351.9,IBIFN_",",.09)=DUZ       ; last edited user
 D FILE^DIE("I","CMNT")
 ;
 ; Enter some comment data if the user failed to do so
 ; This would only apply if the user manually deleted all lines of
 ; comment text.  We want to put something in there.  This will
 ; probably never happen.
 I '$P($G(^IBA(351.9,IBIFN,2,0)),U,4) D
 . S DIE="^IBA(351.9,",DA=IBIFN,DR="2.01///"_NOCOMMSG
 . D ^DIE
 . Q
 ;
 ; Get the assigned to person after entering Exit comments
 ; or when using the stand-alone option to assign a bill
 I TYPE=1!(TYPE=5) D EDATP^IBCIUT1(IBIFN,COMMCHG)
 ;
COMMX ;
 Q
 ;
