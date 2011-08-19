RAMAGRP1 ;HCIOFO/SG - ORDERS/EXAMS API (REMOTE PROCEDURES) ; 6/6/08 2:40pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;+++++ COMPLETES THE EXAM
 ; RPC: [RAMAG EXAM COMPLETE]
 ;
 ; .RARESULT     Reference to a local variable where the results
 ;               are returned to.
 ;
 ; See the comments preceding the $$COMPLETE^RAMAG06 function for
 ; description of other parameters.
 ;
 ; NOTE: Date/time values are passed into this RPC it in HL7
 ;       format (TS): YYYYMMDD[HHMM[+/-ZZZZ]].
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RARESULT(0)
 ; indicates an error (see the RPCSTK^RAERR01 procedure for more
 ; details).
 ;
 ; Otherwise, 0 is returned in the RARESULT(0).
 ;
COMPLETE(RARESULT,RACASE,RAMSC) ;
 N RAERROR,RAMISC,RC
 N:'$G(RAPARAMS("DEBUG")) RAPARAMS
 K RARESULT  S (RARESULT(0),RC)=0
 ;---
 D CLEAR^RAERR(1)
 D:$G(RAPARAMS("DEBUG"))>1
 . D W^RAMAGU11("RAMAG EXAM COMPLETE","!!")
 . D VARS^RAMAGU11("RACASE")
 . D ZW^RAUTL22("RAMSC")
 D
 . ;--- Parse miscellaneous parameters
 . S RC=$$RPCMISC^RAMAGU01(.RAMSC,.RAMISC)  Q:RC<0
 . K RAMSC
 . ;--- Complete the exam
 . S RC=$$COMPLETE^RAMAG06(.RAPARAMS,.RACASE,.RAMISC)
 ;---
 D:RC<0 RPCSTK^RAERR01(.RARESULT,RC)
 Q
 ;
 ;+++++ CANCELS THE EXAM
 ; RPC: [RAMAG EXAM CANCEL]
 ;
 ; .RARESULT     Reference to a local variable where the results
 ;               are returned to.
 ;
 ; See the comments preceding the $$EXAMCANC^RAMAG05 function for
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
EXAMCANC(RARESULT,RACASE,RAREASON,RAFLAGS,RAMSC) ;
 N RAERROR,RAMISC,RC
 N:'$G(RAPARAMS("DEBUG")) RAPARAMS
 K RARESULT  S (RARESULT(0),RC)=0
 ;---
 D CLEAR^RAERR(1)
 D:$G(RAPARAMS("DEBUG"))>1
 . D W^RAMAGU11("RAMAG EXAM CANCEL","!!")
 . D VARS^RAMAGU11("RACASE,RAREASON,RAFLAGS")
 . D ZW^RAUTL22("RAMSC")
 D
 . ;--- Parse miscellaneous parameters
 . S RC=$$RPCMISC^RAMAGU01(.RAMSC,.RAMISC)  Q:RC<0
 . K RAMSC
 . ;--- Cancel the exam
 . S RC=$$EXAMCANC^RAMAG05(.RAPARAMS,.RACASE,.RAREASON,.RAFLAGS,.RAMISC)
 ;---
 D:RC<0 RPCSTK^RAERR01(.RARESULT,RC)
 Q
 ;
 ;+++++ CANCELS THE ORDER
 ; RPC: [RAMAG ORDER CANCEL]
 ;
 ; .RARESULT     Reference to a local variable where the results
 ;               are returned to.
 ;
 ; See the comments preceding the $$ORDCANC^RAMAG04 function for
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
ORDCANC(RARESULT,RAOIFN,RAREASON,RAMSC) ;
 N RAERROR,RAMISC,RC
 N:'$G(RAPARAMS("DEBUG")) RAPARAMS
 K RARESULT  S (RARESULT(0),RC)=0
 ;---
 D CLEAR^RAERR(1)
 D:$G(RAPARAMS("DEBUG"))>1
 . D W^RAMAGU11("RAMAG ORDER CANCEL","!!")
 . D VARS^RAMAGU11("RAOIFN,RAREASON")
 . D ZW^RAUTL22("RAMSC")
 D
 . ;--- Parse miscellaneous parameters
 . S RC=$$RPCMISC^RAMAGU01(.RAMSC,.RAMISC)  Q:RC<0
 . K RAMSC
 . ;--- Cancel the order
 . S RC=$$ORDCANC^RAMAG04(.RAPARAMS,.RAOIFN,.RAREASON,.RAMISC)
 ;---
 D:RC<0 RPCSTK^RAERR01(.RARESULT,RC)
 Q
 ;
 ;+++++ ORDERS/REQUESTS AN EXAM
 ; RPC: [RAMAG EXAM ORDER]
 ;
 ; .RARESULT     Reference to a local variable where the results
 ;               are returned to.
 ;
 ; See the comments preceding the $$ORDER^RAMAG02 function for
 ; description of other parameters.
 ;
 ; NOTE: Date/time values are passed into this RPC it in HL7
 ;       format (TS): YYYYMMDD[HHMM[+/-ZZZZ]].
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RARESULT(0)
 ; indicates an error (see the RPCSTK^RAERR01 procedure for more
 ; details).
 ;
 ; Otherwise, IEN of the new order in the RAD/NUC MED ORDERS file
 ; (#75.1) is returned in the RARESULT(0).
 ;
ORDER(RARESULT,RADFN,RAMLC,RAPROC,REQDTE,RACAT,REQLOC,REQPHYS,REASON,RAMSC) ;
 N REQDTE1,RAERROR,RAMISC,RC
 N:'$G(RAPARAMS("DEBUG")) RAPARAMS
 K RARESULT  S (RARESULT(0),RC)=0
 ;---
 D CLEAR^RAERR(1)
 D:$G(RAPARAMS("DEBUG"))>1
 . D W^RAMAGU11("RAMAG EXAM ORDER","!!")
 . D VARS^RAMAGU11("RADFN,RAMLC,RAPROC")
 . D VARS^RAMAGU11("REQDTE,RACAT,REQLOC,REQPHYS")
 . D VARS^RAMAGU11("REASON")
 . D ZW^RAUTL22("RAMSC")
 D
 . ;--- Parse miscellaneous parameters
 . S RC=$$RPCMISC^RAMAGU01(.RAMSC,.RAMISC)  Q:RC<0
 . K RAMSC
 . ;--- Convert the request date
 . S REQDTE1=$$HL7TFM^XLFDT($G(REQDTE))
 . I REQDTE1'>0  D  Q
 . . S RC=$$IPVE^RAERR("REQDTE")
 . ;--- Request an exam
 . S RC=$$ORDER^RAMAG02(.RAPARAMS,.RADFN,.RAMLC,.RAPROC,REQDTE1,.RACAT,.REQLOC,.REQPHYS,.REASON,.RAMISC)
 . S:RC>0 RARESULT(0)=+RC
 ;---
 D:RC<0 RPCSTK^RAERR01(.RARESULT,RC)
 Q
 ;
 ;+++++ REGISTERS THE EXAM
 ; RPC: [RAMAG EXAM REGISTER]
 ;
 ; .RARESULT     Reference to a local variable where the results
 ;               are returned to.
 ;
 ; See the comments preceding the $$REGISTER^RAMAG03 function for
 ; description of other parameters.
 ;
 ; NOTE: Date/time values are passed into this RPC and returned from
 ;       it in HL7 format (TS): YYYYMMDD[HHMM[+/-ZZZZ]].
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RARESULT(0)
 ; indicates an error (see the RPCSTK^RAERR01 procedure for more
 ; details).
 ;
 ; Otherwise, number of registered examinations is returned in the
 ; RARESULT(0) and identifiers of the examinations are returned
 ; in the subsequent elements of the array.
 ;
 ; RARESULT(
 ;   0)                  Number of registered examinations
 ;
 ;   i)                  Examination identifiers
 ;                         ^01: IEN of the patient in the file #70
 ;                         ^02: IEN in the REGISTERED EXAMS multiple
 ;                         ^03: IEN in the EXAMINATIONS multiple
 ;                         ^04: Case number
 ;                         ^05: Accession number
 ;                         ^06: Actual date/time of the case (value
 ;                              of the EXAM DATE field) in HL7 format 
 ;                              (TS): YYYYMMDD[HHMM[+/-ZZZZ]]
 ;
REGISTER(RARESULT,RAOIFN,EXMDTE,RAMSC) ;
 N I,EXMDTE1,RAERROR,RAMISC,RC
 N:'$G(RAPARAMS("DEBUG")) RAPARAMS
 K RARESULT  S (RARESULT(0),RC)=0
 ;---
 D CLEAR^RAERR(1)
 D:$G(RAPARAMS("DEBUG"))>1
 . D W^RAMAGU11("RAMAG EXAM REGISTER","!!")
 . D VARS^RAMAGU11("RAOIFN,EXMDTE")
 . D ZW^RAUTL22("RAMSC")
 D
 . ;--- Parse miscellaneous parameters
 . S RC=$$RPCMISC^RAMAGU01(.RAMSC,.RAMISC)  Q:RC<0
 . K RAMSC
 . ;--- Convert the exam date/time
 . S EXMDTE1=$$HL7TFM^XLFDT($G(EXMDTE))
 . I EXMDTE1'>0  D  Q
 . . S RC=$$IPVE^RAERR("EXMDTE")
 . ;--- Register the exam
 . S RC=$$REGISTER^RAMAG03(.RAPARAMS,.RARESULT,.RAOIFN,EXMDTE1,.RAMISC)
 . Q:RC'>0
 . S RARESULT(0)=+RC
 . ;--- Convert the result date/time values to HL7 (TS) format
 . F I=1:1:RARESULT(0)  D
 . . S $P(RARESULT(I),U,6)=$$FMTHL7^XLFDT($P(RARESULT(I),U,6))
 ;---
 D:RC<0 RPCSTK^RAERR01(.RARESULT,RC)
 Q
