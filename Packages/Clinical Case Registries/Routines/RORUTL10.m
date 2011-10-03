RORUTL10 ;HCIOFO/SG - LAB DATA SEARCH ; 10/14/05 3:29pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #91           Read access to the file #60
 ; #554          Read access to the file #63
 ; #998          Laboratory reference from file #2
 ;
 Q
 ;
 ;***** LOADS THE LIST OF TESTS FROM THE REGISTRY PARAMETERS
 ;
 ; ROR8LTST      Closed root of a variable, which will contain
 ;               a list of lab tests of interest:
 ;
 ;               @ROR8LTST@(ResultNode,TestIEN)
 ;                 ^01: Test IEN (in file #60)
 ;                 ^02: Test name
 ;                 ^03: Code of the group
 ;                 ^04: Group name
 ;                 ^05: Location subscript
 ;                 ^06: Result node
 ;
 ; REGIEN        Registry IEN
 ;
 ; [GROUPS]      List of codes (separated by commas) of Lab Groups
 ;               to load (1 - CD4, 2 - CD4 %, 3 - Viral Load).
 ;               If this parameter is undefined or empty then all
 ;               tests will be loaded.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  No tests are defined
 ;       >0  Number of the tests
 ;
LOADTSTS(ROR8LTST,REGIEN,GROUPS) ;
 N BUF,CNT,GRIEN,I,IEN,IENS,LTIEN,LTNODE,NAME,NODE,RC,RGIENS,RORBUF,RORMSG,TMP
 S RC=0,RGIENS=","_(+REGIEN)_","  K @ROR8LTST
 S NODE=$$ROOT^DILFD(798.128,RGIENS,1)
 ;--- List of Group IEN's
 S GROUPS=$TR($G(GROUPS)," ")
 D:GROUPS'=""
 . F I=1:1  S TMP=$P(GROUPS,",",I)  Q:TMP'>0  D
 . . S TMP=$$ITEMIEN^RORUTL09(3,REGIEN,TMP)
 . . S:TMP>0 GRIEN(TMP)=""
 ;---
 S (CNT,IEN)=0
 F  S IEN=$O(@NODE@(IEN))  Q:IEN'>0  D  Q:RC<0
 . K RORBUF  S BUF=""
 . ;--- Load the local test reference
 . S IENS=IEN_RGIENS
 . D GETS^DIQ(798.128,IENS,".01;.02","I","RORBUF","RORMSG")
 . I $G(DIERR)  D  Q
 . . S RC=$$DBS^RORERR("RORMSG",-9,,,798.128,IENS)
 . S (BUF,LTIEN)=+$G(RORBUF(798.128,IENS,.01,"I"))
 . Q:LTIEN'>0
 . ;--- Check the Lab Group
 . S GRIEN=+$G(RORBUF(798.128,IENS,.02,"I"))
 . I $D(GRIEN)>1  Q:'$D(GRIEN(GRIEN))
 . I GRIEN>0  D  Q:RC<0
 . . S TMP=$$ITEMCODE^RORUTL09(GRIEN,.NAME)
 . . I TMP'>0  S:TMP<0 RC=+TMP  Q
 . . S $P(BUF,U,3,4)=TMP_U_NAME  ; Code and name of the group
 . ;--- Load the lab test parameters
 . S IENS=LTIEN_","
 . D GETS^DIQ(60,IENS,".01;5","EI","RORBUF","RORMSG")
 . I $G(DIERR)  D  Q
 . . S RC=$$DBS^RORERR("RORMSG",-9,,,60,IENS)
 . S LTNODE=$P($G(RORBUF(60,IENS,5,"I")),";",2)
 . Q:LTNODE=""
 . S TMP=$G(RORBUF(60,IENS,.01,"E"))             ; Name of the test
 . S $P(BUF,U,2)=$S(TMP'="":TMP,1:"Unknown ("_LTIEN_")")
 . S $P(BUF,U,5)=$P(RORBUF(60,IENS,5,"I"),";",1) ; Subscript
 . S $P(BUF,U,6)=$P(RORBUF(60,IENS,5,"I"),";",2) ; Result node
 . ;--- Create the reference
 . S @ROR8LTST@(LTNODE,LTIEN)=BUF,CNT=CNT+1
 ;---
 Q $S(RC<0:RC,1:CNT)
 ;
 ;***** SEARCHES THE LAB DATA FOR REGISTRY SPECIFIC RESULTS
 ;
 ; PATIEN        IEN of the patient (DFN)
 ;
 ; ROR8LT        Closed root of a variable, which contains a list
 ;               of lab tests of interest (in the same format as
 ;               the list returned by the $$LOADTSTS^RORUTL10).
 ;
 ;               If the "*" is passed via this parameter then all
 ;               lab tests are considered.
 ;
 ;               If this parameter has a pure numeric value then
 ;               it is considered as registry IEN and the default
 ;               list of registry specific tests is automatically
 ;               compiled by the $$LOADTSTS^RORUTL10 function.
 ;
 ; [[.]ROR8DST]  Closed root of an array where the results will be
 ;               returned (the ^TMP("RORUTL10",$J), by default).
 ;               The results will be stored into the destination
 ;               array in following format:
 ;
 ;                 @ROR8DST@(i,
 ;                   1)  Result Descriptor
 ;                         ^01: IEN in the file #63 (inverted date)
 ;                         ^02: Date of the test (FileMan)
 ;                         ^03: Result
 ;                   2)  Test Descriptor
 ;                         ^01: Test IEN (in the file #60)
 ;                         ^02: Test name
 ;                         ^03: Code of the group
 ;                         ^04: Group name
 ;                         ^05: Location subscript
 ;                         ^06: Result node
 ;
 ;               Example:
 ;                 S RC=$$LTSEARCH^RORUTL10(DFN,REGIEN,"RORBUF")
 ;
 ;               If this parameter is passed by reference, you can
 ;               provide a full name ($$TAG^ROUTINE) of the callback
 ;               function, which will process and store the results,
 ;               as the value of the "RORCB" node.
 ;
 ;               Any additional nodes created in this variable will
 ;               be accessible in the callback function. Several
 ;               nodes are created automatically:
 ;
 ;                 "RORDFN"      IEN of the registry patient (DFN)
 ;
 ;                 "ROREDT"      End date
 ;
 ;                 "RORFLAGS"    Value of parameter of the same name
 ;
 ;                 "RORSDT"      Start date
 ;
 ;               The callback function must accept 3 parameters:
 ;
 ;                 .ROR8DST      Reference to the ROR8DST parameter.
 ;
 ;                 INVDT         IEN of the Lab test (inverted date)
 ;
 ;                 .RESULT       Reference to a local variable,
 ;                               which contains the result in the
 ;                               same format as it is stored into
 ;                               the destination array by default.
 ;
 ;               The function should return the following values:
 ;
 ;                 <0  Error code (the search will be aborted)
 ;                  0  Ok
 ;                  1  Skip this result
 ;                  2  Skip this and all remaining results
 ;
 ;               Example:
 ;                 S RORDST=$NA(^TMP("RORBUF",$J))
 ;                 S RORDST("RORPTR")=+$O(@RORDST@(""),-1)
 ;                 S RORDST("RORCB")="$$LTCB^RORUT999"
 ;                 S RC=$$LTSEARCH^RORUTL10(DFN,REGIEN,.RORDST)
 ;
 ; [RORFLAGS]    Flags to control processing (reserved)
 ;
 ; [STDT]        Start date (FileMan)
 ; [ENDT]        End date   (FileMan)
 ;
 ;               The search is performed exactly between provided
 ;               boundaries (the time parts are considered).
 ;
 ; The ^TMP("RORUTL10",$J) global node is used by this function.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  No results have been found
 ;       >0  Number of results
 ;
LTSEARCH(PATIEN,ROR8LT,ROR8DST,RORFLAGS,STDT,ENDT) ;
 N BUF,CNT,EXIT,GRC,ILDT,LTDT,LTFREE,LTIEN,LTLOC,LTNODE,LTRES,RC,ROR8SET,RORLR,RORMSG,TMP
 S:$G(ROR8DST)="" ROR8DST=$NA(^TMP("RORUTL10",$J))
 Q:$G(ROR8LT)="" 0  ; No Lab tests to search for
 S RORFLAGS=$G(RORFLAGS),(LTFREE,RC)=0
 ;
 ;--- Determine the storage method (default or callback)
 I $G(ROR8DST("RORCB"))?2"$"1.8UN1"^"1.8UN  D  Q:RC<0 RC
 . S ROR8SET="S RC="_ROR8DST("RORCB")_"(.ROR8DST,ILDT,.BUF)"
 . S ROR8DST("RORDFN")=PATIEN
 . S ROR8DST("ROREDT")=$G(ENDT)
 . S ROR8DST("RORFLAGS")=RORFLAGS
 . S ROR8DST("RORSDT")=$G(STDT)
 E  S ROR8SET=""  K @ROR8DST
 ;
 ;--- Get the Lab reference
 S RORLR=$P($G(^DPT(PATIEN,"LR")),U)  Q:RORLR'>0 0
 ;
 ;--- Prepare the list of tests of interest
 I (+ROR8LT)=ROR8LT  D  Q:RC'>0 RC
 . S TMP=+ROR8LT,ROR8LT=$$ALLOC^RORTMP(),LTFREE=1
 . S RC=$$LOADTSTS(ROR8LT,TMP)
 I ROR8LT'="*",$D(@ROR8LT)<10  Q 0
 ;
 ;--- Search the Lab data
 S STDT=$$INVDATE^RORUTL01($S($G(STDT)>0:STDT,1:0))
 S ILDT=$S($G(ENDT)>0:$$INVDATE^RORUTL01(ENDT),1:0)
 S (CNT,RC)=0
 F  S ILDT=$O(^LR(RORLR,"CH",ILDT))  Q:(ILDT'>0)!(ILDT>STDT)  D  Q:RC
 . S LTNODE=1
 . F  S LTNODE=$O(^LR(RORLR,"CH",ILDT,LTNODE))  Q:LTNODE=""  D  Q:RC
 . . S LTRES=$P($G(^LR(RORLR,"CH",ILDT,LTNODE)),U)
 . . Q:LTRES=""    ; Skip empty results
 . . S TMP=$$UP^XLFSTR(LTRES)
 . . Q:TMP["CANC"  ; Skip cancelled tests
 . . S LTDT=$P($G(^LR(RORLR,"CH",ILDT,0)),U)
 . . ;--- Only selected tests
 . . I ROR8LT'="*"  D  Q
 . . . S LTIEN=""
 . . . F  S LTIEN=$O(@ROR8LT@(LTNODE,LTIEN))  Q:LTIEN=""  D  Q:RC
 . . . . S GRC=$P(@ROR8LT@(LTNODE,LTIEN),U,3)  Q:GRC'>0
 . . . . K BUF
 . . . . S BUF(1)=ILDT_U_LTDT_U_LTRES
 . . . . S BUF(2)=@ROR8LT@(LTNODE,LTIEN)
 . . . . ;--- Default output
 . . . . I ROR8SET=""  S CNT=CNT+1  M @ROR8DST@(CNT)=BUF  Q
 . . . . ;--- Callback function
 . . . . X ROR8SET
 . . . . I RC  S:RC=1 RC=0  Q
 . . . . S CNT=CNT+1
 . . ;--- Consider all tests
 . . S LTLOC="CH;"_LTNODE_";1",LTIEN=""
 . . F  S LTIEN=$O(^LAB(60,"C",LTLOC,LTIEN))  Q:LTIEN=""  D  Q:RC
 . . . K BUF
 . . . S BUF(1)=ILDT_U_LTDT_U_LTRES
 . . . S TMP=$$GET1^DIQ(60,LTIEN,.01,,,"RORMSG")
 . . . S BUF(2)=LTIEN_U_$S(TMP'="":TMP,1:"Unknown ("_LTIEN_")")
 . . . S $P(BUF(2),U,5,6)="CH"_U_LTNODE
 . . . ;--- Default output
 . . . I ROR8SET=""  S CNT=CNT+1  M @ROR8DST@(CNT)=BUF  Q
 . . . ;--- Callback function
 . . . X ROR8SET
 . . . I RC  S:RC=1 RC=0  Q
 . . . S CNT=CNT+1
 ;
 ;--- Cleanup
 D:LTFREE FREE^RORTMP(ROR8LT)
 Q $S(RC<0:RC,1:CNT)
