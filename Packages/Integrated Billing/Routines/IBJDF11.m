IBJDF11 ;ALB/CPM - THIRD PARTY FOLLOW-UP REPORT (COMPILE) ;09-JAN-97
 ;;2.0;INTEGRATED BILLING;**69,80,118,128,204,205,227,451,530,554,568,618,663**;21-MAR-94;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
DQ ; - Tasked entry point.
 K ^TMP("IBJDF1",$J) S IBQ=0
 ;
 ; - Collect divisions when running the job for all divisions.
 I IBSD,VAUTD S J=0 F  S J=$O(^DG(40.8,J)) Q:'J  S VAUTD(J)=""
 ;
 ; - Find data required for the report.
 S IBA=0 F  S IBA=$O(^PRCA(430,"AC",16,IBA)) Q:'IBA  D  Q:IBQ
 .;
 .I IBA#100=0 S IBQ=$$STOP^IBOUTL("Third Party Follow-Up Report") Q:IBQ
 .;
 .;**IB*2.0*618 - Moved ahead of RI Bill check to ensure 
 .;               claim exists before checking rate types
 .;               on Community Care Categories.
 .I '$D(^DGCR(399,IBA,0)) Q  ; No corresponding claim to this AR.
 .;
 .S IBAR=$G(^PRCA(430,IBA,0))
 .;
 .;**IB*2.0*618 - Change add new AR Categories and AR Category/
 .;                 Rate Types
 .S IBARNUM=$$GET1^DIQ(430.2,$P(IBAR,U,2)_",",6)   ; Get AR Cat Num
 .Q:'$$CHKARNUM(IBARNUM)    ;Confirm RI Bill, quit if not
 .;
 .; - Determine whether bill is inpatient, outpatient, or RX refill.
 .S IBTYP=$P($G(^DGCR(399,IBA,0)),U,5),IBTYP=$S(IBTYP>2:2,1:1)
 .S:$D(^IBA(362.4,"C",IBA)) IBTYP=3
 .I $P(IBAR,U,2)=45 S IBTYP=4  ;IB*2*554/DRF Look for Non-VA
 .I $P(IBAR,U,2)>47,($P(IBAR,U,2)<52) S IBTYP=4  ;IB*2.0*6 - Community Care third party
 .I IBSEL'[IBTYP,IBSEL'[5 Q
 .;
 .; - Check the receivable age, if necessary.
 .I IBSMN S:"Aa"[IBSDATE IBARD=$$ACT^IBJDF2(IBA) S:"Dd"[IBSDATE IBARD=$$DATE1^IBJDF2(IBA) Q:'IBARD  S:IBARD IBARD=$$FMDIFF^XLFDT(DT,IBARD) I IBARD<IBSMN!(IBARD>IBSMX) Q
 .;
 .; - Check the minimum dollar amount, if necessary.
 .S IBWBA=+$G(^PRCA(430,IBA,7)) I IBSAM,IBWBA<IBSAM Q
 .;
 .; - Get division, if necessary.
 .I 'IBSD S IBDIV=0
 .E  S IBDIV=$$DIV^IBJDF2(IBA) I 'IBDIV S IBDIV=+$$PRIM^VASITE()
 .I IBSD,'VAUTD Q:'$D(VAUTD(IBDIV))  ;  Not a selected division.
 .;
 .; - Exclude receivables referred to Regional Counsel, if necessary.
 .S IBWRC=$G(^PRCA(430,IBA,6)) I 'IBSRC,$P(IBWRC,U,4) Q
 .S IBWRC=$S('$P(IBWRC,U,4):"",$P(IBWRC,U,22):$P(IBWRC,U,22),1:$P(IBWRC,U,4))
 .;
 .; - Get the insurance carrier and exclude claim, if necessary.
 .S IBWIN=$$INS(IBA) I IBWIN="" Q
 .;
 .; - Get the claim patient and exclude claim, if necessary.
 .S IBWPT=$$PAT(IBA) I IBWPT="" Q
 .;
 .; - Get remaining claim information.
 .; IB*2.0*451 - get 1st/3rd party payment EEOB indicator for bill
 .S IBPFLAG=$$EEOB^IBOA31(IBA)
 .S IBWDP=$P(IBAR,U,10)
 .;IB*2.0*530 Add indicator for rejects - External Bill # (.01) value is passed in, not IEN
 .S IBWBN=$G(IBPFLAG)_$S(+$$BILLREJ^IBJTU6($P($G(^DGCR(399,IBA,0)),U)):"c",1:"")_$P(IBAR,U) ; flag bill # when applicable
 .S IBBU=$G(^DGCR(399,IBA,"U")),IBWFR=+IBBU,IBWTO=$P(IBBU,U,2)
 .S IBWSC=$$OTH($P(IBWPT,U,5),$P(IBWIN,"@@",2),IBWFR),IBWOR=$P(IBAR,U,3)
 .S IBWSI=$P($G(^DPT(+$P(IBWPT,U,5),.312,+$P($G(^DGCR(399,IBA,"MP")),U,2),0)),U,2)
 .;
 .; - Set up main report index.
 .F X=IBTYP,5 I IBSEL[X D
 ..S ^TMP("IBJDF1",$J,IBDIV,X,IBWIN,$P(IBWPT,U)_"@@"_$P(IBWPT,U,5),IBWDP_"@@"_IBWBN)=$P(IBWPT,U,2)_" ("_$P(IBWPT,U,4)_")"_U_$P(IBWPT,U,3)_U_IBWSC_U_IBWFR_U_IBWTO_U_IBWOR_U_IBWBA_"~"_IBWRC_U_IBWSI
 .;
 .; - Add bill comment history, if necessary.
 .I IBSH D
 ..S X=0 F  S X=$O(^PRCA(433,"C",IBA,X)) Q:'X  D
 ...S Y=$G(^PRCA(433,X,1))
 ...I $P(Y,U,2)'=35,$P(Y,U,2)'=45 Q  ; Not a decrease/comment transact.
 ...S DAT=$S(Y:+Y\1,1:+$P(Y,U,9)\1)
 ...;
 ...; - Append brief and transaction comments.
 ...K COM,COM1 S COM(0)=DAT,X1=0
 ...S COM1(1)=$P($G(^PRCA(433,X,5)),U,2),COM1(2)=$E($P($G(^(8)),U,6),1,70)
 ...S COM(1)=COM1(1)_$S(COM1(1)]""&(COM1(2)]""):"|",1:"")_COM1(2)
 ...I COM(1)]"" S COM(1)="**"_COM(1)_"**",X1=1
 ...;
 ...; - Get main comments.
 ...S X2=0 F  S X2=$O(^PRCA(433,X,7,X2)) Q:'X2  S COM($S(X1:X2+1,1:X2))=^(X2,0)
 ...;
 ...S X1="" F  S X1=$O(COM(X1)) Q:X1=""  F X2=IBTYP,4 I IBSEL[X2 D
 ....S ^TMP("IBJDF1",$J,IBDIV,X2,IBWIN,$P(IBWPT,U)_"@@"_$P(IBWPT,U,5),IBWDP_"@@"_IBWBN,X,X1)=COM(X1)
 ;
 I 'IBQ D EN^IBJDF12 ; Print the report.
 ;
CHKARNUM(IBCAT) ; Check for Reimbursable insurance
 ; 
 Q:IBCAT=21 1  ;Reimbursable Insurance - Third Party
 ; 
 ;All Non VA care AR Categories, Emergency/Humanitarian, and Ineligible Hospital
 I (IBCAT>46),(IBCAT<54) Q 1  ;Fee Reimbursable Insurance - Third Party
 Q 0
 ;
ENQ K ^TMP("IBJDF1",$J)
 I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K IBA,IBAR,IBARD,IBBU,IBDIV,IBQ,IBIO,IBWRC,IBWPT,IBWDP,IBWIN,IBWBN
 K IBTYP,IBWSC,IBWSI,IBWFR,IBWTO,IBWOR,IBWBA,COM,COM1,DAT,VAUTD,IBARNUM
 K X,X1,X2,Y,Z
 Q
 ;
INS(X) ; - Find the Insurance company and decide to include the claim.
 ;  Input: X=Pointer to the claim/AR in file #399/#430
 ;           plus all variable input in IBS*
 ; Output: Y=Insurance Company name and pointer to file #36
 ;
 N Y,Z,Z1 S Y=""
 I '$G(X) G INSQ
 S Z=+$G(^DGCR(399,X,"MP")),Z1=$P($G(^DIC(36,Z,0)),U)
 I $G(IBSI) G INSQ:'$D(IBSI(Z)),INSC
 I IBSIF'="@",'Z G INSQ
 I $D(IBSIA) G:IBSIA="ALL"&('Z) INSQ G:IBSIA="NULL"&(Z) INSQ
 I Z1="" S Z1="UNKNOWN" G INSC
 I $G(IBSIA)="ALL" G INSC
 I IBSIF="@",IBSIL="zzzzz" G INSC
 I IBSIF]Z1!(Z1]IBSIL) G INSQ
 ;
INSC S Y=Z1_"@@"_Z
INSQ Q Y
 ;
PAT(X) ; - Find the claim patient and decide to include the claim.
 ;  Input: X=Pointer to the claim/AR in file #399/#430
 ;           plus all variable input in IBS*
 ; Output: Y=1^2^3^4^5, where
 ;           1 => sort key (name or last four)
 ;           2 => patient name
 ;           3 => patient ssn
 ;           4 => patient age
 ;           5 => patient pointer to file #2
 ;
 N AGE,DFN,DOB,KEY,Y,Z S Y=""
 I '$G(X) G PATQ
 S DFN=+$P($G(^DGCR(399,X,0)),U,2),Z=$G(^DPT(DFN,0))
 S KEY=$S(IBSN="N":$P(Z,U),1:$E($P(Z,U,9),6,9))
 ;
 I IBSNF'="@",'DFN G PATQ
 I $D(IBSNA) G:IBSNA="ALL"&('DFN) PATQ G:IBSNA="NULL"&(DFN) PATQ
 I KEY="" S Y="UNK^UNK^UNK^UNK^UNK" G PATQ
 I $G(IBSNA)="ALL" G PATC
 I IBSNF="@",IBSNL="zzzzz" G PATC
 I IBSNF]KEY!(KEY]IBSNL) G PATQ
 ;
PATC ; - Find all patient data.
 S DOB=$P(Z,U,3)
 S AGE=$S('DOB:"UNK",1:$E(DT,1,3)-$E(DOB,1,3)-($E(DT,4,7)<$E(DOB,4,7)))
 S Y=KEY_U_$E($P(Z,U),1,17)_U_$P(Z,U,9)_U_AGE_U_DFN
PATQ Q Y
 ;
OTH(DFN,INS,DS) ; - Find a patient's other valid insurance carrier (if any).
 ;  Input: DFN=Pointer to the patient in file #2
 ;         INS=Pointer to the patient's primary carrier in file #36
 ;          DS=Date of service for validity check
 ; Output: Valid insurance carrier (1st 13 chars.) or null
 ;
 N Y S Y="" I '$G(DFN)!('$G(DS)) G OTHQ
 S Z=0 F  S Z=$O(^DPT(DFN,.312,Z)) Q:'Z  S X=$G(^(Z,0)) D:X  Q:Y]""
 .I $G(INS),+X=INS Q
 .S X1=$G(^DIC(36,+X,0)) I X1="" Q
 .I $P(X1,U,2)'="N",$$CHK^IBCNS1(X,DS) S Y=$E($P(X1,U),1,13)
 ;
OTHQ Q Y
