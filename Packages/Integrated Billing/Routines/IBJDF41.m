IBJDF41 ;ALB/RB - FIRST PARTY FOLLOW-UP REPORT (COMPILE) ;15-APR-00
 ;;2.0;INTEGRATED BILLING;**123,159,204,356,451,473,568,618,651,694,705,715**;21-MAR-94;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to FILE 433.001 in ICR #7321
 ;
ST ; - Tasked entry point.
 K IB,IBCAT,^TMP("IBJDF4",$J)
 S IBQ=0
 ;
 ; - Set selected categories for report.
 I IBSEL[1 S IBCAT(2)=1
 I IBSEL[2 S IBCAT(1)=2
 I IBSEL[3 S IBCAT(18)=3 F X=22,23 S IBCAT(X)=3
 I IBSEL[4 F X=33:1:39 S IBCAT(X)=4
 ; *** new code
 I IBSEL[5 D
 . F X=61:1:74 S IBCAT(X)=5
 . F X=81:1:85 S IBCAT(X)=5
 ;
 ; - Print the header line for the Excel spreadsheet
 I $G(IBEXCEL) D PHDL
 ;
 ; - Find data required for report.
 F IB=16,19,40 D  G:IBQ ENQ
 . I IBSTA="A",IB'=16 Q  ;      Active AR's only.
 . I IBSTA="S",IB=16 Q   ;      Suspended AR's only.
 . I IB'=40 D 
 . . S IBCAT=""
 . . F  S IBCAT=$O(IBCAT(IBCAT)) Q:IBCAT=""  D
 . . . D INIT^IBJDF43
 . S IBA=0
 . F  S IBA=$O(^PRCA(430,"AC",IB,IBA)) Q:'IBA  D  Q:IBQ
 . . D PROC
 ;
 I 'IBQ,'$G(IBEXCEL) D EN^IBJDF42 ; Print the report.
 ;
ENQ K ^TMP("IBJDF4",$J)
 I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K IB,IB0,IBA,IBA1,IBADM,IBAGE,IBAR,IBAR1,IBBA,IBBN,IBBU,IBC,IBCAT,IBCAT1
 K IBELIG,IBEXCEL,IBFLG,IBAI,IBAIQ,IBIDX,IBIO,IBINT,IBN,IBPA,IBPD,IBPAT
 K IBPT,IBQ,IBRFD,IBRFT,IBSRC,IBRP,IBVA,COM,COM1,DAT,DFN,X,X1,X2,Y,Z
 Q
 ;
PROC ; - Process data for report(s).
 I IBA#100=0 D  Q:IBQ
 . S IBQ=$$STOP^IBOUTL("First Party Follow-Up Report")
 S IBAR=$G(^PRCA(430,IBA,0)) I 'IBAR Q
 S IBCAT=+$P(IBAR,U,2) I '$D(IBCAT(IBCAT)) Q  ; Get valid AR category.
 I '$$CLMACT^IBJD(IBA,IBCAT) Q  ;               Invalid IB claim/action.
 S IBSUSTYP=""
 I IB=40 S IBSUSTYP=$$SUST(IBA)
 I IBSTA="S",IBSELST'[(","_IBSUSTYP_",") Q  ;   Filter by suspended type IB*2*568/DRF
 S IBPT=$$PAT(IBA) I IBPT="" Q  ;               Get patient info.
 S DFN=$P(IBPT,U,2)
 S IBAGE=$$FMDIFF^XLFDT(DT,+$P(IBAR,U,10))
 I IBSMN,IBAGE<IBSMN!(IBAGE>IBSMX) Q  ;         AR outside age range.
 S IBVA=$$VA^IBJD1(DFN),IBBN=$P(IBAR,U),IBPD=$P($$PYMT^IBJD1(IBA),U)
 S IBPAT=$P(IBPT,U)_"@@"_DFN
 ;
 ; - Check the AR balance amounts, if necessary.
 S (IBADM,IBBA,IBINT,IBPA)=0,IBN=$G(^PRCA(430,IBA,7))
 F X=1:1:5 D
 . S IBBA=IBBA+$P(IBN,U,X)
 . S:X=1 IBPA=+IBN S:X=2 IBINT=$P(IBN,U,2) S:X=3 IBADM=$P(IBN,U,3)
 ;
 I '$G(IBEXCEL) D EN^IBJDF43 I IBRPT="S"!(IBRPT="O") Q  ;   Get summary stats.
 ;
 I IBSAM,IBBA<IBSAM Q
 ;
 ; - Check if AR was referred to R-Regional Counsel, D-DMC, T-TOP,
 ;   or C-CROSS SERVICING and exclude, if necessary.
 S IB0=$S(IB=40:19,1:IB),IBIDX=0,IBRFT=""
 S IBAIQ=0,IBAI=$G(^TMP("IBJDF4",$J,IBPAT,0,"A"))
 S IBRFD=$P($G(^PRCA(430,IBA,6)),U,4)
 I IBRPT="D",IBRFD D  I IBAIQ Q                   ; Referred to RC
 . S IBRFT="R" I IBAI'["R" S IBAI=IBAI_"R"
 . I 'IBSRC S IBAIQ=1 Q
 . D SREF("R",IBRFD,IB0,,.IBIDX)
 S IBRFD=+$G(^PRCA(430,IBA,12))
 I IBRPT="D",IBRFD D                              ; Referred to DMC
 . S IBRFT=IBRFT_"D" I IBAI'["D" S IBAI=IBAI_"D"
 . D SREF("D",IBRFD,IB0,,.IBIDX)
 S IBRFD=+$G(^PRCA(430,IBA,14))
 I IBRPT="D",IBRFD D                              ; Referred to TOP
 . S IBRFT=IBRFT_"T" I IBAI'["T" S IBAI=IBAI_"T"
 . D SREF("T",IBRFD,IB0,,.IBIDX)
 ; PRCA*4.5*338 added CS 
 S IBRFD=+$G(^PRCA(430,IBA,15))
 I IBRPT="D",IBRFD D                              ; Referred to CS 
 . S IBRFT=IBRFT_"C" I IBAI'["C" S IBAI=IBAI_"C"
 . D SREF("C",IBRFD,IB0,,.IBIDX)
 ;
 ; - Check if AR is on P-Repayment plan or F-Defaulted repayment plan.
 ;   and exclude if repayment plan is active.
 S IBRP=$$RP(IBA)
 I IBRP D
 . I IBRP=2 S IBRFT=IBRFT_"F"  I IBAI'["F" S IBAI=IBAI_"F"
 . I IBRP=1 S IBRFT=IBRFT_"P" I IBAI'["P"&(IBAI'["F") S IBAI=IBAI_"P"
 . D SREF("P",$P(IBRP,"^",2),IB0,$S(+IBRP=2:1,1:0),.IBIDX)
 ;
 I IBIDX S IBFLG=1
 ;
 ; - Check if VA Employee
 I $P(IBVA,"^")["*",IBAI'["V" S IBAI=IBAI_"V"
 ;
 I IBAI'="" S ^TMP("IBJDF4",$J,IBPAT,0,"A")=IBAI
 ;
 ; IB*2.0*451 - Check for EEOB on associated 3rd party bills and attach EOB indicator '%' if applicable
 S IBBN=$$IBEEOBCK(IBBN,DFN)_IBBN  ; Pass AR BILL#, Pat ID
 ;
 ; - Set up indexes for detail report.
 I $G(IBEXCEL) D  Q
 . S IBEXCEL1=$P($G(^PRCA(430.2,IBCAT,0)),U,2)_U_$P(IBPT,U,3)_U_$P(IBVA,U)_U_$P(IBPT,U,4)_U_$$DT^IBJD($P(IBPT,U,6),1)_U_$$ELIG^IBJDF42(+$P(IBPT,U,5))_U
 . S IBEXCEL1=IBEXCEL1_$$GET1^DIQ(2,DFN,.381)_U_$$MTRX(DFN)_U_IBBN_U_$S(IB=16:"A",1:"S")_U_$S("BS"[IBSTA:$$ABBR($G(IBSUSTYP)),1:"")_U_IBRFT_U_$$DT^IBJD($P(IBAR,U,10),1)_U_$$DT^IBJD(IBPD,1)_U_IBBA_U_IBPA_U_IBINT_U_IBADM_U
 . I IBSH D COM
 . S IBD=0 I DAT!IBPD S IBD=$$FMDIFF^XLFDT(DT,$S('DAT:IBPD,1:$G(DAT)))
 . S IBEXCEL1=IBEXCEL1_U_IBD
 . W !,IBEXCEL1 K IBD,IBEXCEL1
 ;
 I '($D(^TMP("IBJDF4",$J,IBPAT))#10) D
 . S ^TMP("IBJDF4",$J,IBPAT)=$P(IBPT,U,3,5)_U_$$MTRX(DFN)_U_$P(IBPT,U,6)_"^"_$P(IBVA,"^",2)_"^"_$$ACCBAL($P(IBPT,U,7))
 S ^TMP("IBJDF4",$J,IBPAT,IB0,IBCAT,IBBN)=IBPD_U_IBBA_U_IBPA_U_IBINT_U_IBADM_U_IBIDX_U_$S($D(IBSUSTYP):IBSUSTYP,1:"")
 ;
 I IBSH D COM
 Q
 ;
ACCBAL(DFN) ; Calculates the Account Balance for the Bill
 ; Input: DFN - Patient/Debtor internal number
 ; Output: BAL - Patient/Debtor Account Balance
 ;
 N B0,B7,BAL,BILL,I
 S (BAL,BILL)=0
 F  S BILL=$O(^PRCA(430,"C",DFN,BILL)) Q:BILL=""  D
 . S B0=$G(^PRCA(430,BILL,0)) I $P(B0,"^",8)'=16 Q
 . S B7=$G(^PRCA(430,BILL,7))
 . F I=1:1:5 S BAL=BAL+$P(B7,"^",I)
 Q BAL
 ;
PHDL ; - Print the header line for the Excel spreadsheet
 N X
 S X="Cat^Patient^VA Empl.?^SSN^Dt Death^Prim.Elig.^Med.Elig.?^"
 S X=X_"Means Tst Sts^Means Tst Dt^RX Copay Exemp.Sts^RX Copay Exemp.Dt^"
 S X=X_"Bill #^Act/Susp^Reason^Refer. to^Dt Bill prep.^Last Pymt Dt^" ;Added reason IB*2*568/DRF
 S X=X_"Curr.Bal.^Princ.Bal.^Int.^Admin.^Last Comm.Dt^Days Lst Comm.^"
 W !,X
 Q
 ;
PAT(X) ; - Find the AR patient and decide to include the AR.
 ;    Input: X=AR pointer to file #430 and pre-set variables IBS*
 ;   Output: Y=Sort key (name or last 4) ^ Patient pointer to file #2 
 ;             ^ Name ^ SSN ^ Eligibilities ^ Date of death (if any)
 ;             ^ Debtor pointer to file #340
 N PAT,KEY,DBTR,DFN,DEATH,NAME,SSN,VAEL,VADM,X1,X2
 S PAT="" G:'$G(X) PATQ
 S DBTR=+$P($G(^PRCA(430,X,0)),U,9)
 S X1=$P($G(^RCD(340,DBTR,0)),U) G:X1'["DPT" PATQ
 S DFN=+X1 G:'DFN PATQ D DEM^VADPT
 S NAME=VADM(1),SSN=$P(VADM(2),"^"),DEATH=VADM(6)\1
 S KEY=$S(IBSN="N":NAME,1:$E(SSN,6,9))
 I KEY=""!(IBSNF'="@"&('DFN)) G PATQ
 I $D(IBSNA) G:IBSNA="ALL"&('DFN) PATQ G:IBSNA="NULL"&(DFN) PATQ
 I $G(IBSNA)="ALL" G PATC
 I IBSNF="@",IBSNL="zzzzz" G PATC
 I IBSNF'=KEY,IBSNF]KEY G PATQ
 I IBSNL'=KEY,KEY]IBSNL G PATQ
 ;
PATC ; - Set patient eligibilities.
 D ELIG^VADPT S X2=+$G(VAEL(1))_";"
 I +X2 S X1=0 F  S X1=$O(VAEL(1,X1)) Q:'X1  S X2=X2_X1_";"
 ;
 S PAT=KEY_U_DFN_U_$E(NAME,1,26)_U_SSN_U_X2_U_DEATH
 S PAT=PAT_U_DBTR
PATQ Q PAT
 ;
RP(X) ; - Check if claim/receivable is under a repayment plan.
 ;    Input: X=Bill pointer to file #430
 ;   Output: 0-Not on repay plan, 1-On repay plan, 2-On defaulted plan
 N RPIEN,Z
 ; IB*2.0*694
 S RPIEN=$P($G(^PRCA(430,X,4)),U,5)  ; file 340.5 ien
 S Z=$$REPDATA(RPIEN,1) I Z="" Q 0
 I $P(Z,U,9)=5 Q ("2^"_$P(Z,U))  ; IB*2.0*694
 ;
 Q ("1^"_$P(Z,U))  ; IB*2.0*694
 ;
MTRX(X) ; - Return patient's means test and/or RX copay status and most recent
 ;   test dates for both.
 ;    Input: X=Patient pointer to file #2 and opt. variable IBEXCEL
 ;   Output: Y=Means test status ^ Date ^ RX copay status ^ Date 
 N MTST,RXST,Y
 S Y="^^^",MTST=$$LST^DGMTU(X),RXST=$$RXST^IBARXEU(X)
 I '$G(IBEXCEL) D
 . S $P(Y,"^",1,2)=$P(MTST,"^",3)_"^"_$$DAT1^IBOUTL($P(MTST,"^",2))
 . S $P(Y,"^",3)=$S('RXST:"NON-EXEMPT",+RXST=1:"EXEMPT",1:"")
 . I $P(Y,"^",3)'="" S $P(Y,"^",4)=$$DAT1^IBOUTL($P(RXST,"^",5))
 I $G(IBEXCEL) D
 . S $P(Y,"^",1,2)=$P(MTST,"^",4)_"^"_$$DT^IBJD($P(MTST,"^",2),1)
 . S $P(Y,"^",3)=$S('RXST:"M",+RXST=1:"E",1:"")
 . I $P(Y,"^",3)'="" S $P(Y,"^",4)=$$DT^IBJD($P(RXST,"^",5),1)
 Q Y
 ;
SREF(RFT,DAT,STS,DEF,IDX) ; Set the "referred to" information on the 
 ;                         temporary global ^TMP
 ;Input: RFT: "R": RC, "D": DMC, "T": TOP, "C": CROSS SERVICING, "P": REPAYMENT PLAN
 ;       DAT: Date it was referred/established
 ;       STS: Receivable status (16-Active,19-Suspended)
 ;       DEF: Repayment Plan in Default? (1 - YES, 0 - NO)
 ;       IDX: Subscript to be set in the Temporary global ^TMP
 ;Output: IDX: Subscript set in the Temporary global ^TMP
 ;
 N SREF,IDX1
 S DEF=+$G(DEF),IDX=+$G(IDX)
 I RFT="R" S SREF="REFERRED TO RC"
 I RFT="D" S SREF="REFERRED TO DMC"
 I RFT="T" S SREF="REFERRED TO TOP"
 I RFT="C" S SREF="REFERRED TO CS" ; PRCA*4.5*338
 I RFT="P" D
 . S SREF="REPAYMENT PLAN ESTABLISHED"
 . I $G(DEF) S SREF=SREF_" (CURRENTLY IN DEFAULT)"
 ;
 I 'IDX S IDX=$O(^TMP("IBJDF4",$J,IBPAT,0,"C",STS,""),-1)+1
 S IDX1=$O(^TMP("IBJDF4",$J,IBPAT,0,"C",STS,IDX,""),-1)+1
 S ^TMP("IBJDF4",$J,IBPAT,0,"C",STS,IDX,IDX1)=DAT
 S ^TMP("IBJDF4",$J,IBPAT,0,"C",STS,IDX,IDX1,1)=SREF
 Q
 ;
COM ; - Get bill comments.
 I 'IBIDX,'$G(IBEXCEL) D
 . S IBFLG=0,IBIDX=$O(^TMP("IBJDF4",$J,IBPAT,0,"C",IB0,""),-1)+1
 ;
 S DAT=0,IBA1=$S(IBSH1="M":999999999,1:0)
 F  S IBA1=$S(IBSH1="M":$O(^PRCA(433,"C",IBA,IBA1),-1),1:$O(^PRCA(433,"C",IBA,IBA1))) Q:'IBA1  D  I IBSH1="M",DAT Q
 . S IBC=$G(^PRCA(433,IBA1,1)) Q:'IBC
 . I $G(IBSH2),$$FMDIFF^XLFDT(DT,+IBC)>IBSH2 Q  ; Comment age not minimum.
 . I $P(IBC,U,2)'=35,$P(IBC,U,2)'=45 Q  ;   Not decrease/comment transact.
 . S DAT=$S(IBC:+IBC\1,1:+$P(IBC,U,9)\1)
 . I $G(IBEXCEL),IBSH1="M" S IBEXCEL1=IBEXCEL1_$$DT^IBJD(DAT,1) Q
 . ;
 . ; - Append brief and transaction comments.
 . K COM,COM1 S COM(0)=DAT,X1=0
 . S COM1(1)=$P($G(^PRCA(433,IBA1,5)),U,2)
 . S COM1(2)=$E($P($G(^PRCA(433,IBA1,8)),U,6),1,70)
 . S COM(1)=COM1(1)_$S(COM1(1)]""&(COM1(2)]""):"|",1:"")_COM1(2)
 . I COM(1)]"" S COM(1)="**"_COM(1)_"**",X1=1
 . ;
 . ; - Get main comments.
 . S X2=0
 . F  S X2=$O(^PRCA(433,IBA1,7,X2)) Q:'X2  D
 . . S COM($S(X1:X2+1,1:X2))=^PRCA(433,IBA1,7,X2,0)
 . ;
 . I $G(IBEXCEL) Q
 . ;
 . S IBFLG=1,^TMP("IBJDF4",$J,IBPAT,0,"C",IB0,IBIDX,IBA1)=$G(COM(0)),X1=0
 . F  S X1=$O(COM(X1)) Q:X1=""  D
 . . S ^TMP("IBJDF4",$J,IBPAT,0,"C",IB0,IBIDX,IBA1,X1)=COM(X1)
 ;
 I '$G(IBEXCEL),IBFLG D
 . S $P(^TMP("IBJDF4",$J,IBPAT,IB0,IBCAT,IBBN),"^",6)=IBIDX
 Q
 ; IB*2.0*451 -  Use Event Date to find an associated 3rd Party bill with an associated EEOB
IBEEOBCK(IBBN,DFN) ; Passed AR Bill, Patient ID
 ; Function will quit as soon as a 3rd party bill is located that has an associated EEOB
 ;
 ; Find 3rd Party Bills with an Event Date
 N IBREF,IBEEOB,IBDT
 S IBEEOB=""
 ; Loop through Xref of ARbill (#430) to Action file (#350)
 I +$G(IBBN) S IBREF=0 F  S IBREF=$O(^IB("ABIL",IBBN,IBREF)) Q:'IBREF  D  Q:IBEEOB="%"
 . S IBDT=$P($G(^IB(IBREF,0)),"^",17) ;Get event Date
 . I IBDT S IBEEOB=$$TPEVDT(DFN,IBDT)
 . I IBDT S IBEEOB=$$TPOPV(DFN,IBDT)
 ;
 Q IBEEOB
 ;
 ; IB*2.0*451 - Traverse all THIRD PARTY bills for a patient with a specific Event Date (399,.03)
TPEVDT(DFN,EVDT) ;
 ; Function will quit as soon as a 3rd party bill is located that has an associated EEOB
 ; IB*2.0*473 - Use the 399,"APDT" (by patient) index instead of the 399,"D" index for efficiency
 I '$G(DFN)!'$G(EVDT) Q ""
 N IBIFN,IBEEOB
 S IBEEOB="",IBIFN=""
 F  S IBIFN=$O(^DGCR(399,"APDT",DFN,IBIFN),-1) Q:'IBIFN  D  Q:IBEEOB="%"
 . I $D(^DGCR(399,"APDT",DFN,IBIFN,9999999-EVDT)) S IBEEOB=$$EEOBCK(IBIFN)
 Q IBEEOB
 ; 
 ; IB*2.0*451 - Traverse all THIRD PARTY bills for a patient with any Opt Visit Dates same as Event Date (399,43)
TPOPV(DFN,EVDT) ;
 ; Function will quit as soon as a 3rd party bill is located that has an associated EEOB
 N IBIFN,IBEEOB
 S IBEEOB=""
 I +$G(DFN),+$G(EVDT) S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"AOPV",DFN,EVDT,IBIFN)) Q:'IBIFN  D  Q:IBEEOB="%"
 . ; attach EOB indicator '%' to bill # when applicable
 . S IBEEOB=$$EEOBCK(IBIFN)
 Q IBEEOB
 ;
 ; IB*2.0*451 - Check for EEOB indicator
EEOBCK(IBBILL)  ;
 ; Check for 1st and 3rd party payment activity on bill
 ; IBBILL is the IEN for the bill # in files #399/#430 and must be valid,
 ; check the EOB type and exclude it if it is an MRA. Otherwise,
 ; returns the EEOB indicator '%' if payment activity was found.
 ; Access to file #361.1 covered by IA #4051.
 ; Access to file #399 covered by IA #3820.
 N IBOUT,IBVAL,Z
 I $G(IBBILL)=0 Q ""
 I '$O(^IBM(361.1,"B",IBBILL,0)) Q ""  ; no entry here
 I $P($G(^DGCR(399,IBBILL,0)),"^",13)=1 Q ""  ;avoid 'ENTERED/NOT REVIEWED' status
 ; handle both single and multiple bill entries in file #361.1
 S Z=0 F  S Z=$O(^IBM(361.1,"B",IBBILL,Z)) Q:'Z  D  Q:$G(IBOUT)="%"
 . S IBVAL=$G(^IBM(361.1,Z,0))
 . S IBOUT=$S($P(IBVAL,"^",4)=1:"",$P(IBVAL,"^",4)=0:"%",1:"")
 Q IBOUT  ; EOB indicator for either 1st or 3rd party payment on bill
 ;
 ;
SUST(IBA) ;Look for suspended type for a suspended bill IB*2*568/DRF
 N TRANS,ST,STIEN
 S IBA=$G(IBA) I IBA="" Q ""
 S ST=""
 ; IB*2.0*715
 S TRANS="" F  S TRANS=$O(^PRCA(433,"C",IBA,TRANS),-1) Q:'TRANS  Q:$$GET1^DIQ(433,TRANS_",",12)="CHARGE SUSPENDED"
 I TRANS>0 S STIEN=$P($G(^PRCA(433,TRANS,1)),U,12) S:STIEN ST=$$GET1^DIQ(433.001,STIEN_",",.01)
 I ST="" S ST=$P($G(^PRCA(433,TRANS,1)),U,11)  ; if no type, try to get it from the old field 433/90
 I ST="" S ST=14  ; if still no type, set it to NONE
 ;
 Q ST
 ;
 ;
ABBR(SUSP) ;Return abbreviation for suspended bill types IB*2*568/DRF
 S SUSP=$G(SUSP)
 I SUSP=0 Q "NonCoS"
 I SUSP=1 Q "IniCoS"
 I SUSP=2 Q "AplCoW"
 I SUSP=3 Q "AdminS"
 I SUSP=4 Q "Compro"
 I SUSP=5 Q "Termin"
 I SUSP=6 Q "BnkCh7"
 I SUSP=7 Q "BnkC13"
 I SUSP=8 Q "BnkOth"
 I SUSP=9 Q "Probat"
 I SUSP=10 Q "Choice"
 I SUSP=11 Q "Disput"
 ; IB*2.0*715
 I SUSP=12 Q "IndAtt"
 I SUSP=13 Q "Compct"
 I SUSP=14 Q "None"
 ;
 Q ""
 ;
REPDATA(RPIEN,DAYS) ; - Return Repayment Plan information IB*2.0*694
 ;
 ; RPIEN - file 340.5 ien
 ; DAYS  - Number of days over the due date for a payment not 
 ;         received to be considered defaulted.
 ;
 ; Output: String with the following "^" (up-arrow) pieces:
 ;              1. Repayment Plan Start Date (FM Format)
 ;              2. Balance (Repayment Plan)
 ;              3. Monthly Payment Amount
 ;              4. Due Date (day of the month)
 ;              5. Last Payment Date
 ;              6. Last Payment Amount
 ;              7. Number of Payments Due
 ;              8. Number of Payments Defaulted
 ;              9. Plan status (internal)
 ;         or NULL if either no RPP data was found or plan was paid in full
 ;
 N DATA,IENS,LPAMT,LPDT,PDEF,PDUE,RES,STATUS,TMPDT,Z
 S RES="",IENS=RPIEN_","
 D GETS^DIQ(340.5,IENS,".04;.06;.07;.11;2*;3*","I","DATA") I '$D(DATA) Q RES
 S RES=$G(DATA(340.5,IENS,.04,"I"))          ; start date - 340.5/.04
 S $P(RES,U,2)=$G(DATA(340.5,IENS,.11,"I"))  ; amount owed - 340.5/.11
 S $P(RES,U,3)=$G(DATA(340.5,IENS,.06,"I"))  ; monthly amount - 340.5/.06
 S STATUS=$G(DATA(340.5,IENS,.07,"I"))       ; plan status - 340.5/.07
 S $P(RES,U,4)=28                            ; due date
 S (LPAMT,LPDT)=0,Z="" F  S Z=$O(DATA(340.53,Z)) Q:Z=""  S TMPDT=+$G(DATA(340.53,Z,.01,"I")) S:TMPDT>LPDT LPDT=TMPDT,LPAMT=+$G(DATA(340.53,Z,1,"I"))
 I LPDT>0 S $P(RES,U,5)=LPDT,$P(RES,U,6)=LPAMT  ; last payment date & amount
 S (PDEF,PDUE)=0,Z="" F  S Z=$O(DATA(340.52,Z)) Q:Z=""  D
 .I +$G(DATA(340.52,Z,1,"I"))=1 Q  ; payment was made
 .S PDUE=PDUE+1  ; inc. # of payments due
 .I +$G(DATA(340.52,Z,2,"I"))=1 Q  ; payment forborne
 .I $$FMDIFF^XLFDT(DT,+$G(DATA(340.52,Z,.01,"I")))'<DAYS S PDEF=PDEF+1  ; inc. # of defaulted payments
 .Q
 I PDUE=0 Q ""  ; plan was paid in full
 S $P(RES,U,7)=PDUE,$P(RES,U,8)=PDEF,$P(RES,U,9)=STATUS  ; #of payments due, # of defaulted payments, & plan status
 Q RES
