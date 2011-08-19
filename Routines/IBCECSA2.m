IBCECSA2 ;ALB/CXW - IB CLAIMS STATUS AWAITING RESOLUTION SCREEN ;28-JUL-1999
 ;;2.0;INTEGRATED BILLING;**137,181,197,320**;21-MAR-1994
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- claims status awaiting resolution detail
 D EN^VALM("IBCEM CSA MSG")
 Q
 ;
HDR ; -- header code
 ; IBA - EOB ien from summary selection
 N IBST,IBST0
 Q:'$G(IBA)
 S IBST0=$G(^IBM(361,+$P(IBA,U,2),0)),IBST=$P(IBST0,U,9)
 S VALMHDR(2)="Message Status = "_$$EXPAND^IBTRE(361,.09,IBST)
 I $P(IBST0,U,14) S VALMHDR(2)=VALMHDR(2)_"  (AUTOMATICALLY REVIEWED)"
 S VALMHDR(1)=$J("",23)_"CLAIMS STATUS AWAITING RESOLUTION-DETAIL"
 Q
 ;
INIT ; -- init variables and list array
 N I,X,Y,Z,ZZ,IBZ,IBZ0,IBX,IBCNT
 K ^TMP("IBCECSC",$J)
SCR S VALMCNT=0,IBCNT=1
 S IBA=+$O(IBDAX(0)),IBA=$G(IBDAX(IBA))
 Q:IBA=""
 S X=""
 S IBX=$S($D(^TMP("IBCECSB",$J)):$G(^TMP("IBCECSB",$J,$P(IBA,U,3),$P(IBA,U,4),$P(IBA,U,6),$P(IBA,U,2))),1:"")
 D SETL1^IBCECSA1(IBX,.X)
 D SET(X,IBCNT)
 D SET("",IBCNT)    ; blank line
 ;
 S X=$E("     Svc Loc: "_$P(IBX,U,7)_$J("",30),1,30)_$J("",14)_"Division: "_$E($P(IBX,U,8),1,26)
 D SET(X,IBCNT)
 S X=$E(" Biller Name: "_$P($P(IBX,U,9),"~")_$J("",30),1,30)_$J("",10)_"Days Pending: "_$P(IBX,U,11)
 D SET(X,IBCNT)
 S IBZ=$P(IBA,U,2),IBZ0=$G(^IBM(361,IBZ,0))
 S X=$E("  Date Rec'd: "_$$FMTE^XLFDT($P(IBZ0,U,2),"2Z")_$J("",30),1,30)_$J("",10)_"Dt Generated: "_$S($P(IBZ0,U,12):$$FMTE^XLFDT($P(IBZ0,U,12),"2Z"),1:"")
 D SET(X,IBCNT),SET("",IBCNT)
 ;
 D SET("Message Text:",IBCNT)
 S X=0 F  S X=$O(^IBM(361,IBZ,1,X)) Q:'X  D
 . S Y="  "_$G(^IBM(361,IBZ,1,X,0))
 . D SET(Y,IBCNT)
 . Q
 D SET("",IBCNT)
 ;
 S ZZ="" F  S ZZ=$O(^IBM(361,IBZ,2,"B",ZZ),-1) Q:ZZ=""  S Z=0 F  S Z=$O(^IBM(361,IBZ,2,"B",ZZ,Z)) Q:'Z  D
 . S I=$G(^IBM(361,IBZ,2,Z,0))
 . S Y=$$SETSTR^VALM1("Review Date: "_$$EXTERNAL^DILFD(361.02,.01,,ZZ),"",2,40)
 . D SET(Y,IBCNT)
 . I $P(I,U,2) S Y=$$SETSTR^VALM1("Reviewed By: "_$P($G(^VA(200,+$P(I,U,2),0)),U,1),"",2,70) D SET(Y,IBCNT)
 . D SET("    Comments:",IBCNT)
 . S X=0 F  S X=$O(^IBM(361,IBZ,2,Z,1,X)) Q:'X  D
 .. S Y="    "_$G(^IBM(361,IBZ,2,Z,1,X,0))
 .. D SET(Y,IBCNT)
 .. Q
 . D SET("",IBCNT)
 . Q
INITQ Q
 ;
HELP ; help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; exit code
 K ^TMP("IBCECSC",$J)
 D CLEAN^VALM10
 Q
 ;
SET(X,CNT) ;
 S VALMCNT=VALMCNT+1
 S ^TMP("IBCECSC",$J,VALMCNT,0)=X
 S ^TMP("IBCECSC",$J,"IDX",VALMCNT,CNT)=""
 S ^TMP("IBCECSC",$J,CNT)=VALMCNT
 Q
 ;
UPDTX(IBDA,IBST) ; Update transmit bill record
 ; IBDA = ien of entry in 364
 ; IBST = status to stuff
 N X,Y,DR,DIE,DA
 S DR=".03////"_IBST_";.04///NOW",DA=IBDA,DIE="^IBA(364," D:DA ^DIE
 Q
 ;
STATUS ; Edit rev stat
 ;IBA - EOB ien
 N DA,DIE,DR,IBOLD,DIC,DO,DD,DLAYGO,IBDA,IBFINAL,IBO,IBNEW,IBFACT
 D FULL^VALM1
 S DIE="^IBM(361,"
 S (IBDA,DA)=$P(IBA,U,2)
 G:'DA STATUSQ
 S IBOLD=$P($G(^IBM(361,DA,0)),U,9),IBFINAL=0,IBO=$S(IBOLD'="":"/"_IBOLD,1:"@")
 S DR="@1;.09;I +X<2 S IBFINAL=0,Y=""@99"";S IBFINAL=1;.1;I X="""" W !,""For a final status, this field is required"" S Y=""@98"";S Y=""@99"";@98;.09///"_IBO_";S Y=""@1"";@99"
 L +^IBM(361,IBDA):3 I '$T D  G STATUSQ
 . W !,"Sorry, another user currently editing this entry (#"_IBDA_")."
 D ^DIE
 ;
 I $G(IBFINAL) D  ;Final status selected - enter remarks
 . N Z
 . S Z=IBDA
 . N IBDA,Q,DIE,DR,DA,X,Y
 . S IBDA(1)=Z,IBDA=""
 . D ADDCOM(.IBDA,.DUZ,.IBCOM)
 . I $P($G(^IBM(361,IBDA(1),0)),U,10)="O",'$O(^IBM(361,IBDA(1),2,+IBDA,0)) D   ; Require remarks for 'OTHER ACTION' final status
 .. W !,"Since OTHER ACTION final status was selected, you must enter a",!,"   comment explaining the OTHER ACTION" D ADDCOM(.IBDA,.DUZ,.IBCOM,1)
 .. I IBDA D
 ... ; Delete entry without a comment
 ... D KILLREV(.IBDA)
 .. I '$O(^IBM(361,IBDA(1),2,+IBDA,0)) S DIE="^IBM(361,",DA=IBDA(1),DR=".20///@;.09///"_IBO D ^DIE W !,"The review status was not changed because no comment was entered",! Q
 S IBNEW=$P($G(^IBM(361,DA,0)),U,9)
 ;if time out-no change in review status
 S IBFACT=$P($G(^IBM(361,DA,0)),U,10)
 I $G(IBFINAL),IBFACT="",IBNEW>1 D  G STATUSQ
 . W !,"The review status was not changed because no final status was selected"
 . S DR=".09////"_IBOLD,DIE="^IBM(361," D ^DIE
 I IBNEW>1,$P(^IBM(361,DA,0),U,11) D
 . I "CR"'[IBFACT D
 .. W !,"NO FURTHER ACTION WILL BE ALLOWED REGARDING THIS ELECTRONIC MESSAGE"
 .. I $$PRINTUPD^IBCEU0("",$P(^IBM(361,DA,0),U,11)) D  Q
 ... W !," SINCE THIS CLAIM WAS PRINTED AT THE CLEARINGHOUSE"
 ... S IBFACT="N"
 .. S DIR(0)="YA",DIR("A")="IS THIS THE FINAL ELECTRONIC MESSAGE YOU EXPECT TO RECEIVE FOR THIS BILL?: ",DIR("B")="NO"
 .. S DIR("?",1)="If you respond YES to this prompt, the transmit status of this bill will",DIR("?",2)="  be set to CLOSED.  No further electronic processing of this bill will be"
 ..S DIR("?",3)="  allowed.  If you respond NO to this prompt, this electronic message will",DIR("?",4)="  be filed as reviewed, but the bill's transmit status will not be changed."
 .. S DIR("?",5)="  You may wish to periodically print a list of bills with a non-final",DIR("?",6)="  (closed/cancelled/etc) status to ensure the electronic processing of all"
 .. S DIR("?",7)="  bills has been completed.  Closing the transmit bill record here will",DIR("?")="  eliminate the bill from this list."
 .. W ! D ^DIR K DIR W !
 .. Q:Y'=1
 .. S DIR("A",1)="SINCE YOU HAVE INDICATED THIS BILL HAS RECEIVED ITS FINAL ELECTRONIC MESSAGE",DIR("A",2)="  AND NO FURTHER ACTION WILL BE TAKEN ON IT, THE STATUS OF THE TRANSMIT",DIR("A",3)="  RECORD FOR THIS BILL WILL BE CHANGED TO CLOSED"
 .. S DIR("A")="IS THIS WHAT YOU MEANT TO DO?: ",DIR("B")="YES",DIR(0)="YA" W ! D ^DIR W ! K DIR
 .. Q:Y'=1
 .. S IBFACT="N"
 . I "NCR"[IBFACT D UPDEDI^IBCEM(+$P(^IBM(361,DA,0),U,11),IBFACT) Q
 S $P(IBX,U,12)=$S(IBNEW=1:"*",1:"")
 I IBOLD'=IBNEW D  ;Note the change and who made it
 . D NOTECHG(IBDA,0),HDR,INIT
 L -^IBM(361,DA)
 S VALMBCK="R"
 Q
 ;
NOTECHG(IBDA,IBAUTO,IBNTEXT,IBUSER) ; Enter who/when review stat change was entered
 ; IBDA = ien of entry in file 361
 ; IBAUTO = flag to say auto-review was used (1=used, 0=not used)
 ; IBNTEXT = array containing the lines of text to store if not using the
 ;           default text  IBNTEXT = # of lines
 ; IBUSER = flag which says to also stuff the .02 reviewed by field
 N IBIEN,IBTEXT,DA,X,Y,DIC,DO,DLAYGO,DD
 S DA(1)=IBDA,DIC="^IBM(361,"_DA(1)_",2,",DIC(0)="L",DLAYGO=361.02
 S X=$$NOW^XLFDT
 I $G(IBUSER),$G(DUZ) S DIC("DR")=".02////"_$G(DUZ)
 D FILE^DICN K DIC,DD,DO,DLAYGO
 Q:Y'>0
 S DA(2)=DA(1),DA(1)=+Y,IBIEN=DA(1)_","_DA(2)_","
 I $G(IBNTEXT) D
 . M IBTEXT=IBNTEXT
 E  D
 . S IBTEXT(1)="REVIEW STATUS "_$S($G(IBAUTO):"AUTOMATICALLY ",1:"")_"CHANGED TO '"_$$EXTERNAL^DILFD(361,.09,,$P(^IBM(361,DA(2),0),U,9))_"'  BY: "_$$EXTERNAL^DILFD(361.02,.02,,+$G(DUZ))
 D WP^DIE(361.02,IBIEN,.03,,"IBTEXT") K ^TMP("DIERR",$J)
 Q
 ;
STATUSQ ;
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
COM ; Enter/Edit Review Comments
 ; IBA - EOB ien
 N DA,DIC,X,Y,DO,DD,DLAYGO,IBDA,IB0,IBNEW,IBCOM
 D FULL^VALM1
 W !
 S (IBDA(1),DA(1))=+$P(IBA,U,2)
 L +^IBM(361,IBDA(1)):3 I '$T D  G COMQ
 . W !,*7,"Sorry, another user currently editing this entry."
 . D PAUSE^VALM1
 ;
 S Z=0 F  S Z=$O(^IBM(361,IBDA(1),2,Z)) Q:'Z  I $P($G(^(Z,0)),U,2)=DUZ S IBCOM(DUZ,Z)=""
 S IBNEW=0
 I '$D(IBCOM(DUZ)) D
 . N DO,DD,DIC,DLAYGO,DIR,X,Y
 . S DIR(0)="YA",DIR("B")="YES",DIR("A",1)="There are no comments previously entered by you",DIR("A")="Do you want to add a new comment?: "
 . S DIR("?",1)="You are only allowed to edit your own comments."
 . S DIR("?")="You may enter a new comment here."
 . D ^DIR K DIR
 . W !
 . I Y'=1 S IBDA=-1 Q
 . D ADDCOM(.IBDA,.DUZ,.IBCOM)
 ;
 E  D
 . S DIC="^IBM(361,"_IBDA(1)_",2,",DIC("S")="I $P(^(0),U,2)=DUZ",DIC(0)="AEMQ",DIC("A")="Select REVIEW DATE to edit or press ENTER to add a new comment: " D ^DIC K DIC S IBDA=+Y
 . I IBDA>0 D  Q  ;User selected an existing entry
 .. D ADDCOM(.IBDA,.DUZ,.IBCOM,1)
 .. I $D(^IBM(361,IBDA(1),2,IBDA)),'$O(^IBM(361,IBDA(1),2,IBDA,1,0)) D KILLREV(.IBDA)
 . S DIR(0)="YAO",DIR("A")="DO YOU WANT TO ADD A NEW REVIEW COMMENT?: ",DIR("B")="NO" D ^DIR K DIR Q:Y'=1
 . D ADDCOM(.IBDA,.DUZ,.IBCOM)
 L -^IBM(361,IBDA(1))
 G:IBDA'>0 COMQ
 D PAUSE^VALM1
 D HDR,INIT
COMQ S VALMBCK="R"
 Q
 ;
ADDCOM(IBDA,DUZ,IBCOM,ADD) ; Add review comment to file 361
 ; IBDA = array containing the DA references for the file add -
 ;        pass by reference
 ; DUZ = ien of the user
 ; ADD = flag when set to 1 says the review date exists,
 ;       just allow comment entry
 ; Returns IBDA = the entry # of the comment
 ;          and IBCOM array referencing any comments added by the user
 ;
 N DA,DIC,DD,DO,DLAYGO,X,Y
 S DR=$S($G(DUZ):".02////"_DUZ_";",1:"")_".03"
 I '$G(ADD) D
 . K DO,DD
 . S DIC="^IBM(361,"_IBDA(1)_",2,",DA(1)=IBDA(1),X=$$NOW^XLFDT
 . W !,"New Review Date: "_$$FMTE^XLFDT(X,"2Z")
 . S DIC("DR")=DR,DLAYGO=361.02
 . S DIC(0)="L",DIC("P")=$$GETSPEC^IBEFUNC(361,2)
 . D FILE^DICN K DIC,DD,DO,DLAYGO
 . S IBDA=+Y
 I IBDA>0 D
 . I $G(ADD) S DIE="^IBM(361,"_IBDA(1)_",2,",DA(1)=IBDA(1),DA=IBDA D ^DIE
 . I '$O(^IBM(361,IBDA(1),2,IBDA,0)) D KILLREV(.IBDA) Q
 . S IBCOM(DUZ,IBDA)=""
 Q
 ;
KILLREV(IBDA) ; Deletes a review date if no comments entered
 N DA,DIK
 S DA=IBDA,DA(1)=IBDA(1),DIK="^IBM(361,"_IBDA(1)_",2,"
 K IBCOM(DUZ,IBDA)
 D ^DIK
 Q
 ;
