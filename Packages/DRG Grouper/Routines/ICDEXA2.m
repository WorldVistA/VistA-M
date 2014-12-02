ICDEXA2 ;SLC/KER - ICD Extractor - APIs/Utilities (cont) ;04/21/2014
 ;;18.0;DRG Grouper;**57**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    ^ICD0("AVA"         N/A
 ;    ^ICD9("AVA"         N/A
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;
 Q
NEXT(CODE,SYS,CDT) ; Next ICD Code (active or inactive)
 ;
 ; Input:
 ; 
 ;    CODE   ICD Code or Null for the first code
 ;    SYS    Coding System - see ^ICDS
 ;              
 ;              1 = ICD-9-CM
 ;              2 = ICD-9-PCS
 ;             30 = ICD-10-CM
 ;             31 = ICD-10-PCS
 ;             
 ;   CDT   Code Date to check
 ;         If CDT is passed, then the code
 ;         returned is the next active code
 ;         based on date.  If it is not 
 ;         passed then the next code is
 ;         returned regardless of status.
 ;         
 ; Output:
 ; 
 ;    The Next ICD Code, Null if none
 ;
 N ICDB,ICDC,ICDG,ICDF,ICDD,ICDE,ICDI,ICDR,ICDS,ICDO,ICDN,ICDY
 S ICDC=$TR($G(CODE)," ",""),ICDD=$G(CDT),ICDB=ICDD?7N
 S ICDY=$$SYS^ICDEX(+($G(SYS)))
 S:ICDY'>0&($L(ICDC)) ICDY=$$SYS^ICDEX(ICDC)
 S ICDF=$$FILE^ICDEX(+ICDY)
 Q:'$L(ICDC)&(ICDY'>0) "" S ICDS=0,ICDE=""
 S:+ICDY>0 ICDS=+ICDY I $L(ICDC) D
 . S:"^80^80.1^"'[("^"_ICDF_"^") ICDF=$$CODEFI^ICDEX(ICDC)
 . S ICDE=$P($$CODECS^ICDEX(ICDC,ICDF),"^",1) S:ICDS>0 ICDE=ICDS
 Q:+ICDY>0&(+($G(ICDE))>0)&(+ICDY'=+($G(ICDE))) ""
 S:+ICDS'>0&(+($G(ICDE))>0) ICDS=+($G(ICDE))
 Q:+ICDS'>0 ""  S ICDR=$$ROOT^ICDEX(ICDS) Q:'$L(ICDR) ""
 S ICDO=$$NUM^ICDEX(ICDC) Q:$L(ICDC)&(+ICDO'>0) ""
 I 'ICDB S ICDC="" D  Q $S(ICDC="":"",1:ICDC)
 . S ICDN=$O(@(ICDR_"""AN"","_+ICDS_","_+ICDO_")"))
 . S ICDC=$S(+ICDN>0:$$COD^ICDEX(+ICDN),1:"")
 I ICDB S ICDC="" D  Q $S(ICDC="":"",1:ICDC)
 . N ICDA S ICDA="" F  S ICDO=$O(@(ICDR_"""AN"","_+ICDS_","_+ICDO_")")) Q:+ICDO'>0  D  Q:$L(ICDC)
 . . N ICDI S ICDI=0 F  S ICDI=$O(@(ICDR_"""AN"","_+ICDS_","_+ICDO_","_+ICDI_")")) Q:+ICDI'>0  D  Q:$L(ICDC)
 . . . N ICDE,ICDH S ICDE=$O(@(ICDR_+ICDI_",66,""B"","_(ICDD+.001)_")"),-1) Q:ICDE'?7N
 . . . S ICDH=$O(@(ICDR_+ICDI_",66,""B"","_ICDE_","" "")"),-1) Q:+ICDH'>0
 . . . S ICDA=$G(@(ICDR_+ICDI_",66,"_ICDH_",0)")),ICDA=+($P(ICDA,"^",2))
 . . . S:+ICDA>0 ICDC=ICDO S ICDC=$S(+($G(ICDC))>0:$$COD^ICDEX(+ICDC),1:"")
 Q $S(ICDC="":"",1:ICDC)
PREV(CODE,SYS,CDT) ; Previous ICD Code (active or inactive)
 ;
 ; Input:
 ; 
 ;    CODE   ICD Code or Null for the last code
 ;    SYS    Coding System - see ^ICDS
 ;              
 ;              1 = ICD-9-CM
 ;              2 = ICD-9-PCS
 ;             30 = ICD-10-CM
 ;             31 = ICD-10-PCS
 ;             
 ;   CDT   Code Date to check
 ;         If CDT is passed, then the code
 ;         returned is the previous active 
 ;         code based on date.  If it is 
 ;         not passed then the previous 
 ;         code is returned regardless of 
 ;         status.
 ;         
 ; Output:
 ; 
 ;    The Previous ICD Code, Null if none
 ;
 N ICDB,ICDC,ICDG,ICDF,ICDD,ICDE,ICDI,ICDR,ICDS,ICDO,ICDN,ICDY
 S ICDC=$TR($G(CODE)," ",""),ICDD=$G(CDT),ICDB=ICDD?7N
 S ICDY=$$SYS^ICDEX(+($G(SYS)))
 S:ICDY'>0&($L(ICDC)) ICDY=$$SYS^ICDEX(ICDC)
 S ICDF=$$FILE^ICDEX(+ICDY)
 Q:'$L(ICDC)&(ICDY'>0) "" S ICDS=0,ICDE=""
 S:+ICDY>0 ICDS=+ICDY I $L(ICDC) D
 . S:"^80^80.1^"'[("^"_ICDF_"^") ICDF=$$CODEFI^ICDEX(ICDC)
 . S ICDE=$P($$CODECS^ICDEX(ICDC,ICDF),"^",1) S:ICDS>0 ICDE=ICDS
 Q:+ICDY>0&(+($G(ICDE))>0)&(+ICDY'=+($G(ICDE))) ""
 S:+ICDS'>0&(+($G(ICDE))>0) ICDS=+($G(ICDE)) Q:+ICDS'>0 ""
 S ICDR=$$ROOT^ICDEX(ICDS) Q:'$L(ICDR) ""
 S ICDO=$$NUM^ICDEX(ICDC) Q:$L(ICDC)&(+ICDO'>0) ""
 I 'ICDB D  Q $S(ICDC="":"",1:ICDC)
 . S:+ICDO'>0 ICDO=$O(@(ICDR_"""AN"","_+ICDS_","" "")"),-1)+1
 . S ICDN=0,ICDC=""
 . S ICDN=$O(@(ICDR_"""AN"","_+ICDS_","_+ICDO_")"),-1)
 . S ICDC=$S(+ICDN>0:$$COD^ICDEX(+ICDN),1:"")
 I ICDB S ICDC="" D  Q $S(ICDC="":"",1:ICDC)
 . N ICDA S ICDA="" S:+ICDO'>0 ICDO=$O(@(ICDR_"""AN"","_+ICDS_","" "")"),-1)+1
 . F  S ICDO=$O(@(ICDR_"""AN"","_+ICDS_","_+ICDO_")"),-1) Q:+ICDO'>0  D  Q:$L(ICDC)
 . . N ICDI S ICDI=0 F  S ICDI=$O(@(ICDR_"""AN"","_+ICDS_","_+ICDO_","_+ICDI_")")) Q:+ICDI'>0  D  Q:$L(ICDC)
 . . . N ICDE,ICDH S ICDE=$O(@(ICDR_+ICDI_",66,""B"","_(ICDD+.001)_")"),-1) Q:ICDE'?7N
 . . . S ICDH=$O(@(ICDR_+ICDI_",66,""B"","_ICDE_","" "")"),-1) Q:+ICDH'>0
 . . . S ICDA=$G(@(ICDR_+ICDI_",66,"_ICDH_",0)")),ICDA=+($P(ICDA,"^",2))
 . . . S:+ICDA>0 ICDC=ICDO S ICDC=$S(+($G(ICDC))>0:$$COD^ICDEX(+ICDC),1:"")
 Q $S(ICDC="":"",1:ICDC)
HIST(CODE,ARY,SYS)  ; Activation History
 ;
 ; Input:
 ; 
 ;    CODE   ICD Code                   (required)
 ;    .ARY   Array, passed by Reference (required)
 ;    SYS    Coding System - see ^ICDS
 ;              
 ;              1 = ICD-9-CM
 ;              2 = ICD-9-PCS
 ;             30 = ICD-10-CM
 ;             31 = ICD-10-PCS
 ;
 ; Output:    Mirrors ARY(0) (or, -1 on error)
 ; 
 ;    ARY(0) = Number of Activation History Entries
 ;    ARY(<date>) = status    where: 1 is Active
 ;    ARY("IEN") = <ien>
 ;
 Q:$G(CODE)="" -1  K ARY
 N ICDC,ICDF,ICDS,ICDE,ICDI,ICDA,ICDN,ICDD,ICDR,ICDF,ICDS,ICDY
 S ICDC=$TR($G(CODE)," ","") Q:'$L(ICDC) -1  S ICDY=$$SYS^ICDEX($G(SYS))
 S:+ICDY'>0 ICDY=$$SYS^ICDEX(ICDC)
 S ICDS=0 S:+ICDY>0 ICDS=+ICDY
 S ICDF=$$CODEFI^ICDEX(ICDC) Q:+ICDF'>0 -1
 S ICDE=$P($$CODECS^ICDEX(ICDC,ICDF),"^",1) Q:+ICDE'>0 -1
 S:+ICDS'>0&(+ICDE>0) ICDS=ICDE
 Q:+ICDS>0&(ICDS'=+ICDE) -1
 S ICDR=$$ROOT^ICDEX(ICDF) Q:'$L(ICDR) -1
 S ICDI=$$CODEABA^ICDEX(ICDC,ICDR,+ICDS) Q:+ICDI'>0 -1
 S ICDE=$P($G(@(ICDR_ICDI_",1)")),"^",1) Q:+ICDS>0&(ICDS'=+ICDE) -1
 S ARY("IEN")=ICDI,ICDA="" M ICDA=@(ICDR_ICDI_",66)")
 K ICDA("B") S ARY(0)=+($P($G(ICDA(0)),"^",4))
 S:+ARY(0)=0 ARY(0)=-1 K:ARY(0)=-1 ARY("IEN")
 S (ICDI,ICDC)=0 F  S ICDI=$O(ICDA(ICDI)) Q:+ICDI=0  D
 . S ICDD=$P($G(ICDA(ICDI,0)),"^",1) Q:+ICDD=0
 . S ICDF=$P($G(ICDA(ICDI,0)),"^",2) Q:'$L(ICDF)
 . S ICDC=ICDC+1,ARY(0)=ICDC,ARY(ICDD)=ICDF
 Q ARY(0)
PERIOD(CODE,ARY,SYS) ; Return Activation/Inactivation Period in ARY
 ;
 ; Input:
 ; 
 ;    CODE   ICD Code (required)
 ;    ARY    Array, passed by Reference (required)
 ;    SYS    Coding System - see ^ICDS
 ;              
 ;              1 = ICD-9-CM
 ;              2 = ICD-9-PCS
 ;             30 = ICD-10-CM
 ;             31 = ICD-10-PCS
 ;
 ; Output:  
 ; 
 ;          $$PERIOD  Number of activation periods found
 ; 
 ;          ARY(0) = IEN ^ Selectable ^ Error Message
 ;          
 ;            Where IEN = -1 if error
 ;            Selectable = 0 for unselectable
 ;            Error Message if applicable
 ;            
 ;          ARY(Activation Date) = Inactivation Date^Short Name
 ;
 ;            Where the Short Name is versioned as follows:
 ;
 ;            Period is active   - Text for TODAY's date
 ;            Period is inactive - Text for inactivation date
 ;
 I $G(CODE)="" S ARY(0)="-1^0^Code not specified" Q 0
 K ARY N ICD1,ICDC,ICDBA,ICDF,ICDG,ICDS,ICDE,ICDI,ICDI,ICDA,ICDN,ICDD,ICDR,ICDF,ICDS,ICDY,ICDP,ICDT
 S ICDC=$TR($G(CODE)," ","") I '$L(ICDC) S ARY(0)="-1^0^Invalid Code specified" Q 0
 I $D(^ICD9("AVA",(CODE_" ")))!($D(^ICD0("AVA",(CODE_" ")))) S ARY(0)="-1^0^Invalid Code specified" Q 0
 S ICDY=$$SYS^ICDEX($G(SYS))
 I +ICDY'>0 D
 . N ICDF,ICDE S ICDF=$$CODEFI^ICDEX(ICDC) Q:+ICDF'>0
 . S ICDE=$P($$CODECS^ICDEX(ICDC,ICDF),"^",1) Q:+ICDE'>0
 . S ICDY=$$SYS^ICDEX(ICDE)
 S ICDS=+($G(ICDY)) I +ICDS'>0 S ARY(0)="-1^0^Invalid or undetermined Coding System" Q 0
 S ICDR=$$ROOT^ICDEX(ICDS) I '$L(ICDR) S ARY(0)="-1^0^Undetermined global root" Q 0
 S ICDI=$$CODEABA^ICDEX(ICDC,ICDR,+ICDS) I +ICDI'>0 S ARY(0)="-1^0^IEN not found" Q 0
 S ICDP=$S(ICDR["ICD9":3,1:4),ICD1=$G(@(ICDR_ICDI_",1)")),ICDN=$$MRST(ICDR,ICDI)
 S ICDG=ICDR_ICDI_",67,",ICDT=$O(@(ICDG_"""B"","" "")"),-1),ICDT=$O(@(ICDG_"""B"","_+ICDT_","" "")"),-1)
 S ICDT=$P($G(@(ICDG_+ICDT_",0)")),"^",2),ARY(0)=ICDI_"^"_'$P(ICD1,"^",7)
 S (ICDA,ICDBA)=0,ICDG=ICDR_ICDI_",66,"
 F  Q:ICDBA  D
 . N ICDBI,ICDCA,ICDST,ICDV S ICDA=$O(@(ICDG_"""B"","_ICDA_")"))
 . I ICDA="" S ICDBA=1 Q
 . S ICDF=$O(@(ICDG_"""B"","_ICDA_",0)"))
 . I '+ICDF S ICDBA=1 Q
 . S ICDST=$P($G(@(ICDG_ICDF_",0)")),"^",2)
 . Q:'ICDST  ;outer loop looks for active
 . ; Versioned text for activation date
 . S ICDV=$$MRST(ICDR,ICDI) S:$L(ICDV) ICDT=ICDV
 . S ARY(ICDA)="^"_ICDT,ICDBI=0,ICDI=ICDA
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
 . . S ICDV=$$MRST(ICDR,+($G(ARY(0))),ICDI)
 . . S:$L(ICDV) $P(ARY(ICDA),"^",2)=ICDV
 . . S $P(ARY(ICDA),"^")=ICDI
 . . S ICDBI=1,ICDA=ICDI,ICDCA=0
 S (ICDI,ICDC)=0 F  S ICDI=$O(ARY(ICDI)) Q:+ICDI'>0  S ICDC=ICDC+1
 S:ICDC'>0 ARY(0)="-1^0^No activation periods found"
 Q ICDC
MRST(ICD,X,Y) ; Most Recent Description from Date
 N ICDI,ICDT,ICDE,ICDH,ICDR S ICDR=$G(ICD),ICDI=+($G(X)),ICDT=$G(Y)
 Q:'$L(ICDR)!(ICDR'["^")!(ICDR'["(") ""  Q:+ICDI'>0 ""  I ICDT'>0 D  Q X
 . N ICDE,ICDH S ICDE=+($O(@(ICDR_+ICDI_",67,""B"","" "")"),-1))
 . S ICDH=+($O(@(ICDR_+ICDI_",67,""B"","_ICDE_","" "")"),-1))
 . S X=$P($G(@(ICDR_+ICDI_",67,"_ICDH_",0)")),"^",2)
 S ICDE=+($O(@(ICDR_+ICDI_",67,""B"","_+ICDT_")"),-1))
 S ICDH=+($O(@(ICDR_+ICDI_",67,""B"","_ICDE_","" "")"),-1))
 S X=$P($G(@(ICDR_+ICDI_",67,"_ICDH_",0)")),"^",2)
 Q X
