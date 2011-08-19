ICPTMOD2 ;ALB/DEK/KER - CPT MODIFIER APIS ;08/18/2007
 ;;6.0;CPT/HCPCS;**30,37**;May 19, 1997;Build 25
 ;             
 ; Global Variables
 ;    ^DIC(81.3
 ;    ^ICPT(
 ;             
 ; External References
 ;    $$DT^XLFDT       DBIA  10103
 ;    $$FMADD^XLFDT    DBIA  10103
 ;             
 Q
MODA ; Create an array of Modifiers for a CPT Code
 ;
 ; Input
 ;     
 ;     CODE   CPT/HCPCS Code   ?7N / ?1A4N / ?4N1A
 ;     VDT    Versioning Date (date service provided)
 ;     .ARY   Name of a Local Array passed by value
 ; 
 ; Output
 ; 
 ;    ARY    Only returns Active Modifiers
 ;    ARY(0) = 4 Piece String
 ;           4 Piece String
 ;           1   # of Modifiers found for code CODE (input)
 ;           2   # of Modifiers w/Active Ranges
 ;           3   # of Modifiers w/Inactive Ranges
 ;           4   Code
 ;                  
 ;    ARY(ST,MOD) = 8 Piece Output String
 ;    
 ;      ST   Status A=Active I=Inactive
 ;      MOD  Modifier (external format)
 ;           8 Piece String
 ;           1   IEN of Modifier
 ;           2   Versioned Short Text (name)
 ;           3   Activation date of Modifier
 ;           4   Beginning Range Code
 ;           5   Ending Range Code
 ;           6   Activation Date of Range
 ;           7   Inactivation Date of Range
 ;           8   Modifier Identifier
 ;                    
 N A,EFF,I,ID,MIEN,MOD,SRC,ST,X K ARY
 S CODE=$G(CODE) Q:'$D(^ICPT("BA",(CODE_" ")))
 S VDT=$G(VDT) S:+VDT'>0 VDT=$$DT^XLFDT Q:VDT'?7N
 S SRC=3,MIEN=0 F  S MIEN=$O(^DIC(81.3,MIEN)) Q:+MIEN'>0  D
 . S (EFF,ST)=$O(^DIC(81.3,MIEN,60,"B"," "),-1) Q:ST'>0  S ST=$O(^DIC(81.3,MIEN,60,"B",ST," "),-1) Q:ST'>0  S ST=$P($G(^DIC(81.3,MIEN,60,ST,0)),"^",2) Q:ST'>0
 . S MOD=$P($G(^DIC(81.3,MIEN,0)),"^",1) Q:'$L(MOD)
 . S X=$$MODP(CODE,MIEN,"I",VDT,0) S ID=$P(X,"^",6) S ID=$S(+ID>0:"I",1:"A")
 . S:+X>0 ARY(ID,MOD)=$P(X,"^",1,2)_"^"_EFF_"^"_$P(X,"^",3,7)
 S (A,I)=0,ST="" F  S ST=$O(ARY(ST)) Q:ST=""  S MOD="" F  S MOD=$O(ARY(ST,MOD)) Q:MOD=""  S:ST="A" A=A+1 S:ST="I" I=I+1
 S ST=A+I,ARY(0)=ST_"^"_A_"^"_I_"^"_CODE
 Q
 ;            
MODP(CODE,MOD,MFT,MDT,SRC,DFN) ;  Check if modifier can be used with code (pair)
 ;
 ; Input:
 ; 
 ;    CODE   CPT/HCPCS Code ?7N / ?1A4N / ?4N1A
 ;    MOD    Modifier (External or Internal)
 ;    MFT    Modifier Format "E" - or "I"
 ;    VDT    Date service provided
 ;    SRC    Source Screen
 ;               If 0 or Null, Level I and II modifiers
 ;               If >0, Level I, II, and III modifiers
 ; Output:
 ;
 ;    If pair is acceptable - Positive "^" Delimited String
 ;        
 ;        1 - IEN of CPT Modifier
 ;        2 - Versioned Short Text
 ;        3 - Beginning Code for Code Range
 ;        4 - Ending Code for Code Range
 ;        5 - Code Range Activaiton Date
 ;        6 - Code Range Inactivation Date
 ;        7 - Modifier Identifier
 ;        
 ;    If pair is unacceptable
 ;    
 ;        0 or
 ;       -1 with error message
 ;  
 N ADT,BEGA,BEGR,CDT,CODEA,CODN,ENDA,ENDR,ICD,IDT,LACT,LINA,MIEN,MODEFF,MODI,MODNM,MODST,ND,NSTA,RIEN,RSTA,SIEN,STA,STI,STX,TA,TEFF,TI,TIEN,VDT
 S:$G(MFT)="" MFT="E" Q:"^E^I^"'[("^"_MFT_"^") "-1^Invalid Modifier Format"  S VDT=$P($G(MDT),".",1)
 S:+VDT'?7N VDT=$$DT^XLFDT S:VDT#10000=0 VDT=VDT+101 S:VDT#100=0 VDT=VDT+1 S VDT=$S(VDT<2890101:2890101,1:VDT)
 Q:+VDT'>0!(VDT'?7N) "-1^Invalid Date"  I MFT="E" D  I +($G(MIEN))'>0 Q "-1^Multiple Modifiers with the same name, use IEN"
 . S MIEN=0 S (TIEN,TI)=0 F  S TIEN=$O(^DIC(81.3,"B",MOD,TIEN)) Q:+TIEN'>0  D
 . . S TEFF=$$EFF^ICPTSUPT(81.3,TIEN,VDT) Q:'$P(TEFF,"^",2)  S TI=TI+1,TA(TI)=TIEN,TA(0)=TI
 . S:+($G(TA(0)))=1 MIEN=+($G(TA(1)))
 S:MFT="I" MIEN=+MOD S CODE=$G(CODE),CODN=$S(CODE?1.N:+CODE,1:$$CODEN^ICPTCOD(CODE)) I CODN<1!'$D(^ICPT(CODN,0)) Q "-1^NO SUCH CPT CODE"
 S CODE=$P($G(^ICPT(CODN,0)),"^") Q:'$L(CODE) "-1^No such CPT Code"  Q:$L(CODE)'=5 "-1^Invalid Code"
 S CODEA=$S(CODE?1N.4N:+CODE,CODE?4N1A:$A($E(CODE,5))*10_$E(CODE,1,4),1:$A(CODE)_$E(CODE,2,5)) Q:+CODEA'>0 "-1^Invalid Code Source"
 S MIEN=$G(MIEN) Q:+MIEN'>0 "-1^Invalid Modifier"  S SRC=$S(+($G(SRC))>0:1,1:0),SIEN=$O(^ICPT("BA",(CODE_" "),0)) Q:+SIEN'>0 "-3^Invalid Code"
 Q:$P($G(^ICPT(+SIEN,0)),"^",6)="L"&(SRC'>0) "-1^Invalid Code Source"
 S MODEFF=$$EFF^ICPTSUPT(81.3,MIEN,VDT) Q:'$P(MODEFF,"^",2) "-1^Modifier Inactive"
 S MODNM=$P($G(^DIC(81.3,MIEN,0)),"^",2) Q:'$L(MODNM) "-1^Invalid Modifier Name"
 S MODI=$P($G(^DIC(81.3,MIEN,0)),"^",1) Q:'$L(MODI) "-1^Invalid Modifier ID"
 S MODST=$$VSTCM^ICPTMOD(MIEN,VDT) K STX S (STA,STI)=0 S CDT=VDT+.001
 S (LINA,LACT)="",RSTA=0,RIEN=0 F  S RIEN=$O(^DIC(81.3,MIEN,10,RIEN)) Q:+RIEN'>0  D
 . N NSTA S NSTA=0,ND=$G(^DIC(81.3,MIEN,10,RIEN,0))
 . S BEGR=$P(ND,"^",1) Q:$L(BEGR)'=5  S BEGA=$S(BEGR?1N.4N:+BEGR,BEGR?4N1A:$A($E(BEGR,5))*10_$E(BEGR,1,4),1:$A(BEGR)_$E(BEGR,2,5)) Q:+CODEA<+BEGA
 . S ENDR=$P(ND,"^",2) S:$L(ENDR)'=5 ENDR=BEGR S ENDA=$S(ENDR?1N.4N:+ENDR,ENDR?4N1A:$A($E(ENDR,5))*10_$E(ENDR,1,4),1:$A(ENDR)_$E(ENDR,2,5))
 . Q:$L(ENDR)&(CODEA>ENDA)  S ADT=$P(ND,"^",3),(ICD,IDT)=$P(ND,"^",4) S:ADT="" ADT=2890101
 . I +CODEA'<+BEGA,+CODEA'>ENDA,+ADT>0,+IDT'>0 S RSTA=1,NSTA=1 S:+ADT>0&(+ADT>(+LACT)) LACT=+ADT
 . I +CODEA'<+BEGA,+CODEA'>ENDA,+ADT>0,+IDT>0,CDT>ADT,CDT'>IDT S RSTA=1,NSTA=1 S:+ADT>0&(+ADT>(+LACT)) LACT=+ADT
 . I +CODEA'<+BEGA,+CODEA'>ENDA,+ADT>0,+IDT>0 S:+IDT>0&(+IDT>(+LINA)) LINA=+IDT
 . Q:NSTA'>0  S:'$L(IDT) IDT=$$FMADD^XLFDT($$DT^XLFDT,365) S ADT=$P(ND,"^",3),(ICD,IDT)=$P(ND,"^",4) S:ADT="" ADT=2890101
 . S:'$L(IDT) IDT=$$FMADD^XLFDT($$DT^XLFDT,365) S STA=+($G(STA))+1,STX(STA)=MIEN_"^"_MODST_"^"_BEGR_"^"_ENDR_"^"_ADT_"^"_ICD_"^"_MODI,STX("B",+ADT,+STA)=""
 S:+LACT>0&(+LINA>0)&(LINA'>CDT)&(+LINA>+LACT) RSTA=0
 S ADT=$O(STX("B",+CDT),-1),STA=$O(STX("B",+ADT," "),-1),MOD=$G(STX(+STA))
 Q:+MOD'>0 "0"  Q:+RSTA'>0 "0"
 Q MOD
 ;            
MODC(MOD) ; Checks modifier for active range including code
 ;
 ; Input:
 ;    MOD  - modifier ien
 ;
 N MODNM,MODEFF
 S MODEFF=$$EFF^ICPTSUPT(81.3,MOD,MDT)
 I '$P(MODEFF,"^",2) S STR="-1^modifier inactive" Q
 S PR=CODEA_.0001,PR=$O(^DIC(81.3,MOD,"M",PR),-1)
 I 'PR S STR=0 Q
 S PRN=^DIC(81.3,MOD,"M",PR)
 I 'PRN S STR="-1^bad modifier file entry" Q
 I PRN<CODEA S STR=0 Q
 S MODNM=$P($G(^DIC(81.3,MOD,0)),"^",2)
 S STR=MOD_"^"_MODNM
 Q
 ;
MULT ; Finds iens for all modifiers with same 2-letter code
 ;  MOD = .01, check B x-ref for dupliate .01 fields
 ;  Output:
 ;     STR - a ";" delimited string of IENS for modifier MOD
 F MODN=0:0 S MODN=$O(^DIC(81.3,"B",MOD,MODN)) Q:'MODN   S STR=STR_MODN_"; "
 Q
