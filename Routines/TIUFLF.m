TIUFLF ; SLC/MAM - Library; File 8925.1 Related: NODE0ARR(FILEDA,NODE0,PFILEDA), HASBOIL(FILEDA,NODE0), DDEFUSED(FILEDA), DESCUSED(FILEDA) ;10/24/95  23:35
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
 ;
HASBOIL(FILEDA,NODE0) ;Function Returns 0, 1, 10, or 11 (like $D) if FILEDA/any descendant has Boilerplate Text, or NA if nonapplicable (neither DOC nor CO).
 ; Requires FILEDA, NODE0.
 N ANS,ANSONE,ANSTEN
 I $P(NODE0,U,4)'="DOC"&($P(NODE0,U,4)'="CO") S ANS="NA" G HASBX
 S ANSONE=+$O(^TIU(8925.1,FILEDA,"DFLT",0)) S:ANSONE ANSONE=1
 S ANSTEN=$$DHASBOIL(FILEDA)
 S ANS=ANSTEN_ANSONE
 I ANS="00" S ANS=0
 I ANS="01" S ANS=1
HASBX Q ANS
 ;
DHASBOIL(FILEDA) ; Function Returns 1 if any descendant has Boilerplate Text.
 ; Requires FILEDA.
 N TIUI,IFILEDA,ANS
 I '$G(FILEDA) S ANS="ERR" G DHASX
 S (TIUI,ANS)=0
 F  S TIUI=$O(^TIU(8925.1,FILEDA,10,TIUI)) G:'TIUI!ANS DHASX  D
 . S IFILEDA=+^TIU(8925.1,FILEDA,10,TIUI,0)
 . I $D(^TIU(8925.1,IFILEDA,"DFLT")) S ANS=1 Q
 . S ANS=$$DHASBOIL(IFILEDA)
 . Q
DHASX Q ANS
 ;
NODE0ARR(FILEDA,NODE0,PFILEDA) ; Sets NODE0 = ^TIU(8925.1,FILEDA,0)_U_PIECE20, where
 ;PIECE20= 0,1,10,11 if FILEDA/any descendant has Boilerplate text
 ;(Like $D), or NA.
 ; IF NODE0 IS NOT NULL, Passes back NODE0 as an array. If NODE0 is null,
 ;doesn't set subscripts, writes warning.
 ; When return from this call, if FILEDA is not already on the screen but taken from an item multiple, a name xfef, etc, check for NODE0="".  This will catch broken pointers to 8925.1.
 ; Sets Subscript TYPE = Stnd Abbrev = ^TMP("TIUF",$J,"TYPE"_INTERNALTYPE)). See TIUFL.
 ; Sets Subscripts COWNER, STATUS = Mixed case(external value);
 ; Sets Subscript POWNER = external value;
 ; Sets Subscript NATL= Yes, or No;
 ; Sets Subscript SHARE = Yes, No, or "" for NA;
 ; Sets Subscript ORPHAN = Yes, No, or "" for NA (Object);
 ; Sets Subscript ITEMS = Yes, No, or "" for NA (Object);
 ; Sets Subscript BOILPT = Yes if entry or descendants have Boiltxt, No, or "" for NA (Type not Doc or CO);
 ; Sets Subscript INUSE = Yes, No, ?, or "" for NA (Object).
 ; Requires FILEDA = file 8925.1 IFN of 8925.1 entry.
 ; Optional PFILEDA = parent IFN of FILEDA. Used for Computed Field .08 In Use for EN^DIQ.
 S NODE0=$G(^TIU(8925.1,FILEDA,0))
 I '$D(PFILEDA) S PFILEDA=0
 I PFILEDA,NODE0="" W !!," File entry "_PFILEDA_" has Nonexistent Item "_FILEDA_"; See IRM.",! D PAUSE^TIUFXHLX G NODEX
 I NODE0="" W !!," ",FILEDA_" doesn't exist in the file; See IRM.",! D PAUSE^TIUFXHLX G NODEX
 N DIC,DA,DR,TIUFQ,SHARE,ORPHAN,BOILPT,TYPE,ITEMS,DIQ,USED
 S DIC=8925.1,DR=".04:.13",DIQ(0)="I,E",DA=FILEDA,DIQ="TIUFQ" D EN^DIQ1
 S TYPE=$G(TIUFQ(8925.1,FILEDA,.04,"I")) S:TYPE="DOC" TYPE="TL"
 S NODE0("TYPE")=$G(^TMP("TIUF",$J,"TYPE"_TYPE))
 S NODE0("POWNER")=$G(TIUFQ(8925.1,FILEDA,.05,"E"))
 S NODE0("COWNER")=$$MIXED^TIULS($G(TIUFQ(8925.1,FILEDA,.06,"E")))
 S NODE0("STATUS")=$$MIXED^TIULS($G(TIUFQ(8925.1,FILEDA,.07,"E")))
 S NODE0("NATL")=$$MIXED^TIULS($G(TIUFQ(8925.1,FILEDA,.13,"E")))
 I NODE0("NATL")="" S NODE0("NATL")="No"
 S USED=$G(TIUFQ(8925.1,FILEDA,.08,"E")),NODE0("INUSE")=$S(USED="NA":"",USED="?":"?",1:$$MIXED^TIULS(USED))
 S SHARE=$G(TIUFQ(8925.1,FILEDA,.1,"E"))
 S NODE0("SHARE")=$S(SHARE="YES":"Yes",SHARE="NO":"No",SHARE=""&(TYPE'="O"):"No",1:"")
 S ORPHAN=$$ORPHAN^TIUFLF4(FILEDA,NODE0)
 S NODE0("ORPHAN")=$S(ORPHAN="NA":"",1:$$MIXED^TIULS(ORPHAN))
 S BOILPT=$$HASBOIL(FILEDA,NODE0),$P(NODE0,U,20)=BOILPT
 S NODE0("BOILPT")=$S(BOILPT="NA":"",BOILPT:"Yes",1:"No")
 S ITEMS=$S($O(^TIU(8925.1,FILEDA,10,0)):1,1:0)
 S NODE0("ITEMS")=$S(ITEMS:"Yes",$P(NODE0,U,4)="O":"",1:"No")
NODEX Q
 ;
DESCUSED(FILEDA) ; Function returns 1 if FILEDA has
 ;descendant item of Type DOC with TIU documents (file 8925 entries)
 ;pointing to it; Else returns 0.
 ; Assumes DDEFs cannot be reused Except SHARED Components; stops
 ;check at DOC level. It is enough to check descendants down to type
 ;DOC since if a component is used, its ancestor of type DOC is used.
 ;Therefore reusing COMPONENTS does not present a difficulty for
 ;DDEFUSED or for DESCUSED IF CHECKING FOR USE STOPS AT THE DOC LEVEL
 ;AND DOES NOT CHECK COMPONENTS.
 ; Requires FILEDA.
 ; Requires FILEDA's node 0 to exist.
 N DESCANS,TIUI,IFILEDA,ITYPE,INODE0
 S (TIUI,DESCANS)=0
 F  S TIUI=$O(^TIU(8925.1,FILEDA,10,TIUI)) Q:'TIUI  D  Q:DESCANS=1
 . S IFILEDA=+^TIU(8925.1,FILEDA,10,TIUI,0)
 . I $O(^TIU(8925,"B",IFILEDA,0)) S DESCANS=1 Q
 . S INODE0=$G(^TIU(8925.1,IFILEDA,0)),ITYPE=$P(INODE0,U,4)
 . I INODE0="" S DESCANS="?" Q
 . I ITYPE="DOC" Q
 . S DESCANS=$$DESCUSED(IFILEDA)
 . Q
DESCX Q DESCANS
 ;
DDEFUSED(FILEDA) ; Function called by 8925.1 computed field .08 USED BY DOCMTS.
 ; Assumes DDEFs CANNOT be reused except for SHARED Components.
 ; Returns YES if FILEDA is pointed to by 8925 docmts or components.
 ;         YES if FILEDA itself is not pointed to, but descendants
 ;           of Type DOC(Title) under FILEDA in the hierarchy are 
 ;           pointed to.
 ;         NA if FILEDA has Type Object.
 ;         ? if not known to be YES and FILEDA has Item w broken pointer.
 ;         NO if not YES, not ?, and not NA.
 ; Requires FILEDA = 8925.1 IFN of Entry.
 ; Requires Node 0 of FILEDA to exist.
 N DDEFUSED,NODE0,TYPE,DESCUSED
 S NODE0=^TIU(8925.1,FILEDA,0),DDEFUSED=0
 I $O(^TIU(8925,"B",FILEDA,0)) S DDEFUSED="YES" G DDEFX
 S TYPE=$P(NODE0,U,4)
 I TYPE="O" S DDEFUSED="NA" G DDEFX
 I TYPE="DOC" S DDEFUSED="NO" G DDEFX
 S DESCUSED=$$DESCUSED(FILEDA)
 S DDEFUSED=$S(DESCUSED:"YES",DESCUSED="?":"?",1:"NO")
DDEFX Q DDEFUSED
 ;
