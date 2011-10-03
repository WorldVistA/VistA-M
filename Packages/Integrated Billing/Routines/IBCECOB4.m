IBCECOB4 ;ALB/CXW - IB EM MANAGEMENT - REVIEW STATUS SCREEN ;16-MAY-2000
 ;;2.0;INTEGRATED BILLING;**137,181,348,349**;21-MAR-1994;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; -- main entry point for claims status awaiting resolution detail
 S VALMCNT=0,VALMBG=1
 D EN^VALM("IBCEM EOB REVIEW")
 Q
 ;
HDR ; -- header code
 ;IBDA - ien EOB selection screen
 N IBST
 S IBST=$P($G(^IBM(361.1,IBDA,0)),U,16)
 S VALMHDR(2)="Review Status= "_$S(IBST=1:"REVIEW IN PROCESS",IBST=2:"ACCEPTED-INTERIM EOB",IBST=3:"ACCEPTED-COMPLETE EOB",IBST=4:"REJECTED",IBST=9:"CLAIM CANCELLED",1:"NOT REVIEWED")
 Q
 ;
INIT ; -- init variables and list array
 N I,X,Y,Z,IBZ,IBFST,IBPAT
 K ^TMP("IBCECOC",$J)
SCR S VALMCNT=0
 ; IBCMT = the data extracted into ^TMP("IBCECOB1",$J)
 ; IBIFN = the ien of the bill
 ; IBDA = the ien of the entry in 361.1
 S Z=$G(^DPT(+$P($G(^DGCR(399,IBIFN,0)),U,2),0))
 S IBPAT=$E($P(Z,U),1,25)_"/"_$E($P(Z,U,9),6,9)
 S X=""
 S X=$$SETFLD^VALM1($$BN1^PRCAFN(IBIFN),X,"BILL")
 S X=$$SETFLD^VALM1($$DAT1^IBOUTL($P(IBCMT,U)),X,"SERVICE")
 S X=$$SETFLD^VALM1(IBPAT,X,"PATNM")
 S X=$$SETFLD^VALM1("  "_$P("PRI^SEC^TER",U,+$P(IBCMT,U,16)),X,"SEQ")
 S X=$$SETFLD^VALM1("  "_$$TYPE^IBJTLA1($P(IBCMT,U,5))_"/"_$S(+$P(IBCMT,U,6)=2:"CMS-1500",1:"UB-04"),X,"BTYPE")
 D SET(X)
 S Z=0 F  S Z=$O(^IBM(361.1,IBDA,21,Z)) Q:'Z  S I=$G(^(Z,0)) D
 . S X=$$SETSTR^VALM1("Review Date/Time: "_$$EXPAND^IBTRE(361.121,.01,+I),"",2,40)
 . D SET(X)
 . I $P($G(^VA(200,+$P(I,U,2),0)),U)'="" S X=$$SETSTR^VALM1("Reviewed By: "_$P($G(^VA(200,+$P(I,U,2),0)),U),"",2,50) D SET(X)
 . S (IBFST,Y)=0 F  S Y=$O(^IBM(361.1,IBDA,21,Z,1,Y)) Q:'Y  D
 .. S X=$$SETSTR^VALM1($S('IBFST:"Comments: ",1:"")_$G(^IBM(361.1,IBDA,21,Z,1,Y,0)),"",2,$S('IBFST:140,1:150))
 .. D SET(X)
 .. S IBFST=1
 . D SET("")
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCECOC",$J)
 D CLEAN^VALM10
 Q
 ;
SET(X) ;
 S VALMCNT=VALMCNT+1
 S ^TMP("IBCECOC",$J,VALMCNT,0)=X
 S ^TMP("IBCECOC",$J,"IDX",VALMCNT,1)=""
 S ^TMP("IBCECOC",$J,1)=VALMCNT
 Q
 ;
STATUS ; Edit review status
 ;IBDA - EOB ien
 N DA,DIE,DR,IBOLD,DIC,DO,DD,DLAYGO,IBFINAL,IBO,IBNEW,IBFACT
 D FULL^VALM1
 S DIE="^IBM(361.1,"
 S DA=IBDA
 G:'DA STATUSQ
 S IBOLD=$P($G(^IBM(361.1,DA,0)),U,16),IBFINAL=0,IBO=$S(IBOLD'="":"/"_IBOLD,1:"@")
 S DR="@1;.16;I +X<3 S IBFINAL=0,Y=""@99"";S IBFINAL=1;.2;I X="""" W !,""For a final status, this field is required"" S Y=""@98"";S Y=""@99"";@98;.16///"_IBO_";S Y=""@1"";@99"
 L +^IBM(361.1,IBDA):3 I '$T D  G STATUSQ
 . W !,"Sorry, another user currently editing this entry (#"_IBDA_")."
 D ^DIE
 ;
 I $G(IBFINAL) D  ;Final status selected - let remarks be entered
 . N Z
 . S Z=IBDA
 . N IBDA,Q,DIE,DR,DA,X,Y
 . S IBDA(1)=Z,IBDA=""
 . D ADDCOM(.IBDA,.DUZ,.IBCOM)
 . I $P($G(^IBM(361.1,IBDA(1),0)),U,20)="F",'$O(^IBM(361.1,IBDA(1),21,+IBDA,0)) D   ; Require remarks for 'OTHER ACTION' final status
 .. W !,"Since FILED - NO ACTION final status was selected, you must enter a",!,"   comment explaining the FILED - NO ACTION" D ADDCOM(.IBDA,.DUZ,.IBCOM,1)
 .. I IBDA D
 ... ; Delete entry if just entered without a comment
 ... D KILLREV(.IBDA)
 .. I '$O(^IBM(361.1,IBDA(1),21,+IBDA,0)) S DIE="^IBM(361.1,",DA=IBDA(1),DR=".20///@;.16///"_IBO D ^DIE W !,"The review status was not changed because no comment was entered",! Q
 S IBNEW=$P($G(^IBM(361.1,DA,0)),U,16)
 ;if time out-no change in review status
 S IBFACT=$P($G(^IBM(361.1,DA,0)),U,20)
 I $G(IBFINAL),IBFACT="",IBNEW>1 D  G STATUSQ
 . W !,"The review status was not changed because no final status was selected"
 . S DR=".16////"_IBOLD,DIE="^IBM(361.1," D ^DIE
 I IBNEW>1,$P(^IBM(361.1,DA,0),U,19) D
 . I "CR"'[IBFACT D
 .. N DIR,X,Y
 .. S DIR("?",1)="IF THIS BILL HAS RECEIVED ITS FINAL ELECTRONIC MESSAGE AND NO FURTHER ACTION",DIR("?",2)="WILL BE TAKEN ON IT, ANSWER YES"
 .. S DIR("A")="DO YOU WANT TO CLOSE THE TRANSMISSION RECORD FOR THIS CLAIM?: ",DIR("B")="NO",DIR(0)="YA" D ^DIR
 .. I Y>0 S IBFACT="N"
 . I "NCR"[IBFACT D UPDEDI^IBCEM(+$P(^IBM(361.1,DA,0),U,19),IBFACT) Q
 I IBOLD'=IBNEW D  ;Note the change and who made it
 . N IBIEN,IBTEXT,DA
 . S DA(1)=IBDA,DIC="^IBM(361.1,"_DA(1)_",21,",DIC(0)="L",DLAYGO=361.121
 . S X=$$NOW^XLFDT
 . S DIC("P")=$$GETSPEC^IBEFUNC(361.1,21)
 . D FILE^DICN K DIC,DD,DO,DLAYGO
 . Q:Y'>0
 . S DA(2)=DA(1),DA(1)=+Y,IBIEN=DA(1)_","_DA(2)_",",IBTEXT(1)="REVIEW STATUS CHANGED TO '"_$$EXPAND^IBTRE(361.1,.16,$P(^IBM(361.1,DA(2),0),U,16))_"'  BY: "_$$EXPAND^IBTRE(361.121,.02,+$G(DUZ))
 . D WP^DIE(361.121,IBIEN,1,,"IBTEXT") K ^TMP("DIERR",$J)
 . D HDR,INIT
 L -^IBM(361.1,DA)
STATUSQ ;
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
ADDCOM(IBDA,DUZ,IBCOM,ADD) ; Add review comment to file 361.1
 ; IBDA = array containing the DA references for the file add -
 ;        pass by reference
 ; DUZ = ien of the user
 ; ADD = flag when set to 1 says the review date exists,
 ;       just allow comment entry
 ; Returns IBDA = the entry # of the comment
 ;          and IBCOM array referencing any comments added by the user
 ;
 N DA,DIC,DD,DO,DLAYGO,X,Y
 S DR=$S($G(DUZ):".02////"_DUZ_";",1:"")_"1"
 I '$G(ADD) D
 . K DO,DD
 . S DIC="^IBM(361.1,"_IBDA(1)_",21,",DA(1)=IBDA(1),X=$$NOW^XLFDT
 . W !,"New Review Date: "_$$FMTE^XLFDT(X,2)
 . S DIC("DR")=DR,DLAYGO=361.121
 . S DIC(0)="L",DIC("P")=$$GETSPEC^IBEFUNC(361.1,21)
 . D FILE^DICN K DIC,DD,DO,DLAYGO
 . S IBDA=+Y
 I IBDA>0 D
 . I $G(ADD) S DIE="^IBM(361.1,"_IBDA(1)_",21,",DA(1)=IBDA(1),DA=IBDA D ^DIE
 . I '$O(^IBM(361.1,IBDA(1),21,IBDA,0)) D KILLREV(.IBDA) Q
 . S IBCOM(DUZ,IBDA)=""
 Q
 ;
KILLREV(IBDA) ; Deletes a review date if no comments entered
 N DA,DIK
 S DA=IBDA,DA(1)=IBDA(1),DIK="^IBM(361.1,"_IBDA(1)_",21,"
 K IBCOM(DUZ,IBDA)
 D ^DIK
 Q
 ;
