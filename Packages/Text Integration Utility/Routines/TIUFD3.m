TIUFD3 ; SLC/MAM - LM Template D Actions Edit Items, Edit Boilerplate Text ;4/17/97  11:02
 ;;1.0;TEXT INTEGRATION UTILITIES;**17**;Jun 20, 1997
 ;
EDITEMS ; Templates H, C, A, D Action Edit Items. Calls LM Template TIUFT.
 ; Requires TIUFTMPL.
 ; Requires TIUFWHO, set in Options TIUF/A/C/H EDIT/SORT/CREATE DDEFS CLIN/MGR/NATL.
 ; Sets TIUFACTT for Subtemplate T. Sets TIUFSTMP = T.
 I $G(TIUFSTMP)="D" G EDITEMS1
 N TIUFINFO,TIUFNOD0,TIUFVCN1,MISSITEM,TIUFXNOD,DTOUT,DIRUT,DIROUT
 S VALMBCK="",TIUFVCN1=VALMCNT,TIUFXNOD=$G(XQORNOD(0))
 I TIUFXNOD'["=" W !!," You may edit the Items of ONE Entry.  Please select an Entry from the List.",!!
 D EN^VALM2(TIUFXNOD,"SO") Q:'$O(VALMY(0))  S TIUFINFO=$G(^TMP("TIUF1IDX",$J,$O(VALMY(0)))) I 'TIUFINFO W !!," Missing List Manager Data; See IRM",! D PAUSE^TIUFXHLX S VALMBCK="Q" G EDITX
 S FILEDA=$P(TIUFINFO,U,2),MISSITEM=$$MISSITEM^TIUFLF4(FILEDA) I MISSITEM W !!," Can't Edit Items: File Entry "_FILEDA_" Has Nonexistent Item "_MISSITEM_" ; See IRM.",! D PAUSE^TIUFXHLX S VALMBCK="Q" G EDITX
 D PARSE^TIUFLLM(.TIUFINFO)
 D NODE0ARR^TIUFLF(TIUFINFO("FILEDA"),.TIUFNOD0) G:$D(DTOUT) EDITX
EDITEMS1 ; Entry point called by Edit Items of Template D.
 ; Requires CURRENT array TIUFINFO, CURRENT variable TIUFVCN1
 ;as set in EDVIEW^TIUFHA, updated (if Template A has changed) 
 ;in AUPDATE^TIUFLA1, or (if Template H has changed) in UPDATE^TIUFLLM1.
 ;WARNING: +TIUFINFO may = 0 if Template A has changed!
 ; Requires array TIUFNOD0; Updates TIUFNOD0 upon return from Template T.
 ; If called from D, requires TIUFILIN as set in DSITEMS^TIUFD.
 ; If called from D, requires TIUFSTMP="D"
 N SUBTEMPL
 S SUBTEMPL=$G(TIUFSTMP)
 S VALMBCK=""
 N FILEDA,TYPE,STATUS,MSG,SHARED,USROWNS
 S FILEDA=TIUFINFO("FILEDA"),TYPE=$P(TIUFNOD0,U,4),SHARED=$P(TIUFNOD0,U,10)
 S USROWNS=$$PERSOWNS^TIUFLF2(FILEDA,DUZ)
 I TIUFWHO="C",'$$HASITEMS^TIUFLF1(FILEDA) D  I $D(MSG) G EDITX
 . I USROWNS Q:TYPE="DOC"  Q:TYPE="CO"&'SHARED
 . S MSG=" Entry has no Items",VALMBCK=""
 I TYPE="O" S MSG=" Objects do not have Items",VALMBCK="" G EDITX
 N TIUREC,TIUFVCN3,TIUFBG3,TIUFSTMP,TIUFACTT,TIUFIXED,EXPAND
 S TIUFSTMP="T" ;Items
 S TIUFACTT=$S("NM"[TIUFWHO:"A",TIUFWHO="C":"E",1:"V") ;Add, Edit, View
 S STATUS=$$STATWORD^TIUFLF5($P(TIUFNOD0,U,7)) ; e.g. INACTIVE
 D
 . I TYPE="" S TIUFACTT="V",MSG=" Entry has no Type; View Only" Q
 . I SHARED,TIUFTMPL'="A" S TIUFACTT="V",MSG=" Shared Components can be edited only through the SORT Option: View Only." Q
 . I 'SHARED,TYPE="DOC"!(TYPE="CO"),STATUS'="INACTIVE" S TIUFACTT="V",MSG=" Can't edit Items of a Title/Component unless entry is Inactive; View Only." Q
 . I SHARED,'$$CANEDIT^TIUFLF6(FILEDA) S TIUFACTT="V",MSG=" Shared Component with parent that isn't Inactive; View Only." Q
 . I USROWNS="" S TIUFACTT="V",MSG=" Entry has no Owner; View Only" Q
 . I USROWNS=0,TIUFWHO="C" S TIUFACTT="V",MSG=" Non-Owner; View Only" Q
 . I USROWNS=0,TIUFWHO'="C",SHARED S TIUFACTT="V",MSG=" Only the Owner can edit a Shared Component; View Only"
 K DIRUT I $D(MSG) W !!,MSG,! D PAUSE^TIUFXHLX K MSG I $D(DIRUT) Q
 ; If came from Template H rather than A AND If Edited Items directly from H rather than thru Edit/View (D), AND If H entry was expanded, then collapse entry (reexpand to items only when return):
 I TIUFTMPL="H",SUBTEMPL'="D" S EXPAND=TIUFINFO("XPDLCNT") I EXPAND D COLLAPSE^TIUFH1(.TIUFINFO) S VALMCNT=VALMCNT-EXPAND
 S TIUFVCN3=VALMCNT,TIUFBG3=VALMBG,TIUFIXED=$G(VALM("FIXED"))
 I TIUFACTT="A" D
 . I "NM"[TIUFWHO D EN^VALM("TIUFT ITEMS ADD/EDIT/VIEW MGR")
 D:TIUFACTT="E" EN^VALM("TIUFT ITEMS EDIT/VIEW CLIN")
 D:TIUFACTT="V" EN^VALM("TIUFT ITEMS VIEW MGR/CLIN")
 S VALMCNT=TIUFVCN3,VALMBG=TIUFBG3
 D NODE0ARR^TIUFLF(FILEDA,.TIUFNOD0) G:$D(DTOUT) EDITX
 ; If came from Template H rather than A AND If Edited Items directly from H rather than thru Edit/View (D), then update + for H and If H entry was expanded, reexpand to items only:
 I TIUFTMPL="H",SUBTEMPL'="D" D
 . ;Since Template is H, then need +.  If 'Expand, just update +:
 . I 'EXPAND  S TIUREC=^TMP("TIUF1",$J,+TIUFINFO,0),TIUREC=$$PLUSUP^TIUFLLM(.TIUFINFO,TIUREC),^TMP("TIUF1",$J,+TIUFINFO,0)=TIUREC
 . ;If Expand, that will automatically update + for template H:
 . I EXPAND D EXPAND1^TIUFH1(.TIUFINFO) S VALMCNT=VALMCNT+$P(TIUFINFO,U,3)
 ; Edit Items affects parentage: if came from Template A and sort by parentage, redo all of A:
 I TIUFTMPL="A" D:$E(TIUFATTR)="P" INIT^TIUFA G:$D(DTOUT) EDITX
 ; If not sort by parentage, don't update A here: Template A has been updated with each change to Template T.
 I SUBTEMPL="D" D DSITEMS^TIUFD(.TIUFILIN) S VALMCNT=TIUFILIN ;Update Items to end on Template D.
 S VALMBCK="R"
EDITX ;
 I $D(MSG) W !!,MSG,! H 2
 I $D(DTOUT) S VALMBCK="Q"
 Q
 ;
EDBOILTX ;Templates D, X Action Edit Boilerplate Text
 ; Requires CURRENT arrays TIUFINFO, TIUFNOD0.
 ; Requires TIUFBLIN as set in DSBOILTX^TIUFD.
 N FILEDA,LINENO,CNTCHNG,TIUFXNOD,MSG,STATUS,DTOUT,DIRUT,DIROUT
 S FILEDA=TIUFINFO("FILEDA")
 S VALMBCK="R",TIUFXNOD=$G(XQORNOD(0))
 S STATUS=$$STATWORD^TIUFLF5($P(^TIU(8925.1,FILEDA,0),U,7))
 I STATUS'="INACTIVE" W !!,"Entry is not Inactive: Can't edit Boilerplate Text" D PAUSE^TIUFXHLX S VALMBCK="" G EDBOX
 I $P(TIUFNOD0,U,10) D  G:$D(MSG) EDBOX
 . I '$$PERSOWNS^TIUFLF2(FILEDA,DUZ) S MSG="  Shared Component: Only Owner can Edit Boilerplate Text"
 . I '$$CANEDIT^TIUFLF6(FILEDA) S MSG="  Shared Component with parent that isn't Inactive: Can't Edit Boilerplate Text"
 . I $D(MSG) W !!,MSG D PAUSE^TIUFXHLX S VALMBCK=""
 I TIUFSTMP="X" L +^TIU(8925.1,FILEDA):1 I '$T W !!," Another user is editing this entry.",! H 2 G EDBOX
 D EDBOIL^TIUFLD1(FILEDA,TIUFNOD0) G:$D(DTOUT) EDBOX
 D DEDBOIL^TIUFLD1(FILEDA) G:$D(DTOUT) EDBOX
 D NODE0ARR^TIUFLF(FILEDA,.TIUFNOD0) G:$D(DTOUT) EDBOX
 ; Update template D or X:
 S LINENO=TIUFBLIN D DSBOILTX^TIUFD(.LINENO) G:$D(DTOUT) EDBOX S VALMCNT=LINENO
 I TIUFTMPL="A" D AUPDATE^TIUFLA1(TIUFNOD0,FILEDA,.CNTCHNG) S:CNTCHNG TIUFVCN1=TIUFVCN1-1 ;doesn't match.
 I "HC"[TIUFTMPL D LINEUP^TIUFLLM1(.TIUFINFO,TIUFTMPL)
EDBOX ;
 I TIUFSTMP="X" L -^TIU(8925.1,+$G(FILEDA))
 I $D(DTOUT) S VALMBCK="Q"
 Q
 ;
