TIUFHA2 ; SLC/MAM - LM Templates A and H Action Copy/Move (COPYMOVE), WHICHTL(CFILEDA,PFILEDA), COPY, OVERRIDE(XDIRA) ;7/28/97  14:02
 ;;1.0;TEXT INTEGRATION UTILITIES;**5,11,27**;Jun 20, 1997
 ;
WHICHTL(CFILEDA,PFILEDA) ; Function returns IFN of TL/CO to add copy Component to, or 0 if none chosen.
 ;Requires CFILEDA = IFN of Copy Component
 ;Requires PFILEDA = parent of original Title or 0 if Title has no parent
 N X,Y,DIC,NEWTLY
 S DIC=8925.1,DIC(0)="AEMNQZ"
 S DIC("A")="Select TIU TITLE or COMPONENT NAME to add Copy to: "
 S DIC("S")="I $P(^(0),U,4)=""DOC""!($P(^(0),U,4)=""CO"")&'$P(^(0),U,13)&'$P(^(0),U,10)&($$ORPHAN^TIUFLF4(Y,^(0))=""NO"")"
 D ^DIC
 I Y=-1 W !!,"Copy left in file as an orphan.  To add it to a Title/Component, use action",!,"Items for the desired Title/Component.",! D PAUSE^TIUFXHLX G WTLX
 S NEWTLY=Y
WTLX I $D(DTOUT) S VALMQUIT=1
 Q $S($G(NEWTLY):NEWTLY,1:0)
 ;
COPYMOVE ; Template H Action Copy/Move, Templates A, J Action Copy
 ; See Description Field of Protocol TIUFHA ACTION COPY for detailed description of actions Copy, Move Title, Move Documents, and Update Documents.
 N DIR,X,Y,DIRUT,DTOUT,ACTION,TIUFFULL,ENTRYNO,FILEDA
 S VALMBCK="",TIUFXNOD=$G(XQORNOD(0))
 I $G(TIUFTMPL)=""!($G(TIUFWHO)="") G CMOVX
 D FULL^VALM1 S TIUFFULL=1 ;must full here for ? help
 I TIUFTMPL="H" D  G:$D(DIRUT) CMOVX S ACTION=Y
 . S ENTRYNO=+$P($P(TIUFXNOD,U,4),"=",2),FILEDA=+$P($G(^TMP("TIUF1IDX",$J,ENTRYNO)),U,2)
 . I $G(^TIU(8925.1,FILEDA,0))="CO" S ACTION="C" Q
 . S DIR("?",1)="Enter 'MT' to Move a Title from one Document Class to another."
 . S DIR("?",2)="Enter 'MD' to Move ALL documents from one Title to another Title."
 . S DIR("?",3)="Enter 'C' to Copy a Title, a Component, or an Object."
 . S DIR("?",4)="Enter 'U' to Update Parent Document Type for Documents of a Certain Title."
 . S DIR("?")="  For details, exit Copy/Move, and enter '??' at the Select Action prompt."
 . S DIR(0)="SB^MT:MOVE TITLE;MD:MOVE DOCUMENTS;C:COPY;U:UPDATE DOCUMENTS",DIR("A")="Select Copy/Move Action",DIR("B")="MT" D ^DIR
 I "AJ"[TIUFTMPL S ACTION="C"
 I TIUFTMPL="H" N DIRUT D  D:ACTION'="U" PAUSE^TIUFXHLX I $D(DIRUT) W "  ...Nothing ",$S(ACTION["M":"Moved",1:"Copied") H 2 G CMOVX
 . I ACTION="C" W !,"WARNING: Entries can be COPIED without affecting the original, but be careful",!,"where you PUT the copy.  Don't touch entries you are not responsible for.",! Q
 . Q:ACTION="U"
 . W !,"WARNING: This action affects inheritance and can CHANGE DOCUMENT BEHAVIOR.  It",!,"DISREGARDS ownership.  It may take awhile if the Title has many documents.",!,"Please use caution and DON'T TOUCH entries you are not responsible for.",!
 I TIUFWHO="N" D OVERWARN
 D COPY:ACTION="C",MOVETL^TIUFHA7:ACTION="MT",MOVEDOC^TIUFHA8:ACTION="MD",UPDATE^TIUFHA7:ACTION="U"
CMOVX I $D(DTOUT) S VALMQUIT=1
 I $G(TIUFFULL) S VALMBCK="R" D RESET^TIUFXHLX
 Q
 ;
COPY ; Copy Title, Component, or Object.
 ; Updates Template A if started there.
 ; Returns TIUFERR=1 if couldn't complete process.
 ; Requires TIUFTMPL.
 ; Requires TIUFWHO, set in Options TIUF/A/C/H EDIT/SORT/CREATE DDEFS CLIN/MGR/NATL.
 N INFO,FILEDA,NODE0,CFILEDA,PFILEDA,PLINENO,NPLINENO
 N MSG,TIUFSHAR,LINENO
 N DTOUT,DIRUT,DIROUT,DUOUT,CNODE0,NPFILEDA,NPNODE0,TIUFI
 N TYPE,DIR,X,Y,TLFILEDA,TLNODE0,NPARENTY,TLLINENO
 S VALM("ENTITY")="Entry to Copy"
AGAINC D EN^VALM2(TIUFXNOD,"SO") G:'$O(VALMY(0)) COPYX S INFO=$G(^TMP("TIUF1IDX",$J,$O(VALMY(0)))) I 'INFO W !!," Missing List Manager Data; See IRM",! D PAUSE^TIUFXHLX S VALMBCK="Q" G COPYX
 S FILEDA=$P(INFO,U,2),NODE0=^TIU(8925.1,FILEDA,0),TIUFSHAR=+$P(NODE0,U,10),LINENO=+INFO
 ; User may enter e.g. "CO=3" and THEN select subaction.  If entry is bad,, user needs to redo CO prompt, not the 3 or it loops:
 I $P(NODE0,U,4)="CL"!($P(NODE0,U,4)="DC") S MSG="    ?? Classes and Document Classes cannot be copied." W !!,MSG,! D PAUSE^TIUFXHLX G COPYX:$D(DIRUT)!(TIUFXNOD["="),AGAINC
 S PFILEDA=+$O(^TIU(8925.1,"AD",FILEDA,0)),PLINENO=+$O(^TMP("TIUF1IDX",$J,"DAF",PFILEDA,0)) ; may be 0 if in template A
 N TIUFCK D CHECK^TIUFLF3(FILEDA,PFILEDA,1,.TIUFCK) G:$D(DTOUT) COPYX K TIUFCK("P") I $D(TIUFCK)>9 W !!,"Faulty entry.  Please TRY entry and correct problems before copying it.",! D PAUSE^TIUFXHLX G COPYX
 S VALMBCK="R" K DIRUT
 L +^TIU(8925.1,FILEDA):1 I '$T W !!,"Another user is editing this entry.",! H 2 G COPYX
 D COPYFDA^TIUFHA5(FILEDA,0,PFILEDA,.CFILEDA,.CNODE0,.VALMCNT)
 S TYPE=$P(NODE0,U,4) S:TYPE="DOC" TYPE="TL" S TYPE=$G(^TMP("TIUF",$J,"TYPE"_TYPE))
 D  D:'$D(DTOUT) PAUSE^TIUFXHLX G:'CFILEDA COPYX
 . I 'CFILEDA W !!,"  ...Not copied" Q
 . I $D(DIRUT) W !!,"  ...Copy deleted" S CFILEDA=0 Q  ;deleted in CP10^TIUFHA5
 . W !!,TYPE_" copied into File Entry #"_CFILEDA
 I $P(NODE0,U,4)="O"!(TIUFTMPL="A") S NPLINENO=0 G MSG ;Don't add to parent from A
 S:'$D(DIRUT) NPARENTY=$S($P(NODE0,U,4)="CO":$$WHICHTL(FILEDA,PFILEDA),$P(NODE0,U,4)="DOC":$$WHICHDC^TIUFHA7(FILEDA,PFILEDA,"C"))
 I '$G(NPARENTY),TYPE="TITLE" D  D PAUSE^TIUFXHLX
 . W !!,"Copy left in file as an orphan.  To add it to a Document Class, use action",!,"Items for the desired Document Class.  Please test it thoroughly after adding it",!,"since its inheritance may have changed.",!
 I '$G(NPARENTY) G COPYX
 S NPFILEDA=+NPARENTY,NPLINENO=+$O(^TMP("TIUF1IDX",$J,"DAF",NPFILEDA,0)) ;NPLINENO may be 0
 ; If copy is a component, get the Title ancestor of the new parent, (or new parent itself if new parent is a Title), and inactivate this Title and its descendants:
 I $P(NODE0,U,4)="CO" D
 . N DA,DIK,TENDA
 . S NPNODE0=^TIU(8925.1,NPFILEDA,0),TLFILEDA=NPFILEDA,TLNODE0=NPNODE0
 . I $P(NPNODE0,U,4)'="DOC" N ANCESTOR D ANCESTOR^TIUFLF4(NPFILEDA,NPNODE0,.ANCESTOR,1) S TIUFI=$O(ANCESTOR(100),-1),TLFILEDA=ANCESTOR(TIUFI),TLNODE0=^TIU(8925.1,TLFILEDA,0)
 . L +^TIU(8925.1,TLFILEDA):1 I '$T W !!,"Another user is editing parent Title.  Copy deleted. Please try again later.",! H 2 D  Q
 . . S DIK="^TIU(8925.1,",TENDA=0 F  S TENDA=$O(^TIU(8925.1,CFILEDA,10,TENDA)) Q:'TENDA  S DA=+$G(^TIU(8925.1,CFILEDA,10,TENDA,0)) I DA,'$P(^TIU(8925.1,DA,0),U,10) D ^DIK
 . . S DA=CFILEDA D ^DIK
 . I $P(TLNODE0,U,7)'=+^TMP("TIUF",$J,"STATI") D AUTOSTAT^TIUFLF6(TLFILEDA,TLNODE0,"INACTIVE")
 D ADDTEN^TIUFLF4(NPFILEDA,CFILEDA,CNODE0,"") ;Add Copy to new parent
 I $P(CNODE0,U,4)="CO" W !,"Inactivating Title ",$P(TLNODE0,U)
 W !,"Copy added to ",$P(NPARENTY,U,2),!
MSG I $P(CNODE0,U,4)="DOC" D
 . I TIUFTMPL="A" W !,"You will need to add the copy to a Document Class in the hierarchy and activate",!,"it before it can be used.  Use DETAILED DISPLAY for the Document Class, ITEMS,",!,"ADD/CREATE, and enter the name of the copy.",! Q
 . I NPFILEDA=PFILEDA W !,"Copies are created inactive.  Please activate the copy Title when it is ready",!,"for users to enter documents on it.",! Q
 . W !,"Adding the copy Title to a different Document Class may change its behavior",!,"from that of the original.  Adding it to a different CLASS may change it",!,"RADICALLY.  Please test the copy thoroughly before activating it.",!
 I $P(CNODE0,U,4)="CO" D
 . I $D(TLNODE0) W !,"Please test the Title ",$P(TLNODE0,U),!,"and reactivate it when it is ready for users to enter documents on it.",!
 . I TIUFTMPL="A" W !!,"You will need to add the copy to a Title in the hierarchy before it can be used.",!,"Use DETAILED DISPLAY for the Title, ITEMS, ADD/CREATE, and enter the name of",!,"the copy.",!
 I 'NPLINENO,TIUFTMPL="H" W !,"You will have to expand the hierarchy to see the Copy in its new position.",!
 I $P(CNODE0,U,4)="O" W !,"Please test the copy object and activate it when it is ready for users to embed",!,"it in boilerplate text.",!
 D PAUSE^TIUFXHLX W !
 I TIUFTMPL="H",NPLINENO D
 . I $P(CNODE0,U,4)="CO" S TLLINENO=+$O(^TMP("TIUF1IDX",$J,"DAF",TLFILEDA,0)) D REEXPAND^TIUFHA7(TLFILEDA,TLLINENO,1) Q
 . D REEXPAND^TIUFHA7(NPFILEDA,NPLINENO,1)
 ; Templates A, J updated for copy already in COPYFDA.
 D VALMBG^TIUFHA7(CFILEDA,FILEDA,LINENO)
COPYX I $D(DTOUT) S VALMBCK="Q"
 L -^TIU(8925.1,+$G(FILEDA)) S VALM("ENTITY")="Entry"
 Q
 ;
OVERRIDE(XDIRA) ; function returns 1 if natl programmer, wants to override safeguards
 ;Requires XDIRA = DIR("A") Requires TIUFWHO
 N OVERRIDE,DIR,Y
 S OVERRIDE=0,DIR("A")=XDIRA
 I TIUFWHO'="N" G OVERX
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A",1)="Want to override safeguards and"
 I $G(TIUFXNOD)["Add" S DIR("A",1)="Selecting (another) item to add:  "_DIR("A",1)
 D ^DIR
 I Y S OVERRIDE=1
OVERX Q OVERRIDE
 ;
OVERWARN ;Warn re override
 W !,"WARNING: As a National Programmer, you are permitted to override safeguards",!,"when moving entries and when adding/deleting items. Please do NOT override"
 W !,"safeguards except as a last resort, and then only after thoroughly testing the",!,"actions you plan to take.",!
 Q
