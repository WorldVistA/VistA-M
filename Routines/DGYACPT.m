DGYACPT ;ALB/ABR - CPT Utilities ;3/15/97
 ;;6.0;CPT/HCPCS;;May 19, 1997
 ;
 ;    ************************************************
 ;     THIS ROUTINE WILL BE ELIMINATED 18 MONTHS AFTER
 ;     THE RELEASE DATE INDICATED IN THE 2ND LINE.
 ;     
 ;     CPT NOW HAS ITS OWN NAMESPACE - ICPT*,
 ;     AND NO LONGER USES DGYA*
 ;
 ;     USE $$MODP^ICPTMOD(CODE,MOD,MFT,MDT) FOR ACCEPTABLE
 ;     MODIFIER PAIRS.
 ;
 ;     USE $$CPT^ICPTCOD(CODE,CDT) TO CHECK FOR VALID CODE
 ;    *************************************************
 ;
MODE(CODE,MOD) ; Returns 1/0 if modifier can be used with code
 ;
 ;  Input:    CODE = CPT code (external format)
 ;             MOD = CPT modifier [Optional] (external format)
 ; Output:     0/1 = 0 cannot be used with code 
 ;                   0 not a valid CPT code if modifier not passed in
 ;                   1 can be used with code
 ;                   1 a valid CPT code if modifier not passed in
 ;
 N MODP
 ;
 ; if no MOD, check if valid CPT code
 I '$D(MOD) S MODP=$$CPT^ICPTCOD(CODE) G MODEQ
 ;
 ;  check modifier/code pair (external format)
 S MODP=$$MODP^ICPTMOD(CODE,MOD,"E")
 ;
MODEQ Q $S(MODP>0:1,1:0)
 ;
 ;
MODI(CODE,MOD) ; Returns 1/0 if modifier can be used with code
 ;
 ;  Input:    CODE = CPT code (internal format)
 ;             MOD = CPT modifier [Optional] (internal format)
 ; Output:     0/1 = 0 cannot be used with code
 ;                   0 not valid CPT code if modifier not passed in
 ;                   1 can be used with code
 ;                   1 valid CPT code if modifier not passed in
 ;
 N MODP
 ;
 ; if no MOD, check if valid CPT code
 I '$D(MOD) S MODP=$$CPT^ICPTCOD(CODE) G MODIQ
 ;
 ;  check modifier/code pair (internal format)
 S MODP=$$MODP^ICPTMOD(CODE,MOD,"I")
 ;
MODIQ Q $S(MODP>0:1,1:0)
