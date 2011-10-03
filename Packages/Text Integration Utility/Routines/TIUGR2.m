TIUGR2 ; SLC/MAM - ID Note Review Screen Actions ;2/28/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**100**;Jun 20, 1997
 ;
LKDAD(KIDDATA) ; Select DAD ID note to attach KID to, and attach it.
 ; Called by PICK^TIULM when user selects line at action prompt
 ;when TIUGLINK exists.  Needs $0(VALMY(0)).
 ; KIDDATA = TIUGLINK = DA^lineno^titlename for entry being attached,
 ;                      where lineno = 0 if not in current screen
 N LINENO,CANLINK2,DADDATA,DADDA,DADTL,CONTINUE,LINKED
 N TIUI,PDOCTYP,TIUCHNG
 S LINKED=0
 S LINENO=+$O(VALMY(0))
 S DADDATA=$G(^TMP("TIURIDX",$J,LINENO))
 S DADDA=+$P(DADDATA,U,2)
 I '$D(^TIU(8925,+DADDA,0)) G LKDADX
 ; -- Set can't attach msg:
 I +^TIU(8925,+DADDA,0)=81 S CANLINK2="0^You cannot attach ID entries to addenda."
 S PDOCTYP=$P(^TIU(8925,+DADDA,0),U,4)
 I (PDOCTYP=27)!(PDOCTYP=25)!(PDOCTYP=31)!(PDOCTYP=30) S CANLINK2="0^You cannot attach ID entries to CWAD notes."
 I $P(^TIU(8925,+DADDA,14),U,5) S CANLINK2="0^You cannot attach ID entries to consult results."
 I '$D(CANLINK2) S CANLINK2=$$CANDO^TIULP(DADDA,"ATTACH ID ENTRY")
 I CANLINK2 D
 . Q:($P(^TIU(8925,DADDA,0),U,2)=$P(^TIU(8925,+KIDDATA,0),U,2))
 . S $P(CANLINK2,U,2)="You cannot attach these notes; they do not have the same patient."
 . S $P(CANLINK2,U)=0
 ; -- Tell user they can't attach, and quit:
 I 'CANLINK2 D  G LKDADX
 . W !!,"  ",$P(CANLINK2,U,2),!
 . W "Please reselect the child and choose a different parent."
 . I $$READ^TIUU("EA","Press RETURN to continue...")
 ; -- Attach:
 S DADTL=$P($$DOCTYPE^TIULF(DADDA),U,2)
 W !!,"  Attaching ",$P(KIDDATA,U,3)," to ",!,DADTL,"."
 S CONTINUE=$$READ^TIUU("Y","  Are you sure","YES")
 I 'CONTINUE!$D(DUOUT)!$D(DTOUT)!$D(DIROUT) G LKDADX
 S LINKED=1
 D LINK(+TIUGLINK,DADDA)
 I $L(DADTL)>26 S DADTL=$E(DADTL,1,26)
LKDADX ; Exit
 ; -- Restore video for KID line if kid is in current screen:
 I $P(KIDDATA,U,2) D RESTORE^VALM10($P(KIDDATA,U,2))
 ; -- Set msgbar, UPRBLD parameter:
 I 'LINKED S VALMSG="** Note not attached **",TIUCHNG("REFRESH")=1
 I LINKED S VALMSG="** Note attached to "_DADTL_" **",TIUCHNG("RBLD")=1
 D UPRBLD^TIURL(.TIUCHNG,.VALMY) ;don't K VALMY - done in PICK^TIULM
 S VALMBCK="R" K TIUGLINK
 Q
 ;
LINKMSG(TIUGLINK) ; Returns VALMSG displayed after LKKID.
 ;Used in ENTRY ACTION of protocol TIU ACTION MENU OE/RR.
 ; Can't just set VALMSG in LKKID because it gets overwritten by ENTRY
 ;ACTION if user selects item number as independent List Manager action.
 N KIDTL
 S KIDTL=$P(TIUGLINK,U,3)
 I $L(KIDTL)>33 S KIDTL=$E(KIDTL,1,33)
 Q "** Attaching "_KIDTL_" **"
 ;
LINK(DA,DADDA) ; Link DA to parent ID note DADDA
 N DIE,DR
 S DIE=8925,DR="2101////"_DADDA
 D ^DIE
 D AUDLINK^TIUGR1(DA,"a",DADDA)
 D SENDID^TIUALRT1(DA)
 Q
 ;
LINKQUIT ; Quit without linking
 ; Action QUIT Review Screen if started linking and didn't succeed
 ; Called by TIU ACTION QUIT from Review Screen if $G(TIUGLINK).
 ; Unscreens review actions
 N TIUI
 S TIUI=0
 F TIUI=+$O(VALMY(TIUI)) Q:'TIUI  D RESTORE^VALM10(TIUI)
 I $P($G(TIUGLINK),U,2) D RESTORE^VALM10(+$P(TIUGLINK,U,2))
 S VALMSG="** Note not attached **"
 K VALMY,TIUGLINK
 S VALMBCK="R"
 Q
 ;
