DGPFALH ;ALB/RBS - PRF LOCAL FLAG HISTORY API'S ; 3/10/03 3:14pm
 ;;5.3;Registration;**425**;Aug 13, 1993
 ;
 Q  ;no direct entry
 ;
GETALL(DGPFIEN,DGPFIENS) ;retrieve list of history IENs for a Local Flag
 ;
 ;  Input:
 ;    DGPFIEN - (required) Pointer to PRF LOCAL FLAG (#26.11) file
 ;   DGPFIENS - (required) Result array passed by reference
 ;
 ;  Output:
 ;   Function Value - Count of returned IENs
 ;   DGPFIENS - Output array subscripted by Local Flag history IENs
 ;                    
 N DGCNT   ;number of returned values
 N DGHIEN  ;single history IEN
 ;
 S DGCNT=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.12,"B",DGPFIEN)) D
 . S DGHIEN=0
 . F  S DGHIEN=$O(^DGPF(26.12,"B",DGPFIEN,DGHIEN)) Q:'DGHIEN  D
 . . S DGPFIENS(DGHIEN)=""
 . . S DGCNT=DGCNT+1
 Q DGCNT
 ;
 ;
GETALLDT(DGPFIEN,DGPFIENS) ;retrieve list of history IENs for a Local Flag
 ; Retrieve list of history IENs for a Local Flag and place in a local
 ; array subscripted by Flag Edit Date/Time.
 ;
 ;  Input:
 ;    DGPFIEN - (required) Pointer to PRF LOCAL FLAG (#26.11) file
 ;   DGPFIENS - (required) Result array passed by reference
 ;
 ;  Output:
 ;   Function Value - Count of returned IENs
 ;   DGPFIENS - Output array containing Local Flag history IENs,
 ;              subscripted by Flag Edit Date/Time
 ;              Ex. DGPFIENS(3030310.1025)=2
 ;
 ;                    
 N DGCNT   ;number of returned values
 N DGDT    ;flag edit date/time
 N DGHIEN  ;single history IEN
 ;
 S DGCNT=0
 ;
 I $G(DGPFIEN)>0,$D(^DGPF(26.12,"C",DGPFIEN)) D
 . S DGDT=0
 . F  S DGDT=$O(^DGPF(26.12,"C",DGPFIEN,DGDT)) Q:'DGDT  D
 . . S DGHIEN=0
 . . F  S DGHIEN=$O(^DGPF(26.12,"C",DGPFIEN,DGDT,DGHIEN)) Q:'DGHIEN  D
 . . . S DGPFIENS(DGDT)=DGHIEN
 . . . S DGCNT=DGCNT+1
 ;
 Q DGCNT
 ;
 ;
GETHIST(DGPFIEN,DGPFLH) ;retrieve a single Local Flag history record
 ;
 ;  Input:
 ;   DGPFIEN - (required) IEN for record in PRF LOCAL FLAG HISTORY
 ;             (#26.12) file
 ;    DGPFLH - (required) Result array passed by reference
 ;
 ;  Output:
 ;   Function Value - Return 1 on success, 0 on failure
 ;           DGPFLH - Output array containing the field values
 ;                    Subscript            Field#
 ;                    -----------------    ------
 ;                    "FLAG"               .01
 ;                    "ENTERDT"            .02
 ;                    "ENTERBY"            .03
 ;                    "REASON",line#,0     .04
 ;
 N DGIENS  ;IEN string for DIQ
 N DGFLDS  ;results array for DIQ
 N DGERR  ;error array for DIQ
 N DGRSLT
 S DGRSLT=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.12,DGPFIEN)) D
 . S DGIENS=DGPFIEN_","
 . D GETS^DIQ(26.12,DGIENS,"*","IEZ","DGFLDS","DGERR")
 . Q:$D(DGERR)
 . S DGRSLT=1
 . S DGPFLH("FLAG")=$G(DGFLDS(26.12,DGIENS,.01,"I"))_U_$G(DGFLDS(26.12,DGIENS,.01,"E"))
 . S DGPFLH("ENTERDT")=$G(DGFLDS(26.12,DGIENS,.02,"I"))_U_$G(DGFLDS(26.12,DGIENS,.02,"E"))
 . S DGPFLH("ENTERBY")=$G(DGFLDS(26.12,DGIENS,.03,"I"))_U_$G(DGFLDS(26.12,DGIENS,.03,"E"))
 . ;build reason of enter/edit word processing array
 . M DGPFLH("REASON")=DGFLDS(26.12,DGIENS,.04)
 . K DGPFLH("REASON","E"),DGPFLH("REASON","I")
 . ;
 Q DGRSLT
 ;
 ;
GETLAST(DGPFIEN) ;determine IEN of last Local Flag history record
 ;This function returns the IEN of the most recent history record for
 ;a given Local Flag record.
 ;
 ;  Input:
 ;   DGPFIEN - (required) IEN of record in PRF LOCAL FLAG(#26.11) file
 ;
 ;  Output:
 ;   Function Value - IEN of last history record on success
 ;                  - 0 on failure
 N DGDAT,DGHIEN
 S DGHIEN=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.11,DGPFIEN)) D
 . S DGDAT=$O(^DGPF(26.12,"C",DGPFIEN,""),-1)
 . I DGDAT>0 D
 . . S DGHIEN=$O(^DGPF(26.12,"C",DGPFIEN,DGDAT,0))
 Q $S($G(DGHIEN)>0:DGHIEN,1:0)
 ;
 ;
GETADT(DGPFIEN) ;get the initial entry date/time
 ;This function returns the initia entry date/time for a given Local
 ;record flag.
 ;
 ;  Input:
 ;   DGPFIEN - (required) IEN of record in PRF LOCAL FLAG(#26.11) file
 ;
 ;  Output:
 ;   Function Value - Entry date/time on success (internal^external)
 ;                    0 on failure
 ;
 N DGHIEN  ;history IEN
 N DGEDT   ;edit date
 N DGADT   ;entry date
 N DGPFLH  ;history record data array
 ;
 S DGADT=0
 S DGHIEN=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.11,DGPFIEN)) D
 . S DGEDT=$O(^DGPF(26.12,"C",DGPFIEN,0))
 . I DGEDT>0 D
 . . S DGHIEN=$O(^DGPF(26.12,"C",DGPFIEN,DGEDT,0))
 . . I DGHIEN>0,$$GETHIST^DGPFALH(DGHIEN,.DGPFLH) D
 . . . S DGADT=$G(DGPFLH("ENTERDT"))
 Q DGADT
 ;
 ;
STOHIST(DGPFLH,DGPFERR) ;file a PRF LOCAL FLAG HISTORY (#26.12) file record
 ;
 ;  Input:
 ;    DGPFLH - (required) Array of values to be filed (see GETHIST tag
 ;             above for valid array structure)
 ;   DGPFERR - (optional) Passed by reference to contain error msg's
 ;
 ;  Output:
 ;   Function Value - Returns IEN of record on success
 ;                  - 0 on failure
 ;          DGPFERR - Undefined on success, error message on failure
 ;
 N DGSUB,DGFLD,DGIEN,DGIENS,DGFDA,DGFDAIEN,DGERR
 ;
 F DGSUB="FLAG","ENTERDT","ENTERBY" D
 . S DGFLD(DGSUB)=$P($G(DGPFLH(DGSUB)),U)
 I $D(DGPFLH("REASON")) M DGFLD("REASON")=DGPFLH("REASON")
 I $$VALID^DGPFUT("DGPFALH",26.12,.DGFLD,.DGPFERR) D
 . S DGIENS="+1,"
 . S DGFDA(26.12,DGIENS,.01)=DGFLD("FLAG")
 . S DGFDA(26.12,DGIENS,.02)=DGFLD("ENTERDT")
 . S DGFDA(26.12,DGIENS,.03)=DGFLD("ENTERBY")
 . S DGFDA(26.12,DGIENS,.04)="DGFLD(""REASON"")"
 . D UPDATE^DIE("","DGFDA","DGFDAIEN","DGERR")
 . I '$D(DGERR) S DGIEN=$G(DGFDAIEN(1))
 Q $S($G(DGIEN)>0:DGIEN,1:0)
 ;
 ;
 ; PRF LOCAL FLAG field VALIDATION DATA
XREF ;;array node name;field#;required param;word processing?;description
 ;;FLAG;.01;1;0;flag name
 ;;ENTERDT;.02;1;0;pointer to NEW PERSON (#200) file
 ;;ENTERBY;.03;1;0;pointer to NEW PERSON (#200) file
 ;;REASON;.04;1;1;Reason of Flag enter/edit
