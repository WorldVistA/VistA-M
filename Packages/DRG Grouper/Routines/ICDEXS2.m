ICDEXS2 ;SLC/KER - ICD Extractor - Support ;04/21/2014
 ;;18.0;DRG Grouper;**57**;Oct 20, 2000;Build 1
 ;               
VER(SYS,REL) ; Coding System Version
 ;
 ; Input:
 ;
 ;   SYS     System (pointer to file 80.4)
 ;   REL     Relationship to System (optional)
 ;   
 ;               0   N/A - Current Version (default)
 ;               1   Next Version
 ;              -1   Previous Version
 ; Output:
 ; 
 ;   $$VER   This is a 5 piece string containing:
 ;   
 ;               1   Coding System (pointer to file 80.4)
 ;               2   Coding System Nomenclature
 ;               3   Coding System Abbreviation
 ;               4   File Number containing the Coding System
 ;               5   Date Coding System was Implemented
 ;           or
 ;              -1   on error
 ;              
 N ICDS,ICDR,ICDT,ICDO,ICDA,ICDF,ICDI,ICDD,ICDV,ICDC
 S ICDO="",ICDS=+($G(SYS)),ICDR=+($G(REL)),ICDT=$G(^ICDS(+ICDS,0)),ICDC=$P(ICDT,"^",4)
 I +ICDR=0,ICDS>0,$L(ICDT,"^")>3 S ICDO=ICDS_"^"_ICDT Q ICDO
 S ICDF=$$FILE^ICDEX(ICDS) Q:+ICDF'>0 "-1^No future coding system found"
 S ICDI=0 F  S ICDI=$O(^ICDS("F",+ICDF,ICDI)) Q:+ICDI'>0  D
 . S ICDT=$G(^ICDS(+ICDI,0)),ICDD=$P(ICDT,"^",4)
 . S:ICDD?7N ICDA(ICDD)=ICDI
 I +ICDR>0,ICDC?7N  D  Q ICDO
 . N ICDN,ICDT,ICDD S ICDO="-1^No Next Coding System"
 . S ICDN=$O(ICDA(ICDC)),ICDN=+($G(ICDA(+ICDN))) Q:+ICDN'>0
 . S ICDT=$G(^ICDS(+ICDN,0)),ICDD=$P(ICDT,"^",4)
 . I ICDN>0,$L(ICDT,"^")>3,ICDD?7N S ICDO=ICDN_"^"_ICDT
 I +ICDR<0,ICDC?7N  D  Q ICDO
 . N ICDN,ICDT,ICDD S ICDO="-1^No Previous Coding System"
 . S ICDN=$O(ICDA(ICDC),-1),ICDN=+($G(ICDA(+ICDN))) Q:+ICDN'>0
 . S ICDT=$G(^ICDS(+ICDN,0)),ICDD=$P(ICDT,"^",4)
 . I ICDN>0,$L(ICDT,"^")>3,ICDD?7N S ICDO=ICDN_"^"_ICDT
 Q "-1^No Coding System found"
HDR(X) ; Diagnosis/Procedure File Header Node
 ;
 ; Input:
 ;
 ;    X      File Number or Global Root
 ;              80    or  ^ICD9(
 ;              80.1  or  ^ICD0(
 ;
 ; Output:
 ;
 ;   $$HDR   Diagnosis/Procedure File Header Node
 ;
 ; Replaces ICR 2435 and 2436
 ; 
 N ICDF S ICDF=$G(X) S ICDF=$$FILE^ICDEX(ICDF)
 Q:ICDF=80 $G(^ICD9(0))  Q:ICDF=80.1 $G(^ICD0(0))
 Q ""
