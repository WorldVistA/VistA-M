PXCEHELP ;ISL/dee - Used for help on input ; 5/7/03 3:38pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**5,121**;Aug 12, 1996
 ;;
 Q
 ;
HELP ;
 D:$G(PXCEHLST)'=PXCECATS INTRFACE(PXCEHLOC,PXCECATS,"PXCEHLST")
 Q:$G(PXCEHLST)'=PXCECATS
 N PXCEINDX,PXCECODE,Y
 S Y=1
 S PXCECODE=((PXCEHLST="POV")!(PXCEHLST="CPT"))
 W !
 S PXCEINDX=0
 F  S PXCEINDX=$O(PXCEHLST(PXCEINDX)) Q:'PXCEINDX  D  Q:'Y
 . I $P(PXCEHLST(PXCEINDX),"^",1)="" W !,?5,$P(PXCEHLST(PXCEINDX),"^",2)
 . E  I PXCECODE W !,$P(PXCEHLST(PXCEINDX),"^",1),?10,$P(PXCEHLST(PXCEINDX),"^",2)
 . E  W !,?10,$P(PXCEHLST(PXCEINDX),"^",2)
 . I '(PXCEINDX#(IOSL-5)) D PAUSE
 I Y,(PXCEINDX#(IOSL-5)) D PAUSE
 W !
 Q
 ;
INTRFACE(PXCEHLOC,PXCECATS,PXCELIST) ;
 ;Calls the AICS routine to get the selection list for one
 ; package interface file.
 K @PXCELIST
 N PXCEINTF,PXCEDT
 S PXCEINTF=$P($T(INTRFACE^@("PXCE"_PXCECATS)),";;",2)
 Q:PXCEINTF=""
 S PXCEDT=+^TMP("PXK",$J,"VST",1,0,"AFTER")
 D GETLST^IBDF18A(PXCEHLOC,PXCEINTF,PXCELIST,,,,PXCEDT)
 Q:'$G(@PXCELIST@(0))
 S @PXCELIST=PXCECATS
 Q
 ;
NEWENC ;Displays warning before adding a new historical encounter.
 W !!,"This will create a historical encounter for documenting a clinical encounter"
 W !,"only and will not be used by Scheduling, Billing or Workload credit."
 D PAUSE
 Q
 ;
PAUSE ;
 N DIR
 W !
 S DIR(0)="E"
 D ^DIR
 W !
 Q
 ;
WAIT ;
 N DIR
 W !
 S DIR("A")="Enter RETURN to continue "
 S DIR(0)="EA"
 D ^DIR
 W !
 Q
 ;
 ;from TIUHELP   ;ISL/JER - On-line help library ;
 ;;pre1.0;Text Integration Utilities;;Jul 24, 1995
PROTOCOL ; Help for protocols
 N DIRUT,DTOUT,DUOUT,TIUX,ORU,ORUPRMT,VALMDDF,VALMPGE S TIUX=X
 D FULL^VALM1
 I TIUX="?" D  G PROTX
 . D DISP^XQORM1 W !!,"Enter selection by typing the name, or abbreviation.",!,"Enter '??' for additional details.",!
 . I TIUX="?" W:$$STOP ""
 I TIUX="??" D MENU(XQORNOD) I $D(DIROUT) S (XQORQUIT,XQORPOP)=1 Q
PROTX S VALMBCK="R"
 Q
MENU(XQORNOD) ; Unwind protocol menus for help
 N TIUSEQ,TIUI,TIUJ D CLEAR^VALM1
 W:$$CONTINUE "Valid selections are:",!
 S TIUI=0 F  S TIUI=$O(^ORD(101,+XQORNOD,10,TIUI)) Q:+TIUI'>0  D
 . S TIUJ=+$P($G(^ORD(101,+XQORNOD,10,TIUI,0)),U,3) S:$D(TIUSEQ(TIUJ)) TIUJ=TIUJ+.1
 . S TIUSEQ(TIUJ)=+$P(^ORD(101,+XQORNOD,10,TIUI,0),U)
 S TIUI=0 F  S TIUI=$O(TIUSEQ(TIUI)) Q:+TIUI'>0!$D(DIRUT)  D
 . I $D(^ORD(101,+TIUSEQ(TIUI),0)) D ITEM(+TIUSEQ(TIUI),1)
 Q
ITEM(XQORNOD,TAB) ; Show descriptions of items
 N TIUI
 Q:$P($G(^ORD(101,+XQORNOD,0)),U,2)']""
 W:$$CONTINUE ?+$G(TAB),$G(IOINHI),$$UPPER($P($G(^ORD(101,+XQORNOD,0)),U,2)),$G(IOINORM),!
 I $D(DIRUT) Q
 S TIUI=0 F  S TIUI=$O(^ORD(101,+XQORNOD,1,TIUI)) Q:+TIUI'>0!$D(DIRUT)  D
 . W:$$CONTINUE ?(TAB+2),$G(^ORD(101,+XQORNOD,1,TIUI,0)),! Q:$D(DIRUT)
 ;S TIUI=0 F  S TIUI=$O(^ORD(101,+XQORNOD,10,TIUI)) Q:+TIUI'>0  D
 ;. D ITEM(+$G(^ORD(101,+XQORNOD,10,+TIUI,0))_";ORD(101,",3)
 Q
 ;
CONTINUE() ; Pagination control
 N Y
 I $Y<(IOSL-2) S Y=1 G CONTX
 S Y=$$STOP("",1) W:+Y @IOF,!
CONTX Q Y
 ;
STOP(PROMPT,SCROLL) ; Call DIR at bottom of screen
 N DIR,DA,X,Y
 I $E(IOST)'="C" S Y="" G STOPX
 I +$G(SCROLL),(IOSL>($Y+5)) F  W ! Q:IOSL<($Y+6)
 S DIR(0)="FO^1:1",DIR("A")=$S($G(PROMPT)]"":PROMPT,1:"Press RETURN to continue or '^' to exit")
 S DIR("?")="Enter '^' to quit present action or '^^' to quit to menu"
 D ^DIR I $D(DIRUT),(Y="") K DIRUT
 S Y=$S(Y="^":0,Y="^^":0,$D(DTOUT):"",Y="":1,1:1_U_Y)
STOPX Q Y
 ;
UPPER(X) ; Convert lower case X to UPPER CASE
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
