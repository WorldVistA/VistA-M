ORCXPND2 ; SLC/MKB - Expanded display cont ;11/16/04  09:29
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**34,53,75,94,141,216**;Dec 17, 1997
ALLERGY ; -- allergies
 N I,J,X,Y,DATE,SEV,SOURCE D EN1^GMRAOR2(ID,"Y")
 D ITEM^ORCXPND($P(Y,U)),BLANK^ORCXPND
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=" Nature of Reaction: "_$S($P(Y,U,6)="ALLERGY":"Allergy",$P(Y,U,6)="PHARMACOLOGIC":"Adverse Reaction",1:"Unknown") ;216
 S I=$O(Y("S",0)),LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="     Signs/Symptoms: "_$G(Y("S",+I))
 I $O(Y("S",I)) F  S I=$O(Y("S",I)) Q:I'>0  D
 . S LCNT=LCNT+1
 . S ^TMP("ORXPND",$J,LCNT,0)=$$REPEAT^XLFSTR(" ",21)_Y("S",I)
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="               Type: "_$P(Y,U,7)
 I $O(Y("V",0)) S I=0 F  S I=$O(Y("V",I)) Q:I'>0  D
 . S LCNT=LCNT+1
 . S ^TMP("ORXPND",$J,LCNT,0)=$$REPEAT^XLFSTR(" ",23)_$P(Y("V",I),U,2)
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="           Verified: "_$S($P(Y,U,4)="VERIFIED":$P(Y,U,8),1:$P(Y,U,4)) ;216
A1 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Observed/Historical: "_$P(Y,U,5)
 I $O(Y("O",0)) S I=0 F  S I=$O(Y("O",I)) Q:I'>0  D  ; obs dates
 . S DATE=$P(Y("O",I),U),SEV=$P(Y("O",I),U,2)
 . S X=$$REPEAT^XLFSTR(" ",23)_$$DATE(DATE)_$S($L(SEV):" ("_SEV_")",1:"")
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="         Originator: "_$P(Y,U,2)
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=$$REPEAT^XLFSTR(" ",21)_$P(Y,U,3)
 I $O(Y("C",0)) S I=0 F  S I=$O(Y("C",I)) Q:I'>0  D  ; comments
 . D BLANK^ORCXPND
 . S DATE=$P(Y("C",I),U),SOURCE=$P(Y("C",I),U,2)
 . S:SOURCE="ORIGINATOR" SOURCE=$P(Y,U,2) ; use name
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=$J($$DATE(DATE),20)_" "_SOURCE
 . S J=0 F  S J=$O(Y("C",I,J)) Q:J'>0  D
 . . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=Y("C",I,J,0)
 Q
 ;
XRAY ; -- Single xray report per procedure
 N CASE,PROC
 S CASE=0 F  S CASE=$O(^TMP($J,"RAE2",+ORVP,CASE)) Q:CASE'>0  D
 . S PROC="" F  S PROC=$O(^TMP($J,"RAE2",+ORVP,CASE,PROC)) Q:PROC=""  D ITEM^ORCXPND(PROC),BLANK^ORCXPND,XRPT,BLANK^ORCXPND
 Q
 ;
XRSET ; -- Print set of one report for many procedures
 N CASE,PROC
 S CASE=0 F  S CASE=$O(^TMP($J,"RAE2",+ORVP,CASE)) Q:CASE'>0  D
 . S PROC=$O(^TMP($J,"RAE2",+ORVP,CASE,"")) D ITEM^ORCXPND(PROC)
 S CASE=$O(^TMP($J,"RAE2",+ORVP,0)),PROC=$O(^(CASE,"")) ;1st case
 D BLANK^ORCXPND,XRPT,BLANK^ORCXPND
 Q
 ;
XRPT ; -- body of report for CASE, PROC
 N NODE,ST,ORD,X,I,ORIFN,REQPROV
 S ORD=$S($L($G(^TMP($J,"RAE2",+ORVP,"ORD"))):^("ORD"),$L($G(^("ORD",CASE))):^(CASE),1:"") I $L(ORD),ORD'=PROC S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Proc Ordered  : "_ORD
 I $G(EXAMDATE) S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Exam Date     : "_$$DATETIME^ORCHTAB(EXAMDATE)
 I $D(CASENMBR) D  ; Case number(s)
 . S X="" I $G(CASENMBR)<0 S X=$P(CASENMBR,U,2)
 . E  S I="" F  S I=$O(CASENMBR(I)) Q:I=""  S X=X_$S($L(X):", ",1:"")_I
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Case No.      : "_X
 S NODE=$G(^TMP($J,"RAE2",+ORVP,CASE,PROC)),ORIFN=$P(NODE,U,3)
 I ORIFN S REQPROV=+$P($G(^OR(100,+ORIFN,0)),U,4) S:REQPROV LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Req Provider  : "_$$GET1^DIQ(200,REQPROV_",",.01) ;216
 S ST=$P(NODE,U),LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Report Status : "_ST
 I $P(NODE,U,2)="Y" S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="             ** ABNORMAL RESULTS **" D:$D(IOINHI) CNTRL^VALM10(LCNT,13,22,IOINHI,IOINORM)
 D BLANK^ORCXPND S X="Exam Modifiers: "
 I '$O(^TMP($J,"RAE2",+ORVP,CASE,PROC,"M",0)) S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X_"none"
 E  S I=0 F  S I=$O(^TMP($J,"RAE2",+ORVP,CASE,PROC,"M",I)) Q:I'>0  S X=X_^(I),LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X,X="                "
XR1 Q:$$UP^XLFSTR(ST)="NO REPORT"
 D XRTEXT("Clinical History: ","H")
 D XRTEXT("Report: ","R")
 D XRTEXT("Impression: ","I")
 D XRTEXT("Diagnostic Code: ","D"),BLANK^ORCXPND
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Verified by: "_$P($G(^TMP($J,"RAE2",+ORVP,CASE,PROC,"V")),U,2)
 Q
 ;
XRTEXT(CAPTION,SUB) ; -- include wp text
 N DIWL,DIWF,DIWR,ORI,X D BLANK^ORCXPND
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=CAPTION
 S DIWL=1,DIWF="C75" K ^UTILITY($J,"W")
 S ORI=0 F  S ORI=$O(^TMP($J,"RAE2",+ORVP,CASE,PROC,SUB,ORI)) Q:ORI'>0  S X=^(ORI) D ^DIWP
 S ORI=0 F  S ORI=$O(^UTILITY($J,"W",DIWL,ORI)) Q:ORI'>0  S X=^(ORI,0),LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X
 K ^UTILITY($J,"W")
 Q
 ;
ORDERS ; -- orders
 N ORYY,I
 S ORYY="^TMP(""ORTXT"",$J)"
 D DETAIL^ORQ2(.ORYY,+ID)
 S I=0 F  S I=$O(@ORYY@(I)) Q:I'>0  D
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=@ORYY@(I)
 . I $D(@ORYY@("VIDEO",I)) M ^TMP("ORXPND",$J,"VIDEO",LCNT)=@ORYY@("VIDEO",I)
 Q
 ;
DATE(X) ; -- Return formatted date
 N Y S Y=""
 S:X Y=$$FMTE^XLFDT(X,"2M") ;21
 Q Y
 ;
DRUG ; -- UD or Outpt med
 N INPT,X,Y,PROV,DRUG,I,FILLD,RXN
 S INPT=($P(ID,";",2)="I"),DRUG=$P(NODE,U),PROV=$G(^TMP("PS",$J,"P",0))
 D ITEM^ORCXPND(DRUG),BLANK^ORCXPND
 S RXN=$G(^TMP("PS",$J,"RXN",0)) I RXN S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Prescription#:      "_$P(RXN,U)
 S:PROV LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Prescriber:         "_$P(PROV,U,2)
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Total Dose:         "_$P(NODE,U,9)
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Units/Dose:         "_$P(NODE,U,10)
 D MULT("MDR","Route:")
 D MULT("SCH","Schedule:")
 S X=$S(INPT:"Instructions:",1:"Sig:") D WP("SIG",X)
 D WP("PC","Provider Comments:"),WP("SIO","Other Instructions:")
 D BLANK^ORCXPND
D1 I 'INPT D
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Days Supply:        "_$P(NODE,U,7)
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Quantity:           "_$P(NODE,U,8)
 . S:$P(NODE,U,12) LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Last Filled:        "_$$FMTE^XLFDT($P(NODE,U,12),2)
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Refills Remaining:  "_$P(NODE,U,4)
D2 . I $P(RXN,U,6)!$G(^TMP("PS",$J,"REF",0)) S X="Filled:             " D
 .. I $P(RXN,U,6) S FILLD=$P(RXN,U,6)_"^^^"_$P(RXN,U,7)_U_$P(RXN,U,3,4) D FILLED("R")
 .. S I=0 F  S I=$O(^TMP("PS",$J,"REF",I)) Q:I'>0  S FILLD=$G(^(I,0)) D FILLED("R")
 . I $G(^TMP("PS",$J,"PAR",0)) S I=0,X="Partial Fills:      " F  S I=$O(^TMP("PS",$J,"PAR",I)) Q:I'>0  S FILLD=$G(^(I,0)) D FILLED("P")
D3 I INPT,$D(^TMP("PS",$J,"ADM")) D
 . N I,X S X="Admin Times:        ",I=0
 . F  S I=$O(^TMP("PS",$J,"ADM",I)) Q:I'>0  S Y=$G(^(I,0)) S:$L(Y) LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X_Y,X="                    "
 D BLANK^ORCXPND,SDATES
 Q
 ;
FILLED(TYPE) ; -- add FILLD data
 N Y S Y=$$FMTE^XLFDT($P(FILLD,U),2)_" ("_$$ROUTING($P(FILLD,U,5))_")"
 S:TYPE="R"&$P(FILLD,U,4) Y=Y_" released "_$$FMTE^XLFDT($P(FILLD,U,4),2)
 S:TYPE="P"&$P(FILLD,U,3) Y=Y_" Qty: "_$P(FILLD,U,3)
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X_Y,X="                    "
 S:$L($P(FILLD,U,6)) LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X_$P(FILLD,U,6)
 Q
 ;
ROUTING(X) ; -- Returns external form
 N Y S Y=$S($G(X)="M":"Mail",$G(X)="W":"Window",1:$G(X))
 Q Y
 ;
IV ; -- IV Fluid
 N PROV S PROV=$G(^TMP("PS",$J,"P",0))
 D ITEM^ORCXPND("IV Fluid"),BLANK^ORCXPND
 S:PROV LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Prescriber:         "_$P(PROV,U,2)
 D MULT("B","Solution:")
 D MULT("A","Additive:")
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Infusion Rate:      "_$P(NODE,U,2)
 D WP("PC","Provider Comments:"),BLANK^ORCXPND
 D SDATES
 Q
 ;
 ;
MULT(SUB,CAPTION) ; -- add multiple valued item
 N I,FIRST,SPACES,X S FIRST=1,I=0,SPACES="                    "
 F  S I=$O(^TMP("PS",$J,SUB,I)) Q:I'>0  S X=^(I,0),LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=$S(FIRST:CAPTION,1:"")_$E(SPACES,1,20-$L(CAPTION))_$TR(X,"^"," "),FIRST=0,CAPTION=""
 Q
 ;
WP(SUB,CAPTION) ; -- add wp item
 N ORI,FIRST,SPACES,DIWL,DIWR,DIWF,X
 S DIWL=1,DIWR=60,DIWF="C60",ORI=0 K ^UTILITY($J,"W")
 F  S ORI=$O(^TMP("PS",$J,SUB,ORI)) Q:ORI'>0  S X=^(ORI,0) D ^DIWP
 S FIRST=1,ORI=0,SPACES="                    "
 F  S ORI=$O(^UTILITY($J,"W",DIWL,ORI)) Q:ORI'>0  S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=$S(FIRST:CAPTION,1:"")_$E(SPACES,1,20-$L(CAPTION))_^(ORI,0),FIRST=0,CAPTION=""
 K ^UTILITY($J,"W")
 Q
SDATES ; -- add start & stop dates, status
 N RXN S RXN=$G(^TMP("PS",$J,"RXN",0))
 I $P(RXN,U,5) S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Pharmacist:         "_$$GET1^DIQ(200,+$P(RXN,U,5)_",",.01) ;216
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Start Date:         "_$$FMTE^XLFDT($P(NODE,U,5),"2P")
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Stop Date:          "_$$FMTE^XLFDT($P(NODE,U,3),"2P")
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Status:             "_$P(NODE,U,6)
 S:$P(NODE,U,11) LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="Order #"_+$P(NODE,U,11)
 Q
