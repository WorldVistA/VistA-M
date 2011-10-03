BPSJVAL ;BHAM ISC/LJF - Pharmacy data entry ;2004-03-01
 ;;1.0;E CLAIMS MGMT ENGINE;**1,2**;JUN 2004;Build 12
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 D ^BPSJVAL1
 K DIR,X S DIR(0)="EO" D ^DIR
 I X=U Q
 D ^BPSJVAL2
 Q
 ;
VAL1(VALCK) ;   Application
 N RETCODE,VERBOSE,IX2
 ;
 ; VALCK=0 = validation, HL7 trigger, no display
 I '$G(VALCK) N RETCODE D  Q RETCODE  ; 0 means ok, '0 means invalid
 . ;-validate and quit if ok
 . S RETCODE=0 D VALIDATE^BPSJVAL1 I $G(BPSJVALR)=-1 S BPSJVALR=RETCODE
 . I 'RETCODE Q
 . ;-invalid data, send an email
 . S MCT=1+$G(MCT),MSG(MCT)="ECME Application Registration HL7 Message not created."
 . F IX2=1:1:RETCODE I $G(RETCODE(IX2))]"" D
 .. S MCT=1+MCT,MSG(MCT)=$G(RETCODE(IX2))
 . D MSG^BPSJUTL(.MSG,"ECME Application Registration")
 ;
 ; VALCK=1 = validation, HL7 trigger, display
 I $G(VALCK)=1 N RETCODE D  Q RETCODE  ; 0 means ok, '0 means invalid
 . S RETCODE=0,VERBOSE=1 D VALIDATE^BPSJVAL1
 . I $G(BPSJVALR)=-1 S BPSJVALR=RETCODE
 ;
 ; VALCK=2 = validation, no HL7 trigger, display
 I $G(VALCK)=2 N RETCODE D  Q 1
 . S RETCODE=0,VERBOSE=1 D VALIDATE^BPSJVAL1
 . I $G(BPSJVALR)=-1 S BPSJVALR=RETCODE
 ;
 ; VALCK=3 = validation, no HL7 trigger, no display
 I $G(VALCK)=3 N RETCODE D  Q 1
 . S RETCODE=0 D VALIDATE^BPSJVAL1
 . I $G(BPSJVALR)=-1 S BPSJVALR=RETCODE
 ;
 Q
 ;
VAL2(VALCK,BPSJD) ;  Pharmacies
 N RETCODE,VERBOSE,IX2
 ;
 ; VALCK=0 = validation, HL7 trigger, no display
 I '$G(VALCK) N RETCODE D  Q RETCODE  ; 0 means ok, '0 means invalid
 . ;-validate and quit if ok
 . S RETCODE=0 D VALIDATE^BPSJVAL2(BPSJD) I $G(BPSJVALR)=-1 S BPSJVALR=RETCODE
 . I 'RETCODE Q
 . ;-invalid data, send an email
 . S MCT=1+$G(MCT),MSG(MCT)="ECME Pharmacy Registration HL7 Message not created."
 . F IX2=1:1:RETCODE I $G(RETCODE(IX2))]"" D
 .. S MCT=1+MCT,MSG(MCT)=$G(RETCODE(IX2))
 . D MSG^BPSJUTL(.MSG,"ECME Pharmacy Registration")
 ;
 ; VALCK=1 = validation, HL7 trigger, display
 I $G(VALCK)=1 N RETCODE D  Q RETCODE  ; 0 means ok, '0 means invalid
 . S RETCODE=0,VERBOSE=1 D VALIDATE^BPSJVAL2(BPSJD)
 . I $G(BPSJVALR)=-1 S BPSJVALR=RETCODE
 ;
 ; VALCK=2 = validation, no HL7 trigger, display
 I $G(VALCK)=2 N RETCODE D  Q 1
 . S RETCODE=0,VERBOSE=1 D VALIDATE^BPSJVAL2(BPSJD)
 . I $G(BPSJVALR)=-1 S BPSJVALR=RETCODE
 ;
 ; VALCK=3 = validation, no display, no HL7 trigger
 I $G(VALCK)=3 N RETCODE D  Q 1
 . S RETCODE=0 D VALIDATE^BPSJVAL2(BPSJD)
 . I $G(BPSJVALR)=-1 S BPSJVALR=RETCODE
 ;
 Q
