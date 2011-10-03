TIUFHA8 ; SLC/MAM - MOVEDOC, MDRPOINT(OLDTLDA,NEWTLDA,POLDTLDA,PNEWTLDA,NOLOCK), NEWTITLE(FILEDA,PFILEDA), MTRPOINT(TITLEDA,OLDCLASS) ;1/29/06
 ;;1.0;TEXT INTEGRATION UTILITIES;**11,27,64,184**;Jun 20, 1997
 ;
CANT(FILEDA,NODE0) ; Check if docmts can be moved; return 1 if cant
 N CANTMSG,CANT S CANT=0
 I $P(NODE0,U,4)'="DOC" S CANTMSG="   ?? Entry must be a TITLE (not a Document Class, etc.)" G:$D(CANTMSG) CANTX
 I $$HASITEMS^TIUFLF1(FILEDA) S CANTMSG="   ?? Documents cannot be moved for Titles with Components" G:$D(CANTMSG) CANTX
 I '$O(^TIU(8925,"B",FILEDA,0)) S CANTMSG="  ?? Title has no documents to move" G:$D(CANTMSG) CANTX
 I FILEDA=81 S CANTMSG="   ?? Can't Move Addenda" G:$D(CANTMSG) CANTX
 I $$ISPFTTL^TIUPRFL(FILEDA) S CANTMSG="   ?? Documents cannot be moved for PRF Flag Titles" G:$D(CANTMSG) CANTX
CANTX I $D(CANTMSG) W !,CANTMSG,! D PAUSE^TIUFXHLX S CANT=1
 Q CANT
 ;
MOVEDOC ; Move documents from old Title to new Title.  Template H ONLY.  Titles must have same grandparent.  Titles cannot have components.
 N INFO,FILEDA,NODE0,PFILEDA,TENDA,NEWTLY,LINENO,PLINENO
 N DA,DIK,NPLINENO,DIR,NPFILEDA,NOLOCK,CWAD1,CWAD2
 ; N DIR for EN^VALM2 default
 S VALM("ENTITY")="Title whose documents you want to Move"
AGAINDOC D EN^VALM2(TIUFXNOD,"SO") G:'$O(VALMY(0)) MDOCX S INFO=$G(^TMP("TIUF1IDX",$J,$O(VALMY(0)))) I 'INFO W !," Missing List Manager Data; See IRM",! D PAUSE^TIUFXHLX S VALMBCK="Q" G MDOCX
 S FILEDA=$P(INFO,U,2),NODE0=^TIU(8925.1,FILEDA,0),LINENO=+INFO
 N DIRUT
 ; - Check selected title. Need TIUFXNOD phrase to prevent loop:
 I $$CANT(FILEDA,NODE0) G MDOCX:$D(DIRUT)!(TIUFXNOD["="),AGAINDOC
 S PFILEDA=+$O(^TIU(8925.1,"AD",FILEDA,0)),PLINENO=$P(INFO,U,5)
 S TENDA=$P(INFO,U,6)
 S VALMBCK="R" K DIRUT
 S NEWTLY=$$NEWTITLE(FILEDA,PFILEDA)
 I 'NEWTLY G MDOCX
 D  I 'NEWTLY G MDOCX ;P64 add Are you sure; add CWAD/nonCWAD warning
 . S DIR(0)="Y",DIR("B")="YES",DIR("?")="  Action not reversible if target title already has its own documents."
 . S DIR("A",1)="Moving documents from title",DIR("A",2)="            "_$P(NODE0,U),DIR("A",3)="  to title  "_$P(NEWTLY,U,2)_"."
 . S DIR("A")="    Are you sure"
 . S NPFILEDA=+$O(^TIU(8925.1,"AD",+NEWTLY,0)),CWAD1=$P($G(^TIU(8925.1,NPFILEDA,0)),U,14),CWAD2=$P($G(^TIU(8925.1,PFILEDA,0)),U,14)
 . I (CWAD1="")&(CWAD2'="")!((CWAD1'="")&(CWAD2="")) S DIR("A")="CWADs behave differently from nonCWAD documents. Sure you want to move",DIR("B")="NO",DIR("?")="  CWADs generate alerts; nonCWADs don't."
 . W ! D ^DIR I 'Y S NEWTLY=0
 I $P(NODE0,U,7)'=+^TMP("TIUF",$J,"STATI") D AUTOSTAT^TIUFLF6(FILEDA,NODE0,"INACTIVE")
 S NOLOCK=0 D MDRPOINT(FILEDA,+NEWTLY,PFILEDA,NPFILEDA,.NOLOCK)
 W ! W:NOLOCK "...done.  Please move remaining documents later."
 W:'NOLOCK "...done.  All documents Moved to Title ",$P(NEWTLY,U,2),".",!,"Parent Document Type updated as necessary for all documents."
 W !!,"If you want users to be able to enter more documents on the OLD TITLE,",!,"please reactivate it."
 D PAUSE^TIUFXHLX
 S NPLINENO=+$O(^TMP("TIUF1IDX",$J,"DAF",NPFILEDA,0))
 I NPFILEDA'=PFILEDA D REEXPAND^TIUFHA7(PFILEDA,PLINENO,1)
 D REEXPAND^TIUFHA7(NPFILEDA,NPLINENO,1),VALMBG^TIUFHA7(+NEWTLY,FILEDA,LINENO)
MDOCX I '$G(NEWTLY) W !,"...Nothing moved" H 2 ;P64 add Nothing moved
 S VALM("ENTITY")="Entry"
 Q
 ;
MDRPOINT(OLDTLDA,NEWTLDA,POLDTLDA,PNEWTLDA,NOLOCK) ; Repoint for Move Documents from one title to another: Repoints TITLE and PARENT DOCUMENT TYPE for documents that use old title.
 ; If old and new titles are in same DC, skips repointing PARENT DOCUMENT TYPE.
 N DIE,DR,DA,FILEDA
 W !!,"OLD Title inactivated.  Moving documents..."
 S DR=".01////"_NEWTLDA,DIE=8925
 S:POLDTLDA'=PNEWTLDA DR=DR_";.04////"_PNEWTLDA
 S FILEDA=0 F  S FILEDA=$O(^TIU(8925,"B",OLDTLDA,FILEDA)) Q:'FILEDA  D
 . L +^TIU(8925,FILEDA,0):1 I '$T W !,"...Document can't be locked.  Please move it later. Continuing to move others...",! H 2 S NOLOCK=1 Q
 . S DA=FILEDA D ^DIE
 . W "." L -^TIU(8925,FILEDA,0)
 Q
 ;
NEWTITLE(FILEDA,PFILEDA) ; Function returns DIC's Y=N^S of New Title to move documents to, or 0 if none chosen.
 ;Requires FILEDA = IFN of old Title
 ;Requires PFILEDA = parent of old Title
 N X,Y,DIC,DIR,NEWTLY,TIUFCK,NPFILEDA,GPFILEDA,OVERRIDE
 N SCRN1,SCRN2,SCRN3
 S GPFILEDA=+$O(^TIU(8925.1,"AD",PFILEDA,0)) ; G'parent of old Title
AGAINNEW S DIC=8925.1,DIC(0)="AEMNQZ" K NEWTLY
 W !!,"  Selecting target Title."
 W "  Enter '??' for a list of selectable ones.",!
 W "  You may not select PRF Flag Titles or Titles outside"
 W " the original Class."
 S DIC("A")="Select TIU TITLE NAME to Move documents to: "
 ; - Type=TL, not=old title, not addm title, not PRF title,
 ;   same g'parent (i.e. class):
 S SCRN1="I $P(^(0),U,4)=""DOC""&(Y'=FILEDA)&(Y'=81)"
 S SCRN2="&'$$ISPFTTL^TIUPRFL(Y)&(GPFILEDA="
 S SCRN3="+$O(^TIU(8925.1,""AD"",+$O(^TIU(8925.1,""AD"",Y,0)),0)))"
 S DIC("S")=SCRN1_SCRN2_SCRN3
 D ^DIC I Y=-1 G NEWTLX
 S NEWTLY=Y,NEWTLY(0)=Y(0),NPFILEDA=+$O(^TIU(8925.1,"AD",+NEWTLY,0))
 ;P64 removed "can't move docmts to natl titles"
 I $$HASITEMS^TIUFLF1(+NEWTLY) W !,"   ?? Documents cannot be moved to Titles with Components",! G AGAINNEW
 D CHECK^TIUFLF3(+NEWTLY,NPFILEDA,0,.TIUFCK)
 I 'TIUFCK D
 . W !!,"Faulty Title.  Please TRY Title and correct problems",!,"before moving documents to it."
 . S OVERRIDE=$$OVERRIDE^TIUFHA2("select title even though it is FAULTY")
 . I 'OVERRIDE W "  Documents NOT Moved.",! D PAUSE^TIUFXHLX K NEWTLY
NEWTLX I $D(DTOUT) S VALMQUIT=1
 Q $S($G(NEWTLY):NEWTLY,1:0)
 ;
MTRPOINT(TITLEDA,OLDCLASS) ; Repoint for Move Title from one DC to another:
 ; Repoints PARENT DOCUMENT TYPE to parent of TITLEDA for documents using
 ;title TITLEDA.
 ; If by special arrangement with TIU developers, Title is moved from one
 ;CLASS to another, ALSO resets class xrefs for documents using TITLEDA.
 ;Requires OLDCLASS = IFN of class title was moved FROM. Gets OLDCLASS
 ;from MOVETL, or from UPDATE using ^XTMP("TIUFMOVEN",TITLEDA) = OLDCLASS
 ; Requires TIUFMOVE,^XTMP("TIUFMOVE"[_N]_TLDA,0)
 N DIE,DR,DA,FILEDA,NOLOCK,XDCDA
 I '$O(^TIU(8925,"B",TITLEDA,0)) W !!,"Title has no documents to update.",! Q
 S NOLOCK=0,XDCDA=+$O(^TIU(8925.1,"AD",TITLEDA,0)) I 'XDCDA W !!,"Title has no parent.",! Q
 W !!,"Processing documents that use this Title...",!
 S FILEDA=0 F  S FILEDA=$O(^TIU(8925,"B",TITLEDA,FILEDA)) Q:'FILEDA  D MTRPT1(TITLEDA,FILEDA,XDCDA,+$G(OLDCLASS),.NOLOCK)
 W !,"Done."
 I NOLOCK D   D PAUSE^TIUFXHLX Q
 . W !!,"  Since some documents needing update were (still) not available, please update",!,"them using action 'Update Documents' (again) for this title.",!
 . S ^XTMP("TIUFMOVE"_TIUFMOVE_TITLEDA,"ONCETHRU")=""
 W "  All documents updated for selected Title.",!
 K ^XTMP("TIUFMOVE"_TIUFMOVE_TITLEDA) D PAUSE^TIUFXHLX
 Q
 ;
MTRPT1(TITLEDA,DA,XDCDA,OLDCLASS,NOLOCK) ; Repoint 1 docmt for Move TL.
 ; Requires TITLEDA,DA,XDCDA,TIUFMOVE.  Requires OLDCLASS>or=0.
 ; Kills DA node of ^XTMP("TIUFMOVE[N]"_TLDA if successfully updated.
 I $D(^XTMP("TIUFMOVE"_TIUFMOVE_TITLEDA,"ONCETHRU")),'$D(^XTMP("TIUFMOVE"_TIUFMOVE_TITLEDA,DA)) Q  ;DA already updated
 I TIUFMOVE'="N",XDCDA=$P(^TIU(8925,DA,0),U,4) Q  ; move NOT between CLASSES, Parent Docmt Type already ok.
 L +^TIU(8925,DA,0):1 I '$T W !,"...Document ",DA," can't be locked, not updated.",! S NOLOCK=1 S ^XTMP("TIUFMOVE"_TIUFMOVE_TITLEDA,DA)="" Q
 S DR=".04////"_XDCDA,DIE=8925 D ^DIE
 I OLDCLASS D CLXREF^TIUFHA9(DA,OLDCLASS)
 L -^TIU(8925,DA,0)
 I $G(ACTION)="U" W !,"Document ",DA," updated"
 E  W "."
 K ^XTMP("TIUFMOVE"_TIUFMOVE_TITLEDA,DA)
 Q
 ;
DCDOCMTS(XDCLASS,OLDCLASS) ; Updates CLASS xrefs for documents using DC XDCLASS
 N TENDA,TITLEDA
 S TENDA=0
 F  S TENDA=$O(^TIU(8925.1,XDCLASS,10,TENDA)) Q:'TENDA  D
 . S TITLEDA=+^TIU(8925.1,XDCLASS,10,TENDA,0) Q:'TITLEDA
 . D TLDOCMTS(TITLEDA,OLDCLASS)
 Q
 ;
TLDOCMTS(TITLEDA,OLDCLASS) ; Updates CLASS xrefs for documents using title TITLEDA.
 N DIE,DR,DA,FILEDA,NOLOCK,XDCDA
 I '$O(^TIU(8925,"B",TITLEDA,0)) Q
 ;I '$O(^TIU(8925,"B",TITLEDA,0)) W !!,"Title has no documents to update.",! Q
 ;W !!,"Updating CLASS cross-references for documents that use this Title...",!
 S FILEDA=0 F  S FILEDA=$O(^TIU(8925,"B",TITLEDA,FILEDA)) Q:'FILEDA  D CLXREF^TIUFHA9(FILEDA,OLDCLASS)
 ;W !,"Done."
 W "."
 Q
 ;
