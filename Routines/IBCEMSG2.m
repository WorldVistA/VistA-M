IBCEMSG2 ;ALB/JEH - EDI PURGE STATUS MESSAGES CONT. ;04-MAY-01
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BLD ; -- build list
 K ^TMP("IBCEMSGB",$J)
 N IBI,IB0,IBREC,IBCNT
 S (IBCNT,VALMCNT)=0
 I '$D(^TMP("IBCEMSGA",$J)) D
 . S (IBCNT,VALMCNT)=2
 . S ^TMP("IBCEMSGB",$J,1,0)=""
 . S ^TMP("IBCEMSGB",$J,2,0)="No status messages matching selection criteria were found"
 S IBI=0 F  S IBI=$O(^TMP("IBCEMSGA",$J,IBI)) Q:'IBI  S IBREC=^(IBI) D
 . S IBCNT=IBCNT+1,X=""
 . S X=$$SETFLD^VALM1(IBCNT,"","NUMBER")
 . S X=$$SETFLD^VALM1($P(IBREC,U),X,"BILL")
 . S X=$$SETFLD^VALM1($P(IBREC,U,2),X,"SEV")
 . S X=$$SETFLD^VALM1($P(IBREC,U,3),X,"FNR")
 . S X=$$SETFLD^VALM1($P(IBREC,U,4),X,"FRD")
 . S X=$$SETFLD^VALM1($P(IBREC,U,5),X,"AUTO")
 . D SET(X)
 . I $P(IBREC,U,6)'="" S X=$$SETSTR^VALM1($P(IBREC,U,6),"",5,200) D SET(X)
 Q
 ;
SET(X) ; -- list manager screen
 S VALMCNT=VALMCNT+1
 S ^TMP("IBCEMSGB",$J,VALMCNT,0)=X
 S ^TMP("IBCEMSGB",$J,"IDX",VALMCNT,IBCNT)=""
 S ^TMP("IBCEMSGB",$J,IBCNT)=VALMCNT_U_IBI
 Q
 ;
DEL ; -- entry point to delete status message
 N IBDA,DA,DIK,IBCNT
 D SEL(.IBDA)
 G:'$O(IBDA(0)) DELQ
 S (DA,IBCNT)=0,DIK="^IBM(361," F  S IBDA=$O(IBDA(IBDA)) Q:'IBDA  S DA=IBDA(IBDA) D ^DIK K ^TMP("IBCEMSGA",$J,DA) S IBCNT=IBCNT+1
 W !!,IBCNT_$S(IBCNT>1:" Messages",1:" Message")_" deleted"
 D PAUSE^VALM1,BLD
 K ^TMP("IBDA",$J)
DELQ S VALMBCK="R"
 Q
 ;
VPRT ; -- entry point to view/print status messages
 D SEL(.IBDA)
 G:'$O(IBDA(0)) PRTQ
 S DIC="^IBM(361,",L=0,DHD="Status Messages Selected for Deletion",FLDS="[CAPTION]",DIOBEG="I $E(IOST,1,2)=""C-"" W @IOF",BY(0)="^TMP(""IBDA"",$J,",L(0)=1 D EN1^DIP
 D PAUSE^VALM1
 K ^TMP("IBDA",$J)
PRTQ S VALMBCK="R"
 Q
 ;
SEL(IBDA) ; -- select entry from list
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)),$S('$G(ONE):"",1:"S"))
 S IBDA=0 F  S IBDA=$O(VALMY(IBDA)) Q:'IBDA  S IBDA(IBDA)=$P($G(^TMP("IBCEMSGB",$J,IBDA)),U,2) I IBDA(IBDA) S ^TMP("IBDA",$J,IBDA(IBDA))=""
 Q
 ;
