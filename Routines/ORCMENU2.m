ORCMENU2 ;SLC/MKB-Review New Orders ;4/5/01  21:32
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**7,48,72,108**;Dec 17, 1997
EN ; -- main entry point
 I '$$MORE W !!,"You have no new or unsigned orders for this patient." S VALMBCK="" H 1 Q
EN1 ; -- enter here from ORCHART when exiting chart
 N ORTAB K OREBLD D EN^VALM("OR NEW ORDERS")
 Q
 ;
EX ; -- main exit point
 I $G(OREBUILD)!$G(OREBLD) F TAB="ORDERS","COVER","MEDS","LABS","XRAYS","CONSULTS" D:TAB=$G(ORTAB) TAB^ORCHART(TAB,1) I TAB'=$G(ORTAB),$D(^TMP("OR",$J,TAB,0)) S $P(^(0),U)=""
 S:$D(^TMP("OR",$J,"CURRENT","MENU")) XQORM("HIJACK")=^("MENU")
 K OREBUILD,OREBLD
 Q
 ;
INIT ; -- init variables and list array
 I $G(ORRV),'$$MORE S VALMBCK="Q" Q
 W !,"Searching the patient's chart ..."
 D CLEAN^VALM10 S ORTAB="NEW" D EN^ORCHTAB
 S VALMCNT=+$G(^TMP("OR",$J,"NEW",0)),VALM("TITLE")=$G(^("TITLE"))
 M ^TMP("VALM VIDEO",$J,VALMEVL)=^TMP("OR",$J,ORTAB,"VIDEO")
 S VALMBG=1,VALMBCK="R"
 Q
 ;
PHDR ; -- protocol menu header code
 S VALMSG=$$MSG^ORCHART D SHOW^VALM
 S:$G(OREBUILD) OREBLD=1 K ORNMBR,OREBUILD
 S XQORM("#")=$O(^ORD(101,"B","ORC NEW ACTIONS",0))_"^1:"_+$P($G(^TMP("OR",$J,"NEW",0)),U,2)
 I XQORM("B")="Quit",$P($G(^TMP("OR",$J,"NEW",0)),U,2) S XQORM("B")=$S('$$GET^XPAR("ALL","ORPF NEW ORDERS DEFAULT"):"Sign All Orders",1:"Sign & Release")
 S XQORM("KEY","DC")=$O(^ORD(101,"B","ORC DISCONTINUE ORDERS",0))_"^1"
 S XQORM("KEY","ED")=$O(^ORD(101,"B","ORC CHANGE ORDERS",0))_"^1"
 S XQORM("KEY","DT")=$O(^ORD(101,"B","ORC DETAILED DISPLAY",0))_"^1"
 S XQORM("KEY","$")=$O(^ORD(101,"B","ORC SIGN ORDERS",0))_"^1"
 S XQORM("KEY","SIGN")=XQORM("KEY","$")
 Q
 ;
HELP ; -- help code
 N X W !!,"Enter the display numbers of the items you wish to act on; a menu of"
 W !,"available actions will then be presented for selection."
 W !,"Press <return> to continue ..." R X:DTIME S VALMBCK=""
 Q
 ;
EXIT ; -- exit code
 K ^TMP("OR",$J,"NEW")
 Q
 ;
NOTIF ; -- Trigger notification for new orders left unsigned
 Q:'$O(^TMP("ORNEW",$J,0))  N ORIFN,ORDA,ORA0,ORERR S ORIFN=0
 F  S ORIFN=$O(^TMP("ORNEW",$J,ORIFN)) Q:ORIFN'>0  S ORDA=0 D
 . F  S ORDA=$O(^TMP("ORNEW",$J,ORIFN,ORDA)) Q:ORDA'>0  D
 .. S ORA0=$G(^OR(100,+ORIFN,8,+ORDA,0))
 .. I ORDA,$P(ORA0,U,4)=2 S ORNP=$P(ORA0,U,3) D NOTIF^ORCSIGN
 .. I ORDA,$P(ORA0,U,4)=3,$$VALID^ORCACT0(ORIFN_";"_ORDA,"ES",.ORERR) D EN^ORCSEND(ORIFN_";"_ORDA,,3,1,,,.ORERR) ;release if ES not req'd
 .. D UNLK1^ORX2(+ORIFN)
 Q
 ;
SIGNALL ; -- sign all new orders
 N ORNMBR,ORMAX,I,LNG
 S ORMAX=+$P($G(^TMP("OR",$J,"NEW",0)),U,2),ORNMBR=""
 F I=1:1:ORMAX S LNG=$L(ORNMBR)+$L(I)+1 S:LNG'>255 ORNMBR=ORNMBR_I_"," I LNG>255 W !,"Range too large; only items #1-"_(I-1)_" will be signed." Q
 D EN^ORCSIGN I '$$MORE S VALMBCK="Q" Q
 D EX^ORCACT
 Q
 ;
MORE() ; -- More orders to process?
 I $O(^TMP("ORNEW",$J,0)) Q 1
 N Y S Y=0 I $D(^XUSEC("ORES",DUZ)) D
 . N IDX,IFN,ACT,ROOT,ENT,PAR
 . S ENT="ALL"_$S($G(^VA(200,DUZ,5)):"^SRV.`"_+^(5),1:"")
 . S PAR=$$GET^XPAR(ENT,"OR UNSIGNED ORDERS ON EXIT") Q:PAR'>0
 . I PAR=2,$O(^OR(100,"AS",ORVP,0)) S Y=1 Q
 . S IDX=$NA(@"^OR(100,""AS"",ORVP)"),ROOT=$TR(IDX,")",",")
 . F  S IDX=$Q(@IDX) Q:$E(IDX,1,$L(ROOT))'=ROOT  S IFN=+$P(IDX,",",5),ACT=+$P(IDX,",",6) I PAR=1,$P($G(^OR(100,IFN,8,ACT,0)),U,3)=DUZ S Y=1 Q
 Q Y
