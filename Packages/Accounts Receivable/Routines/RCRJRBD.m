RCRJRBD ;WISC/RFJ,TJK-bad debt extractor and report ;10/18/10 9:00am
 ;;4.5;Accounts Receivable;**101,139,170,193,203,215,220,138,239,273,282,310,315,340,346,338,351,360**;Mar 20, 1995;Build 10
 ;;Per VA Directive 6402, this routine should not be modified.
 ; IA 4385 for calls to $$MRATYPE^IBCEMU2 and $$MRADTACT^IBCEMU2
 Q
 ;
 ;PRCA*4.5*346 Modify SGL compile code 133.N3 to 133N.3 to
 ;             ensure line item 528713 - 133N dollars are accrued
 ;
 ;
START(DATEEND) ;  run bad debt report
 ;  the DATEEND is the last day of the month being run
 ;  from the routine RCRJRCOL which is the data extractor.  The
 ;  current receivable dollars is stored in ^TMP($J,"RCRJRBD",SGL)
 ;  where SGL is the standard general ledger 1319, 1338, or 1339.
 ;
 N ACTDATE,ACTUALCA,ACTUALWO,BEGDATE,BILLDA,CATEGORY
 N COLLECT,CONTRACT,DR,ENDDATE,FUND,PAY,PAYMENT,PRIN,PRINCPAL
 N RCRJFMM,RCRJDATE,SGL,TRANDA,TRANDATE,TRANTYPE,VALUE,WRITEOFF
 N RCPRIN,RCTOMCCF,RCVALUE,RSC,MRATYPE,ARACTDT
 ;
 ;  lock the bad debt file for storing data, lock cannot fail
 ;  this lock can be used to monitor if the report is running
 F  L +^RC(348.1):$S($G(DILOCKTM)>5:DILOCKTM,1:5) Q:$T
 ;
 ;  calculate the base percentages from past data
 ;  example:  DATEEND=2980331  => BEGDATE=2970300
 ;                             => ENDDATE=2980229
 ;   add one day to ending date to go to next month
 S BEGDATE=($E(DATEEND,1,3)-1)_$E(DATEEND,4,5)_"00"
 S ENDDATE=($$FMADD^XLFDT($E(DATEEND,1,5)_"00",-1))+1
 ;  loop bills activated between these dates
 S ACTDATE=BEGDATE
 F  S ACTDATE=$O(^PRCA(430,"ACTDT",ACTDATE)) Q:'ACTDATE!(ACTDATE>ENDDATE)  D
 . S BILLDA=0 F  S BILLDA=$O(^PRCA(430,"ACTDT",ACTDATE,BILLDA)) Q:'BILLDA  D
 . . S CATEGORY=+$P($G(^PRCA(430,BILLDA,0)),"^",2)
 . . ;  do not look at prepayments
 . . I 'CATEGORY!(CATEGORY=26) Q
 . . ;
 . . ;  only look at bills with a 0 principal balance
 . . I $P($G(^PRCA(430,BILLDA,7)),"^") Q
 . . ;
 . . ;  only report fund 528701,03,04,11 and 4032/528709 bills
 . . ;PRCA*4.5*338 - grab existing FUND for bill.  Only recalculate if FUND = NULL
 . . S FUND=$$GET1^DIQ(430,BILLDA_",",203)
 . . I FUND="" S FUND=$$GETFUNDB^RCXFMSUF(BILLDA,1)
 . . ;end PRCA*4.5*338
 . . I '$$PTACCT^PRCAACC(FUND),$E(FUND,1,4)'=4032 Q
 . . ;
 . . ;  determine MRA type of bill, given bill# and bill active date
 . . ;  DBIA #4385 activated on 31-Mar-2004
 . . S MRATYPE=$$MRATYPE^IBCEMU2(BILLDA,ACTDATE)
 . . ;
 . . ;  derive standard general ledger (SGL) from cat/fund/MRA type
 . . S SGL=$$BDRSGL(CATEGORY,FUND,MRATYPE)
 . . ;
 . . ;  determine the original amount of the bill (add increase
 . . ;  adjustments below)
 . . S PRIN=$P($G(^PRCA(430,BILLDA,0)),"^",3)
 . . S PAY=0
 . . ;
 . . ;  get the $ transations for bills
 . . S TRANDA=0
 . . F  S TRANDA=$O(^PRCA(433,"C",BILLDA,TRANDA)) Q:'TRANDA  D
 . . . S TRANTYPE=$P($G(^PRCA(433,TRANDA,1)),"^",2)
 . . . I "^1^73^2^34^43^"'[("^"_TRANTYPE_"^") Q           ; *340 added 73
 . . . S VALUE=$$TRANBAL^RCRJRCOT(TRANDA) I VALUE="" Q
 . . . ;  increase adjustments or re-establish
 . . . I TRANTYPE=1!(TRANTYPE=73)!(TRANTYPE=43) S PRIN=PRIN+$P(VALUE,"^") Q    ; *340 added 73
 . . . ;  payments
 . . . I TRANTYPE=2!(TRANTYPE=34) S PAY=PAY+$P(VALUE,"^") Q
 . . ;
 . . ;  payment cannot be greater than principle
 . . I PAY>PRIN S PAY=PRIN
 . . ;
 . . ;  store the data
 . . S PRINCPAL(SGL)=$G(PRINCPAL(SGL))+PRIN
 . . S PAYMENT(SGL)=$G(PAYMENT(SGL))+PAY
 . . ;
 ;
 ;  calculate the writeoffs from 2/0/98
 ;  2/0/98 is when fms cleared out actual writeoffs and contract adj
 K ^XTMP("PRCABDET")
 S ^XTMP("PRCABDET",0)=$$FMADD^XLFDT(DT,10)_"^"_DT_"^BAD DEBT REPORT AUDIT"
 F TRANTYPE=8,9,10,11,35 D
 . S TRANDATE=2980200
 . ;  do not pick up transactions after the end date
 . F  S TRANDATE=$O(^PRCA(433,"AT",TRANTYPE,TRANDATE)) Q:'TRANDATE!($P(TRANDATE,".")>DATEEND)  D
 . . S TRANDA=0 F  S TRANDA=$O(^PRCA(433,"AT",TRANTYPE,TRANDATE,TRANDA)) Q:'TRANDA  D
 . . . ;  do not look at decrease adj which are not contract adj
 . . . I TRANTYPE=35,'$P($G(^PRCA(433,TRANDA,8)),"^",8) Q
 . . . ;
 . . . S BILLDA=$P($G(^PRCA(433,TRANDA,0)),"^",2)
 . . . I 'BILLDA Q
 . . . S CATEGORY=+$P($G(^PRCA(430,BILLDA,0)),"^",2)
 . . . ;  do not look at prepayments
 . . . I 'CATEGORY!(CATEGORY=26) Q
 . . . ;
 . . . ;  only report fund 528701,03,04,11 and 4032/528709 (ltc) bills
 . . . ;PRCA*4.5*338 - grab existing FUND for bill.  Only recalculate if FUND = NULL
 . . . S FUND=$$GET1^DIQ(430,BILLDA_",",203)
 . . . I FUND="" S FUND=$$GETFUNDB^RCXFMSUF(BILLDA,1)
 . . . ;end PRCA*4.5*338
 . . . I '$$PTACCT^PRCAACC(FUND),$E(FUND,1,4)'=4032 Q
 . . . ;
 . . . ;  get bill active date
 . . . S ARACTDT=+$P($P($G(^PRCA(430,BILLDA,6)),"^",21),".")
 . . . ;  determine MRA type of bill, given bill# and bill active date
 . . . ;  DBIA #4385 activated on 31-Mar-2004
 . . . S MRATYPE=$$MRATYPE^IBCEMU2(BILLDA,ARACTDT)
 . . . ;
 . . . ; derive standard general ledger (SGL) from cat/fund/MRA type
 . . . S SGL=$$BDRSGL(CATEGORY,FUND,MRATYPE)
 . . . ;
 . . . ;  get the principal transaction value
 . . . S RCVALUE=+$P($$TRANBAL^RCRJRCOT(TRANDA),"^")
 . . . ;  temp variable for value (used below)
 . . . S RCPRIN=RCVALUE
 . . . ;
 . . . ;  add actual writeoff amount for fiscal year
 . . . I TRANTYPE'=35 S ACTUALWO(SGL)=$G(ACTUALWO(SGL))+RCVALUE
 . . . ;  add actual contract adjustments for fiscal year
 . . . I TRANTYPE=35 S ACTUALCA(SGL)=$G(ACTUALCA(SGL))+RCVALUE
 . . . ;PRCA*4.5*338 - retrieve RSC from Bill.  If no RSC in BILL, calculate it.
 . . . S RSC=$$GET1^DIQ(430,BILLDA_",",255.1)       ;Check for accrued RSC
 . . . S:RSC="" RSC=$$GET1^DIQ(430,BILLDA_",",255)  ;if no accrued RSC, check for non-accrued.
 . . . S:RSC="" RSC=$$CALCRSC^RCXFMSUR(BILLDA)      ;if neither present, calculate
 . . . ;end PRCA*4.5*338
 . . . S ^XTMP("PRCABDET",BILLDA,CATEGORY,FUND,RSC,SGL,TRANDA,TRANDATE,TRANTYPE,RCPRIN,RCVALUE,0,0)=""
 ;
 ;  remove all the entries from the bad debt file
 D DELETALL
 ;
 ;  calculate percentages and store them
 ; PRCA*4.5*338 - corrected 133.N3 to 133N.3, also added 1319.7, 1319.8, 1319.9
 F SGL=1319,1319.2,1319.3,1319.4,1319.5,1319.6,1319.7,1319.8,1319.9,1338,1338.2,1338.3,1339,1339.1,"133N","133N.2","133N.3" D    ;PRCA*4.5*346
 . ;  collection %
 . S COLLECT=0 I $G(PRINCPAL(SGL)) S COLLECT=$J($G(PAYMENT(SGL))/PRINCPAL(SGL)*100,0,2)
 . ;  patch PRCA*4.5*138: for the first year from when MRA is activated at a site, there is no collection
 . ;  history for post-MRA non-Medicare bills(SGL 133N). So, to calculate the percentage for SGL 133N, the
 . ;  payment and the principal for SGL 1339 are used in the first year.
 . ;  override the collection value for SGL=133N for the first year from MRA activation.
 . ;;  Re-evaluate the calc. of the percentage for 133N as well as 1339.
 . ;;I SGL="133N",$G(PRINCIPAL(1339)) D  ;
 . ;;. N X1,X2,X,%Y
 . ;;. ;  X2=MRA Activation Date, X1=Today, X=diff in days, %Y=0 invalid dates
 . ;;. ;  DBIA #4385 activated on 31-Mar-2004
 . ;;. S X2=$$MRADTACT^IBCEMU2,X1=$$DT^XLFDT D ^%DTC
 . ;;. I %Y,X'>364.25 S COLLECT=$J($G(PAYMENT(1339))/PRINCPAL(1339)*100,0,2)
 . S DR=".02////"_+COLLECT_";"
 . ;
 . ;  current month receivable (this is built in the routine
 . ;  RCRJRCO1 and is stored in ^TMP($J,"RCRJRBD",SGL))
 . S DR=DR_".07////"_+$G(^TMP($J,"RCRJRBD",SGL))_";"
 . ;
 . ;  calculate allowance estimate for 1319 and 1338
 . ;  .08 allowance estimate = (writeoff % * current receivables)
 . ;  .09 actual writeoffs fytd
 . I SGL=1319!(SGL=1319.2)!(SGL=1319.3)!(SGL=1319.4)!(SGL=1319.5)!(SGL=1319.6)!(SGL=1319.7)!(SGL=1319.8)!(SGL=1319.9)!(SGL=1338)!(SGL=1338.2)!(SGL=1338.3) D
 . . S WRITEOFF=100-COLLECT
 . . S DR=DR_".03////"_WRITEOFF_";"
 . . S DR=DR_".08////"_$J((WRITEOFF/100)*$G(^TMP($J,"RCRJRBD",SGL)),0,2)_";"
 . . S DR=DR_".09////"_+$G(ACTUALWO(SGL))_";"
 . ;  calculate allowance estimate for 1339
 . ;  .08 allowance estimate = (contract % * current receivables)
 . ;  .09 actual contract adjustments fytd
 . I SGL=1339!(SGL=1339.1)!(SGL="133N")!(SGL="133N.2")!(SGL="133N.3") D
 . . S CONTRACT=100-COLLECT
 . . S DR=DR_".04////"_CONTRACT_";"
 . . S DR=DR_".08////"_$J((CONTRACT/100)*$G(^TMP($J,"RCRJRBD",SGL)),0,2)_";"
 . . S DR=DR_".09////"_+$G(ACTUALCA(SGL))_";"
 . ;
 . ;  set changed locally flag to no
 . S DR=DR_".1////0;"
 . D STORE(SGL,DR)
 ;
 L -^RC(348.1)
 ;
 ;   ;  put the report in a mail message (rcrjfmm=1)
 ;   S RCRJFMM=1
 ;   S RCRJDATE=DATEEND
 ;   D DQ^RCRJRBDR
 ;
 ;  transmit the allowances to FMS, and then generate the report.
 D BADDEBT^RCXFMSSV(DATEEND)
 Q
 ;
 ;
STORE(SGL,DR) ;  store data for Standard Ledger Account
 N D0,DA,DD,DI,DIC,DIE,DINUM,DO,DQ,X,Y
 S DIC="^RC(348.1,",DIC(0)="L",X=SGL,DIC("DR")=DR
 D FILE^DICN
 Q
 ;
 ;
DELETALL ;  delete all the entries from the bad debt file
 N %,DA,DIC,DIK,X,Y
 S DIK="^RC(348.1,"
 S DA=0 F  S DA=$O(^RC(348.1,DA)) Q:'DA  D ^DIK
 Q
 ;
 ;
WD3() ;  return the third work day of the month
 N J,P,V,X
 S J=0 F P=$E(DT,1,5)_"01":1 S V=$$DOW^XLFDT(P,1) I V,V<6,'$D(^HOLIDAY("B",P)) S J=J+1 Q:J=3
 S X=+$E(P,6,7)
 Q X
 ;
 ;
PREVMONT(FORDATE) ; return the previous month's date
 N PREVDATE
 S PREVDATE=$E(FORDATE,1,5)-1
 I $E(PREVDATE,4,5)="00" S PREVDATE=($E(PREVDATE,1,3)-1)_12
 Q PREVDATE_"00"
 ;
 ; derive standard general ledger (SGL) from category and fund
SGL(CATEGORY,FUND) ;
 I $G(FUND)=528709 Q 1319.2 ;new long term care fund
 I $E($G(FUND),1,4)=4032 Q 1319.2 ; breakout long term care as a subset
 I $G(FUND)=528711&(CAT=6)!(CAT=7) Q 1319.5  ; breakout pharmacy
 I $G(FUND)=528711&(CAT=9) Q "133N.2"  ; pharmacy reimburs health ins
 I $G(FUND)=528711&(CAT=10) Q 1338.2  ; pharmacy tort feasor
 I CATEGORY=8 Q 1339   ; crime or per. vio.
 I CATEGORY=9 Q 1339   ; reimbursable health insurance
 I CATEGORY=46 Q 1339   ; EMER/HUMAN REIMB INS  ;315
 I CATEGORY=10 Q 1338  ; tort feasor
 I CATEGORY=21 Q 1339  ; medicare
 I CATEGORY=45 Q 1339.1  ; Fee Basis
 Q 1319
 ;
 ;
BDRSGL(CAT,FUND,MRATYPE) ; Calculate SGLs for the BDR process
 ;PRCA*4.5*310/DRF Added fund 528713, Non-VA Reimbursable Insurance
 ;
 ; This API will be used by both the ARDC (routine RCRJRCOC)
 ; and the BDR estimate calculator to associate receivables
 ; with the correct standard general ledger account (SGL).
 ; The following table will be implemented:
 ;
 ; Receivable Type (Category)        Fund      SGL
 ;==================================================
 ; Medical Care Co-payments                 528703    1319
 ;  (plus Inelig, Emerg./Hum. rec.)
 ; Long Term Care Co-payments               528709    1319.2
 ; Medication Co-payments                   528701    1319.3
 ; Crimes of Personal Violence (8),         528704    1319.4
 ;  Medicare (21), No-Fault Auto
 ;  (7), Workman's Comp (6)
 ; Tort Feasor (10)                         528704    1338
 ; RHI (9), pre-MRA                         528704    1339
 ; RHI (9), post-MRA, MRA rec.              528704    133H
 ; RHI (9), post-MRA, non-MRA rec.          528704    133N
 ; Non-VA Tort Feasor                       528713    1338.3
 ; Non-VA RHI (45), pre-MRA                 528713    1339.1
 ; Non-VA RHI (45), post-MRA, MRA rec.      528713    133H.2
 ; Non-VA RHI (45), post-MRA, non-MRA rec.  528713    133N.3
 ; Non-VA No-Fault Auto, Workman's Comp (6) 528713    1319.6
 ; Inpat./Outpat./Urgent Care Community     528714    1319.7
 ;  Care copayments
 ; RX Community Care copayments             528714    1319.8
 ; LTC Community Care copayments            528714    1319.9 
 ; Pharmacy No Fault Auto(7),               528711    1319.5
 ; Pharmacy Workman's Comp(6)
 ; Pharmacy RHI, non MRA (9)                528711    133N.2
 ; Pharmacy Tort Feasor (10)                528711    1338.2
 ;
 ;  Input:  CAT  --  Pointer to the receivable category in file 430.2
 ;         FUND  --  Receivable fund calculated by routine RCXFMSUF
 ;      MRATYPE  --  Indicator of an MRA (2) or non-MRA (3) receivable
 ;
 ;
 I $G(FUND)=528709 Q 1319.2
 I $E($G(FUND),1,4)=4032 Q 1319.2
 I $G(FUND)=528701 Q 1319.3
 I $G(FUND)=528711&((CAT=6)!(CAT=7)) Q 1319.5
 I $G(FUND)=528711&(CAT=9) Q "133N.2"
 I $G(FUND)=528711&(CAT=10) Q 1338.2
 ;PRCA*4.5*338 - Add new Community Care Categories
 ; THIRD PARTY =528713 new code begins
 I $G(FUND)=528713&(CAT=10!(CAT=53)!(CAT=56)!(CAT=59)) Q 1338.3   ;patch 338 Add Comm Care Tort Feasor
 I $G(FUND)=528713&(CAT=8!(CAT=21)!(CAT=6)!(CAT=7)!(CAT=52)!(CAT=54)!(CAT=55)!(CAT=57)!(CAT=59)!(CAT=60)) Q 1319.6  ;patch 338 Added Comm Care No Fault and Workers Comp
 I ((CAT>47)&(CAT<52)) Q $S(MRATYPE=2:"133H.2",MRATYPE=3:"133N.3",1:1339.1)  ;patch 338 Comm Care Reimb ins types.
 ; FIRST PARTY = 528714  - Community Care Copays
 I $G(FUND)=528714&(CAT=61!(CAT=81)!(CAT=63)!(CAT=82)!(CAT=65)!(CAT=83)!(CAT=67)!(CAT=84)!(CAT=85)) Q 1319.7    ;INP/OPT copays
 I $G(FUND)=528714&(CAT=62!(CAT=64)!(CAT=66)!(CAT=68)) Q 1319.8    ;rx copays
 I $G(FUND)=528714&(CAT>68)&(CAT<75) Q 1319.9    ;LTC copays
 ;end PRCA*4.5*338
 I CAT=8!(CAT=21)!(CAT=7)!(CAT=6) Q 1319.4
 I CAT=10 Q 1338
 I CAT=9 Q $S(MRATYPE=2:"133H",MRATYPE=3:"133N",1:1339)
 I CAT=46 Q $S(MRATYPE=2:"133H",MRATYPE=3:"133N",1:1339)  ;315 
 I CAT=45 Q $S(MRATYPE=2:"133H.2",MRATYPE=3:"133N.3",1:1339.1)
 Q 1319
