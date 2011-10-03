RAMAGRP2 ;HCIOFO/SG - ORDERS/EXAMS API (REMOTE PROCEDURES) ; 2/19/08 3:46pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;+++++ INDICATES THAT THE PROCEDURE HAS BEEN PERFORMED
 ; RPC: [RAMAG EXAMINED]
 ;
 ; .RARESULT     Reference to a local variable where the results
 ;               are returned to.
 ;
 ; See the comments preceding the $$EXAMINED^RAMAG07 function for
 ; description of other parameters.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RARESULT(0)
 ; indicates an error (see the RPCSTK^RAERR01 procedure for more
 ; details).
 ;
 ; Otherwise, 0 is returned in the RARESULT(0).
 ;
EXAMINED(RARESULT,RACASE,RAMSC) ;
 N RAERROR,RAMISC,RC
 N:'$G(RAPARAMS("DEBUG")) RAPARAMS
 K RARESULT  S (RARESULT(0),RC)=0
 D CLEAR^RAERR(1)
 ;--- Debug code
 D:$G(RAPARAMS("DEBUG"))>1
 . D W^RAMAGU11("RAMAG EXAMINED","!!")
 . D VARS^RAMAGU11("RACASE")
 . D ZW^RAUTL22("RAMSC")
 D
 . ;--- Parse miscellaneous parameters
 . S RC=$$RPCMISC^RAMAGU01(.RAMSC,.RAMISC)  Q:RC<0
 . K RAMSC
 . ;--- Indicate that the procedure has been performed
 . S RC=$$EXAMINED^RAMAG07(.RAPARAMS,.RACASE,.RAMISC)
 ;---
 D:RC<0 RPCSTK^RAERR01(.RARESULT,RC)
 Q
 ;
 ;+++++ RETURNS EXAM STATUS REQUIREMENTS
 ; RPC: [RAMAG EXAM STATUS REQUIREMENTS]
 ;
 ; .RARESULT     Reference to a local variable where the results
 ;               are returned to.
 ;
 ; RACTION       Action that is going to be performed on an
 ;               exam/case record (single character):
 ;
 ;                 E  Examined (procedure has been performed,
 ;                    images have been acquired)
 ;
 ;                 C  Complete
 ;
 ; RAIMGTYI      Imaging type IEN (file #79.2).
 ;
 ; [RAPROC]      Radiology procedure IEN (file #71). This parameter
 ;               is required to determine exact nuclear medicine
 ;               requirements. See the $$EXMSTREQ^RAMAGU06 for more
 ;               details.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RARESULT(0)
 ; indicates an error (see the RPCSTK^RAERR01 procedure for more
 ; details).
 ;
 ; Otherwise, exam status requirements are returned in the
 ; RARESULT(0). See the $$EXMSTREQ^RAMAGU06 for details.
 ; Descriptor of the exam status is returned in the RARESULT(1).
 ; See the ^RAMAGU06 for details.
 ;
EXMSTREQ(RARESULT,RACTION,RAIMGTYI,RAPROC) ;
 N EXMST,RAERROR,RC
 N:'$G(RAPARAMS("DEBUG")) RAPARAMS
 K RARESULT  S (EXMST,RARESULT(0),RC)=0
 D CLEAR^RAERR(1)
 ;=== Debug code
 D:$G(RAPARAMS("DEBUG"))>1
 . D W^RAMAGU11("RAMAG EXAM STATUS REQUIREMENTS","!!")
 . D VARS^RAMAGU11("RACTION,RAIMGTYI")
 ;
 ;=== Find the exam status record
 D
 . I RACTION="C"  D  Q
 . . S EXMST=$$EXMSTINF^RAMAGU06("^^9",.RAIMGTYI)
 . ;---
 . I RACTION="E"  D  Q
 . . S EXMST=$$EXMSTINF^RAMAGU06("^^1",.RAIMGTYI)  Q:EXMST<0
 . . S EXMST=$$GETEXMND^RAMAGU06(+EXMST)
 . ;---
 . S EXMST=$$IPVE^RAERR("RACTION")
 S:EXMST<0 RC=EXMST
 ;
 ;=== Get the status requirements
 I RC'<0  D
 . S (RARESULT(0),RC)=$$EXMSTREQ^RAMAGU06(+EXMST,.RAPROC)  Q:RC<0
 . S RARESULT(1)=EXMST
 D:RC<0 RPCSTK^RAERR01(.RARESULT,RC)
 Q
