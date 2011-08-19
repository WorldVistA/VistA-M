TIUGR ; SLC/MAM - ID Note Review Screen Actions ; IDNOTE; 4/12/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**100**;Jun 20, 1997
 ;
IDNOTE ; Review Screen Action IN Interdisciplinary Note
 ;If editing this module, please keep TIUGR1 consistent with it.
 ; -- Sets TIUGLINK if user starts attaching
 ;    the note to an existing note: --
 ;     TIUGLINK = IFN of ID entry^Lineno^Title.
 ;     (If ID entry is chosen via browse instead of review, Lineno=0)
 N LINENO,NTDATA,NTDA,ADDED,TIUQUIT,TITLE,TITLEDA
 N CANATT,CANADD,PDOCTYP,TIUCHNG,LNO
 N TIUDAARY,DETACHED,TIUACT,TIULST,TIUIDDAD
 ; -- If user has already selected note to attach, but not note
 ;    to attach it to, write msg and quit: --
 ;I $G(TIUGLINK) D ATTCHMSG(TIUGLINK) S TIUQUIT=1 G IDNOTEX
 ; -- If user has already selected note to attach, but not note
 ;    to attach it to, and reselects IN, quit attach action: --
 I $G(TIUGLINK) D LINKQUIT^TIUGR2 S TIUQUIT=1 G IDNOTEX
 ; -- Select note to act on, if not already selected: --
 I '$D(VALMY) D  I $G(TIUQUIT) G IDNOTEX
 . I $P($G(XQORNOD(0)),U,4)'["=" D
 . . W !!,"  To ADD a new entry to an interdisciplinary note, please select the",!,"interdisciplinary note."
 . . W !,"  To ATTACH an existing stand-alone note to an interdisciplinary note,",!,"please select the note you want to attach."
 . D EN^VALM2(XQORNOD(0),"S") S LINENO=+$O(VALMY(0))
 . I 'LINENO S TIUQUIT=1 Q
 . ; -- Reverse video selected note: --
 . D RESTORE^VALM10(LINENO),CNTRL^VALM10(LINENO,6,VALM("RM"),IORVON,IORVOFF),WRITE^VALM10(LINENO)
 ; -- In case note was already selected: --
 S LINENO=+$O(VALMY(0))
 ; -- Set notedata NTDATA = lineno^IFN^? --
 S NTDATA=$G(^TMP("TIURIDX",$J,LINENO))
 S NTDA=+$P(NTDATA,U,2)
 I '$D(^TIU(8925,+NTDA,0)) S TIUCHNG("REFRESH")=1,TIUQUIT=1 G IDNOTEX
 S TITLE=$$DOCTYPE^TIULF(NTDA)
 I $O(VALMY(LINENO)) D
 . W !!,"Notes must be selected one at a time for interdisciplinary"
 . W !,"note actions.  Acting on your FIRST selection,"
 . W !?3,$P(TITLE,U,2) H 5
 . S LNO=LINENO F  S LNO=$O(VALMY(LNO)) Q:'LNO  D
 . . D RESTORE^VALM10(LNO)
 . . D WRITE^VALM10(LNO)
 . . K VALMY(LNO)
 ; -- If note is addendum, CWAD, or consult result,
 ;    user can't detach/attach it or add new entry to it.
 ;    Say so & quit: --
 I +^TIU(8925,+NTDA,0)=81 D CANT("A") S TIUCHNG("REFRESH")=1 G IDNOTEX
 S PDOCTYP=$P(^TIU(8925,+NTDA,0),U,4)
 I (PDOCTYP=27)!(PDOCTYP=25)!(PDOCTYP=31)!(PDOCTYP=30) D  G IDNOTEX
 . D CANT("CWAD") S TIUCHNG("REFRESH")=1
 I $P($G(^TIU(8925,+NTDA,14)),U,5) D  G IDNOTEX
 . D CANT("CR") S TIUCHNG("REFRESH")=1
 ; -- If note is already an entry of an ID note, unlink it: --
 S TIUIDDAD=$$HASIDDAD^TIUGBR(NTDA)
 I TIUIDDAD D  G IDNOTEX
 . S TIUACT="DETACHED",TIUDAARY(LINENO)=NTDA
 . D UNLKKID^TIUGR1(NTDA,TIUIDDAD,.DETACHED)
 . I '$G(DETACHED) S TIUCHNG("REFRESH")=1,TIULST="" Q
 . S TIUCHNG("RBLD")=1,TIULST=LINENO
 ; -- If user can add an entry to the note, do it & quit: --
 S CANADD=$$CANDO^TIULP(NTDA,"ATTACH ID ENTRY")
 I CANADD D  G IDNOTEX
 . D ADDDAD^TIUGEDIT(NTDA,.ADDED)
 . I 'ADDED S TIUCHNG("REFRESH")=1 Q
 . S TIUCHNG("RBLD")=1
 ; -- If user can't add entry to note, & attaching note to
 ;    an existing note is not permitted, say can't add & quit: --
 ;    -- Note itself has entries: --
 I 'CANADD,$$HASIDKID^TIUGBR(NTDA) D  G IDNOTEX
 . W !!,$P(CANADD,U,2) D PAUSE S TIUCHNG("REFRESH")=1
 ;    -- Note is a possible parent: --
 S TITLEDA=+^TIU(8925,NTDA,0)
 I 'CANADD,$$POSSPRNT^TIULP(TITLEDA) D  G IDNOTEX
 . W !!,$P(CANADD,U,2) D PAUSE S TIUCHNG("REFRESH")=1
 ; -- See if user can attach note to an existing note: --
 S CANATT=$$CANDO^TIULP(NTDA,"ATTACH TO ID NOTE")
 ;    -- If user can attach note, set TIUGLINK,
 ;       write "Attaching...", and quit: --
 I CANATT D  G IDNOTEX
 . S TIUGLINK=NTDA_U_LINENO_U_$P(TITLE,U,2)
 . D ATTCHMSG(TIUGLINK) ; User is mid-attach, don't set TIUCHNG
 ;    -- If user can't attach, say can't attach, and quit
 I 'CANATT D
 . W !!,$P(CANATT,U,2) D PAUSE
 . S TIUCHNG("REFRESH")=1
IDNOTEX ; Restore video for selected line and refresh/update/rebuild list:
 I $G(TIUCHNG("REFRESH"))!$G(TIUCHNG("UPDATE"))!$G(TIUCHNG("RBLD")) D
 . S VALMY(LINENO)=""
 . D UPRBLD^TIURL(.TIUCHNG,.VALMY)
 S VALMBCK="R" K VALMY
 I $G(TIUACT)="DETACHED" D VMSG^TIURS1(TIULST,.TIUDAARY,"DETACHED")
 Q
 ;
PAUSE ;Wait til user hits return
 I $$READ^TIUU("EA","Press RETURN to continue...")
 Q
 ;
CANT(TYPE) ; Tell user they can't act on addendum, CWAD, or
 ;Consult result
 I TYPE="A" D
 . W !!,"  An addendum is linked to its parent when it is first made and"
 . W !,"cannot be attached or detached like an interdisciplinary note."
 . W !,"To add an addendum to a note, use action 'Make Addendum.'"
 I TYPE="CWAD" D
 . W !!,"  CWAD notes cannot be used as interdisciplinary notes."
 I TYPE="CR" D
 . W !!,"  Consult results cannot be used as interdisciplinary notes."
 D PAUSE
 Q
 ;
ATTCHMSG(KIDDATA) ; Offer instructions when user has selected
 ;the note to attach but not the note to attach it to.
 W !!,"  Attaching ",$P(KIDDATA,U,3),"."
 W !,"  Please select the note you want to attach it to."
 W !,"  Or, reselect action IN if you no longer wish to attach the note."
 I $$READ^TIUU("EA","Press RETURN when you have finished reading this message...")
 Q
 ;
