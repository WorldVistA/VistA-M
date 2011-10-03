MAGDCCS3 ;WOIFO/MLH - DICOM Correct - Clinical specialties - subroutines ; 14 Jul 2003  11:24 AM
 ;;3.0;IMAGING;**10,11**;14-April-2004
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
ASK() ;Prompt user
 N DIR,X,Y
 S DIR(0)="F:1:30",DIR("A")="Enter patient or request/consultation number"
 S DIR("?")="Enter a patient name or request/consultation number to associate with this image."
 D ^DIR
 Q Y
READ(RESULT) ; Accept input for patient or request/consultation number.
 ; We'll return patient DFN^NAME, or DFN~REQNO.
 N ANS
 S RESULT=0,ANS=$$ASK
 I ANS=""!(ANS="^") S RESULT="^" Q RESULT
 ;Is user trying to select on request/consult # or by patient?
 I ANS?1.8N D REQCON(ANS,.RESULT) I +RESULT Q RESULT ; request/consult #
 D:ANS'?.N1"-".E PAT(ANS,.RESULT) ; patient
 Q RESULT
REQCON(GMRIEN,RESULT) ; Validate existence of user-entered request/consultation number.
 ;
 S RESULT=$$GET1^DIQ(123,GMRIEN,.02,"I") ; get the patient's DFN value
 I RESULT'="" S RESULT=RESULT_"~"_GMRIEN
 Q
PAT(PAT,RESULT) ; Verify that patient exists and has requests/consults on file.
 N DIR,X,Y
 S DIR(0)="P^2:EMZ",DIR("B")=PAT
 D ^DIR
 I Y D
 . W !,"Y=",Y,! ; ***<<< DEBUG
 . I $$ANYREQ^MAGDGMRC(+Y) S RESULT=Y
 . E  W !,"No requests/consultations on file for this patient.",!
 . Q
 Q
