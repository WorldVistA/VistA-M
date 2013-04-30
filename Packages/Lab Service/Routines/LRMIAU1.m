LRMIAU1 ;DALISC/RBN - Microbiology Audit PREPROCESSOR ;July 22, 2008
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; This routine is a shell so it will fit back into the proposed framework for LR*5.2*216
 Q
 ;
 ;
FILEAUD(DATA) ;
 ; Replacement for FILEIT^LRMIAU1
 ; Expects LRDFN,LRIDT,LREDT,LRSB
 ; Inputs
 ;   DATA : <byref>  (File#,field)=value
 ; Outputs
 ;   Returns #63.539 IEN or 0 if record not created
 ;
 N X,LRIEN,LRIENS,LRFDA,LRMSG,DIERR
 S LRIEN="+1"_","_LRIDT_","_LRDFN_","
 I $G(LREDT)="" N LREDT S LREDT=$$NOW^XLFDT
 S LRFDA(1,63.539,LRIEN,.01)=LREDT
 S LRFDA(1,63.539,LRIEN,1)=LREDT
 S LRFDA(1,63.539,LRIEN,2)=DUZ
 I $G(DATA(63.539,3))'="" S LRFDA(1,63.539,LRIEN,3)=DATA(63.539,3)
 I $G(DATA(63.539,4))'="" S LRFDA(1,63.539,LRIEN,4)=DATA(63.539,4)
 I $G(LRSB),$$DATAOK(63.539,6,LRSB) S LRFDA(1,63.539,LRIEN,6)=$G(LRSB)
 S LRFDA(1,63.539,LRIEN,7)=DUZ(2)
 D UPDATE^DIE("","LRFDA(1)","LRIENS","LRMSG")
 ;
 Q $G(LRIENS(1))
 ;
 ;
DATAOK(LRFILE,LRFLD,LRVAL) ;
 ; Checks if a value is appropriate for storing in the field
 ; Inputs
 ;  LRFILE : File #
 ;  LR FLD : Field #
 ;   LRVAL : Value of the field
 ;
 ; Returns 0 (invalid) or 1 (valid)
 ;
 N STATUS,LROUT,LRMSG
 S STATUS=0
 D CHK^DIE(LRFILE,LRFLD,"",LRVAL,.LROUT,"LRMSG")
 I $G(LROUT)'="^" S STATUS=1
 I $D(LRMSG) S STATUS=0
 Q STATUS
