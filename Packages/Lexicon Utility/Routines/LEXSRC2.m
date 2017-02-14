LEXSRC2 ;ISL/KER - Classification Code Source Util ;11/16/2016
 ;;2.0;LEXICON UTILITY;**25,28,73,80,110**;Sep 23, 1996;Build 6
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    $$STATCHK^ICDEX     ICR   5747
 ;    $$SYS^ICDEX         ICR   5747
 ;    $$STATCHK^ICPTAPIU  ICR   1997
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;               
 Q
CPT(LEXC,LEXVDT) ; Return Pointer to Active CPT
 ;                 
 ; Input  CPT Code
 ; Output IEN file 81 of Active Codes only
 S LEXC=$G(LEXC) Q:'$L(LEXC) ""  S LEXVDT=$G(LEXVDT) S:+LEXVDT'>0 LEXVDT=$$DT^XLFDT
 S LEXC=$$STATCHK^ICPTAPIU(LEXC,LEXVDT) Q:+LEXC'>0 ""  S LEXC=$P(LEXC,"^",2) Q:+LEXC'>0 ""
 Q +LEXC
 ;                
ICD(LEXC,LEXVDT) ; Return Pointer to Active ICD/ICP
 ;                 
 ; Input ICD Diagnosis or Procedure
 ; Output IEN file 80 or 80.1 of Active Codes only
 N LEXS S LEXC=$G(LEXC) Q:'$L(LEXC) ""  S LEXVDT=$G(LEXVDT) S:+LEXVDT'>0 LEXVDT=$$DT^XLFDT
 S LEXS=$$SYS^ICDEX(LEXC,LEXVDT),LEXC=$$STATCHK^ICDEX(LEXC,LEXVDT,$G(LEXS))
 Q:+LEXC'>0 ""  S LEXC=$P(LEXC,"^",2) Q:+LEXC'>0 ""
 Q +LEXC
 ;                
STATCHK(CODE,CDT,LEX,SAB) ; Check Status of a Code
 ;                      
 ; Input:
 ;   CODE - Any Code (ICD/CPT/DSM etc) (Required)
 ;   CDT  - Date to screen against (Optional, default TODAY)
 ;   LEX  - Output Array, passed by reference (Optional)
 ;   SAB  - Source Abbreviation or pointer to 757.03 (Optional)
 ;                      
 ; Output:
 ;                      
 ;   2, 3 or 4 Piece String containing the code's status,
 ;   the IEN, and if the status exist, the effective
 ;   date, else -1 in lieu of the IEN.
 ;           
 ;   The following are possible outputs:
 ;           
 ;       1 ^ IEN ^ Active Date   ^ Initial Date    Active Code
 ;       1 ^ IEN ^ Revision Date ^ Initial Date    Revised Code
 ;       0 ^ IEN ^ Effective Date                  Inactive Code
 ;       0 ^ IEN                                   Not Yet Active
 ;       0 ^ -1                                    Code not Found
 ;                      
 ;   ASTM Triplet in array LEX passed by reference (optional)
 ;                      
 ;   ASTM Triplet with Major Concept Map and Semantic
 ;   Map in array LEX passed by reference (optional)
 ;                    
 ;
 ;     LEX(0)  =  Code, a 2 Piece String containing:
 ;
 ;         1 - IEN in the CODES file #757.02
 ;         2 - the code (external)
 ;                    
 ;     LEX(1)  =  Expression, a 2 Piece String containing:
 ;
 ;         1 - IEN in the EXPRESSION file #757.01
 ;         2 - the code expression (external)
 ;
 ;     LEX(2)  =  Coding System, a 4 Piece String containing:
 ;
 ;         1 - IEN in the CODING SYSTEMS file #757.03
 ;         2 - Source Abbreviation (i.e., ICD or CPT)
 ;         3 - Source Nomenclature (i.e., ICD-9-CM or CPT-4)
 ;         4 - Source Full Name
 ;                    
 ;     LEX(3)  =  Major Concept, a 3 Piece String containing:
 ;
 ;         1 - IEN in the MAJOR CONCEPT MAP file #757
 ;         2 - IEN in the EXPRESSIONS file #757.01
 ;         3 - The Major Concept expression, which may be
 ;             different from the code's expression in LEX(1)
 ;                    
 ;     LEX(4,#)=  Semantics (multiple), a 5 Piece String:
 ;
 ;         1 - IEN in the SEMANTIC MAP file #757.1
 ;         2 - IEN in the SEMANTIC CLASS file #757.11
 ;         3 - IEN in the SEMANTIC TYPE file #757.12
 ;         4 - External Semantic Class
 ;         5 - External Semantic Type 
 ;     
 ; This API requires the ACT Cross-Reference
 ;       ^LEX(757.02,"ACT",<code>,<status>,<date>,<ien>)
 ;
 ; Variables used
 ;   LEXC      Code     from input parameter
 ;   LEXDT     Date     from input parameter
 ;   LEXSAB    Source   from input parameter (patch 57)
 ;   LEXAE     Last Activation IEN for SAB
 ;   LEXAP     Last Activation Date for SAB
 ;   LEXIE     Last Inactivation IEN for SAB
 ;   LEXIP     Last Inactivation Date for SAB
 ;   LEXED     Earliest Date Possible for SAB
 ;   LEXEE     Earliest Date IEN for SAB
 ;   LEXE      Counter (for Earliest loop)
 ;   LEXI      Counter (for IEN loop)
 ;   LEXMR     Most Recent Date
 ;   LEXMRI    IEN for Most Recent Date for SAB
 ;   LEXN      Data Node
 ;   LEXO      Temporary Value for $O Loops
 ;   LEXSTAT   Status
 ;   LEXTDT    Input Date Offset
 ;   X         Output
 ;   LEX       Output Array (when passed)
 ;   
 ; Integration Agreement
 ;   4083     $$STATCHK^LEXSRC2()
 ;              
 N LEXAE,LEXAP,LEXC,LEXDT,LEXE,LEXED,LEXEE,LEXI,LEXIE,LEXIP,LEXMR
 N LEXMRI,LEXN,LEXINIT,LEXO,LEXSAB,LEXSTAT,LEXTDT,X
 S LEXC=$G(CODE) I '$L(LEXC) S (LEX,X)="0^-1" D UPD Q X
 S LEXDT=$P($G(CDT),".",1),LEXDT=$S(+LEXDT>0:LEXDT,1:$$DT^XLFDT)
 S LEXSAB=$$SAB($G(SAB)),LEXTDT=LEXDT+.00001
 ; Find preceding active date/IEN for SAB           LEXAP/LEXAE
 ;   and earliest possible active date/IEN for SAB  LEXED/LEXEE
 S (LEXED,LEXEE,LEXAE,LEXAP)="",LEXO=LEXTDT F  S LEXO=$O(^LEX(757.02,"ACT",(LEXC_" "),3,LEXO),-1) D  Q:+LEXO'>0
 . I '$L(LEXO)!(+LEXO'>0) D  Q
 . . N LEXE S LEXE=LEXTDT F  S LEXE=$O(^LEX(757.02,"ACT",(LEXC_" "),1,LEXE)) Q:+LEXE'>0  D  Q:+LEXED>0&(+LEXEE>0)
 . . . N LEXI S LEXI=0 F  S LEXI=$O(^LEX(757.02,"ACT",(LEXC_" "),1,LEXE,LEXI)) Q:+LEXI'>0  D  Q:+LEXED>0&(+LEXEE>0)
 . . . . Q:+LEXED>0&(+LEXEE>0)  N LEXN S LEXN=$G(^LEX(757.02,+LEXI,0)) Q:+LEXSAB>0&($P(LEXN,"^",3)'=+LEXSAB)
 . . . . S:'$L(LEXED) LEXED=LEXE S:'$L(LEXEE) LEXEE=LEXI
 . N LEXI S LEXI=" " F  S LEXI=$O(^LEX(757.02,"ACT",(LEXC_" "),3,LEXO,LEXI),-1) Q:+LEXI'>0  D
 . . N LEXN S LEXN=$G(^LEX(757.02,+LEXI,0)) Q:+LEXSAB>0&($P(LEXN,"^",3)'=+LEXSAB)
 . . S:'$L(LEXAP) LEXAP=LEXO S:'$L(LEXAE) LEXAE=LEXI
 ; Find preceding inactive date/IEN for SAB         LEXIP/LEXIE
 N LEXO,LEXIP,LEXIE S (LEXIE,LEXIP)="",LEXO=LEXTDT F  S LEXO=$O(^LEX(757.02,"ACT",LEXC_" ",2,LEXO),-1) Q:+LEXO'>0  D
 . N LEXI S LEXI=" " F  S LEXI=$O(^LEX(757.02,"ACT",LEXC_" ",2,LEXO,LEXI),-1) Q:+LEXI'>0  D
 . . N LEXN S LEXN=$G(^LEX(757.02,+LEXI,0)) Q:+LEXSAB>0&($P(LEXN,"^",3)'=+LEXSAB)
 . . S:'$L(LEXIP) LEXIP=LEXO S:'$L(LEXIE) LEXIE=LEXI
 ; Quit if input date is before earliest date
 I +LEXAP'>0,+LEXIP'>0,+LEXEE>0,+LEXED>0,LEXED?7N,LEXED>LEXDT S X="0^"_LEXEE D UPD Q X
 ; Quit if both active/inactive dates are zero
 I +LEXAP=0,+LEXIP=0 S (LEX,X)="0^-1" D UPD Q X
 ; Find the most recent date/IEN/Status LEXMR/LEXMRI/LEXSTAT
 S:LEXAP>LEXIP!(LEXAP=LEXIP) LEXMR=LEXAP,LEXMRI=LEXAE,LEXSTAT=1
 S:LEXAP<LEXIP LEXMR=LEXIP,LEXMRI=LEXIE,LEXSTAT=0
 ; Check for difficulties from date errors for SAB
 D ADJ
 S LEXINIT="" I LEXMR?7N,LEXSTAT>0 S LEXINIT=$$INIT(LEXC,LEXMR)
 ; Quit with status, code IEN and effective date
 S (LEX,X)=LEXSTAT_"^"_LEXMRI_"^"_LEXMR D UPD
 S:(LEXMR?7N)&(LEXSTAT>0)&(LEXINIT?7N)&(LEXMR'=LEXINIT) $P(LEX,"^",4)=LEXINIT,X=LEX
 Q X
SAB(X) ; Resolve SAB
 N Y S Y=$G(X) Q:'$L($G(Y)) ""  S X=+($O(^LEX(757.03,"ASAB",$E($G(Y),1,3),0))) Q:+X>0 X  S X=+Y Q:$D(^LEX(757.03,+Y,0)) X
 Q ""
ADJ ; Do we have adjacent dates for SAB
 N LEXND,LEXNI,LEXNS,LEXNO,LEXN S LEXND=$$FMADD^XLFDT($G(LEXMR),1)
 S LEXNO='LEXSTAT,LEXNS=2+LEXNO Q:LEXND'?7N
 S LEXNI=$O(^LEX(757.02,"ACT",(LEXC_" "),LEXNS,LEXND," "),-1)
 Q:+LEXNI'>0  S LEXN=$G(^LEX(757.02,+LEXMRI,0))
 I +($G(LEXSAB))>0&($P(LEXN,"^",3)=+($G(LEXSAB))) S LEXSTAT=LEXNO,LEXMR=LEXND,LEXMRI=LEXNI
 Q
INIT(X,Y) ; Inital Activation Dates (revised codes only)
 N LEXA,LEXC,LEXI,LEXOFF,LEXMR S LEXC=$G(X),LEXMR=$P($G(Y),".",1),X="" Q:'$L($G(LEXC)) ""  Q:$G(LEXMR)'?7N ""
 S:'$D(^LEX(757.02,"ACT",(LEXC_" "),1,LEXMR)) LEXMR=$O(^LEX(757.02,"ACT",(LEXC_" "),1,LEXMR),-1) Q:$G(LEXMR)'?7N ""
 S LEXA=(LEXMR-.001) S LEXOFF=$$FMADD^XLFDT(LEXMR,-1)
 F  S LEXA=$O(^LEX(757.02,"ACT",(LEXC_" "),1,LEXA),-1) Q:LEXA'?7N  D
 . S LEXI=$O(^LEX(757.02,"ACT",(LEXC_" "),0,LEXA))
 . I LEXI>LEXA,LEXI?7N,LEXI'<LEXOFF S X=LEXA
 S:'$L(X)&(LEXMR?7N) X=LEXMR
 Q X
UPD ; Update Array
 N LEXI,LEXC,LEXN,LEXM,LEXE,LEXS,LEXC S LEXI=+($P($G(X),"^",2)) Q:+LEXI'>0
 S LEXN=$G(^LEX(757.02,+LEXI,0)),LEXE=+LEXN,LEXC=$P(LEXN,"^",2)
 S LEXS=+($P(LEXN,"^",3)),LEXM=+($P(LEXN,"^",4)),LEX(0)=+LEXI_"^"_LEXC
 S LEX(1)=LEXE_"^"_$P($G(^LEX(757.01,+LEXE,0)),"^",1)
 S LEX(2)=LEXS_"^"_$P($G(^LEX(757.03,+LEXS,0)),"^",1,3)
 S LEX(3)=LEXM_"^"_$P($G(^LEX(757,+LEXM,0)),"^",1)_"^"_$G(^LEX(757.01,+($P($G(^LEX(757,+LEXM,0)),"^",1)),0))
 S (LEXI,LEXS)=0 F  S LEXS=$O(^LEX(757.1,"B",+LEXM,LEXS)) Q:+LEXS'>0  D
 . N LEXN,LEXC,LEXT,LEXCT,LEXTT S LEXN=$G(^LEX(757.1,+LEXS,0)),LEXC=$P(LEXN,"^",2),LEXT=$P(LEXN,"^",3)
 . S LEXCT=$P($G(^LEX(757.11,+LEXC,0)),"^",2),LEXTT=$P($G(^LEX(757.12,+LEXT,0)),"^",2)
 . I LEXC>0,LEXT>0,$L(LEXCT),$L(LEXTT)  D
 . . S LEXI=LEXI+1,LEX(4,LEXI)=LEXS_"^"_LEXC_"^"_LEXT_"^"_LEXCT_"^"_LEXTT
 Q
PI(X) ; Preferred IEN for code X
 N LEXE,LEXLA,LEXA,LEXS,LEXC,LEXP,LEXPF,LEXF,LEXI,LEXC,LEXFL
 S LEXC=$G(X) Q:'$L(LEXC) ""  S (LEXP,LEXF,LEXI)=0,LEXPF(0)=LEXC
 F  S LEXI=$O(^LEX(757.02,"CODE",(LEXC_" "),LEXI)) Q:+LEXI=0!(LEXP>0)  D
 . S:+LEXF'>0 LEXF=LEXI S LEXFL=$S(+($P($G(^LEX(757.02,+LEXI,0)),"^",5))>0:1,1:0)
 . S LEXE=0,LEXLA="" F  S LEXE=$O(^LEX(757.02,+LEXI,4,LEXE)) Q:+LEXE=0  D
 . . S LEXS=$P($G(^LEX(757.02,+LEXI,4,LEXE,0)),"^",2) Q:+LEXS'>0
 . . S LEXA=$P($G(^LEX(757.02,+LEXI,4,LEXE,0)),"^",1)
 . . S:+LEXA>+LEXLA LEXLA=+LEXA
 . S:+LEXLA>0 LEXPF(LEXFL,LEXLA,LEXI)=""
 S X="" I $D(LEXPF(1)) S X=$O(LEXPF(1," "),-1),X=$O(LEXPF(1,+X," "),-1)
 I '$D(LEXPF(1)),$D(LEXPF(0)) S X=$O(LEXPF(0," "),-1),X=$O(LEXPF(0,+X," "),-1)
 Q X
