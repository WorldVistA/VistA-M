BPSBCKJ ;BHAM ISC/AAT - BPS NIGHTLY BACKGROUND JOB ;02/27/2005
 ;;1.0;E CLAIMS MGMT ENGINE;**1,2,5,7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
EN ; The ECME NIGHTLY PROCESS
 ;
 ; The list of nightly actions
 D AUTOREV     ; Auto-Reversals (normal and inpatient)
 D MAIN^BPSOSK ; Purge BPS LOG
 D TASKMAN^BPSJAREG ; Do automatic registration.
 Q
 ;
AUTOREV ; The Auto-Reverse Procedure
 N BDT,BTRAN,BPHARM,BTRAN0,BTRAN1,BTRAN4,BDAYS,BRX,BFIL,BDATE,BNOW,BCLAIM,BRES,BREV,BTEST,REF,BCNT,BTX,X,X1,X2
 ;
 S BTEST=0 ; Debugging flag 1 - TEST, 0 - LIVE
 S BCNT=0 ; Count reversals
 ;
 S REF=$NA(^TMP($J,"BPSBCKJ")) K @REF
 ;
 S (X1,BNOW)=$$DT^XLFDT()
 ;
 ;Define number of days to look back - Auto Reverse days can be from 0-31
 ;To make sure every claim is caught, moving back 45 days
 S X2=-45 D C^%DTC S BDT=X
 ;
 ;Loop through 'LAST UPDATE' 'AH' index
 F  S BDT=$O(^BPST("AH",BDT)) Q:'BDT  S BTRAN=0 F  S BTRAN=$O(^BPST("AH",BDT,BTRAN)) Q:'BTRAN  D
 . W:BTEST !,"TRAN=",BTRAN," ",?20
 . S BTRAN0=$G(^BPST(BTRAN,0)),BTRAN1=$G(^(1)),BTRAN4=$G(^(4))
 . I BTRAN0=""!(BTRAN1="") W:BTEST "ZERO OR ONE NODE MISSING" Q
 . I '$$PAID^BPSOSQ4(BTRAN) W:BTEST "NOT PAID" Q  ; Not paid
 . S BPHARM=$P(BTRAN1,U,7) I 'BPHARM W:BTEST "NO BPS PHARM" Q  ; BPS PHARMACY
 . W:BTEST "BPHARM=",$P($G(^BPS(9002313.56,BPHARM,0)),U,1),"  "
 . ;
 . ;Handle 'Inpatient' Auto-Reversals
 . S BREV=$$REVINP(BNOW,BTRAN,BTRAN0,BTRAN1,BPHARM) Q:BREV
 . ;
 . ;Handle Regular Auto-Reversals
 . S BDAYS=+$P($G(^BPS(9002313.56,BPHARM,0)),U,9)
 . I 'BDAYS W:BTEST "AUTO-REV DISABLED" Q  ;disabled
 . I $P(BTRAN4,U,1) Q  ;Reversal claim exist
 . S BCLAIM=$P(BTRAN0,U,4) I 'BCLAIM W:BTEST "NO BCLAIM" Q
 . I $P($G(^BPSC(BCLAIM,0)),U,7) W:BTEST "AUTO-REVERSE FLAG" Q 
 . S BDATE=$P($G(^BPSC(BCLAIM,0)),U,5)
 . I 'BDATE S BDATE=$P($G(^BPSC(BCLAIM,0)),U,6)
 . S BDATE=$P(BDATE,".")
 . I 'BDATE="" W:BTEST "NO DATE" Q
 . W:BTEST "DATE=",BDATE,"  "
 . I $$FMDIFF^XLFDT(BNOW,BDATE,1)'>BDAYS W:BTEST "TOO EARLY" Q
 . S BRX=$P(BTRAN1,U,11) I 'BRX W:BTEST "NO RX" Q
 . S BFIL=$P(BTRAN1,U,1)
 . I $$RELDATE(BRX,BFIL) W:BTEST " RELEASED" Q  ;released
 . S BRES=$$REVERSE(BRX,BFIL,BCLAIM,1)
 . W:BTEST " *REV CLM=",BCLAIM," STAT=",BRES
 . I BRES=0!(BRES=4) D
 .. S (BCNT,@REF@(BRES))=$G(@REF@(BRES))+1
 .. S @REF@(BRES,BCNT)=BTRAN_U_BCLAIM_U_BRX_U_BFIL_U_BPHARM
 . ; Any notifications to IB?
 D BULL(REF) ; Send the bulletin
 K @REF
 Q
 ;
 ;Auto-Reverse Claims for Current Inpatients
 ;
 ;20050810;BEE;Phase III - CR11
 ;
REVINP(BNOW,BTRAN,BTRAN0,BTRAN1,BPHARM) ;
 N BRX,BFIL,BCLAIM,BDATE,BRES,DFN,VAIP
 ;
 ;Only process Window fills
 S BRX=+$P(BTRAN1,U,11) I BRX=0 Q 0
 S BFIL=+$P(BTRAN1,U)
 I $$MWC^BPSRPT6(BRX,BFIL)'="W" Q 0
 ;
 ;Check for Fill date - Must be equal to T-5
 S BCLAIM=$P(BTRAN0,U,4) I 'BCLAIM Q 0
 S BDATE=$$FILDATE(BRX,BFIL)
 S BDATE=$P(BDATE,".")
 I 'BDATE="" Q 0
 I $$FMDIFF^XLFDT(BNOW,BDATE,1)'=5 Q 0
 ;
 ;Check for current Inpatient
 S DFN=+$P(BTRAN0,U,6) I DFN=0 Q 0
 D IN5^VADPT
 I $G(VAIP(3))="" Q 0
 ;
 ;Auto-Reverse Claim
 S BRES=$$REVERSE(BRX,BFIL,BCLAIM,2)
 W:BTEST " *REV CLM=",BCLAIM," STAT=",BRES
 I BRES=0!(BRES=4) D
 . S (BCNT,@REF@(BRES))=$G(@REF@(BRES))+1
 . S @REF@(BRES,BCNT)=BTRAN_U_BCLAIM_U_BRX_U_BFIL_U_BPHARM
 Q 1
 ;
RELDATE(BRX,BFIL) ;Get the Released Date
 I BFIL Q $$RXSUBF1^BPSUTIL1(BRX,52,52.1,+BFIL,17,"I")
 Q $$RXAPI1^BPSUTIL1(BRX,31,"I")
 ;
FILDATE(BRX,BFIL) ;Get the Fill Date
 I BFIL Q $$RXSUBF1^BPSUTIL1(BRX,52,52.1,+BFIL,.01,"I")
 Q $$RXAPI1^BPSUTIL1(BRX,22,"I")
 ;
REVERSE(BRX,BFIL,BCLAIM,BTYPE) ;Auto-Reverse the claim
 ;PUBLIC BTEST
 N BDOS,BRES,BDAT,BMES,BRSN,BPSCOB,BP59
 I $G(BTEST) Q 0  ; Test mode
 ;
 ; Get Date of Service and set reversal reason
 S BDOS=$$DOSDATE^BPSSCRRS(BRX,BFIL)
 S BRSN=$S(BTYPE=2:"CURRENT INPATIENT",1:"PRESCRIPTION NOT RELEASED")
 ;
 S BP59=$$CLAIM59^BPSUTIL2(BCLAIM) ;get the BPS TRANSACTION IEN for the claim
 S BPSCOB=$$COB59^BPSUTIL2(BP59) ;get COB for the BPS TRANSACTION IEN
 ;
 ; Call ECME to process reversal
 S BRES=$$EN^BPSNCPDP(BRX,BFIL,BDOS,"AREV","",BRSN,"",,,,BPSCOB)
 ;
 ; If successful, log message to the Prescription Activity Log
 ;  and set the auto-reversal flag
 S BRES=+BRES,BMES="ECME: AUTO REVERSAL JOB-"_$S(BPSCOB=1:"p",BPSCOB=2:"s",1:"")_$$INSNAME^BPSSCRU6(BP59)
 I BRES=0 D
 . D ECMEACT^PSOBPSU1(BRX,BFIL,BMES,.5)
 . S BDAT(9002313.02,BCLAIM_",",.07)=BTYPE D FILE^DIE("","BDAT")
 Q BRES
 ;
 ;
BULL(REF) ;Bulletin to the OPECC
 ;PUBLIC BTEST,DUZ,DT
 N XMSUB,XMY,XMTEXT,XMDUZ,BLNUM
 ;
 I BCNT<1,'$G(BTEST),(+$G(@REF@(4)))=0 Q
 S BLNUM=0,BCNT=+$G(@REF@(0))
 S XMSUB="ECME AUTO-REVERSAL PROCESS"
 I $G(BTEST) D T("*** P L E A S E   D I S R E G A R D    T H I S    E M A I L ***"),T(),T("NOT ACTUALLY REVERSED - THIS IS A TEST"),T()
 D T("The ECME Nightly Process submitted auto-reversals for the following e-Pharmacy")
 D T("prescriptions.")
 D T()
 D T("TOTAL CLAIMS SUBMITTED FOR AUTO-REVERSALS: "_BCNT)
 D T()
 D T("Claims Submitted for Auto-Reversals on "_$$DAT(DT)_":") D ARLIST(0,REF)
 D T()
 S BCNT=+$G(@REF@(4))
 I BCNT'=0 D
 . D T()
 . D T("The ECME Nightly Process attempted to auto-reverse the following claims but")
 . D T("could not because the previous request was IN PROGRESS.  Please verify that")
 . D T("the previous request is not stranded.")
 . D T()
 . D T("Total number of claims that could not be auto-reversed: "_BCNT)
 . D T()
 . D T("Claims not auto-reversed on "_$$DAT(DT)_":")
 . D ARLIST(4,REF)
 . D T()
 ;
 S XMDUZ="BPS PACKAGE",XMTEXT="BTX("
 S XMY("G.BPS OPECC")=""
 I $G(DUZ)'<1 S XMY(DUZ)=""
 D ^XMD
 Q
 ;
T(BTXT) ; Add text to the message
 ;PUBLIC BLNUM,BTEST
 S BLNUM=BLNUM+1,BTX(BLNUM)=$G(BTXT," ")
 I $G(BTEST) W !,$G(BTXT)
 Q
 ;
ARLIST(BRES,REF) ;Auto-Rev List
 N I,TXT,BCLAIM,BTRAN,Y,BRX,BFIL,BFDATE,BPHARM,BRXN,BPHARMN,BPAT,BPSTAT
 D T()
 D T(" #    RX     FILL  STATUS FILL DATE PATIENT                      BPS PHARMACY")
 D T("------------------------------------------------------------------------------")
 S I=0 F  S I=$O(@REF@(BRES,I)) Q:'I   D
 . S Y=@REF@(BRES,I)
 . S BTRAN=$P(Y,U)
 . S BCLAIM=$P(Y,U,2)
 . S BRX=$P(Y,U,3),BRXN=$$RXAPI1^BPSUTIL1(BRX,.01,"I")
 . S BPAT=$P($G(^DPT(+$$RXAPI1^BPSUTIL1(BRX,2,"I"),0)),U)
 . S BFIL=$P(Y,U,4)
 . S BPHARM=$P(Y,U,5),BPHARMN=$P($G(^BPS(9002313.56,BPHARM,0)),U)
 . S BFDATE=$$FILDATE(BRX,BFIL)
 . S BPSTAT=$$MWC^BPSRPT6(BRX,BFIL)_"/"_$S($$RELDATE(BRX,BFIL)]"":"RL",1:"NR")
 . S TXT=$J(I,3)_" "_$$J(BRXN,10)_" "_$$J(BFIL,2)_"  "_$J(BPSTAT,4)_"  "_$$J($$DAT(BFDATE),11)_$$J(BPAT,25)_" "_$J($E(BPHARMN,1,15),15)
 . D T(TXT)
 D T("------------------------------------------------------------------------------")
 Q
 ;
J(TXT,LEN) ;Left justify
 Q TXT_$J("",LEN-$L(TXT))
 ;
DAT(X,Y) ; Convert FM date to displayable (mm/dd/yy) format.
 ; -- optional output of time, if $g(y) 
 N DATE,T
 S DATE=$S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3),1:"")
 I $G(Y) S T="."_$E($P(X,".",2)_"000000",1,7) I T>0 S DATE=DATE_" "_$S($E(T,2,3)>12:$E(T,2,3)-12,$E(T,2,3)="00":"00",1:+$E(T,2,3))_":"_$E(T,4,5)_$S($E(T,2,5)>1200:" pm",1:" am")
 Q DATE
