ORWPT16 ; SLC/KCM - Patient Lookup Functions - 16bit ;7/20/96  15:43
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243**;Dec 17, 1997;Build 242
 ;
IDINFO(ORY,DFN) ; Return identifying information for a patient
 ; PID^DOB^AGE^SEX^SC%^TYPE^WARD^RM-BED^NAME
 N OR0,OR36,OR1,OR101,VAEL,VAERR
 S OR0=$G(^DPT(DFN,0)),OR36=$G(^(.36)),OR1=$G(^(.1)),OR101=$G(^(.101))
 D ELIG^VADPT
 S ORY=$P(OR36,U,3)_U_$P(OR0,U,3)_U_U_$P(OR0,U,2)
 S ORY=ORY_U_$P(VAEL(3),U,2)_U_$P(VAEL(6),U,2)_U_$P(OR1,U)_U_$P(OR101,U)
 I $P(OR0,U,3) S $P(ORY,U,3)=DT-$P(OR0,U,3)\10000
 I '$L($P(ORY,U,1)) D
 . S X=$P(OR0,U,9),$P(ORY,U,1)=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,99)
 S $P(ORY,U,9)=$P(OR0,U,1)
 Q
DEMOG(VAL,DFN) ; procedure
 ; Return common patient demographic info
 ; NAME^SEX^DOB^SSN^WARDID^WARDNAME^RMBED^ADMITTIME^DIED ;^SC%^ELIGTYPE
 S X=^DPT(DFN,0),VAL=$P(X,U,1,3)_U_$P(X,U,9)_U_U_$G(^(.1))_U_$G(^(.101))
 S X=$P(VAL,U,6) I $L(X) S $P(VAL,U,5)=$O(^SC("B",X,0))
 S X=$G(^DPT(DFN,.105)) I X S $P(VAL,U,8)=$P(^DGPM(X,0),U,1)
 I $L($P($G(^DPT(DFN,.35)),U,1)) S $P(VAL,U,9)=$P(^(.35),U,1)
 Q
PSCNVT(VAL,DFN) ; procedure
 ; Call conversion routine for pharmacy (both inpatient and outpatient)
 S VAL=0
 Q
LISTALL(Y,DIR,FROM) ; Return a bolus of patient names
 N I,IEN,CNT S CNT=44,I=0
 ;
 I DIR=0 D  ; Forward direction
 . F  S FROM=$O(^DPT("B",FROM)) Q:FROM=""  D  Q:I=CNT
 . . S IEN=0 F  S IEN=$O(^DPT("B",FROM,IEN)) Q:'IEN  D  Q:I=CNT
 . . . ; S X=$P($G(^DPT(IEN,0)),"^",9)
 . . . ; S X=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,99)
 . . . ; S X1=$G(^DPT(IEN,.1))_" "_$G(^DPT(IEN,.101))
 . . . S I=I+1 S Y(I)=IEN_"^"_FROM ;_"^"_X ; _"^"_X1  ;"   ("_X_")"
 . I $G(Y(CNT))="" S I=I+1,Y(I)=""
 ;
 I DIR=1 D  ; Reverse direction
 . F  S FROM=$O(^DPT("B",FROM),-1) Q:FROM=""  D  Q:I=CNT
 . . S IEN=0 F  S IEN=$O(^DPT("B",FROM,IEN)) Q:'IEN  D  Q:I=CNT
 . . . ; S X=$P($G(^DPT(IEN,0)),"^",9)
 . . . ; S X=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,99)
 . . . ; S X1=$G(^DPT(IEN,.1))_" "_$G(^DPT(IEN,.101))
 . . . S I=I+1 S Y(I)=IEN_"^"_FROM ;_"^"_X ; _"^"_X1  ;"   ("_X_")"
 Q
LOOKUP(Y,FROM) ; Return a set of patient names
 N I,X
 D FIND^DIC(2,"","","M",FROM)
 S I=0,Y=""
 F  S I=$O(^TMP("DILIST",$J,1,I)) Q:'I  D
 . S X=^TMP("DILIST",$J,"ID",I,.09)
 . S X=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,99)
 . S Y(I)=^TMP("DILIST",$J,2,I)_"^"_^TMP("DILIST",$J,1,I)_"^"_X
 K ^TMP("DILIST",$J)
 Q
GETVSIT(Y,DFN,LOC,ADATE) ; procedure
 ; Return a visit given a patient, location, and date/time
 N VSIT,VSITPKG
 S (VSIT,VSIT("VDT"))=ADATE,VSIT("PAT")=DFN,VSIT("LOC")=LOC
 S VSIT("SVC")="A",VSIT("PRI")="P",VSIT(0)="NMD1",VSITPKG="OR"
 D ^VSIT
 S Y=VSIT("IEN") I +VSIT("IEN")'>0 S Y="" Q
 I +VSIT("LOC") S Y=Y_U_VSIT("LOC")_U_$P(^SC(+VSIT("LOC"),0),U,1,2)
 Q
APPTLST(LST,DFN) ; procedure
 ; Return a list of appointments
 N I,ILST S ILST=0
 D GETAPPT^TIUVSIT(DFN)
 S I=0 F  S I=$O(^TMP("TIUVNI",$J,I)) Q:'I  D
 . S ILST=ILST+1
 . S LST(ILST)=$P(^TMP("TIUVNI",$J,I),U,1,2)_U_$P(^TMP("TIUVN",$J,I),U,1,2)
 K ^TMP("TIUVN",$J),^TMP("TIUVNI",$J)
 Q
ADMITLST(LST,DFN) ; procedure
 ; Return a list of admissions
 N TIM,MOV,X0,Y,MTIM,XTIM,XTYP,XLOC,HLOC,ILST S ILST=0
 S TIM="" F  S TIM=$O(^DGPM("ATID1",DFN,TIM)) Q:TIM'>0  D
 . S MOV=0  F  S MOV=$O(^DGPM("ATID1",DFN,TIM,MOV)) Q:MOV'>0  D
 . . S X0=^DGPM(MOV,0)
 . . S MTIM=$P(X0,U,1),Y=MTIM D DD^%DT S XTIM=Y
 . . S XTYP=$P($G(^DG(405.1,+$P(X0,U,4),0)),U,1)
 . . S XLOC=$P($G(^DIC(42,+$P(X0,U,6),0)),U,1),HLOC=+$G(^(44))
 . . S ILST=ILST+1,LST(ILST)=MTIM_U_HLOC_U_XTIM_U_XTYP_U_"TO: "_XLOC
 Q
