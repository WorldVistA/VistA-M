GMRCADU ;ABV/PIJ - Consults Report by Released by Policy. Patch GMRC*3.0*107 ;7/5/18 07:36
 ;;3.0;CONSULT/REQUEST TRACKING;**107**;DEC 27, 1997;Build 27
 ;
 ; LOCAL VISTA REPORT BY USER
 ;
 ; Screen Title: Admin Released Consults-User
 ;
EN ; -- main entry point for GMRC RPT ADMIN RELEASE CONSULT
 ;
 N GMRCEDT1,GMRCEDT2
 ;
 D EN^VALM("GMRC RPT ADMIN REL CONS USER")
 Q
 ;
EN1 ;Ask for date range
 ;
 S DIR(0)="DA",DIR("A")="Enter Consult Released Starting Date: "
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) S GMRCQUT=1 Q
 S GMRCDT1=+Y I 'GMRCDT1 G EN1
 W "  (",$$FMTE^XLFDT(GMRCDT1)_")"
 ;
 K DIR
 S DIR(0)="DA",DIR("A")="Enter Consult Released Ending Date: "
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) K GMRCDT1 S GMRCQUT=1 G EXIT
 I +Y<GMRCDT1 W !!,$C(7),"Ending Date Can Not Be Before Starting Date.",! G EN1
 I $G(GMRCDT2)="" S GMRCDT2=+Y
 W "  (",$$FMTE^XLFDT(GMRCDT2)_")"
 ;
 ; Retrieve External Date
 D LISTDATE^GMRCSTU1(GMRCDT1,GMRCDT2,.GMRCEDT1,.GMRCEDT2)
 ;
 Q
 ;
HDR ; -- header code
 N GMRCSITE
 S GMRCSITE=$P($$SITE^VASITE(),U,2)
 S VALMHDR(1)="VAMC: "_GMRCSITE
 S VALMHDR(2)="From: "_$G(GMRCEDT1)_"   To: "_$G(GMRCEDT2)
 Q
 ;
BLDLIST ; -- init variables and list array
 N FMRELDT,I,IENS,LINE,ORDITEM,ORIEN,RELBY
 S (FMRELDT,ORIEN,LINEVAR)=""
 S LINECNT=0
 ;
 K ^TMP("GMRCADU",$J)
 ;
 F  S FMRELDT=$O(^OR(100,"AADMINKEY",FMRELDT)) Q:FMRELDT=""  D
 . F I=GMRCDT1:1:GMRCDT2 I $P(I,".",1)=$P(FMRELDT,".",1) D
 .. ;  Orderable Item
 .. F  S ORIEN=$O(^OR(100,"AADMINKEY",FMRELDT,"Y",ORIEN)) Q:ORIEN=""  D
 ... S IENS="1,"_ORIEN
 ... ;
 ... ; Released By
 ... S RELBY=$$GET1^DIQ(100.008,IENS,17)    ; Released by
 ... I '$D(^TMP("GMRCADU",$J,RELBY)) S ^TMP("GMRCADU",$J,RELBY)=0
 ... S ^TMP("GMRCADU",$J,RELBY)=^TMP("GMRCADU",$J,RELBY)+1
 ... ;
 ... S ORDITEM=$$GET1^DIQ(100.001,IENS,.01) ; Orderable Item
 ... I '$D(^TMP("GMRCADU",$J,RELBY,ORDITEM)) S ^TMP("GMRCADU",$J,RELBY,ORDITEM)=0
 ... S ^TMP("GMRCADU",$J,RELBY,ORDITEM)=^TMP("GMRCADU",$J,RELBY,ORDITEM)+1
 Q
 ;
INIT ;
 K ^TMP("VALMAR",$J)
 N DTOUT,DIR,DUOUT,DIRUT,GMRCQUT,X,Y,TOTAL
 N GMRCDT1,GMRCDT2,LINECNT
 ;
 S (GMRCDT1,GMRCDT2,GMRCEDT1,GMRCEDT2,GMRCQUT)=""
 S (LINECNT,TOTAL,VALMCNT)=0
 ;
 D EN1
 I GMRCQUT S VALMQUIT="",VALMBCK="Q" Q
 ;
 D BLDLIST ;build the list for List Manager
 N NUM,ORDITEM,RELBY
 S (LINE,LINECNT,NUM)=0
 ;
 S LINEVAR=""
 ;
 S RELBY=""
 F  S RELBY=$O(^TMP("GMRCADU",$J,RELBY)) Q:RELBY=""  D
 . S LINECNT=LINECNT+1
 . S LINEVAR=$$SETFLD^VALM1(RELBY,LINEVAR,"ORDITEM")
 . ;
 . S NUM=^TMP("GMRCADU",$J,RELBY)
 . S TOTAL=TOTAL+NUM
 . S LINEVAR=$$SETFLD^VALM1(NUM,LINEVAR,"NUM")
 . D VALM10(LINEVAR)  ; Print first group
 . ;
 . S ORDITEM=""
 . F  S ORDITEM=$O(^TMP("GMRCADU",$J,RELBY,ORDITEM)) D:ORDITEM="" VALM10("") Q:ORDITEM=""  D
 .. S LINEVAR=$$SETFLD^VALM1("  "_ORDITEM,LINEVAR,"ORDITEM")
 .. ;
 .. S NUM=^TMP("GMRCADU",$J,RELBY,ORDITEM)
 .. S LINEVAR=$$SETFLD^VALM1(NUM,LINEVAR,"NUM")
 .. ;
 .. D VALM10(LINEVAR)
 ;
 D VALM10("") ; Enter blank line
 S LINEVAR="GRAND TOTAL "_TOTAL
 D SET^VALM10(LINE,LINEVAR)
 ;
 S VALMBCK="R"
 ;
 K ^TMP("GMRCADU",$J)
 Q
 ;
VALM10(LINEVAR) ;
 S LINE=LINE+1
 D SET^VALM10(LINE,LINEVAR)
 S VALMCNT=LINE
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("VALMAR",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
DTRES ;Restore old date in case user '^' out.
 I $D(GMRCDTS1) S GMRCDT1=GMRCDTS1
 I $D(GMRCDTS2) S GMRCDT2=GMRCDTS2
 K GMRCDTS1,GMRCDTS2
 Q
