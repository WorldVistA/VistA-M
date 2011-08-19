ORWDPS2 ; SLC/KCM/JLI - Pharmacy Calls for Windows Dialog;05/09/2007
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**85,116,125,131,132,148,141,195,215,258,243**;Dec 17, 1997;Build 242
 ;
OISLCT(LST,OI,PSTYPE,ORVP,NEEDPI,PKIACTIV) ; return for defaults for pharmacy orderable item
 N ILST,ORDOSE,ORWPSOI,ORWDOSES,X1,X2
 K ^TMP("PSJINS",$J),^TMP("PSJMR",$J),^TMP("PSJNOUN",$J),^TMP("PSJSCH",$J),^TMP("PSSDIN",$J)
 S ILST=0
 S ORWPSOI=0
 S:+OI ORWPSOI=+$P($G(^ORD(101.43,+OI,0)),U,2)
 D START^PSSJORDF(ORWPSOI,$S(PSTYPE="U":"I",1:"O")) ; dflt route, schedule, etc.
 I '$L($T(DOSE^PSSOPKI1)) D DOSE^PSSORUTL(.ORDOSE,ORWPSOI,PSTYPE,ORVP)       ; dflt doses
 I $L($T(DOSE^PSSOPKI1)) D DOSE^PSSOPKI1(.ORDOSE,ORWPSOI,PSTYPE,ORVP)       ; dflt doses NEW PKI CODE from pharmacy
 D EN^PSSDIN(ORWPSOI)                               ; nfi text
 S ILST=ILST+1,LST(ILST)="~Medication"
 S ILST=ILST+1,LST(ILST)="d"_OI_U_$S(+OI:$P(^ORD(101.43,OI,0),U),1:"")
 S ILST=ILST+1,LST(ILST)="~Verb"
 S ILST=ILST+1,LST(ILST)="d"_$P($G(ORDOSE("MISC")),U)
 S ILST=ILST+1,LST(ILST)="~Preposition"
 S ILST=ILST+1,LST(ILST)="d"_$P($G(ORDOSE("MISC")),U,2)
 I $D(NEEDPI),(NEEDPI="Y") S ILST=ILST+1,LST(ILST)="~PtInstr" D PTINSTR
 ;S:NEEDPI="Y" ILST=ILST+1,LST(ILST)="~PtInstr"   D PTINSTR
 S ILST=ILST+1,LST(ILST)="~AllDoses"  D ALLDOSE ; must do before DOSAGE
 S ILST=ILST+1,LST(ILST)="~Dosage"    D DOSAGE
 S ILST=ILST+1,LST(ILST)="~Dispense"  D DISPLST
 S ILST=ILST+1,LST(ILST)="~Route"     D ROUTE
 S ILST=ILST+1,LST(ILST)="~Schedule"  D SCHED
 S ILST=ILST+1,LST(ILST)="~Guideline" D GUIDE
 S ILST=ILST+1,LST(ILST)="~Message"   D OIMSG
 S ILST=ILST+1,LST(ILST)="~DEASchedule" ;PKI
 ;S ILST=ILST+1,LST(ILST)="d"_$P($G(ORDOSE("DEA")),U) ;PKI
 S ILST=ILST+1,LST(ILST)="d" ;PKI
 I $D(ORDOSE("DEA")) S X="",X1=$P(ORDOSE("DEA"),";"),X2=$P(ORDOSE("DEA"),";",2) D
 . I '$L(X2) Q
 . I $G(PKIACTIV)="Y" S X=X2
 S LST(ILST)=LST(ILST)_X
 I PSTYPE="U" D
 . ; start, expires, next admin
 I PSTYPE="O" D
 . ; days supply, quantity, refills
 K ^TMP("PSJINS",$J),^TMP("PSJMR",$J),^TMP("PSJNOUN",$J),^TMP("PSJSCH",$J),^TMP("PSSDIN",$J)
 Q
 ;
PTINSTR ; from OISLCT, set up patient instructions
 N I
 S I=0 F  S I=$O(ORDOSE("PI",I)) Q:I'>0  S ILST=ILST+1,LST(ILST)="t"_ORDOSE("PI",I)
 Q
DOSAGE ; from OISLCT, set up the list of dosages
 ; LST(n)=iDrugName^Strength^NF^... (see BLDDOSE)
 ; must be called after ALLDOSE so ORWDOSES is set up
 N I
 S I=0 F  S I=$O(ORWDOSES(I)) Q:I'>0  S ILST=ILST+1,LST(ILST)=ORWDOSES(I)
 Q
DISPLST ; from OISLCT, set up list of dispense drugs
 ; DrugIEN^Strength^Units^Name^Split
 N DD
 S DD=0 F  S DD=$O(ORDOSE("DD",DD)) Q:'DD  D
 . S ILST=ILST+1
 . S LST(ILST)="i"_DD_U_$P(ORDOSE("DD",DD),U,5,6)_U_$P(ORDOSE("DD",DD),U)_U_$P(ORDOSE("DD",DD),U,11)
 Q
ALLDOSE ; from OISLCT, set up a list of all possible doses
 ; LST(n)=iDrugName^Strength^NF^... (see BLDDOSE)
 N I,J,CONJ,DD,DRUG,DDNM,LDOSE,TEXT,STREN,UD,COST,NF,ID,X
 S CONJ=$P($G(ORDOSE("MISC")),U,3),ORWDOSES=0
 S:$L(CONJ) CONJ=" "_CONJ_" " S:'$L(CONJ) CONJ=" "
 S I=0 F  S I=$O(ORDOSE(I)) Q:I'>0  D
 . S X=$$BLDDOSE(ORDOSE(I))
 . S ORWDOSES=ORWDOSES+1,ORWDOSES(ORWDOSES)=X
 . S ILST=ILST+1
 . S LST(ILST)="i"_$P(X,U,5)_U_$P($P(X,U,4),"&",6)_U_$P(X,U,4)
 . S J=0 F  S J=$O(ORDOSE(I,J)) Q:J'>0  D
 . . S X=$$BLDDOSE(ORDOSE(I,J))
 . . S ILST=ILST+1
 . . S LST(ILST)="i"_$P(X,U,5)_U_$P($P(X,U,4),"&",6)_U_$P(X,U,4)
 Q
BLDDOSE(X) ; build dose info where X is ORDOSE node
 ; from ALLDOSE
 ;    X=TotalDose^Units^U/D^Noun^LocalDose^DispDrugIEN
 ;    Y=iDrugName^Strength^NF^TDose&Units&U/D&Noun&LDose&Drug&Stren&Units^
 ;      DoseText^CostText^MaxRefills^DispUnits^CanSplit
 ; DRUG=Name^Cost^NF^DispUnit^Strength^Units^DoseForm^MaxRefills^
 ; No TotalDose,           use LocalDose
 ; TotalDose & Strength,   use LocalDose+Conjunction+Strength+Units
 ; TotalDose, No Strength, use LocalDose+Conjunction+DispenseName
 S DD=+$P(X,U,6),DRUG=ORDOSE("DD",DD),DDNM=$P(DRUG,U),ID=$P(X,U,1,6)
 S LDOSE=$P(X,U,5),TEXT=LDOSE,STREN=$P(DRUG,U,5)_$P(DRUG,U,6)
 S $P(ID,U,7)=$P(DRUG,U,5) S $P(ID,U,8)=$P(DRUG,U,6) ; add strength
 I '$L($P(X,U)),$L($P(DRUG,U,5))  S TEXT=TEXT_CONJ_STREN
 I '$L($P(X,U)),'$L($P(DRUG,U,5)) S TEXT=TEXT_CONJ_$P(DRUG,U)
 S UD=$P(X,U,3),COST=$P(X,U,7),NF=$S($P(DRUG,U,3):"NF",1:"")
 ;I UD S COST="$"_$J(UD*$P(DRUG,U,2),1,3) ;_" per "_UD_" "_$P(X,U,4)
 S Y="i"_DDNM_U_STREN_U_NF_U_$TR(ID,U,"&")_U_TEXT_U_COST_U_$P(DRUG,U,8)_U_$P(DRUG,U,4)
 Q Y
ROUTE ; from OISLCT, get list of routes for the drug form
 ; ** NEED BOTH ABBREVIATION & NAME IN LIST BOX
 N I,CNT,ABBR,IEN,ROUT,EXP,X
 S I="" F  S I=$O(^TMP("PSJMR",$J,I)) Q:I=""  D
 . S X=^TMP("PSJMR",$J,I)
 . S ROUT=$P(X,U),ABBR=$P(X,U,2),IEN=$P(X,U,3),EXP=$P(X,U,4)
 . S ILST=ILST+1,LST(ILST)="i"_IEN_U_ROUT_U_ABBR_U_EXP_U_$P(X,U,5)
 . I $P(X,U,6)="D",IEN S ILST=ILST+1,LST(ILST)="d"_IEN_U_ROUT ;_U_ABBR ; assume first always default
 ; add abbreviations to list of routes, commented out for 15.5 on
 ; S I="" F  S I=$O(^TMP("PSJMR",$J,I)) Q:I=""  D
 ; . S X=^TMP("PSJMR",$J,I)
 ; . S ROUT=$P(X,U),ABBR=$P(X,U,2),IEN=$P(X,U,3),EXP=$P(X,U,4)
 ; . I $L(ABBR),(ABBR'=ROUT) S ILST=ILST+1,LST(ILST)="i"_IEN_U_ABBR_" ("_ROUT_")"_U_ABBR_U_EXP
 Q
SCHED ; from OISLCT, get default schedule for this medication
 I $L($G(^TMP("PSJSCH",$J))) S ILST=ILST+1,LST(ILST)="d"_^($J)
 Q
GUIDE ; from OISLCT, get guidelines associated with this medication
 N IEN,I
 S IEN=0 F  S IEN=$O(^TMP("PSSDIN",$J,"OI",ORWPSOI,IEN)) Q:'IEN  D
 . S I=0 F  S I=$O(^TMP("PSSDIN",$J,"OI",ORWPSOI,IEN,I)) Q:'I  D
 . . S ILST=ILST+1,LST(ILST)="t"_^TMP("PSSDIN",$J,"OI",ORWPSOI,IEN,I)
 Q
OIMSG ; from OISLCT, get the orderable item message for this medication
 S I=0 F  S I=$O(^ORD(101.43,OI,8,I)) Q:I'>0  S ILST=ILST+1,LST(ILST)="t"_^(I,0)
 Q
ADMIN(REC,DFN,SCH,OI,LOC,ADMIN) ; return administration time info
 ; REC: StartText^StartTime^Duration^FirstAdmin
 S OI=+$P($G(^ORD(101.43,+OI,0)),U,2)
 S LOC=+$G(^SC(LOC,42)),REC=""
 I $L($G(^DPT(DFN,.1))) S REC=$$FIRST^ORCDPS3(DFN,LOC,OI,SCH,"",$G(ADMIN))
 Q
REQST(VAL,DFN,SCH,OI,LOC,TXT) ; return requested start time
 ; VAL: FirstAdmin time
 S VAL=""
 Q:'$L($G(SCH))  Q:'$G(OI)
 S OI=+$P($G(^ORD(101.43,+OI,0)),U,2)
 S LOC=+$G(^SC(LOC,42))
 S VAL=$P($$RESOLVE^PSJORPOE(DFN,SCH,OI,TXT,LOC),U,2)
 Q
DAY2QTY(VAL,DAY,UPD,SCH,DUR,PAT,DRG) ; return qty for days supply
 ; VAL: quantity
 N ORWX,I,X,ADUR,ADURNM
 S ORWX("DAYS SUPPLY")=DAY
 S ORWX("PATIENT")=PAT
 I DRG S ORWX("DRUG")=DRG
 F I=1:1:$L(UPD,U)-1 D
 . S ORWX("DOSE ORDERED",I)=$P(UPD,U,I)
 . S ORWX("SCHEDULE",I)=$P(SCH,U,I)
 . S ADUR=$P(DUR,U,I),ADURNM=$P($P(ADUR," ",2),"~")
 . S:ADURNM="MONTHS" X=+ADUR_"L"
 . S:ADURNM'="MONTHS" X=+ADUR_$E($P(ADUR," ",2))
 . I $L(X) S ORWX("DURATION",I)=X
 . S X=$E($P(ADUR,"~",2))
 . I $L(X) S ORWX("CONJUNCTION",I)=X
 D QTYX^PSOSIG(.ORWX)
 S VAL=$G(ORWX("QTY"))
 Q
QTY2DAY(VAL,QTY,UPD,SCH,DUR,PAT,DRG) ; return days supply given quantity
 ; VAL: days supply
 N ORWX,I,X,ADUR
 S ORWX("QTY")=QTY
 S ORWX("PATIENT")=PAT
 I DRG S ORWX("DRUG")=DRG
 F I=1:1:$L(UPD,U)-1 D
 . S ORWX("DOSE ORDERED",I)=$P(UPD,U,I)
 . S ORWX("SCHEDULE",I)=$P(SCH,U,I)
 . S ADUR=$P(DUR,U,I),X=+ADUR_$E($P(ADUR," ",2))
 . I $L(X) S ORWX("DURATION",I)=X
 . S X=$E($P(ADUR,"~",2))
 . I $L(X) S ORWX("CONJUNCTION",I)=X
 D QTYX^PSOSIG(.ORWX)
 S VAL=$G(ORWX("DAYS SUPPLY"))
 Q
MAXREF(VAL,PAT,DRG,SUP,OI,OUT) ; return the maximum number of refills
 ; PAT=Patient DFN, DRG=ptr50, SUP=days supply, OI=orderable item
 ; VAL: maximum refills allowed
 N ORWX
 S ORWX("PATIENT")=PAT
 I $G(DRG) S ORWX("DRUG")=+DRG
 I $G(SUP) S ORWX("DAYS SUPPLY")=SUP
 I $G(OI)  S ORWX("ITEM")=+$P(^ORD(101.43,+OI,0),U,2)
 I $G(OUT) S ORWX("DISCHARGE")=1
 D MAX^PSOSIGDS(.ORWX)
 S VAL=$G(ORWX("MAX"))
 Q
SCHREQ(VAL,OI,RTE,DRG) ; return 1 if schedule is required
 ; OI=orderable item, RTE=ptr route, DRG=ptr dispense drug
 S VAL=1
 Q:'$G(OI)  Q:'$G(RTE)
 S VAL=$$SCHREQ^PSJORPOE(RTE,OI,+$G(DRG))
 Q
CHKPI(VAL,ODIFN) ; return pre-existing patient instruct
 N IDNUM,IDPI
 S (IDNUM,IDPI)=0,VAL=""
 I '$D(^OR(100,ODIFN,4.5,"ID","PI")) S VAL="" Q
 F  S IDNUM=$O(^OR(100,ODIFN,4.5,"ID","PI",IDNUM)) Q:'IDNUM  D
 . F  S IDPI=$O(^OR(100,ODIFN,4.5,IDNUM,2,IDPI)) Q:'IDPI  D
 .. S VAL=VAL_^OR(100,ODIFN,4.5,IDNUM,2,IDPI,0)
 K IDNUM,IDPI
 Q
CHKGRP(VAL,ORIFN) ;
 ;Inpatient Med Order Group or Clin Meds Group: return 1
 ;If order belong to Outpatient Med Order Grpoup: return 2 
 ;Otherwise, return 0
 S VAL=0
 I '$L(ORIFN) Q
 N UDGRP,IPGRP,OPGRP,ODGRP,ODID,CLMED
 S ODID=+ORIFN
 Q:ODID<1
 S (UDGRP,IPGRP,OPGRP,ODGRP,CLMED)=0
 S UDGRP=$O(^ORD(100.98,"B","UD RX",UDGRP))
 S OPGRP=$O(^ORD(100.98,"B","OUTPATIENT MEDICATIONS",OPGRP))
 S IPGRP=$O(^ORD(100.98,"B","INPATIENT MEDICATIONS",IPGRP))
 S CLMED=$O(^ORD(100.98,"B","CLINIC ORDERS",CLMED))
 S:IPGRP=0 IPGRP=$O(^ORD(100.98,"B","I RX",IPGRP))
 I $L($G(^OR(100,ODID,0)))<1 Q
 S ODGRP=$P(^OR(100,ODID,0),U,11)
 I (UDGRP=ODGRP)!(CLMED=ODGRP) S VAL=1
 I IPGRP=ODGRP S VAL=1
 I OPGRP=ODGRP S VAL=2
 K UDGRP,ODGRP,OPGRP,IPGRP,ODID,CLMED
 Q
QOGRP(VAL,QOIFN) ;
 ;If quick order belong to Inpatient Med Order Group: return 1
 ;Otherwise, return 0
 S VAL=0
 I '$L(QOIFN) Q
 N UDGRP,IPGRP,QOGRP,QOID,CLMED
 S QOID=+QOIFN
 Q:QOID<1
 S (UDGRP,IPGRP,QOGRP,CLMED)=0
 S UDGRP=$O(^ORD(100.98,"B","UD RX",UDGRP))
 S IPGRP=$O(^ORD(100.98,"B","INPATIENT MEDICATIONS",IPGRP))
 S CLMED=$O(^ORD(100.98,"B","CLINIC ORDERS",CLMED))
 S:IPGRP=0 IPGRP=$O(^ORD(100.98,"B","I RX",IPGRP))
 I $L($G(^ORD(101.41,QOID,0)))<1 Q
 S QOGRP=$P(^ORD(101.41,QOID,0),U,5)
 I UDGRP=QOGRP S VAL=1
 I (IPGRP=QOGRP)!(CLMED=QOGRP) S VAL=1
 K UDGRP,QOGRP,QOID,IPGRP,CLMED
 Q
