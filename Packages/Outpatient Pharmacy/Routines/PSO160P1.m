PSO160P1 ;BIR/BHW-Patch 160 Post Install routine - Part 1 ;11/24/03
 ;;7.0;OUTPATIENT PHARMACY;**160**;DEC 1997
 ;
EN ;Begin Processing.  Entry point for PSO160DR
 N PSRX,PSRXLDT,PSOTCNT,PSRXPROV,NVAPROV,PSRXDIV,PSORXTPB,PRVPSTAT
 N NVAPROVE,PSRXDRG,PROVTYPE,PSRXRX,DIE,DR,DA
 ;
 ;If Date of Pharmacy Benefit = Inactivation of Benefit Date Don't Process
 I PSOTDBG="" Q
 I PSOTDBG=PSOTIBD Q
 ;
 S PSOTCNT=0
 F  S PSOTCNT=$O(^PS(55,PSOTDFN,"P",PSOTCNT)) Q:'PSOTCNT  D
 . ;Get Prescription Number
 . S PSRX=$G(^PS(55,PSOTDFN,"P",PSOTCNT,0)) Q:'$L(PSRX)
 . S PSRXLDT=$$GET1^DIQ(52,PSRX,21,"I")         ;Get LOGIN DATE
 . S PSRXLDT=$P(PSRXLDT,".",1) Q:'PSRXLDT
 . ;
 . ;Determine if Login Date within Benefit Range, If not Don't Process
 . I (PSRXLDT<PSOTDBG)!((PSOTIBD'="")&(PSRXLDT>PSOTIBD)) Q
 . ;
 . ;Get PRESCRIPTION (#52) field TPB (#201), If already set, Don't Process
 . S PSRXTPB=$$GET1^DIQ(52,PSRX,201,"I") Q:PSRXTPB
 . ;
 . ;Get Provider, If not defined OR not an NVA provider, Don't Process
 . S PSRXPROV=$$GET1^DIQ(52,PSRX,4,"I") Q:'PSRXPROV
 . S NVAPROV=$$GET1^DIQ(200,PSRXPROV,53.91,"I") Q:'NVAPROV
 . ;
 . ;Get Previous PATIENT STATUS (#3) prior to setting to NON-VA
 . S PRVPSTAT=$$GET1^DIQ(52,PSRX,3)
 . ;
 . ;**********************************************************************
 . ;Set TPB (#201) ="YES" & PATIENT STATUS (#3) = NON-VA in PRESCRIPTION (#52)
 . S DIE="^PSRX(",DA=PSRX,DR="201///YES"
 . S:$G(PATSTATC)'="" DR=DR_";3///"_PATSTATC
 . D ^DIE K DIE,DA,DR
 . ;
 . ;If Unique TPB Clinic, Reset RX CLINIC to that clinic (Save Previous value)
 . I TPBCL S DIE="^PSRX(",DA=PSRX,DR="5///"_TPBCLE D ^DIE K DIE,DA,DR
 . ;
 . ;**********************************************************************
 . ;
 . ;Get display fields and Set Temporary DB for E-mail Report
 . S TPBCLP=$$GET1^DIQ(52,PSRX,5)               ;Get Clinic
 . S PSRXDRG=$$GET1^DIQ(52,PSRX,6)              ;Get Drug (External Form)
 . S PSRXRX=$$GET1^DIQ(52,PSRX,.01)             ;Get Rx Number (External Form)
 . I '$L(PSRXRX) S PSRXRX=PSRX
 . S NVAPROVE=$$GET1^DIQ(200,PSRXPROV,.01)      ;Get Provider Name (External Form)
 . S PROVTYPE=$$GET1^DIQ(200,PSRXPROV,53.6)     ;Get Provider type (External Form)
 . S PSRXDIV=$$GET1^DIQ(52,PSRX,20)             ;Get Division (External Form)
 . I '$L(PSRXDIV) S PSRXDIV="Unknown Division"
 . I $L(PROVTYPE) S NVAPROVE="*"_NVAPROVE
 . ;
 . ;Create Temporary global for E-mail Message
 . S TEMP=PATSSN_U_PSRXDRG_U_NVAPROVE_U_TPBCLP_U_TPBCLE_U_PRVPSTAT_U_"NON-VA"_U_TPBCL
 . S ^XTMP("PSO160P1",$J,"T",PSRXDIV,PATNAM,PSRXRX)=TEMP
 . Q
 Q
 ;
 ;======================================================================
 ;Loop Temporary Global and Format for E-mail
MAIL ;
 N PSRXDIV,PATNAM,PSRXRX,PSRXDRG,PATSSN,NVAPROVE,EMCNT,PATCNT,RXCNT,DASH
 N DIVFLAG,PNAM,RXSTS,TEMP,TPBRX,RX,L,DATA,PATSSNL
 S (PSRXDIV,PATNAM,PSRXRX,PSRXDRG,PATSSN,NVAPROVE)="",EMCNT=1
 S (PATCNT,RXCNT,DIVFLAG,PATSSNL)=0,$P(DASH,"-",80)=""
 ;
 ;Create Header for Mail Report
 D STORELN("The Post-Install process for PSO*7*160 - Part 1 successfully completed.")
 D STORELN(" ")
 D STORELN("Started on: "_$$FMTE^XLFDT($G(^XTMP("PSO160DR",$J,"START"))))
 D STORELN("Finished on: "_$$FMTE^XLFDT($G(^XTMP("PSO160DR",$J,"FINISH"))))
 D STORELN(" ")
 ;
 ;If no entries created above, skip reporting
 I '$L($O(^XTMP("PSO160P1",$J,"T",""))) D  G SEND
 . D STORELN("No prescriptions have been marked as TPB (Transitional Pharmacy).")
 . Q
 ;
 D STORELN("The following Prescriptions have been marked as TPB (Transitional Pharmacy")
 D STORELN("Benefits) prescription by the post-install process.")
 D STORELN(" ")
 ;
 F  S PSRXDIV=$O(^XTMP("PSO160P1",$J,"T",PSRXDIV)) Q:'$L(PSRXDIV)  D
 . ;Check if Division Changed
 . I DIVFLAG'=PSRXDIV D
 . . ;Print Sub-Header
 . . D STORELN("DIVISION: "_PSRXDIV)
 . . D STORELN(DASH)
 . . D STORELN($E("Patient Name (LAST4SSN)"_SP,1,25)_$E("Rx#"_SP,1,10)_$E("DRUG"_SP,1,24)_$E("PROVIDER"_SP,1,20))
 . . D STORELN(DASH)
 . . Q
 . E  S DIVFLAG=PSRXDIV
 . ;
 . S PATNAM=""
 . F  S PATNAM=$O(^XTMP("PSO160P1",$J,"T",PSRXDIV,PATNAM)) Q:'$L(PATNAM)  D
 . . S PSRXRX="",PATCNT=PATCNT+1
 . . ;
 . . F  S PSRXRX=$O(^XTMP("PSO160P1",$J,"T",PSRXDIV,PATNAM,PSRXRX)) Q:'$L(PSRXRX)  D
 . . . S DATA=$G(^XTMP("PSO160P1",$J,"T",PSRXDIV,PATNAM,PSRXRX))
 . . . S PATSSN=$P(DATA,U,1),PSRXDRG=$P(DATA,U,2),NVAPROVE=$P(DATA,U,3),TPBCLP=$P(DATA,U,4)
 . . . S TPBCLE=$P(DATA,U,5),PRVPSTAT=$P(DATA,U,6),PATSTAT=$P(DATA,U,7),TPBCL=$P(DATA,U,8)
 . . . ;Line 1
 . . . S TEMP="",RXCNT=RXCNT+1
 . . . S TEMP=$E(PATNAM_SP,1,20)
 . . . S TEMP=$E($E(PATNAM,1,16)_" ("_$E(PATSSN,1,5)_")"_$E(SP,1,6-PATSSNL)_SP,1,25)
 . . . S TEMP=TEMP_$E(PSRXRX_SP,1,11)
 . . . S TEMP=TEMP_$E(PSRXDRG_SP,1,22)_" "
 . . . S TEMP=TEMP_$E(NVAPROVE_SP,1,20)
 . . . D STORELN(TEMP)
 . . . ;Line 2 (clinic Line)
 . . . S TEMP=$E(SP,1,25)
 . . . I (TPBCLP'=TPBCLE)&(TPBCL) S TEMP=TEMP_"Clinic: Old: "_$E(TPBCLP,1,16)_" New: "_$E(TPBCLE,1,17)
 . . . E  S TEMP=TEMP_"Clinic: "_$E(TPBCLP,1,46)
 . . . D STORELN(TEMP)
 . . . ;Line 3 (Patient status line)
 . . . S TEMP=$E(SP,1,25)
 . . . I PRVPSTAT'=PATSTAT S TEMP=TEMP_"Rx Patient Status: Old: "_$E(PRVPSTAT,1,17)_" New: "_$E(PATSTAT_SP,1,7)
 . . . E  S TEMP=TEMP_"Rx Patient Status: "_$E(PATSTAT_SP,1,25)
 . . . D STORELN(TEMP)
 . . . D STORELN(" ")
 . . . Q
 . . Q
 . ;Print Totals only if End of Division
 . D STORELN("Total: "_PATCNT_" Patients and "_RXCNT_" Prescriptions")
 . D STORELN(" ")
 . D STORELN("* Non-VA Provider has a PROVIDER TYPE")
 . S (PATCNT,RXCNT)=0
 . Q
 ;======================================================================
SEND ;Send Completion E-mail.
 N DIFROM
 ;
 ;Setup Mailman Variables
 S XMSUB="PSO*7*160 - LIST OF PRESCRIPTIONS MARKED AS TPB"
 S XMDUZ="Patch PSO*7*160" D SXMY^PSOTPCUL("PSO TPB GROUP")
 S XMY(DUZ)="",XMTEXT="^XTMP(""PSO160P1"","_$J_",""M"","
 ;
 ;Send E-mail
 D ^XMD
 K XMTEXT,XMSUB,XMDUZ,XMY
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
 ;======================================================================
 ;Store E-mail line in "M" subscript.
STORELN(LINE) ;
 S EMCNT=EMCNT+1
 S ^XTMP("PSO160P1",$J,"M",EMCNT)=LINE
 Q
