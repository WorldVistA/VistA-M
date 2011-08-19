ORBCMA32 ; SLC/JLI - Pharmacy Calls for GUI Dialog 02/11/2008
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**133,243**;Dec 17, 1997;Build 242
 ;;BCMA ORDER V1.0 ;**133,243**;Jan 17, 2002
 ;
NXT() ; -- returns next available index in return data array
 S ILST=ILST+1
 Q ILST
 ;
DLGSLCT(LST,PSTYPE) ; return default lists for dialog
 ; PSTYPE: pharmacy type (U=unit dose, F=IV fluids, O=outpatient)
 N ILST S ILST=0
 I PSTYPE="F" D  Q                       ; IV Fluids
 . S LST($$NXT)="~ShortList"  D SHORT
 . S LST($$NXT)="~Priorities" D PRIOR
 ;
 S LST($$NXT)="~ShortList"  D SHORT      ; Unit Dose & Outpatient
 S LST($$NXT)="~Schedules"  D SCHED
 S LST($$NXT)="~Priorities" D PRIOR
 I PSTYPE="O" D                          ; Outpatient
 . S LST($$NXT)="~Pickup"   D PICKUP
 . S LST($$NXT)="~SCStatus" D SCLIST
 Q
SHORT ; from DLGSLCT, get short list of med quick orders
 N I,X,TMP
 I PSTYPE="U" S X="UD RX"
 I PSTYPE="F" S X="IV RX"
 I PSTYPE="O" S X="O RX"
 D GETQLST^ORWDXQ(.TMP,X,"iQ")
 S I=0 F  S I=$O(TMP(I)) Q:'I  S LST($$NXT)=TMP(I)
 Q
SCHED ; from DLGSLCT, get all pharmacy administration schedules
 N X
 K ^TMP($J,"ORBCMA32 SCHED")
 D AP^PSS51P1("PSJ",,,,"ORBCMA32 SCHED")
 S X="" F  S X=$O(^TMP($J,"ORBCMA32 SCHED","APPSJ",X)) Q:X=""  S LST($$NXT)="i"_X
 K ^TMP($J,"ORBCMA32 SCHED")
 Q
SCHEDA ; (similar to SCHED, but also returns administration times)
 N X,IEN,SCH
 K ^TMP($J,"ORBCMA32 SCHEDA")
 D AP^PSS51P1("PSJ",,,,"ORBCMA32 SCHEDA")
 S SCH="" F  S SCH=$O(^TMP($J,"ORBCMA32 SCHEDA","APPSJ",SCH)) Q:SCH=""  D
 . S IEN=0 F  S IEN=$O(^TMP($J,"ORBCMA32 SCHEDA","APPSJ",SCH,IEN)) Q:IEN'>0  D
 . . S X=$S($L(^TMP($J,"ORBCMA32 SCHEDA",IEN,2)):"  ("_^TMP($J,"ORBCMA32 SCHEDA",IEN,2)_")",1:"")
 . . S LST($$NXT)="i"_IEN_U_SCH_X
 Q
PRIOR ; from DLGSLCT, get list of allowed priorities
 N X,XREF
 S X=0
 S X=$O(^ORD(101.42,"B","DONE",X))
 S LST($$NXT)="i"_X_U_$P(^ORD(101.42,X,0),U,2)
 Q
PICKUP ; from DLGSLCT, get prescription routing
 N X,EDITONLY
 F X="W^at Window","M^by Mail","C^in Clinic" S LST($$NXT)="i"_X
 S X=$$DEFPICK I $L(X) S LST($$NXT)="d"_X
 Q
DEFPICK()       ; return default routing
 N X,DLG,PRMT
 S DLG=$O(^ORD(101.41,"AB","PSO OERR",0)),X=""
 S PRMT=$O(^ORD(101.41,"AB","OR GTX ROUTING",0))
 I $D(^TMP("ORECALL",$J,+DLG,+PRMT,1)) S X=^(1)
 I X'="" S EDITONLY=1 Q X  ; EDITONLY used by default action
 ;
 S X=$$GET^XPAR("ALL","ORWDPS ROUTING DEFAULT",1,"I")
 I X="C" S X="C^in Clinic" G XPICK
 I X="M" S X="M^by Mail"   G XPICK
 I X="W" S X="W^at Window" G XPICK
 I X="N" S X=""             G XPICK
 I X=""  S X=$S($D(^PSX(550,"C")):"M^by Mail",1:"W^at Window")
XPICK Q X
 ;
SCLIST ; from DLGSLCT, get options for service connected
 F X="0^No","1^Yes" S LST($$NXT)="i"_X
 Q
 ;
OISLCT(LST,OI,PSTYPE,ORVP) ; return for defaults for pharmacy orderable item
 N ILST S ILST=0
 K ^TMP("PSJINS",$J),^TMP("PSJMR",$J),^TMP("PSJNOUN",$J),^TMP("PSJSCH",$J)
 S LST($$NXT)="~Dispense" D DISPDRG
 S LST($$NXT)="~Instruct" D INSTRCT
 S LST($$NXT)="~Route"    D ROUTE
 S LST($$NXT)="~Message"  D MESSAGE
 I $L($G(^TMP("PSJSCH",$J))) S LST($$NXT)="~DefSched",LST($$NXT)="d"_^($J)
 K ^TMP("PSJINS",$J),^TMP("PSJMR",$J),^TMP("PSJNOUN",$J),^TMP("PSJSCH",$J)
 Q
 ;
DISPDRUG(LST,OI) ; list dispense drugs for an orderable item
 N ILST,PSTYPE S ILST=0,PSTYPE="U" D DISPDRG
 Q
 ;
DISPDRG ; from OISLCT, get dispense drugs for this pharmacy orderable item
 N I,ORTMP,ORX
 S ORX=$T(ENDD^PSJORUTL),ORX=$L($P(ORX,";"),",")
 I ORX>3 D ENDD^PSJORUTL("^^^"_+$P($G(^ORD(101.43,OI,0)),"^",2),PSTYPE,.ORTMP,+ORVP)
 I ORX'>3 D ENDD^PSJORUTL("^^^"_+$P($G(^ORD(101.43,OI,0)),"^",2),PSTYPE,.ORTMP)
 S I="" F  S I=$O(ORTMP(I)) Q:I=""  D
 . I $P(ORTMP(I),U,4)="1" S $P(ORTMP(I),U,4)="NF"
 . S $P(ORTMP(I),U,3)="$"_$P(ORTMP(I),U,3)_" per "_$P(ORTMP(I),U,5)
 . S LST($$NXT)="i"_ORTMP(I)
 Q
INSTRCT ; from OISLCT, get list of potential instructions (based on drug form)
 N INOUN,NOUN,IINS,INS,VERB,INSREC
 D START^PSSJORDF(+$P(^ORD(101.43,OI,0),U,2))
 I PSTYPE="U" Q  ; don't use the instructions list for inpatients
 S IINS=0 F  S IINS=$O(^TMP("PSJINS",$J,IINS)) Q:'IINS  D
 . S INSREC=$G(^TMP("PSJINS",$J,IINS))
 . I '$D(VERB) S VERB=$P(INSREC,U)
 . I $L($P(INSREC,U,2)) S LST($$NXT)="i"_$P(INSREC,U,2)
 S LST($$NXT)="~Nouns"
 S INOUN=0 F  S INOUN=$O(^TMP("PSJNOUN",$J,INOUN)) Q:'INOUN  D
 . S LST($$NXT)="i"_$P(^TMP("PSJNOUN",$J,INOUN),U)
 I $D(VERB) S LST($$NXT)="~Verb",LST($$NXT)="d"_VERB
 ;
 Q
MIXED(X)   ; Return mixed case
 Q X  ;$E(X)_$TR($E(X,2,$L(X)),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 ;
ROUTE ; from OISLCT, get list of routes for the drug form
 ; ** NEED BOTH ABBREVIATION & NAME IN LIST BOX
 N I,CNT,ABBR,IEN,ROUT,X
 S I="" F  S I=$O(^TMP("PSJMR",$J,I)) Q:I=""  D
 . S ROUT=$P(^TMP("PSJMR",$J,I),U),ABBR=$P(^(I),U,2),IEN=$P(^(I),U,3)
 . S LST($$NXT)="i"_IEN_U_ROUT_U_ABBR
 . I I=1,IEN S LST($$NXT)="d"_IEN_U_ROUT ;_U_ABBR ; assume first always default
 S I="" F  S I=$O(^TMP("PSJMR",$J,I)) Q:I=""  D
 . S ROUT=$P(^TMP("PSJMR",$J,I),U),ABBR=$P(^(I),U,2),IEN=$P(^(I),U,3)
 . I $L(ABBR),(ABBR'=ROUT) S LST($$NXT)="i"_IEN_U_ABBR_" ("_ROUT_")"_U_ABBR
 Q
MESSAGE ; message
 S I=0 F  S I=$O(^ORD(101.43,OI,8,I)) Q:I'>0  S LST($$NXT)="t"_^(I,0)
 Q
ALLROUTE(LST) ; returns a list of all available med routes
 N I,X,ILST
 S ILST=0
 K ^TMP($J,"ORWDPS32 ALLROUTE")
 D ALL^PSS51P2(,"??",,,"ORWDPS32 ALLROUTE")
 S I=0 F  S I=$O(^TMP($J,"ORWDPS32 ALLROUTE",I)) Q:'I  D
 . I +$P(^TMP($J,"ORWDPS32 ALLROUTE",I,3),U)>0 S LST($$NXT)=I_U_^TMP($J,"ORWDPS32 ALLROUTE",I,.01)_U_^TMP($J,"ORWDPS32 ALLROUTE",I,1)
 Q
VALROUTE(REC,X)        ; validates route name & returns IEN + abbreviation
 N ABBR,NAME,IEN
 K ^TMP($J,"ORBCMA32 VALROUTE")
 S X=$$UPPER(X)
 D ALL^PSS51P2(,X,,1,"ORBCMA32 VALROUTE")
 I $P(^TMP($J,"ORBCMA32 VALROUTE",0),U)=-1 K ^TMP($J,"ORBCMA32 VALROUTE") S REC=0 Q
 S IEN=$O(^TMP($J,"ORBCMA32 VALROUTE","B",X,""))
 I IEN'>0 S IEN=$O(^TMP($J,"ORBCMA32 VALROUTE","C",X,""))
 I IEN'>0 S REC=0 Q
 S NAME=$G(^TMP($J,"ORBCMA32 VALROUTE",IEN,.01))
 S ABBR=$G(^TMP($J,"ORBCMA32 VALROUTE",IEN,1))
 I '$L(ABBR) S ABBR=NAME
 I ($$UPPER(NAME)'=X),($$UPPER(ABBR)'=X) S REC=0 K ^TMP($J,"ORBCMA32 VALROUTE") Q
 S REC=IEN_U_ABBR
 K ^TMP($J,"ORBCMA32 VALROUTE")
 Q
AUTH(VAL,PRV) ; For inpatient meds, check restrictions
 N NAME,AUTH,INACT,X S VAL=0
 S NAME=$P($G(^VA(200,PRV,20)),U,2) S:'$L(NAME) NAME=$P(^(0),U)
 S X=$G(^VA(200,PRV,"PS")),AUTH=$P(X,U),INACT=$P(X,U,4)
 I 'AUTH!(INACT&(DT>INACT)) D  Q
 . S VAL="1^"_NAME_" is not authorized to write medication orders."
 I $D(^XUSEC("OREMAS",DUZ)),'$$GET^XPAR("ALL","OR OREMAS MED ORDERS") D  Q
 . S VAL="1^OREMAS key holders may not enter medication orders."
 Q
DRUGMSG(VAL,IEN)        ; return any message associated with a dispense drug
 N X S X=$$ENDCM^PSJORUTL(IEN)
 S VAL=$P(X,U,2)_U_$P(X,U,4)
 Q
MEDISIV(VAL,IEN)        ; return true if orderable item is IV medication
 S VAL=0
 I $P($G(^ORD(101.43,IEN,"PS")),U)=2 S VAL=1
 Q
ISSPLY(VAL,IEN) ; return true if orderable item is a supply
 S VAL=0
 I $P($G(^ORD(101.43,IEN,"PS")),U,5)=1 S VAL=1
 Q
IVAMT(VAL,OI,ORWTYP)     ; return UNITS^AMOUNT |^AMOUNT^AMOUNT...| for IV soln
 N I,PSOI,ORWY,AMT,IVFLAG
 S IVFLAG=$P(OI,U,2)
 S PSOI=+$P($G(^ORD(101.43,+OI,0)),U,2)_ORWTYP,VAL=""
 I IVFLAG="NF" D ENVOL2^PSJORUT2(PSOI,.ORWY)
 I IVFLAG="" D ENVOL^PSJORUT2(PSOI,.ORWY)
 I ORWTYP="B" D
 . S I=0 F  S I=$O(ORWY(I)) Q:I'>0  S AMT(+ORWY(I))=""
 . S AMT=0,VAL="ML" F  S AMT=$O(AMT(AMT)) Q:AMT'>0  S VAL=VAL_U_AMT
 I ORWTYP="A" D
 . S I=+$O(ORWY(0)) S VAL=$P($G(ORWY(I)),U,2)
 . I '$L(VAL) S VAL="ML^LITER^MCG^MG^GM^UNITS^IU^MEQ^MM^MU^THOUU^MG-PE^NANOGRAM^MMOL"
 Q
VALRATE(VAL,X)   ; return "1" (true) if IV rate text is valid
 I $E($RE($$UPPER(X)),1,5)="RH/LM"  S X=$E(X,1,$L(X)-5)
 S X=$$TRIM(X)
 D ORINF^PSIVSP S VAL=$G(X) ;S OK=$S($D(X):1,1:0)
 Q
UPPER(X) ; return uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
TRIM(X) ; trim leading and trailing spaces
 S X=$RE(X) F  S:$E(X)=" " X=$E(X,2,999) Q:$E(X)'=" "  Q:'$L(X)  ;trail
 S X=$RE(X) F  S:$E(X)=" " X=$E(X,2,999) Q:$E(X)'=" "  Q:'$L(X)  ;lead
 Q X
SCSTS(VAL,ORVP,ORDRUG)  ; return service connected eligibility for patient
 N ORWP94 S ORWP94=$O(^ORD(101.41,"AB","PS MEDS",0))>0
 I $L($T(SC^PSOCP)),$$SC^PSOCP(+ORVP,+$G(ORDRUG)) S VAL=0 G XSCSTS
 I 'ORWP94,(+$$RXST^IBARXEU(+ORVP)>0) S VAL=0 G XSCSTS
 S VAL=1
XSCSTS Q
FORMALT(ORLST,IEN,PSTYPE) ; return a list of formulary alternatives
 D ENRFA^PSJORUTL(IEN,PSTYPE,.ORLST)
 S I=0 F  S I=$O(ORLST(I)) Q:'I  D
 . S OI=+$O(^ORD(101.43,"ID",+$P(ORLST(I),U,4)_";99PSP",0))
 . S $P(ORLST(I),U,4)=OI I OI S $P(ORLST(I),U,5)=$P(^ORD(101.43,OI,0),U)
 Q
VALSCH(OK,X,PSTYPE)    ; validate a schedule, return 1 if valid, 0 if not
 I '$L($T(EN^PSSGSGUI)) S OK=-1 Q
 I $E($T(EN^PSSGSGUI),1,4)="EN(X" D
 . N ORX S ORX=$G(X) D EN^PSSGSGUI(.ORX,$G(PSTYPE,"I"))
 . K X S:$D(ORX) X=ORX
 E  D
 . D EN^PSSGSGUI
 S OK=$S($D(X):1,1:0)
 Q
VALQTY(OK,X)    ; validate a quantity, return 1 if valid, 0 if not
 ; to be compatible with LM, make sure X is integer from 1 to 240
 ; this is based on the input transform from 52,7
 K:(+X'>0)!(+X>99999999)!(X'?.8N.1".".2N)!($L(X)>12) X
 S OK=$S($D(X):1,1:0)
 Q
DOSES(LST,OI) ; return doses for an orderable item  -  TEST ONLY
 N ORTMP,ORI,ORJ,ILST,NDF,VAPN,X,PSTYPE S PSTYPE="O"
 D ENDD^PSJORUTL("^^^"_+$P($G(^ORD(101.43,OI,0)),"^",2),PSTYPE,.ORTMP)
 S ORI=0 F  S ORI=$O(ORTMP(ORI)) Q:'ORI  S ORWDRG=+ORTMP(ORI) D
 . K ^TMP($J,"ORBCMA32 DRUG")
 . D NDF^PSS50(+ORWDRG,,,,,"ORBCMA32 DRUG")
 . S VAPN=$P($G(^TMP($J,"ORBCMA32 DRUG",+ORWDRG,22)),U),NDF=$P($G(^TMP($J,"ORBCMA32 DRUG",+ORWDRG,20)),U)
 . S X=$$DFSU^PSNAPIS(NDF,VAPN)
 . S LSTA($P(X,U,4),$P(X,U,6))=""
 . I +$P(X,U,4)=$P(X,U,4) S LSTA($P(X,U,4)*2,$P(X,U,6))=""
 K ^TMP($J,"ORBCMA32 DRUG")
 S ORI="",ILST=0 F  S ORI=$O(LSTA(ORI)) Q:ORI=""  D
 . S ORJ="" F  S ORJ=$O(LSTA(ORI,ORJ)) Q:ORJ=""  D
 . . S ILST=ILST+1,LST(ILST)=ORI_" "_ORJ
 Q
