RCDPEWLZ ;ALB/PJH-Block Auto-decrease protocol ;09 Feb 2018
 ;;4.5;Accounts Receivable;**326**;Mar 20, 1995;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
BLOCK(RCERA) ;  Stop/Allow Auto Decrease of zero balance denials
 ;
 ; Input - RCERA - IEN of ERA in #344.4
 ;
 ; Check that the ERA has auto-decrease CARCs which are not decreased
 N RCARRAY
 D AUTO(RCERA,.RCARRAY)
 ;
 D FULL^VALM1
 S VALMBCK="R"
 ;
 I 'RCARRAY D  G QUIT
 .W !!,"This option is only valid if an ERA has auto-decrease CARCs."
 ;
 I RCARRAY("D") D  G QUIT
 .W !!,"This option is not valid, the ERA has already been auto-decreased."
 ;
 N RCSTA,X
 S RCSTA=$$GET1^DIQ(344.4,RCERA_",",.19,"I")
 ;
 ;
 W !!,"This option will "
 W $S(RCSTA:"ALLOW the nightly process to auto-decrease",1:"STOP the nightly process from auto-decreasing")
 W !," the CARCs on this ERA.",!
 ;
 I $$ASKSTAT(RCSTA)'=1 Q
 ;
 ; Update ERA
 D UPD(RCERA,RCSTA)
 ;
 W !,"... CARCs on this ERA will "_$S(RCSTA:"",1:"NOT ")_"be auto-decreased ..."
 ;
QUIT ;  pause and rebuild the header
 W !!,"press RETURN to continue: "
 R X:DTIME
 ;
 N RCARC
 S RCARC=$$WLH^RCDPEWLZ(+RCSCR)
 S:RCARC]"" VALMHDR(4)=RCARC
 Q
 ;
ASKSTAT(RCSTA) ;  ask if its okay to block to unblock from auto-decrease
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="Y"
 S DIR("A")="Do you want to "_$S(RCSTA:"ALLOW",1:"STOP")_" auto-decrease of this ERA"
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
 ;
AUTO(RCERA,RCARRAY) ; Search ERA for Auto-Decrease CARCs 
 ; INPUT -  RCERA = ERA number/IEN
 ;          RCARRAY = return array reference
 ; OUTPUT - RCARRAY = list of ERA lines and auto-decrease CARC/amounts for each line
 ;
 ;          RCARRAY=1 
 ;          RCARRAY(1)="5.71;22;^10.00;23;"  - list of decrease amounts for each auto-decrease CARC
 ;          RCARRAY(1,"D")=1   - indicates line is decreased already
 ;          RCARRAY(1,"B")=1   - indicates line is/was blocked
 ;
 N EOBIEN,PAYID,PAYNAM,RC3446,RCARC,RCBLK,RCDAY,RCPARM,RCRCVD,RCSUB,RCRTYPE,RCZERO
 K RCARRAY
 S RCARRAY=0,RCARRAY("D")=0
 ; Ignore ERA if total paid is not zero
 Q:+$$GET1^DIQ(344.4,RCERA_",",.05)
 ; Ignore ERA if removed from worklist
 Q:+$$GET1^DIQ(344.4,RCERA_",",.16,"I")
 ; Calculate process date by subtracting DENIAL decrease days from today's date
 S RCDAY=$$FMADD^XLFDT(DT\1,-$$GET1^DIQ(344.61,"1,",.12))
 ; Compare to ERA received date
 S RCRCVD=$$GET1^DIQ(344.4,RCERA_",",.07,"I")
 ; If not already decreased then check that auto-decrease date is not already past
 I $$GET1^DIQ(344.4,RCERA_",",4.03,"I")="",RCRCVD\1<RCDAY Q
 ; Ignore ERA if not payment type of NON
 I $$GET1^DIQ(344.4,RCERA_",",.15)'="NON"
 ; Ignore ERA if it has PLBs
 Q:$D(^TMP($J,"RCDPEWLA","ERA LEVEL ADJUSTMENT EXISTS"))
 ; Quit if ERA is for Pharmacy
 S RCRTYPE=$$PHARM^RCDPEAP1(RCERA)
 Q:RCRTYPE
 ; Check payer exclusion file for this ERA's payer
 S PAYID=$P($G(^RCY(344.4,RCERA,0)),U,3)
 S PAYNAM=$P($G(^RCY(344.4,RCERA,0)),U,6)
 I PAYID'="",PAYNAM'="" D
 . S RCPARM=$O(^RCY(344.6,"CPID",PAYNAM,PAYID,""))
 . S:RCPARM'="" RC3446=$G(^RCY(344.6,RCPARM,0))
 ; Ignore ERA if EXCLUDE MED CLAIMS POSTING  (#.06) or EXCLUDE MED CLAIMS DECREASE (#.07) fields set to 'yes'
 I $G(RC3446)'="" Q:$P(RC3446,U,6)=1  Q:$P(RC3446,U,7)=1
 ; Scan ERA for EOB - do NOT use scratchpad
 S RCSUB=0,RCZERO=1
 F  S RCSUB=$O(^RCY(344.4,RCERA,1,RCSUB)) Q:'RCSUB  D
 .; Get IEN of EOB
 .S EOBIEN=$$GET1^DIQ(344.41,RCSUB_","_RCERA,.02,"I")
 .Q:'EOBIEN
 .; Get CARCS
 .S RCARC=$$CARCLMT^RCDPEAD(EOBIEN,RCZERO)
 .; No CARCs on EOB were eligible for auto-decrease
 .Q:$L(RCARC)=0
 .; Save CARCs agains line number
 .S RCARRAY(RCSUB)=RCARC
 .; CARCs found indicator
 .S RCARRAY=1
 .; Determine if line is already auto-decreased
 .S:$$GET1^DIQ(344.41,RCSUB_","_RCERA_",",10,"I")]"" RCARRAY("D")=1
 Q
 ;
UPD(RCERA,RCSTA) ; Update AUTO-DECREASE BLOCKED status of an ERA
 N DA,DIE,DR
 S DA=RCERA
 S DIE="^RCY(344.4,",DR=".19///"_$S(RCSTA:0,1:1) D ^DIE
 Q
 ;
WLF(RCERA) ; Return auto-decrease flag - EP EXTRACT^RCDPEWL7
 ; INPUT  - RCERA = IEN of ERA in #344.4
 ; OUTPUT - 'c' or null
 N RCARRAY
 ; Check for CARCs
 D AUTO(RCERA,.RCARRAY)
 ; Return result
 Q $S(RCARRAY:"c",1:"")
 ;
WLH(RCERA) ; Auto-decrease status for ERA - EP HDR^RCDPEWL
 ; INPUT  - RCERA = IEN of ERA in #344.4
 ; OUTPUT - RCTXT = display text
 N RCARRAY
 ; Check for CARCs
 D AUTO(RCERA,.RCARRAY)
 ; If none return null
 I 'RCARRAY Q ""
 ; Check if ERA is auto-decrease blocked
 Q:$$GET1^DIQ(344.4,RCERA_",",.19,"I") "Auto-Decrease CARCS are stopped from auto-decrease"
 ; Check if already auto-decreased
 Q:RCARRAY("D") "ERA has processed Auto-Decrease CARCS"
 ; Else
 Q "ERA has unprocessed Auto-Decrease CARCS"
 ;
WLL(RCERA,RCLINE) ; Auto-decrease status for ERA line - EP - RCDPEWL0
 ; INPUT  - RCERA = IEN of ERA in #344.4
 ;          RCLINE = ERA line number
 ; OUTPUT - RCTXT = display text
 N I,RCARC,RCARRAY,RCTOT
 ; Check for CARCs on ERA
 D AUTO(RCERA,.RCARRAY)
 ; Check for CARCs on line
 Q:'$D(RCARRAY(RCLINE)) ""
 ; Total line CARCS
 S RCTOT=0
 F I=1:1 S RCARC=$P(RCARRAY(RCLINE),U,I) Q:RCARC=""  S RCTOT=RCTOT+$P(RCARC,";")
 Q $S(RCTOT:"Auto-decrease CARC total: $"_RCTOT,1:"")
 ;
SCRPAD(RCERA) ;Build Scratchpad entry in #344.49 for the ERA - EP REJ^RCDPEAD
 ;
 ; Input - RCERA - IEN for #344.4
 ;
 ; Output - RCSCR = Scratchpad IEN (Success) or 0 (Fail)
 ;
 N RC0,RC5,RCSCR,RCDAT,X
 S RC0=$G(^RCY(344.4,RCERA,0)),RC5=$G(^RCY(344.4,RCERA,5))
 ;Ignore is this ERA already has a receipt
 I +$P(RC0,U,8) Q 0
 ;Denial ERA must be expected payment type NON 
 I $P(RC0,U,15)'="NON" Q 0
 ;Scratchpad already exists
 S RCSCR=+$O(^RCY(344.49,"B",RCERA,0)) I RCSCR G SCRPADX
 ;Create new Scratchpad
 S RCSCR=+$$ADDREC^RCDPEWL(RCERA,.RCDAT) I 'RCSCR Q 0
 ;Add all the ERA lines to the Scratchpad entry
 D ADDLINES^RCDPEWLA(RCSCR)
SCRPADX ;Return Scratchpad IEN
 Q RCSCR
