PXAIXAMV ;SLC/PKR - VALIDATE EXAMINATION DATA ;03/12/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;
ERRSET ;Set the rest of the error data.
 S STOP=1
 S PXAERRF=1
 S PXADI("DIALOG")=8390001.001
 S PXAERR(7)="EXAM"
 Q
 ;
VAL ;Validate the input data.
 I $G(PXAA("EXAM"))="" D  Q
 . S PXAERR(9)="EXAM"
 . S PXAERR(12)="The Exam is missing."
 . D ERRSET
 ;
 ;If this is a deletion no further verification is required.
 I $G(PXAA("DELETE"))=1 Q
 ;
 ;Check that it is a valid pointer.
 I '$D(^AUTTEXAM(PXAA("EXAM"))) D  Q
 . S PXAERR(9)="EXAM"
 . S PXAERR(11)=PXAA("EXAM")
 . S PXAERR(12)="The Exam pointer is not valid."
 . D ERRSET
 ;
 N TEMP S TEMP=$G(^AUTTEXAM(PXAA("EXAM"),0))
 ;Check that the .01 is not null.
 I $P(TEMP,U,1)="" D  Q
 . S PXAERR(9)="EXAM"
 . S PXAERR(11)=PXAA("EXAM")
 . S PXAERR(12)="The Exam does not have a .01."
 . D ERRSET
 ;
 ;Check that it is active.
 I $P(TEMP,U,4)=1 D
 . S PXAERR(9)="INACTIVE"
 . S PXAERR(11)=PXAA("EXAM")
 . S PXAERR(12)="The Exam is inactive."
 . D ERRSET
 ;
 ;If a Result is being input validate it.
 I $G(PXAA("RESULT"))'="",'$$SET^PXAIVAL(9000010.13,"RESULT",.04,PXAA("RESULT"),.PXAERR) D  Q
 . D ERRSET
 ;
 ;If Event D/T is input verify it is a valid FileMan date and not in
 ;the future.
 I $G(PXAA("EVENT D/T"))'="",'$$EVENTDT^PXAIVAL(PXAA("EVENT D/T"),"T",.PXAERR) D  Q
 . D ERRSET
 ;
 ;If a Comment is passed verify it.
 I $G(PXAA("COMMENT"))'="",'$$TEXT^PXAIVAL("COMMENT",PXAA("COMMENT"),1,245,.PXAERR) D  Q
 . D ERRSET
 ;
 ;If an Ordering Provider is passed verify it is valid.
 I $G(PXAA("ORD PROVIDER"))'="",'$$PRV^PXAIVAL(PXAA("ORD PROVIDER"),"ORD",.PXAA,.PXAERR,PXAVISIT) D  Q
 . D ERRSET
 ;
 ;If an Encounter Provider is passed verify it is valid.
 I $G(PXAA("ENC PROVIDER"))'="",'$$PRV^PXAIVAL(PXAA("ENC PROVIDER"),"ENC",.PXAA,.PXAERR,PXAVISIT) D  Q
 . D ERRSET
 ;
 ;If a measurement is being input verify that it is in the allowed
 ;range.
 I $G(PXAA("MAGNITUDE"))'="",'$$MAG^PXAIVAL(PXAA("MAGNITUDE"),$G(^AUTTEXAM(PXAA("EXAM"),220)),.PXAERR) D  Q
 . D ERRSET
 ;
 ;If PKG is input verify it.
 I $G(PXAA("PKG"))'="" D
 . N PKG
 . S PKG=$$VPKG^PXAIVAL(PXAA("PKG"),.PXAERR)
 . I PKG=0 S PXAERR(9)="PKG" D ERRSET Q
 . S PXAA("PKG")=PKG
 I $G(STOP)=1 Q
 ;
 ;If SOURCE is input verify it.
 I $G(PXAA("SOURCE"))'="" D
 . N SRC
 . S SRC=$$VSOURCE^PXAIVAL(PXAA("SOURCE"),.PXAERR)
 . I SRC=0 S PXAERR(9)="SOURCE" D ERRSET Q
 . S PXAA("SOURCE")=SRC
 Q
 ;
