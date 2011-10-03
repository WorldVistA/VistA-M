TIUFLF1 ; SLC/MAM - Library; File 8925.1 Related:  HASITEMS(FILEDA), ASKFLDS(FILEDA,FIELDS,PFILEDA,NEWSFLG,XFLG), BADNAP(NAP,FILEDA,OBJFLG) ; 03/16/2007
 ;;1.0;TEXT INTEGRATION UTILITIES;**2,12,17,64,211,225**;Jun 20, 1997;Build 13
 ;
 ;
 ;*** INCLUDES JOEL'S MODS FOR VUID PATCH ***
 ;
BADNAP(NAP,FILEDA,OBJFLG) ; Function returns 1 if NAP is ambiguous as a
 ;name, abbrev or print name for FILEDA AND such ambiguity is a problem.
 ;Else 0.  Used when editing entries, or when finding permitted types.
 ; Ambiguity is a problem if OBJFLG=1.  OBJFLG=1 if FILEDA is an object,
 ;or FILEDA WILL BE an object since we're in Create Objects, or we are
 ;deciding whether to include type O as a permitted type
 ;in TYPELIST^TIUFLF7.
 ; TYPELIST, NAME of object in ASKFLDS must SEND OBJFLG=1.  Others are SET here.
 N NAPANS,XREF,OFILEDA
 S NAPANS=0 I NAP="" G BADNX
 I $D(^TIU(8925.1,"AT","O",FILEDA)) S OBJFLG=1
 I $G(TIUFTMPL)="J" S OBJFLG=1
 I $G(TIUFXNOD)["Copy",$P($G(NODE0),U,4)="O" S OBJFLG=1
 S OBJFLG=+$G(OBJFLG)
 I 'OBJFLG G BADNX
 F XREF="B","C","D" D  Q:NAPANS
 . S OFILEDA=0 F  S OFILEDA=$O(^TIU(8925.1,XREF,NAP,OFILEDA)) Q:'OFILEDA  D  Q:NAPANS
 . . I OFILEDA'=FILEDA,$D(^TIU(8925.1,"AT","O",OFILEDA)) S NAPANS=1
BADNX Q NAPANS
 ;
HASITEMS(FILEDA) ; Function returns 0 if FILEDA has no items, else returns 1.
 Q $O(^TIU(8925.1,+FILEDA,10,0))
 ;
ASKFLDS(FILEDA,FIELDS,PFILEDA,NEWSFLG,XFLG) ; Ask FIELDS (String subset of: ;.01;.02;.03;.04;.05;.06;.07;.1;.13;3.03) w ;'s on ends as well as between numbers for file entry FILEDA.
 ; Requires FILEDA, FIELDS.
 ; If field is determined, correct, and exists, module doesn't ask even if it is contained in FIELDS.
 ; Returns NEWSFLG=1 if ASKFIELDS has changed Status of FILEDA, else 0
 ; Returns XFLG=1 if user ^exited, else 0.
 ; Requires PFILEDA (= Actual/Anticipated parent) if FIELDS [ .04 Type
 ;or .07 Status. If no such parent, send PFILEDA=0.
 ; Should Lock FILEDA before calling ASKFLDS.
 ; After calling ASKFLDS, Set back to screen mode if nec, set VALMBCK = "R" if necessary.
 N DIE,DA,X,Y,NODE0,DR,PFDA,TYPEDR,USED,ITEMIFN,DIR,NAME,ANS
 N TIUFQUIT,TIUFY,SIGNERS,TIUFTLST,TIUFTMSG,TIUFIMSG,DEFLT,CONTINUE
 N SUPVISIT
 S NEWSFLG=0,XFLG=0,NODE0=^TIU(8925.1,FILEDA,0)
 S USED=$S($P(NODE0,U,4)="O":1,1:$$DDEFUSED^TIUFLF(FILEDA))
 S DIE=8925.1,DA=FILEDA,TIUFQUIT=0
 S PFILEDA=+$G(PFILEDA) K DIRUT
 D FULL^VALM1 S TIUFFULL=1
 I FIELDS'[";.01;" G ABBREV
 I $P(NODE0,U,4)="O" S CONTINUE=$$WARNOBJ^TIUFLJ("N",FILEDA,NODE0) G:$D(DIRUT) ASKFX G:'CONTINUE ABBREV
NAME S DEFLT=$P(NODE0,U) K DIRUT S NAME=$$SELNAME^TIUFLF2(DEFLT) G:$D(DIRUT) ASKFX
 I PFILEDA,$$DUPITEM^TIUFLF7(NAME,PFILEDA,FILEDA) W !!,"Please enter a different Name; Parent already has Item with that Name",! G NAME
 D TYPELIST^TIUFLF7(NAME,FILEDA,PFILEDA,.TIUFTMSG,.TIUFTLST) G:$D(DTOUT) ASKFX
 I $D(TIUFTMSG("T")) W !!,TIUFTMSG("T"),!,"Can't edit Entry",! D PAUSE^TIUFXHLX G ASKFX
 I TIUFTLST="" W !!," Please enter a different Name; File already has entries of every permitted Type",!,"with that Name",! G NAME
 I $P(NODE0,U,4)'="",TIUFTLST'[(U_$P(NODE0,U,4)_U) W !!,"Please enter a different Name; File already has entry of this Type",!,"with that Name",! G NAME
 I $P(NODE0,U,4)="O",$$BADNAP^TIUFLF1(NAME,FILEDA,1) W " ??",!,"Object Name must be unique among all object Names, Abbreviations,",!,"and Print Names." G NAME
 S DR=".01///^S X=NAME" D ^DIE S NODE0=^TIU(8925.1,FILEDA,0)
 I $D(DIRUT)!$D(Y)!$D(DTOUT) S DUOUT=1 G ASKFX
ABBREV I FIELDS'[";.02;" G PRINTN
 I $P(NODE0,U,4)="O" S CONTINUE=$$WARNOBJ^TIUFLJ("A",FILEDA,NODE0) G:$D(DIRUT) ASKFX G:'CONTINUE PRINTN
ABBREV1 S DR=".02" D ^DIE S NODE0=^TIU(8925.1,FILEDA,0)
 I $D(DIRUT)!$D(Y)!$D(DTOUT) S DUOUT=1 G ASKFX
PRINTN I FIELDS'[";.03;" G LOINC
 I $P(NODE0,U,4)="O" S CONTINUE=$$WARNOBJ^TIUFLJ("P",FILEDA,NODE0) G:$D(DIRUT) ASKFX G:'CONTINUE LOINC
PRINTN1 N TIUFUPP S DR=".03" D ^DIE S NODE0=^TIU(8925.1,FILEDA,0)
 I $D(DIRUT)!$D(Y)!$D(DTOUT) S DUOUT=1 G ASKFX
 ; <VUID PATCH>
LOINC I FIELDS'[";1501;"!($P(NODE0,U,4)'="DOC") G NATL
 N TIUOUT S TIUOUT=0
 W !!,"EVERY Local Title must be mapped to a VHA Enterprise Standard Title.",!
 S DR="1501" D DIRECT^TIUMAP2(FILEDA) S NODE0=^TIU(8925.1,FILEDA,0)
 I $D(DIRUT)!+$G(TIUOUT)!$D(DTOUT) S DUOUT=1 G ASKFX
 ; </VUID PATCH>
NATL I FIELDS[";.13;",TIUFWHO="N" D  G:XFLG ASKFX S NODE0=^TIU(8925.1,FILEDA,0)
 . S DIR("B")=$S($P(NODE0,U,13):"YES",1:"NO")
 . D
 . . S DIR(0)="YO",(DIR("?"),DIR("??"))="^D HELP2^TIUFXHLX(.13)"
 . . S DIR("A")="NATIONAL"
 . . D ^DIR I $D(DUOUT)!$D(DTOUT) S XFLG=1 Q
 . . S ANS=Y,DR=".13////^S X=ANS" D ^DIE
TYPE I FIELDS[";.04;" K DIRUT D EDTYPE^TIUFLF7(FILEDA,.NODE0,PFILEDA,.XFLG,USED) G:$D(DIRUT) ASKFX
SHARE G:FIELDS'[";.1;" OWNER
 N PARENT1,PARENT2,SHARE,STATUS,DIR
 I "NM"'[TIUFWHO G OWNER
 I $P(NODE0,U,4)'="CO" G OWNER
 I '$$PERSOWNS^TIUFLF2(FILEDA,DUZ) W !!,"SHARED: Only an Owner can edit SHARED",! G OWNER
 S SHARE=$P(NODE0,U,10)
 ; If not presently SHARED set default=NO:
 I 'SHARE S DIR("B")="NO"
 ; If presently SHARED but only used once, set default=YES:
 S PARENT1=$O(^TIU(8925.1,"AD",FILEDA,0)),PARENT2=$S('PARENT1:0,1:$O(^TIU(8925.1,"AD",FILEDA,PARENT1)))
 I SHARE,'PARENT2 S DIR("B")="YES" I $P($G(^TIU(8925.1,+PARENT1,0)),U,10) W !!,"SHARED: Subcomponent of Shared Component; Must remain Shared",! G OWNER
 I 'SHARE,$P($G(^TIU(8925.1,+PARENT1,0)),U,10) S DIR("B")="YES"
 N Y
 I $D(DIR("B")) D  G:XFLG ASKFX S NODE0=^TIU(8925.1,FILEDA,0)
 . S DIR(0)="YO",(DIR("?"),DIR("??"))="^D HELP2^TIUFXHLX(.1)"
 . S DIR("A")="SHARED"
 . D ^DIR I $D(DUOUT)!$D(DTOUT) S XFLG=1 Q
 . S ANS=Y,DR=".1////^S X=ANS" D ^DIE
 I 'SHARE,$G(ANS),$$HASITEMS^TIUFLF1(FILEDA) D DSETSHAR^TIUFLD1(FILEDA) G OWNER
 I SHARE,PARENT2 W !!,"SHARED: Entry is SHARED with multiple parents; Can't edit SHARED"
OWNER I FIELDS[";.05;" D EDOWN^TIUFLF8(FILEDA,.XFLG) G:XFLG ASKFX
OKDIST I FIELDS[";3.02;",TIUFWHO="N" S DR="3.02//NO" D ^DIE I $D(Y)!$D(DTOUT) S DUOUT=1 G ASKFX
SUPVISIT I FIELDS[";3.03;",$P(NODE0,U,4)="CL"!($P(NODE0,U,4)="DC")!($P(NODE0,U,4)="DOC") D  G:$D(DUOUT) ASKFX
 . S SUPVISIT=$P($G(^TIU(8925.1,FILEDA,3)),U,3)
 . S SUPVISIT=$S(SUPVISIT=0:"NO",SUPVISIT=1:"YES",1:"")
 . I SUPVISIT="" D INHERIT^TIUFLD(FILEDA,0,3.03,"E","","",.SUPVISIT) S SUPVISIT=SUPVISIT("E")
 . S DR="3.03//^S X=SUPVISIT" D ^DIE I $D(Y)!$D(DTOUT) S DUOUT=1 Q
 . I SUPVISIT="NO",$P($G(^TIU(8925.1,FILEDA,3)),U,3) S CONTINUE=$$WARNSUP D
 . . I 'CONTINUE S DR="3.03///^S X=SUPVISIT" D ^DIE W " NOT"
 . . W " Suppressed" H 1
STATUS I FIELDS'[";.07;" G ASKFX
 I $P(NODE0,U,4)="CO",$P(NODE0,U,10) W !,"STATUS: Shared Components have no Status; Can't Edit Status" H:TIUFXNOD["Basics"!(TIUFXNOD["Boil") 2 G ASKFX ;P64 add msg and hang
 I TIUFTMPL="A",$G(TIUFSTMP)="",($P(NODE0,U,4)="CL")!($P(NODE0,U,4)="DC")!($P(NODE0,U,4)="DOC")!($P(NODE0,U,4)="CO") W !,"STATUS: Orphans are Inactive; Can't Edit Status" H 2 G ASKFX
 I $P(NODE0,U,4)="CO" W !,"STATUS: Components get their Status from their Parent; Can't Edit Status" H:TIUFXNOD["Basics"!(TIUFXNOD["Boil") 2 G ASKFX
 D ASKSTAT^TIUFLF6(FILEDA,.NODE0,PFILEDA,.NEWSFLG,.XFLG)
ASKFX S:$D(DTOUT)!$D(DUOUT) XFLG=1
 Q
 ;
WARNSUP() ; Function Warns user who asks to Suppress Visit,  Returns 1 to Suppress, 0 to not Suppress.
 N DIR,X,Y
 S DIR(0)="Y",DIR("B")="NO",DIR("A",1)=" Warning: You will NOT GET WORKLOAD CREDIT if you Suppress Visit Selection."
 S DIR("A")=" Sure you want to Suppress Visit Selection"
 W ! D ^DIR W " ... "
 Q Y
 ;
