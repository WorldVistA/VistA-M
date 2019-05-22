DGPFAA ;ALB/RPM,ASMR/JD - PRF ASSIGNMENT API'S ; 11/16/16 6:47pm
 ;;5.3;Registration;**425,921,951**;Aug 13, 1993;Build 135
 ;    Last edited: SHRPE/SGM - Sep 26, 2018 17:06
 ;
 ;   DE2813 - JD - 10/28/15
 ;Done for eHMP project: DG*5.3*921
 ;Add logic to trigger an unsolicited update when a patient flag is updated.
 ;New code: Tag UU and any reference to that tag thereof.
 ;     SHRPE/sgm - Jan 22, 2018
 ;Done for SHRPE project: DG*5.3*951
 ;  GETASGN is called via ICR.  So new input parameter introduced that
 ;  is not part of the ICR for returning DBRS data.
 ;
 ; ICR# TYPE DESCRIPTION
 ;----- ---- ----------------------------------
 ;  872 CSub Global read of B index on file 101
 ; 2056 Sup  GETS^DIQ
 ; 2053 Sup  ^DIE: FILE, UPDATE
 ;10101 Sup  EN1^XQOR
 ;
 Q  ;no direct entry
 ;
GETALL(DGDFN,DGIENS,DGSTAT,DGCAT) ;retrieve list of assignment IENs
 ;This function returns an array of patient record flag assignment IENs
 ;for a given patient.  The returned IEN array may optionally be
 ;filtered by Active or Inactive status and by flag category.
 ;
 ;  Input:
 ;    DGDFN - (required) Pointer to patient in PATIENT (#2) file
 ;   DGIENS - (required) Result array passed by reference
 ;   DGSTAT - (optional) Status filter (0:Inactive,1:Active,"":Both).
 ;            Defaults to Both.
 ;    DGCAT - (optional) Category filter
 ;            (1:Category I,2:Category II,"":Both).  Defaults to Both.
 ;
 ;  Output:
 ;   Function Value - Count of returned IENs
 ;         DGIENS - Output array subscripted by the assignment IENs
 ;
 N DGCNT   ;number of returned values
 N DGIEN   ;single IEN
 N DGCKS   ;check status flag (1:check, 0:ignore)
 N DGFLAG  ;pointer to #26.11 or #26.15
 ;
 S DGCNT=0
 I $G(DGDFN)>0,$D(^DGPF(26.13,"B",DGDFN)) D
 . S DGFLAG=""
 . S DGCKS=0
 . S DGSTAT=$G(DGSTAT)
 . I DGSTAT=0!(DGSTAT=1) S DGCKS=1
 . S DGCAT=+$G(DGCAT)
 . S DGCAT=$S(DGCAT=1:"26.15",DGCAT=2:"26.11",1:0)
 . F  S DGFLAG=$O(^DGPF(26.13,"C",DGDFN,DGFLAG)) Q:(DGFLAG="")  D
 . . I DGCAT,DGFLAG'[DGCAT Q
 . . S DGIEN=$O(^DGPF(26.13,"C",DGDFN,DGFLAG,0))
 . . I DGCKS,'$D(^DGPF(26.13,"D",DGDFN,DGSTAT,DGIEN)) Q
 . . S DGCNT=DGCNT+1
 . . S DGIENS(DGIEN)=""
 Q DGCNT
 ;
GETASGN(DGPFIEN,DGPFA,DGDBRS) ;retrieve a single assignment record
 ;This function returns a single patient record flag assignment in an
 ;array format.
 ;
 ;  Input:
 ;    DGPFIEN - (required) Pointer to patient record flag assignment in
 ;              PRF ASSIGNMENT (#26.13) file
 ;      DGPFA - (required) Result array passed by reference
 ;     DGDBRS - (optional) 1:return DBRS info in DGPFA() ; dg*951
 ;
 ;  Output:
 ;   Function Value - Returns 1 on success, 0 on failure
 ;            DGPFA - Output array containing assignment record field
 ;                    values.
 ;                    Subscript          Field#   Data
 ;                    --------------     -------  ---------------------
 ;                    "DFN"              .01      internal^external
 ;                    "FLAG"             .02      internal^external
 ;                    "STATUS"           .03      internal^external
 ;                    "OWNER"            .04      internal^external
 ;                    "ORIGSITE"         .05      internal^external
 ;                    "REVIEWDT"         .06      internal^external
 ;                    "NARR",line#,0     1        character string
 ;                        If input DGDBRS>0 then
 ;                    "DBRS#",line#      2;.01    internal^external
 ;                    "DBRS OTHER",line# 2;.02    internal^external
 ;                    "DBRS DATE",line#  2;.03    internal^external
 ;                    "DBRS SITE",line#  2;.04    internal^external
 ;
 N DGRSLT
 ;
 S DGRSLT=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.13,DGPFIEN)) D
 . N DGIENS   ;IEN string for DIQ
 . N DGFLDS   ;results array for DIQ
 . N DGERR  ;error array for DIQ
 . N ARR,DF,DIERR
 . S DGIENS=DGPFIEN_","
 . S DF="*" I +$G(DGDBRS) S DF="**" ;   dg*5.3*951
 . D GETS^DIQ(26.13,DGIENS,DF,"IEZ","DGFLDS","DGERR")
 . Q:$D(DGERR)
 . M ARR=DGFLDS(26.13,DGIENS)
 . S DGRSLT=1
 . S DGPFA("DFN")=$G(ARR(.01,"I"))_U_$G(ARR(.01,"E"))
 . S DGPFA("FLAG")=$G(ARR(.02,"I"))_U_$G(ARR(.02,"E"))
 . S DGPFA("STATUS")=$G(ARR(.03,"I"))_U_$G(ARR(.03,"E"))
 . S DGPFA("OWNER")=$G(ARR(.04,"I"))_U_$G(ARR(.04,"E"))
 . S DGPFA("ORIGSITE")=$G(ARR(.05,"I"))_U_$G(ARR(.05,"E"))
 . S DGPFA("REVIEWDT")=$G(ARR(.06,"I"))_U_$G(ARR(.06,"E"))
 . ;build assignment narrative word processing array
 . M DGPFA("NARR")=ARR(1)
 . K DGPFA("NARR","E"),DGPFA("NARR","I")
 . I $D(DGFLDS(26.131)) D DBRS ;     DG*5.3*951
 . Q
 Q DGRSLT
 ;
FNDASGN(DGPFDFN,DGPFFLG) ;Find Assignment
 ;  This function finds a patient record flag assignment record.
 ;
 ;  Input:
 ;    DGDFN - Pointer to patient in the PATIENT (#2) file
 ;   DGFLAG - Pointer to flag in either the PRF LOCAL FLAG (#26.11)
 ;            file or the PRF NATIONAL FLAG (#26.15) file
 ;
 ;  Output:
 ;   Function Value - Returns IEN of existing record on success, 0 on
 ;                    failure
 ;
 N DGIEN
 ;
 I $G(DGPFDFN)>0,($G(DGPFFLG)>0) D
 . S DGIEN=$O(^DGPF(26.13,"C",DGPFDFN,DGPFFLG,0))
 Q $S($G(DGIEN)>0:DGIEN,1:0)
 ;
STOASGN(DGPFA,DGPFERR,DGPFUV) ;
 ;Store a single PRF ASSIGNMENT (#26.13) file record
 ;
 ;  Input:
 ;    DGPFA - (required) array of values to be filed (see GETASGN tag
 ;            above for valid array structure)
 ;              DGPFA() contains 2 "^"-pieces when called from AF/EF
 ;                               1 "^"-piece when called from HL
 ;            DGPFA("ACTION")=DGPFAH("ACTION") added by EF action and HL
 ;            DGPFA("ACTION") = internal [ACTION; 26.14,.03]
 ;  DGPFERR - (optional) passed by reference to contain error messages
 ;   DGPFUV - (optional) see STOALL
 ;             required to file DBRS data
 ;
 ;  Output:
 ;   Function Value - Returns IEN of record on success, 0 on failure
 ;          DGPFERR - Undefined on success, error message on failure
 ;
 N I,X,DGFLD,DGIEN,DGPFERR,DGSUB
 S DGPFUV=$$UV
 S X="ACTION^DFN^FLAG^ORIGSITE^OWNER^STATUS"
 F I=1:1:$L(X,U) S DGSUB=$P(X,U,I),DGFLD(DGSUB)=$P($G(DGPFA(DGSUB)),U)
 ;
 ;only build DGFLD("REVIEWDT") if "REVIEWDT" is passed
 I $D(DGPFA("REVIEWDT"))=1 S DGFLD("REVIEWDT")=$P(DGPFA("REVIEWDT"),U,1)
 ;
 I $D(DGPFA("NARR")) M DGFLD("NARR")=DGPFA("NARR")
 ;
 ;REFRESH option may reset STATUS value - DG*5.3*951
 S X=DGFLD("ACTION") I (X=7)!(X=8) S DGFLD("STATUS")=X-7
 ;
 I $$VALID^DGPFUT("DGPFAA1",26.13,.DGFLD,.DGPFERR) D
 . N X,DGDBRSE,DGCUR,DGFDA,DGFDAIEN,DGIENS,UPD
 . S DGIEN=$$FNDASGN^DGPFAA(DGFLD("DFN"),DGFLD("FLAG"))
 . I DGIEN S X=$$GETASGN(DGIEN,.DGCUR,1)
 . I DGIEN S DGIENS=DGIEN_","
 . E  S DGIENS="+1,"
 . S DGFDA(26.13,DGIENS,.01)=DGFLD("DFN")
 . S DGFDA(26.13,DGIENS,.02)=DGFLD("FLAG")
 . S DGFDA(26.13,DGIENS,.03)=DGFLD("STATUS")
 . S DGFDA(26.13,DGIENS,.04)=DGFLD("OWNER")
 . S DGFDA(26.13,DGIENS,.05)=DGFLD("ORIGSITE")
 . ;
 . ;only touch REVIEW DATE (#.06) field if "REVIEWDT" is passed
 . ;if called from REFRESH option re-evaluate - DG*5.3*951
 . S X=DGFLD("ACTION") I (X=7)!(X=8) D
 . . I '$$ISDIV^DGPFUT(DGFLD("OWNER")) S DGFLD("REVIEWDT")="" Q
 . . I 'DGFLD("STATUS") S DGFLD("REVIEWDT")="" Q
 . . I +$G(DGCUR("REVIEWDT")) Q
 . . ;calculate the default review date
 . . S DGFLD("REVIEWDT")=$$GETRDT^DGPFAA3(DGFLD("FLAG"),$$NOW^XLFDT)
 . . Q
 . I $D(DGFLD("REVIEWDT")) S DGFDA(26.13,DGIENS,.06)=DGFLD("REVIEWDT")
 . ;
 . I $D(DGFLD("NARR")) S DGFDA(26.13,DGIENS,1)=$NA(DGFLD("NARR"))
 . ;
 . ;add in DBRS# data into .DGFDA ; dg*5.3*951
 . ;   if all existing DBRS data was deleted, $D(DGPFA("DBRS#"))=0
 . ;   DGPFA("ACTION")=History action code (may not be present)
 . ;
 . I DGPFUV'=-1,$L($T(AASGN^DGPFUT6)),+$$FLAG(DGFLD("FLAG")) D
 . . N ACT S ACT=+DGFLD("ACTION")
 . . I ACT=3 S DGPFUV=""
 . . I ACT=5 S DGPFUV="d"
 . . I ACT=7 S DGPFUV="D"
 . . D AASGN^DGPFUT6(DGIENS,.DGPFA,.DGFDA,DGPFUV,.DGPFERR)
 . . Q
 . Q:$D(DGPFERR)
 . ;
 . ;determine if update or file should be called
 . S UPD=(DGIENS["+") I 'UPD D
 . . N I,J
 . . S I=0 F J=0:0 S I=$O(DGFDA(26.131,I)) Q:I=""  I I["+" S UPD=1 Q
 . . Q
 . ;
 . ;  variable needed for ^DD(26.131,.01,"DEL")
 . I $G(DGPFA("ACTION"))=5 S DGDBRSE=1
 . I 'UPD D
 . . N DGERR,DIERR
 . . D FILE^DIE("","DGFDA","DGERR")
 . . I $D(DGERR) S DGIEN=0
 . . ;DG*5.3*921 - Trigger an unsolicited update if a patient flag is updated
 . . I '$D(DGERR) D UU(.DGPFA)
 . . Q
 . E  D
 . . N DGERR,DIERR
 . . D UPDATE^DIE("","DGFDA","DGFDAIEN","DGERR")
 . . I $D(DGERR),DGIENS'="+1," S DGIEN=0
 . . I '$D(DGERR),DGIENS="+1," S DGIEN=$G(DGFDAIEN(1))
 . . Q
 . Q
 Q $S($G(DGIEN)>0:DGIEN,1:0)
 ;
STOALL(DGPFA,DGPFAH,DGPFERR,DGPFUV) ;
 ;Store both the assignment and history record
 ;This function acts as a wrapper around the $$STOASGN and $$STOHIST
 ;filer calls.
 ;
 ;  INPUT PARAMETERS:
 ;    DGPFA - (required) array of assignment values to be filed (see
 ;            $$GETASGN^DGPFAA for valid array structure)
 ;   DGPFAH - (required) array of assignment history values to be filed
 ;            (see $$STOHIST^DGPFAAH for valid array structure)
 ;  DGPFERR - (optional) passed by reference to contain error messages
 ;   DGPFUV - (optional) generic flag, single character, intent allow
 ;            calls to STOALL to flag special handling cases
 ;            D: STOASGN - first, mark all existing DBRS records for
 ;               delete in FDA().  DGPFUT62 processing continues
 ;            d: STOASGN - first, mark all existing DBRS records for
 ;               delete in FDA().  DGPFUT62 processing stops and exits
 ;           -1: DGPFUV was not passed in
 ;               [difference between null and '$D(DGPFUV)]
 ;
 ;  Output:
 ;   Function Value - Returns circumflex("^") delimited results of
 ;                    $$STOASGN^DGPFAA and $$STOHIST^DGPFAAH calls
 ;          DGPFERR - Undefined on success, error message on failure
 ;
 N DGOIEN    ;existing assignment file IEN used for "roll-back"
 N DGPFOA    ;existing assignment data array used for "roll-back"
 N DGAIEN    ;assignment file IEN
 N DGAHIEN   ;assignment history file IEN
 N DGDFN     ;"DFN" value
 N DGFLG     ;"FLAG" value
 ;
 S (DGAIEN,DGAHIEN)=0
 S DGDFN=$P($G(DGPFA("DFN")),U,1)
 S DGFLG=$P($G(DGPFA("FLAG")),U,1)
 S DGPFUV=$$UV
 S DGOIEN=$$FNDASGN^DGPFAA(DGDFN,DGFLG)
 D   ;drops out of block if can't rollback or assignment filer fails
 . I DGOIEN,'$$GETASGN^DGPFAA(DGOIEN,.DGPFOA,1) Q  ;can't rollback, so quit
 . ;
 . ;store the assignment
 . I '$D(DGPFA("ACTION")) S DGPFA("ACTION")=+$G(DGPFAH("ACTION"))
 . S DGAIEN=$$STOASGN^DGPFAA(.DGPFA,.DGPFERR,DGPFUV)
 . I $D(DGPFERR) S DGAIEN=0
 . Q:'DGAIEN  ;assignment filer failed, so quit
 . ;
 . ;store the assignment history
 . S DGPFAH("ASSIGN")=DGAIEN
 . S DGAHIEN=$$STOHIST^DGPFAAH(.DGPFAH,.DGPFERR)
 . I $D(DGPFERR) S DGAHIEN=0
 . I DGAHIEN=0 D    ;history filer failed, so rollback the assignment
 . . I 'DGOIEN,'$D(DGPFOA) S DGPFOA("DFN")="@"
 . . I $$ROLLBACK^DGPFAA2(DGAIEN,.DGPFOA) S DGAIEN=0
 . . Q
 . Q
 Q $S(+$G(DGAHIEN)=0:0,1:DGAIEN_"^"_DGAHIEN)
 ;
UU(ARRY) ;Fire off "DGPF ASSIGN FLAG" protocol for UPDATED flags
 ;ARRY("DFN")=DFN
 N DGDFN,X
 S DGDFN=+ARRY("DFN")
 S X=+$O(^ORD(101,"B","DGPF ASSIGN FLAG",0))_";ORD(101,"
 D:X EN1^XQOR
 Q
 ;
DBRS ; DG*5.3*951
 ;  add DBRS data to DGPFA()
 N I,X,Y,IENS
 S (I,IENS)=0
 F  S IENS=$O(DGFLDS(26.131,IENS)) Q:IENS=""  D
 . N ARR M ARR=DGFLDS(26.131,IENS)
 . S I=I+1
 . S X=ARR(.01,"I") S DGPFA("DBRS#",I)=X_U_X
 . S (X,Y)=ARR(.02,"I") S:Y="" Y="<no value>"
 . S DGPFA("DBRS OTHER",I)=X_U_Y
 . S DGPFA("DBRS DATE",I)=ARR(.03,"I")_U_ARR(.03,"E")
 . S DGPFA("DBRS SITE",I)=ARR(.04,"I")_U_ARR(.04,"E")
 . Q
 Q
 ;
FLAG(VARPTR) ;
 ;  Verify that variable flag pointer is BEHAVIORAL, Category I
 ;  DGPFIN - required - variable pointer to 26.11 / 26.15
 Q $$FLAG^DGPFUT6(VARPTR,"BEHAVIORAL","I")
 ;
UV() ;  return edited value for DGPFUV
 ;   if '$D(DGPFUV) then set DGPFUV=-1
 ;   also called from ^DGPFUT62
 N Y,RET
 S RET=-1
 S Y=DGPFUV I $D(DGPFUV)#2 D
 . I $L(Y)<2 S RET=$S("dD"[Y:Y,1:"") Q
 . I Y["d" S RET="d" Q
 . I (Y["AD")!(Y["DA") S RET="D" Q
 . S RET=$S(Y["D":"D",1:"")
 . Q
 Q RET
