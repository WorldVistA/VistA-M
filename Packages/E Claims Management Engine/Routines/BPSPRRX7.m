BPSPRRX7 ;AITC/PD - ePharmacy secondary billing ;01-JUN-20
 ;;1.0;E CLAIMS MGMT ENGINE;**28**;JUN 2004;Build 22
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
ACTDTY(BPSRX,BPSRF,BPSDFN,BPSDOS) ; Active Duty Override
 ; Input:
 ;    BPSRX  (r) - Rx IEN
 ;    BPSRF  (r) - Rx Refill
 ;    BPSDFN (r) - Patient IEN
 ;    BPSDOS (r) - Rx Date of Service
 ;
 I $G(BPSRX)="" Q
 I $G(BPSRF)="" Q
 I $G(BPSDFN)="" Q
 I $G(BPSDOS)="" Q
 ;
 N BPSDOSE,BPSEI,BPSELIG,BPSES,BPSICD,BPSSIG,BPSX,DFN,DIR,DUOUT
 N VAEL,X1,Y
 ;
 ; Check Eligibility - Must be TRICARE dual eligible
 ; (Veteran and TRICARE)
 ;
 S DFN=BPSDFN
 D ELIG^VADPT
 I 'VAEL(4) Q
 S BPSELIG=$P(VAEL(1),"^",2)
 S BPSX=""
 F  S BPSX=$O(VAEL(1,BPSX)) Q:BPSX=""  D
 . S BPSELIG=BPSELIG_$P(VAEL(1,BPSX),"^",2)
 I BPSELIG'["TRICARE" Q
 ;
 ; Check Environmental Indicators
 ;
 S BPSEI=0
 K BPSICD
 D GETS^DIQ(52.052311,1_","_BPSRX,"1;2;3;4;5;7;","I","BPSICD")
 S BPSX="BPSICD(52)"
 F  S BPSX=$Q(@BPSX) Q:BPSX=""  I @BPSX=1 S BPSEI=1
 I BPSEI'=1 Q
 ;
 ; Check Date of Service
 ;
 S BPSDOSE=$E(BPSDOS,4,5)_"/"_$E(BPSDOS,6,7)_"/"_(1700+$E(BPSDOS,1,3))
 S DIR(0)="Y"
 S DIR("A")="Was the patient Active Duty on "_BPSDOSE
 S DIR("B")="No"
 S DIR("?",1)="Enter Yes or No"
 S DIR("?",2)="No  - maintains the current Veteran status(es) and claim will not be"
 S DIR("?",3)="      submitted"
 S DIR("?",4)="Yes - overrides Veteran non-billable status(es) (e.g. SC, Combat, MST,"
 S DIR("?",5)="      AO, etc.) and submits claim"
 S DIR("?",6)=" "
 S DIR("?")="An Electronic Signature code is required."
 D ^DIR
 I $G(DUOUT)!(Y="^")!('Y) D SETADO(BPSRX,BPSRF,0) Q
 ;
 ; Check Signature Code
 ;
 ; If no Electronic Signature code on file, display message and quit.
 ;
 S BPSES=$$GET1^DIQ(200,DUZ,20.4)
 I BPSES="" D  D SETADO(BPSRX,BPSRF,0) Q
 . W !,"Electronic Signature code is required."
 ;
 ; User has an Electronic Signature code on file.
 ; Prompt for Signature Code to verify.
 ; 
 S BPSSIG=0
SIGCD ; Signature Code
 D SIG^XUSESIG
 I 'BPSSIG&($G(X1)="") D  G SIGCD
 . W !!,"  *** Electronic Signature code is required. ***"
 . S BPSSIG=1
 I $G(X1)="" D SETADO(BPSRX,BPSRF,0) Q
 ;
 D SETADO(BPSRX,BPSRF,1)
 ;
 Q
 ;
SETADO(BPSRX,BPSRF,BPSAD) ; Set Active Duty Override Flag
 ;
 ; Input:
 ; BPSRX (r) - Rx IEN
 ; BPSRF (r) - Rx Refill
 ; BPSAD (r) - Acticve Duty Override; 0=No, 1=Yes
 ;
 N DA,DIE,DR
 ;
 ; Original Fill
 I 'BPSRF D
 . S DA=BPSRX
 . S DIE="^PSRX("
 . S DR="32.4///"_+$G(BPSAD)
 ;
 ; Refill
 I BPSRF D
 . S DA=BPSRF
 . S DA(1)=BPSRX
 . S DIE="^PSRX("_BPSRX_",1,"
 . S DR="24///"_+$G(BPSAD)
 ;
 D ^DIE
 Q
