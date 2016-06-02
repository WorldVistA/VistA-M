IBCNICB ;ALB/SBW - Update utilities for the ICB interface ;1 SEP 2009
 ;;2.0;INTEGRATED BILLING;**413,416,528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
ACCEPAPI(RESULT,IBBUFDA,DFN,IBINSDA,IBGRPDA,IBPOLDA,IBMVINS,IBMVGRP,IBMVPOL,IBNEWINS,IBNEWGRP,IBNEWPOL,IVMREPTR,IBELIG) ;
 ;Provides API to be called by the Insurance Capture Buffer (ICB) 
 ;application to move buffer data in Insurance Files then cleanup
 ;
 ;The call to PROCESS^IBCNBAR and embedded Sub calls are updated to 
 ;provide data in the RESULT parameter and suppress user I/O when 
 ;function is called by ICB.
 ;Input
 ;  IBBUFDA  - INSURANCE BUFFER (#355.33) file internal entry number
 ;             (IEN) (Required)
 ;  DFN      - PATIENT (#2) file IEN (Required)
 ;  IBINSDA  - INSURANCE COMPANY (#36) File IEN if not adding new entry
 ;             (Optional)
 ;  IBGRPDA  - GROUP INSURANCE PLAN (#355.3) File IEN if not adding new
 ;             entry (Optional)
 ;  IBPOLDA  - INSURANCE TYPE (#2.312) sub-file of PATIENT (#2) IEN if
 ;             not adding new entry (Optional)
 ;  IBMVINS  - Type for INSURANCE (Required)
 ;     1=Merge, 2=Overwrite, 3=Replace, 4=Unsupported
 ;  IBMVGRP  - Type for GROUP (Optional)
 ;     1=Merge, 2=Overwrite, 3=Replace, 4=Unsupported
 ;  IBMVPOL  - Type for POLICY (Optional)
 ;     1=Merge, 2=Overwrite, 3=Replace, 4=Unsupported
 ;  IBNEWINS - Add new INSURANCE COMPANY flag (non-zero means add)
 ;  IBNEWGRP - Add new GROUP INSURANCE PLAN flag (non-zero means add)
 ;  IBNEWPOL - Add new patient insurance policy (non-zero means add)
 ;  IVMREPTR - IVM REASONS FOR NOT UPLOADING (#301.91) IEN (Optional)
 ;
 ;OUTPUT
 ;  RESULT   - Returned Parameter Array with IENS of new entries and/or 
 ;             errors/warning.
 ;     RESULT(0) = -1^error message
 ;     RESULT(0) =   0           -Move worked
 ;     RESULT(0) =   0 ^ warning message ^ warning message ^ 
 ;                   warning message ^ warning message
 ;             - Move worked but there may be zero to 4 warning messages
 ;     RESULT(1) = "IBINSDA^" IEN of new Insurance Company (#36) File
 ;     RESULT(1,"ERR",#) - Array with any FM errors when data updated
 ;                         from file 355.33 to 36.
 ;     RESULT(2) = "IBGRPDA^" IEN of new GROUP INSURANCE PLAN (#355.3)
 ;                            File
 ;     RESULT(2,"ERR",#) - Array with any FM errors when data updated
 ;                         from file 355.33 to 355.3.
 ;     RESULT(3) = "IBPOLDA^" IEN of new INSURANCE TYPE (#2.312) sub-file
 ;                  of PATIENT (#2) IEN
 ;     RESULT(3,"ERR",#) - Array with any FM errors when data updated
 ;                         from file 355.33 to 2.312.
 ;     RESULT(4) Contains the results of the call to UPDPOL^IBCNICB which
 ;               is used to update a new group into an existing patient
 ;               policy entry when applicable.
 ;     RESULT(4) =-1^error message      
 ;     RESULT(4) =0 ^ message that process was successful or not required
 ;
 N IBSUPRES,IBUFSTAT,IBX
 I '$D(IBELIG) S IBELIG=0
 ;Set IBSUPRES to suppress screen I/O within ACCEPT
 S IBSUPRES=1,IBUFSTAT=$P($G(^IBA(355.33,$G(IBBUFDA),0)),U,4)
 ;
 S RESULT(0)="-1^INSURANCE BUFFER (#355.33) IEN required" Q:'$G(IBBUFDA)
 S RESULT(0)="-1^INSURANCE BUFFER ENTRY PREVIOUSLY PROCESSED"
 Q:"~A~R~"[("~"_IBUFSTAT_"~")
 S RESULT(0)="-1^INSURANCE BUFFER ENTRY STATUS SHOULD BE ENTERED"
 Q:IBUFSTAT'="E"
 S RESULT(0)="-1^PATIENT (#2) IEN required" Q:'$G(DFN)
 S IBINSDA=$G(IBINSDA),IBGRPDA=$G(IBGRPDA),IBPOLDA=$G(IBPOLDA)
 S IBMVINS=$G(IBMVINS,2),IBMVGRP=$G(IBMVGRP,2),IBMVPOL=$G(IBMVPOL,2)
 S IBNEWINS=$G(IBNEWINS),IBNEWGRP=$G(IBNEWGRP),IBNEWPOL=$G(IBNEWPOL)
 ;
 S RESULT(0)="-1^Passed INSURANCE COMPANY (#36) entry doesn't exist"
 I +IBINSDA,$G(^DIC(36,IBINSDA,0))="" Q
 S RESULT(0)="-1^Passed GROUP INSURANCE PLAN (#355.3) entry doesn't exist"
 I +IBGRPDA,$G(^IBA(355.3,IBGRPDA,0))="" Q
 S RESULT(0)="-1^Passed Patient INSURANCE TYPE (#2.312) entry doesn't exist"
 I +IBPOLDA,$G(^DPT(DFN,.312,IBPOLDA,0))="" Q
 S RESULT(0)="-1^Passed GROUP INSURANCE PLAN (#355.3) entry points to different INSURANCE COMPANY (#36) entry"
 I +IBGRPDA,+IBINSDA,+$G(^IBA(355.3,IBGRPDA,0))'=IBINSDA Q
 S RESULT(0)="-1^Individual Policy Patient required to be Patient DFN when Group Insurance Plan is not Group Policy"
 I +IBGRPDA S IBX=$G(^IBA(355.3,IBGRPDA,0)) I $P(IBX,U,2)=0,+$P(IBX,U,10),$P(IBX,U,10)'=DFN Q
 ;
 ;If existing GROUP INSURANCE PLAN (#355.3) entry is being changed from 
 ;a group plan to individual plan with other subscribers, send error 
 ;message and abort update
 S RESULT(0)="-1^Can't change GROUP INSURANCE PLAN from Group Plan to Individual Plan when there are subscribers"
 I +IBGRPDA,$P(IBX,U,2)=1,$P($G(^IBA(355.33,+$G(IBBUFDA),40)),U,1)'=1,$$SUBS^IBCNSJ(IBINSDA,IBGRPDA)>1 Q
 ;
 D PROCESS^IBCNBAR
 Q
 ;
REJECAPI(RESULT,IBBUFDA,IVMREPTR) ;
 ;Provides API to be called by the Insurance Capture Buffer (ICB) 
 ;application to reject buffer entry.
 ;The REJPROC^IBCNBAR call and embedded Sub calls are updated to 
 ;provide data in the RESULT parameter and suppress I/O when function 
 ;is called by ICB.
 ;Input:
 ;   IBBUFDA  - INSURANCE BUFFER (#355.33) file internal entry number
 ;              (required)
 ;   IVMREPTR - IVM REASONS FOR NOT UPLOADING (#301.91) File internal
 ;              internal entry number (Optional)
 ;Output:
 ;   RESULT   - Returned parameter variable with errors messages if
 ;              problems with the reject processing. Format:
 ;     REJECT = -1 ^ error message
 ;     REJECT =  0                     - Reject worked
 ;     REJECT =  0 ^ warning message   - Reject process worked but there
 ;                                       is a warning message
 ;
 N IBSUPRES
 ;Set IBSUPRES to suppress screen I/O within REJECT
 S IBSUPRES=1
 S RESULT="-1^INSURANCE BUFFER IEN required" Q:'$G(IBBUFDA)
 S RESULT="-1^INSURANCE BUFFER ENTRY PREVIOUSLY PROCESSED"
 Q:"~A~R~"[("~"_$$GET1^DIQ(355.33,IBBUFDA,.04,"I")_"~")
 D REJPROC^IBCNBAR
 Q
 ;
UPDTICB(RESULT,DFN,IBPOLDA,IBGRPDA,IBPOLCOM,IBPOLBIL,IBPLAN,IBELEC,IBGPCOM,IBFTF,IBFTFVAL) ;
 ;Updates additional fields for ICB Interface
 ;
 ;Input:
 ;  DFN      - PATIENT (#2) file IEN (Required)
 ;  IBGRPDA  - GROUP INSURANCE PLAN (#355.3) File IEN (Optional)
 ;  IBPOLDA  - INSURANCE TYPE (#2.312) sub-file of PATIENT (#2) IEN 
 ;             (Optional)
 ;  IBPOLCOM - Data to be filed into the COMMENT - SUBSCRIBER POLICY 
 ;              MULTIPLE (2.312, 1.18) optional
 ;  IBPOLBIL - Data to be filed into the POLICY NOT BILLABLE  (#3.04)
 ;             field of the 2.312 sub-file. (Optional)
 ;             Corresponds to the Internal codes in 3.04 field of 
 ;             2.312 sub-file: '0' FOR NO; '1' FOR YES;
 ;  IBPLAN   - Data to be filed in PLAN FILING TIME FRAME (#.13) field 
 ;             of 355.3 file (Optional)
 ;  IBELEC   - Data to be file in ELECTRONIC PLAN TYPE  (#.15) field 
 ;             of 355.3 file (Optional)
 ;             Corresponds to the Internal Codes in .15 field of 355.3 
 ;             file
 ;  IBGPCOM  - Group Plan Comment array that contains the word
 ;             processing data to be filed the COMMENTS (#11) word-
 ;             processing field of  355.3 file. (Optional)
 ;              Example:  IBGPCOM(1)="This is line 1"
 ;                        IBGPCOM(2)="This is line 2"
 ;  IBFTF    - Data to be filed in the PLAN STANDARD FTF (#.16) field of
 ;             355.3 file (Optional)
 ;             Corresponds to the Internal Entry Number of the entry in 
 ;             the INSURANCE FILING TIME FRAME (#355.13) File.
 ;  IBFTFVAL - Data to be filed in the PLAN STANDARD FTF VALUE (#.17)
 ;             field of 355.3 file (Optional - Calling application 
 ;             responsible to pass value if required for Plan Standard
 ;             FTF) 
 ;
 ;Output:
 ;  RESULT - Returned Parameter Array with results of call
 ;   RESULT = 0 ^ No data to update
 ;   RESULT(1) = -1^ error with Insurance Type (#2.312) file update
 ;   RESULT(1) = 0                   - Insurance Type update worked
 ;   RESULT(2) = -1^ error with GROUP INSURANCE PLAN (#355.3) file update
 ;   RESULT(2) = 0                   - Group Insurance Plan update worked
 ;
 ;Update Patient Policy Comment (#1.08) and/or 
 ;Policy Not Billable (#3.04) fields in 2.312 subfile
 I $G(IBPOLCOM)]""!($G(IBPOLBIL)]"") D
 . N IBIENS,IBFDA
 . I $G(DFN)']"" S RESULT(1)="-1^PATIENT (#2) DFN not passed" Q
 . I $G(IBPOLDA)'>0 S RESULT(1)="-1^INSURANCE TYPE (#2.312) sub-file IEN not defined" Q
 . I +IBPOLDA,$G(^DPT(DFN,.312,IBPOLDA,0))="" S RESULT(0)="-1^Passed Patient INSURANCE TYPE (#2.312) entry doesn't exist" Q
 . L +^DPT(DFN,.312,IBPOLDA):5 I '$T S RESULT(1)="-1^INSURANCE TYPE (#2.312) sub-file entry locked, data not updated" Q
 . S IBIENS=+IBPOLDA_","_+DFN_","
 . I $G(IBPOLBIL)]"",$$EXTERNAL^DILFD(2.312,3.04,"",IBPOLBIL)']"" S RESULT(1)="-1^POLICY NOT BILLABLE ("_IBPOLBIL_") not a valid value",IBPOLBIL=""
 . S:$G(IBPOLBIL)]"" IBFDA(2.312,IBIENS,3.04)=IBPOLBIL
 . I $D(IBFDA)>0 D FILE^DIE(,"IBFDA") S:$D(RESULT(1))'>0 RESULT(1)=0
 . D PPCOMM(DFN,IBPOLDA,IBPOLCOM,.RESULT)
 . L -^DPT(DFN,.312,IBPOLDA)
 ;
 ;Update Plan Filing Time Frame (#.13), Electronic Plan Type (#.15)
 ;Plan Standard FTF (#.16), Plan Standard FTF Value (#.17), and/or
 ;Group Plan Comments (#11) fields in 355.3 file
 I $G(IBPLAN)]""!($G(IBELEC)]"")!($D(IBGPCOM)>0)!($G(IBFTF)]"")!($G(IBFTFVAL)]"") D
 . N IBIENS,IBFDA
 . I $G(IBGRPDA)'>0 S RESULT(2)="-1^GROUP INSURANCE PLAN (#355.3) file IEN not defined" Q
 . I +IBGRPDA,$G(^IBA(355.3,IBGRPDA,0))="" S RESULT(2)="-1^Passed GROUP INSURANCE PLAN (#355.3) entry doesn't exist" Q
 . L +^IBA(355.3,IBGRPDA):5 I '$T S RESULT(2)="-1^GROUP INSURANCE PLAN (#355.3) file entry locked, data not updated" Q
 . S IBIENS=+IBGRPDA_","
 . ; Consistency Checks for Plan Standard FTF and FTF VALUE fields
 . I $G(IBELEC)]"",$$EXTERNAL^DILFD(355.3,.15,"",IBELEC)']"" S RESULT(2)="-1^ELECTRONIC PLAN TYPE ("_IBELEC_") not a valid value",IBELEC=""
 . I $G(IBFTFVAL)]"",$G(IBFTF)']"" S RESULT(2)="-1^PLAN STANDARD FTF should be passed with PLAN STANDARD FTF VALUE",IBFTFVAL=""
 . I $G(IBFTF)]"",$$EXTERNAL^DILFD(355.3,.16,"",IBFTF)']"" S RESULT(2)="-1^PLAN STANDARD FTF ("_IBFTF_") not a valid value",IBFTF=""
 . I $G(IBFTF)]"",$$GET1^DIQ(355.13,+IBFTF_",",.02,"I")=1,$G(IBFTFVAL)'>0 S RESULT(2)="-1^Valid PLAN STANDARD FTF VALUE not passed for "_$$GET1^DIQ(355.13,+IBFTF,.01,"E"),IBFTF="",IBFTFVAL=""
 . ;
 . S:$G(IBPLAN)]"" IBFDA(355.3,IBIENS,.13)=IBPLAN
 . S:$G(IBELEC)]"" IBFDA(355.3,IBIENS,.15)=IBELEC
 . S:$G(IBFTF)]"" IBFDA(355.3,IBIENS,.16)=IBFTF
 . S:$G(IBFTFVAL)]"" IBFDA(355.3,IBIENS,.17)=IBFTFVAL
 . I $D(IBFDA)>0 D FILE^DIE(,"IBFDA") S:$D(RESULT(2))'>0 RESULT(2)=0
 . ;
 . ;Update Group Plan Comments (#11) word processing field in 355.3 file
 . I $O(IBGPCOM(""))>0 D WP^DIE(355.3,+IBGRPDA_",",11,,"IBGPCOM") S:$D(RESULT(2))'>0 RESULT(2)=0
 . L -^IBA(355.3,IBGRPDA)
 I $D(RESULT(1))'>0&($D(RESULT(2))'>0) S RESULT="0^No data to update"
 Q
 ;
PPCOMM(DFN,IBPOLDA,IBPOLCOM,RESULT) ; ib*2*528   record patient policy comments
 ; Input:
 ;   DFN      = patient IEN
 ;   IBPOLDA  = ien of selected INSURANCE POLICY at ^DPT("_DFN_",.312,
 ;   IBPOLCOM = patient policy COMMENT data
 ;
 ; Output:
 ;   RESULT   = Returned Parameter Array with results of call
 ;
 N IBDT,IBVCOM
 S IBVCOM=""
 ;
 ; -- get the last comment made for the policy within VistA
 S IBDT=$O(^DPT(DFN,.312,IBPOLDA,13,"B",""),-1)
 I IBDT]"" S IBCDA=$O(^DPT(DFN,.312,IBPOLDA,13,"B",IBDT,""),-1) S IBVCOM=$G(^DPT(DFN,.312,IBPOLDA,13,IBCDA,1))
 ;
 ; -- no VistA comments for patient policy so go add the new ICB comment
 I IBVCOM="",IBPOLCOM]"" D ADCOM(DFN,IBPOLDA,IBPOLCOM,.RESULT) Q
 ;
 ; -- the last comment within VistA is the same comment as the new ICB comment
 I IBVCOM=IBPOLCOM Q
 ;
 ; -- VistA comment is different from ICB comment so add the ICB comment
 D ADCOM(DFN,IBPOLDA,IBPOLCOM,.RESULT)
 Q
 ;
ADCOM(DFN,IBPOLDA,IBPOLCOM,RESULT) ; add new entry to the COMMENT - SUBSCRIBER POLICY multiple
 ; Input:
 ;   DFN      = patient IEN
 ;   IBPOLDA  = ien of INSURANCE POLICY at ^DPT("_DFN_",.312,
 ;   IBPOLCOM = patient policy COMMENT data
 ;   DUZ      = user IEN - system wide variable   
 ;
 ; Output:
 ;   RESULT   = Returned Parameter Array with results of call
 ;
 ; -- lock the COMMENT - SUBSCRIBER POLICY multiple so that previous comments can't be edited
 L +^DPT(DFN,.312,IBPOLDA,13):5 I '$T S RESULT(1)="-1^INSURANCE TYPE (#2.312,1.18) sub-file entry locked, data not updated" Q
 ;
 N FDA,IENS,DIERR
 ;
 ; -- populate the FDA array with data
 S IENS="+1,"_IBPOLDA_","_DFN_","
 S FDA(2.342,IENS,.01)=$$NOW^XLFDT()
 S FDA(2.342,IENS,.02)=DUZ
 S FDA(2.342,IENS,.03)=IBPOLCOM
 ;
 ; -- update comment
 D UPDATE^DIE(,"FDA",,"DIERR")
 ;
 ; -- check for error
 I $D(DIERR) S RESULT(1)="-1^INSURANCE TYPE (#2.312,1.18) error adding comment to INSURANCE TYPE (#2.312,1.18)"
 E  S RESULT(1)=0
 ;
 ; -- unlock comment multiple
 L -^DPT(DFN,.312,IBPOLDA,13)
 Q
 ;
EDCOM(IBPOLDA,IBPOLCOM,IBDT) ; edit the existing entry at 2.312,1.18 multiple
 ; input - IBPOLDA = ien of INSURANCE POLICY at ^DPT("_DFN_",.312,
 ;         IBDT = date/time that comment was made
 N DA,DIE,DR,IBNM
 ; retrieve the latest comment made by the user
 S DA=$O(^DPT(DFN,.312,IBPOLDA,13,"BB",DUZ,IBDT,""),-1)
 S DIE="^DPT("_DFN_",.312,"_IBPOLDA_",13,"
 S DA(2)=DFN,DA(1)=IBPOLDA
 ;  retrieve the latest comment made by the user
 S IBNM=$$GET1^DIQ(200,DUZ_",",.01,"E")
 I $G(^DPT(DFN,.312,IBPOLDA,13,DA,1))]"" S DR=".01///"_$$NOW^XLFDT()_";.02///"_IBNM_";.03///"_IBPOLCOM
 E  S DR=".01///@;.02///@"
 D ^DIE
 Q
UPDPOL(RESULT,IBBUFDA,DFN,IBINSDA,IBGRPDA,IBPOLDA) ;update a new group into 
 ;an existing patient policy entry for ICB interface
 ;Input
 ;  IBBUFDA  - INSURANCE BUFFER (#355.33) file internal entry number
 ;             (IEN) (Required)
 ;  DFN      - PATIENT (#2) file IEN (Required)
 ;  IBINSDA  - INSURANCE COMPANY (#36) File IEN if not adding new entry
 ;             (Optional)
 ;  IBGRPDA  - GROUP INSURANCE PLAN (#355.3) File IEN if not adding new
 ;             entry (Required)
 ;  IBPOLDA  - INSURANCE TYPE (#2.312) sub-file of PATIENT (#2) IEN if
 ;             not adding new entry (Required)
 ;Output:
 ;  RESULT(4) - Returned Parameter Array with results of call
 ;     RESULT(4) =-1^error message
 ;     RESULT(4) =0 ^ message that process was successful or not require
 ;
 N IBPAT
 I $G(IBBUFDA)'>0 S RESULT(4)="-1^INSURANCE BUFFER (#355.33) IEN required" Q
 I $G(DFN)'>0 S RESULT(4)="-1^PATIENT (#2) IEN required" Q
 I $G(IBPOLDA)'>0 S RESULT(4)="-1^INSURANCE TYPE (#2.312) SUB-FILE IEN required" Q
 I $G(^DPT(DFN,.312,IBPOLDA,0))'>0 S RESULT(4)="-1^PATIENT INSURANCE TYPE(#2.312) entry doesn't exist" Q
 I $G(IBGRPDA)'>0 S RESULT(4)="-1^GROUP INSURANCE PLAN (#355.3) IEN required" Q
 ;
 ; NO changes required
 S IBPAT=$G(^DPT(DFN,.312,IBPOLDA,0))
 I $G(IBINSDA)>0,$P(IBPAT,U,1)=IBINSDA,$P(IBPAT,U,18)=IBGRPDA S RESULT(4)="0^NO CHANGE REQUIRE" Q
 I $G(IBINSDA)'>0,$P(IBPAT,U,18)=IBGRPDA S RESULT(4)="0^NO CHANGE REQUIRE" Q
 ;
 ;Additional error checks
 I $G(^IBA(355.3,IBGRPDA,0))="" S RESULT(4)="-1^GROUP INSURANCE PLAN (#355.3) entry doesn't exist" Q
 I $G(IBINSDA)>0,$G(^DIC(36,IBINSDA,0))="" S RESULT(4)="-1^INSURANCE COMPANY (#36) entry doesn't exist" Q
 I $G(IBINSDA)>0,$P($G(^IBA(355.3,IBGRPDA,0)),U,1)'=IBINSDA S RESULT(4)="-1^GROUP INSURANCE PLAN (#355.3) entry points to different INSURANCE COMPANY (#36) entry" Q
 I $G(IBINSDA)'>0,$P($G(^IBA(355.3,IBGRPDA,0)),U,1)'=$P(IBPAT,U,1) S RESULT(4)="-1^GROUP INSURANCE PLAN (#355.3) entry points to different INSURANCE COMPANY (#36) entry" Q
 ;
 D CLEANUP
 ;
 L +^DPT(DFN,.312,IBPOLDA):5 I '$T S RESULT(4)="-1^INSURANCE TYPE (#2.312) SUB-FILE ENTRY LOCKED, DATA NOT UPDATED" Q
 ;
 N IBXIFN,IBFIELDS,IBERR
 S IBXIFN=IBPOLDA_","_DFN_","
 I $G(IBINSDA) S IBFIELDS(2.312,IBXIFN,.01)=IBINSDA
 S IBFIELDS(2.312,IBXIFN,.18)=IBGRPDA ;policy's group/plan always update 
 Q:'$D(IBFIELDS)
 ;Source
 S IBFIELDS(2.312,IBXIFN,1.09)=$P($G(^IBA(355.33,+$G(IBBUFDA),0)),U,3)
 ;Source Date
 S IBFIELDS(2.312,IBXIFN,1.1)=+$G(^IBA(355.33,+$G(IBBUFDA),0))
 D FILE^DIE("","IBFIELDS","IBERR")
 I $D(IBERR)>0 S RESULT(4)="-1^Fileman DIE error"
 I $D(IBERR)'>0 S RESULT(4)="0^Data successfully updated"
 L -^DPT(DFN,.312,IBPOLDA)
 Q
 ;
CLEANUP ;This logic will delete obsolete Individual Plans, Repoint Insurance 
 ;Reviews if Insurance Company changes, and Remove any Old Benefits Used.
 N IBPAT,IBOLDINS,IBOLDGRP,IBIP,IBT,IBTNODE0,IBTNODE1,IBFIELDS,IBARR
 S IBPAT=$G(^DPT(DFN,.312,IBPOLDA,0))
 S IBOLDINS=$P(IBPAT,U,1),IBOLDGRP=$P(IBPAT,U,18)
 S IBIP=$P($G(^IBA(355.3,+$P(IBPAT,U,18),0)),U,2)
 ;If Old Group Insurance Plan is an Individual Plan with only one
 ;subscriber for the same Patient Insurance Policy Entry, delete it
 I IBIP=0,$$SUBS^IBCNSJ(IBOLDINS,IBOLDGRP,,"IBARR")'>1,($D(IBARR(DFN,IBPOLDA))>0) D DEL^IBCNSJ(IBOLDGRP)
 ;If changing to a new Insurance Company
 I $G(IBINSDA)>0,IBOLDINS'=IBINSDA D  Q
 . ; - repoint all Insurance Reviews to new company
 . I $$IR^IBCNSJ21(DFN,IBPOLDA) D
 . S IBT=0
 . F  S IBT=$O(^IBT(356.2,"D",DFN,IBT)) Q:'IBT  D
 . . S IBTNODE0=$G(^IBT(356.2,IBT,0)),IBTNODE1=$G(^IBT(356.2,IBT,1))
 . . I $P(IBTNODE1,U,5)=IBPOLDA,$P(IBTNODE0,U,8)'=IBINSDA D
 . . . S IBFIELDS(356.2,IBT_",",.08)=IBINSDA
 . . . D FILE^DIE("","IBFIELDS")
 ;Delete Benefits Used (#355.5) corresponding to old Patient Group Plan
 D DELBU
 Q
 ;
DELBU ;Delete Benefits Used
 N IBCDFN,IBPLAN,IBBU
 S IBCDFN=IBPOLDA,IBPLAN=IBOLDGRP
 ;Get Benefits Used
 D BU^IBCNSJ21
 ;If there are Benefits Used, then delete them
 I $O(IBBU(0)) D
 . N IBDAT
 . S IBDAT=""
 . F  S IBDAT=$O(IBBU(IBDAT)) Q:IBDAT=""  D DBU^IBCNSJ(IBBU(IBDAT))
 Q
