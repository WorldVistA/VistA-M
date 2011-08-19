USRHELP ; SLC/JER,PKR - On-line help library ;2/9/98
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**3**;Jun 20, 1997
 ;This is a direct copy of TIUHELP with TIU only portions removed.
 ;======================================================================
PROTOCOL ; Help for protocols
 N DIRUT,DTOUT,DUOUT,USRX,ORU,ORUPRMT,VALMDDF,VALMPGE S USRX=X
 D FULL^VALM1
 I USRX="?"!(USRX="??") D  G PROTX
 . D DISP^XQORM1 W !!,"Enter selection by typing the name, or abbreviation.",!,"Enter '??' or '???' for additional details.",!
 . I USRX="?" W:$$STOP^USRU ""
 I USRX="???" D MENU(XQORNOD) I $D(DIROUT) S (XQORQUIT,XQORPOP)=1 Q
PROTX S VALMBCK="R"
 Q
 ;======================================================================
MENU(XQORNOD) ; Unwind protocol menus for help
 N USRSEQ,USRI,USRJ D CLEAR^VALM1
 W:$$CONTINUE "Valid selections are:",!
 S USRI=0 F  S USRI=$O(^ORD(101,+XQORNOD,10,USRI)) Q:+USRI'>0  D
 . S USRJ=+$P($G(^ORD(101,+XQORNOD,10,USRI,0)),U,3) S:$D(USRSEQ(USRJ)) USRJ=USRJ+.1
 . S USRSEQ(USRJ)=+$P(^ORD(101,+XQORNOD,10,USRI,0),U)
 S USRI=0 F  S USRI=$O(USRSEQ(USRI)) Q:+USRI'>0!$D(DIRUT)  D
 . I $D(^ORD(101,+USRSEQ(USRI),0)) D ITEM(+USRSEQ(USRI),1)
 Q
 ;======================================================================
ITEM(XQORNOD,TAB) ; Show descriptions of items
 N USRI
 Q:$P($G(^ORD(101,+XQORNOD,0)),U,2)']""
 W:$$CONTINUE ?+$G(TAB),$G(IOINHI),$$UPPER^USRLS($P($G(^ORD(101,+XQORNOD,0)),U,2)),$G(IOINORM),!
 I $D(DIRUT) Q
 S USRI=0 F  S USRI=$O(^ORD(101,+XQORNOD,1,USRI)) Q:+USRI'>0!$D(DIRUT)  D
 . W:$$CONTINUE ?(TAB+2),$G(^ORD(101,+XQORNOD,1,USRI,0)),! Q:$D(DIRUT)
 S USRI=0 F  S USRI=$O(^ORD(101,+XQORNOD,10,USRI)) Q:+USRI'>0  D
 . D ITEM(+$G(^ORD(101,+XQORNOD,10,+USRI,0))_";ORD(101,",3)
 Q
 ;======================================================================
CONTINUE() ; Pagination control
 N Y
 I $Y<(IOSL-2) S Y=1 G CONTX
 S Y=$$STOP^USRU("",1) W:+Y @IOF,!
CONTX Q Y
