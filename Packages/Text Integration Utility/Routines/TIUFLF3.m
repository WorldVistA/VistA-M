TIUFLF3 ; SLC/MAM - Library; File 8925.1 Related: CHECK(FILEDA,PFILEDA,DETAILS,MSGARRAY), DESCCK(FILEDA), OBJECT 8/28/97  18:20
 ;;1.0;TEXT INTEGRATION UTILITIES;**2,5,12,13,17**;Jun 20, 1997
 ;
CHECK(FILEDA,PFILEDA,DETAILS,MSGARRAY) ; Module Checks Docmt Def FILEDA for completeness/correctness.
 ; If FILEDA is a TITLE, check includes completeness/correctness check of DESCENDANT COMPONENTS.
 ; If FILEDA is a TITLE or COMPONENT, check includes check of BOILERPLATE TEXT of entry/Descendants.
 ; Requires FILEDA.
 ; If FILEDA has an actual or prospective parent (as in Create, Add
 ;Items), requires PFILEDA to check if entry Type is right, given
 ;parent, to NOT set Orphan if it has a prospective parent, to check
 ;inheritance, etc.
 ; Sets MSGARRAY
 ; MSGARRAY=1 if OK;
 ;          0[^First Reason Whynot] if Not OK - Used in msgs like 'Can't Add Item:','Status limited to I:'
 ; If +MSGARRAY=0 then MSGARRAY(subscript)=WHYNOT as in CHECK("F") etc.
 ; Requires DETAILS:
 ;  = 1 for yes if want all the subscripted problem msgs
 ;    0 for no if want only to know if good or bad ie first msg is enough
 ;
 ; NOTE: if you add a new subscript here, be sure to add it also in
 ;rtn TIUFHA6, which writes it out when user TRIES entry.
 ;
 N NODE0,WHYNOT,TYPE,POSSTYPE,LP,LC,POSSSTAT,PARENT,MSG,NODE6,NODE61
 N ICUSTOM,TIUFI,MISSITEM,CHECK,SHARED,VALUE
 S CHECK("F")="Does not Exist in File"
 S CHECK("I")="Has Nonexistent Item; See IRM"
 S CHECK("T")="No Type/Wrong Type"
 S CHECK("C")="Shared; Not Component"
 S CHECK("B")="Personal AND Class Owners"
 S CHECK("O")="No Owner"
 S CHECK("S")="No Status/Wrong Status for Type" ;For nonshared entries
 S CHECK("J")="No Object Method"
 F LETTER="N","A","P" S CHECK("J"_LETTER)="Ambiguous.  Object "_$S(LETTER="N":"Name",LETTER="A":"Abbreviation",1:"Print Name")_" could be any of several objects."
 S CHECK("P")="Orphan"
 S CHECK("M")="Multiple Parents" ;For nonshared entries
 S CHECK("U")="Unshared, with Shared Parent"
 ; For subscripts OBJ and OBJINACT see rtn TIUFLX.
 S CHECK("A")="Natl with NonNatl Ancestor" ;For nonshared entries
 S CHECK("E")="No Edit Template" ; Set only if entry is Title, is/will be in hierarchy, has no explicit value, has/will have no inherited value.
 S CHECK("R")="No Print Method" ; see E
 S CHECK("V")="No Visit Linkage Method" ; see E
 S CHECK("D")="No Validation Method" ; see E
 S CHECK("H")="No Print Form Header" ; Set only if entry is Title, is/will be in hierarchy, has no explicit value, has/will have no inherited value, and if entry's DC allows Custom Form Headers.
 S CHECK("N")="No Print Form Number" ; see H
 S CHECK("G")="No Print Group" ; see H
 ; For subscript DESC see DESCCK
 S NODE0=$G(^TIU(8925.1,+FILEDA,0)) I NODE0="" D SET("F") G CHECX
 S MISSITEM=$$MISSITEM^TIUFLF4(FILEDA)
 I MISSITEM D SET("I") Q:'DETAILS
 S PFILEDA=+$G(PFILEDA) S POSSTYPE=$$POSSTYPE^TIUFLF7(PFILEDA) G:$D(DTOUT) CHECX
 S TYPE=$P(NODE0,U,4) I TYPE=""!(POSSTYPE'[(U_TYPE_U)) D SET("T") Q:'DETAILS
 S SHARED=$P(NODE0,U,10) I SHARED,TYPE'="CO" D SET("C") Q:'DETAILS
 S LP=$L($P(NODE0,U,5)),LC=$L($P(NODE0,U,6))
 I LP&LC D SET("B") Q:'DETAILS
 I 'LP&'LC D SET("O") Q:'DETAILS
 I '$P(NODE0,U,7),'$P(NODE0,U,10) D SET("S") Q:'DETAILS
 I $P(NODE0,U,7),'$P(NODE0,U,10) S POSSSTAT=$$POSSSTAT^TIUFLF5(TYPE) I POSSSTAT'[$E($$STATWORD^TIUFLF5($P(NODE0,U,7))) D SET("S") Q:'DETAILS
 I TYPE="O" D OBJECT G CHECX
 I 'PFILEDA!$P(NODE0,U,13) N ANCESTOR D ANCESTOR^TIUFLF4(FILEDA,NODE0,.ANCESTOR)
 I 'PFILEDA,$$ORPHAN^TIUFLF4(FILEDA,NODE0)="YES" D SET("P") Q:'DETAILS
 S PARENT=+$O(^TIU(8925.1,"AD",FILEDA,0))
 I $O(^TIU(8925.1,"AD",FILEDA,PARENT)),'$P(NODE0,U,10) D SET("M") Q:'DETAILS
 I '$P(NODE0,U,10),$P($G(^TIU(8925.1,PARENT,0)),U,10) D SET("U") Q:'DETAILS
 ; Check Btext.  If problem, set MSGARRAY("OBJ").  If FIRST problem, set
 ;MSGARRAY=0^Bad/Inactive Object in Boilerplate Text:
 I $$HASBOIL^TIUFLF(FILEDA,NODE0) D XCHECK^TIUFLX(FILEDA,1,DETAILS,.MSGARRAY),DCHECK^TIUFLX(FILEDA,1,DETAILS,.MSGARRAY) I 'DETAILS,$D(MSGARRAY) G CHECX
 I $P(NODE0,U,13),'$P(NODE0,U,10) D  I 'DETAILS,$D(MSGARRAY) G CHECX
 . S TIUFI=0
 . F  S TIUFI=$O(ANCESTOR(TIUFI)) Q:'TIUFI  I '$P(^TIU(8925.1,ANCESTOR(TIUFI),0),U,13) D SET("A") Q
 ; If Title, NOT an ADDENDUM, must have flds 5-8. Ignore for entries remaining orphans:
 I TYPE="DOC",FILEDA'=81,'$D(MSGARRAY("P")) D
 . I $G(^TIU(8925.1,FILEDA,5))="" D INHERIT^TIUFLD(FILEDA,PFILEDA,5,"","","",.VALUE) I VALUE="" D SET("E") Q:'DETAILS
 . I $G(^TIU(8925.1,FILEDA,6))="" D INHERIT^TIUFLD(FILEDA,PFILEDA,6,"","","",.VALUE) I VALUE="" D SET("R") Q:'DETAILS
 . I $G(^TIU(8925.1,FILEDA,7))="" D INHERIT^TIUFLD(FILEDA,PFILEDA,7,"","","",.VALUE) I VALUE="" D SET("V") Q:'DETAILS
 . I $G(^TIU(8925.1,FILEDA,8))="" D INHERIT^TIUFLD(FILEDA,PFILEDA,8,"","","",.VALUE) I VALUE="" D SET("D") Q:'DETAILS
 . ; If TL, NOT Addendum, check for flds 6.1, 6.12, 6.13;
 . ;6.14 will be there, it's set to 1 for Clinical Documents.
 . S NODE61=$G(^TIU(8925.1,FILEDA,6.1))
 . D INHERIT^TIUFLD(FILEDA,PFILEDA,6.14,"","","",.ICUSTOM)
 . ; If parent Allows Custom Hdrs, then Require 6.1/6.12/6.13 (can be inherited):
 . Q:'ICUSTOM
 . I $P(NODE61,U)="" D INHERIT^TIUFLD(FILEDA,PFILEDA,6.1,"","","",.VALUE) I VALUE="" D SET("H") Q:'DETAILS
 . I $P(NODE61,U,2)="" D INHERIT^TIUFLD(FILEDA,PFILEDA,6.12,"","","",.VALUE) I VALUE="" D SET("N") Q:'DETAILS
 . I $P(NODE61,U,3)="" D INHERIT^TIUFLD(FILEDA,PFILEDA,6.13,"","","",.VALUE) I VALUE="" D SET("G") Q:'DETAILS
CHECX Q:$D(DTOUT)
 I $D(MSGARRAY) Q  ;bad entry or bad descendant or bad btext
 I TYPE="DOC"!(TYPE="CO") D DESCCK(FILEDA,.MSGARRAY) I $D(MSGARRAY) Q
 S MSGARRAY=1
 Q
 ;
DESCCK(FILEDA,MSGARRAY) ; Module Checks FILEDA Components for correctness/completeness.
 ; Requires FILEDA, MSGARRAY from CHECK.
 ; If some descendant has problem, sets MSGARRAY("DESC"), and MSGARRAY=
 ;0^Entry has Faulty Descendant.
 ; Ignores descendant boilerplate text problems since they are already
 ;caught for original entry.
 N TIUI,IFILEDA,DESCCK
 S TIUI=0
 F  S TIUI=$O(^TIU(8925.1,FILEDA,10,TIUI)) Q:'TIUI  D  Q:'DESCCK
 . S IFILEDA=+^TIU(8925.1,FILEDA,10,TIUI,0)
 . D CHECK(IFILEDA,FILEDA,0,.DESCCK)
 . I 'DESCCK S MSGARRAY("DESC")="Entry has Faulty Descendant",MSGARRAY="0^"_MSGARRAY("DESC") I "MN"[TIUFWHO S MSGARRAY("DESC")=MSGARRAY("DESC")_" IFN "_IFILEDA
 Q
 ;
OBJECT ; Set MSGARRAY for objects (subscripts J; JN,JA,JP if DETAILS)
 ; Needs variables from CHECK
 N TIUFI,NAP,LETTER,XREF,OFILEDA ; NAP is for NAME/ABBREV/PRINTNAME
 I $G(^TIU(8925.1,FILEDA,9))="" D SET("J")
 I 'DETAILS Q  ;Ignore ambiguity here, ambiguity done in TIUFLX
 F TIUFI=1:1:3 S NAP=$P(NODE0,U,TIUFI) Q:NAP=""  D
 . S LETTER=$S(TIUFI=1:"N",TIUFI=2:"A",1:"P")
 . F XREF="B","C","D" D
 . . S OFILEDA=0 F  S OFILEDA=$O(^TIU(8925.1,XREF,NAP,OFILEDA)) Q:'OFILEDA  D  Q:$D(MSGARRAY("J"_LETTER))
 . . . Q:'$D(^TIU(8925.1,"AT","O",OFILEDA))
 . . . I OFILEDA'=FILEDA D SET("J"_LETTER)
 Q
 ;
SET(SUBS) ; Sets MSGARRAY
 ; Requires vars from CHECK
 S MSGARRAY(SUBS)=CHECK(SUBS) I $G(MSGARRAY)="" S MSGARRAY=0_U_MSGARRAY(SUBS)
 Q
