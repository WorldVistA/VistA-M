TIUGR1 ; SLC/MAM - More ID Note Review Screen Actions ;4/12/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**100**;Jun 20, 1997
 ;
IDNOTEB(TIUDA) ; Browse Screen Action IN Interdisciplinary Note
 ; Requires TIUDA
 ; If editing this module, please keep TIUGR consistent with it.
 N TITLE,PREFIX,TITLEDA,CANADD,CANATT,ADDED,TIUQUIT,TIUIDDAD
 ;TIUCHNG is newed in TIURA2; Don't new it here
 S VALMBCK="R"
 ; -- If note is addendum, can't attach; say so & quit: --
 I +^TIU(8925,TIUDA,0)=81 D  G IDNOTEBX
 . D CANT^TIUGR("A") S TIUCHNG("REFRESH")=1
 ; -- If note is already an entry of an ID note, unlink it: --
 S TIUIDDAD=$$HASIDDAD^TIUGBR(TIUDA)
 I TIUIDDAD D  G IDNOTEBX
 . D UNLKKID(TIUDA,TIUIDDAD)
 . I $G(TIUQUIT) S TIUCHNG("REFRESH")=1 Q
 . S TIUCHNG("RBLD")=1
 . K VALMHDR ; TIUDA is no longer an ID entry so update header
 ; -- If user can add an entry to the note, do it & quit: --
 S CANADD=$$CANDO^TIULP(TIUDA,"ATTACH ID ENTRY")
 I CANADD D ADDDAD^TIUGEDIT(TIUDA,.ADDED) D  G IDNOTEBX
 . I 'ADDED S TIUCHNG("REFRESH")=1 Q
 . S TIUCHNG("RBLD")=1 K VALMHDR
 ; -- If user can't add entry to note, & attaching note to
 ;    an existing note is not permitted, say can't add & quit: --
 ;    -- Note itself has entries: --
 I 'CANADD,$$HASIDKID^TIUGBR(TIUDA) D  G IDNOTEBX
 . W !!,$P(CANADD,U,2) D PAUSE^TIUGR
 . S TIUCHNG("REFRESH")=1
 ;    -- Note is a possible parent: --
 S TITLEDA=+^TIU(8925,TIUDA,0)
 I 'CANADD,$$POSSPRNT^TIULP(TITLEDA) D  G IDNOTEBX
 . W !!,$P(CANADD,U,2) D PAUSE^TIUGR
 . S TIUCHNG("REFRESH")=1
 ; -- See if user can attach note to an existing note: --
 S CANATT=$$CANDO^TIULP(TIUDA,"ATTACH TO ID NOTE")
 ; -- If user can attach, tell user not to use Browse:
 I CANATT W !!,"To attach this note to an ID parent, please exit Browse and try again ",!,"from a Review Screen showing a list of notes.",! H 5 S TIUCHNG("REFRESH")=1 G IDNOTEBX
 ;    -- If user can't attach, say can't attach: --
 I 'CANATT W !!,$P(CANATT,U,2) D PAUSE^TIUGR S TIUCHNG("REFRESH")=1
IDNOTEBX ;
 ; -- Rebuild browse screen for updated record: --
 ;    (Review screen is updated from BROWSE^TIURA2)
 S TIUGDATA=$$IDDATA^TIURECL1(TIUDA) ;may have changed
 D BLDTMP^TIUBR(TIUDA)
 Q
 ;
UNLKKID(KIDDA,TIUIDDAD,DETACHED) ; Unlink ID entry
 ; Check if user can unlink, and if so, unlink it.
 N CANUNLK,UNLINK,MSG,DADDA,TIUQUIT
 S DETACHED=0
 W !!,"This note is attached to an interdisciplinary note."
 ; -- Same users can unlink as can link: --
 S CANUNLK=$$CANDO^TIULP(KIDDA,"ATTACH TO ID NOTE")
 I CANUNLK S CANUNLK=$$CANDO^TIULP(TIUIDDAD,"ATTACH ID ENTRY")
 I 'CANUNLK D  G UNLKKIDX
 . ;S MSG=$P(CANUNLK,U,2),MSG=$P(MSG,"You may not ATTACH this",2)
 . ;S MSG=$P(MSG,"to an ID note."),MSG=" You may not DETACH this"_MSG
 . W !,"You may not detach this note from its interdisciplinary note."
 . I $$READ^TIUU("EA","Press RETURN to continue...")
 . S TIUQUIT=1
 S UNLINK=$$READ^TIUU("Y","Do you want to detach it","NO")
 I 'UNLINK W !!,"Entry not detached." H 1 S TIUQUIT=1 G UNLKKIDX
 S DADDA=$P($G(^TMP("TIUR",$J,"IDDATA",KIDDA)),U,3)
 D UNLINK(KIDDA)
 I DADDA D UPIDDATA^TIURL1(KIDDA),UPIDDATA^TIURL1(DADDA)
 W !!,"Entry detached." H 1
 ;S VALMSG="** Entry detached **" ;4/9/01
 S TIUCHNG("RBLD")=1,DETACHED=1 ;4/9/01
UNLKKIDX ;
 ;I $G(TIUQUIT) S VALMSG="** Entry not detached **",TIUCHNG("REFRESH")=1 Q  ;4/9/01
 I $G(TIUQUIT) S TIUCHNG("REFRESH")=1 Q  ;4/9/01
 Q
 ;
UNLINK(DA) ; Unlink DA from DADDA
 N DIE,DR,IDDAD
 S IDDAD=+$G(^TIU(8925,DA,21))
 S DIE=8925,DR="2101////@"
 D ^DIE
 D AUDLINK(DA,"d",IDDAD)
 D IDDEL^TIUALRT1(DA)
 Q
AUDLINK(TIUDA,ACTION,IDPARENT) ; Audit Attach/Detach Events
 N DIC,DIE,DA,DR,X,Y,TIUD0,TIUD21,DLAYGO
 Q:$G(ACTION)']""!(+$G(IDPARENT)'>0)
 S TIUD0=$G(^TIU(8925,TIUDA,0))
 S X=""""_"`"_TIUDA_"""",(DIC,DLAYGO)=8925.5,DIC(0)="FLX" D ^DIC Q:+Y'>0
 S DA=+Y,DIE=DIC
 S DR="3.01////"_ACTION_";3.02////"_$$NOW^XLFDT
 S DR=DR_";3.03////"_DUZ_";3.04////"_$P(TIUD0,U,5)
 S DR=DR_";3.05////"_IDPARENT
 D ^DIE
 Q
