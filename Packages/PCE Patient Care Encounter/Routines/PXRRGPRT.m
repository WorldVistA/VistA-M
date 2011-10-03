PXRRGPRT ;ISL/PKR - PCE reports general printing routines. 4/17/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**3,12,20**;Aug 12, 1996
 ;
 ;=======================================================================
CLASSNE(INDENT) ;Print the selected Person Classes that had no encounters.
 ;PXRRPECL is the input list, the fourth piece is "M" if a match was
 ;found.
 N CLS,IC,NOMATCH,TEMP
 S NOMATCH=0
 F IC=1:1:NCL Q:NOMATCH  D
 . I $P(PXRRPECL(IC),U,4)'="M" S NOMATCH=1
 ;
 ;Print the list.
 I NOMATCH D
 . W !!,?INDENT,"The following selected Person Classes had no encounters that met the"
 . W !,?INDENT,"selection criteria:"
 . S CLS=INDENT+INDENT
 . F IC=1:1:NCL D
 .. S TEMP=PXRRPECL(IC)
 .. I $P(TEMP,U,4)'="M" D
 ... W !!,?CLS,"Occupation:   ",$P(TEMP,U,1)
 ... W !,?CLS,"Specialty:    ",$P(TEMP,U,2)
 ... W !,?CLS,"Subspecialty: ",$P(TEMP,U,3)
 Q
 ;
 ;=======================================================================
FACNE(INDENT) ;Print the selected facilities that had no encounters.
 ;PXRRFAC is the input list, the fourth piece is "M" if a match was
 ;found.
 N IC,IND,NOMATCH,TEMP
 S NOMATCH=0
 F IC=1:1:NFAC Q:NOMATCH  D
 . I $P(PXRRFAC(IC),U,4)'="M" S NOMATCH=1
 ;
 ;Print the list.
 I NOMATCH D
 . W !!,"The following selected Facilities had no encounters that met the selection"
 . W !,"criteria:"
 . F IC=1:1:NFAC D
 .. I $P(PXRRFAC(IC),U,4)'="M" D
 ... S IND=$P(PXRRFAC(IC),U,1)
 ... S TEMP=PXRRFACN(IND)
 ... W !,?INDENT,$P(TEMP,U,1)," ",$P(TEMP,U,2)
 Q
 ;
 ;=======================================================================
HDR(PAGE) ;
 I $E(IOST)="C",IO=IO(0) W @IOF
 E  W !
 N TEMP,TEXTLEN
 S TEMP=$$NOW^XLFDT,TEMP=$$FMTE^XLFDT(TEMP,"P")
 S TEMP=TEMP_"  Page "_PAGE
 S TEXTLEN=$L(TEMP)
 W ?(IOM-TEXTLEN),TEMP
 ;PXRROPT should be newed in the main driver.
 I '$D(PXRROPT) D
 . S PXRROPT=$$TITLE
 . I ($L(PXRROPT)>0)&(PXRROPT'["PCE") S PXRROPT="PCE "_PXRROPT
 S TEXTLEN=$L(PXRROPT)
 I TEXTLEN>0 D
 . W !!
 . W ?((IOM-TEXTLEN)/2),PXRROPT
 Q
 ;
 ;=======================================================================
OLRCRIT(PSTART) ;Output the location report criteria.
 N ED,SD
 W !?PSTART,"Location selection criteria:",?32,$P(PXRRLCSC,U,2)
 S SD=$$FMTE^XLFDT(PXRRBDT)
 S ED=$$FMTE^XLFDT(PXRREDT)
 W !?PSTART,"Encounter date range:",?32,SD," through ",ED
 I $D(PXRRSCAT) D OSCAT(PXRRSCAT,PSTART)
 I $D(PXRRENTY) D OENTYPE(PXRRENTY,PSTART)
 W !,"___________________________________________________________________"
 Q
 ;
 ;=======================================================================
OENTYPE(ENTYL,PSTART) ;Output the encounter types used for screening the encounters.
 N IC,CSTART,EM,ENTYPE,ENTTEXT
 S CSTART=PSTART+3
 W !,?PSTART,"Encounter types:",?32,ENTYL
 F IC=1:1:$L(ENTYL) D
 . S ENTYPE=$E(ENTYL,IC,IC)
 . S ENTTEXT=$$EXTERNAL^DILFD(9000010,15003,"",ENTYPE,.EM)
 . W !,?CSTART,ENTYPE," - ",ENTTEXT
 Q
 ;
 ;=======================================================================
OPRCRIT(PSTART) ;Output the provider report criteria.
 N ED,SD
 W !?PSTART,"Provider selection criteria:",?32,$P(PXRRPRSC,U,2)
 S SD=$$FMTE^XLFDT(PXRRBDT)
 S ED=$$FMTE^XLFDT(PXRREDT)
 W !?PSTART,"Report date range:",?32,SD," through ",ED
 D OSCAT(PXRRSCAT,PSTART)
 I $P($G(PXRRPRSC),U,1)="C" D PECLASS^PXRRGPRT(PSTART)
 I $D(PXRRENTY) D OENTYPE(PXRRENTY,PSTART)
 W !,"___________________________________________________________________"
 Q
 ;
 ;=======================================================================
OSCAT(SCL,PSTART) ;Output the service categeories used for screening the encounters.
 N IC,CSTART,EM,SC,SCTEXT
 S CSTART=PSTART+3
 W !,?PSTART,"Service categories:",?32,SCL
 F IC=1:1:$L(SCL) D
 . S SC=$E(SCL,IC,IC)
 . S SCTEXT=$$EXTERNAL^DILFD(9000010,.07,"",SC,.EM)
 . W !,?CSTART,SC," - ",SCTEXT
 Q
 ;
 ;=======================================================================
PAGE ;form feed to new page
 I ($E(IOST)="C")&(IO=IO(0)) D
 . S DIR(0)="E"
 . W !
 . D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT)) S DONE=1 Q
 W:$D(IOF) @IOF
 S PAGE=PAGE+1
 D HDR^PXRRGPRT(PAGE)
 S HEAD=1
 Q
 ;
 ;=======================================================================
PECLASS(CLS) ;Print the list of selected Person Classes.
 N IC,TEMP
 S TEMP=$P(PXRRPRSC,U,2)_":  "
 W !!,TEMP
 F IC=1:1:NCL D
 . S TEMP=PXRRPECL(IC)
 . I IC>1 W !
 . W !,?CLS,"Occupation:   ",$P(TEMP,U,1)
 . W !,?CLS,"Specialty:    ",$P(TEMP,U,2)
 . W !,?CLS,"Subspecialty: ",$P(TEMP,U,3)
 Q
 ;
 ;=======================================================================
PTOTAL(TEXT,TOTAL,END,LINE) ;Print totals.
 N IC,TEXLEN,TOTLEN
 S TEXLEN=$L(TEXT)
 S TOTLEN=$L(TOTAL)
 I LINE D
 . W !,?(END-TOTLEN-1) F IC=1:1:TOTLEN+2 W "_"
 W !,?(END-TEXLEN-TOTLEN),TEXT,?(END-TOTLEN),TOTAL,!
 Q
 ;
 ;=======================================================================
TITLE() ;Set title from option file name.
 N XQOPT
 I +$G(XQY)>0 D OP^XQCHK
 Q $P($G(XQOPT),U,2)
 ;
