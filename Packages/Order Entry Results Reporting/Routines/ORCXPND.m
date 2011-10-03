ORCXPND ; SLC/MKB - Expanded Display ;6/3/97  11:04
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
RESULTS ; -- Results Display
 N ORESULTS S ORESULTS=1
EN ; -- main entry point for OR DETAILED DISPLAY
 I '$G(ORNMBR) S ORNMBR=$$ORDERS^ORCHART("display") I 'ORNMBR S VALMBCK="" Q
 D EN^VALM("OR DETAILED DISPLAY") S VALMBCK="R"
 Q
 ;
EN1(DFN,ID,ORTAB) ; -- entry point for independent display
 Q:'DFN  Q:'$D(ID)  S:'$D(ORTAB) ORTAB="ORDERS"
 N ORNMBR,ORVP,ORPNM,ORSSN,ORDOB,ORAGE,ORSEX,ORTS,ORWARD,ORATTEND,ORL,OREBUILD
 S ORNMBR=-1,^TMP("OR",$J,ORTAB,"IDX",ORNMBR)=ID D SLCT1^ORQPT
 D EN^VALM("OR DETAILED DISPLAY")
 Q
 ;
INIT ; -- init variables and list array
 ; ORNMBR=#[,#,...,#] of selection[s]
 N LCNT,ORPIECE,NUM,ID S LCNT=0
 F ORPIECE=1:1:$L(ORNMBR,",") S NUM=$P(ORNMBR,",",ORPIECE) I NUM D:LCNT BORDER S ID=$P($G(^TMP("OR",$J,ORTAB,"IDX",NUM)),U) D @(ORTAB_"^ORCXPND1") ; create ^TMP("ORXPND",$J)
 S VALMCNT=LCNT,VALM("TITLE")=$$TITLE(ORTAB)
 M ^TMP("VALM VIDEO",$J,VALMEVL)=^TMP("ORXPND",$J,"VIDEO")
 Q
 ;
BORDER ; -- Insert border between items
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="   "
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=$$REPEAT^XLFSTR("*",79)
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="   "
 Q
 ;
MSG ; -- set msg line, XQORM("KEY")
 N ACTION S ACTION=$P($G(^TMP("ORXPND",$J,0)),U,2)
 I '$L(ACTION) S VALMSG="Enter ? for more help." Q
 I ACTION="NEW" S VALMSG="Enter NW to place another order.",XQORM("KEY","NW")=$O(^ORD(101,"B","ORCB NEW ORDER",0))_"^1"
 I ACTION="RENEW" S VALMSG="Enter RN to renew this order.",XQORM("KEY","RN")=$O(^ORD(101,"B","ORCB RENEW ORDER",0))_"^1"
 I ACTION="REPLACE" S VALMSG="Enter RP to replace this order.",XQORM("KEY","RP")=$O(^ORD(101,"B","ORCB REPLACE ORDER",0))_"^1"
 Q
 ;
MARGIN ; -- Reset bottom margin if menu display off
 N BM S BM=$S(VALMMENU:17,1:21) Q:BM=VALM("BM")  ; no change
 S VALM("BM")=BM,VALM("LINES")=VALM("BM")-VALM("TM")+1,VALMBCK="R"
 Q
 ;
HELP ; -- help code
 N X S VALMBCK="" I 'VALMMENU D FULL^VALM1 S VALMBCK="R"
 W !!,"Use the actions listed to scroll up and down, to view the data; if you want",!,"to search the data for a particular string, enter SL.  You may print the"
 W !,"data, either the entire list or just the current screen, by entering PL or PS",!,"respectively.  Enter Q when finished to return to the chart."
 W !!,"Press <return> to continue ..." R X:DTIME
 Q
 ;
EXIT ; -- exit code
 K ^TMP("ORXPND",$J)
 Q
 ;
SETVIDEO(LINE,COL,WIDTH,ON,OFF) ; -- set video attributes
 S ^TMP("ORXPND",$J,"VIDEO",LINE,COL,WIDTH)=ON
 S ^TMP("ORXPND",$J,"VIDEO",LINE,COL+WIDTH,0)=OFF
 Q
 ;
BLANK ; -- blank line
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="   "
 Q
 ;
ITEM(X) ; -- set name of item into display
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X
 I $D(IORVON),$D(IORVOFF) D SETVIDEO(LCNT,1,$L(X),IORVON,IORVOFF)
 Q
 ;
TITLE(TAB) ; -- Screen title
 N Y S Y=""
 S:TAB="COVER" Y="Allergies/Alerts"
 S:TAB="NOTES" Y="Progress Note"
 S:TAB="PROBLEMS" Y="Problem"
 S:TAB="MEDS" Y="Medication"
 S:TAB="LABS" Y="Laboratory"
 S:TAB="ORDERS" Y=$S($G(ORESULTS):"Results",1:"Order")
 S:TAB="REPORTS" Y="Report"
 S:TAB="CONSULTS" Y="Consult/Procedure"
 S:TAB="XRAYS" Y="Radiology"
 S:TAB="SUMMRIES" Y="Discharge Summary"
 S:TAB="PTINQ" Y="Patient Inquiry"
 S:(TAB="NEW")!(TAB="DELAY") Y="Order"
 Q Y_" Display"
