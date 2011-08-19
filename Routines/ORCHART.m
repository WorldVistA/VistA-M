ORCHART ;SLC/MKB/REV-OE/RR ; 11 March 2003 14:02
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**7,27,48,70,72,92,141,181**;Dec 17, 1997
EN ; -- main entry point
 K ^TMP("OR",$J) ;ensure fresh start
 D EN^ORQPT Q:+$G(ORVP)'>0
 D EN^VALM("OR CHART") G:'$G(OREXIT) EN
 K OREXIT
 Q
 ;
INIT ; -- init variables and list array
 S:'$D(ORTAB) ORTAB=$$UP^XLFSTR($$GET^XPAR("ALL","ORCH INITIAL TAB",1,"E"))
 S:ORTAB="DCSUMM" ORTAB="SUMMRIES" S:'$L(ORTAB) ORTAB="COVER"
 S ORACTION=0 D TAB(ORTAB)
 Q
 ;
PHDR ; -- protocol header code
 N ORM,ORI,ORS,ORSYN K ORNMBR,OREBUILD
 S:$G(ORTAB)'="LABS" VALMSG=$$MSG D SHOW^VALM
 S:XQORM("B")="Quit" XQORM("B")=$S('$G(DGPMT):"Chart Contents",1:"Close Patient Chart")
 S:$G(^TMP("OR",$J,"CURRENT","#")) XQORM("#")=^("#")
 S ORM=$S(ORTAB="CONSULTS":+$O(^ORD(101,"B","ORC CONSULT SERVICE MENU",0)),1:+$G(XQORM("#"))),ORI=0 ;set XQORM("KEY",<synonym>)
 F  S ORI=$O(^ORD(101,ORM,10,"B",ORI)) Q:ORI'>0  I $D(^ORD(101,+ORI,2)) D
 . S ORS=0 F  S ORS=$O(^ORD(101,+ORI,2,ORS)) Q:ORS'>0  S ORSYN=$G(^(ORS,0)) S:$L(ORSYN) XQORM("KEY",ORSYN)=+ORI_"^1"
 S XQORM("KEY","EX")=$O(^ORD(101,"B","ORC EXIT",0))_"^1"
 S XQORM("KEY","NEXT")=$O(^ORD(101,"B","ORC NEXT SCREEN",0))_"^1"
 S XQORM("KEY","PL")=$O(^ORD(101,"B","ORC PRINT LIST",0))_"^1"
 Q
 ;
HDR ; -- header code
 ;    Expects ORPNM, ORSSN, ORL, ORDOB, ORAGE [, ORPD]
 ;    N DFN S DFN=+ORVP D SLCT1^ORQPT if any are missing ??
 N ORX,ORX1,ORX2,ORX3,ORCWAD,L,SP K VALMHDR
 S ORX1=$P($G(^DPT(+ORVP,0)),U,3),ORX3=$$FMTE^XLFDT(ORX1,2)_"("_ORAGE_")"
 S ORX2="" I +$G(ORL) D  S:$L($G(ORL(1))) ORX2=ORX2_"/"_ORL(1)
 . S L=$G(^SC(+ORL,0)),ORX2=$P(L,U,2)
 . S:'$L(ORX2) ORX2=$E($P(L,U),1,4)
 S L=80-$L(ORPNM)-$L(ORSSN)-$L(ORX2)-$L(ORX3),SP=$$REPEAT^XLFSTR(" ",L\3)
 S ORX1=ORPNM_SP_ORSSN_SP_ORX2,VALMHDR(1)=ORX1_$J(ORX3,80-$L(ORX1))
 S ORX1=$S(ORATTEND:"Attend: "_$$LNAMEF^ORCHTAB(ORATTEND),1:"")
 S ORX2="PrimCare: "_$$LNAMEF^ORCHTAB(+$$OUTPTPR^SDUTL3(+ORVP))
 S ORX3="PCTeam: "_$P($$OUTPTTM^SDUTL3(+ORVP),U,2)
 S ORX=$S($L(ORX1):$$LJ^XLFSTR(ORX1,20),1:"")_ORX2,VALMHDR(2)=$$LJ^XLFSTR(ORX,42)_ORX3
 S ORCWAD=$$CWAD^ORQPT2(+ORVP) S:ORCWAD]"" ORCWAD="<"_ORCWAD_">"
 S ORX=$S($G(ORTAB)="COVER":"",$G(ORTAB)="REPORTS":"",1:$$VIEW),VALMHDR(3)=ORX_$J(ORCWAD,80-$L(ORX))
 Q
 ;
MSG() ; -- LMgr message bar
 Q "Enter the numbers of the items you wish to act on."
 ;
HELP ; -- help code
 N X,DX,DY D FULL^VALM1
 W !!,"Enter the display numbers of the items you wish to change or act on; a menu of",!,"available actions will then be presented for selection."
 W !!,"To see a different 'page' of the chart, enter CC; if you'd like another view of",!,"the current page, by date range for example, enter CV.  You may add new orders"
 W !,"for this patient from any page in the chart by entering AD and review them",!,"using RV.  Enter ?? to see a list of actions available for navigating the list."
 W:ORTAB="PROBLEMS" !!,"* = Acute problem",!,"$ = Unverified problem",!,"# = Problem references inactive code"
 W:(ORTAB="SUMMRIES")!(ORTAB="NOTES") !!,"+ = Addenda attached"
 W:(ORTAB="ORDERS")!(ORTAB="MEDS") !!,"* = Order has been updated by service"
 W:ORTAB="ORDERS" !,"+ = Sub-orders exist"
 W !!,"Press <return> to continue ..." R X:DTIME
 S VALMBCK="R" S:$G(ORTAB)'="LABS" VALMSG=$$MSG
 S (DX,DY)=0 X ^%ZOSF("XY")
 Q
 ;
ITEMHELP ; -- help code for action menus
 N X
 W !!,"Enter the action you wish to take on the items selected and highlighted",!,"above; each item will be processed in order, one at a time."
 W !!,"Press <return> to continue ..." R X:DTIME
 S X="?" D DISP^XQORM1 W !
 Q
 ;
EXIT ; -- exit code
 I $G(ORVP),$$MORE^ORCMENU2 D  ;unsig orders
 . ;I '$D(^TMP("ORNEW",$J)),'$D(^XUSEC("ORES",DUZ)) Q  ;msg like 2.5??
 . W !!,"You have new or unsigned orders for this patient!" H 1
 . S ORRV=1 D EN1^ORCMENU2,NOTIF^ORCMENU2 ;sign, notif if not all signed
 D UNLOCK^ORX2(+ORVP) K ^TMP("OR",$J),^TMP("ORNEW",$J),^TMP("LRRR",$J)
 K VALMCNT,VALMHDR,VALMBG,ORQUIT,ORVP,ORSEX,ORTAB,ORPNM,ORSSN,ORL,ORDOB,ORAGE,ORPD,ORNP,ORSC,ORTS,ORWARD,ORATTEND,ORNMBR,ORACTION,OREBUILD,OREBLD,ORRV,OREVENT
 Q
 ;
TAB(NEWTAB,REBUILD) ; -- switch focus to new chart tab from ORTAB
 S VALMBCK="",VALMBG=$S($G(ORTAB)'=NEWTAB:1,'$G(VALMBG):1,1:VALMBG)
 S ORTAB=NEWTAB I '$G(^TMP("OR",$J,ORTAB,0))!($G(REBUILD)) D
 . W !,"Searching the patient's chart ..."
 . D FULL^VALM1,EN^ORCHTAB ; [re]build list
 D CLEAN^VALM10 M ^TMP("OR",$J,"CURRENT")=^TMP("OR",$J,ORTAB)
 M ^TMP("VALM VIDEO",$J,VALMEVL)=^TMP("OR",$J,"CURRENT","VIDEO")
 I $D(^TMP("OR",$J,"CURRENT","CAPTION")) D
 . N FLD,LBL S FLD=""
 . F  S FLD=$O(^TMP("OR",$J,"CURRENT","CAPTION",FLD)) Q:FLD=""  S LBL=$G(^(FLD)) D CHGCAP^VALM(FLD,LBL)
 S VALM("TITLE")=$G(^TMP("OR",$J,"CURRENT","TITLE")),VALM("RM")=^("RM")
 S:$D(^TMP("OR",$J,"CURRENT","MENU")) XQORM("HIJACK")=^("MENU")
 S VALMCNT=+$G(^TMP("OR",$J,"CURRENT",0)),VALMLFT=$P(VALMDDF("DATA"),U,2)
 D HDR S VALMBCK="R" ; reset VALMHDR nodes
 Q
 ;
NEWPAT ; -- Select new patient
 I $$MORE^ORCMENU2 D  ;unsigned orders
 . ;I '$D(^TMP("ORNEW",$J)),'$D(^XUSEC("ORES",DUZ)) Q
 . W !!,"You have new or unsigned orders for this patient!" H 1
 . S ORRV=1 D EN1^ORCMENU2,NOTIF^ORCMENU2 ;sign, notif if not all signed
 N TAB,OLD,T,ORT,CTXT K ORRV S OLD=+ORVP,TAB=ORTAB
 D EN^ORQPT I OLD=+ORVP S VALMBCK="R" D:$G(OREBUILD) REBLD^ORCMENU K OREBUILD Q  ; no change
 S T="" F  S T=$O(^TMP("OR",$J,T)) Q:T=""  D
 . I T="MEDS" K ^TMP("OR",$J,T) Q
 . S CTXT=$P($G(^TMP("OR",$J,T,0)),U,3) S:$L(CTXT) ORT(T,0)="^^"_$S(T="NOTES"&($P(CTXT,";",3)=1):"",1:CTXT)_U_$P(^(0),U,4) ; save tab contexts
 D UNLOCK^ORX2(+ORVP) K ^TMP("OR",$J),^TMP("ORNEW",$J),^TMP("LRRR",$J)
 K VALMHDR,ORTAB,ORNEW,OREBUILD,OREBLD
 M ^TMP("OR",$J)=ORT D TAB(TAB) S VALMBCK="R"
 Q
 ;
ORDERS(ACTION) ; -- Return order numbers to act on, if action chosen first
 N X,Y,DIR,MAX S:'$L($G(ACTION)) ACTION="act on"
 S MAX=+$P($G(^TMP("OR",$J,ORTAB,0)),U,2) Q:MAX'>0 "^"
 S DIR(0)="LAO^1:"_MAX,DIR("A")="Select item(s): " S:MAX=1 DIR("B")=1
 S DIR("?")="Enter the items you wish to "_ACTION_", as a range or list of numbers"
 D ^DIR S:$D(DTOUT)!(Y="") Y="^"
 Q Y
 ;
ALL ; -- Return all items on ORTAB
 N X,Y,DIR,MAX
 S MAX=+$P($G(^TMP("OR",$J,ORTAB,0)),U,2) Q:MAX'>0 ""
 S DIR(0)="L^1:"_MAX,DIR("V")="",X="1-"_MAX D ^DIR
 Q Y
 ;
SELECT(NMBR) ; -- rev video on selected items
 N ORI,ORJ,NUM,ROW,ROWS,VALID S VALID=0
 F ORI=1:1:$L(NMBR,",") S NUM=$P(NMBR,",",ORI) I NUM D
 . I '$L($P($G(@VALMAR@("IDX",NUM)),U)) W !,NUM_" is not a valid selection." H 2 Q
 . S VALID=1
 . S ROW=$P(@VALMAR@("IDX",NUM),U,2),ROWS=$P(^(NUM),U,3)
 . F ORJ=ROW:1:(ROW+ROWS-1) I ORJ'<VALMBG,ORJ'>(VALMBG+VALM("LINES")-1) D
 . . K ^TMP("VALM VIDEO",$J,VALMEVL,ORJ)
 . . D CNTRL^VALM10(ORJ,1,80,IORVON,IORVOFF)
 . . D WRITE^VALM10(ORJ)
 I 'VALID S XQORQUIT=1
 Q
 ;
DESELECT(NMBR) ; -- norm video on selected items
 N ORI,ORJ,NUM,IFN,ROW,ROWS,ON,OFF,I,IDX
 F ORI=1:1:$L(NMBR,",") S NUM=$P(NMBR,",",ORI) I NUM D
 . S IDX=$G(@VALMAR@("IDX",NUM)) Q:'$L(IDX)  ;invalid NUM
 . S IFN=$P(IDX,U),ROW=$P(IDX,U,2),ROWS=$P(IDX,U,3)
 . F ORJ=ROW:1:(ROW+ROWS-1) I ORJ'<VALMBG,ORJ'>(VALMBG+VALM("LINES")-1) D
 . . K ^TMP("VALM VIDEO",$J,VALMEVL,ORJ) Q:'$L(IFN)  ;deleted
 . . S ON=IOINHI,OFF=IOINORM
 . . I ORTAB="ORDERS",$G(^OR(100,+IFN,8,+$P(IFN,";",2),3)) S ON=IORVON,OFF=IORVOFF ; flagged
 . . D CNTRL^VALM10(ORJ,1,5,ON,OFF)
 . . I ORTAB="ORDERS" S I=$F(^TMP("OR",$J,ORTAB,ORJ,0),"*UNSIGNED*") I I D CNTRL^VALM10(ORJ,I-10,10,IOINHI,IOINORM)
 . . I ORTAB="XRAYS" S I=$F(^TMP("OR",$J,ORTAB,ORJ,0),"*ABNORMAL*") I I D CNTRL^VALM10(ORJ,I-10,10,IOINHI,IOINORM)
 . . I ORTAB="LABS" D CNTRL^VALM10(ORJ,24,2,IOINHI,IOINORM)
 . . D:VALMBCK="" WRITE^VALM10(ORJ)
 Q
 ;
CHANGE ; -- Change view of current list
 G EN^ORCHANGE
 Q
 ;
REV(ORVP) ; -- Review orders for patient
 Q:'$G(ORVP)  Q:$D(ZTQUEUED)  Q:$G(DGQUIET)  ;silent
 I $D(SDAMEVT) Q:$S(SDAMEVT=1:0,1:1)  ;continue if new appt
 Q:'$$GET^XPAR("ALL","ORPF REVIEW ON PATIENT MVMT")
 Q:'$$ACCESS^ORCHTAB  ;CPRS not in user's option menu tree
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT,DFN ;protect DFN
 S DFN=+ORVP,ORVP=DFN_";DPT("  Q:'$D(^OR(100,"AC",ORVP))  ; no orders
 S DIR(0)="YA",DIR("A")="Review active orders? ",DIR("B")="YES"
 S DIR("?")="Answer YES to review this patient's active orders"
 D ^DIR Q:Y'>0  K DIR
 D SLCT1^ORQPT Q:'$G(ORVP)
 S ORTAB="ORDERS" D EN^VALM("OR CHART")
 Q
 ;
VIEW() ; -- return line 3 of header w/current view of tab 
 N BEGIN,END,ITEMS,STS,TEXT,X
 I $G(ORTAB)']"" Q ""
 S X=$P($G(^TMP("OR",$J,ORTAB,0)),U,3),TEXT=""
 S BEGIN=$P(X,";"),END=$P(X,";",2),STS=$P(X,";",3),ITEMS=$P(X,";",5)
 I ORTAB="NOTES",(STS'=5) S TEXT=$S(ITEMS:"up to "_ITEMS,1:"all")_$S(STS=1:" notes",STS=2:" unsigned notes",STS=3:" uncosigned notes",STS=4:" signed notes by author",1:"")
 E  D
 . S:$L(BEGIN)!$L(END) TEXT=$$FDATE^VALM1($$DT^ORCHTAB1(BEGIN))_" thru "_$$FDATE^VALM1($$DT^ORCHTAB1(END))
 . I ORTAB="XRAYS",ITEMS>0 S TEXT=$S($L(TEXT):TEXT_", ",1:"")_"limit "_ITEMS
 S:$L(TEXT) TEXT="Current View: "_TEXT,TEXT=$J(TEXT,40+($L(TEXT)\2))
 Q TEXT
