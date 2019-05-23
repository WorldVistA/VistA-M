IBJPS7 ;ALB/VD - IB Site Parameters, Pay-To Provider Rate Types ;02-Feb-2018
 ;;2.0;INTEGRATED BILLING;**608**;21-MAR-94;Build 90
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN(IBTCFLAG) ; -- main entry point for IBJP IB PAY-TO RATE TYPES
 ; select pay-to provider
 Q:(IBTCFLAG'=1)  ; Only want Non-MCCF Pay-To Provider Rate Types
 D EN^VALM("IBJP IB NON-MCCF RATE TYPES")
 S VALMBCK="R"
 Q
 ;
HDR ; -- header code
 S VALMSG=""
 Q
 ;
INIT(IBTCFLAG) ; -- init variables and list array
 N ERROR,IBCNT,IBLN,IBSTR,RTYDATA,RIENS,RTYPE
 Q:(IBTCFLAG'=1)  ; Only want Non-MCCF Pay-To Provider Rate Types
 ;
 S (VALMCNT,IBCNT,IBLN)=0
 I $D(^IBE(350.9,1,28,"B")) D
 . S RTYPE=0 F  S RTYPE=$O(^IBE(350.9,1,28,"B",RTYPE)) Q:'RTYPE  D
 . . ;
 . . S RIENS=RTYPE_","
 . . D GETS^DIQ(399.3,RIENS,".001;.01;.03","I","RTYDATA","ERROR")
 . . ; do not included *RESERVED codes (must be ACTIVATE = 0 for Active, 1 = InActive)
 . . Q:+$G(RTYDATA(399.3,RIENS,.03,"I"))
 . . S IBCNT=IBCNT+1
 . . S IBSTR=$$SETSTR^VALM1($J(IBCNT,4)_".","",2,6)
 . . S IBSTR=$$SETSTR^VALM1($J($G(RTYDATA(399.3,RIENS,.001,"I")),3),IBSTR,10,4)
 . . S IBSTR=$$SETSTR^VALM1($G(RTYDATA(399.3,RIENS,.01,"I")),IBSTR,17,30)
 . . S IBLN=$$SET(IBLN,IBSTR)
 . . S @VALMAR@("ZIDX",IBCNT,$G(RTYDATA(399.3,RIENS,.001,"I")))=""
 . . Q
 ;
 I 'IBLN S IBLN=$$SET(IBLN,$$SETSTR^VALM1("No Rate Types defined.","",13,40))
 ;
 S VALMCNT=IBLN,VALMBG=1
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
RTADD(IBTCFLAG) ; -- Add a new Rate Type
 N DA,DIK,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FDA,IEN,IENS,X,Y,Z
 ;
 S VALMBCK="R"
 Q:'$$LOCK()  ; Couldn't lock for adding
 D FULL^VALM1
 ;
 I '$$ENTSEL(.IENS) D  Q  ; Select entry(s) to be added
 . S VALMSG="No Rate Type selected"
 . D UNLOCK
 D UNLOCK          ; Unlock the node.
 D INIT(IBTCFLAG) ; Rebuild list body
 S VALMSG="Added Rate Type(s)"
 Q
 ;
RTDEL(IBTCFLAG) ; -- Delete a Rate Type
 N VALMY,Z
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)))
 S Z=0
 F  S Z=$O(VALMY(Z)) Q:'Z  D
 . N DA,DIK,IEN,RIEN
 . S IEN=$O(@VALMAR@("ZIDX",Z,""))
 . Q:'IEN
 . S RIEN=$O(^IBE(350.9,1,28,"B",IEN,""))
 . I +RIEN S DIK="^IBE(350.9,1,28,",DA(1)=1,DA=RIEN D ^DIK
 K @VALMAR
 D INIT(IBTCFLAG)
 S VALMBCK="R"
 Q
 ;
SET(IBLN,IBSTR) ; -- Add a line to display list
 ; returns line number added
 S IBLN=IBLN+1 D SET^VALM10(IBLN,IBSTR,IBLN)
 Q IBLN
 ;
ENTSEL(IENS) ; Selects an entry to be added to the specified Site Parameter Node
 ; Output: IENS - Array of selected IEN(s), "" if not selected
 ; Returns: 1 - At least one IEN selected, 0 otherwise
 N DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FDA,STOP,X,Y,Z
 K IENS
 S STOP=0
 S DIC=399.3
 S DIC(0)="AEQM"
 S DIC("A")="Select a Rate Type to be added: "
 ;
 ; Set the Add filter
 S DIC("S")="I '$D(^IBE(350.9,1,28,""B"",Y))&'$D(IENS(+Y))"
 F  D  Q:STOP
 . D ^DIC
 . I Y'>0 S STOP=1 Q
 . S IENS(+Y)=""
 . ; create entry for Rate Type
 . K FDA
 . S FDA("350.928","+1,1,",.01)=+Y
 . S FDA("350.928","+1,1,",.02)=0
 . D UPDATE^DIE("","FDA")
 . Q
 ;
 I '$D(IENS) Q 0 ; No IENS selected
 Q 1
 ;
LOCK() ;EP
 ; Attempt to lock the Non-MCCF Pay-To Providers Rate Types for Site Parameters.
 ; Returns: 1 - Successfully locked
 ; 0 - Not successfully locked and an error message is
 ; displayed
 L +^IBE(350.9,1,28):1
 I '$T D  Q 0
 . W @IOF,"Someone else is editing the Non-MCCF Pay-To Providers Rate Types"
 . W !,"Please Try again later"
 . D PAUSE^VALM1
 Q 1
 ;
UNLOCK ;EP
 ; Unlocks the Non-MCCF Pay-To Providers Rate Types for IB Site Parameters.
 L -^IBE(350.9,1,28)
 Q
 ;
