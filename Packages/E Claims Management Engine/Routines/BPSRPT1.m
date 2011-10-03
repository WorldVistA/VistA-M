BPSRPT1 ;BHAM ISC/BEE - ECME REPORTS ;14-FEB-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ; ECME Report Compile Routine - Looping/Filtering Routine
 ;
 ;  Input Variables:
 ;                 BPRTYPE - Type of Report (1-7)
 ;               BPGLTMP - Temporary storage global
 ;  BPPHARM/BPPHARM(ptr) - Set to 0 for all pharmacies, if set to 1 array
 ;                         of internal pointers of selected pharmacies
 ;              BPSUMDET - (1) Summary or (0) Detail format
 ;              BPINSINF - Set to 0 for all insurances or list of file 36 IENs
 ;                 BPMWC - 1-ALL,2-Mail,3-Window,4-CMOP Prescriptions
 ;               BPRTBCK - 1-ALL,2-RealTime,3-Backbill Claim Submission
 ;               BPRLNRL - 1-ALL,2-RELEASED,3-NOT RELEASED
 ;                BPDRUG - DRUG to report on (ptr to #50)
 ;               BPDRGCL - DRUG CLASS to report on (0 for ALL)
 ;               BPBEGDT - Beginning Date
 ;               BPENDDT - Ending Date
 ;               BPCCRSN - Set to 0 for all closed claim reasons or ptr to #356.8
 ;              BPAUTREV - 0-ALL,1-Auto Reversed
 ;               BPACREJ - 0-ALL,1-REJECTED,2-ACCEPTED
 ;              
COLLECT(BPGLTMP) N BP02,BP57,BP59,BPENDDT1,BPLDT02,BPLDT57,X,Y,OK,BPIX
 ;
 ;Check Variables
 S OK=1
 S:'$G(BPBEGDT) BPBEGDT=0
 S:'$G(BPENDDT) BPENDDT=9999999
 S BPENDDT=BPENDDT+0.9
 I $G(BPRTYPE)=""!($G(BPGLTMP)="")!($G(BPPHARM)="")!($G(BPSUMDET)="")!($G(BPINSINF)="")!($G(BPMWC)="")!($G(BPRTBCK)="") S OK=-1 G EXIT
 ;
 ;Loop through BPS CLAIMS
 ;
 ;First look for fill/refill cross reference
 ;Loop through Date of Service Index in BPS CLAIMS file and find link to 
 ;claim in BPS TRANSACTION.  Process earliest Date of Service entry found in
 ;BPS TRANSACTION
 ;
 ;Choose Index to Loop through (different for Closed Claims)
 S BPIX="AF" S:BPRTYPE=7 BPIX="AG"
 ;
 S BPLDT02=$S(BPIX="AF":$$FM2YMD(BPBEGDT-0.00001),1:BPBEGDT) S:BPLDT02="" BPLDT02=0
 S BPENDDT1=$S(BPIX="AF":$$FM2YMD(BPENDDT),1:BPENDDT_".9999999999") S:BPENDDT1="" BPENDDT1=99999999
 F  S BPLDT02=+$O(^BPSC(BPIX,BPLDT02)) Q:BPLDT02=0!(BPLDT02>BPENDDT1)  D
 . S BP02=0 F  S BP02=$O(^BPSC(BPIX,BPLDT02,BP02)) Q:+BP02=0  D
 . . S BP59=+$O(^BPST("AE",BP02,0))
 . . Q:BP59=0
 . . I $D(@BPGLTMP@("FILE59",BP59)) Q
 . . S @BPGLTMP@("FILE59",BP59)=BPLDT02_"^02"
 . . D PROCESS(BP59)
 ;
 ;#9002313.59 has only one entry per claim with, which has a date 
 ;  of the latest update for the claim
 ;#9002313.57 has more than one entries per claim and keep all 
 ;  changes made the claim
 ;so we have to go thru #9002313.57 to find the earliest date 
 ;related to the claim to check it against BPBEGDT
 S BPLDT57=BPBEGDT-0.00001
 F  S BPLDT57=+$O(^BPSTL("AH",BPLDT57)) Q:BPLDT57=0!(BPLDT57>BPENDDT)  D
 . S BP57=0 F  S BP57=$O(^BPSTL("AH",BPLDT57,BP57)) Q:+BP57=0  D
 . . S BP59=+$G(^BPSTL(BP57,0))
 . . I $D(@BPGLTMP@("FILE59",BP59)) Q
 . . S @BPGLTMP@("FILE59",BP59)=BPLDT57_"^57"
 . . D PROCESS(BP59)
 ;
 ;Remove Portion of Scratch Global
EXIT K @BPGLTMP@("FILE59")
 Q OK
 ;
 ;Convert FB date to YYYYMMDD
FM2YMD(BPFMDT) N Y,Y1
 S Y=$E(BPFMDT,2,3),Y1=$E(BPFMDT,1,1) S Y=$S(Y1=3:"20"_Y,Y1=2:"19"_Y,1:"")
 Q:Y Y_$E(BPFMDT,4,7)
 Q ""
 ;
 ;Process each Entry
 ;
PROCESS(BP59) ;
 N BPBCK,BPDFN,BPREF,BPPAYBL,BPPLAN,BPREJ,BPRLSDT,BPRX,BPRXDRG,BPSTATUS,BPSEQ
 ;
 S BPSEQ=$$COB59^BPSUTIL2(BP59)
 ;
 ;Get ABSBRXI - ptr to #52
 S BPRX=+$P($G(^BPST(BP59,1)),U,11)
 ;
 ;Get ABSBRXR - Prescription Number IEN
 S BPREF=+$P($G(^BPST(BP59,1)),U)
 ;
 ;Get PATIENT - ptr to #2
 S BPDFN=+$P($G(^BPST(BP59,0)),U,6)
 ;
 ;Check for correct BPS Pharmacy (DIVISION)
 I $G(BPPHARM)=1,$$CHKPHRM(BP59)=0 G XPROC
 ;
 ;Check for Display 1-ALL,2-RELEASED,3-NOT RELEASED
 S BPRLSDT=$$RELEASED(BPRX,BPREF)
 I BPRLNRL'=1 I ((BPRLNRL=2)&(BPRLSDT=0))!((BPRLNRL=3)&(BPRLSDT)) G XPROC
 ;
 ;Get Status
 S BPSTATUS=$$STATUS^BPSRPT6(BPRX,BPREF,BPSEQ)
 ;
 ;if REVERSAL
 I BPRTYPE=4,BPSTATUS'["REVERSAL" G XPROC  ; exclude non-reversed
 I BPRTYPE=4,$$CLOSED02^BPSSCR03($P(^BPST(BP59,0),U,4))=1 G XPROC  ; exclude closed claims for Reversal Report
 ;
 ;if PAYABLE
 S BPPAYBL=BPSTATUS["PAYABLE"
 I BPRTYPE=1,'BPPAYBL G XPROC  ; exclude non-payable
 I BPRTYPE=1,BPSTATUS["REVERSAL" G XPROC  ; reversed
 ;
 ;if REJECTED
 S BPREJ=BPSTATUS["REJECTED"
 I BPRTYPE=2,BPSTATUS["REVERSAL" G XPROC ; exclude rejected reversals
 I BPRTYPE=2,'BPREJ G XPROC  ; exclude non-rejected
 ;
 ;if SUBMITTED NOT RELEASED exclude released ones
 I BPRTYPE=3,BPRLSDT'=0 G XPROC
 I BPRTYPE=3,'BPPAYBL G XPROC  ; exclude non-payable
 ;
 ;Auto Reverse Check
 I BPRTYPE=4,BPAUTREV,'$$AUTOREV(BP59) G XPROC
 ;
 ;if CLOSED
 I BPRTYPE=7,'$$CLSCLM(BP59) G XPROC  ;exclude open claims
 ;I BPRTYPE=7,BPSTATUS'["REJECTED" G XPROC  ;exclude non-rejected closed claims
 ;
 ;if Recent Transactions, exclude closed claims
 I BPRTYPE=5,$$CLSCLM(BP59) G XPROC
 ;
 ;If Totals by Date, include only rejects and payables
 I BPRTYPE=6,BPSTATUS'["REJECTED",BPSTATUS'["PAYABLE" G XPROC  ; Reversed
 ;
 ;Realtime/Backbill Check
 S BPBCK=$$RTBCK(BP59)
 I BPRTBCK'=1 I ((BPRTBCK=2)&(BPBCK=0))!((BPRTBCK=3)&(BPBCK)) G XPROC
 ;
 ;Check for MAIL/WINDOW/CMOP/ALL
 I BPMWC'="A",$$MWC^BPSRPT6(BPRX,BPREF)'=BPMWC G XPROC
 ;
 ;Check for selected insurance
 S BPPLAN=$$INSNAM^BPSRPT6(BP59)
 I BPINSINF'=0,'$$CHKINS^BPSSCRCU($P(BPPLAN,U,1),BPINSINF) G XPROC
 S BPPLAN=$P(BPPLAN,U,2)
 ;
 ;Check for selected drug
 S BPRXDRG=$$GETDRUG^BPSRPT6(BPRX)
 I BPRXDRG=0 G XPROC
 I BPDRUG,BPDRUG'=BPRXDRG G XPROC
 ;
 ;Check for selected drug classes
 I BPDRGCL'=0,BPDRGCL'=$$DRGCLNAM^BPSRPT6($$GETDRGCL^BPSRPT6(BPRXDRG),99) G XPROC
 ;
 ;Check for selected Close Reason
 I BPCCRSN,BPCCRSN'=$P($$CLRSN^BPSRPT7(BP59),U) G XPROC
 ;
 ;Check for Accepted/Rejected
 I BPACREJ=1,BPSTATUS'["REJECTED" G XPROC
 I BPACREJ=2,BPSTATUS'["ACCEPTED" G XPROC
 ;
 ;Check for Specific Reject Code
 I BPREJCD'=0,'$$CKREJ(BP59,BPREJCD) G XPROC
 ;
 ;Check for Eligibility Code
 I BPELIG'=0,BPELIG'=$$ELIGCODE^BPSSCR05(BP59) G XPROC
 ;
 ;Check Open/Closed claim
 I BPOPCL'=0,((BPOPCL=2)&($$CLOSED02^BPSSCR03($P(^BPST(BP59,0),U,4))=1))!((BPOPCL=1)&($$CLOSED02^BPSSCR03($P(^BPST(BP59,0),U,4))'=1)) G XPROC
 ;
 ;Save Entry for Report
 D SETTMP^BPSRPT2(BPGLTMP,BPDFN,BPRX,BPREF,BP59,BPBEGDT,BPENDDT,.BPPHARM,BPSUMDET,BPPLAN,BPRLSDT,BPPAYBL,BPREJ,BPRXDRG,$P(BPSTATUS,U))
 ;
XPROC Q
 ;
 ;Check if selected BPS PHARMACY
 ;
 ; Defined Variable: BPPHARM(ptr) - List of BPS Pharmacies to Report on
 ; Input Variable: BP59 - Lookup to BPS TRANSACTION (#59)
 ; 
 ; Returned Value -> 0 = Entry not in list of selected pharmacies
 ;                   1 = Entry is in list of selected pharmacies
CHKPHRM(BP59) N PHARM
 S PHARM=+$P($G(^BPST(BP59,1)),"^",7)
 S PHARM=$S($D(BPPHARM(PHARM)):1,1:0)
 Q PHARM
 ;
 ;Determine whether claim is Released or Not Released
 ;
 ; Input Variables: BPRX - ptr to PRESCRIPTION (#52)
 ;                 BPREF - refill # (0-No Refills,1-1st Refill, 2-2nd, ...) 
 ;
 ; Return Value ->             0 = Not Released
 ;                 released date = Released
 ;                 
RELEASED(BPRX,BPREF) N RDT
 ;
 I BPREF=0 S RDT=$$RXRELDT^BPSRPT6(BPRX)\1
 I BPREF'=0 S RDT=$$REFRELDT^BPSRPT6(BPRX,BPREF)\1
 Q RDT
 ;
 ;Determine if claim was Auto Reversed
 ;
 ; Input Variable: BP59 - Lookup to BPS TRANSACTION (#59)
 ; Return Value -> 1 = Auto Reversed
 ;                 0 = Not Auto Reversed
 ;
AUTOREV(BP59) N AR,BP02
 S BP02=+$P($G(^BPST(BP59,0)),U,4)
 S AR=+$P($G(^BPSC(BP02,0)),U,7)
 Q AR
 ;
 ;Determine if claim was closed
 ;
 ; Input Variable: BP59 - Lookup to BPS TRANSACTION (#59)
 ; Return Value -> 1 = Closed
 ;                 0 = Not Closed
 ;                 
CLSCLM(BP59) N BP02,CL
 S BP02=+$P($G(^BPST(BP59,0)),U,4)
 S CL=+$G(^BPSC(BP02,900))
 Q CL
 ;
 ;Determine whether claim is Realtime or Backbilled
 ;
 ; Input Variable: BP59 - Lookup to BPS TRANSACTION (#59)
 ; Return Value -> 1 = Backbilled
 ;                 0 = Realtime
RTBCK(BP59) N BB
 S BB=$P($G(^BPST(BP59,12)),U)
 S BB=$S(BB="BB":0,1:1)
 Q BB
 ;
 ;Screen Pause 1
 ;
 ; Return variable - BPQ = 0 Continue
 ;                          2 Quit
PAUSE N X
 U IO(0) W !!,"Press RETURN to continue, '^' to exit:"
 R X:$G(DTIME) S:'$T X="^" S:X["^" BPQ=2
 U IO
 Q
 ;
 ;Screen Pause 2
 ;
 ; Return variable - BPQ = 0 Continue
 ;                         2 Quit
PAUSE2 N X
 U IO(0) W !!,"Press RETURN to continue:"
 R X:$G(DTIME) S:'$T X="^" S:X["^" BPQ=2
 U IO
 Q
 ;
 ;Get ECME#
 ;
 ; Input Variable: BP59 - Lookup to BPS TRANSACTION (#59)
 ; Returned value -> Last 7 digits of ECME#
 ; 
ECMENUM(BP59) N BPY1,BPY2
 S BPY1=(BP59\1),BPY2=$E(BPY1,$L(BPY1)-6,99) ;last 7 digits
 Q BPY2
 ;
 ;Convert FM date or date.time to displayable (mm/dd/yy HH:MM) format
 ;
DATTIM(X) N DATE,BPT,BPM,BPH,BPAP
 S DATE=$S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3),1:"")
 S BPT=$P(X,".",2) S:$L(BPT)<4 BPT=BPT_$E("0000",1,4-$L(BPT))
 S BPH=$E(BPT,1,2),BPM=$E(BPT,3,4)
 S BPAP="AM" I BPH>12 S BPH=BPH-12,BPAP="PM" S:$L(BPH)<2 BPH="0"_BPH
 I BPT S:'BPH BPH=12 S DATE=DATE_" "_BPH_":"_BPM_BPAP
 Q $G(DATE)
 ;
 ;Display RT-Realtime,BB-Backbill, or " "
 ;
RTBCKNAM(BPINDEX) Q $S(BPINDEX=1:"RT",BPINDEX=0:"BB",1:" ")
 ;
 ;See for Specific Reject Code
 ;
CKREJ(BP59,BPREJCD) N FREJ,I,REJ,X
 S FREJ=0
 S X=$$REJTEXT^BPSRPT2(BP59,.REJ)
 S X="" F  S X=$O(REJ(X)) Q:X=""  D  Q:FREJ=1
 .S REJ=$P($G(REJ(X)),":") Q:REJ=""
 .S I="" F  S I=$O(^BPSF(9002313.93,"B",REJ,I)) Q:I=""  I I=BPREJCD S FREJ=1
 Q FREJ
