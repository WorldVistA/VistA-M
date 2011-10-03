RORUTL14 ;HCIOFO/BH,SG - PHARMACY DATA SEARCH ; 12/13/05 2:16pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** SEARCHES THE PHARMACY DATA
 ;
 ; PATIEN        IEN of the patient (DFN)
 ;
 ; ROR8RXS       Closed root of a variable, which contains a list
 ;               of drugs of interest (in the same format as
 ;               the list returned by the $$DRUGLIST^RORUTL16).
 ;
 ;               If the "*" is passed via this parameter then all
 ;               pharmacy orders tests are considered.
 ;
 ;               If this parameter has a pure numeric value then
 ;               it is considered as registry IEN and the default
 ;               list of registry specific drugs is automatically
 ;               compiled by the $$DRUGLIST^RORUTL16 function.
 ;
 ; [[.]ROR8DST]  Closed root of an array where the data will be
 ;               returned (the ^TMP("RORUTL14",$J), by default).
 ;               The data will be stored into the destination
 ;               array in following format:
 ;
 ;                 @ROR8DST@(i,  Additional drug information
 ;                                 ^01: Order number
 ;                                 ^02: Flags describing the order:
 ;                                        I  Inpatient dose
 ;                                        O  Outpatient fill
 ;                                        P  Pending
 ;                                        V  IV
 ;                                 ^03: Generic drug IEN (file #50.6)
 ;                                 ^04: Generic drug name
 ;                                 ^05: Drug class IEN (file #50.605)
 ;                                 ^06: Drug class code
 ;                   0)          Detailed information on pharmacy
 ;                   "RXN",0)    order loaded by the OEL^PSOORRL
 ;                   ...
 ;
 ;               Example:
 ;                 S RORDST=$NA(^TMP("RORTMP",$J))
 ;                 S RC=$$RXSEARCH^RORUTL14(DFN,REGIEN,RORDST)
 ;
 ;               If this parameter is passed by reference, you can
 ;               provide a full name ($$TAG^ROUTINE) of the callback
 ;               function, which will process and store the results,
 ;               as the value of the "RORCB" node.
 ;
 ;               Any additional nodes created in this variable will
 ;               be accessible in the callback function. The following
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
 ;                 "RORXGEN"     Generic drug
 ;                                 ^01: Drug IEN in file #50.6
 ;                                 ^02: Generic drug name
 ;
 ;                 "RORXVCL"     VA Drug class
 ;                                 ^01: Class IEN in file #50.605
 ;                                 ^02: Class code
 ;
 ;               The callback function must accept 5 parameters:
 ;
 ;                 .ROR8DST      Reference to the ROR8DST parameter
 ;                               passed into the $$RXSEARCH function.
 ;
 ;                 ORDER         Order number (from condensed list)
 ;
 ;                 FLAGS         Flags describing the order to be
 ;                               processed.
 ;
 ;                 DRUG          Dispensed drug
 ;                                 ^01: Drug IEN in file #50
 ;                                 ^02: Drug name
 ;
 ;                 DATE          Order date (issue date for outpatient
 ;                               drugs or start date for inpatient)
 ;
 ;               The ^TMP("PS",$J) global node contains the data
 ;               returned by the OEL^PSOORRL procedure (see the
 ;               DBIA #2400 for details).
 ;
 ;               The callback function is called for each additive
 ;               included in the IV order; the ^TMP("PS",$J) is
 ;               loaded once and stays the same for all of them.
 ;
 ;               The function should return the following values:
 ;
 ;                 <0  Error code (the search will be aborted)
 ;                  0  Ok
 ;                  1  Skip this pharmacy order
 ;                  2  Skip this and all remaining orders
 ;
 ;               Example:
 ;                 S RORDST=$NA(^TMP("RORBUF",$J))
 ;                 S RORDST("RORPTR")=+$O(@RORDST@(""),-1)
 ;                 S RORDST("RORCB")="$$RXCB^RORUT999"
 ;                 S RC=$$RXSEARCH^RORUTL14(DFN,REGIEN,.RORDST)
 ;
 ; [RORFLAGS]    Flags to control processing:
 ;                 E  Load external values for additional fields
 ;                    stored into the output array or passed to
 ;                    the callback function. Affected fields
 ;                    have the (E) marker.
 ;                 I  Include inpatient doses
 ;                 O  Include outpatient fills
 ;                 P  Include pending orders
 ;                 V  Include IV
 ;
 ;               If this parameter has no value ($G(RORFLAGS)="")
 ;               then the default set of flags is used: "IO".
 ;
 ; RORSDT        Start date (FileMan)
 ; [ROREDT]      End date   (FileMan)
 ;
 ;               The search is performed exactly between provided
 ;               boundaries (the time parts are considered).
 ;
 ; The following global nodes are used by the function:
 ;
 ; ^TMP("PS",$J)         The OCL^PSOORRL and OEL^PSOORRL procedures
 ;                       return the results into this node.
 ;
 ; ^TMP("RORUTL14",$J)   If the name of the destination array is
 ;                       not provided via the ROR8DST parameter
 ;                       then the $$RXSEARCH returns the results
 ;                       under this node.
 ;
 ; ^TMP("RORUTL14L",$J)  If the ROR8RXS parameter is undefined
 ;                       then a temporary list of registry specific
 ;                       drugs is compiled under this node.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  No ordes have been found
 ;       >0  Number of pharmacy orders
 ;
RXSEARCH(PATIEN,ROR8RXS,ROR8DST,RORFLAGS,RORSDT,ROREDT) ;
 N RC,ROR8SET,RORXLST,TMP
 S:$G(ROR8DST)="" ROR8DST=$NA(^TMP("RORUTL14",$J))
 S RORFLAGS=$S($G(RORFLAGS)'="":RORFLAGS,1:"IO")
 Q:$TR(RORFLAGS,"IO")=RORFLAGS 0  ; Neither Inpatient nor Outpatient
 Q:$G(ROR8RXS)="" 0               ; No drugs to search for
 ;---
 S:$G(ROREDT)'>0 ROREDT=DT
 S RORXLST=$$ALLOC^RORTMP(),RC=0
 ;
 D
 . ;--- Prepare the list of drugs of interest
 . I (+ROR8RXS)=ROR8RXS  D  Q:RC'>0
 . . S TMP=ROR8RXS,ROR8RXS=$$ALLOC^RORTMP()
 . . S RC=$$DRUGLIST^RORUTL16(ROR8RXS,TMP)
 . I ROR8RXS'="*",$D(@ROR8RXS)<10  S RC=0  Q
 . ;--- Preselect pharmacy orders
 . S RC=$$QUERY^RORUTL15(PATIEN,RORFLAGS,RORSDT,ROREDT,RORXLST)
 . Q:RC'>0
 . ;--- Process selected orders
 . S RC=$$PROCESS^RORUTL15(PATIEN,RORFLAGS,RORXLST)
 . Q:RC'>0
 ;
 ;--- Cleanup
 D POP^RORTMP(RORXLST)
 Q RC
