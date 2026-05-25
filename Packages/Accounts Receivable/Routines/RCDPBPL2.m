RCDPBPL2 ;EDE/YMG - bill profile eligibility screen; 08/21/2025
 ;;4.5;Accounts Receivable;**462**;Mar 20, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
INIT ; initialization for list manager list
 ; requires RCBILLDA
 N DFN,LN,MTCODE,MTIEN,STR,TMP,TMP1,VAEL,VAL,Z
 S DFN=$$GETDFN(RCBILLDA)
 S TMP=$$LST^DGMTU(DFN),MTIEN=$P(TMP,U),MTCODE=$P(TMP,U,4)
 S VAL=$S('TMP:"N/A",MTCODE="P":"PEN",MTCODE="C":"YES",MTCODE="G":"GMT",MTCODE="R":"REQ",MTCODE="N":"NLR",1:"No")
 S STR=$$SETSTR^VALM1("Means Test: "_VAL,"",12,28)
 S VAL=$S(+$$INSURED^IBCNS1(DFN):"Yes",1:"No")
 S STR=$$SETSTR^VALM1("Insured: "_VAL,STR,51,50)
 S LN=1 D SET^VALM10(LN,STR)
 S VAL=$$FMTE^XLFDT($P(TMP,U,2),"2DZ")
 S STR=$$SETSTR^VALM1("Date of Test: "_VAL,"",10,28)
 S VAL=$P($$LST^DGMTU(DFN,"",2),U,3) S:VAL="" VAL="N/A"
 S STR=$$SETSTR^VALM1("Co-pay Exemption Test: "_VAL,STR,37,50)
 S LN=LN+1 D SET^VALM10(LN,STR)
 I MTCODE="N" D
 .S TMP=$$GET1^DIQ(408.31,MTIEN,.17,"I")
 .S VAL=$S(TMP>0:$$FMTE^XLFDT(TMP,"2DZ"),1:"Missing")
 .S STR=$$SETSTR^VALM1("Means Test NLR Date: "_VAL,"",3,29)
 .S LN=LN+1 D SET^VALM10(LN,STR)
 .Q
 S LN=LN+1 D SET^VALM10(LN,"")
 S TMP=$$INDGET^IBINUT1(DFN),Z=$P(TMP,U),VAL=$S(Z="Y":"Yes",Z="N":"No",1:"Unanswered")
 S STR=$$SETSTR^VALM1("AI/AN: "_VAL,"",17,28)
 S TMP1=$P(TMP,U,2)
 S VAL=$S(TMP1:$$FMTE^XLFDT(TMP1,"2DZ"),Z="Y":"Missing",1:"N/A")
 S STR=$$SETSTR^VALM1("AI/AN Effective Date: "_VAL,STR,38,50)
 S LN=LN+1 D SET^VALM10(LN,STR)
 S TMP1=$P(TMP,U,3)
 S VAL=$S(TMP1:$$FMTE^XLFDT(TMP1,"2DZ"),1:"N/A")
 S STR=$$SETSTR^VALM1("AI/AN End Date: "_VAL,"",44,50)
 S LN=LN+1 D SET^VALM10(LN,STR)
 S TMP=$$CVEDT^DGCV(DFN),Z=$P(TMP,U),VAL=$S(Z=1:"Yes",Z=0:"No",1:"N/A")  ; DBIA #4156
 S STR=$$SETSTR^VALM1("Combat Veteran Status: "_VAL,"",1,28)
 S TMP1=$P(TMP,U,2)
 S VAL=$S(Z=1&TMP1:$$FMTE^XLFDT(TMP1,"2DZ"),Z=1:"Missing",1:"N/A")
 S STR=$$SETSTR^VALM1("CV End Date: "_VAL,STR,47,50)
 I TMP1,TMP1<DT S STR=$$SETSTR^VALM1(" (Expired)",STR,68,20)
 S LN=LN+1 D SET^VALM10(LN,STR)
 D ELIG^VADPT S VAL=$S('VAEL(3):"No",1:$P(VAEL(3),U,2)_"%")
 S STR=$$SETSTR^VALM1("Service Connected: "_VAL,"",5,28)
 S Z=$$GET1^DIQ(2,DFN,.3014,"I") S VAL=$S(Z>0:$$FMTE^XLFDT(Z,"2DZ"),Z'>0&VAEL(3):"Missing",1:"N/A")
 S STR=$$SETSTR^VALM1("Comb. SC % Effective Date: "_VAL,STR,33,50)
 S LN=LN+1 D SET^VALM10(LN,STR)
 S VAL=$P(VAEL(1),U,2)_$S(VAEL(8)'="":"  --  "_$P(VAEL(8),U,2),1:"")
 S STR=$$SETSTR^VALM1("Primary Elig. Code: "_VAL,"",1,79)
 S LN=LN+1 D SET^VALM10(LN,STR)
 S VAL=""
 I $D(VAEL(1))>1 S Z=0 F  S Z=$O(VAEL(1,Z)) Q:'Z  S:VAL'="" VAL=VAL_"," S VAL=VAL_$P(VAEL(1,Z),U,2)
 I VAL="" S VAL="None"
 S STR=$$SETSTR^VALM1("Secondary Elig. Codes: "_VAL,"",1,79)
 S LN=LN+1 D SET^VALM10(LN,STR)
 S LN=LN+1 D SET^VALM10(LN,"")
 S VAL=$S('VAEL(4):"Not a Veteran",'$O(^DPT(DFN,.372,0)):"None",1:"")
 S STR=$$SETSTR^VALM1("Rated Disabilities: "_VAL,"",1,79)
 S LN=LN+1 D SET^VALM10(LN,STR)
 I VAL="" D
 .S Z=0 F  S Z=$O(^DPT(DFN,.372,Z)) Q:'Z  D
 ..S TMP=^DPT(DFN,.372,Z,0),TMP1=^DIC(31,+TMP,0)
 ..S VAL=$S($P(TMP1,U,4)="":$P(TMP1,U),1:$P(TMP1,U,4))_" ("_$P(TMP,U,2)_"%-"_$S(+$P(TMP,U,3):"SC",1:"NSC")_")"
 ..S STR=$$SETSTR^VALM1(VAL,"",1,79)
 ..S LN=LN+1 D SET^VALM10(LN,STR)
 ..Q
 .Q
 S VALMCNT=LN
 Q
 ;
HDR ; list manager display header
 ; requires RCBILLDA
 N DATA,PRCOUT,RCDEBTDA
 S RCDEBTDA=$P(^PRCA(430,RCBILLDA,0),U,9),DATA=$$ACCNTHDR^RCDPAPLM(RCDEBTDA)
 ; get EEOB indicator for 1st/3rd party payment and attach to bill when applicable
 S PRCOUT=$$COMP3^PRCAAPR(RCBILLDA) S:PRCOUT'="%" PRCOUT=$$IBEEOBCK^PRCAAPR1(RCBILLDA)
 S VALMHDR(1)=$$LJ^XLFSTR("Bill #: "_PRCOUT_$$GET1^DIQ(430,RCBILLDA,.01),28)_$$LJ^XLFSTR("Account: "_$P(DATA,U)_$P(DATA,U,2),50)
 S VALMSG="|% EEOB | Enter ?? for more actions |"
 Q
 ;
EXIT ;  exit list manager
 D CLEAN^VALM10
 D CLEAR^VALM1
 Q
 ;
GETDFN(RCBILLDA) ; get patient DFN for a given bill
 ;
 ; RCBILLDA - file 430 ien
 ;
 ; returns DFN if available, 0 otherwise
 ;
 N DEBTOR,DFN,N0,TMP
 I RCBILLDA'>0 Q 0
 S N0=$G(^PRCA(430,RCBILLDA,0)) I N0="" Q 0  ; node 0 of file 430
 S DFN=$P(N0,U,7) Q:DFN>0 DFN
 S DEBTOR=$P(N0,U,9)
 I DEBTOR S TMP=$P(^RCD(340,DEBTOR,0),U) I TMP["DPT(" S DFN=$P(TMP,";") Q:DFN>0 DFN
 Q 0
