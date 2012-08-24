IBJDF41 ;ALB/RB - FIRST PARTY FOLLOW-UP REPORT (COMPILE) ;15-APR-00
 ;;2.0;INTEGRATED BILLING;**123,159,204,356,451,473**;21-MAR-94;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ST ; - Tasked entry point.
 K IB,IBCAT,^TMP("IBJDF4",$J)
 S IBQ=0
 ;
 ; - Set selected categories for report.
 I IBSEL[1 S IBCAT(2)=1
 I IBSEL[2 S IBCAT(1)=2
 I IBSEL[3 S IBCAT(18)=3 F X=22,23 S IBCAT(X)=4
 I IBSEL[4 F X=33:1:39 S IBCAT(X)=5
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
 S IBCAT=+$P(IBAR,U,2) I '$D(IBCAT(IBCAT)) Q   ;Get valid AR category.
 I '$$CLMACT^IBJD(IBA,IBCAT) Q  ;               Invalid IB claim/action.
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
 I '$G(IBEXCEL) D EN^IBJDF43 I IBRPT="S" Q  ;   Get summary stats.
 ;
 I IBSAM,IBBA<IBSAM Q
 ;
 ; - Check if AR was referred to R-Regional Counsel, D-DMC, or T-TOP
 ;   and exclude, if necessary.
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
 . S IBEXCEL1=IBEXCEL1_$$GET1^DIQ(2,DFN,.381)_U_$$MTRX(DFN)_U_IBBN_U_$S(IB=16:"A",1:"S")_U_IBRFT_U_$$DT^IBJD($P(IBAR,U,10),1)_U_$$DT^IBJD(IBPD,1)_U_IBBA_U_IBPA_U_IBINT_U_IBADM_U
 . I IBSH D COM
 . S IBD=0 I DAT!IBPD S IBD=$$FMDIFF^XLFDT(DT,$S('DAT:IBPD,1:$G(DAT)))
 . S IBEXCEL1=IBEXCEL1_U_IBD W !,IBEXCEL1 K IBD,IBEXCEL1
 ;
 I '($D(^TMP("IBJDF4",$J,IBPAT))#10) D
 . S ^TMP("IBJDF4",$J,IBPAT)=$P(IBPT,U,3,5)_U_$$MTRX(DFN)_U_$P(IBPT,U,6)_"^"_$P(IBVA,"^",2)_"^"_$$ACCBAL($P(IBPT,U,7))
 S ^TMP("IBJDF4",$J,IBPAT,IB0,IBCAT,IBBN)=IBPD_U_IBBA_U_IBPA_U_IBINT_U_IBADM_U_IBIDX
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
 S X=X_"Bill #^Act/Susp^Refer. to^Dt Bill prep.^Last Pymt Dt^"
 S X=X_"Curr.Bal.^Princ.Bal.^Int.^Admin.^Last Comm.Dt^Days Lst Comm."
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
 ;    Input: X=Bill pointer to file #399/#430
 ;   Output: 0-Not on repay plan, 1-On repay plan, 2-On defaulted plan
 N Z
 S Z=$$REPDATA^RCBECHGA(X,1) I Z="" Q 0
 I '$P(Z,"^",7) Q ("1^"_$P(Z,"^"))
 Q ("2^"_$P(Z,"^"))
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
 ;Input: RFT: "R": RC, "D": DMC, "T": TOP, "P": REPAYMENT PLAN
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
