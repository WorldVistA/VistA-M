IBJDI11 ;ALB/CPM - PERCENTAGE OF COMPLETED REGISTRATIONS (CONT'D) ;16-DEC-96
 ;;2.0;INTEGRATED BILLING;**100,118,128,249**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; - Entry point from IBJDI1.
 ;
 ; - Get patient's most recent registration.
 S IBREG=$G(^DPT(DFN,"DIS",+$O(^DPT(DFN,"DIS",0)),0)) I 'IBREG G ENQ
 ;
 ; - Get division, if necessary.
 I 'IBSORT S IBDIV=0
 E  S IBDIV=+$P(IBREG,U,4) I 'IBDIV S IBDIV=+$$PRIM^VASITE()
 I IBSORT,'VAUTD,'$D(VAUTD(IBDIV)) Q  ; Not a selected division.
 ;
 ; - Set 'total registrations' accumulator.
 S IB(IBDIV,"TOT")=IB(IBDIV,"TOT")+1
 ;
 ; - Check if patient is a non-veteran.
 D ELIG^VADPT S IBNVET=$S('VAEL(4):1,1:0)
 ;
 ; - Check if patient is deceased; get DOD.
 I +$G(^DPT(DFN,.35)) D
 .S IBDOD=$$DAT1^IBOUTL(+^DPT(DFN,.35)\1),IB(IBDIV,"DEC")=IB(IBDIV,"DEC")+1
 E  S IBDOD=""
 ;
 ; - Check if patient is/was getting inpatient care.
 S IBINPT=""
 I $$INPT^IBAMTS1(DFN,IBEDT) S IBINPT="*"
 E  S IBX=$O(^DGPM("APTT3",DFN,(IBBDT-.01)))\1 I IBX,IBX<IBEDT S IBINPT="*"
 ;
 ; - Check for 'no billable treatment' dispositions.
 I $$NOTR(DFN,IBBDT,IBEDT,0) S IBNOTR="+",IB(IBDIV,"NOTR")=IB(IBDIV,"NOTR")+1
 E  S IBNOTR="",IB(IBDIV,"TR")=IB(IBDIV,"TR")+1
 ;
 ; - Set accumulators for the breakdown of the total number.
 D INC(DFN,.IBIN)
 I IBIN]"" D:IBNOTR=""  G EN1
 .I IBNVET D
 ..S IBIN=+$P(IBREG,U,13)_";"_IBIN,IB(IBDIV,"NVETI")=IB(IBDIV,"NVETI")+1
 .E  S IB(IBDIV,"VETI")=IB(IBDIV,"VETI")+1
 .S IB(IBDIV,"INC")=IB(IBDIV,"INC")+1
 I IBNOTR="" D
 .S IB(IBDIV,"COM")=IB(IBDIV,"COM")+1
 .I IBNVET S IB(IBDIV,"NVETC")=IB(IBDIV,"NVETC")+1
 .E  S IB(IBDIV,"VETC")=IB(IBDIV,"VETC")+1
 ;
EN1 I IBRPT="S"!(IBIN="") G ENQ ; Summary info only/No inconsistencies.
 ;
 ; - Get patient's type of care.
 S X=+$P(IBREG,U,3),IBTOC=$S(X=1:"HOSPITAL",X=2:"DOMICILIARY",X=3:"OPT. MEDICAL",X=4:"OPT. DENTAL",X=5:"N.H. CARE",1:"")
 ;
 ; - Get next scheduled treatment date.
 S IBNEXT=""
 I $$GETICN^MPIF001(DFN)>0 S ^TMP("IBDFN",$J,DFN)="" ; for future look up scheduled appts.
 S X=0 F  S X=$O(^DGS(41.1,"B",DFN,X)) Q:'X  D  ;   Scheduled adm.
 .S X1=$G(^DGS(41.1,X,0)),X2=$P(X1,U,2)\1
 .I X2<DT Q  ;       Must be old scheduled admission.
 .I $P(X1,U,13) Q  ; Scheduled admission is cancelled.
 .I $P(X1,U,17) Q  ; Patient already admitted.
 .I X2>IBNEXT S IBNEXT=X2
 ;
 ; - Save detail information.
 S ^TMP("IBJDI1",$J,IBDIV,IBNVET,$E($P(IBDN,U),1,25)_IBINPT_IBNOTR_"@@"_DFN)=$P(IBDN,U,9)_U_$E($P($G(^DPT(DFN,.13)),U),1,15)_U_IBTOC_U_IBIN_U_$E($P($G(^VA(200,+$P(IBREG,U,9),0)),U),1,20)_U_IBNEXT_U_IBDOD
 ;
ENQ K VA,VAEL,VAERR
 Q
 ;
NOTR(DFN,IBBDT,IBEDT,Z) ; - Check for patient's 'no treatment' dispositions.
 ;  Input:   DFN = Patient IEN
 ;         IBBDT = Start date for search
 ;         IBEDT = Ending date for search
 ;             Z = 1-Look for 'no treatment' dispositions only
 ;                 0-Also look for C&P/emply/collat/non-ct clinic visits
 ; Output: 0 = Patient had no 'no treatment' dispositions or patient
 ;             had treatment within selected date range
 ;         1 = Patient had at least one 'no treatment' disposition or
 ;             C&P exam/employee/collateral/non-count clinic visit
 ;
 N IBDIS,VAROOT,VARP,X,X1,X2,Y
 S VAROOT="IBDIS",VARP("F")=IBBDT,VARP("T")=IBEDT D REG^VADPT
 S Y=1 I '$O(IBDIS(0)) G NTQ
 S (X,X1)=0 F  S X=$O(IBDIS(X)) Q:X=""  D  I X1 S Y=0 Q
 .S X2=+$P($G(^DPT(DFN,"DIS",9999999-$P(IBDIS(X,"I"),U,6),0)),U,18)
 .S X2=$G(^SCE(X2,0))
 .I $P(X2,U,8)'=2,"^CANCEL WITHOUT EXAM^NO CARE OR TREATMENT REQUIRED^"[("^"_$P(IBDIS(X,"E"),U,7)_"^") Q
 .I 'Z,"^1^4^7^"[("^"_+$P(X2,U,10)_"^") Q  ;    C&P/collat/emply visit.
 .I 'Z,$P($G(^SC(+$P(X2,U,4),0)),U,17)="Y" Q  ; Non-count clinic.
 .S X1=1 ; Patient had treatment.
 ;
NTQ Q Y
 ;
INC(DFN,X) ; - Find a patient's registration inconsistencies.
 ;  Input: DFN = Pointer to the patient in file #2
 ; Output:   X = Passed by reference - the patient's
 ;               registration inconsistencies in the form
 ;
 ;               n;n1;n2;n3...
 ;
 ;               where n is a pointer to file #38.6.
 N I S X=""
 S I=0 F  S I=$O(^DGIN(38.5,DFN,"I",I)) Q:'I  S X=X_I_";"
 I X]"" S X=$E(X,1,$L(X)-1)
 Q
