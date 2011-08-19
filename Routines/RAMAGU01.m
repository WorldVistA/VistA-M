RAMAGU01 ;HCIOFO/SG - ORDERS/EXAMS API (RAMISC UTILITIES) ; 3/13/08 11:54am
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;***** LOADS DEFINITIONS OF MISCELLANEOUS PARAMETERS
 ;
 ; .MSPSDEFS     Reference to a local variable where descriptors
 ;               of the miscellaneous parameters are loaded to
 ;               (see description of the RAMSPSDEFS in the ^RAMAG
 ;               routine for details).
 ;
LDMSPRMS(MSPSDEFS) ;
 N BUF,FILE,I,NAME
 K MSPSDEFS
 F I=4:1  S BUF=$P($T(MSCPRMS+I),";;",2)  Q:BUF=""  D
 . S BUF=$P($TR(BUF,"| ",U),U,2,99)
 . S NAME=$P(BUF,U,1)  Q:NAME=""
 . S FILE=$P(BUF,U,2)  Q:FILE'>0
 . S MSPSDEFS("N",NAME)=$P(BUF,U,2,5)
 . S:$P(BUF,U,4)["*" MSPSDEFS("F",FILE,NAME)=""
 Q
 ;
MSCPRMS ;+++++ DEFINITIONS OF MISCELLANEOUS PARAMETERS
 ;;==========================================================
 ;;| Parameter  | File  |Field|Type |Req#|    Reference     |
 ;;|------------+-------+-----+-----+----+------------------|
 ;;|ACLHIST     |74     | 400 | W   |    |$$COMPLETE^RAMAG06|
 ;;|BEDSECT     |70.03  |  19 | P   |    |$$REGISTER^RAMAG03|
 ;;|CLINHIST    |70.03  | 400 | W   |    |$$REGISTER^RAMAG03|
 ;;|CMUSED      |70.03  |  10 |     |    |$$EXAMINED^RAMAG07|
 ;;|COMPLICAT   |70.03  |  16 | P   |    |$$EXAMINED^RAMAG07|
 ;;|CONTMEDIA   |70.3225| .01 |  M  |    |$$EXAMINED^RAMAG07|
 ;;|CPTMODS     |70.3135| .01 | PM  | 14 |$$EXAMINED^RAMAG07|
 ;;|EXAMCAT     |70.03  |   4 |     |    |$$REGISTER^RAMAG03|
 ;;|FILMSIZE    |70.04  | .01 | PM  |  4 |$$REGISTER^RAMAG03|
 ;;|FLAGS       |       |     |     |    |          ^RAMAG  |
 ;;|HOLDESC     |75.1   |  25 | W   |    | $$ORDCANC^RAMAG04|
 ;;|IMPRESSION  |74     | 300 | W   | 16 |$$COMPLETE^RAMAG06|
 ;;|ISOLPROC    |75.1   |  24 |     |    |   $$ORDER^RAMAG02|
 ;;|PREGNANT    |75.1   |  13 |     |    |   $$ORDER^RAMAG02|
 ;;|PREOPDT     |75.1   |  12 | D   |    |   $$ORDER^RAMAG02|
 ;;|PRIMCAM     |70.03  |  18 | P   |  6 |$$EXAMINED^RAMAG07|
 ;;|PRIMDXCODE  |70.03  |  13 | P   |  5 |$$EXAMINED^RAMAG07|
 ;;|PRIMINTRES  |70.03  |  12 | P   |  2 |$$EXAMINED^RAMAG07|
 ;;|PRIMINTSTF  |70.03  |  15 | P   |  2 |$$EXAMINED^RAMAG07|
 ;;|PRINCLIN    |70.03  |   8 | P   |    |$$REGISTER^RAMAG03|
 ;;|PROBSTAT    |74     |  25 |     |    |$$COMPLETE^RAMAG06|
 ;;|RAPROC      |70.03  |   2 |     |    |$$REGISTER^RAMAG03|
 ;;|RDPHARMS    |70.21  |     |  M  | 17 |$$EXAMINED^RAMAG07|
 ;;|  RDPH-ACDR |70.21  |   4 |   * | 19 |$$EXAMINED^RAMAG07|
 ;;|  RDPH-DOSE |70.21  |   7 |   * | 17 |$$EXAMINED^RAMAG07|
 ;;|  RDPH-DRUG |70.21  | .01 | P * | 17 |$$EXAMINED^RAMAG07|
 ;;|  RDPH-DTADM|70.21  |   8 | D * | 21 |$$EXAMINED^RAMAG07|
 ;;|  RDPH-DTDRW|70.21  |   5 | D * | 19 |$$EXAMINED^RAMAG07|
 ;;|  RDPH-FORM |70.21  |  15 |   * | 25 |$$EXAMINED^RAMAG07|
 ;;|  RDPH-LOTN |70.21  |  13 | P * | 24 |$$EXAMINED^RAMAG07|
 ;;|  RDPH-PWADM|70.21  |   9 | P * | 21 |$$EXAMINED^RAMAG07|
 ;;|  RDPH-PWMSD|70.21  |   6 | P * | 19 |$$EXAMINED^RAMAG07|
 ;;|  RDPH-ROUTE|70.21  |  11 | P * | 23 |$$EXAMINED^RAMAG07|
 ;;|  RDPH-SITE |70.21  |  12 | P * | 23 |$$EXAMINED^RAMAG07|
 ;;|  RDPH-VOL  |70.21  |  14 |   * | 25 |$$EXAMINED^RAMAG07|
 ;;|REPORT      |74     | 200 | W   | 11 |$$COMPLETE^RAMAG06|
 ;;|REQNATURE   |75.1   |  26 |     |    |   $$ORDER^RAMAG02|
 ;;|REQURG      |75.1   |   6 |     |    |   $$ORDER^RAMAG02|
 ;;|RPTDTE      |74     |   8 | D   |    |$$COMPLETE^RAMAG06|
 ;;|RPTSTATUS   |74     |   5 |     |    |$$COMPLETE^RAMAG06|
 ;;|SERVICE     |70.03  |   7 | P   |    |$$REGISTER^RAMAG03|
 ;;|SINGLERPT   |70.03  |  25 |     |    |$$REGISTER^RAMAG03|
 ;;|TECH        |70.12  | .01 | PM  |  1 |$$EXAMINED^RAMAG07|
 ;;|TECHCOMM    |70.07  |   4 |     |    |$$REGISTER^RAMAG03|
 ;;|TRANSCRST   |74     |  11 | P   |    |$$COMPLETE^RAMAG06|
 ;;|TRANSPMODE  |75.1   |  19 |     |    |   $$ORDER^RAMAG02|
 ;;|VERDTE      |74     |   7 | D   |    |$$COMPLETE^RAMAG06|
 ;;|VERPHYS     |74     |   9 | P   |    |$$COMPLETE^RAMAG06|
 ;;|WARD        |70.03  |   6 | P   |    |$$REGISTER^RAMAG03|
 ;;==========================================================
 ;
 ; Type          Field type that requires special processing:
 ;                 D - Date/time, M - Multiple,
 ;                 P - Pointer,   W - Word processing,
 ;                 * - Add this parameter to the "F" index
 ;                     (see the VEXAMND^RAMAGU14 for details).
 ;
 ; Req#          Number of the "^"-piece of the value returned by the
 ;               $$EXMSTREQ^RAMAGU06. It determines if a non-empty
 ;               field value is required.
 ;
 ; Reference     Indicates where the parameter is described for the
 ;               first time.
 ;   
 ; NOTE #1: This table is here not only for documentation purposes;
 ;          the data is processed by the LDMSPRMS^RAMAGU01 procedure.
 ;
 ; NOTE #2: If a parameter does not have the corresponding field
 ;          and has the "M" flag, then this is a record tag (e.g.
 ;          RDPHARMS). It encloses other parameters that define
 ;          field values for a record of the sub-file.
 ;
 Q
 ;
 ;***** PARSES RAMSC RECORDS (RPC) INTO RAMISC SUBSCRIPTS (API)
 ;
 ; .RAMSC        Reference to the RAMSC parameter of a remote
 ;               procedure.
 ;
 ; .RAMISC       Reference to a local variable that will store
 ;               miscellaneous parameters as subscripts (for API
 ;               functions).
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Success
 ;
RPCMISC(RAMSC,RAMISC) ;
 N RAMSPSDEFS,RASRCI,RC
 K RAMISC  S RASRCI=""
 D LDMSPRMS(.RAMSPSDEFS)
 S RC=$$RPCMISC1("RAMISC")
 Q $S(RC>0:$$ERROR^RAERR(-5),1:RC)
 ;
 ;+++++ RECURSIVE PARSER OF RAMSC RECORDS
 ;
 ; DSTNODE       Node of the RAMISC where values will be stored.
 ;
 ; [RECNAME]     Tag name and index of the current record. They are
 ; [RECNDX]      used to detect the record boundaries.
 ;
 ; Input Variables:
 ;   RAMSC, RAMSPSDEFS, RASRCI
 ;
 ; Output Variables:
 ;   RAMISC, RASRCI
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Success
 ;       >0  Number of validation errors
 ;
 ; NOTE: This is an internal entry point. Do not call
 ;       it from outside of this routine.
 ;
RPCMISC1(DSTNODE,RECNAME,RECNDX) ;
 N ERRCNT,NAME,NDX,RARC,TMP,TYPE
 S (ERRCNT,RARC)=0
 ;===
 F  S RASRCI=$O(RAMSC(RASRCI))  Q:RASRCI=""  D  Q:RARC
 . S NAME=$$TRIM^XLFSTR($P(RAMSC(RASRCI),U))  Q:NAME=""
 . S NDX=+$$TRIM^XLFSTR($P(RAMSC(RASRCI),U,2))
 . S TYPE=$P($G(RAMSPSDEFS("N",NAME)),U,3)
 . ;=== Single value
 . I NDX'>0  D  Q
 . . I $D(@DSTNODE@(NAME))#10  D  S ERRCNT=ERRCNT+1  Q
 . . . D ERROR^RAERR(-6,,NAME)
 . . ;--- Convert date/time value from HL7 (TS) to FileMan
 . . I TYPE["D"  D  Q
 . . . S @DSTNODE@(NAME)=$$HL7TFM^XLFDT($P(RAMSC(RASRCI),U,3))
 . . . I @DSTNODE@(NAME)<0  D  S ERRCNT=ERRCNT+1
 . . . . S TMP=$NA(@DSTNODE@(NAME))
 . . . . D ERROR^RAERR(-3,TMP_"='"_$P(RAMSC(RASRCI),U,3)_"'",TMP)
 . . ;--- Copy parameters of other types
 . . S @DSTNODE@(NAME)=$P(RAMSC(RASRCI),U,3,999)
 . ;=== Check for duplicate indexes
 . I $D(@DSTNODE@(NAME,NDX))  D  S ERRCNT=ERRCNT+1  Q
 . . D ERROR^RAERR(-7,,NDX,NAME)
 . ;=== Check for record start/end
 . I (TYPE["M"),$P($G(RAMSPSDEFS("N",NAME)),U,2)'>0  D  Q
 . . ;--- If the name is the same as that of the current record, then
 . . ;    this either the end of the current record or a beginning of
 . . ;--- the next record of the same kind (and on the same level).
 . . I NAME=$G(RECNAME)  D:NDX'=$G(RECNDX)  S RARC=1  Q
 . . . ;--- If the index is different from that of the current record,
 . . . ;    then this is a beginning of the next record. Let the
 . . . ;--- source line be re-processed on the upper execution level.
 . . . S RASRCI=$O(RAMSC(RASRCI),-1)
 . . ;--- Start processing field values of the record
 . . S TMP=$$RPCMISC1($NA(@DSTNODE@(NAME,NDX)),NAME,NDX)
 . . I TMP<0  S RARC=TMP  Q
 . . S:TMP>0 ERRCNT=ERRCNT+TMP
 . . S:RASRCI="" RARC=1
 . ;=== List item or text line
 . S @DSTNODE@(NAME,NDX)=$P(RAMSC(RASRCI),U,3,999)
 ;===
 Q $S(RARC<0:RARC,1:ERRCNT)
