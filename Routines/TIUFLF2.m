TIUFLF2 ; SLC/MAM - Library; File 8925.1 Related: PERSOWNS(FILEDA,PERSON), SELNAME(DEFLT), NAMSCRN(PFILEDA) ;4/23/97  18:20
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
 ;
PERSOWNS(FILEDA,PERSON) ; Function determines if PERSON owns 8925.1
 ;Entry FILEDA.
 ; Returns 1^P if FILEDA is personally-owned by PERSON;
 ;         1^C if FILEDA is owned by a class and PERSON belongs to it;
 ;         0   if PERSON doesn't own Entry
 ;         ""  if Entry is not owned except if adding FILEDA as item,
 ;         1   if Entry is not owned and adding FILEDA as item. (Users are confused if they don't see the item, so let them add it even if it's missing things).
 ; Requires 8925.1 FILEDA;
 ; Requires PERSON = IFN in file 200
 N ANS,CLASS
 I $D(^TIU(8925.1,"AP",PERSON,FILEDA)) S ANS="1^P" G PERSX
 S CLASS=$P(^TIU(8925.1,FILEDA,0),U,6)
 I $D(^TIU(8925.1,"AC",+CLASS,FILEDA)) D  G PERSX
 . I $$ISA^USRLM(PERSON,CLASS) S ANS="1^C" Q
 . S ANS=0
 . Q
 I 'CLASS,'$P(^TIU(8925.1,FILEDA,0),U,5) S ANS=$S($G(TIUFSTMP)="T"&($G(TIUFXNOD)["Add"):1,1:"") G PERSX
 S ANS=0
PERSX Q ANS
 ;
SELNAME(DEFLT) ; Function Prompts for Name, Returns Name or "" if nothing selected or @ entered.
 ; Optional DEFLT = present Name if editing name
 N DIR,X,Y,DA,NAME
 S DIR(0)="FA^3:60^S X=$$UPPER^TIULS(X) K:'(X'?1P.E) X",(DIR("?"),DIR("??"))="^D NAME^TIUFXHLX"
 I (TIUFXNOD["Create") S $P(DIR(0),U)="FAO"
 I $D(DEFLT) S DIR("B")=DEFLT
 S DIR("A")=$S(TIUFXNOD["Basics"!(TIUFXNOD["Name"):"NAME: ",TIUFTMPL'="J":"Enter Document Definition Name to add as New Entry: ",1:"Enter the Name of a new Object: ")
 D ^DIR I $D(DTOUT)!$D(DUOUT) S NAME="" G SELNX
 S NAME=Y,NAME=$$UPPER^TIULS(NAME)
SELNX Q NAME
 ;
NAMSCRN(PFILEDA) ; Function returns DIC("S") for File 8925.1 Lookups when
 ;looking up entries to add as items to parent entry. Used in Rtn TIUFT,
 ;NOT in file DD's.
 ; Adding items is done in 2 separate steps: 1) choosing a new or
 ;existing entry and adding it to the file if it is new, and 2) actually
 ;adding entry as an item to the parent. This screen is for the first
 ;step ONLY.  The second step is done in ADDTEN^TIUFLF4 and uses the
 ;screen set on fld 10, subfld .01, which prevents lookup failure due to
 ;duplicate names by letting only IFN TIUFISCR past the screen.
 ; Allows items of appropriate Type or NO Type.
 ; Disallows items which already have a parent EXCEPT for Shared Components (field .1).
 ; Disallows items which user doesn't own, EXCEPT ownerless items,
 ;EXCEPT Shared Components.
 ; Disallows entry from being its own item.
 ; If PFILEDA is nonNat'l, disallows Nat'l entries except Shared Comp.
 ; If PFILEDA is a shared component, disallows nonshared entries.
 ; Requires PFILEDA = IFN of 8925.1 parent entry
 ; Returns SCRN = screen that allows appropriate items
 ; TIUFIMSG is set in DUP^TIUFLF7
 N SCRN,PTYPE,HASPRNT,TYPEIS,TYPEISCL,TYPEISDC,TYPISDOC,TYPISNUL,TYPEISCO
 N SHARED,USROWNS,RTTYPE,CL,NUL,DC,DOC,CO,POSSTYPE,GOODTYPE,SELFITEM
 N NATLOK,PNATL,PNODE0,PSHARED
 S SCRN="I 0"
 S SELFITEM="(Y="_PFILEDA_")"
 S HASPRNT="+$O(^TIU(8925.1,""""AD"""",Y,0))"
 S TYPEIS="($P(^(0),U,4)="
 S NUL="""""",CL="""CL""",DC="""DC""",DOC="""DOC""",CO="""CO"""
 S TYPISNUL=TYPEIS_NUL_")"
 S TYPEISCL=TYPEIS_CL_")"
 S TYPEISDC=TYPEIS_DC_")"
 S TYPISDOC=TYPEIS_DOC_")"
 S TYPEISCO=TYPEIS_CO_")"
 S POSSTYPE=$$POSSTYPE^TIUFLF7(PFILEDA) G:$D(DTOUT) NAMSX
 I POSSTYPE="" W !!," Parent has no Type/Bad Type",! G NAMSX
 S GOODTYPE=""
 I POSSTYPE["CL" S GOODTYPE=$S(GOODTYPE="":TYPEISCL,1:GOODTYPE_"!"_TYPEISCL)
 I POSSTYPE["DC" S GOODTYPE=$S(GOODTYPE="":TYPEISDC,1:GOODTYPE_"!"_TYPEISDC)
 I POSSTYPE["DOC" S GOODTYPE=$S(GOODTYPE="":TYPISDOC,1:GOODTYPE_"!"_TYPISDOC)
 I POSSTYPE["CO" S GOODTYPE=$S(GOODTYPE="":TYPEISCO,1:GOODTYPE_"!"_TYPEISCO)
 S USROWNS="+$$PERSOWNS^TIUFLF2(Y,DUZ)"
 S SHARED="+$P(^TIU(8925.1,Y,0),U,10)",PSHARED=+$P(^TIU(8925.1,PFILEDA,0),U,10)
 S SCRN="I "_GOODTYPE_",'"_SELFITEM_",'$$DUP^TIUFLF7($P(^(0),U),"_PFILEDA_",Y),$$NATLOK^TIUFLF2(^TIU(8925.1,Y,0),"_PFILEDA_"),'("_PSHARED_"&'"_SHARED_") X:'"_SHARED_" ""I "_USROWNS_"&'"_HASPRNT_""""
NAMSX I $D(DTOUT) S SCRN="I 0"
 Q SCRN
 ;
NATLOK(NODE0,PFILEDA) ; Function returns 1/0 if item OK/not OK to add as far
 ;as Natl goes.  Considers if parent is Natl, if Item is Natl,
 ;if User has Natl menu.
 N NATL,PNODE0,PNATL,PTYPE,SHARED,NATLANS
 S NATL=+$P(NODE0,U,13),PNODE0=^TIU(8925.1,PFILEDA,0),PNATL=+$P(PNODE0,U,13),PTYPE=$P(PNODE0,U,4),SHARED=$P(NODE0,U,10),NATLANS=0
 I PTYPE="CL"!(PTYPE="DC") S NATLANS=$S(PNATL:$S(NATL:$S(TIUFWHO="N":1,1:0),1:1),1:$S(NATL:0,1:1))
 I PTYPE="DOC"!(PTYPE="CO") S NATLANS=$S(PNATL:$S(NATL:1,1:0),1:$S(NATL:$S(SHARED:1,1:0),1:1))
 Q NATLANS
 ;
