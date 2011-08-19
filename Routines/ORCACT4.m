ORCACT4 ;SLC/MKB-Act on orders cont ; 08 May 2002  2:12 PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**7,27,116,141,149,190**;Dec 17, 1997
XX ; -- Edit/Change order ORIFN
 N ORDIALOG,ORQUIT,FIRST,X,OREDIT,ORCHECK,ORSTS,ORDA,OR0,ORDG,ORNMSP,OREVENT,ORDUZ,ORLOG,ORTYPE
 K ^TMP("ORWORD",$J) S FIRST=0,ORTYPE="D"
 S OR0=$G(^OR(100,+ORIFN,0)),ORSTS=$P(^(3),U,3),ORDG=$P(OR0,U,11)
 I $P(OR0,U,17),ORSTS=10 S OREVENT=$P(OR0,U,17)
 S OREDIT=$S(ORSTS=11:0,ORSTS=10:0,1:1),ORNMSP=$$NMSP^ORCD($P(OR0,U,14))
 S X=$P(OR0,U,5) I X'["101.41" D  ; 2.5
 . N X,WP S ORDIALOG=$$PTR^ORCD("OR GXTEXT WORD PROCESSING ORDER")
 . D GETDLG^ORCD(ORDIALOG) S WP=$$PTR^ORCD("OR GTX WORD PROCESSING 1")
 . S ORDIALOG(WP,1)="^TMP(""ORWORD"","_$J_","_WP_",1)"
 . M ^TMP("ORWORD",$J,WP,1)=^OR(100,+ORIFN,1) ; edit order text
 . S X=$O(^TMP("ORWORD",$J,WP,1,0)) I X,$E(^(X,0),1,3)=">> " S ^TMP("ORWORD",$J,WP,1,X,0)=$E(^OR(100,+ORIFN,1,X,0),4,999)
 I X["101.41" S ORDIALOG=+X S:$P($G(^ORD(101.41,+X,0)),U,4)'="D" ORDIALOG=+$P($G(^ORD(100.98,+$P(OR0,U,11),0)),U,4) D GETDLG^ORCD(ORDIALOG),GETORDER^ORCD(+ORIFN)
 X:$D(^ORD(101.41,+ORDIALOG,3)) ^(3) G:$G(ORQUIT) XXQ ; entry action
 D DISPLAY^ORCHECK ;pkg order checks
XX1 D DIALOG^ORCDLG G:$G(ORQUIT)&FIRST XXQ
 I '$$CHANGED W !!,"Nothing changed!" H 2 Q
 D ACCEPT^ORCHECK(),DISPLAY^ORCDLG S X=$$OK(ORACT)
 G:X="^" XXQ I X="E" K ORCHECK G XX1
 I X="C" W !?10,"... changes cancelled.",! G XXQ
 I X="P" D XX^ORCSAVE W !?10,$S(ORIFN:"... changes placed.",1:"ERROR"),! S:ORIFN ^TMP("ORNEW",$J,ORIFN,1)=""
XXQ X:$D(^ORD(101.41,+ORDIALOG,4)) ^(4) K ^TMP("ORWORD",$J) ; exit action
 Q
 ;
CHANGED() ; -- Returns 1 or 0, if order was actually changed
 N OROLD,P,I,Y D GETORDER^ORCD(+ORIFN,"OROLD") S Y=0
 S P=0 F  S P=$O(ORDIALOG(P)) Q:P'>0  D  Q:Y
 . S I=0 F  S I=$O(OROLD(P,I)) Q:I'>0  D CHK Q:Y
 . Q:Y  S I=0 F  S I=$O(ORDIALOG(P,I)) Q:I'>0  D CHK Q:Y
 Q Y
 ;
CHK N OLD,NEW S OLD=$G(OROLD(P,I)),NEW=$G(ORDIALOG(P,I)) S:NEW'=OLD Y=1
 ;I $E(ORDIALOG(P,0))'="W" S:NEW'=OLD Y=1 Q
 ;I @OLD@(0)'=@NEW@(0) S Y=1
 Q
 ;
RN ; -- Renew order ORIFN
 N ORDIALOG,ORQUIT,FIRST,ORENEW,ORCHECK,ORDA,OR0,OR3,ORDG,ORNMSP,ORDUZ,ORLOG,ORTYPE,X
 K ^TMP("ORWORD",$J) S FIRST=0,ORENEW=1,ORTYPE="D"
 S OR0=$G(^OR(100,+ORIFN,0)),OR3=$G(^(3)),ORDIALOG=+$P(OR0,U,5)
 S ORNMSP=$$NMSP^ORCD($P(OR0,U,14)),ORDG=$P(OR0,U,11)
 I $P(OR3,U,9) D  Q:$G(ORQUIT)
 . I $$DOSES($P(OR3,U,9))'>1 Q  ;dose+Now only - ok
 . W !,$C(7),"This is part of a complex order, which must be renewed in its entirety:"
 . S I=0 F  S I=$O(^OR(100,+$P(OR3,U,9),8,1,.1,I)) Q:I<1  S X=$G(^(I,0)) W:$$UP^XLFSTR(X)'=" FIRST DOSE NOW" !,X
 . S:'$$OKALL ORQUIT=1 I '$G(ORQUIT) S ORIFN=+$P(OR3,U,9)
 I $P(OR0,U,5)["101.41" S:$P($G(^ORD(101.41,ORDIALOG,0)),U,4)'="D" ORDIALOG=+$P($G(^ORD(100.98,+$P(OR0,U,11),0)),U,4) D GETDLG^ORCD(ORDIALOG),GETORDER^ORCD(+ORIFN) K ORDIALOG($$PTR^ORCD("OR GTX NOW"),1)
 I $P(OR0,U,5)'["101.41" D  ; protocol -> use WP dialog for renewal
 . N STOP,WP,X S ORDIALOG=$$PTR^ORCD("OR GXTEXT WORD PROCESSING ORDER")
 . D GETDLG^ORCD(ORDIALOG)
 . S WP=$$PTR^ORCD("OR GTX WORD PROCESSING 1"),ORDIALOG(WP,1)="^TMP(""ORWORD"","_$J_","_WP_",1)" M ^TMP("ORWORD",$J,WP,1)=^OR(100,+ORIFN,1)
 . S X=$O(^TMP("ORWORD",$J,WP,1,0)) I X,$E(^(X,0),1,3)=">> " S ^TMP("ORWORD",$J,WP,1,X,0)=$E(^OR(100,+ORIFN,1,X,0),4,999)
 . S STOP=$P(OR0,U,9) I STOP,STOP>$$NOW^XLFDT S ORDIALOG($$PTR^ORCD("OR GTX START DATE/TIME"),1)=STOP
 X:$D(^ORD(101.41,+ORDIALOG,3)) ^(3) G:$G(ORQUIT) RNQ ; entry action
 D DISPLAY^ORCHECK ;pkg order checks
RN1 D DIALOG^ORCDLG G:$G(ORQUIT) RNQ
 D ACCEPT^ORCHECK() S X="P"
 I $G(ORCHECK) D DISPLAY^ORCDLG S X=$$OK(ORACT) G:X="^" RNQ
 I X="C" W !?10,"... renewal cancelled.",! G RNQ
 I X="P" D RN^ORCSAVE W !?10,$S(ORIFN:"... order renewed.",1:"ERROR"),! S:ORIFN ^TMP("ORNEW",$J,ORIFN,1)=""
RNQ X:$D(^ORD(101.41,+ORDIALOG,4)) ^(4) K ^TMP("ORWORD",$J)
 Q
 ;
DOSES(IFN) ; -- Return #doses in order IFN
 N I,P,CNT S (I,CNT)=0
 F  S I=$O(^OR(100,IFN,4.5,"ID","INSTR",I)) Q:I<1  S CNT=CNT+1
 Q CNT
 ;
OKALL() ; -- OK to renew all child orders of complex?
 N X,Y,DIR,DTOUT,DUOUT,DIROUT,DIRUT
 S DIR(0)="YA",DIR("A")=" ...OK? ",DIR("B")="YES"
 S DIR("?")="Enter YES to continue and renew the entire complex order as shown, or NO to quit."
 D ^DIR S:$D(DTOUT)!(X["^") Y="^"
 Q Y
 ;
RW ; -- Rewrite order ORIFN
 N ORDIALOG,ORQUIT,FIRST,OREWRITE,ORCHECK,ORDA,OR0,ORDG,ORNMSP,ORDUZ,ORLOG,ORTYPE,X
 K ^TMP("ORWORD",$J) S FIRST=1,OREWRITE=1,ORTYPE="D"
 S OR0=$G(^OR(100,+ORIFN,0)),ORNMSP=$$NMSP^ORCD($P(OR0,U,14)),ORDG=$P(OR0,U,11),ORDIALOG=+$P(OR0,U,5)
 I $P(OR0,U,5)["101.41" D  ;get dialog, responses
 . S:$P($G(^ORD(101.41,ORDIALOG,0)),U,4)'="D" ORDIALOG=+$P($G(^ORD(100.98,+$P(OR0,U,11),0)),U,4)
 . I ORNMSP="PS",$G(OREVENT) D  ;use generic Meds dlg
 .. N X S X=$P($G(^ORD(100.98,+ORDG,0)),U,3)
 .. Q:X="IV RX"  Q:X="SPLY"  ;don't switch these
 .. S ORDIALOG=+$O(^ORD(101.41,"AB","PS MEDS",0))
 . D GETDLG^ORCD(ORDIALOG),GETORDER^ORCD(+ORIFN)
 . S X=$$PTR^ORCD("OR GTX URGENCY") K:$G(ORDIALOG(X,1))=99 ORDIALOG(X,1)
 I $P(OR0,U,5)'["101.41" D  ; protocol -> use WP dialog for renewal
 . N WP,X S ORDIALOG=$$PTR^ORCD("OR GXTEXT WORD PROCESSING ORDER")
 . D GETDLG^ORCD(ORDIALOG)
 . S WP=$$PTR^ORCD("OR GTX WORD PROCESSING 1"),ORDIALOG(WP,1)="^TMP(""ORWORD"","_$J_","_WP_",1)" M ^TMP("ORWORD",$J,WP,1)=^OR(100,+ORIFN,1)
 . S X=$O(^TMP("ORWORD",$J,WP,1,0)) I X,$E(^(X,0),1,3)=">> " S ^TMP("ORWORD",$J,WP,1,X,0)=$E(^OR(100,+ORIFN,1,X,0),4,999)
 X:$D(^ORD(101.41,+ORDIALOG,3)) ^(3) G:$G(ORQUIT) RWQ
 D DISPLAY^ORCHECK ;pkg order checks
RW1 D DIALOG^ORCDLG G:$G(ORQUIT)&FIRST RWQ
 D ACCEPT^ORCHECK() ;($S(FIRST:"ALL",1:""))
 I $G(OREVENT),$G(^ORE(100.2,+OREVENT,1)) D  ;event occurred
 . W !!,"This release event has occurred since you started copying delayed orders."
 . W !,"The orders that were signed have now been released; this and any other"
 . W !,"unsigned orders will be released immediately upon signature."
 . N X W !!,"Press <return> to continue ..." R X:DTIME K OREVENT
 D DISPLAY^ORCDLG S X=$$OK^ORCDLG G:X="^" RWQ
 I X="E" S FIRST=0 K ORCHECK G RW1
 I X="C" W !?10,"... order cancelled.",! G RWQ
 I X="P" D
 . N OLDIFN,ORSRC S OLDIFN=+ORIFN,ORSRC="C" K ORIFN D EN^ORCSAVE
 . W !?10,$S($G(ORIFN):"... order rewritten.",1:"ERROR"),!
 . I $G(ORIFN) S ^TMP("ORNEW",$J,ORIFN,1)="" S:$D(^OR(100,OLDIFN,5)) ^OR(100,ORIFN,5)=^OR(100,OLDIFN,5)
RWQ X:$D(^ORD(101.41,+ORDIALOG,4)) ^(4) K ^TMP("ORWORD",$J)
 Q
 ;
HD ; -- Hold order ORIFN
 N X S X=$$ACTION^ORCSAVE(ORACT,+ORIFN,ORNP) Q:'X
 S ^TMP("ORNEW",$J,+ORIFN,X)=""
 W !?10,"... hold order placed."
 Q
 ;
RL ; -- Release hold on order ORIFN
 N X S X=$$ACTION^ORCSAVE(ORACT,+ORIFN,ORNP) Q:'X
 S ^TMP("ORNEW",$J,+ORIFN,X)=""
 W !?10,"... release hold order placed."
 Q
 ;
OK(ACT) ; -- Ready to save?
 N X,Y,DIR
 S DIR(0)="SA^P:PLACE;C:CANCEL;"_$S(ACT'="RN":"E:EDIT;",1:"")
 S:ACT="XX" DIR("A")="(P)lace, (E)dit, or (C)ancel changes? ",DIR("?")="Enter P to save the changes to this order, or E to change any of the displayed values; enter C to quit without changing this order"
 S:ACT="RN" DIR("A")="(P)lace or (C)ancel renewal? ",DIR("?")="Enter P to save this renewal or C to quit without renewing this order"
 S DIR("B")="PLACE" D ^DIR S:$D(DTOUT) Y="^"
 Q Y
