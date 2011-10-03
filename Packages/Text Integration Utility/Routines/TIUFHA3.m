TIUFHA3 ; SLC/MAM - LM Templates H, A Action Edit Status, INACTIVE(TYPE,FILEDA,NODE0), WARNING, WARNOBJI(FILEDA) ; 03/16/2007
 ;;1.0;TEXT INTEGRATION UTILITIES;**13,64,211,225**;Jun 20, 1997;Build 13
 ;
EDSTAT ; Action Edit Status for Templates H, A, J, C
 N STATUS,TIUFXNOD,TIUFFULL
 N DTOUT,DIRUT,DIROUT
 S VALMBCK="",TIUFXNOD=$G(XQORNOD(0))
 S STATUS=$$SELSTAT^TIUFLF5,STATUS=$P(STATUS,U,2) I $D(DTOUT)!(STATUS="") G EDSTX
 I "AJ"[TIUFTMPL D TMPLA(STATUS) G EDSTX
 ;               Template H, C
 I STATUS'="ACTIVE" D ONE(STATUS) G EDSTX
 D MANY(STATUS)
EDSTX I $D(DTOUT) S VALMBCK="Q" Q
 I $G(TIUFFULL) S VALMBCK="R" D RESET^TIUFXHLX
 Q
 ;
MANY(STATUS) ; Select multiple entries for Status ACTIVE for Templates H, C.
 ; Requires STATUS
 N LINENO,INFO,TIUFQUIT
 I $P(TIUFXNOD,U,4)'["=" W !!," Selecting Entries for Status ACTIVE.  You may enter multiple entries",!,"at the same time."
 D EN^VALM2(TIUFXNOD,"O") Q:'$O(VALMY(0))  K DIRUT
 S (LINENO,TIUFQUIT)=0 F  S LINENO=$O(VALMY(LINENO)) Q:'LINENO  S INFO=$G(^TMP("TIUF1IDX",$J,LINENO)) D EDONE(STATUS,INFO,.TIUFQUIT) Q:TIUFQUIT  D LINEUP^TIUFLLM1(INFO,TIUFTMPL) Q:$D(DIRUT)
 Q
 ;
ONE(STATUS) ; Select one entry (in loop) for Status INACTIVE or TEST for Templates H, C.
 N INFO,TIUFQUIT,EXPAND
 I $P(TIUFXNOD,U,4)'["=" W !!," Selecting Entry for Status ",STATUS,".  Please select ONE entry.  You will be",!,"prompted for another." K DIRUT
 F  D EN^VALM2(TIUFXNOD,"SO") Q:'$O(VALMY(0))  S INFO=$G(^TMP("TIUF1IDX",$J,$O(VALMY(0)))) D  Q:TIUFQUIT!$D(DIRUT)
 . I STATUS="TEST" W " ... "
 . S (EXPAND,TIUFQUIT)=0 K DIRUT D EDONE(STATUS,.INFO,.TIUFQUIT,.EXPAND) Q:TIUFQUIT!$D(DIRUT)
 . D LINEUP^TIUFLLM1(INFO,TIUFTMPL)
 . I EXPAND D EXPAND1^TIUFH1(.INFO) S VALMCNT=VALMCNT+$P(INFO,U,3)
 . I VALMBCK="R" S VALMSG=$$VMSG^TIUFL D RE^VALM4
 . S $P(TIUFXNOD,U,4)="ST"
 . W !!,"Selecting Another Entry for Status "_STATUS_":"
 Q
 ;
TMPLA(STATUS) ; Select multiple entries for Status edit for Template A
 ; Requires STATUS
 N LINENO,INFO,TIUFQUIT
 I $P(TIUFXNOD,U,4)'["=" W !!," Selecting Entries for Status ",STATUS,".  You may enter multiple entries",!,"at the same time."
 D EN^VALM2(TIUFXNOD,"O") Q:'$O(VALMY(0))  K DIRUT
 S (LINENO,TIUFQUIT)=0 F  S LINENO=$O(VALMY(LINENO)) Q:'LINENO  S INFO=$G(^TMP("TIUF1IDX",$J,LINENO)) D EDONE(STATUS,INFO,.TIUFQUIT) Q:TIUFQUIT!$D(DIRUT)
 I VALMBCK="R" D INIT^TIUFA
 Q
 ;
EDONE(STATUS,INFO,TIUFQUIT,EXPAND) ; Edit Status for one LM entry.
 ; Requires STATUS,INFO; returns TIUFQUIT, EXPAND.
 N FILEDA,NODE0,TYPE,MSG,STATOK,PFILEDA,LIST
 S (TIUFQUIT,EXPAND)=0 S:STATUS'="ACTIVE" VALMBCK=""
 I 'INFO W !!," Missing List Manager Information; See IRM",! D PAUSE^TIUFXHLX S TIUFQUIT=1 G EDONX
 S FILEDA=+$P(INFO,U,2),NODE0=$G(^TIU(8925.1,FILEDA,0))
 I NODE0="" W !!," Entry "_+INFO_" does not exist in the File; See IRM",! D PAUSE^TIUFXHLX S TIUFQUIT=1 G EDONX
 S TYPE=$P(NODE0,U,4)
 I FILEDA=81!(FILEDA=512) S MSG=" Addendum; Can't edit Status" W !!,MSG,! D PAUSE^TIUFXHLX G EDONX ;P64
 I $P(NODE0,U,13),TYPE'="DOC",TIUFWHO'="N" S MSG=" Entry "_+INFO_" is National; Can't edit Status" W !!,MSG,! D PAUSE^TIUFXHLX G EDONX ;P64 restrict msg to nontitles
 I TYPE="O" W !!,"Entry "_+INFO_" is an Object.  To edit Status please select action Detailed",!,"Display and then select Basics.",! D PAUSE^TIUFXHLX G EDONX
 I "AJ"[TIUFTMPL!(STATUS="ACTIVE") S MSG=" Editing Status for Entry "_+INFO_" ... " W !!,MSG H 1
 I TYPE="CO",$P(NODE0,U,10) S MSG=" Shared Components have no Status; Can't Edit Status" W !,MSG,! D PAUSE^TIUFXHLX G EDONX
 I TYPE="CO" S MSG=" Component Status is determined by Parent; Can't Edit Status" W !,MSG,! D PAUSE^TIUFXHLX G EDONX
 L +^TIU(8925.1,FILEDA):1 I '$T W !!," Another user is editing this entry; please try later.",! D PAUSE^TIUFXHLX G EDONX
 S PFILEDA=+$O(^TIU(8925.1,"AD",FILEDA,0))
 D STATLIST^TIUFLF5(FILEDA,PFILEDA,$E(STATUS),.MSG,.LIST) G:$D(DTOUT) EDONX I LIST'[$E(STATUS) W !,MSG,! D PAUSE^TIUFXHLX G EDONX
 I $$STATWORD^TIUFLF5($P(NODE0,U,7))=STATUS S MSG=" Status already "_STATUS W MSG,! D PAUSE^TIUFXHLX G EDONX
 D INACTIVE(TYPE,FILEDA,NODE0):STATUS="INACTIVE",TEST(FILEDA,NODE0):STATUS="TEST",ACTIVE(FILEDA,NODE0):STATUS="ACTIVE"
 I STATUS="INACTIVE",TYPE="CL"!(TYPE="DC")!(TYPE="DOC") D COLLEXPD(.INFO,0,.EXPAND)
 I STATUS="ACTIVE",TYPE="DOC" D COLLEXPD(.INFO,1)
 I STATUS="TEST" D COLLEXPD(.INFO,0,.EXPAND)
 S VALMSG=$$VMSG^TIUFL
EDONX L -^TIU(8925.1,FILEDA)
 Q
 ;
INACTIVE(TYPE,FILEDA,NODE0) ; Change Status to Inactive.
 ; Requires TYPE, FILEDA, NODE0 
 N CONTINUE
 I TYPE="O" S CONTINUE=$$WARNOBJI(FILEDA) D  G:'CONTINUE INACX
 . I CONTINUE W " Inactivated" H 1 Q
 . W " NOT Inactivated" H 1
 I TYPE="CL"!(TYPE="DC"),$$HASITEMS^TIUFLF1(FILEDA) S CONTINUE=$$WARNING I 'CONTINUE W "  NOT Inactivated" H 1 G INACX
 I TYPE'="O" D
 . I $G(CONTINUE) W !," Entry and descendants Inactivated" H 1 Q
 . I TYPE="DOC" W !," Entry (& any nonShared Components) Inactivated" H 1 Q
 . W " Entry Inactivated" H 1
 D AUTOSTAT^TIUFLF6(FILEDA,NODE0,"INACTIVE") S:$P(TIUFXNOD,U,3)["Status" VALMBCK="R"
INACX Q
 ;
COLLEXPD(INFO,EXPDFLG,EXPAND) ; Collapse entry, reexpand (to items only) if EXPDFLG=1
 ; Requires string INFO. Passes back array INFO.  If 'EXPDFLG, must reexpand later, or reinit the whole screen.
 S EXPAND=$P(INFO,U,3) Q:'EXPAND
 D PARSE^TIUFLLM(.INFO),COLLAPSE^TIUFH1(.INFO)
 I $G(EXPDFLG) D EXPAND1^TIUFH1(.INFO)
 S VALMCNT=$S($G(EXPDFLG):VALMCNT-EXPAND+$P(INFO,U,3),1:VALMCNT-EXPAND)
 Q
 ;
WARNING() ; Function Warns user who asks to Inactivate,  Returns 1 to Inactivate, 0 to not Inactivate.
 N DIR,X,Y
 S DIR(0)="Y",DIR("B")="NO",DIR("A",1)=" This will Inactivate ALL DESCENDANTS (except Shared Components).  Before"
 S DIR("A",2)="Inactivating, please note which Descendants are presently Inactive.  This will"
 S DIR("A",3)="help you know which Descendants NOT to reactivate later."
 S DIR("A")="  Sure you want to Inactivate"
 D ^DIR W " ... "
 Q Y
 ;
ACTIVE(FILEDA,NODE0) ; Change Status to Active.
 N TIUOUT
 D FULL^VALM1
 I ($P(NODE0,U,4)="DOC"),(+$G(^TIU(8925.1,FILEDA,15))'>0) D  Q:+$G(TIUOUT)
 . W !!,$C(7),"You MUST first map ",$P(NODE0,U),!
 . D DIRECT^TIUMAP2(FILEDA)
 . I +$G(^TIU(8925.1,FILEDA,15))'>0 W $C(7)," Status unchanged...",! H 2
 . I  S TIUOUT=1,VALMBCK="R"
 D AUTOSTAT^TIUFLF6(FILEDA,NODE0,"ACTIVE") S VALMBCK="R"
 I $P(NODE0,U,4)="DOC" W " Entry and any (nonShared) Components Activated",! H 1 Q
 W " Entry Activated",! H 1
 Q
 ;
TEST(FILEDA,NODE0) ; Change Status to Test.
 ; Requires FILEDA, NODE0, INFO from EDSTAT.
 D AUTOSTAT^TIUFLF6(FILEDA,NODE0,"TEST") S VALMBCK="R"
 W !," Entry & any (nonShared) Components changed to TEST",! H 1
 Q
 ;
WARNOBJI(FILEDA) ; Function Warns user inactivating an object,  Returns 1 to Proceed, 0 to Stop.
 N DIR,X,Y,USED,WARNANS
 S USED=$$OBJUSED^TIUFLJ(FILEDA) I USED'["A" S WARNANS=1 G WARNX
 S DIR(0)="Y",DIR("B")="NO",DIR("A",1)=" WARNING: Object is embedded in boilerplate text of active titles.  If you"
 S DIR("A",2)="inactivate the object, it will not function when users enter documents against"
 S DIR("A",3)="such titles.  You might want to warn users or even take such titles offline"
 S DIR("A",4)="while the Object is inactive."
 S DIR("A")="  Continue"
 D ^DIR W " ... " S WARNANS=Y
WARNX Q WARNANS
 ;
