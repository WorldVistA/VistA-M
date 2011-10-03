PXAIXAMV ;ISL/PKR - VALIDATE EXAMINATION DATA ;7/24/96  13:59
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 ;
VAL ;Make sure the required field is present.
 I '$D(PXAA("EXAM")) D
 . S STOP=1
 . S PXAERRF=1
 . S PXADI("DIALOG")=8390001.001
 . S PXAERR(9)="EXAM"
 . S PXAERR(10)="AFTER"
 . S PXAERR(11)=$G(PXAA("EXAM"))
 . S PXAERR(12)="You are missing the name of the exam"
 Q
