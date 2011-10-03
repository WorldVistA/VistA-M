TIUGEDIT ; SLC/MAM - Add New ID Entry; 8/28/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**100,123**;Jun 20, 1997
DIE(DA,TIUQUIT) ; Invoke ^DIE
 N Y,DIE,DR
 S ^TIU(8925,"ASAVE",DUZ,DA)=""
 S DR=$$GETTMPL^TIUEDI1(+$P(^TIU(8925,+DA,0),U))
 I DR']"" W !?5,$C(7),"No Edit template defined for ",$$PNAME^TIULC1(+$P(^TIU(8925,+DA,0),U)),! S TIUQUIT=2 Q
 S DIE=8925 D ^DIE
 S DR=".05///undictated",DIE=8925 D ^DIE
 D UPDTIRT^TIUDIRT(.TIU,DA),SEND^TIUALRT(DA)
 L -^TIU(8925,+DA)
 Q
 ;
ADDSTUB(DADDA) ; Prompt user for new stub ID entries for parent DADDA
 N TIUAUTH,TIUTYP,TIUDAD,DFN,TIUDPRM,DA,TIURTYP,TIUPRMT
 N X,Y,DIC
 S DFN=$P(^TIU(8925,DADDA,0),U,2)
 W !!,"  If you wish you may add stub interdisciplinary entries for this note:",!
 F  D  Q:$G(TIUAUTH)'>0  Q:$G(TIUTYP)'>0
 . K TIUTYP,TIUAUTH
 . S DIC=200,DIC(0)="AEMQ",DIC("A")="Select stub AUTHOR: "
 . S DIC("S")="I '+$$ISTERM^USRLM(+Y)"
 . D ^DIC
 . ;I Y'>0 S TIUOUT=1 Q
 . Q:Y'>0
 . S TIUAUTH=+Y
 . ; -- Get data array TIUDAD on parent note DADDA: --
 . I '$D(TIUDAD) D GETTIU^TIULD(.TIUDAD,DADDA)
 . D DOCSPICK^TIULA2(.TIUTYP,3,"1A","LAST","Select stub TITLE: ","+$$CANPICK^TIULP(+Y),+$$CANENTR^TIULP(+Y),$$CANLINK^TIULP(+Y)")
 . ;I +$G(TIUTYP)'>0 S TIUOUT=1 Q
 . Q:+$G(TIUTYP)'>0
 . S TIUTYP=+$P($G(TIUTYP(1)),U,2) ; IFN. (DOCSPICK returns TIUTYP as 1.)
 . ; -- Use visit of parent: --
 . M TIU=TIUDAD
 . ;-- Get parameters for selected title: --
 . D DOCPRM^TIULC1(TIUTYP,.TIUDPRM)
 . ; --  Get DA: --
 . S DA=$$CREATREC^TIUEDI3(DFN,.TIU,TIUTYP(1))
 . N TIUQUIT,TIUTDA
 . D DIE(DA,.TIUQUIT)
 . D LINK^TIUGR2(DA,DADDA)
 . W !,"  Stub entry added",!!
 Q
 ;
ADDDAD(DADDA,ADDED) ; Create new ID entry and link it to note DADDA
 ; Assumes DADDA can receive ID entries.
 ; Requires DADDA = parent note
 ; Requires DADLINE = parent note line number
 ; Returns ADDED > 0 if new note added (may not be linked), otherwise = 0
 N TITLE,TIUD0,TITLEDA,ADDING,STATUS,KIDDA
 S ADDED=0
 S TIUD0=$G(^TIU(8925,+DADDA,0))
 S TITLEDA=+TIUD0,STATUS=$P(TIUD0,U,5),TITLE=$$PNAME^TIULC1(TITLEDA)
 I STATUS<6 Q
 S ADDING=$$READ^TIUU("Y","Are you adding a new interdisciplinary entry to this note","YES")
 I 'ADDING D  Q
 . W !!,"This note appears to be an interdisciplinary parent.  Please select"
 . W !,"the note you want to attach to this note FIRST, or check with IRM"
 . W !,"or your clinical coordinator."
 . I $$READ^TIUU("EA","Press RETURN to continue...")
 D CLEAR^VALM1 W !!,"Adding a new interdisciplinary entry to",!,TITLE
 D FULL^VALM1
 D ADDDAD1(DADDA,.KIDDA)
 I $G(KIDDA) S ADDED=1 D:$D(^TMP("TIUR",$J)) UPIDDATA^TIURL1(DADDA),UPIDDATA^TIURL1(KIDDA)
 Q
 ;
ADDDAD1(DADDA,DA) ; Enter one new ID Document and link it to DADDA
 ; Call with:
 ; [DADDA] --> IFN of note new note will be added to,
 ;             i.e. parent note. Required.
 ;    [DA] --> IFN of new note or 0 if not created.  Passed back.
 N LINKTL,TIUVSUPP,TIULMETH,TIU,TIUVMETH,TIUOUT,TIUASK,TIUDAD
 N TIUNEW,TIU,TIUTYP,DFN,EDIT,TIUCMMTX,TIUDPRM,TIUEXIT,CONTINUE
 N TIUQUIT
 S DA=0
 ; -- Get data array TIUDAD on parent note DADDA: --
 D GETTIU^TIULD(.TIUDAD,DADDA)
 S DFN=$P(^TIU(8925,DADDA,0),U,2)
 ; -- Get new title from user.
 ;    Set info into array TIUTYP where
 ;          TIUTYP = title DA
 ;       TIUTYP(1) = 1^title DA^Name...
TITLE ; -- Get title.  Limit titles to those user can link, at least
 ;for SOME status.  Check again later after we know the status.
 W !!,"Please select a title for your entry:"
 D DOCSPICK^TIULA2(.TIUTYP,3,"1A","LAST","","+$$CANPICK^TIULP(+Y),+$$CANENTR^TIULP(+Y),$$CANLINK^TIULP(+Y)")
 I +$G(TIUTYP)'>0 S TIUOUT=1 Q
 S TIUTYP=+$P($G(TIUTYP(1)),U,2) ; IFN. (DOCSPICK returns TIUTYP as 1.)
VISIT ; -- Get visit (use same visit as first entry unless visit
 ;must be an historical event and parent visit is not hist): --
 S TIUVSUPP=+$$SUPPVSIT^TIULC1(TIUTYP)
 I TIUVSUPP,$P(TIUDAD("VSTR"),";",3)'="E" D EVENT^TIUSRVP1(.TIU,DFN) I 1
 E  M TIU=TIUDAD
VALID ; -- Validate, i.e. ask user if OK: --
 S TIUVMETH=$$GETVMETH^TIUEDI1(TIUTYP)
 I '$L(TIUVMETH) D  S TIUOUT=1 Q
 . W !,$C(7),"No Validation Method defined for "
 . W $$PNAME^TIULC1(TIUTYP),".",!,"Please contact IRM..."
 ; -- Ask user if proposed docmt looks OK.
 ;    May change array TIU, gets user answer in TIUASK: --
 K TIU("REFDT") ; for new ID child, want default = NOW. See TIULD
 X TIUVMETH
 I '$D(TIU("VSTR")) D  Q
 . W !,$C(7),"Patient & Visit required." H 2
 ; -- Go on if user answers says OK: --
 Q:'TIUASK
 ;-- Get parameters for selected title: --
 D DOCPRM^TIULC1(TIUTYP,.TIUDPRM)
 ; --  Get DA: new docmt for user to continue entering, or
 ;     existing docmt for user to edit, or existing docmt for
 ;     user to link w/o editing since they may not edit it: --
 S DA=$$GETRECG^TIUGEDI1(DFN,.TIU,.TIUTYP,.TIUDPRM,.TIUNEW,.EDIT,DADDA)
 I 'DA S VALMSG="** No entry added **" Q
 ; -- If user is attaching an existing docmt they may not edit,
 ;    try to attach, and quit: --
 I 'TIUNEW,'EDIT D TRYLINK(DA,DADDA,.TIUDAD) H 2 Q
 ; -- Edit new or existing DA: --
 N TIUQUIT,TIUTDA
 D DIE^TIUEDI4(DA,.TIUQUIT)
 Q:'$G(^TIU(8925,DA,0))  ; uparrow w/ bad docmt, already deleted
 I $$EMPTYDOC^TIULF(DA) D DELETE^TIUEDIT(DA,0) S:$G(VALMAR)="^TMP(""TIUVIEW"",$J)" VALMBCK="Q" S:'TIUNEW TIUCHNG("DELETE")=1 H:'TIUNEW 2 Q
 I +$G(TIUQUIT),'EDIT W !,"Document not attached" H 2 Q
 ; -- Misc after-edit-stuff for DA --
 I +$G(TIU("STOP")),(+$P($G(TIUDPRM(0)),U,14)'=1) D DEFER^TIUVSIT(DA,TIU("STOP")) I 1 ; Stop code: For stand alones, mark to get work load at signature
 E  D QUE^TIUPXAP1 ; Post workload now in background
 S TIUCMMTX=$$COMMIT^TIULC1(TIUTYP)
 I TIUCMMTX]"" X TIUCMMTX
 D RELEASE^TIUT(DA)
 D VERIFY^TIUT(DA)
 ; -- If get this far without quitting, attach entry,
 ;    new or existing, so auto-print prints whole note:
 D LINK^TIUGR2(DA,DADDA) S VALMSG="** Entry attached **"
 ; -- Get signature
 D EDSIG^TIURS(DA) ;does auto-print
 ; -- execute EXIT ACTION --
 S TIUEXIT=$$GETEXIT^TIUEDI2(TIUTYP)
 I $L(TIUEXIT) S TIUTDA=DA X TIUEXIT S DA=TIUTDA
 ;I '$G(^TIU(8925,DA,21)) D TRYLINK(DA,DADDA,.TIUDAD)
 ; --  [Prompt to print DA] --
 I +$P($G(TIUDPRM(0)),U,8) D PRINT^TIUEPRNT(DA)
 Q
 ;
TRYLINK(DA,DADDA,TIUDAD) ; Check specific docmt now that we know
 ;its status, to see if user can attach it to an ID note; if so,
 ;attach DA to DADDA.
 ; Already know that DADDA can receive ID entries.
 ;4/11/01 not currently used
 N CANLINK
 S CANLINK=$$CANDO^TIULP(DA,"ATTACH TO ID NOTE")
 I 'CANLINK D  Q
 . W !!,$P(CANLINK,U,2),!," Entry saved as a stand-alone note.  Please attach it later if you are",!," authorized to do so."
 . I $$READ^TIUU("EA","Press RETURN to continue...")
 . I $D(DUOUT)!$D(DTOUT)!$D(DIROUT) S TIUQUIT=1
 . S VALMSG="** Entry saved as a stand-alone note **"
 D LINK^TIUGR2(DA,DADDA)
 W !!,"Entry added to ",$P(TIUDAD("DOCTYP"),U,2)
 S VALMSG="** Entry attached **"
 Q
 ;
