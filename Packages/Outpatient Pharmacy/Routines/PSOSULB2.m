PSOSULB2 ;AITC/MRD - Print suspended labels cont. ;12/8/20
 ;;7.0;OUTPATIENT PHARMACY;**561**;DEC 1997;Build 41
 ;Reference to $$INSUR^IBBAPI supported by IA 4419
 ;Reference to $$BILLABLE^IBNCPDP supported by IA 6243
 ;
EBILLABLE(PSORX,PSOFILL) ; Determine if this Rx is e-billable.
 ;
 ; This function will return '1' if the given Rx/Fill is
 ; e-billable.  Otherwise, it returns '0'.
 ;
 N PSODFN,PSODRUG,PSOELIG,PSOIBSTAT
 ;
 ; If this is not the original fill, and the previous fill was not
 ; billable, Quit with 0.
 ;
 I PSOFILL>0,$$STATUS^BPSOSRX(PSORX,PSOFILL-1)="" Q 0
 ;
 ; If one of the environmental indicators is set, Quit with 0.
 ;
 I $P($G(^PSRX(PSORX,"ICD",1,0)),U,2,10)[1 Q 0
 ;
 ; If the drug is not billable, Quit with 0.
 ;
 S PSODRUG=$$GET1^DIQ(52,PSORX,6,"I")
 I PSOFILL S PSOELIG=$$GET1^DIQ(52.1,PSOFILL_","_PSORX,85,"I")
 E  S PSOELIG=$$GET1^DIQ(52,PSORX,85,"I")
 I '$$BILLABLE^IBNCPDP(PSODRUG,PSOELIG) Q 0  ; IA# 6243
 ;
 ; If there is no insurance on file, Quit with 0.
 ;
 S PSODFN=$$GET1^DIQ(52,PSORX,2,"I")
 S PSOIBSTAT=$$INSUR^IBBAPI(PSODFN,,"E",,1)
 I 'PSOIBSTAT!(PSOIBSTAT=-1) Q 0
 ;
 Q 1
 ;
