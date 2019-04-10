DGPFAAH ;ALB/RPM - PRF ASSIGNMENT HISTORY API'S ; 4/8/04 4:13pm
 ;;5.3;Registration;**425,554,951**;Aug 13, 1993;Build 135
 ;     Last Edited: SHRPE/sgm - Aug 16, 2018 11:46
 ;
 ; ICR#  TYPE  DESCRIPTION
 ;-----  ----  ---------------------------------------
 ; 2052  Sup   $$GET1^DID
 ; 2055  Sup   $$VFIELD^DILFD
 ; 2056  Sup   GETS^DIQ
 ; 2053  Sup   ^DIE: FILE, UPDATE
 ;
 Q  ;no direct entry
 ;
GETALL(DGPFIEN,DGPFIENS) ;retrieve list of history IENs for an assignment
 ;
 ;  Input:
 ;    DGPFIEN - (required) Pointer to PRF ASSIGNMENT (#26.13) file
 ;   DGPFIENS - (required) Result array passed by reference
 ;
 ;  Output:
 ;   Function Value - Count of returned IENs
 ;         DGPFIENS - Output array subscripted by assignment history IENs
 ;                    
 N DGCNT   ;number of returned values
 N DGHIEN  ;single history IEN
 ;
 S DGCNT=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.14,"B",DGPFIEN)) D
 . S DGHIEN=0
 . F  S DGHIEN=$O(^DGPF(26.14,"B",DGPFIEN,DGHIEN)) Q:'DGHIEN  D
 . . S DGPFIENS(DGHIEN)=""
 . . S DGCNT=DGCNT+1
 Q DGCNT
 ;
GETALLDT(DGPFIEN,DGPFIENS) ;retrieve list of history IENs for an assignment
 ;
 ;  Input:
 ;    DGPFIEN - (required) Pointer to PRF ASSIGNMENT (#26.13) file
 ;   DGPFIENS - (required) Result array passed by reference
 ;
 ;  Output:
 ;   Function Value - Count of returned IENs
 ;         DGPFIENS - Output array subscripted by assignment history date
 ;
 N DGADT   ;assignment date
 N DGCNT   ;number of returned values
 N DGHIEN  ;single history IEN
 ;
 S DGCNT=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.14,"C",DGPFIEN)) D
 . S DGADT=0
 . F  S DGADT=$O(^DGPF(26.14,"C",DGPFIEN,DGADT)) Q:'DGADT  D
 . . S DGHIEN=0
 . . F  S DGHIEN=$O(^DGPF(26.14,"C",DGPFIEN,DGADT,DGHIEN)) Q:'DGHIEN  D
 . . . S DGPFIENS(DGADT)=DGHIEN
 . . . S DGCNT=DGCNT+1
 Q DGCNT
 ;
GETHIST(DGPFIEN,DGPFAH,DGDBRS) ;retrieve a single assignment history record
 ;
 ;  Input:
 ;   DGPFIEN - (required) IEN for record in PRF ASSIGNMENT HISTORY
 ;             (#26.14) file 
 ;    DGPFAH - (required) Result array passed by reference
 ;    DGDBRS - (optional) If 1, return DBRS info in result array ; dg*951
 ;
 ;  Output:
 ;   Function Value - Return 1 on success, 0 on failure
 ;           DGPFAH - Output array containing the field values
 ;                    Subscript            Field#
 ;                    -----------------    ------
 ;                    "ASSIGN"             .01
 ;                    "ASSIGNDT"           .02
 ;                    "ACTION"             .03
 ;                    "ENTERBY"            .04
 ;                    "APPRVBY"            .05
 ;                    "TIULINK"            .06
 ;                    "ORIGFAC"            .09
 ;                    "COMMENT",line#,0    1
 ;                    "DBRS",line#         2 (multiple, all fields)
 ;                                            p1^p2^p3^p4^p5
 ;                                            p1 = dbrs#
 ;                                            p2 = dbrs_other
 ;                                            p3 = create_date_int;ext
 ;                                            p4 = status_int;ext
 ;                                            p5 = create_by_int;ext
 ;                               p3,p4,p5 - external ';'piece optional
 ;                                            
 ;
 N DGIENS  ;IEN string for DIQ
 N DGFLDS  ;results array for DIQ
 N DGERR  ;error array for DIQ
 N DGRSLT S DGRSLT=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.14,DGPFIEN)) D
 . N ARR,DF,DIERR
 . S DGIENS=DGPFIEN_","
 . S DF="*"
 . I +$G(DGDBRS),$$VFIELD^DILFD(26.14,2) S DF="**"
 . D GETS^DIQ(26.14,DGIENS,DF,"IEZ","DGFLDS","DGERR")
 . Q:$D(DGERR)
 . S DGRSLT=1
 . M ARR=DGFLDS(26.14,DGIENS)
 . S DGPFAH("ASSIGN")=$G(ARR(.01,"I"))_U_$G(ARR(.01,"E"))
 . S DGPFAH("ASSIGNDT")=$G(ARR(.02,"I"))_U_$G(ARR(.02,"E"))
 . S DGPFAH("ACTION")=$G(ARR(.03,"I"))_U_$G(ARR(.03,"E"))
 . S DGPFAH("ENTERBY")=$G(ARR(.04,"I"))_U_$G(ARR(.04,"E"))
 . S DGPFAH("APPRVBY")=$G(ARR(.05,"I"))_U_$G(ARR(.05,"E"))
 . S DGPFAH("TIULINK")=$G(ARR(.06,"I"))_U_$G(ARR(.06,"E"))
 . ;build review comments word processing array
 . M DGPFAH("COMMENT")=ARR(1)
 . K DGPFAH("COMMENT","E"),DGPFAH("COMMENT","I")
 . ;  next two IF statement from DG*5.3*951
 . I $D(ARR(.09)) S DGPFAH("ORIGFAC")=ARR(.09,"I")_U_ARR(.09,"E")
 . I $D(DGFLDS(26.142)) D GETDBRS
 . Q
 . ;
 Q DGRSLT
 ;
GETFIRST(DGPFIEN) ;get IEN of the initial assignment
 ;This function returns the IEN of the initial history record for a
 ;given patient record flag assignment.
 ;
 ;  Input:
 ;   DGPFIEN - (required) IEN of record in PRF ASSIGNMENT (#26.13) file
 ;
 ;  Output:
 ;   Function Value - IEN of initial history record on success
 ;                    0 on failure
 ;
 N DGHIEN  ;history IEN
 N DGEDT   ;edit date
 N DGPFAH  ;history record data array
 ;
 S DGHIEN=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.13,DGPFIEN)) D
 . S DGEDT=$O(^DGPF(26.14,"C",DGPFIEN,0))
 . I DGEDT>0 S DGHIEN=$O(^DGPF(26.14,"C",DGPFIEN,DGEDT,0))
 . Q
 Q $S($G(DGHIEN)>0:DGHIEN,1:0)
 ;
GETLAST(DGPFIEN) ;determine IEN of last assignment history record
 ;This function returns the IEN of the most recent history record for a
 ;given patient record flag assignment.
 ;
 ;  Input:
 ;   DGPFIEN - (required) IEN for record in PRF ASSIGNMENT (#26.13) file 
 ;
 ;  Output:
 ;   Function Value - IEN of last history record on success, 0 on failure
 ;
 N DGDAT
 N DGHIEN
 S DGHIEN=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.13,DGPFIEN)) D
 . S DGDAT=$O(^DGPF(26.14,"C",DGPFIEN,""),-1)
 . I DGDAT>0 D
 . . S DGHIEN=$O(^DGPF(26.14,"C",DGPFIEN,DGDAT,0))
 Q $S($G(DGHIEN)>0:DGHIEN,1:0)
 ;
GETADT(DGPFIEN) ;get the initial assignment date
 ;This function returns the initial assignment date for a given patient
 ;record flag assignment.
 ;
 ;  Input:
 ;   DGPFIEN - (required) IEN for record in PRF ASSIGNMENT (#26.13) file
 ;
 ;  Output:
 ;   Function Value - assignment date in internal^external format on
 ;                    success, 0 on failure
 ;
 N DGHIEN  ;history IEN
 N DGEDT   ;edit date
 N DGADT   ;assignment date
 N DGPFAH  ;history record data array
 ;
 S DGADT=0
 S DGHIEN=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.13,DGPFIEN)) D
 . S DGEDT=$O(^DGPF(26.14,"C",DGPFIEN,0))
 . I DGEDT>0 D
 . . S DGHIEN=$O(^DGPF(26.14,"C",DGPFIEN,DGEDT,0))
 . . I DGHIEN>0,$$GETHIST^DGPFAAH(DGHIEN,.DGPFAH) D
 . . . I $P($G(DGPFAH("ACTION")),U,2)="NEW ASSIGNMENT" D
 . . . . S DGADT=$G(DGPFAH("ASSIGNDT"))
 Q DGADT
 ;
FNDHIST(DGAIEN,DGADT) ;Find Assignment
 ;  This function finds a patient record flag assignment record.
 ;
 ;  Input:
 ;    DGAIEN - Pointer to assignment in the PRF ASSIGNMENT (#26.13) file
 ;     DGADT - Assignment date
 ;
 ;  Output:
 ;   Function Value - Returns IEN of existing record on success, 0 on
 ;                    failure
 ;
 N DGIEN
 ;
 I $G(DGAIEN)>0,($G(DGADT)>0) D
 . S DGIEN=$O(^DGPF(26.14,"C",DGAIEN,DGADT,0))
 Q $S($G(DGIEN)>0:DGIEN,1:0)
 ;
STOHIST(DGPFAH,DGPFERR) ;
 ;File a PRF ASSIGNMENT HISTORY (#26.14) file record
 ;
 ;  Input:
 ;   .DGPFAH - (required) Array of values to be filed (see GETHIST tag
 ;             above for valid array structure)
 ;  .DGPFERR - (optional) Passed by reference to contain error messages
 ;
 ;  Output:
 ;   Function Value - Returns IEN of record on success, 0 on failure
 ;          DGPFERR - Undefined on success, error message on failure
 ;
 N DGSUB
 N DGFLD
 N DGIEN
 N DGIENS
 N DGFDA
 N DGFDAIEN
 N DGERR
 N UPD
 ;
 F DGSUB="ASSIGN","ASSIGNDT","ACTION","ENTERBY","APPRVBY","TIULINK" D
 . S DGFLD(DGSUB)=$P($G(DGPFAH(DGSUB)),U)
 . Q
 I $D(DGPFAH("COMMENT")) M DGFLD("COMMENT")=DGPFAH("COMMENT")
 S X=$G(DGPFAH("ORIGFAC")) I +X S DGFLD("ORIGFAC")=+X ;  DG*5.3*951
 I $D(DGPFAH("DBRS")) M DGFLD("DBRS")=DGPFAH("DBRS") ;   DG*5.3*951
 ;
 I $$VALID^DGPFUT("DGPFAAH1",26.14,.DGFLD,.DGPFERR) D
 . N X,DIERR
 . S DGIEN=$$FNDHIST^DGPFAAH(DGFLD("ASSIGN"),DGFLD("ASSIGNDT"))
 . I DGIEN S DGIENS=DGIEN_","
 . E  S DGIENS="+1,"
 . S DGFDA(26.14,DGIENS,.01)=DGFLD("ASSIGN")
 . S DGFDA(26.14,DGIENS,.02)=DGFLD("ASSIGNDT")
 . S DGFDA(26.14,DGIENS,.03)=DGFLD("ACTION")
 . S DGFDA(26.14,DGIENS,.04)=DGFLD("ENTERBY")
 . S DGFDA(26.14,DGIENS,.05)=DGFLD("APPRVBY")
 . S DGFDA(26.14,DGIENS,.06)=DGFLD("TIULINK")
 . S DGFDA(26.14,DGIENS,1)=$NA(DGFLD("COMMENT"))
 . S X=+$G(DGFLD("ORIGFAC")) I X S DGFDA(26.14,DGIENS,.09)=X
 . ;  add in DBRS data to DGFDA
 . I $D(DGFLD("DBRS")) D  Q:$D(DGERR)
 . . D STOHIST^DGPFUT6(DGIENS,.DGFLD,.DGFDA,.DGERR)
 . . I $D(DGERR) S DGIEN=0
 . . Q
 . ;
 . ;determine if update or file should be called
 . S UPD=(DGIENS["+") I 'UPD D
 . . N I,J
 . . S I=0 F J=0:0 S I=$O(DGFDA(26.142,I)) Q:I=""  I I["+" S UPD=1 Q
 . . Q
 . ;
 . I 'UPD D
 . . N DGERR,DIERR
 . . D FILE^DIE("","DGFDA","DGERR")
 . . I $D(DGERR) S DGIEN=0
 . . Q
 . E  D
 . . N DGERR,DGFDAIEN,DIERR
 . . S DGFDAIEN=""
 . . I DGIENS="+1," S DGFDAIEN="DGFDAIEN",DGFDAIEN(1)=""
 . . D UPDATE^DIE("","DGFDA",DGFDAIEN,"DGERR")
 . . I $D(DGERR) S DGIEN=0 Q
 . . I DGIENS="+1," S DGIEN=+$G(DGFDAIEN(1))
 . . Q
 . Q
 Q $S($G(DGIEN)>0:DGIEN,1:0)
 ;
GETDBRS ;  called from GETHIST
 ;  expects DGFLDS() to contain GETS^DIQ(26.14) with all fields "**"
 ;  Return sorted by DBRS#:
 ;    DGPFAH("DBRS",inc) = p1^p2^p3^p4^p5
 ;      p1=DBRS#     p2=Other     p3=date_int;ext     p4=status_int;ext  
 ;      p5=site_int;ext
 ;
 N I,J,X,Y,DBNM,IENS,TMP
 S IENS=0 F  S IENS=$O(DGFLDS(26.142,IENS)) Q:'IENS  D
 . N ARR M ARR=DGFLDS(26.142,IENS)
 . S (X,DBNM)=$G(ARR(.01,"E")) Q:X=""
 . S $P(X,U,2)=$G(ARR(.02,"E"))
 . S $P(X,U,3)=$G(ARR(.03,"I"))_";"_$P($G(ARR(.03,"E")),":",1,2)
 . S $P(X,U,4)=$G(ARR(.04,"I"))_";"_$G(ARR(.04,"E"))
 . S $P(X,U,5)=$G(ARR(.05,"I"))_";"_$G(ARR(.05,"E"))
 . S TMP(DBNM,+IENS)=X
 . Q
 S X="TMP" F J=1:1 S X=$Q(@X) Q:X=""  S DGPFAH("DBRS",J)=@X
 Q
