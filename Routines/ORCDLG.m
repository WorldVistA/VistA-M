ORCDLG ;SLC/MKB-Order dialogs ; 08 May 2002  2:12 PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**4,7,46,60,79,94,141**;Dec 17, 1997
 ;
EN(ORDIALOG) ; -- process ORDIALOG
 Q:'ORDIALOG  N TITLE,TYPE,MSG K ^TMP("ORWORD",$J)
 S TITLE=$G(^ORD(101.41,ORDIALOG,0)),TYPE=$P(TITLE,U,4),MSG=$P(TITLE,U,3),TITLE=$P(TITLE,U,2)
 W !!,?(36-($L(TITLE)\2)),"-- "_TITLE_" --"
 I $L(MSG) W $C(7),!!,MSG H 2 Q  ;disabled
 D SET:TYPE="O",MENU:TYPE="M",ADD:(TYPE="D")!(TYPE="Q")!(TYPE="A")
 K ^TMP("ORWORD",$J)
 Q
 ;
SET ; -- prompt for new order set
 N ORSET,ORSEQ,ORSITM,ORSTOP,ORPARENT,ORCHLD,ORS0,ORSIFN,ORPIFN,ORLAST,ORSLOG,X,OREV0
 S ORSET=+ORDIALOG Q:'ORSET  Q:'$D(^ORD(101.41,ORSET))
 I $G(OREVENT) S X=+$P($G(^ORE(100.2,OREVENT,0)),U,2),OREV0=$G(^ORD(100.5,X,0))
 X:$D(^ORD(101.41,ORSET,3)) ^(3) ; Entry action
 S ORPARENT=$P($G(^ORD(101.41,ORSET,5)),U,6) ;,ORHDR=$P($G(^(5)),U,7)
 S ORSLOG=+$E($$NOW^XLFDT,1,12) D:ORPARENT SET^ORCSAVE(+ORDIALOG) ;Parent
S1 S ORSEQ=0 F  S ORSEQ=$O(^ORD(101.41,ORSET,10,"B",ORSEQ)) Q:ORSEQ'>0!($G(ORSTOP))  S ORSITM=0 F  S ORSITM=$O(^ORD(101.41,ORSET,10,"B",ORSEQ,ORSITM)) Q:'ORSITM  D  Q:$G(ORSTOP)
 . S ORS0=$G(^ORD(101.41,ORSET,10,ORSITM,0)) K ORSIFN
 . I $G(OREVENT),$G(ORDSET),+$P(ORS0,U,2)=+$P(OREV0,U,4) Q  ;Evt Ord Dlg
 . D:$P(ORS0,U,2) EN(+$P(ORS0,U,2))
 . I $G(ORSTOP) Q:$G(DIROUT)  K:$$CONT ORSTOP Q
 . I ORPARENT,$G(ORSIFN) S ORCHLD=+$G(ORCHLD)+1,ORCHLD(ORSIFN,0)=ORSIFN,ORLAST=ORSIFN
S2 I $G(ORSTOP) D  G SQ ; delete orders
 . N DA,DIK
 . S DA=0 F  S DA=$O(ORCHLD(DA)) Q:DA'>0  S DIK="^OR(100," D ^DIK
 . W !?10,"... orders cancelled.",! H 1
 I ORPARENT,$G(ORCHLD) M ^OR(100,ORPIFN,2)=ORCHLD S ^OR(100,ORPIFN,2,0)="^100.002PA^"_ORLAST_U_ORCHLD
 ;W !?10,"... orders placed.",! H 1
SQ X:$D(^ORD(101.41,ORSET,4)) ^(4) ; Exit action
 Q
 ;
MENU ; -- prompt for menu
 N ORI,ORY,XQORM
 S ORI=$$LOCK^ORDD41(ORDIALOG) I 'ORI W !!,$P(ORI,U,2) H 2 Q
 X:$D(^ORD(101.41,ORDIALOG,3)) ^(3) G:$G(ORQUIT) MNQ ;Entry action
 S XQORM("W")="W $S($P(X,U,5)=""H"":IOUON,1:"""")_$P(X,U,3)_IOUOFF"
 S ORI=$G(^ORD(101.41,ORDIALOG,5)) S:$P(ORI,U,2) XQORM("M")=$P(ORI,U,2)
 S XQORM=ORDIALOG_";ORD(101.41,",XQORM(0)="AD" D EN^XQORM
 I Y'>0 S:$G(ORSET)&(X["^") ORSTOP=1 G MNQ
 M ORY=Y S ORI=0 F  S ORI=$O(ORY(ORI)) Q:ORI'>0  D EN(+$P(ORY(ORI),U,2))
MNQ X:$D(^ORD(101.41,ORDIALOG,4)) ^(4) ;Exit action
 D UNLOCK^ORDD41(ORDIALOG)
 Q
 ;
ORDER(ORDIALOG) ; -- Execute ORDIALOG, return ORIFN or ^ if unsuccessful
 K ^TMP("ORWORD",$J) Q:'$G(ORDIALOG) "^"
 N TITLE,TYPE,MSG,NODE0,FIRST,ORDG,ORQUIT,VERIFY,ACTION,ASK,AUTO,ORIFN,ORTYPE,ORCHECK,ORNMSP,ORDUZ,ORLOG
 S TITLE=$G(^ORD(101.41,ORDIALOG,0)),TYPE=$P(TITLE,U,4),MSG=$P(TITLE,U,3),TITLE=$P(TITLE,U,2)
 W !!,?(36-($L(TITLE)\2)),"-- "_TITLE_" --"
 I $L(MSG) W $C(7),!!,MSG H 2 Q "^" ;disabled
 I TYPE'="D",TYPE'="Q" W $C(7),!!,"Invalid order dialog!" H 2 Q "^"
 D ADD0 S:'$G(ORIFN) ORIFN="^"
 K ^TMP("ORWORD",$J)
 Q ORIFN
 ;
ADD ; -- prompt for new order
 ;    Requires:  ORDIALOG = Order Dialog ifn
 ;               ORNP     = Ordering Provider (ifn in #200)
 ;               ORVP     = Patient (vptr to #2)
 ;    Optional:  ORL      = Patient Location (vptr to #44)
 ;               ORTS     = Treating Specialty (ifn in #45.7)
 ;               ORSET    = Order Set (ifn in #101.41, from SET)
 ;    $$ORDER enters at ADD0 to be able to return ORIFN
 ;
 N NODE0,FIRST,ORDG,ORQUIT,VERIFY,ACTION,ASK,AUTO,ORIFN,ORTYPE,ORCHECK,ORNMSP,ORDUZ,ORLOG
ADD0 S VALMBCK="R",FIRST=1 Q:'ORDIALOG
 S NODE0=$G(^ORD(101.41,ORDIALOG,0)),AUTO=$P($G(^(5)),U,8)
 S ORTYPE=$P(NODE0,U,4),ORDG=+$P(NODE0,U,5),ORDUZ=DUZ
 S ORLOG=+$$NOW,VERIFY=$P(NODE0,U,8),ASK=$P(NODE0,U,9)
 D @("GET"_$S(ORTYPE="Q":"Q",1:"")_"DLG^ORCD(+ORDIALOG)")
 I ORDIALOG'>0 W $C(7),!!,"Invalid dialog - cannot place order!" H 1 Q
 S ORNMSP=$P($G(^ORD(101.41,ORDIALOG,0)),U,7),ORNMSP=$$NMSP^ORCD(ORNMSP)
 I '$$ACTIVE W $C(7),!!,"Inactive orderable item(s) - cannot place order!" H 1 Q
 X:$D(^ORD(101.41,+ORDIALOG,3)) ^(3) G:$G(ORQUIT) ADDQ ; entry action
 G:ORTYPE="A" ADDQ ; action only
 D DISPLAY^ORCHECK ; pkg order check
ADD1 D DIALOG ; Loop thru prompts or components
 I $G(ORQUIT) S:$G(ORSET) ORSTOP=1 G:$G(ORSTOP)!$G(DIROUT)!FIRST ADDQ K ORQUIT
 D ACCEPT^ORCHECK() S ACTION="P"
 I $G(OREVENT),$G(^ORE(100.2,+OREVENT,1)) D  ;event occurred
 . W !!,"This release event has occurred since you started writing delayed orders."
 . W !,"The orders that were signed have now been released; this and any other"
 . W !,"unsigned orders will be released immediately upon signature.  The Orders"
 . W !,"tab will be refreshed in the Active Orders view when finished."
 . K OREVENT S $P(^TMP("OR",$J,"ORDERS",0),U,3,4)="^1" ;default view
 . N X W !!,"Press <return> to continue ..." R X:DTIME
 I VERIFY!$G(ORCHECK) D DISPLAY S ACTION=$$OK G:ACTION="^" ADDQ
 I ACTION="E" S FIRST=0 K ORCHECK G ADD1
 I ACTION="C" W !?10,"... order cancelled.",! ;G ADDQ
 I ACTION="P" D EN^ORCSAVE D
 . I '$G(ORIFN) W !?10,"... ERROR - unable to place order.",! H 1 Q
 . S ^TMP("ORNEW",$J,ORIFN,1)="" S:$G(ORSET) ORSIFN=ORIFN
 . I '$D(^TMP("ORECALL",$J,ORDIALOG)) M ^(ORDIALOG)=ORDIALOG M:$D(^TMP("ORWORD",$J)) ^TMP("ORECALL",$J,ORDIALOG)=^TMP("ORWORD",$J) ;1st values
 . W !?10,"... order placed.",!
 I ASK,$$ANOTHER D KVALUES S FIRST=1,ORLOG=+$$NOW G ADD1
ADDQ X:$D(^ORD(101.41,+ORDIALOG,4)) ^(4) ; exit action
 Q
 ;
DIALOG ; -- loop through prompts in dialog
 N SEQ,DA K ORQUIT
 I $G(ORTYPE)'="A" S SEQ=0 F  S SEQ=$O(^ORD(101.41,+ORDIALOG,10,"B",SEQ)) Q:SEQ'>0!($G(ORQUIT))  S DA=0 F  S DA=$O(^ORD(101.41,+ORDIALOG,10,"B",SEQ,DA)) Q:'DA  D  Q:$G(ORQUIT)
 . Q:$P(^ORD(101.41,+ORDIALOG,10,DA,0),U,11)  ; child
 . D EN^ORCDLG1(DA)
 Q
 ;
ANOTHER() ; -- Add another order?
 I ASK>1 Q 1 ; Don't ask, go right to another order
 N X,Y,DIR
 S DIR("A")="Add another "_$P(^ORD(101.41,+ORDIALOG,0),U,2)_" order? "
 S DIR(0)="YA",DIR("B")="NO" D ^DIR
 Q +Y
 ;
CONT() ; -- continue w/set?
 N X,Y,DIR
 S DIR(0)="YA",DIR("A")="Do you want to continue with this order set? "
 S DIR("?")="Enter NO if you wish to cancel the entire order set; YES will cancel only this one order."
 S DIR("B")="YES" D ^DIR
 Q +Y
 ;
DISPLAY ; -- Display new order on screen
 N SEQ,DA,X,PROMPT,MULT,I,TITLE
 W !!,$$REPEAT^XLFSTR("-",79)
 S SEQ=0 F  S SEQ=$O(^ORD(101.41,+ORDIALOG,10,"B",SEQ)) Q:SEQ'>0  S DA=0 F  S DA=$O(^ORD(101.41,+ORDIALOG,10,"B",SEQ,DA)) Q:'DA  D
 . S X=$G(^ORD(101.41,+ORDIALOG,10,DA,0)) Q:$P(X,U,11)  ;child
 . S PROMPT=$P(X,U,2),MULT=$P(X,U,7) Q:$P(X,U,9)["*"  ;hide
 . Q:'PROMPT  S I=$O(ORDIALOG(PROMPT,0)) Q:'I  ; no values
 . S TITLE=$S($L($G(ORDIALOG(PROMPT,"TTL"))):ORDIALOG(PROMPT,"TTL"),1:ORDIALOG(PROMPT,"A"))
 . W !,$J(TITLE,30)
 . I $E(ORDIALOG(PROMPT,0))="W" W $E($G(^TMP("ORWORD",$J,PROMPT,I,1,0)),1,40)_$S($L($G(^(0)))>40:" ...",$O(^TMP("ORWORD",$J,PROMPT,I,1)):" ...",1:"") Q
 . W $$ITEM(PROMPT,I) Q:'MULT  Q:'$O(ORDIALOG(PROMPT,I))  ; done
 . F  S I=$O(ORDIALOG(PROMPT,I)) Q:I'>0  W !?30,$$ITEM(PROMPT,I)
 W !,$$REPEAT^XLFSTR("-",79),!
 I $G(ORCHECK) W "Order Checks:" D LIST^ORCHECK("NEW")
 Q
 ;
ITEM(P,I) ; -- Display each item in dialog
 N ITEM,SEQ,DA,IFN,X,ORDTXT
 S ITEM=$$EXT^ORCD(P,I) I $E(ORDIALOG(P,0))="R",$G(ORTYPE)'="Z",'$G(OREVENT) S X=ORDIALOG(P,I) S:'X ITEM=ITEM_$$DATE(X)
 I $D(^ORD(101.41,+ORDIALOG,10,"DAD",P)) S SEQ=0 F  S SEQ=$O(^ORD(101.41,+ORDIALOG,10,"DAD",P,SEQ)) Q:SEQ'>0  S DA=$O(^(SEQ,0)) D
 . S IFN=$P(^ORD(101.41,+ORDIALOG,10,DA,0),U,2),ORDTXT=$G(^(2)) Q:$P(^(0),U,9)["*"
 . Q:'$D(ORDIALOG(IFN,I))  Q:$E(ORDIALOG(IFN,0))="W"
 . S X=$$EXT^ORCD(IFN,I) Q:'$L(X)
 . S:$L($P(ORDTXT,U,4)) X=$$GETXT^ORCSAVE1($P(ORDTXT,U,4))_" "_X
 . S:$L($P(ORDTXT,U,5)) X=X_" "_$$GETXT^ORCSAVE1($P(ORDTXT,U,5))
 . S ITEM=ITEM_" "_X
 Q ITEM
 ;
DATE(X) ; -- Returns resolved date
 N Y,%DT S %DT="T"
 D AM^ORCSAVE2:X="AM",NEXT^ORCSAVE2:X="NEXT"
 D ADMIN^ORCSAVE2("NEXT"):X="NEXTA",ADMIN^ORCSAVE2("CLOSEST"):X="CLOSEST"
 D ^%DT S:Y'>0 Y="" I Y>0 S Y=" ("_$$FMTE^XLFDT(Y,2)_")"
 Q Y
 ;
OK() ; -- Ready to save?
 N X,Y,DIR
 S DIR(0)="SA^P:PLACE;E:EDIT;C:CANCEL;",DIR("A")="(P)lace, (E)dit, or (C)ancel this order? ",DIR("B")="PLACE"
 S DIR("?")="Enter P to place this order, or E to change any of the displayed values; enter C to quit without placing this order"
 D ^DIR S:$D(DTOUT) Y="^"
 Q Y
 ;
KVALUES ; -- kill ORDIALOG("ORDERABLE ITEM",#) value nodes
 N PTR,INST K ORIFN,ORCHECK,^TMP("ORWORD",$J)
 S PTR=0 F  S PTR=$O(ORDIALOG(PTR)) Q:PTR'>0  D
 . K ORDIALOG(PTR,"LIST") S INST=0
 . F  S INST=$O(ORDIALOG(PTR,INST)) Q:INST'>0  K ORDIALOG(PTR,INST)
 Q
 ;
NOW() ; -- Returns current Date Ordered for new order
 N Y I $G(ORSLOG) S Y=ORSLOG ; timestamp for order set
 E  S Y=+$E($$NOW^XLFDT,1,12)
 Q Y
 ;
ACTIVE()        ; -- Returns 1 or 0, if orderable item(s) are active
 ;       [Uses ORDIALOG(),ORDG,ORNMSP]
 N OI,NOW,I,ITM,X,Y
 S OI=+$$PTR^ORCD("OR GTX ORDERABLE ITEM"),NOW=$$NOW^XLFDT,Y=1
 S I=0 F  S I=+$O(ORDIALOG(OI,I)) Q:I'>0  D  Q:'Y
 . S ITM=+$G(ORDIALOG(OI,I)) Q:ITM'>0
 . S X=$G(^ORD(101.43,ITM,.1)) I X,X<NOW S Y=0 Q  ;inactive
 I 'Y,ORNMSP?1"PS".E D  ;ck for new OI, if PS
 . Q:$P($G(^ORD(100.98,+$G(ORDG),0)),U,3)="IV RX"  ;skip fluids
 . Q:$G(ORCAT)="I"&$G(ORENEW)  ;skip Inpt renewals
 . N DD,J,DRUG,PSOI S DD=+$$PTR^ORCD("OR GTX DISPENSE DRUG")
 . S J=+$O(ORDIALOG(DD,0)),DRUG=+$G(ORDIALOG(DD,J)) ;first one
 . S PSOI=+$P($G(^ORD(101.43,+$G(ORDIALOG(OI,1)),0)),U,2)
 . S X=$$ITEM^PSSUTIL1(PSOI,DRUG) Q:X'>0
 . S ITM=+$O(^ORD(101.43,"ID",+$P(X,U,2)_";99PSP",0)) Q:ITM'>0
 . S X=$G(^ORD(101.43,ITM,.1)) I X,X<NOW Q  ;just checking
 . S ORDIALOG(OI,1)=ITM,Y=1
 Q Y
