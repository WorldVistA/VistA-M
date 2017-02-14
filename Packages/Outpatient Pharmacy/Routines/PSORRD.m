PSORRD ;AITC/BWF - Remote RX report details ;8/15/16 5:43pm
 ;;7.0;OUTPATIENT PHARMACY;**454**;DEC 1997;Build 349
 ;
EN ; -- main entry point for PSO LM REMOTE REPORT DETAILS
 D EN^VALM("PSO LM REMOTE REPORT DETAILS")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Detailed report of "_$P("Prescriptions dispensed for other Host Pharmacies^Our RXs filled by other facilities as the Dispensing Pharmacy^All OneVA Pharmacy Prescription Activity","^",PSOREPORT)
 Q
 ;
INIT ; -- init variables and list array
 S VALMCNT=PSORCNT
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 S VALMBCK="R"
 K PSORCNT
 Q
 ;
EXPND ; -- expand code
 Q
 ;
