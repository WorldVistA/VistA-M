ORCDFHTF ; SLC/MKB - Utility functions for FH Tubefeeding dialog ; 08 May 2002  2:12 PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**7,141,215**;Dec 17, 1997
 ;
EN ; -- entry action
 S ORCAT=$S($$INPT^ORCD:"I",1:"O")
 ;I '$$INPT^ORCD W $C(7),!!,"This patient is not an inpatient!" S ORQUIT=1 H 2 Q
 ;D:'$G(OREVENT) EN^FHWOR8(+ORVP,.ORPARAM) I $G(OREVENT) D
 ;. N X S X=$$LOC^OREVNTX(OREVENT)  Q:X<1
 ;. S X=+$G(^SC(+X,42)) I X,$T(EN1^FHWOR8) D EN1^FHWOR8(X,.ORPARAM)
 ;S:'$L($G(ORPARAM(3))) ORPARAM(3)="T" ; for now
 ; -- show current TF order
 N ORTF,ORTX,I S ORTF=$$CURRENT^ORCDFH("TF") Q:ORTF'>0
 W !!,"An ACTIVE TUBEFEEDING ORDER exists for this patient:",!
 D TEXT^ORQ12(.ORTX,ORTF,80) F I=1:1:ORTX W !,ORTX(I)
 W !,"Total Quantity: "_$$TOTALQTY(ORTF)_" ml",!
 Q
 ;
EX ; -- exit action
 K ORPARAM,ORTIME,ORCAT
 Q
 ;
QUANTITY ; -- Validation code for TF quantity
 N X,ORQTY,I,TOT S X=ORDIALOG(PROMPT,ORI)
 S ORQTY=$$VALIDQTY(X) I '$L(ORQTY) K DONE,ORDIALOG(PROMPT,ORI) Q
 S ORDIALOG(PROMPT,ORI)=ORQTY
 W "   (Amount: "_$$CC(ORI)_"ml)"
 S (I,TOT)=0 F  S I=$O(ORDIALOG(PROMPT,I)) Q:I'>0  S TOT=TOT+$$CC(I)
 I TOT>5000 W $C(7),!!,"WARNING: Total quantity ordered is "_TOT_"ml which exceeds the limit of 5000ml!",!
 Q
 ;
VALIDQTY(X) ; -- Validates quantity X=amt units/freq X times
 N X1,X2,AMT,N,UNITS,F,D,FREQ,DUR
 S X=$$UP^XLFSTR(X),X=$$STRIP^XLFSTR(X," ") ; uppercase, no spaces
 S AMT=+X,X1=$P(X,"/"),X2=$P(X,"/",2) Q:'AMT ""
 S N=$P(X1,AMT,2),UNITS="" F X="^KCAL^K^","^ML^M^CC^C^","^OZ^O^","^UNITS^BOTTLES^CANS^PKG^U^","^TBSP^","^GM^GMS^GRAMS^G^" I X[(U_N_U) S UNITS=$P(X,U,2) Q
 Q:'$L(UNITS) "" S F=$P(X2,"X"),D=$P(X2,"X",2) S:'$L(F) F="QD"
 S FREQ="" F X="^QD^DAY^","^QH^HOUR^HR^","^BID^","^TID^","^QID^","^Q2H^","^Q3H^","^Q4H^","^Q6H^" I X[(U_F_U) S FREQ=$P(X,U,2) Q
 Q:'$L(FREQ) "" S DUR="" S:D DUR=+D_$S(D'["F":"HR",1:"")
 Q AMT_" "_UNITS_"/"_FREQ_$S(DUR:" X "_DUR,1:"")
 ;
CC(INST) ; -- Returns #cc ordered for INSTance
 N X,X1,X2,DUR
 S X=ORDIALOG($$PTR^ORCD("OR GTX INSTRUCTIONS"),INST)
 S X1=ORDIALOG($$PTR^ORCD("OR GTX ORDERABLE ITEM"),INST)
 S X1=+$P($G(^ORD(101.43,+X1,0)),U,2)_"-"_ORDIALOG($$PTR^ORCD("OR GTX STRENGTH FH"),INST),X2=+X_"&"_$E($P(X," ",2))_U_$P($P(X,"/",2)," "),DUR=$P(X," X ",2)
 I $L(DUR) S DUR=$S(DUR["H":"H",1:"X")_+DUR,X2=X2_U_DUR
 S X=$$QUAN^FHWOR5R(X1,X2)
 Q X
 ;
QUANHELP ; -- ??-help for Quantity
 W !!,"Units may be K for Kcals, M for ml, C for cc's, O For oz. or U for units (e.g. cans)."
 W !,"Frequency may be DAY, HOUR, QD, QH, BID, TID, QID, Q2H, Q3H, Q4H, or Q6H."
 W !,"May also input 100ML/HR X 16 for 16 hours.  Valid quantity for powder form"
 W !,"product can be ""# GRAMS"" as 20 G, GRAMS, or GMS, or as 1 PKG or 1 U, and the"
 W !,"frequency (e.g. 20 GRAMS/DAY or 1 PKG/TID)."
 Q
 ;
TOTALQTY(ORDER) ; -- Returns total cc's for ORDER
 N ORDIALOG,ORIT,ORTOTAL,ORI
 S ORDIALOG=+$P($G(^OR(100,+ORDER,0)),U,5) D GETDLG1^ORCD(ORDIALOG)
 S ORIT=$$PTR^ORCD("OR GTX ORDERABLE ITEM")
 D GETORDER^ORCD(+ORDER) S (ORTOTAL,ORI)=0
 F  S ORI=$O(ORDIALOG(ORIT,ORI)) Q:ORI'>0  S ORTOTAL=ORTOTAL+$$CC(ORI)
 Q ORTOTAL
 ;
CANCEL ; -- Cancel active TF with new diet? [Called from FHW1 Exit Action]
 N ORTF,ORTX,DIR,X,Y,ORDA,OREASON,ORNATR,I
 S ORTF=$$CURRENT^ORCDFH("TF") Q:'ORTF  ;no active tubefeeding order
 Q:$$FUTURE^ORCDFH("EFFECTIVE DATE/TIME")  ;future diet order
 W !!,"An active tubefeeding order exists for this patient:"
 D TEXT^ORQ12(.ORTX,+ORTF,80) F I=1:1:ORTX W !,ORTX(I)
 S DIR(0)="YA",DIR("A")="Do you wish to cancel this order? "
 S DIR("?")="Enter YES to place a DC order for this tubefeeding"
 W ! D ^DIR Q:Y'=1  ;quit if not YES
 S ORDA=$$ACTION^ORCSAVE("DC",ORTF,ORNP),^TMP("ORNEW",$J,ORTF,ORDA)=""
 S OREASON=+$O(^ORD(100.03,"C","ORREQ",0)),ORNATR=$S(ORNP=DUZ:"E",1:"W")
 D SET^ORCACT2(+ORTF,ORNATR,OREASON) ;set ^(6) node
 Q
 ;
DATES ; -- get existing outpatient meal dates
 Q:$G(ORDIALOG(PROMPT,"LIST"))  D EN2^FHWOR8(+$G(ORVP),"",.ORDT)
 N I,CNT,X,Y S (I,CNT)=0 F  S I=$O(ORDT(I)) Q:I<1  D
 . S X=+ORDT(I),Y=$$FMTE^XLFDT(X)
 . Q:$G(ORDIALOG(PROMPT,"LIST","B",Y))  S CNT=CNT+1
 . S ORDIALOG(PROMPT,"LIST",CNT)=X_U_Y,ORDIALOG(PROMPT,"LIST","B",Y)=X
 S:CNT ORDIALOG(PROMPT,"LIST")=CNT_"^1"
 Q
