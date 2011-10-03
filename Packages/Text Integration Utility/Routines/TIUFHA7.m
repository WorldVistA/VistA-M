TIUFHA7 ; SLC/MAM - VALMBG(FILEDA,EFILEDA,EOLDLNO), UPDATE, MOVETL, REEXPAND(FILEDA,LINENO,UPDATE), WHICHDC(FILEDA,PFILEDA,ACTION) ;1/27/06
 ;;1.0;TEXT INTEGRATION UTILITIES;**11,27,184**;Jun 20, 1997
 ;
WHICHDC(FILEDA,PFILEDA,ACTION) ; Function returns IFN of DC to copy/move Title to, or 0 if none chosen
 ;Requires FILEDA = IFN of Title to copy/move
 ;Requires PFILEDA = parent of Title
 ;Requires ACTION = MT or C
 N X,Y,GPFILEDA,DIC,DIR,NEWDCY,CWAD1,CWAD2
 S GPFILEDA=+$O(^TIU(8925.1,"AD",PFILEDA,0)) ;orig g'parent of title
AGAINDC S DIC=8925.1,DIC(0)="AEMNQZ"
 I ACTION="MT" D
 . W !!,"  Selecting target Document Class.  Enter '??' for a list of selectable ones.",!
 . W "  You may not select PRF Flag Document Classes"
 . I TIUFWHO'="N" W " or Document Classes",!,"    outside the original Class."
 . E  W "."
 . S DIC("A")="Select TIU DOCUMENT CLASS NAME to Move Title to: "
 . ; - Selected DC must: be DC, in hierarchy, not=current DC,
 . ;   not addm, not PRF DC, & unless user is natl,
 . ;   must be in same class as orig DC:
 . ; - Careful! last global ref could change during screen:
 . S DIC("S")="I $P(^(0),U,4)=""DC""&($$ORPHAN^TIUFLF4(Y,^(0))=""NO"")"
 . S DIC("S")=DIC("S")_"&(Y'=PFILEDA)&(Y'=512)&'$$ISPFDC^TIUPRFL(Y)"
 . I TIUFWHO'="N" S DIC("S")=DIC("S")_"&(GPFILEDA=+$O(^TIU(8925.1,""AD"",Y,0)))"
 I ACTION="C" S DIC("A")="Select TIU DOCUMENT CLASS NAME to Add Copy to: ",DIC("S")="I $P(^(0),U,4)=""DC""&($$ORPHAN^TIUFLF4(Y,^(0))=""NO"")&(Y'=512)"
 D ^DIC I Y=-1 G WDCX
 S NEWDCY=Y,NEWDCY(0)=Y(0)
 N TIUFCK D CHECK^TIUFLF3(+NEWDCY,+$O(^TIU(8925.1,"AD",+NEWDCY,0)),0,.TIUFCK)
 I 'TIUFCK D  I '$$OVERRIDE^TIUFHA2("select entry even though it is FAULTY") W $S(ACTION="MT":"  Title NOT moved.",1:"  Copy NOT added.") D PAUSE^TIUFXHLX  K NEWDCY G WDCX
 . W !!,"Faulty Document Class.  Please TRY it and correct problems before ",$S(ACTION="MT":"Moving Title",1:"Adding Copy"),!,"to it.  "
 I PFILEDA S CWAD1=$P(NEWDCY(0),U,14),CWAD2=$P(^TIU(8925.1,PFILEDA,0),U,14) I (CWAD1="")&(CWAD2'="")!((CWAD1'="")&(CWAD2="")) D  G AGAINDC:Y=0,WDCX:'Y
 . S DIR(0)="Y",DIR("B")="NO"
 . S DIR("A",1)="CWAD's behave differently from nonCWAD documents.",DIR("A")="Are you sure you want this Document Class" D ^DIR
 . I 'Y K NEWDCY
WDCX I $D(DTOUT) S VALMQUIT=1
 Q $S($G(NEWDCY):NEWDCY,1:0)
 ;
VALMBG(FILEDA,EFILEDA,EOLDLNO) ; Set VALMBG to show FILEDA if FILEDA is in LM Array.
 ; requires FILEDA.
 ; Requires EFILEDA = DA of LM entry of interest, EOLDLNO = old lineno of EFILEDA. EFILEDA and/or EOLDLNO may be 0.
 ; Entry of interest is entry to be copied, or Parent of Title to me moved, or Title whose documents are being moved.
 N LINENO,ENEWLNO
 S LINENO=+$O(^TMP("TIUF1IDX",$J,"DAF",FILEDA,0)),ENEWLNO=+$O(^TMP("TIUF1IDX",$J,"DAF",EFILEDA,0))
 I 'LINENO,"AJ"[TIUFTMPL W !,"...  Not in Current View" H 2
 I 'LINENO  Q
 ; If FILEDA shows on the screen, and entry of interest is still in same place on screen then don't change screen position:
 I LINENO'<VALMBG,LINENO'>(VALMBG+VALM("LINES")-1),EOLDLNO=ENEWLNO Q
 S VALMBG=LINENO
 Q
 ;
UPDATE ; Update Parent Document Type for documents of a certain title
 ; ALSO updates CLASS xrefs if valid OLDCLASS can be gotten from ^XTMP("TIUFMOVEN",FILEDA)=OLDCLASS
 N FILEDA,NODE0,INFO,DIR,OLDCLASS
 ; N DIR for EN^VALM2 default
 I '$D(TIUFMOVE) S TIUFMOVE="" ;Set to N in opt ZZTIUFH EDIT DDEFS NATL
 S VALM("ENTITY")="Title whose documents you want to Update"
AGAINUP D EN^VALM2(TIUFXNOD,"SO") G:'$O(VALMY(0)) UPDAX S INFO=$G(^TMP("TIUF1IDX",$J,$O(VALMY(0)))) I 'INFO W !!," Missing List Manager Data; See IRM",! D PAUSE^TIUFXHLX S VALMBCK="Q" G UPDAX
 S FILEDA=$P(INFO,U,2),NODE0=^TIU(8925.1,FILEDA,0)
 ; Need TIUFXNOD phrase to prevent loop:
 N DIRUT I $P(NODE0,U,4)'="DOC" W !,"   ?? Entry must be a TITLE (not a Document Class, etc.).",! D PAUSE^TIUFXHLX G UPDAX:$D(DIRUT)!(TIUFXNOD["="),AGAINUP
 I '$O(^TIU(8925,"B",FILEDA,0)) W !,"  ?? Title has no documents to Update",! D PAUSE^TIUFXHLX G UPDAX:$D(DIRUT)!(TIUFXNOD["="),AGAINUP
 I TIUFMOVE="N" S OLDCLASS=$G(^XTMP("TIUFMOVEN"_FILEDA))
 S OLDCLASS=+$G(OLDCLASS) ;may be 0
 S ^XTMP("TIUFMOVE"_TIUFMOVE_FILEDA,0)=+$$FMADD^XLFDT(DT,30)_U_DT
 D MTRPOINT^TIUFHA8(FILEDA,OLDCLASS)
UPDAX K:TIUFMOVE="" TIUFMOVE S VALM("ENTITY")="Entry" Q
 ;
MOVETL ; Move Title to different DC.  Template H ONLY.  National titles cannot be moved.  Unless special arrangements are made w/ TIU developers, new DC must be in same CLASS as original DC.
 N INFO,FILEDA,NODE0,LINENO,PFILEDA,TENDA,NEWDCY,NDCLNO,PLINENO
 N GPFILEDA,OLDCLASS,DIR ; DIR for EN^VALM2 default
 N EXPAND,DA,DIK,TIUFI,LACKTECH,OVERRIDE
 S VALM("ENTITY")="Title to Move"
 S TIUFMOVE=$G(TIUFMOVE) ; Set to N in opt ZZTIUFH EDIT DDEFS NATL
AGAINTL D EN^VALM2(TIUFXNOD,"SO") G:'$O(VALMY(0)) MTLX S INFO=$G(^TMP("TIUF1IDX",$J,$O(VALMY(0)))) I 'INFO W !!," Missing List Manager Data; See IRM",! D PAUSE^TIUFXHLX S VALMBCK="Q" G MTLX
 S FILEDA=$P(INFO,U,2),NODE0=^TIU(8925.1,FILEDA,0),LINENO=+INFO
 ; Need TIUFXNOD phrase to prevent loop:
 N DIRUT I $P(NODE0,U,4)'="DOC" W !,"   ?? Entry must be a TITLE (not a Document Class, etc.).",! D PAUSE^TIUFXHLX G MTLX:$D(DIRUT)!(TIUFXNOD["="),AGAINTL
 I $P(NODE0,U,13) W !,"   ?? Can't Move National Titles",! D PAUSE^TIUFXHLX G MTLX:$D(DIRUT)!(TIUFXNOD["="),AGAINTL
 I $$ISPFTTL^TIUPRFL(FILEDA) W !,"   ?? Can't Move PRF Flag Titles",! D PAUSE^TIUFXHLX G MTLX:$D(DIRUT)!(TIUFXNOD["="),AGAINTL
 S PFILEDA=+$O(^TIU(8925.1,"AD",FILEDA,0))
 S TENDA=$P(INFO,U,6),PLINENO=$P(INFO,U,5)
 ; -----Check Title under PRESENT parent:
 N TIUFCK D CHECK^TIUFLF3(FILEDA,PFILEDA,1,.TIUFCK) G:$D(DTOUT) MTLX
 K TIUFCK("E"),TIUFCK("R"),TIUFCK("V"),TIUFCK("D"),TIUFCK("H"),TIUFCK("N"),TIUFCK("G")
 I $D(TIUFCK)>9 D  G:'OVERRIDE MTLX
 . W !!,"Faulty Title.  Please TRY it and correct problems before moving it.",!
 . S OVERRIDE=$$OVERRIDE^TIUFHA2("select title even though it is FAULTY")
 . I 'OVERRIDE W "  NOT Moved",! D PAUSE^TIUFXHLX
 S VALMBCK="R" K DIRUT
 L +^TIU(8925.1,FILEDA):1 I '$T W !!,"Another user is editing this Title.",! H 4 G MTLX
 S NEWDCY=$$WHICHDC(FILEDA,PFILEDA,"MT")
 I 'NEWDCY G MTLX ;NEWDCY=New Document Class Y
 S GPFILEDA=+$O(^TIU(8925.1,"AD",PFILEDA,0))
 I GPFILEDA'=+$O(^TIU(8925.1,"AD",+NEWDCY,0)) S OLDCLASS=GPFILEDA
 S OLDCLASS=+$G(OLDCLASS)
 ; -----Check Title under PROPOSED parent:
 N TIUFCK D CHECK^TIUFLF3(FILEDA,NEWDCY,1,.TIUFCK) G:$D(DTOUT) MTLX
 ; -----If Title faulty under proposed parent, don't move:
 S LACKTECH=0
 F TIUFI="E^Edit Template","R^Print Method","V^Visit Linkage Method","D^Validation Method","H^Print Form Header","N^Print Form Number","G^Print Group" S:$D(TIUFCK($E(TIUFI))) LACKTECH=1
 I LACKTECH D
 . W !!,"Documents would not function properly under this move",!,"since Title lacks Technical Fields.  Please edit Title's:",!
 . F TIUFI="E^Edit Template","R^Print Method","V^Visit Linkage Method","D^Validation Method","H^Print Form Header","N^Print Form Number","G^Print Group" W:$D(TIUFCK($E(TIUFI))) ?16,$P(TIUFI,U,2),!
 . W !,"Use values Title inherits from its ancestors.  (To see inherited values, select",!,"Detailed Display for the CURRENT PARENT."
 . I $D(TIUFCK("H"))!$D(TIUFCK("N"))!$D(TIUFCK("G")) W "  In some cases you may have to look",!,"higher up the hierarchy than current parent."
 . W ")  Then come back and try again",!,"to move the Title.",!
 I LACKTECH,'$$OVERRIDE^TIUFHA2("ignore missing fields") W "  Title NOT moved",! D PAUSE^TIUFXHLX G MTLX
 ; -----Delete Title from old parent, Add to new parent:
 I $P(NODE0,U,7)'=+^TMP("TIUF",$J,"STATI") D AUTOSTAT^TIUFLF6(FILEDA,NODE0,"INACTIVE")
 S DA=TENDA,DA(1)=PFILEDA,DIK="^TIU(8925.1,DA(1),10," D ^DIK
 D REEXPAND(PFILEDA,PLINENO,1)
 D ADDTEN^TIUFLF4(+NEWDCY,FILEDA,NODE0,"")
 S NDCLNO=+$O(^TMP("TIUF1IDX",$J,"DAF",+NEWDCY,0))
 I NDCLNO D REEXPAND(+NEWDCY,NDCLNO,1),VALMBG(FILEDA,PFILEDA,PLINENO)
 W !,"...Title Inactivated, Moved to ",$P(NEWDCY,U,2),"."
 K ^XTMP("TIUFMOVE"_TIUFMOVE_FILEDA) ; Cleanup before resetting
 S ^XTMP("TIUFMOVE"_TIUFMOVE_FILEDA,0)=+$$FMADD^XLFDT(DT,30)_U_DT
 D MTRPOINT^TIUFHA8(FILEDA,OLDCLASS)
 D  D:'$D(DIRUT) PAUSE^TIUFXHLX
 . W !!,"Since the Title is in a new Document Class, it now inherits from a new parent",!,"wherever it lacks its own values, and its behavior may differ from before.  It",!
 . W "may also differ from its new siblings wherever it HAS its own values and",!,"siblings INHERIT them.",!
 . W !,"Please check Title thoroughly before reactivating.  Check Business Rules,",!,"TIU Document Parameters, and Document Definition attributes including Basic,",!,"Technical, and Upload fields.",!
 . I TIUFWHO="N" D
 . . W !,"Note that the IN USE display is not updated for CLASSES if old and new Document",!
 . . W "Classes were in different Classes.  This is intentional, to speed up the move",!
 . . W "process.  Display can be updated at any time by collapsing and reexpanding",!
 . . W "the hierarchy.",!
MTLX I $D(DTOUT) S VALMBCK="Q"
 L -^TIU(8925.1,+$G(FILEDA)) S VALM("ENTITY")="Entry" K:TIUFMOVE="" TIUFMOVE
 Q
 ;
REEXPAND(FILEDA,LINENO,UPDATE) ; Collapse, reexpand FILEDA; FILEDA is LINENO in LM array. Sets VALMCNT. Updates LINENO if UPDATE.
 ; Requires FILEDA, LINENO.
 ;DON'T CALL THIS except from template H or C since it resets VALMCNT.
 N INFO,EXPAND
 S INFO=^TMP("TIUF1IDX",$J,LINENO),EXPAND=$P(INFO,U,3) D PARSE^TIUFLLM(.INFO),COLLAPSE^TIUFH1(.INFO) S VALMCNT=VALMCNT-EXPAND D EXPAND1^TIUFH1(.INFO) S VALMCNT=VALMCNT+$P(INFO,U,3)
 I $G(UPDATE) D LINEUP^TIUFLLM1(.INFO,"H")
 Q
 ;
