IBCSC4F ;ALB/ARH - GET PTF DIAGNOSIS ;10-OCT-1998
 ;;2.0;INTEGRATED BILLING;**106,403,400,522**;21-MAR-94;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
PTFDXDT(IBPTF,IBDT1,IBDT2,TF) ; collect PTF Transfer (501) and Discharge (701) movements and diagnosis within a date range
 ; if end date is before Discharge date delete Discharge Diagnosis
 ; if bill is an interim first or interim continuous then the last date on the bill is included in the bill
 N IBSTAY,IBADM,IBDSCH,IBDT,IBLAST,IBMDT K ^TMP($J,"IBDX","D"),^TMP($J,"IBDX","M") Q:'$G(IBPTF)
 S IBDT1=+$G(IBDT1)\1 Q:IBDT1'?7N  S IBDT2=+$G(IBDT2)\1 Q:IBDT2'?7N
 ;
 D PTFDX(IBPTF)
 ;
 S IBSTAY=$G(^TMP($J,"IBDX","M")),IBADM=+$P($P(IBSTAY,U,2),".",1),IBDSCH=+$P($P(IBSTAY,U,3),".",1)
 ;
 I IBADM=IBDSCH Q  ; 1 day stay, accept all
 I IBDT1=IBADM,IBDT2=IBDSCH Q  ; bill for entire length of stay, accept all
 ;
 I IBDT2<IBDSCH K ^TMP($J,"IBDX","D") ; discharge date not on bill, exclude 701 Dxs
 I 'IBDSCH,IBDT2<DT K ^TMP($J,"IBDX","D") ; not discharged, current end date (today) not on bill, exclude 701 Dxs
 ;
 ; determine which of the movements should be included based on dates and timeframe
 S TF=$G(TF) I (TF=2)!(TF=3) S IBDT2=$$FMADD^XLFDT(IBDT2,1) ; if first or continuous bill include end date
 ;
 S (IBLAST,IBDT)="" F  S IBDT=$O(^TMP($J,"IBDX","M",IBDT)) Q:'IBDT  D  S IBLAST=IBDT
 . S IBMDT=$P(IBDT,".",1)
 . I IBMDT'>IBDT1 K ^TMP($J,"IBDX","M",IBDT)
 . I IBLAST>IBDT2 K ^TMP($J,"IBDX","M",IBDT)
 Q
 ;
PTFDX(IBPTF) ; collect all PTF Transfer (501) and Discharge (701) movements and diagnosis and try to assign SC
 ; PTF movements are assigned SC or NSC but diagnosis are not
 ; this routine 'interprets' this PTF data and 'assigns' SC/NSC to individual Diagnosis
 ; Movement (501) Diagnosis:  all Dx on SC movements are assigned SC
 ;                            a Dx on an NSC movement that is also the first Dx on an SC move is assigned SC
 ; Discharge (701) Diagnosis: if admit is for SC care all discharge Dx are assigned SC
 ;                            if the Dx is also the first Dx on an SC movement then is assigned SC
 ;                            a Dx on an SC movement only is assigned SC
 ;
 ; Output:  TMP($J,"IBDX","D")=PTF # ^ ADMIT DATE ^ DISCHARGE DATE
 ;          TMP($J,"IBDX","D", DISCHARGE DATE) = DISCHARGE DATE ^ SPECIALTY ^ SC (1/0) ^ DRG ^ PROVIDER
 ;          TMP($J,"IBDX","D", DISCHARGE DATE, x) = DIAGNOSIS ^ SC? (1/0) ^ POA
 ;
 ;          TMP($J,"IBDX","M")=PTF # ^ ADMIT DATE ^ DISCHARGE DATE
 ;          TMP($J,"IBDX","M", MOVEMENT DATE) = MOVEMENT DATE ^ SPECIALTY ^ SC (1/0) ^ DRG ^ PROVIDER
 ;          TMP($J,"IBDX","M", MOVEMENT DATE, x) = DIAGNOSIS ^ SC? (1/0) ^ POA
 ; if patient not discharged then NOW is used as date subscript and first piece will be null, SC?=interpreted SC
 ;
 N IBSTAY,IBMI,IBM0,IBDT,IBMDT,IBMBS,IBMP,IBMDRG,IBMPRV,IBMSC,IBMDX,IBD0,IBDDT,IBDBS,IBDDRG,IBDPRV,IBDSC,IBDDX
 N IBCNT,IBI,IBTMP,DFN,DGVAR,DRG,DRGCAL,ICDCAL,PTF,PTFCOD K ^TMP($J,"IBDX","M"),^TMP($J,"IBDX","D") Q:'$G(IBPTF)
 ;
 S IBSTAY=IBPTF_U_$P($G(^DGPT(IBPTF,0)),U,2)_U_$P($G(^DGPT(IBPTF,70)),U,1) Q:'$P(IBSTAY,U,2)
 ;
 ; collect PTF Movement Diagnosis (501)
 S ^TMP($J,"IBDX","M")=IBSTAY
 S IBMI=0 F  S IBMI=$O(^DGPT(IBPTF,"M",IBMI)) Q:'IBMI  D
 . S IBM0=$G(^DGPT(IBPTF,"M",IBMI,0)) Q:'IBM0
 . S (IBDT,IBMDT)=$P(IBM0,U,10) I 'IBDT S IBDT=$$NOW^XLFDT
 . S IBMBS=$P(IBM0,U,2),IBMSC=$P(IBM0,U,18),IBMSC=$S(IBMSC=1:1,1:"")
 . S IBMP=$G(^DGPT(IBPTF,"M",IBMI,"P")),IBMPRV=$P(IBMP,U,5),IBMDRG=$$MVDRG^IBCRBG(IBPTF,IBMI)
 . ;
 . S ^TMP($J,"IBDX","M",IBDT)=IBMDT_U_IBMBS_U_IBMSC_U_IBMDRG_U_IBMPRV
 . ;
 . D PTFCDS(IBPTF,501,IBMI,.PTFCOD) D  K PTFCOD ; get movements diagnosis
 .. S IBCNT=0,IBI="" F  S IBI=$O(PTFCOD(IBI)) Q:IBI=""  S IBMDX=PTFCOD(IBI) I +IBMDX S IBCNT=IBCNT+1 D
 ... S ^TMP($J,"IBDX","M",IBDT,IBCNT)=+IBMDX_U_U_$P(IBMDX,U,2),IBTMP("DXSC",+IBMDX,+IBMSC,IBCNT)=""
 ;
 ; collect PTF Discharge Diagnosis (701)
 S ^TMP($J,"IBDX","D")=IBSTAY
 S IBD0=$G(^DGPT(IBPTF,70)),IBDPRV=$P(IBD0,U,15),IBDDRG=$$PTFDDRG(IBPTF)
 S (IBDT,IBDDT)=$P(IBD0,U,1) I 'IBDT S IBDT=$$NOW^XLFDT
 S IBDBS=$P(IBD0,U,2),IBDSC=$P(IBD0,U,25),IBDSC=$S(IBDSC=1:1,1:"")
 ;
 S ^TMP($J,"IBDX","D",IBDT)=IBDDT_U_IBDBS_U_IBDSC_U_IBDDRG_U_IBDPRV
 ;
 D PTFCDS(IBPTF,701,,.PTFCOD) D  K PTFCOD ; get discharge diagnosis
 . S IBCNT=0,IBI="" F  S IBI=$O(PTFCOD(IBI)) Q:IBI=""  S IBDDX=PTFCOD(IBI) I +IBDDX S IBCNT=IBCNT+1 D
 .. S ^TMP($J,"IBDX","D",IBDT,IBCNT)=+IBDDX_U_U_$P(IBDDX,U,2)
 ;
 ; Try to assign SC to PTF Diagnosis
 ;
 ; assign SC to Movement Diagnosis (501):  if movement is SC or first Dx on an SC movement
 S IBMDT=0 F  S IBMDT=$O(^TMP($J,"IBDX","M",IBMDT)) Q:'IBMDT  D
 . S IBI="" F  S IBI=$O(^TMP($J,"IBDX","M",IBMDT,IBI)) Q:'IBI  D
 .. S IBMDX=+$G(^TMP($J,"IBDX","M",IBMDT,IBI)) Q:'IBMDX
 .. ;
 .. S IBMSC=+$P($G(^TMP($J,"IBDX","M",IBMDT)),U,3) ; sc move
 .. I 'IBMSC,$D(IBTMP("DXSC",IBMDX,1,1)) S IBMSC=1 ; first dx on sc move
 .. ;
 .. I +IBMSC S $P(^TMP($J,"IBDX","M",IBMDT,IBI),U,2)=1
 ;
 ; assign SC to Discharge Diagnosis (701):  if stay is SC or first Dx on an SC movement or only on SC movement
 S IBDDT=0 F  S IBDDT=$O(^TMP($J,"IBDX","D",IBDDT)) Q:'IBDDT  D
 . S IBI="" F  S IBI=$O(^TMP($J,"IBDX","D",IBDDT,IBI)) Q:'IBI  D
 .. S IBDDX=+$G(^TMP($J,"IBDX","D",IBDDT,IBI)) Q:'IBDDX
 .. ;
 .. S IBDSC=+$P($G(^TMP($J,"IBDX","D",IBDDT)),U,3) ; sc stay
 .. I 'IBDSC,$D(IBTMP("DXSC",IBDDX,1,1)) S IBDSC=1 ; first dx on sc move
 .. I 'IBDSC,+$O(IBTMP("DXSC",IBDDX,"")) S IBDSC=1 ; on sc move only
 .. ;
 .. I +IBDSC S $P(^TMP($J,"IBDX","D",IBDDT,IBI),U,2)=1
 ;
 Q
 ;
SETPOA(IBIFN) ; get POAs from file 19640.1 and put them into file 362.3
 N DIAG,DIEN,IBPTF,IEN362,ORDER,POASET
 ; ICD-9 only, beginning with ICD-10 DSS will pass POA to PTF
 I $$BDATE^IBACSV(IBIFN)'<$$CSVDATE^IBACSV(30) Q
 ; get PTF ien
 S IBPTF=$P($G(^DGCR(399,IBIFN,0)),U,8) Q:IBPTF=""
 ; loop through all entries in 19640.1 for this PTF
 S DIEN="" F  S DIEN=$O(^DSIPPOA("B",IBPTF,DIEN)) Q:DIEN=""  D
 .S DIAG=$P($G(^DSIPPOA(DIEN,0)),U,3) Q:DIAG=""
 .; loop through all DXes in 362.3 for this claim and try to find a match for 19640.1 entry
 .S POASET=0,ORDER="" F  S ORDER=$O(^IBA(362.3,"AO",IBIFN,ORDER)) Q:ORDER=""!(POASET=1)  D
 ..S IEN362=$O(^IBA(362.3,"AO",IBIFN,ORDER,""))
 ..; if DX in 362.3 matches DX in 19640.1, put proper POA indicator into 362.3 and bail out
 ..I DIAG=$P($G(^IBA(362.3,IEN362,0)),U) S $P(^IBA(362.3,IEN362,0),U,4)=$P(^DSIPPOA(DIEN,0),U,4),POASET=1
 ..Q 
 .Q
 Q
 ;
MAXECODE(IBIFN) ; returns 1 if there are already 3 Ecode diagnoses on the claim, 0 otherwise
 N IBDATE,IBDX,CNT
 Q:'IBIFN 0
 S CNT=0,IBDX="",IBDATE=$$BDATE^IBACSV(IBIFN)
 F  S IBDX=$O(^IBA(362.3,"AIFN"_IBIFN,IBDX))  Q:'IBDX  I $E($$ICD9^IBACSV(IBDX,IBDATE))="E" S CNT=CNT+1
 Q CNT>2
 ;
 ;
PTFDDRG(PTF) ; Returns PTF Discharge DRG (#45, 9) calculated field (clean up DG and ICD variables)
 N IBI,DFN,DGDAT,DGPMAN,DGPMCA,DGPTDAT,DGPTTMP,DGTMP,DGVAR,DRG,DRGCAL,EFFDATE
 N ICD10ORNIT,ICD10ORT,ICD10SDT,ICDCAL,ICDCDSY,ICDCSYS,ICDDATE,ICDDA,ICDIEN,ICDPOA,ICDRG,ICDTMP,ICDX,IMPDATE
 ;
 S IBI="" I +$G(PTF) S IBI=$$GET1^DIQ(45,PTF,9,"")
 Q IBI
 ;
PTFCDS(PTF,TYPE,NODE,PTFARR) ; Get PTF Diagnosis (501, 701) and PTF ICD Procedures (401, 601) Codes   DBIA ICR #6130
 ; returns codes for a single event: Discharge, one Movement, one Procedure or one Surgery
 ; Input:   PTF #, TYPE: 701, 501, 401, 601,  NODE: subfile IEN requested (501, 401, 601)
 ; Output:  PTFARR returned array of Diagnosis or Procedure codes found for event, pass by reference
 ;          PTFARR(x) = Dx IEN ^ POA ^ ... for 701 and 501,  PTFARR(x) =  ICD Prc IEN ^ ... for 401 and 601
 ; 
 N DGPMAN,DGPMCA K PTFARR S PTFARR=0 Q:'$G(PTF)
 S TYPE=$G(TYPE) I TYPE'=401,TYPE'=501,TYPE'=601,TYPE'=701 Q
 S NODE=$G(NODE) I TYPE'=701,'NODE Q
 ;
 D PTFICD^DGPTFUT(TYPE,PTF,NODE,.PTFARR)
 Q
