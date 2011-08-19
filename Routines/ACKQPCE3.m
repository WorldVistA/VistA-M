ACKQPCE3 ;HCIOFO/AG - Quasar/PCE Interface; August 1999.
 ;;3.0;QUASAR;;Feb 11, 2000
 ;;
 ;
KILLPCE(ACKVIEN) ; kill a visit from PCE 
 ; see KILLPCE^ACKQPCE for comments. this routine should not be
 ; called directly, only from ^ACKQPCE (this routine assumes that
 ; ACKVIEN exists).
 N ACKDEAD,ACKLOCK,ACKPCE,ACKE,ACKARR,ACKMSG,ACKRSN
 S ACKDEAD=1,ACKLOCK=0
 ;
 ; get the PCE VISIT IEN from the visit file
 S ACKPCE=$$GET1^DIQ(509850.6,ACKVIEN_",",125,"I")
 ;
 ; if no PCE Visit Ien then nothing to do.
 I 'ACKPCE G KILLPCEX
 ;
 ; lock the visit
 L +^ACK(509850.6,ACKVIEN):0 I $T S ACKLOCK=1
 ;
 ; clear any existing PCE Errors for this visit
 D CLEAR^ACKQPCE(ACKVIEN)
 ;
 ; call PCE to delete the visit
 S ACKE=$$DELVFILE^PXAPI("ALL",ACKPCE,"","",0,0,"")
 ;
 ; if deletion not completed then record error and set flag
 I ACKE'=1 D
 . K ACKRSN S ACKRSN=0
 . S ACKMSG="Unable to Delete PCE Visit (error code="_ACKE_")"
 . D ADDRSN^ACKQPCE2("PCE VISIT",ACKPCE,"",ACKMSG,.ACKRSN)
 . D FILERSN^ACKQPCE(ACKVIEN,.ACKRSN)
 .  ; file last edited in Quasar date to create exception entry
 . K ACKARR D NOW^%DTC
 . S ACKARR(509850.6,ACKVIEN_",",140)=%
 . D FILE^DIE("","ACKARR","")
 . S ACKDEAD=0
 ;
 ; if deleted ok then update fields and set flag
 I ACKE=1 D
 . K ACKARR D NOW^%DTC
 . S ACKARR(509850.6,ACKVIEN_",",125)="@"  ; remove PCE Visit ien
 . S ACKARR(509850.6,ACKVIEN_",",135)=%    ; last sent to pce
 . D FILE^DIE("","ACKARR","")
 . S ACKDEAD=1
 ;
KILLPCEX ; exit point from KILLPCE
 ;
 ; if visit was locked then unlock it
 I ACKLOCK L -^ACK(509850.6,ACKVIEN)
 ;
 ; return whether the PCe visit was killed
 Q ACKDEAD
 ;
