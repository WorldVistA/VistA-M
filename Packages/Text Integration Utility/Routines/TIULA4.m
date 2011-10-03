TIULA4 ; SLC/JER,JM - Check out PUT API's ; 6/13/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**10,35,79,103,111,116**;Jun 20, 1997
CLASPICK(PARENT,Y,TYPES) ; Boolean fn to screen selection of classes
 N TIUY S TIUY=0,TYPES=$G(TYPES,"DCCL")
 I ($P(^TIU(8925.1,+Y,0),U,4)]""),$S(TYPES[$P(^TIU(8925.1,+Y,0),U,4):1,(+Y=+$$CLASS^TIUCNSLT):1,1:0),+$$ISA^TIULX(+Y,+PARENT),+$$CANPICK^TIULP(+Y) S TIUY=1
 Q TIUY
DFLTPICK(PARENT,Y,LIST) ; Boolean function to screen selection of Default title
 N TIUY S TIUY=0
 I $P(^TIU(8925.1,+Y,0),U,4)="DOC",+$$ISA^TIULX(+Y,+PARENT),+$$CANPICK^TIULP(+Y) S TIUY=1
 I +$G(LIST),(+$O(^TIU(8925.98,+$G(LIST),10,0))>0),(+$O(^TIU(8925.98,+$G(LIST),10,"B",+Y,0))'>0) S TIUY=0
 Q TIUY
LBYPASS() ; Interactive function to determine whether to bypass list
 N PROMPT W !
 S PROMPT="Edit (L)ist, (D)efault TITLE, or (B)oth? "
 Q $P($$READ^TIUU("SA^L:list;D:default;B:both",PROMPT,"BOTH"),U)
TITLPICK(TIUY,CLASS,ATTCHID) ; Select a title
 N PICK,TITLES,I,L,Y,TIUDFLT,QUIT,DTOUT,DUOUT,CANLINK,PICKNUM
 S CLASS=$G(CLASS,3)
 D LIST(.TITLES,CLASS,"","",$G(ATTCHID)) Q:'+$O(TITLES(0))
 S TIUDFLT=$G(TITLES("DFLT"))
 I TIUDFLT,'$P(TITLES(TIUDFLT),U,3)!($G(ATTCHID)&'$P(TITLES(TIUDFLT),U,4)) S TIUDFLT=0,TIUY("NODFLT")=1
RPT W !!,"Personal ",$$UP^XLFSTR($$PNAME^TIULC1(CLASS))," Title List for "
 W $$NAME^TIULS($$PERSNAME^TIULC1(DUZ),"FIRST LAST"),!
 S (I,L,PICK,QUIT,PICKNUM)=0
 F  S I=$O(TITLES(I)) Q:QUIT!(+I'>0)!(+PICK)  D
 . W !?3,I,?8,$P(TITLES(I),U,2)
 . I I#15=0 D
 . . I +$O(TITLES(I)) D  I 1
 . . . W !!,"Press <RETURN> to see more titles, '^' to exit personal list, or CHOOSE"
 . . . S Y=$G(TITLES(+$$PICK(1,I))) ;If more titles, no default
 . . E  D
 . . . W ! S PICKNUM=$$PICK(1,I,+$G(TIUDFLT))
 . . . I PICKNUM="" S QUIT=1
 . . . S Y=$G(TITLES(+PICKNUM))
 . . . I Y="0^Other Title" S QUIT=1
 . . I $D(DTOUT)!$D(DUOUT) S QUIT=1,Y=0
 . . E  S PICK=+Y
 . I +PICK S TIUY(1)=1_U_+Y_$$PNAME^TIULC1(+Y),TIUY=1
 . S L=I
 I 'QUIT,'PICK W ! S Y=$G(TITLES(+$$PICK(1,L,+$G(TIUDFLT))))
 I +Y,'$P(Y,U,3) D  G RPT
 . W !,$C(7),">>> ",$$PNAME^TIULC1(+Y)," is not an ACTIVE title."
 . W " Please choose another."
 . W !?4,"You may want to remove it from your list..."
 . W !?4,"Check with your Clinical Application Coordinator.",! K Y
 I +Y,$G(ATTCHID),'$P(Y,U,4) D  G RPT
 . S CANLINK=$$CANLINK^TIULP(+Y)
 . W !,$C(7),">>> ",$P(CANLINK,U,2),!," Please choose another title."
 . K Y
 I +Y D
 . S TIUY(1)=1_U_+Y_U_$$PNAME^TIULC1(+Y),TIUY=1
 . W "    ",$$PNAME^TIULC1(+Y)
 I +Y=0 S (TIUY,TIUY(1))=0
 ;If user selected other title, they rejected the default:
 I Y="0^Other Title" S TIUY("NODFLT")=1
 I 'Y D
 . W !,"Exiting NUMBERED personal list.",!
 . W "Please select other title by NAME:"
 Q
PICK(LOW,HIGH,DFLT) ; List selection
 N X,Y
 I +$G(DFLT) S Y=$$READ^TIUU("NO^"_LOW_":"_HIGH,"TITLE",DFLT) I 1
 E  S Y=$$READ^TIUU("NO^"_LOW_":"_HIGH,"TITLE")
 W !
 Q Y
LIST(TIUY,CLASS,TYPE,TIUK,ATTCHID) ; Get list of document titles
 N TIUDFLT
 S TIUK=+$G(TIUK)
 I $G(TYPE)']"" S TYPE="DOC"
 ; If the user has a preferred list of titles for the CLASS, get it
 I +$O(^TIU(8925.98,"AC",DUZ,CLASS,0)) D PERSLIST(.TIUY,DUZ,CLASS,.TIUK,ATTCHID)
 Q
PERSLIST(TIUY,DUZ,CLASS,TIUC,ATTCHID) ; Get personal list for a user
 N TIUI,TIUDA,LASTSEQ,UNKSEQ,DFLTFL
 S TIUDA=+$O(^TIU(8925.98,"AC",DUZ,CLASS,0))
 Q:+TIUDA'>0
 S TIUY("DFLT")=$P($G(^TIU(8925.98,+TIUDA,0)),U,3)
 S TIUC=+$G(TIUC)
 S (TIUI,LASTSEQ,UNKSEQ,DFLTFL)=0
 F  S TIUI=$O(^TIU(8925.98,TIUDA,10,TIUI)) Q:+TIUI'>0  D
 . N TIUPL,TIUTNM,TIUDTYP,TIUSEQ,TLINE
 . S TIUPL=$G(^TIU(8925.98,TIUDA,10,TIUI,0))
 . S TIUDTYP=$P(TIUPL,U),TIUSEQ=+$P(TIUPL,U,2)
 . I 'TIUSEQ S TIUSEQ=1000+UNKSEQ,UNKSEQ=UNKSEQ+1
 . S TIUTNM=$S($P(TIUPL,U,3)]"":$P(TIUPL,U,3),1:$$PNAME^TIULC1(+TIUDTYP))
 . S TIUC=+$G(TIUC)+1
 . S TLINE=$$TLINE(TIUDTYP,TIUTNM,$G(ATTCHID))
 . I $D(TIUY(TIUSEQ)) S TIUY(1000+UNKSEQ)=TLINE,LASTSEQ=1000+UNKSEQ,UNKSEQ=UNKSEQ+1
 . E  S TIUY(TIUSEQ)=TLINE
 . I LASTSEQ<TIUSEQ S LASTSEQ=TIUSEQ
 . I TIUDTYP=TIUY("DFLT") S TIUY("DFLT")=TIUSEQ,DFLTFL=1
 I DFLTFL=0&($G(TIUY("DFLT"))) D
 . N TIUTNM,DFLTLINE
 . S TIUTNM=$$PNAME^TIULC1(+TIUY("DFLT"))
 . S DFLTLINE=$$TLINE(+TIUY("DFLT"),TIUTNM,$G(ATTCHID))
 . S TIUY(1000+UNKSEQ)=DFLTLINE,TIUY("DFLT")=1000+UNKSEQ,LASTSEQ=1000+UNKSEQ,UNKSEQ=UNKSEQ+1
 I +$G(LASTSEQ)>0 S LASTSEQ=LASTSEQ+1,TIUY(LASTSEQ)=0_U_"Other Title"
 Q
 ;
TLINE(TITLIFN,TIUTNM,ATTCHID) ; Function returns TitleIFN^Titlename^Canpick (i.e. active)^Canattach (user can attach child ID entries of this title)
 N TIUPICK,CANLINK
 S TIUPICK=+$$CANPICK^TIULP(TITLIFN)
 S CANLINK=""
 I $G(ATTCHID) S CANLINK=+$$CANLINK^TIULP(TITLIFN)
 I 'TIUPICK!(CANLINK=0) S TIUTNM="("_TIUTNM_")"
 Q TITLIFN_U_TIUTNM_U_TIUPICK_U_CANLINK
