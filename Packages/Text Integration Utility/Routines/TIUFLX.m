TIUFLX ; SLC/MAM - Library; Template X (Boilerplate Text) Related: XCHECK(FILEDA,SILENT,DETAILS,MSGARRAY), DCHECK(FILEDA,SILENT,DETAILS,MSGARRAY) ;8/28/97  11:02
 ;;1.0;TEXT INTEGRATION UTILITIES;**5**;Jun 20, 1997
 ;
AMBIG ; Object AS EMBEDDED is ambiguous.  Sets subscript OBJ, writes msg.
 ; Differs from object ITSELF is ambiguous, since checks only embed name.
 ; Needs vars from XCHECK.
 D SET("OBJ")
 I 'SILENT D  D PAUSE^TIUFXHLX
 . W !!!,"Object |",OBJNM,"| is ambiguous.",!,"It could be any of SEVERAL objects.  Please contact IRM.",!
 Q
 ;
XCHECK(FILEDA,SILENT,DETAILS,MSGARRAY) ; Checks objects in FILEDA's boilerplate text.
 ; Silent if SILENT=1.  Writes problem msgs for each bad object if SILENT=0.
 ; Called silent by CHECK^TIUFLF3. Called not silent by CHECKDEF^TIUFHA6.
 ; Requires SILENT = 1 if silent.
 ; Sets MSGARRAY("OBJ"),MSGARRAY("OBJINACT").
 N TIUFJ,LINE,PIECE,OBJNM,OFILEDA,XREF,ARR,SUBS
 S SILENT=+$G(SILENT)
 I 'SILENT,$G(TIUFSTMP)="D",FILEDA=$P(TIUFINFO,U,2) W !!!,"Faulty Entry: Bad/Inactive Object in Boilerplate Text:",! D PAUSE^TIUFXHLX G:$D(DIRUT) XCHEX ; TIUFINFO: Don't rewrite msg for descendants.
 S TIUFJ=0 F  S TIUFJ=$O(^TIU(8925.1,FILEDA,"DFLT",TIUFJ)) Q:'TIUFJ  K DIRUT D  G:$D(DIRUT) XCHEX I SILENT,$D(MSGARRAY("OBJ")) G XCHEX
 . S LINE=$G(^TIU(8925.1,FILEDA,"DFLT",TIUFJ,0))
 . I LINE["|" D
 . . I ($L(LINE,"|")+1)#2 W:'SILENT !!!,"Object split between lines, rest of line not checked:",!,LINE,! D:'SILENT PAUSE^TIUFXHLX D SET("OBJ") Q
 . . F PIECE=2:2:$L(LINE,"|") S OBJNM=$P(LINE,"|",PIECE) K DIRUT,ARR D  Q:$D(DIRUT)  I SILENT,$D(MSGARRAY("OBJ")) Q
 . . . I OBJNM="" W:'SILENT !!!,"Brackets are there, but there's no name inside: ||",! D:'SILENT PAUSE^TIUFXHLX D SET("OBJ") Q
 . . . K ARR
 . . . F XREF="B","C","D" D  I $O(ARR($O(ARR(0)))) D AMBIG Q
 . . . . S OFILEDA=0 F  S OFILEDA=$O(^TIU(8925.1,XREF,OBJNM,OFILEDA)) Q:'OFILEDA  S:$D(^TIU(8925.1,"AT","O",OFILEDA)) ARR(OFILEDA)="" I $O(ARR($O(ARR(0)))) Q
 . . . I $O(ARR($O(ARR(0)))) Q
 . . . I '$D(ARR) D  Q
 . . . . W:'SILENT !!!,"Object |",OBJNM,"| cannot be found in the file.",!,"Use uppercase and use object's exact name, print name, or abbreviation.",!,"Object's name/print name/abbreviation may have changed since this was embedded.",!
 . . . . D:'SILENT PAUSE^TIUFXHLX D SET("OBJ")
 . . . S DETAILS=$S(SILENT:0,1:1),OFILEDA=$O(ARR(0)) N OBJCK D CHECK^TIUFLF3(OFILEDA,0,DETAILS,.OBJCK)
 . . . I 'OBJCK D SET("OBJ") I 'SILENT D  Q:$D(DIRUT)
 . . . . F SUBS="F","T","O","S","J" D  Q:$D(DIRUT)
 . . . . . I $D(OBJCK(SUBS)) W !!!,"Object |",OBJNM,"| is faulty: ",!,OBJCK(SUBS),".",! D PAUSE^TIUFXHLX Q:$D(DIRUT)
 . . . I '$D(^TIU(8925.1,"AS",+^TMP("TIUF",$J,"STATA"),OFILEDA)) D SET("OBJINACT") I 'SILENT W !!!,"Object |",OBJNM,"| is not active.",! D PAUSE^TIUFXHLX
XCHEX I $D(DTOUT) S VALMQUIT=1
 Q
 ;
SET(SUBS) ; Set MSGARRAY("OBJ"), MSGARRAY("OBJINACT")
 ; Needs vars from XCHECK.
 I SUBS="OBJ" S MSGARRAY("OBJ")="Bad Object in Boilerplate Text."
 I SUBS="OBJINACT" S MSGARRAY("OBJINACT")="Boilerplate Text has Inactive Object."
 I $G(MSGARRAY)="" S MSGARRAY="0^Bad/Inactive Object in Boilerplate Text"
 Q
 ;
DCHECK(FILEDA,SILENT,DETAILS,MSGARRAY) ; Checks Btext for FILEDA descendants.
 N TIUFITEM,TIUFI,MISSITEM,ITENDA,IFILEDA
 S MISSITEM=$$MISSITEM^TIUFLF4(FILEDA),SILENT=+$G(SILENT)
 I MISSITEM W !!,"Corrupt Database: File Entry "_FILEDA_" Has Nonexistent Item "_MISSITEM_" ; See IRM",! D PAUSE^TIUFXHLX G DCHEX
 D ITEMS^TIUFLT(FILEDA)
 S TIUFI=0
 F  S TIUFI=$O(TIUFITEM(TIUFI)) Q:'TIUFI  D
 . S ITENDA=$P(TIUFITEM(TIUFI),U,2)
 . S IFILEDA=+$G(^TIU(8925.1,FILEDA,10,+ITENDA,0))
 . K DIRUT D XCHECK(IFILEDA,SILENT,DETAILS,.MSGARRAY) Q:$D(DIRUT)  D DCHECK(IFILEDA,SILENT,DETAILS,.MSGARRAY)
DCHEX Q
 ;
