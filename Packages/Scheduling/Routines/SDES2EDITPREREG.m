SDES2EDITPREREG ;ALB/JAS,MCB,MCB - SDES2 EDIT PATIENT'S PRE-REGISTRATION ;MAY 21, 2026
 ;;5.3;Scheduling;**861,909,945**;Aug 13, 1993;Build 2
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to DUZ^XUP is supported by IA #7487
 ;
 Q
 ;
 ; RPC: SDES2 GET PATIENT MED LIST
 ;
 ; SDCONTEXT("ACHERON AUDIT ID") = 36 character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("USER DUZ")         = The DUZ of the user taking action on the calling application.
 ; SDCONTEXT("USER SECID")       = The Security ID of the user taking action on the calling application.
 ; SDCONTEXT("PATIENT DFN")      = The DFN of the Veteran/user taking action on the calling application.
 ; SDCONTEXT("PATIENT ICN")      = The ICN of the Veteran/user taking action on the calling application.
 ;
 ; PARAMS("STATUS CODE")         = The code that represents the outcome of the pre-registration interview
 ;                                 with the patient (Required)
 ; PARAMS("DFN")                 = The DFN of the pre-registration patient
 ;
EDITPREREG(JSONRETURN,SDCONTEXT,PARAMS) ; Edit Patient's Pre-Registration
 ;
 N SDERRORS,SDRESULT,SDRETURN,VALCHK
 ;newed leaking variables
 N %,D0,DA,DDER,DI,DIC,DQ,X
 ;
 ; Validate SDCONTEXT
 D VALCONTEXT^SDES2VALCONTEXT(.SDERRORS,.SDCONTEXT)
 I $D(SDERRORS) S SDERRORS("Pre-Registration")="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDERRORS) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 ;
 ; Validate PARAMS
 ;
 S VALCHK=$$VALPARAMS(.PARAMS,.SDERRORS)
 I 'VALCHK M SDRETURN=SDERRORS S SDRETURN("Pre-Registration",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN) Q
 ;
 ; Call PREREG^VPSRPC3
 ;
 D PREREG^VPSRPC3(.SDRESULT,PARAMS("DFN"),PARAMS("STATUS CODE"))
 ;
 K Y  ; Kill leaking variable from PREREG^VPSRPC3
 ;
 I '+(SDRESULT) D
 . D ERRLOG^SDES2JSON(.SDERRORS,52,"An unspecified filing error occurred in the PREREG^VPSRPC3 API")
 . S SDRETURN("Pre-Registration",1)="" M SDRETURN=SDERRORS
 I +(SDRESULT) S SDRETURN("Pre-Registration","Success")=$P(SDRESULT,",",2)
 ;
 ; Build JSON return
 ;
 D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN)
 Q
 ;
VALPARAMS(PARAMS,SDERRORS) ; Validate PARAMS array (DFN & Status Code)
 ;
 ; Validate DFN
 ;
 N VALRET
 D VALFILEIEN^SDES2VALUTIL(.VALRET,.SDERRORS,2,$G(PARAMS("DFN")),1,0,1,2)
 I 'VALRET,$D(SDERRORS) Q 0
 ;
 ; Validate Status Code
 ;
 I $G(PARAMS("STATUS CODE"))="" D  Q 0
 . D ERRLOG^SDES2JSON(.SDERRORS,514)
 I $L(PARAMS("STATUS CODE"))>1 D  Q 0
 . D ERRLOG^SDES2JSON(.SDERRORS,515)
 I "^B^C^D^K^M^N^P^T^U^V^W^X^"'[("^"_$G(PARAMS("STATUS CODE"))_"^") D  Q 0
 . D ERRLOG^SDES2JSON(.SDERRORS,515)
 Q 1
