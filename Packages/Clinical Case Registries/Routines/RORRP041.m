RORRP041 ;HCIOFO/SG - RPC: REGISTRY-SPECIFIC LAB RESULTS ; 8/25/05 12:24pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** LOADS AND PROCESSES CD4 AND VIRAL LOAD RESULTS
 ;
 ; .ROR8DST(     Reference to the Lab search descriptor.
 ;               See the $$LTSEARCH^RORUTL10 for details
 ;
 ;   "RORPTR")   Index of the last node in the destination buffer
 ;
 ;   "RORSTATS",
 ;     Group,
 ;       "LAST") Latest
 ;                 ^01: Result Value
 ;                 ^02: Date
 ;       "MAX")  Highest
 ;                 ^01: Result Value
 ;                 ^02: Date
 ;       "MIN")  Lowest
 ;                 ^01: Result Value
 ;                 ^02: Date
 ;
 ; INVDT         IEN of the Lab test (inverted date)
 ;
 ; .RESULT       Reference to a local variable, which contains the
 ;               result in the same format as it is stored into
 ;               the destination array by default.
 ;
 ; Return Values:
 ;       <0  Error code (the search will be aborted)
 ;        0  Ok
 ;        1  Skip this result
 ;        2  Skip this and all remaining results
 ;
LOADLT(ROR8DST,INVDT,RESULT) ;
 N BUF,GROUP,LTDT,LTVAL,TMP
 S LTDT=$P($G(RESULT(1)),U,2)    Q:LTDT'>0 1   ; Date of the test
 S LTVAL=$$TRIM^XLFSTR($P(RESULT(1),U,3))      ; Result value
 S GROUP=+$P($G(RESULT(2)),U,3)  Q:GROUP'>0 1  ; Code of the group
 ;
 ;=== Create and store the segment
 S BUF="LTR"_U_$P(RESULT(1),U)
 S $P(BUF,U,3,4)=LTDT_U_LTVAL
 S $P(BUF,U,5,8)=$P(RESULT(2),U,1,4)
 S ROR8DST("RORPTR")=$G(ROR8DST("RORPTR"))+1
 S @ROR8DST@(ROR8DST("RORPTR"))=BUF
 ;
 ;=== Most recent result of the group
 D:LTDT>$P($G(ROR8DST("RORSTATS",GROUP,"LAST")),U,2)
 . S ROR8DST("RORSTATS",GROUP,"LAST")=LTVAL_U_LTDT
 ;
 ;=== Numeric results
 D:$$NUMERIC^RORUTL05(LTVAL)
 . ;--- Lowest result value of the group
 . S TMP=+$G(ROR8DST("RORSTATS",GROUP,"MIN"))
 . S:'TMP!(LTVAL<TMP) ROR8DST("RORSTATS",GROUP,"MIN")=LTVAL_U_LTDT
 . ;--- Highest result value of the group
 . S TMP=+$G(ROR8DST("RORSTATS",GROUP,"MAX"))
 . S:LTVAL>TMP ROR8DST("RORSTATS",GROUP,"MAX")=LTVAL_U_LTDT
 ;
 ;=== Success
 Q 0
 ;
 ;***** LOADS THE PATIENT'S REGISTRY-SPECIFIC LAB RESULTS
 ; RPC: [ROR PATIENT REGISTRY LABS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; PATIEN        IEN of the registry patient (DFN)
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, zero is returned in the @RESULTS@(0) and the
 ; subsequent nodes of the global array contain the data.
 ; 
 ; @RESULTS@(0)          0
 ;
 ; @RESULTS@(i)          Registry-specific Lab Result
 ;                         ^01: "LTR"
 ;                         ^02: Result IEN (inverted date/time)
 ;                         ^03: Date/time of the test (FileMan)
 ;                         ^04: Result
 ;                         ^05: Test IEN (in file #60)
 ;                         ^06: Test name
 ;                         ^07: Code of the group
 ;                         ^08: Group name
 ;
 ; @RESULTS@(i)          Lab Group Statistics
 ;                         ^01: "LTG"
 ;                         ^02: Code of the group
 ;                         ^03: Group name
 ;                         ^04: Latest result value
 ;                         ^05: Date of the latest result (FileMan)
 ;                         ^06: Lowest result value
 ;                         ^07: Date of the lowest value (FileMan)
 ;
LOADPRL(RESULTS,REGIEN,PATIEN) ;
 N BUF,GRP,NAME,PTR,RC,RORBUF,RORERRDL,TMP
 D CLEAR^RORERR("LOAD^RORRP041",1)
 K RESULTS  S RESULTS=$$ALLOC^RORTMP()  S @RESULTS@(0)=0
 ;
 ;=== Check the parameters
 S RC=0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 . ;--- Patient IEN
 . I $G(PATIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"PATIEN",$G(PATIEN))
 . S PATIEN=+PATIEN
 ;
 ;=== Search for registry-specific lab results
 S RORBUF=RESULTS
 S RORBUF("RORCB")="$$LOADLT^RORRP041"
 S RC=$$LTSEARCH^RORUTL10(PATIEN,+REGIEN,.RORBUF)
 I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 ;
 ;=== Store the group statistics
 S PTR=+$O(@RESULTS@(""),-1)
 S GRP=0
 F  S GRP=$O(RORBUF("RORSTATS",GRP))  Q:GRP'>0  D
 . S TMP=$$ITEMIEN^RORUTL09(3,REGIEN,GRP,.NAME)
 . S BUF="LTG"_U_GRP_U_NAME
 . S $P(BUF,U,4,5)=$G(RORBUF("RORSTATS",GRP,"LAST"))
 . S $P(BUF,U,6,7)=$G(RORBUF("RORSTATS",GRP,"MIN"))
 . S PTR=PTR+1,@RESULTS@(PTR)=BUF
 Q
