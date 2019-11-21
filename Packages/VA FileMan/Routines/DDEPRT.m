DDEPRT ;SLC/MKB -- Entity Print Utilities ;09/18/18 4:36pm
 ;;22.2;VA FileMan;**16,17**;Jan 05, 2016;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; %ZIS                         10086
 ; %ZTLOAD                      10063
 ; XLFDT                        10103
 ; XLFSTR                       10104
 ;
EN ; -- enter here to print a SDA entity
 N DDENT,DDEFMT
 D ENTITY(.DDENT) Q:"^"[DDENT
 S DDEFMT=$$FORMAT Q:"^"[DDEFMT
 ;
 ;Device
 S %ZIS=$S($D(^%ZTSK):"Q",1:"")
 W ! D ^%ZIS K %ZIS I $G(POP) K POP Q
 K POP
 ;
 ;Queue report?
 I $D(IO("Q")),$D(^%ZTSK) D  G END
 . N ZTRTN,ZTDESC,ZTSAVE
 . S ZTRTN="ENP^DDEPRT"
 . S ZTDESC="Report of Entity "_$P(DDENT,U,2)
 . S ZTSAVE("DDENT")="",ZTSAVE("DDEFMT")=""
 . D ^%ZTLOAD
 . I $D(ZTSK)#2 W !,"Report queued!",!,"Task number: "_$G(ZTSK),!
 . E  W !,"Report canceled!",!
 . K ZTSK
 . S IOP="HOME" D ^%ZIS
 ;
 U IO
 ;
ENP ; -- entry point for [queued] report
 N DDEFN,DDEFILE,DDEDT,DDEPG,DDECRT
 ;
 S DDEFN=+$P($G(DDENT(0)),U,2),DDEDT=$$FMTE^XLFDT($$NOW^XLFDT)
 S DDEFILE=$S(DDEFN:DDEFN_U_$$NAME(DDEFN),1:"")
 S DDECRT=$E(IOST,1,2)="C-",DDEPG=0
 K DIRUT,DUOUT,DTOUT
 ;
 D @("HDR"_(2-DDECRT))
 D @DDEFMT
END ;
 I $D(ZTQUEUED) S ZTREQ="@"
 E  X $G(^%ZIS("C"))
 K DIRUT,DUOUT,DTOUT
 Q
 ;
ENTITY(Y) ; -- select an entity
 N X,DIC
 S DIC=1.5,DIC(0)="AEQMZ" D ^DIC
 I Y<1 S Y="^"
 Q Y
 ;
FORMAT() ; -- summary or details?
 N X,Y,DIR,DUOUT,DTOUT,DIRUT
 S DIR(0)="SA^SUM:Summary;DET:Detailed;"
 S DIR("A")="Print item summary or details? "
 S DIR("?")="Select Summary for a simple list of item names in sequence"
 D ^DIR S:$D(DTOUT) Y="^"
 Q Y
 ;
SUM ; -- print summary of ENTity
 N DSEQ,DITM
 D MAIN Q:$D(DIRUT)
 W !!,"Seq  Item                        Type Field  Sub/File   Entity"
 W !,$$REPEAT^XLFSTR("-",79)
 S DSEQ=0 F  S DSEQ=$O(^DDE(+DDENT,1,"SEQ",DSEQ)) Q:'DSEQ  D  Q:$D(DIRUT)
 . S DITM=0 F  S DITM=$O(^DDE(+DDENT,1,"SEQ",DSEQ,DITM)) Q:'DITM  D LINE(DITM) Q:$D(DIRUT)
 Q
 ;
LINE(DA) ; -- print single item row
 N X0 S X0=$G(^DDE(+DDENT,1,DA,0))
 D PG Q:$D(DIRUT)
 W !,$P(X0,U,2),?5,$P(X0,U),?35,$P(X0,U,3),$$RJ^XLFSTR($P(X0,U,5),7),"  ",$P(X0,U,4)
 W:$P(X0,U,8) ?56,$E($P($G(^DDE(+$P(X0,U,8),0)),U),1,24)
 ; look for complex items
 I $P(X0,U,3)="C" D
 . N CSEQ,CITM
 . S CSEQ=0 F  S CSEQ=$O(^DDE(+DDENT,1,DA,3,"B",CSEQ)) Q:CSEQ<1  D
 .. S CITM=0 F  S CITM=$O(^DDE(+DDENT,1,DA,3,"B",CSEQ,CITM)) Q:CITM<1  D
 ... S CNM=$P($G(^DDE(+DDENT,1,DA,3,CITM,0)),U,2) Q:CNM=""
 ... S CDA=$O(^DDE(+DDENT,1,"B",CNM,0)) D LINE(CDA)
 Q
 ;
DET ; -- print details of ENTity
 N DDELN,DSEQ,DITM
 D DESC Q:$D(DIRUT)
 D MAIN Q:$D(DIRUT)
 W !!,"Seq     Item",!,"Number  Properties",!,"------  ----------"
 S DSEQ=0 F  S DSEQ=$O(^DDE(+DDENT,1,"SEQ",DSEQ)) Q:'DSEQ  D  Q:$D(DIRUT)
 . S DITM=0 F  S DITM=$O(^DDE(+DDENT,1,"SEQ",DSEQ,DITM)) Q:'DITM  D ITEM(DITM,DSEQ) Q:$D(DIRUT)
 Q
 ;
DESC ; -- description
 N I S I=0
 F  S I=$O(^DDE(+DDENT,19,I)) Q:I<1  D PG Q:$D(DIRUT)  W !,$G(^(I,0))
 Q
 ;
MAIN ; -- main Entity properties
 N X0 S X0=$G(DDENT(0)) D PG Q:$D(DIRUT)
 W !!," DISPLAY NAME: "_$G(^DDE(+DDENT,.1))
 D PG Q:$D(DIRUT)
 W !!,"      SORT BY: "_$P(X0,U,3)
 W ?40,"DATA MODEL: "_$S($P(X0,U,6)="S":"SDA",$P(X0,U,6)="F":"FHIR",1:"")
 D PG Q:$D(DIRUT)
 W !,"    FILTER BY: "_$P(X0,U,4)
 W ?41,"READ ONLY: "_$S($P(X0,U,5):"YES",1:"NO")
 D PG Q:$D(DIRUT)
 D MCODE("       SCREEN: ",$G(^DDE(+DDENT,5.1))) Q:$D(DIRUT)
 D PG Q:$D(DIRUT)  W !,"QUERY ROUTINE: "_$G(^DDE(+DDENT,5)),!
 D MCODE(" ENTRY ACTION: ",$G(^DDE(+DDENT,2))) Q:$D(DIRUT)
 D MCODE("    ID ACTION: ",$G(^DDE(+DDENT,4))) Q:$D(DIRUT)
 D MCODE("  EXIT ACTION: ",$G(^DDE(+DDENT,3))) Q:$D(DIRUT)
 Q
 ;
ITEM(DA,NUM,LVL) ; -- print single item
 N X0,X1,TYPE,FN,FLD,TAB,CDA,CNM,I,NM
 S LVL=+$G(LVL),TAB=$S(LVL:$$REPEAT^XLFSTR(" ",(LVL*9)),1:"")
 S X0=$G(^DDE(+DDENT,1,DA,0)),X1=$G(^(1)),TYPE=$P(X0,U,3)
 D PG Q:$D(DIRUT)  W !!,TAB,$$LJ^XLFSTR($G(NUM),9),"NAME:    "_$P(X0,U)
 S TAB=TAB_"         "
 D PG Q:$D(DIRUT)  W !,TAB,"TYPE:    "_$$TYPE(TYPE,+X1)
 ;
 S FN=$P(X0,U,4),FLD=$P(X0,U,5) I FLD D  Q:$D(DIRUT)
 . D PG Q:$D(DIRUT)
 . W !,TAB,"FIELD:   "_$$GET1^DID(FN,FLD,,"LABEL")_" (#"_FLD_")"
 . I $P(X0,U,6) D  ;extended ptr
 .. N GBL S GBL=U_$$GET1^DID(FN,FLD,,"POINTER")_"0)"
 .. S FN=+$P(@GBL,U,2),FLD=$P(X0,U,6)
 .. W " > "_$$GET1^DID(FN,FLD,,"LABEL")_" (#"_FLD_")"
 . I $P(X0,U,7) W " [internal]"
 . I TYPE="W",$P(X0,U,9) W " [word wrap]"
 . Q:FN=+DDEFILE
 . D PG Q:$D(DIRUT)  W !,TAB,"          in "_$$NAME(FN)_" (#"_FN_")"
 ;
 I 'FLD,TYPE="L",FN,FN'=+DDEFILE D  Q:$D(DIRUT)
 . I +X1=1 D PG Q:$D(DIRUT)  W !,TAB,"FILE:    "_$$NAME(FN)_" (#"_FN_")"
 . I +X1=2 D PG Q:$D(DIRUT)  W !,TAB,"SUBFILE: "_$$NAME(FN)_" (#"_FN_")"
 . I $L($P(X1,U,3)) D PG Q:$D(DIRUT)  W !,TAB,"XREF:    "_$P(X1,U,3)
 . I $L($P(X1,U,4)) D PG Q:$D(DIRUT)  W !,TAB,"FILTER:  "_$P(X1,U,4)
 ;
 I $L($G(^DDE(+DDENT,1,DA,6))) D MCODE(TAB_"ACTION:  ",^(6)) Q:$D(DIRUT)
 I TYPE="F" D:$L($G(^DDE(+DDENT,1,DA,2)))  Q
 . D PG Q:$D(DIRUT)
 . W !,TAB,"VALUE:   "_^DDE(+DDENT,1,DA,2)
 I $L($G(^DDE(+DDENT,1,DA,4))) D MCODE(TAB_"XFORM:   ",^(4)) Q:$D(DIRUT)
 I $P(X0,U,8) D PG Q:$D(DIRUT)  W !,TAB,"ENTITY:  "_$P($G(^DDE(+$P(X0,U,8),0)),U)
 I TYPE="L",$L($P(X1,U,2)) D PG Q:$D(DIRUT)  W !,TAB,"TAG:     "_$P(X1,U,2)
 ;
 I TYPE="C"!((TYPE="L")&(+X1=3)) D  Q:$D(DIRUT)
 . D PG Q:$D(DIRUT)  W !!,TAB,"Group    Item"
 . D PG Q:$D(DIRUT)  W !,TAB,"Order    Properties"
 . D PG Q:$D(DIRUT)  W !,TAB,"-----    ----------"
 . S CSEQ=0 F  S CSEQ=$O(^DDE(+DDENT,1,DA,3,"B",CSEQ)) Q:'CSEQ  D  Q:$D(DIRUT)
 .. S I=$O(^DDE(+DDENT,1,DA,3,"B",CSEQ,0))
 .. S NM=$P(^DDE(+DDENT,1,DA,3,I,0),U,2) Q:NM=""
 .. S CDA=+$O(^DDE(+DDENT,1,"B",NM,0))
 .. I CDA<1!'$D(^DDE(+DDENT,1,CDA,0)) Q
 .. D ITEM(CDA,CSEQ,(LVL+1))
 Q
 ;
TYPE(X,L) ; -- return display name of item type X
 N Y S X=$G(X),Y=""
 I X="I" S Y="ID"
 I X="F" S Y="FIXED STRING"
 I X="W" S Y="FIELD/WP"
 I X="S" S Y="FIELD"
 I X="C" S Y="GROUP"
 I X="E" S Y="ENTITY"
 I X="L" S Y="LIST",L=+$G(L) D
 . S Y=$S(L=1:"FILE ",L=2:"SUB-FILE ",L=3:"GROUP AS A ",1:"")_Y
 Q Y
 ;
NAME(NUM) ; -- return name of sub/file
 Q $O(^DD(+$G(NUM),0,"NM",""))
 ;
MCODE(CAPTION,CODE) ; -- print code fields
 N WIDTH S WIDTH=79-$L(CAPTION)
 D PG Q:$D(DIRUT)
 W !,CAPTION,$E(CODE,1,WIDTH) Q:$L(CODE)'>WIDTH
 S CAPTION=$$REPEAT^XLFSTR(" ",$L(CAPTION))
 F  S CODE=$E(CODE,WIDTH+1,999) Q:CODE=""  D PG Q:$D(DIRUT)  W !,CAPTION,$E(CODE,1,WIDTH)
 Q
 ;
PG ; -- check line count for new page
 I $Y+3'<IOSL D HEADER Q:$D(DIRUT)
 Q
 ;
HEADER ; -- all headers except first
 I DDECRT D  Q:$D(DIRUT)
 . N DIR,X,Y
 . S DIR(0)="E" W ! D ^DIR
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DIRUT)=1 Q
HDR1 ;first header for CRTs
 W @IOF
HDR2 ;first header for non-CRTs
 N X1,X2,Y S DDEPG=$G(DDEPG)+1
 S X1="ENTITY: "_$P(DDENT,U,2)_" (#"_+DDENT_")"
 S X2="  FILE: "_$P(DDEFILE,U,2)_" (#"_+DDEFILE_")"
 S Y=DDEDT_"   PAGE "_DDEPG
 W X1,!,X2,$$RJ^XLFSTR(Y,79-$L(X2))
 W !,$$REPEAT^XLFSTR("-",79)
 Q
