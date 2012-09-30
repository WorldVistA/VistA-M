PRCAMDA3 ;ALB/TAZ - PRCA MDA MANAGEMENT WORKLIST SCREEN ;26-APR-2011
 ;;4.5;Accounts Receivable;**275**;Mar 20, 1995;Build 72
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;;DBIA #5713 
 ;
EN ; -- main entry point for PRCA MDA COMMENTS
 N VALMAR
 D EN^VALM("PRCA MDA COMMENTS")
 Q
 ;
HDR ; -- header code
 N PRCACL
 S PRCACL=$P(^PRCA(436.1,PRCAIEN,0),U,1)
 I PRCAFN S PRCACL=$P(^PRCA(430,PRCAFN,0),U,1)
 S VALMHDR(1)="Claim Comment History"
 S VALMHDR(2)="MDA Claim "_PRCACL
 Q
 ;
INIT ; -- init variables and list array
 N PRCACNT
 K ^TMP("PRCAMDAC",$J),@VALMAR
 S PRCAFN=$P(^PRCA(436.1,PRCAIEN,1),U,1)
 ;Remove the I $T(^IBJUT6)'="" in the following line after IB*2.0*452 is released since 
 ; IBJTU6 is part of that patch and may be released after the release of PRCA*4.5*275
 I $T(^IBJTU6)'="" I PRCAFN D IBDSP^IBJTU6(3,PRCAFN,,,VALMAR) G INITQ ;#DBIA #5713
 S PRCACNT=0 D MCOM2^PRCAMDA2(PRCAIEN,.PRCACNT)
INITQ ;
 I '$D(@VALMAR) D SET^VALM10(1,""),SET^VALM10(2,"No Comment Transactions Exist For This Account.")
 S VALMBCK="R"
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("PRCAMDC",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
CMNT ; Enter MDA Comments.  This is called from the PRCA MDA ENTER COMMENT protocol.
 N DA,DD,DIC,DIK,DLAYGO,X,Y
 W !
 ; make sure this entry is not locked already
 L +^PRCA(436.1,PRCAFN):3 I '$T W !,*7,"Sorry, another user currently editing this entry." D PAUSE^VALM1 G CMNTQ
 S DA(1)=PRCAIEN
 K DO S DIC="^PRCA(436.1,"_DA(1)_",2,",DIC(0)="L",DIC("DR")="2;.03",X=$$NOW^XLFDT,DLAYGO=436.12
 D FILE^DICN
 S DA=+Y I DA>0 D
 . ;Make sure a comment or followup date was created.  Otherwise delete the entry.
 . I '$D(^PRCA(436.1,DA(1),2,DA,1)),$P($G(^PRCA(436.1,DA(1),2,DA,0)),U,3)=""  S DIK=DIC D ^DIK Q
 . ;There is a comment or follow up date so ask status prompt
 . K DIC
 . D STATUS1^PRCAMDA2
 L -^PRCA(436.1,PRCAFN)
CMNTQ ;
 S VALMBCK="R"
 D INIT
 Q
 ;
