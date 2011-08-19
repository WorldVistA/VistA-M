TIUHELP ; SLC/JER - On-line help library ;2/28/05
 ;;1.0;TEXT INTEGRATION UTILITIES;**100,184**;Jun 20, 1997
 ;
LINKHELP ; Help for link protocol menus
 W !,"      Problems - links to problems in patient's active Problem List;"
 W !," Patient/Visit - reassigns to a different patient and/or visit;"
 W !,"  Other Applic - links, for example, a Consult Result to a Request, or",!,"                   a PRF Note to a Patient Record Flag."
 Q
 ;
PROTOCOL ; Help for protocols
 N DIRUT,DTOUT,DUOUT,TIUX,ORU,ORUPRMT,VALMDDF,VALMPGE S TIUX=X
 D FULL^VALM1
 I TIUX="?"!(TIUX="??") D  G PROTX
 . I TIUX="??",($G(VALMAR)="^TMP(""TIUR"",$J)") D STATUS I $D(DIRUT) W ! Q
 . D DISP^XQORM1 W !!,"Enter selection by typing the name, or abbreviation.",!,"Enter '??' or '???' for additional details.",!
 . I TIUX="?" W:$$STOP^TIUU ""
 I TIUX="???" D MENU(XQORNOD) I $D(DIROUT) S (XQORQUIT,XQORPOP)=1 Q
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
 W:$$CONTINUE ?+$G(TAB),$G(IOINHI),$$UPPER^TIULS($P($G(^ORD(101,+XQORNOD,0)),U,2)),$G(IOINORM),!
 I $D(DIRUT) Q
 S TIUI=0 F  S TIUI=$O(^ORD(101,+XQORNOD,1,TIUI)) Q:+TIUI'>0!$D(DIRUT)  D
 . W:$$CONTINUE ?(TAB+2),$G(^ORD(101,+XQORNOD,1,TIUI,0)),! Q:$D(DIRUT)
 S TIUI=0 F  S TIUI=$O(^ORD(101,+XQORNOD,10,TIUI)) Q:+TIUI'>0  D
 . D ITEM(+$G(^ORD(101,+XQORNOD,10,+TIUI,0))_";ORD(101,",3)
 Q
STATUS ; Show status descriptions
 W:$$CONTINUE !!,"The Following Statuses are defined:"
 D STATEXP
 W:$$CONTINUE !!,"The Following Indicators are defined:",!!
 W:$$CONTINUE " '+' to the left of the Title or Patient's name indicates that",!,"     a report has addenda.",!
 W:$$CONTINUE " '*' to the left of the Title or Patient's name indicates",!,"     a priority (STAT) document.",!
 W:$$CONTINUE " '<' to the left of the Title or Patient's name indicates an",!,"     interdisciplinary note, which can be expanded to show entries.",!
 W:$$CONTINUE " '>' to the left of the Title or Patient's name indicates",!,"     that the note is an entry of an interdisciplinary note.",!
 ;W:$$CONTINUE "These will appear at the top of the list.",!
 Q
CONTINUE() ; Pagination control
 N Y
 I $Y<(IOSL-2) S Y=1 G CONTX
 S Y=$$STOP^TIUU("",1) W:+Y @IOF,!
CONTX Q Y
STATEXP ; Explain Statuses
 N TIUI,TIUJ,TIUY S TIUI=0
 D STATUS^TIUSRVL(.TIUY,"ALL",1)
 F  S TIUI=$O(TIUY(TIUI)) Q:+TIUI'>0  D
 . I TIUI>1 W:$$CONTINUE !
 . W:$$CONTINUE !,$G(IOINHI),$P(TIUY(TIUI),U,2),$G(IOINORM)
 . S TIUJ=0 F  S TIUJ=$O(TIUY(TIUI,1,TIUJ)) Q:+TIUJ'>0  D
 . . W:$$CONTINUE !?2,$G(TIUY(TIUI,1,TIUJ))
 Q
