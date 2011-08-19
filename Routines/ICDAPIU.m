ICDAPIU ;DLS/DEK/KER - ICD UTILITIES FOR APIS ; 04/18/2004
 ;;18.0;DRG Grouper;**6,11,12,15**;Oct 20, 2000
 ;
 ; External References
 ;   DBIA 10103  $$DT^XLFDT
 ;
DTBR(CDT,CS) ; Date Business Rules
 ; Input:
 ;   CDT - Code Date to check (FileMan format, default=Today)
 ;   CS - Code System (0:ICD, 1:CPT/HCPCS, 2:DRG, Default=0)
 ;
 ; Output:
 ;   If CDT < 2781001 and CS=0, use 2781001
 ;   If CDT < 2890101 and CS=1, use 2890101
 ;   If CDT < 2821001 and CS=2, use 2821001
 ;   If CDT is year only, use first of the year
 ;   If CDT is year and month only, use first of the month
 ;
 Q:'$G(CDT) $$DT^XLFDT ;nothing passed - use today
 Q:$L($P(CDT,"."))'=7 $$DT^XLFDT ;bad date format - use today
 N BRDAT ;Business rule date
 S CS=+$G(CS) S:CS>2!(CS<0) CS=0
 S BRDAT=+$P("2781001^2890101^2821001","^",CS+1)
 I CDT#10000=0 S CDT=CDT+101
 S:CDT#100=0 CDT=CDT+1
 Q $S(CDT<BRDAT:BRDAT,1:CDT)
 ;
MSG(CDT,CS) ; inform of code text inaccuracy
 ; Input:
 ;   CDT - Code Date to check (FileMan format, Default = today)
 ;   CS - Code System (0:ICD, 1:CPT/HCPCS, 2:DRG, 3:LEX, Default=0)
 ; Output: User Alert
 ;
 S CS=+$G(CS) S:CS>3!(CS<0) CS=0
 S CDT=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR(CDT,CS))
 N MSGTXT,MSGDAT S MSGDAT=3021001,MSGTXT="CODE TEXT MAY BE INACCURATE"
 I CS<3 Q $S(CDT<MSGDAT:MSGTXT,1:"")
 I CS=3,CDT'<3031001 Q ""
 Q MSGTXT
 ;
STATCHK(CODE,CDT) ; Check Status of ICD Code
 ; Input:
 ;    CODE - ICD Code  REQUIRED
 ;    CDT - Date to screen against (FileMan format, default = today)
 ; Output:
 ;    2-Piece String containing the code's status
 ;    and the IEN if the code exists, else -1.
 ;    The following are possible outputs:
 ;         1^IEN    Active Code
 ;         0^IEN    Inactive Code
 ;         0^-1     Code not Found
 ;
 ; This API requires the ACT Cross-Reference
 ;     ^ICD9("ACT",<code>,<status>,<date>,<ien>)
 ;     ^ICD0("ACT",<code>,<status>,<date>,<ien>)
 ;
 N ICDC,ICDD,ICDIEN,ICDI,ICDA,ICDG,ICDR,X
 S ICDC=$G(CODE) Q:'$L(ICDC) "0^-1"
 ;    Case 1:  Not Valid                           0^-1
 ;             Fails Pattern Match for Code
 S CODE=$$CODEN^ICDCODE(CODE),ICDG=$P(CODE,"~",2),ICDIEN=+CODE
 Q:ICDIEN<1 "0^-1"
 ;    Case 2:  Never Active                        0^IEN
 ;             No Active/Inactive Date
 S ICDD=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR($G(CDT),1)),ICDD=ICDD+.001
 S ICDR=$$ACTROOT(ICDG,ICDC,1,ICDD),ICDA=$O(@(ICDR_")"),-1)
 I '$L(ICDA) D  Q X
 . S ICDA=$O(@(ICDR_")")),X="0^-1" Q:'$L(ICDA)
 . S ICDR=$$ACTROOT(ICDG,ICDC,1,ICDA)
 . S ICDIEN=$O(@(ICDR_",0)")) S:+ICDIEN<1 ICDIEN=-1
 . S X="0^"_ICDIEN
 ;    Case 3:  Active, Never Inactive              1^IEN
 ;             Has an Activation Date
 ;             No Inactivation Date
 S ICDR=$$ACTROOT(ICDG,ICDC,0,ICDD),ICDI=$O(@(ICDR_")"),-1)
 I $L(ICDA),'$L(ICDI) D  Q X
 . S ICDR=$$ACTROOT(ICDG,ICDC,1,ICDA),ICDIEN=$O(@(ICDR_",0)"))
 . S X=$S(+ICDIEN=0:"0^-1",1:"1^"_ICDIEN)
 ;    Case 4:  Active, but later Inactivated       0^IEN
 ;             Has an Activation Date
 ;             Has an Inactivation Date
 I $L(ICDA),$L(ICDI),ICDI>ICDA,ICDI<ICDD D  Q X
 . S ICDR=$$ACTROOT(ICDG,ICDC,0,ICDI),ICDIEN=$O(@(ICDR_",0)"))
 . S X=$S(+ICDIEN=0:"0^-1",1:"0^"_ICDIEN)
 ;    Case 5:  Active, and not later Inactivated   1^IEN
 ;             Has an Activation Date
 ;             Has an Inactivation Date
 ;             Has a Newer Activation Date
 I $L(ICDA),$L(ICDI),ICDI'>ICDA D  Q X
 . S ICDR=$$ACTROOT(ICDG,ICDC,0,ICDI),ICDIEN=$O(@(ICDR_",1)"))
 . S X=$S(+$O(@(ICDR_",0)"))=0:"0^-1",1:"1^"_ICDIEN)
 ;    Case 6:  Fails Time Test                     0^-1
 Q ("0^"_$S(+($G(ICDIEN))>0:+($G(ICDIEN)),1:"-1"))
 ;
NEXT(CODE) ; Next ICD Code (active or inactive)
 ; Input:
 ;    CODE = ICD Code   REQUIRED
 ; Output:
 ;    The Next ICD Code, Null if none
 ;
 N ICDC,ICDG S ICDC=$G(CODE) Q:'$L(ICDC) ""
 Q:ICDC?1.9N ""  ;app passed an IEN
 S ICDG=$P($$CODEN^ICDCODE(ICDC),"~",2)
 Q:ICDG="INVALID CODE" ""
 S ICDC=$O(@(ICDG_"""BA"","""_ICDC_" "")"))
 Q $S(ICDC="":"",1:$E(ICDC,1,$L(ICDC)-1))
 ;
PREV(CODE) ; Previous ICD Code (active or inactive)
 ; Input:
 ;    CODE = ICD Code   REQUIRED
 ; Output:
 ;    The Previous ICD Code, Null if none
 ;
 N ICDC,ICDG
 S ICDC=$G(CODE) Q:'$L(ICDC) ""
 Q:ICDC?1.9N ""  ;app passed an IEN
 S ICDG=$P($$CODEN^ICDCODE(ICDC),"~",2)
 Q:ICDG="INVALID CODE" ""
 S ICDC=$O(@(ICDG_"""BA"","""_ICDC_" "")"),-1)
 Q $S(ICDC="":"",1:$E(ICDC,1,$L(ICDC)-1))
 ;
HIST(CODE,ARY)  ; Activation History
 ; Input:
 ;    CODE - ICD Code                     REQUIRED
 ;    .ARY - Array, passed by Reference   REQUIRED
 ;
 ; Output:    Mirrors ARY(0) (or, -1 on error)
 ;    ARY(0) = Number of Activation History Entries
 ;    ARY(<date>) = status    where: 1 is Active
 ;    ARY("IEN") = <ien>
 ;
 Q:$G(CODE)="" -1
 N ICDC,ICDI,ICDA,ICDN,ICDD,ICDG,ICDF
 S ICDI=$$CODEN^ICDCODE(CODE),ICDG=$P(ICDI,"~",2)
 S ICDI=+ICDI Q:ICDI<1 -1
 S ARY("IEN")=ICDI,ICDA="" M ICDA=@(ICDG_ICDI_",66)")
 K ICDA("B") S ARY(0)=+($P($G(ICDA(0)),"^",4))
 S:+ARY(0)=0 ARY(0)=-1 K:ARY(0)=-1 ARY("IEN")
 S (ICDI,ICDC)=0 F  S ICDI=$O(ICDA(ICDI)) Q:+ICDI=0  D
 . S ICDD=$P($G(ICDA(ICDI,0)),"^",1) Q:+ICDD=0
 . S ICDF=$P($G(ICDA(ICDI,0)),"^",2) Q:'$L(ICDF)
 . S ICDC=ICDC+1,ARY(0)=ICDC,ARY(ICDD)=ICDF
 Q ARY(0)
 ;
PERIOD(CODE,ARY) ; return Activation/Inactivation Period in ARY
 ;
 ; Input:   CODE  ICD Code (required)
 ;          ARY   Array, passed by Reference (required)
 ;
 ; Output:  ARY(0) = IEN^Selectable
 ;            Where IEN = -1 if error
 ;            Selectable = 0 for VA Only codes
 ;
 ;          ARY(Activation Date) = Inactivation Date^Short Name
 ;
 ;            Where the Short Name is the Versioned text (field 1 of the 67
 ;            multiple), and the text is versioned as follows:
 ;
 ;               Period is active - Versioned text for TODAY's date
 ;               Period is inactive - Versioned text for inactivation date
 ;
 ;           or
 ;
 ;         -1^0 (no period or error)
 ;
 I $G(CODE)="" S ARY(0)="-1^0" Q
 N ICDC,ICDI,ICDA,ICDG,ICDF,ICDBA,ICDBI,ICDST,ICDS,ICDZ,ICDV,ICDN,ICDCA
 S ICDC=$$CODEN^ICDCODE(CODE),ICDG=$P(ICDC,"~",2),ICDC=+ICDC
 I ICDC<1 S ARY(0)="-1^0" Q
 S ICDI=$S(ICDG="^ICD9(":3,1:4),ICDZ=$G(@(ICDG_ICDC_",0)"))
 ; Versioned text for TODAY
 S ICDN=$$VST^ICDCODE(ICDC,$$DT^XLFDT,ICDG)
 S ICDS=$P(ICDZ,"^",ICDI),ARY(0)=ICDC_"^"_'$P(ICDZ,"^",8)
 S (ICDA,ICDBA)=0,ICDG=ICDG_ICDC_",66,"
 F  Q:ICDBA  D
 . S ICDA=$O(@(ICDG_"""B"","_ICDA_")"))
 . I ICDA="" S ICDBA=1 Q
 . S ICDF=$O(@(ICDG_"""B"","_ICDA_",0)"))
 . I '+ICDF S ICDBA=1 Q
 . S ICDST=$P($G(@(ICDG_ICDF_",0)")),"^",2)
 . Q:'ICDST  ;outer loop looks for active
 . ; Versioned text for activation date
 . S ICDV=$$VST^ICDCODE(ICDC,ICDA,ICDG),ICDCA=1
 . S:$L(ICDV) ICDS=ICDV
 . S ARY(ICDA)="^"_ICDS,ICDBI=0,ICDI=ICDA
 . F  Q:ICDBI  D
 . . S ICDI=$O(@(ICDG_"""B"","_ICDI_")"))
 . . ; If no inactivation date for ICDA then use TODAY's text
 . . I ICDI="" S ARY(ICDA)="^"_ICDN,(ICDBI,ICDBA)=1 Q
 . . S ICDF=$O(@(ICDG_"""B"","_ICDI_",0)"))
 . . ; If no effective date ICDF for ICDI then use TODAY's text
 . . I '+ICDF S ARY(ICDA)="^"_ICDN,(ICDBI,ICDBA)=1 Q
 . . S ICDST=$P($G(@(ICDG_ICDF_",0)")),"^",2)
 . . ; If Status ICDST not Inactive then use TODAY's text
 . . I ICDST S ARY(ICDA)="^"_ICDN,ICDBI=1 Q
 . . ; Versioned text for inactive date
 . . S ICDV=$$VST^ICDCODE(ICDC,ICDI,ICDG)
 . . S:$L(ICDV) $P(ARY(ICDA),"^",2)=ICDV
 . . S $P(ARY(ICDA),"^")=ICDI
 . . S ICDBI=1,ICDA=ICDI,ICDCA=0
 Q
 ;
ACTROOT(ICDG,ICDC,ICDS,ICDD)  ; Return "ACT" root
 Q (ICDG_"""ACT"","""_ICDC_" "","_ICDS_","_ICDD)
