FBHLZFE ;WCIOFO/SAB-CREATE HL7 ZFE SEGMENTS ;7/21/1998
 ;;3.5;FEE BASIS;**14,78**;JAN 30, 1995
 ;
 ; This routine generates ZFE HL7 segments that contain FEE BASIS
 ; authorization data for a veteran. 
 ;
EN(DFN,FBSTR,FBCUT) ; Returns array of ZFE segments containing FEE BASIS
 ;                 authorizatiion data for a veteran.
 ;  Input:
 ;    DFN   - internal entry number of the PATIENT (#2) file and
 ;            FEE BASIS PATIENT (#161) file
 ;    FBSTR - (optional) comma delimited sting of requested fields
 ;            DEFAULT: "1,2,3,4,5" (returns all fields)
 ;    FBCUT - (optional) cutoff date (fileman format)
 ;            Default: "2961001" (Oct 1, 1996)
 ;            authorizations with a TO DATE prior to the cutoff will
 ;            not be considered.
 ;    Also needs HL7 variables defined (HLFS, HLECH and HLQ)
 ;  Output:
 ;    If an exception did not occur
 ;    FBZFE(I) - an array of string(s) forming the ZFE segments for the
 ;               patient's FEE authorizations that meet the criteria.
 ;               I will be numeric values greater than 0.
 ;            OR undefined if no authorizations meet criteria.
 ;
 ;               Note: Only the latest authorization for each group is
 ;               returned (where group is FEE PROGRAM + TREATMENT TYPE).
 ;
 ;    If an exception did occur
 ;    FBZFE(0) = -1 ^ exception number ^ exception text
 ;
 N FBA,FBDA1,FBGRP,FBI,FBICN,FBY0
 K FBZFE ; initialize array
 I $G(FBSTR)="" S FBSTR="1,2,3,4,5"
 S FBSTR=","_FBSTR_","
 I $G(FBCUT)="" S FBCUT=2961001
 ;
 ; check for required input
 I $G(FBZFE(0))'<0 D
 . I $G(DFN)="" S FBZFE(0)="-1^103^Patient DFN not specified." Q
 . I '$D(HLFS)!'$D(HLECH)!'$D(HLQ) S FBZFE(0)="-1^201^HL7 variables not defined." Q
 ;
 ; get patient ICN
 I $G(FBZFE(0))'<0 D
 . I $$IFLOCAL^MPIF001(DFN) S FBZFE(0)="-1^104^ICN could not be determined for the specified patient." Q  ; must not be local ICN
 . S FBICN=$$GETICN^MPIF001(DFN) I FBICN<0 S FBZFE(0)="-1^104^ICN could not be determined for the specified patient." Q
 ;
 ; check if cutoff date is a valid value
 I $G(FBZFE(0))'<0 D
 . I FBCUT'?7N S FBZFE(0)="-1^101^Valid date not specified." Q
 . I $$FMTHL7^XLFDT(FBCUT)<0 S FBZFE(0)="-1^101^Valid date not specified." Q
 ;
 I $G(FBZFE(0))'<0 D
 . ; find authorizations that meet criteria (if any)
 . ; loop thru authorizations
 . S FBDA1=0 F  S FBDA1=$O(^FBAAA(DFN,1,FBDA1)) Q:'FBDA1  D
 . . Q:$P($G(^FBAAA(DFN,1,FBDA1,"ADEL")),U)="Y"  ; ignore Austin Deleted
 . . S FBY0=$G(^FBAAA(DFN,1,FBDA1,0))
 . . Q:$P(FBY0,U,3)=""  ; FEE Program required
 . . Q:$P(FBY0,U,2)<FBCUT  ; before cutoff date
 . . S FBGRP=$P(FBY0,U,3)_U_$P(FBY0,U,13) ; group (Program + Treat. Type)
 . . Q:$P(FBY0,U,2)'>$P($G(FBA(FBGRP)),U,2)  ; already have later for grp
 . . ; save as latest found (so far) for a group
 . . S FBA(FBGRP)=FBDA1_U_$P(FBY0,U,2)
 . ;
 . ; build FBZFE array for selected authorizations
 . S FBI=0 ; init number of array elements
 . S FBGRP="" F  S FBGRP=$O(FBA(FBGRP)) Q:FBGRP=""  D
 . . S FBDA1=$P(FBA(FBGRP),U)
 . . D AUTH
 ;
QUIT ;
 Q
 ;
AUTH ; Add node (HL7 ZFE seg.) to FBZFE array for a specified authorization
 ;   Input:
 ;     DFN    - veteran ien (file #2 and #161)
 ;     FBDA1  - authorization ien (authorization multiple of #161)
 ;     FBI    - previous set ID number used for array or 0 when none
 ;     FBSTR  - comma delimited string of requested fields
 ;   Output:
 ;     FBI        - set ID (modified)
 ;     FBZFE(FBI) - output array element for one set ID
 ;                  ZFE ^ set ID ^ treat. type ^ FEE program ^ From ^ To
 ;
 N FBY0,X
 ;
 S FBY0=$G(^FBAAA(DFN,1,FBDA1,0))
 Q:FBY0=""  ; nothing to process
 ;
 S FBI=FBI+1
 ;
 S FBZFE(FBI)="ZFE"
 S $P(FBZFE(FBI),HLFS,6)=""
 I FBSTR[",1," S $P(FBZFE(FBI),HLFS,2)=FBI ; sequential number
 I FBSTR[",2," S X=$$EXTERNAL^DILFD(161.01,.095,"",$P(FBY0,U,13)),$P(FBZFE(FBI),HLFS,3)=$S(X]"":X,1:HLQ)_$E(HLECH)_$E(HLECH)_"VA0033" ; Treatment Type
 I FBSTR[",3," S X=$S($P(FBY0,U,3):$P($G(^FBAA(161.8,$P(FBY0,U,3),0)),U),1:""),$P(FBZFE(FBI),HLFS,4)=$S(X]"":X,1:HLQ)_$E(HLECH)_$E(HLECH)_"VA0034" ; FEE Program
 I FBSTR[",4," S $P(FBZFE(FBI),HLFS,5)=$S($P(FBY0,U)]"":$$HLDATE^HLFNC($P(FBY0,U)),1:HLQ) ; From Date
 I FBSTR[",5," S $P(FBZFE(FBI),HLFS,6)=$S($P(FBY0,U,2)]"":$$HLDATE^HLFNC($P(FBY0,U,2)),1:HLQ) ; To Date
 Q
