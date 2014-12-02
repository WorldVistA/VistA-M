ICDEXA ;SLC/KER - ICD Extractor - APIs/Utilities ;04/21/2014
 ;;18.0;DRG Grouper;**57**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    $$GET1^DIQ          ICR   2056
 ;    $$DT^XLFDT          ICR  10103
 ;               
DTBR(CDT,STD,SYS) ; Date Business Rules
 ;
 ; Input:
 ; 
 ;   CDT   Code Date to check (FileMan format, default=Today)
 ;   STD   Standard
 ;   
 ;           0 = ICD (Default)
 ;           1 = CPT/HCPCS
 ;           2 = DRG
 ;           
 ;   SYS   Coding System
 ;   
 ;           1 = ICD-9-CM
 ;           2 = ICD-9-PCS
 ;          30 = ICD-10-CM
 ;          31 = ICD-10-PCS
 ;
 ; Output:
 ; 
 ;   If CDT < ICD-9 Date and STD=0, use ICD-9 Date
 ;   If CDT < ICD-10 Date and STD=0 and SYS=30, use ICD-10 Date
 ;   If CDT < ICD-10 Date and STD=0 and SYS=31, use ICD-10 Date
 ;   If CDT < 2890101 and STD=1, use 2890101
 ;   If CDT < 2821001 and STD=2, use 2821001
 ;   If CDT is year only, use first of the year
 ;   If CDT is year and month only, use first of the month
 ;
 S CDT=$G(CDT)
 ;   Nothing Passed, use TODAY
 Q:'$G(CDT) $$DT^XLFDT
 ;   Invalid Date Format, use TODAY
 Q:$L($P(CDT,"."))'=7 $$DT^XLFDT
 N BRDAT ;   Business rule date
 N ICD9,ICD10,ICDDS
 S ICD9=$$IMP^ICDEX(1),ICD10=$$IMP^ICDEX(30)
 S ICDDS=ICD9_"^2890101^2821001"
 S STD=+$G(STD) S:STD>2!(STD<0) STD=0  S SYS=$G(SYS)
 S BRDAT=+$P(ICDDS,"^",STD+1)
 S:+($G(STD))'>0&("^30^31^"[("^"_SYS_"^")) BRDAT=ICD10
 I CDT#10000=0 S CDT=CDT+101
 S:CDT#100=0 CDT=CDT+1
 Q $S(CDT<BRDAT:BRDAT,1:CDT)
 ;
IMP(SYS,CDT) ; Coding System Implementation Date
 ;
 ; Input:
 ; 
 ;   SYS   Coding System
 ;   
 ;           1 = ICD-9-CM
 ;           2 = ICD-9-PCS
 ;          30 = ICD-10-CM
 ;          31 = ICD-10-PCS
 ;
 ; Output:
 ; 
 ;   $$IMP  Date the Coding System was Implemented/Activated
 ;   
 N ICDD,ICDS,ICDN
 S ICDD=$S($G(CDT)'?7N:$$DT^XLFDT,1:$G(CDT))
 S ICDS=$$SYS^ICDEX($G(SYS),ICDD,"I") Q:+ICDS'>0 "-1^Coding system Unknown"
 S ICDN=$P($G(^ICDS(+ICDS,0)),"^",4) Q:ICDN'?7N "-1^Implementation Date not found"
 Q ICDN
 ;
MSG(CDT,STD,SYS) ; Inform of code text inaccuracy
 ;
 ; Input:
 ; 
 ;   CDT   Code Date to check (FileMan format, Default = today)
 ;   STD   Code System
 ;    
 ;            0   ICD (default)
 ;            1   CPT/HCPCS
 ;            2   DRG
 ;            3   LEX
 ;           
 ;   SYS   Coding System
 ;   
 ;           1 = ICD-9-CM
 ;           2 = ICD-9-PCS
 ;          30 = ICD-10-CM
 ;          31 = ICD-10-PCS
 ;          
 ; Output: 
 ; 
 ;   User Alert Message
 ;
 S STD=+$G(STD) S:STD>3!(STD<0) STD=0
 S CDT=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR(CDT,STD,$G(SYS)))
 N MSGTXT,MSGDAT S MSGDAT=3021001,MSGTXT="CODE TEXT MAY BE INACCURATE"
 I STD<3 Q $S(CDT<MSGDAT:MSGTXT,1:"")
 I STD=3,CDT'<3031001 Q ""
 Q MSGTXT
 ;
STATCHK(CODE,CDT,SYS) ; Check Status of ICD Code
 ;
 ; Input:
 ; 
 ;    CODE   ICD Code  REQUIRED
 ;    CDT    Date to screen against (default = TODAY)
 ;    SYS    Numeric Coding System (optional, however, if
 ;           specified it must be correct)
 ;    
 ; Output:
 ; 
 ;    3-Piece String containing the code's status
 ;    and the IEN if the code exists, else -1.
 ;    The following are possible outputs:
 ;    
 ;         1^IEN^Effective Date     Active Code
 ;         0^IEN^Effective Date     Inactive Code
 ;         0^IEN^Null               Future Activation (pending)
 ;         0^-1^Error Message       Code not Found or Error
 ;
 ; This API requires the ACT Cross-Reference
 ;     ^ICD9("ACT",<code>,<status>,<date>,<ien>)
 ;     ^ICD0("ACT",<code>,<status>,<date>,<ien>)
 ;
 N ICDC,ICDD,ICDIEN,ICDI,ICDA,ICDG,ICDR,ICDS,ICDY,ICDF,ICDEF,ICDBR,ICDTD,X
 S ICDS="",ICDC=$G(CODE) Q:'$L(ICDC) "0^-1^No code specified"
 S:$L($G(SYS)) ICDS=$$SYS^ICDEX($G(SYS),$G(CDT))
 S:'$L($G(SYS))&($L(ICDC)) ICDS=$$SYS^ICDEX(ICDC)
 Q:'$L($G(SYS))&(+ICDS'>0) "0^-1^No coding system specified"
 Q:$L($G(SYS))&(+ICDS'>0) "0^-1^Invalid coding system specified"
 ;    Case 1:  Not Valid                           0^-1
 ;             Fails Pattern Match for Code
 S ICDF=$$FILE^ICDEX(ICDS) S:ICDF'>0 ICDF=$$CODEFI^ICDEX(CODE)
 S:+ICDF'>0 ICDF="" S CODE=$$CODEN^ICDEX(CODE,ICDF)
 S:+ICDF>0&(+CODE>0) ICDC=$$CODEC^ICDEX(+ICDF,+CODE)
 S ICDG=$P(CODE,"~",2),ICDIEN=+CODE
 Q:ICDIEN<1 "0^-1^Code not found"
 S ICDY=$P($G(@(ICDG_+ICDIEN_",1)")),"^",1)
 Q:+ICDS>0&(ICDY>0)&(ICDS'=ICDY) "0^-1^Code not valid for Coding System"
 ;    Case 2:  Never Active                        0^IEN
 ;             No Active/Inactive Date
 S ICDD=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR($G(CDT),,+ICDS)),ICDD=ICDD+.001
 S ICDR=$$ACTROOT(ICDG,ICDC,1,ICDD),ICDA=$O(@(ICDR_")"),-1)
 I '$L(ICDA) D  Q X
 . S ICDA=$O(@(ICDR_")")),X="0^-1" Q:'$L(ICDA)
 . S ICDR=$$ACTROOT(ICDG,ICDC,1,ICDA)
 . S ICDIEN=$O(@(ICDR_",0)")) S:+ICDIEN<1 ICDIEN=-1
 . S X="0^"_ICDIEN_"^"
 ;    Case 3:  Active, Never Inactive              1^IEN^Effective Date
 ;             Has an Activation Date
 ;             No Inactivation Date
 S ICDR=$$ACTROOT(ICDG,ICDC,0,ICDD),ICDI=$O(@(ICDR_")"),-1)
 I $L(ICDA),'$L(ICDI) D  Q X
 . S ICDR=$$ACTROOT(ICDG,ICDC,1,ICDA),ICDIEN=$O(@(ICDR_",0)"))
 . S X=$S(+ICDIEN=0:"0^-1",1:"1^"_ICDIEN)
 . S:X'["-1"&(ICDA?7N) X=X_"^"_ICDA
 ;    Case 4:  Active, but later Inactivated       0^IEN^Effective Date
 ;             Has an Activation Date
 ;             Has an Inactivation Date
 I $L(ICDA),$L(ICDI),ICDI>ICDA,ICDI<ICDD D  Q X
 . S ICDR=$$ACTROOT(ICDG,ICDC,0,ICDI)
 . S ICDIEN=$O(@(ICDR_",0)"))
 . S X=$S(+ICDIEN=0:"0^-1",1:"0^"_ICDIEN)
 . S:X'["-1"&(ICDI?7N) X=X_"^"_ICDI
 ;    Case 5:  Active, and not later Inactivated   1^IEN^Effective Date
 ;             Has an Activation Date
 ;             Has an Inactivation Date
 ;             Has a Newer Activation Date
 I $L(ICDA),$L(ICDI),ICDI'>ICDA D  Q X
 . S ICDR=$$ACTROOT(ICDG,ICDC,0,ICDI),ICDIEN=$O(@(ICDR_",1)"))
 . S X=$S(+$O(@(ICDR_",0)"))=0:"0^-1",1:"1^"_ICDIEN)
 . S:X'["-1"&(ICDA?7N) X=X_"^"_ICDA
 ;    Case 6:  Fails Time Test                     0^-1
 Q ("0^"_$S(+($G(ICDIEN))>0:+($G(ICDIEN)),1:"-1"))
 ;
ACTROOT(ICDG,ICDC,ICDS,ICDD)  ; Return "ACT" root
 Q (ICDG_"""ACT"","""_ICDC_" "","_ICDS_","_ICDD)
 ;
SEL(FILE,IEN) ; Entry is Selectable
 ;
 ; Input:
 ; 
 ;    FILE   File number 80 or 80.1 (required)
 ;    IEN    Internal Entry Number (required)
 ;
 ; Output:  
 ; 
 ;    $$SEL  Boolean value
 ;    
 ;             1  Selectable
 ;             0  Not Selectable
 ;          
 ;            -1  on error
 ;           
 N ICDF,ICDI,ICDR,ICDS
 S ICDF=$G(FILE) Q:"^80^80.1^"'[("^"_$G(ICDF)_"^") -1
 S ICDR=$$ROOT^ICDEX(ICDF) Q:'$L(ICDR) -1
 S ICDI=+($G(IEN)) Q:ICDI'>0 -1
 Q:'$D(@(ICDR_ICDI_",0)")) -1
 S ICDS=+($$GET1^DIQ(ICDF,(+ICDI_","),1.8))
 Q $S(ICDS>0:0,1:1)
