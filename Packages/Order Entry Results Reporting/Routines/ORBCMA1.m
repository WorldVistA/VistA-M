ORBCMA1 ; SLC/JLI - Pharmacy Calls for Windows Dialog [ 3/7/2006 ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**133,243**;Dec 17, 1997;Build 242
 ;;OR BCMA ORDER COM V1.0 ;**133**; Jan 19, 2002
 ;
ODSLCT(LST,PSTYPE,DFN,LOC) ; return default lists for dialog
 ; PSTYPE: pharmacy type (U=unit dose, F=IV fluids, O=outpatient)
 N ILST S ILST=0
 S ILST=ILST+1,LST(ILST)="~Priority" D PRIOR
 S ILST=ILST+1,LST(ILST)="~DispMsg"
 S ILST=ILST+1,LST(ILST)="d"_$$DISPMSG
 ;
 ; I PSTYPE="F" D  Q                           ; IV Fluids
 ; . S ILST=ILST+1,LST(ILST)="~ShortList" D SHORT
 ;
 I PSTYPE="O" D                                ; Outpatient
 . S ILST=ILST+1,LST(ILST)="~Refills"
 . S ILST=ILST+1,LST(ILST)="d0^0"
 . S ILST=ILST+1,LST(ILST)="~Pickup"
 . S ILST=ILST+1,LST(ILST)="d"_$$DEFPICK($G(LOC))
 . ; S ILST=ILST+1,LST(ILST)="~Supply"
 . ; S ILST=ILST+1,LST(ILST)="d^"_$$DEFSPLY(DFN)
 Q
PRIOR ; from DLGSLCT, get list of allowed priorities
 N X,XREF
 S X=0
 S X=$O(^ORD(101.42,"B","DONE",X))
 S ILST=ILST+1,LST(ILST)="d"_X_U_$P(^ORD(101.42,X,0),U,2)
 Q
DEFPICK(LOC)       ; return default routing
 N X,DLG,PRMT
 S DLG=$O(^ORD(101.41,"AB","PSO OERR",0)),X=""
 S PRMT=$O(^ORD(101.41,"AB","OR GTX ROUTING",0))
 I $D(^TMP("ORECALL",$J,+DLG,+PRMT,1)) S X=^(1)
 I X'="" S EDITONLY=1 Q X  ; EDITONLY used by default action
 ;
 S X=$$GET^XPAR("ALL^"_"LOC.`"_LOC,"ORWDPS ROUTING DEFAULT",1,"I")
 I X="C" S X="C^in Clinic" G XPICK
 I X="M" S X="M^by Mail"   G XPICK
 I X="W" S X="W^at Window" G XPICK
 I X="N" S X=""            G XPICK
 I X=""  S X=$S($D(^PSX(550,"C")):"M^by Mail",1:"W^at Window")
XPICK Q X
 ;
DEFSPLY(DFN)    ; return default days supply for this patient
 N ORWX
 S ORWX("PATIENT")=DFN
 D DSUP^PSOSIGDS(.ORWX)
 Q $G(ORWX("DAYS SUPPLY"))
 ;
DFLTSPLY(VAL,UPD,SCH,PAT,DRG)        ; return days supply given quantity
 ; VAL: default days supply
 N ORWX,I
 S ORWX("PATIENT")=PAT
 I DRG S ORWX("DRUG")=DRG
 F I=1:1:$L(UPD,U)-1 D
 . S ORWX("DOSE ORDERED",I)=$P(UPD,U,I)
 . S ORWX("SCHEDULE",I)=$P(SCH,U,I)
 D DSUP^PSOSIGDS(.ORWX)
 S VAL=$G(ORWX("DAYS SUPPLY"))
 Q
DISPMSG()       ; return 1 to suppress dispense message
 Q +$$GET^XPAR("ALL","ORWDPS SUPPRESS DISPENSE MSG",1,"I")
 ;
SCHALL(LST) ; return all schedules
 N ILST,SCH,IEN,EXP,TYP,X0
 K ^TMP($J,"ORBCMA1 SCHALL")
 D AP^PSS51P1("PSJ",,,,"ORBCMA1 SCHALL")
 S ILST=0,SCH=""
 F  S SCH=$O(^TMP($J,"ORBCMA1 SCHALL","APPSJ",SCH)) Q:SCH=""  D
 . I (SCH="STAT")!(SCH="NOW") D
 .. S IEN=$O(^TMP($J,"ORBCMA1 SCHALL","APPSJ",SCH,""))
 .. S EXP=$G(^TMP($J,"ORBCMA1 SCHALL",SCH,8))
 .. S TYP=$P($G(^TMP($J,"ORBCMA1 SCHALL",SCH,5)),U)
 .. S ILST=ILST+1,LST(ILST)=SCH_U_EXP_U_TYP
 K ^TMP($J,"ORBCMA1 SCHALL")
 Q
FORMALT(ORLST,IEN,PSTYPE) ; return a list of formulary alternatives
 N PSID,I
 S IEN=+$P(^ORD(101.43,IEN,0),U,2)
 D EN1^PSSUTIL1(.IEN,PSTYPE)
 S PSID=0,I=0
 F  S PSID=$O(IEN(PSID)) Q:'PSID  D
 . S OI=+$O(^ORD(101.43,"ID",PSID_";99PSP",0))
 . I OI S I=I+1,ORLST(I)=OI,$P(ORLST(I),U,2)=$P(^ORD(101.43,OI,0),U)
 Q
DOSEALT(LST,DDRUG,CUROI,PSTYPE) ; return a list of formulary alternatives for dose
 N I,OI,ORWLST,ILST S ILST=0
 D ENRFA^PSJORUTL(DDRUG,PSTYPE,.ORWLST)
 S I=0 F  S I=$O(ORWLST(I)) Q:'I  D
 . S OI=+$O(^ORD(101.43,"ID",+$P(ORWLST(I),U,4)_";99PSP",0))
 . I OI,OI'=CUROI S ILST=ILST+1,LST(ILST)=OI_U_$P(^ORD(101.43,OI,0),U)
 Q
FAILDEA(FAIL,OI,ORNP,PSTYPE)    ; return 1 if DEA check fails for this provider
 N DEAFLG,PSOI
 S FAIL=0,PSOI=+$P($G(^ORD(101.43,+$G(OI),0)),U,2) Q:PSOI'>0
 I '$L($T(OIDEA^PSSUTLA1)) Q
 S DEAFLG=$$OIDEA^PSSUTLA1(PSOI,PSTYPE) Q:DEAFLG'>0
 I '$L($P($G(^VA(200,+$G(ORNP),"PS")),U,2)),'$L($P($G(^("PS")),U,3)) S FAIL=1
 Q
CHK94(VAL)      ; return 1 if patch 94 has been installed
 S VAL=0
 I $O(^ORD(101.41,"B","PS MEDS",0)) S VAL=1
 Q
