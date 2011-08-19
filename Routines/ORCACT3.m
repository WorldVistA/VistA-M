ORCACT3 ;SLC/MKB-Delayed Orders ; 08 May 2002  2:12 PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**7,45,48,79,141**;Dec 17, 1997
EN ; -- main entry point
 K ORVP D EN^ORQPT Q:'$G(ORVP)
 S ORTAB="DELAY" D EN^VALM("OR DELAYED ORDERS")
 Q
 ;
EN1(ORVP) ; -- entry point for use with DGPM MOVEMENT EVENTS
 Q:'$$ACCESS^ORCHTAB  ;CPRS not in user's option menu tree
 Q:'$G(ORVP)  Q:'$$REVIEW(DFN)
 N ORTAB,DFN ;protect DFN within event protocol
 S DFN=+ORVP,ORVP=DFN_";DPT(",ORTAB="DELAY" D SLCT1^ORQPT
 D EN^VALM("OR DELAYED ORDERS")
 Q
 ;
REVIEW(PAT) ; -- Want to review delayed orders?
 N X,Y,DIR Q:'$D(^OR(100,"AEVNT",PAT_";DPT(")) 0
 S DIR(0)="YA",DIR("A")="Review delayed orders? ",DIR("B")="YES"
 S DIR("?")="Answer YES to review this patient's delayed orders"
 D ^DIR
 Q +Y
 ;
INIT ; -- init variables and list array
 D TAB^ORCHART(ORTAB)
 Q
 ;
PHDR ; -- protocol menu header code
 N ORM,ORI,ORS,ORSYN
 S VALMSG=$$MSG^ORCHART D SHOW^VALM
 S ORM=+$O(^ORD(101,"B","ORC DELAY ACTIONS",0))
 S XQORM("#")=ORM_"^1:"_+$P($G(^TMP("OR",$J,"DELAY",0)),U,2),ORI=0
 F  S ORI=+$O(^ORD(101,ORM,10,"B",ORI)) Q:ORI<1  I $D(^ORD(101,ORI,2)) D
 . S ORS=0 F  S ORS=$O(^ORD(101,ORI,2,ORS)) Q:ORS'>0  S ORSYN=$G(^(ORS,0)) S:$L(ORSYN) XQORM("KEY",ORSYN)=+ORI_"^1"
 Q
 ;
HELP ; -- help code
 N X W !!,"Enter the display numbers of the items you wish to act on; a menu of"
 W !,"available actions will then be presented for selection."
 W !,"Press <return> to continue ..." R X:DTIME S VALMBCK=""
 Q
 ;
EXIT ; -- exit code
 D UNLOCK^ORX2(+ORVP) K ^TMP("OR",$J),^TMP("LRRR",$J)
 K VALMCNT,VALMHDR,VALMBG,ORQUIT,ORVP,ORSEX,ORTAB,ORPNM,ORSSN,ORL,ORDOB,ORAGE,ORPD,ORNP,ORSC,ORTS,ORWARD,ORATTEND,ORNMBR,ORACTION,OREBUILD,OREVENT
 Q
 ;
DC ; -- cancel orders
 W !!,"This action is no longer supported." H 2
 S VALMBCK=""
 Q
 ;
RELEASE ; -- Release orders to the service
 W !!,"This action is no longer supported." H 2
 S VALMBCK=""
 Q
 ;
TS ; -- Edit treating specialty
 W !!,"This action is no longer supported." H 2
 S VALMBCK=""
 Q
