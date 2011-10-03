ORWDPS32 ; SLC/KCM - Pharmacy Calls for GUI Dialog ; 02/11/2008
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,94,190,195,243**;Dec 17, 1997;Build 242
 ;Per VHA Directive 2004-038, this routine should not be modified.
NXT() ; -- ret next available index in data array
 S ILST=ILST+1
 Q ILST
 ;
DLGSLCT(LST,PSTYPE,DFN,LOCIEN) ; return def lists for dialog
 ; PSTYPE: pharmacy type (U=unit dose, F=IV fluids, O=outpt)
 N ILST S ILST=0
 I PSTYPE="F" D  Q                       ; IV Fluids
 . S LST($$NXT)="~ShortList"  D SHORT
 . S LST($$NXT)="~Priorities" D PRIOR
 . ;S LST($$NXT)="~Schedules"  D SCHED(LOCIEN)
 . S LST($$NXT)="~Route" D IVROUTE
 ;
 S LST($$NXT)="~ShortList"  D SHORT      ; Unit Dose & Outpt
 ;S LST($$NXT)="~Schedules"  D SCHED(LOCIEN)
 S LST($$NXT)="~Priorities" D PRIOR
 I PSTYPE="O" D                          ; Outpt
 . S LST($$NXT)="~Pickup"   D PICKUP
 . S LST($$NXT)="~SCStatus" D SCLIST
 Q
SHORT ; from DLGSLCT, get short list of med quick orders
 ; !!! change this so that it uses the ORWDXQ call!!!
 N I,X,TMP
 I PSTYPE="U" S X="UD RX"
 I PSTYPE="F" S X="IV RX"
 I PSTYPE="O" S X="O RX"
 D GETQLST^ORWDXQ(.TMP,X,"iQ")
 S I=0 F  S I=$O(TMP(I)) Q:'I  S LST($$NXT)=TMP(I)
 Q
SCHEDA ; (similar to SCHED, but also rtns admin times)
 N X,IEN,SCH,TIME
 K ^TMP($J,"ORWDPS32 SCHEDA")
 D AP^PSS51P1("PSJ",,,,"ORWDPS32 SCHEDA")
 S SCH="" F  S SCH=$O(^TMP($J,"ORWDPS32 SCHEDA","APPSJ",SCH)) Q:SCH=""  D
 .S IEN="" F  S IEN=$O(^TMP($J,"ORWDPS32 SCHEDA","APPSJ",SCH,IEN)) Q:IEN'>0  D
 ..S TIME=$G(^TMP($J,"ORWDPS32 SCHEDA",IEN,1))
 ..S X=$S($L(TIME):"  ("_TIME_")",1:"")
 ..S LST($$NXT)="i"_IEN_U_SCH_U_X
 K ^TMP($J,"ORWDPS32 SCHEDA")
 Q
 ;
IVROUTE ;
 N ABB,EXP,IEN,RTE
 K ^TMP($J,"ORWDPS32 IVROUTE")
 D ALL^PSS51P2(,"??",,1,"ORWDPS32 IVROUTE")
 S RTE="" F  S RTE=$O(^TMP($J,"ORWDPS32 IVROUTE","B",RTE)) Q:RTE=""  D
 .S IEN=$O(^TMP($J,"ORWDPS32 IVROUTE","IV",RTE,"")) Q:IEN'>0
 .S ABB=$G(^TMP($J,"ORWDPS32 IVROUTE",IEN,1))
 .S EXP=$G(^TMP($J,"ORWDPS32 IVROUTE",IEN,4))
 .S LST($$NXT)="i"_IEN_U_RTE_U_ABB_U_EXP
 K ^TMP($J,"ORWDPS32 IVROUTE")
 Q
 ;
ALLIVRTE(LST) ;
 N ABB,CNT,EXP,IEN,RTE
 K ^TMP($J,"ORWDPS32 ALLIVRTE")
 S CNT=0
 D ALL^PSS51P2(,"??",,1,"ORWDPS32 ALLIVRTE")
 S RTE="" F  S RTE=$O(^TMP($J,"ORWDPS32 ALLIVRTE","B",RTE)) Q:RTE=""  D
 .S IEN=$O(^TMP($J,"ORWDPS32 ALLIVRTE","IV",RTE,"")) Q:IEN'>0
 .S ABB=$G(^TMP($J,"ORWDPS32 ALLIVRTE",IEN,1))
 .S EXP=$G(^TMP($J,"ORWDPS32 ALLIVRTE",IEN,4))
 .S CNT=CNT+1,LST(CNT)=IEN_U_RTE_U_ABB_U_U_U_U
 K ^TMP($J,"ORWDPS32 IVROUTE")
 Q
 ;
ROUTE ; from OISLCT^ORWDPS32, get list of routes for the drug form
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
 ;similar to SCHED^ORWDPS32, also returns Admin Time for Patient ward location
 ;AGP CPRS 27.72 THIS CODE IS NOT NEEDED ANYMORE
SCHED(LOCIEN) ;
 N CNT,ORARRAY,SCH,IEN,EXP,TIME,TYP,X0,WIEN
 ;K ^TMP($J,"ORWDPS32 SCHED1")
 S WIEN=$$WARDIEN(+LOCIEN)
 D SCHED^PSS51P1(WIEN,.ORARRAY)
 S CNT=0 F  S CNT=$O(ORARRAY(CNT)) Q:CNT'>0  D
 .S LST($$NXT)="i"_$P(ORARRAY(CNT),U,2,5)
 Q
 ;
WARDIEN(LOCIEN) ;
 N RESULT
 S RESULT=0
 I LOCIEN=0 Q RESULT
 I $P($G(^SC(LOCIEN,42)),U)="" Q RESULT
 S RESULT=+$P($G(^SC(LOCIEN,42)),U)
 Q RESULT
PRIOR ; from DLGSLCT, get list of allowed priorities
 N X,XREF
 S XREF=$S(PSTYPE="O":"S.PSO",1:"S.PSJ")
 S X="" F  S X=$O(^ORD(101.42,XREF,X)) Q:'$L(X)  D
 . S LST($$NXT)="i"_$O(^ORD(101.42,XREF,X,0))_U_X
 S LST($$NXT)="d"_$O(^ORD(101.42,"B","ROUTINE",0))_U_"ROUTINE"
 Q
PICKUP ; from DLGSLCT, get prescription routing
 N X,EDITONLY
 F X="W^at Window","M^by Mail","C^in Clinic" S LST($$NXT)="i"_X
 S X=$$DEFPICK I $L(X) S LST($$NXT)="d"_X
 Q
DEFPICK()       ; ret def routing
 N X,DLG,PRMT
 S DLG=$O(^ORD(101.41,"AB","PSO OERR",0)),X=""
 S PRMT=$O(^ORD(101.41,"AB","OR GTX ROUTING",0))
 I $D(^TMP("ORECALL",$J,+DLG,+PRMT,1)) S X=^(1)
 I X'="" S EDITONLY=1 Q X  ; EDITONLY used by def action
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
OISLCT(LST,OI,PSTYPE,ORVP) ; rtn for defaults for pharm OI
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
DISPDRUG(LST,OI) ; list dispense drugs for an OI
 N ILST,PSTYPE S ILST=0,PSTYPE="U" D DISPDRG
 Q
 ;
DISPDRG ; from OISLCT, get disp drugs for this pharm OI
 N I,ORTMP,ORX
 S ORX=$T(ENDD^PSJORUTL),ORX=$L($P(ORX,";"),",")
 I ORX>3 D ENDD^PSJORUTL("^^^"_+$P($G(^ORD(101.43,OI,0)),"^",2),PSTYPE,.ORTMP,+ORVP)
 I ORX'>3 D ENDD^PSJORUTL("^^^"_+$P($G(^ORD(101.43,OI,0)),"^",2),PSTYPE,.ORTMP)
 S I="" F  S I=$O(ORTMP(I)) Q:I=""  D
 . I $P(ORTMP(I),U,4)="1" S $P(ORTMP(I),U,4)="NF"
 . S $P(ORTMP(I),U,3)="$"_$P(ORTMP(I),U,3)_" per "_$P(ORTMP(I),U,5)
 . S LST($$NXT)="i"_ORTMP(I)
 Q
INSTRCT ; from OISLCT, get list of potential instructs (based on drug form)
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
 Q X
 ;
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
 K ^TMP($J,"ORWDPS32 ALLROUTE")
 Q
VALROUTE(REC,X)        ; validates route name & returns IEN + abbreviation
 N ABBR,NAME,IEN
 K ^TMP($J,"ORWDPS32 VALROUTE")
 S X=$$UPPER(X)
 D ALL^PSS51P2(,X,,1,"ORWDPS32 VALROUTE")
 I $P(^TMP($J,"ORWDPS32 VALROUTE",0),U)=-1 K ^TMP($J,"ORWDPS32 VALROUTE") S REC=0 Q
 S IEN=$O(^TMP($J,"ORWDPS32 VALROUTE","B",X,""))
 I IEN'>0 S IEN=$O(^TMP($J,"ORWDPS32 VALROUTE","C",X,""))
 I IEN'>0 S REC=0 Q
 S NAME=$G(^TMP($J,"ORWDPS32 VALROUTE",IEN,.01))
 S ABBR=$G(^TMP($J,"ORWDPS32 VALROUTE",IEN,1))
 I '$L(ABBR) S ABBR=NAME
 I ($$UPPER(NAME)'=X),($$UPPER(ABBR)'=X) S REC=0 K ^TMP($J,"ORWDPS32 VALROUTE") Q
 S REC=IEN_U_ABBR
 K ^TMP($J,"ORWDPS32 VALROUTE")
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
AUTHNVA(VAL,PRV) ; For Non-VA meds, check restrictions
 N NAME,AUTH,INACT,X S VAL=0
 I $D(^XUSEC("OREMAS",DUZ)),$$GET^XPAR("ALL","OR OREMAS NON-VA MED ORDERS")=2 Q
 I $D(^XUSEC("OREMAS",DUZ)),'$$GET^XPAR("ALL","OR OREMAS NON-VA MED ORDERS") D  Q
 . S VAL="1^OREMAS key holders may not enter non-VA medication orders."
 S NAME=$P($G(^VA(200,PRV,20)),U,2) S:'$L(NAME) NAME=$P(^(0),U)
 S X=$G(^VA(200,PRV,"PS")),AUTH=$P(X,U),INACT=$P(X,U,4)
 I 'AUTH!(INACT&(DT>INACT)) D  Q
 . S VAL="1^"_NAME_" is not authorized to write medication orders."
 Q
 ;
UPPER(X)        ; return uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
TRIM(X) ; trim leading and trailing spaces
 S X=$RE(X) F  S:$E(X)=" " X=$E(X,2,999) Q:$E(X)'=" "  Q:'$L(X)  ;trail
 S X=$RE(X) F  S:$E(X)=" " X=$E(X,2,999) Q:$E(X)'=" "  Q:'$L(X)  ;lead
 Q X
 ;
