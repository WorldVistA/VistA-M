LEXU2 ;ISL/KER - Miscellaneous Lexicon Utilities ;12/19/2014
 ;;2.0;LEXICON UTILITY;**80,86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^ICPT(              ICR   5408
 ;    ^TMP("ICPTD")       ICR   1995
 ;               
 ; External References
 ;    $$CPTD^ICPTCOD      ICR   1995
 ;    $$CPT^ICPTCOD       ICR   1995
 ;    $$DT^XLFDT          ICR  10103
 ;    $$ICDDX^ICDEX       ICR   5747
 ;    $$ICDD^ICDEX        ICR   5747
 ;    $$ICDOP^ICDEX       ICR   5747
 ;    $$MOR^ICDEX         ICR   5747
 ;    $$TITLE^XLFSTR      ICR  10104
 ;    CPTD^ICPTCOD        ICR   1995
 ;    MD^ICDEX            ICR   5747
 ;    MODA^ICPTMOD        ICR   1996
 ;               
CSDATA(CODE,CSYS,CDT,ARY) ; Get Information about a Code
 ;
 ; Input:
 ;
 ;   CODE   Classification Code (Required)
 ;   CSYS   Coding System (taken from file 757.03)
 ;             Acceptable values include
 ;             Pointer to file  757.03
 ;             SOURCE ABBREVIATION field .01
 ;             Mnemonic (3 character SOURCE ABBREVIATION 
 ;                from ASAB cross-reference)
 ;    CDT   Code Set Versioning Date (default = TODAY)
 ;   .ARY   Output array passed by reference
 ;
 ; Output: 
 ; 
 ;   $$CSDATA   1 if successful (fully or partial)
 ;              0 if unsuccessful
 ;               
 ;               or
 ;               
 ;              -1 ^ Error Message
 ;              
 ;       It is considered partially successful if:
 ;              
 ;          1)  It is in the Lexicon and not in an SDO file 
 ;          2)  It is in an SDO file and not in the Lexicon
 ;          
 ;   ARY()
 ; 
 ;
 ;    Lexicon Data
 ;    
 ;       ARY("LEX",1)         IEN ^ Preferred Term
 ;       ARY("LEX",2)         Status ^ Effective Date
 ;       ARY("LEX",3)         IEN ^ Major Concept Term
 ;       ARY("LEX",4)         IEN ^ Fully Specified Name
 ;       ARY("LEX",5)         Hierarchy (if it exists)
 ;       ARY("LEX",6,0)       Synonyms/Other Forms
 ;       ARY("LEX",6,1)         Synonym #1
 ;       ARY("LEX",6,n)         #n
 ;       ARY("LEX",7,0)       Semantic Map
 ;       ARY("LEX",7,1,1)       Class ^ Type (internal)
 ;       ARY("LEX",7,1,2)       Class ^ Type (external)
 ;       ARY("LEX",7,1,n)       #n
 ;       ARY("LEX",7,1,n)       #n
 ;       ARY("LEX",8)         Deactivated Concept Flag
 ;      
 ;    Coding System Data
 ;    
 ;       ARY("SYS",1)         IEN
 ;       ARY("SYS",2)         Short Name
 ;       ARY("SYS",3)         Age High
 ;       ARY("SYS",4)         Age Low
 ;       ARY("SYS",5)         Sex
 ;       ARY("SYS",6,0)       MDC/DRG Pairing
 ;       ARY("SYS",6,1,1)       MDC
 ;       ARY("SYS",6,1,2)       DRGs
 ;       ARY("SYS",6,n,1)       #n
 ;       ARY("SYS",6,n,2)       #n
 ;       ARY("SYS",7)         Complication/Comorbidity
 ;       ARY("SYS",8)         MDC13
 ;       ARY("SYS",9)         MDC24
 ;       ARY("SYS",10)        MDC24
 ;       ARY("SYS",11)        Unacceptable as Principal Dx
 ;       ARY("SYS",12)        Major O.R. Procedure
 ;       ARY("SYS",13)        Procedure Category
 ;       ARY("SYS",14,0)      Description
 ;       ARY("SYS",14,1)        Text 1
 ;       ARY("SYS",14,n)        #n
 ;      
 ;    Each data element will be in the following format:
 ;      
 ;       ARY(ID,SUB) = DATA
 ;       ARY(ID,SUB,"N") = NAME
 ; 
 ;         Where
 ;
 ;           ID      Identifier, may be:
 ;           
 ;                       "LEX" for Lexicon data
 ;                       "SYS" for Coding System data
 ;                     
 ;           SUB     Numeric Subscript
 ;           
 ;           DATA    This may be:
 ;           
 ;                       A value if it applies and is found
 ;                       Null if it applies but not found
 ;                       N/A if it does not apply
 ;                     
 ;           NAME    This is the common name given to the 
 ;                   data element
 ;       
 N LEXSO,LEXSRC,LEXSAB,LEXVDT,LEXSCK,LEXSTA,LEXSIEN,LEXEIEN,LEXMIEN,LEXEFF,LEXOK
 S LEXSO=$G(CODE) Q:'$L(LEXSO) "-1^Code missing"
 Q:'$D(^LEX(757.02,"CODE",(LEXSO_" "))) "-1^Invalid Code"
 S LEXSAB=$G(CSYS)
 S LEXSRC=+($$CSYS^LEXU(LEXSAB)) S:LEXSRC'>0 LEXSRC=$$SYSC^LEXU4(LEXSO)
 Q:+LEXSRC'>0 "-1^Invalid source"  S LEXSAB=$P($$CSYS^LEXU(+LEXSRC),"^",2)
 Q:$L(LEXSAB)'=3 "-1^Invalid source"
 Q:+($$CODSAB(LEXSO,LEXSAB))'>0 "-1^Invalid source for code"
 S LEXVDT=$G(CDT) D VDT^LEXU3 D LEX
 I LEXSRC=1!(LEXSRC=30) D ICDDX
 I LEXSRC=2!(LEXSRC=31) D ICDOP
 I LEXSRC=3!(LEXSRC=4) D CPTCPC
 D CS,LX
 Q:$D(ARY("LEX"))!($D(ARY("SYS"))) 1
 Q 0
LEX ; Lexicon
 Q:'$D(^LEX(757.02,"ACT",(LEXSO_" ")))  S LEXSCK=$$STATCHK^LEXSRC2(LEXSO,$G(LEXVDT),,LEXSAB)
 S LEXSTA=$P(LEXSCK,"^",1),LEXSIEN=$P(LEXSCK,"^",2),LEXEFF=$P(LEXSCK,"^",3)
 S LEXEIEN=+($G(^LEX(757.02,+LEXSIEN,0))),LEXMIEN=+($P($G(^LEX(757.02,+LEXSIEN,0)),"^",4))
 Q:LEXSIEN<0  S:LEXSTA'>0&(LEXSIEN>0)&(LEXEFF'?7N) ARY("LEX",2)=0
 S:LEXSTA?1N&(LEXSIEN>0)&(LEXEFF?7N) ARY("LEX",2)=LEXSTA_"^"_LEXEFF
 S ARY("LEX",1)=LEXEIEN_"^"_$G(^LEX(757.01,+LEXEIEN,0))
 N LEXFLG,LEXSM,LEXTIEN,LEXMC
 S LEXSM=0 F  S LEXSM=$O(^LEX(757.1,"B",LEXMIEN,LEXSM)) Q:+LEXSM'>0  D
 . N LEXN,LEXI,LEXC,LEXCE,LEXT,LEXTE S LEXN=$G(^LEX(757.1,+LEXSM,0))
 . S LEXC=$P(LEXN,"^",2),LEXT=$P(LEXN,"^",3) Q:LEXC'>0  Q:LEXT'>0
 . S LEXCE=$P($G(^LEX(757.11,+LEXC,0)),"^",2) Q:'$L(LEXCE)
 . S LEXTE=$P($G(^LEX(757.12,+LEXT,0)),"^",2) Q:'$L(LEXTE)
 . S LEXI=$O(ARY("LEX",7," "),-1)+1
 . S ARY("LEX",7,LEXI,1)=LEXC_"^"_LEXT
 . S ARY("LEX",7,LEXI,2)=LEXCE_"^"_LEXTE
 S ARY("LEX",7,0)=+($O(ARY("LEX",7," "),-1))
 S LEXTIEN=0,LEXFLG="",LEXMC="" F  S LEXTIEN=$O(^LEX(757.01,"AMC",LEXMIEN,LEXTIEN)) Q:+LEXTIEN'>0  D
 . N LEX0,LEX1,LEXT,LEXF
 . S LEX0=$G(^LEX(757.01,LEXTIEN,0)),LEX1=$G(^LEX(757.01,LEXTIEN,1)),LEXT=$P(LEX1,"^",2),LEXF=$P(LEX1,"^",5)
 . S:LEXF>0 LEXFLG=1 I LEXT=8 D
 . . N LEXE,LEXH S LEXE=$G(^LEX(757.01,+LEXTIEN,0)) S ARY("LEX",4)=LEXTIEN_"^"_LEXE
 . . S LEXH=$P($P(LEXE,"(",$L(LEXE,"(")),")") S:$L(LEXH) LEXH=$$TITLE^XLFSTR(LEXH)
 . . S:$L(LEXH) ARY("LEX",5)=LEXH
 . I LEXT=1 S LEXMC=LEXTIEN
 . I LEXT'=1,LEXT'=8,LEXTIEN'=LEXEIEN D
 . . N LEXI S LEXI=$O(ARY("LEX",6," "),-1)+1
 . . S ARY("LEX",6,LEXI)=LEXTIEN_"^"_$G(^LEX(757.01,+LEXTIEN,0)),ARY("LEX",6,0)=LEXI
 S:+LEXMC>0 ARY("LEX",3)=LEXMC_"^"_$G(^LEX(757.01,+LEXMC,0))
 S:+LEXFLG>0 ARY("LEX",8)="Deactivated Concept"
 Q
ICDDX ; ICD DX CS array
 N LEXC,LEXDAT,LEXDD,LEXDRG,LEXFY,LEXI,LEXLEXI,LEXMD,LEXMDC,LEXOUT,LEXSDO
 S LEXDAT=$$ICDDX^ICDEX(LEXSO,LEXVDT,LEXSRC,"E") Q:+LEXDAT<0  S LEXSDO=+LEXDAT
 S ARY("SYS",1)=LEXSDO,ARY("SYS",2)=$P(LEXDAT,"^",4),ARY("SYS",3)=$P(LEXDAT,"^",16)
 S ARY("SYS",4)=$P(LEXDAT,"^",15),ARY("SYS",5)=$P(LEXDAT,"^",11)
 D MD^ICDEX(80,LEXSDO,LEXVDT,.LEXMD)
 S LEXFY="" F  S LEXFY=$O(LEXMD(LEXFY)) Q:'$L(LEXFY)  D
 . N LEXNDC S LEXMDC=0 F  S LEXMDC=$O(LEXMD(LEXFY,LEXMDC)) Q:+LEXMDC'>0  D
 . . N LEXDRG,LEXLEXI S LEXDRG=$G(LEXMD(LEXFY,LEXMDC)),LEXDRG=$P(LEXDRG,";",1),LEXDRG=$TR(LEXDRG,"^",";")
 . . S LEXI=$O(ARY("SYS",6," "),-1)+1,ARY("SYS",6,LEXI,1)=LEXMDC
 . . S ARY("SYS",6,LEXI,2)=$$TM(LEXDRG,";")
 . . S ARY("SYS",6,0)=LEXI
 S ARY("SYS",7)=$P(LEXDAT,"^",19),ARY("SYS",8)=$P(LEXDAT,"^",7),ARY("SYS",9)=$P(LEXDAT,"^",13)
 S ARY("SYS",10)=$P(LEXDAT,"^",14),ARY("SYS",11)=$P(LEXDAT,"^",5)
 K LEXDD S LEXOUT=$$ICDD^ICDEX(LEXSO,.LEXDD,LEXVDT,LEXSRC) I +LEXOUT>0 D
 . N LEXI,LEXC S (LEXI,LEXC)=0 F  S LEXI=$O(LEXDD(LEXI)) Q:+LEXI'>0  D
 . . S LEXC=LEXC+1 S ARY("SYS",14,LEXC)=$G(LEXDD(LEXI)),ARY("SYS",14,0)=LEXC
 Q
ICDOP ; ICD OP CS array
 N LEXC,LEXDAT,LEXDD,LEXDRG,LEXFY,LEXI,LEXLEXI,LEXMD,LEXMDC,LEXMOR,LEXOUT,LEXSDO
 S LEXDAT=$$ICDOP^ICDEX(LEXSO,LEXVDT,LEXSRC,"E") Q:+LEXDAT<0  S LEXSDO=+LEXDAT
 S ARY("SYS",1)=LEXSDO,ARY("SYS",2)=$P(LEXDAT,"^",5),ARY("SYS",5)=$P(LEXDAT,"^",11)
 D MD^ICDEX(80.1,LEXSDO,LEXVDT,.LEXMD)
 S LEXFY="" F  S LEXFY=$O(LEXMD(LEXFY)) Q:'$L(LEXFY)  D
 . N LEXNDC S LEXMDC=0 F  S LEXMDC=$O(LEXMD(LEXFY,LEXMDC)) Q:+LEXMDC'>0  D
 . . N LEXDRG,LEXLEXI S LEXDRG=$G(LEXMD(LEXFY,LEXMDC)),LEXDRG=$P(LEXDRG,";",1),LEXDRG=$TR(LEXDRG,"^",";")
 . . S LEXI=$O(ARY("SYS",6," "),-1)+1,ARY("SYS",6,LEXI,1)=LEXMDC
 . . S ARY("SYS",6,LEXI,2)=$$TM(LEXDRG,";")
 . . S ARY("SYS",6,0)=LEXI
 S ARY("SYS",10)=$P(LEXDAT,"^",4)
 S LEXMOR=$$MOR^ICDEX(LEXSDO)
 S ARY("SYS",12)=LEXMOR
 K LEXDD S LEXOUT=$$ICDD^ICDEX(LEXSO,.LEXDD,LEXVDT,LEXSRC)
 I +LEXOUT>0 D
 . N LEXI,LEXC S (LEXI,LEXC)=0 F  S LEXI=$O(LEXDD(LEXI)) Q:+LEXI'>0  D
 . . S LEXC=LEXC+1 S ARY("SYS",14,LEXC)=$G(LEXDD(LEXI)),ARY("SYS",14,0)=LEXC
 Q
CPTCPC ; CPT-4/HCPCS
 N LEXC,LEXDAT,LEXDD,LEXDRG,LEXFY,LEXI,LEXLEXI,LEXMD,LEXMDC,LEXMOR,LEXOUT,LEXSDO
 S LEXDAT=$$CPT^ICPTCOD(LEXSO,LEXVDT) Q:+LEXDAT<0  S LEXSDO=+LEXDAT
 S ARY("SYS",1)=LEXSDO,ARY("SYS",2)=$P(LEXDAT,"^",3)
 S ARY("SYS",13)=$P(LEXDAT,"^",4) K ^TMP("ICPTD",$J)
 S LEXOUT=$$CPTD^ICPTCOD(LEXSO,,,$G(LEXVDT))
 I +LEXOUT>2,'$L($$TM($G(^TMP("ICPTD",$J,(LEXOUT-1))))) D
 . K ^TMP("ICPTD",$J,(LEXOUT-1)),^TMP("ICPTD",$J,LEXOUT)
 I +LEXOUT>0 D
 . N LEXI,LEXC S (LEXI,LEXC)=0 F  S LEXI=$O(^TMP("ICPTD",$J,LEXI)) Q:+LEXI'>0  D
 . . S LEXC=LEXC+1 S ARY("SYS",14,LEXC)=$G(^TMP("ICPTD",$J,LEXI)),ARY("SYS",14,0)=LEXC
 K ^TMP("ICPTD",$J)
 Q
CS ; CS Segment if CS is NULL
 N LEXI,LEXC S LEXSRC=+($G(LEXSRC))
 S ARY("SYS",1)=$G(ARY("SYS",1)),ARY("SYS",1,"N")="IEN"
 S ARY("SYS",2)=$G(ARY("SYS",2)),ARY("SYS",2,"N")="Short Name"
 S ARY("SYS",3)=$G(ARY("SYS",3)),ARY("SYS",3,"N")="Age High"
 S ARY("SYS",4)=$G(ARY("SYS",4)),ARY("SYS",4,"N")="Age Low"
 S ARY("SYS",5)=$G(ARY("SYS",5)),ARY("SYS",5,"N")="Sex"
 S (LEXI,LEXC)=0 F  S LEXI=$O(ARY("SYS",6,LEXI)) Q:+LEXI'>0  D
 . S LEXC=LEXC+1 S ARY("SYS",6,LEXC,1)=$G(ARY("SYS",6,LEXC,1)),ARY("SYS",6,LEXC,1,"N")="MDC"
 . S ARY("SYS",6,LEXC,2)=$G(ARY("SYS",6,LEXC,2)),ARY("SYS",6,LEXC,2,"N")="DRGs"
 S ARY("SYS",6,0)=LEXC,ARY("SYS",6,0,"N")="MDC/DRG"
 S ARY("SYS",7)=$G(ARY("SYS",7)),ARY("SYS",7,"N")="Complication/Comorbidity"
 S ARY("SYS",8)=$G(ARY("SYS",8)),ARY("SYS",8,"N")="MDC13"
 S ARY("SYS",9)=$G(ARY("SYS",9)),ARY("SYS",9,"N")="MDC24"
 S ARY("SYS",10)=$G(ARY("SYS",10)),ARY("SYS",10,"N")="MDC24"
 S ARY("SYS",11)=$G(ARY("SYS",11)),ARY("SYS",11,"N")="Unacceptable as Principal Dx"
 S ARY("SYS",12)=$G(ARY("SYS",12)),ARY("SYS",12,"N")="Major O.R Procedure"
 S ARY("SYS",13)=$G(ARY("SYS",13)),ARY("SYS",13,"N")="CPT Category"
 S (LEXI,LEXC)=0 F  S LEXI=$O(ARY("SYS",14,LEXI)) Q:+LEXI'>0  D
 . S LEXC=LEXC+1 S ARY("SYS",14,LEXC)=$G(ARY("SYS",14,LEXC))
 S ARY("SYS",14,0)=LEXC,ARY("SYS",14,0,"N")="Description"
 I LEXSRC=1!(LEXSRC=30) D  Q
 . K ARY("SYS",12) S ARY("SYS",12)="N/A" K ARY("SYS",13) S ARY("SYS",13)="N/A"
 I LEXSRC=2!(LEXSRC=31) D  Q
 . K ARY("SYS",3) S ARY("SYS",2)="N/A" K ARY("SYS",4) S ARY("SYS",4)="N/A" K ARY("SYS",7) S ARY("SYS",7)="N/A"
 . K ARY("SYS",8) S ARY("SYS",8)="N/A" K ARY("SYS",10) S ARY("SYS",10)="N/A" K ARY("SYS",11) S ARY("SYS",11)="N/A"
 . K ARY("SYS",13) S ARY("SYS",13)="N/A"
 I LEXSRC=3!(LEXSRC=4) D  Q
 . K ARY("SYS",3) S ARY("SYS",2)="N/A" K ARY("SYS",4) S ARY("SYS",4)="N/A" K ARY("SYS",5) S ARY("SYS",5)="N/A"
 . K ARY("SYS",6) S ARY("SYS",6)="N/A" K ARY("SYS",7) S ARY("SYS",7)="N/A" K ARY("SYS",8) S ARY("SYS",8)="N/A"
 . K ARY("SYS",9) S ARY("SYS",9)="N/A" K ARY("SYS",10) S ARY("SYS",10)="N/A"  K ARY("SYS",11) S ARY("SYS",11)="N/A"
 . K ARY("SYS",12) S ARY("SYS",12)="N/A"
 K ARY("SYS") S ARY("SYS",1)="N/A",ARY("SYS",2)="N/A",ARY("SYS",3)="N/A",ARY("SYS",4)="N/A",ARY("SYS",5)="N/A"
 S ARY("SYS",6)="N/A",ARY("SYS",7)="N/A",ARY("SYS",8)="N/A",ARY("SYS",9)="N/A",ARY("SYS",10)="N/A"
 S ARY("SYS",11)="N/A",ARY("SYS",12)="N/A",ARY("SYS",13)="N/A",ARY("SYS",14)="N/A"
 Q
LX ; Lexicon Segment 
 N LEXC,LEXI S ARY("LEX",1)=$G(ARY("LEX",1)),ARY("LEX",1,"N")="IEN ^ Preferred Term"
 S ARY("LEX",2)=$G(ARY("LEX",2)),ARY("LEX",2,"N")="Status ^ Effective Date"
 S ARY("LEX",3)=$G(ARY("LEX",3)),ARY("LEX",3,"N")="IEN ^ Major Concept Term"
 S ARY("LEX",4)=$G(ARY("LEX",4)),ARY("LEX",4,"N")="IEN ^ Fully Specified Name"
 S ARY("LEX",5)=$G(ARY("LEX",5)),ARY("LEX",5,"N")="Hierarchy (if exists)"
 S ARY("LEX",6,0)=$G(ARY("LEX",6,0)),ARY("LEX",6,0,"N")="Synonyms and Other Forms"
 S (LEXI,LEXC)=0 F  S LEXI=$O(ARY("LEX",6,LEXI)) Q:+LEXI'>0  D
 . S LEXC=LEXC+1 S ARY("LEX",6,LEXC)=$G(ARY("LEX",6,LEXC))
 S ARY("LEX",6,0)=LEXC
 S ARY("LEX",7,0)=$G(ARY("LEX",7,0)),ARY("LEX",7,0,"N")="Semantic Map"
 S (LEXI,LEXC)=0 F  S LEXI=$O(ARY("LEX",7,LEXI)) Q:+LEXI'>0  D
 . S LEXC=LEXC+1 S ARY("LEX",7,LEXC,1)=$G(ARY("LEX",7,LEXC,1))
 . S ARY("LEX",7,LEXC,1,"N")="Semantic Class ^ Semantic Type (internal)"
 . S ARY("LEX",7,LEXC,2)=$G(ARY("LEX",7,LEXC,2))
 . S ARY("LEX",7,LEXC,2,"N")="Semantic Class ^ Semantic Type (external)"
 S ARY("LEX",7,0)=LEXC
 S ARY("LEX",8)=$G(ARY("LEX",8)),ARY("LEX",8,"N")="Deactivated Concept Flag"
 Q
 ;       
MODS ; CPT Modifiers
 N IEN,STR,MAX,OUT,LEN,CODE,TD S TD=$$DT^XLFDT,MAX=0,OUT=""
 S IEN=0 F  S IEN=$O(^ICPT(IEN)) Q:+IEN'>0  D
 . S CODE=$P($G(^ICPT(IEN,0)),"^",1)
 . K ARY D MS(CODE,TD,.ARY)
 Q
MS(X,CDT,LEXS) ; Modifier Strings
 N LEXDT,LEXSO,LEXCT,LEX,LEXM,LEXMOD K LEXS S LEXSO=$G(X),LEXDT=$G(CDT) S:LEXDT'?7N LEXDT=$$DT^XLFDT D MODA^ICPTMOD(LEXSO,LEXDT,.LEX)
 S LEXMOD="",LEXM="",LEXCT=0 F  S LEXM=$O(LEX("A",LEXM)) Q:'$L(LEXM)  D
 . Q:$L(LEXM)'=2  S LEXCT=LEXCT+1,LEXMOD=LEXMOD_"^"_LEXM
 . I LEXCT>19 D
 . . N LEXI S LEXI=$O(LEXS(" "),-1)+1
 . . S LEXS(LEXI)=$$TM(LEXMOD,"^") S LEXMOD="",LEXCT=0
 I $L($G(LEXMOD)) D
 . N LEXI S LEXI=$O(LEXS(" "),-1)+1 S LEXS(LEXI)=$$TM(LEXMOD,"^")
 Q
CODSAB(X,Y) ; Is Code valid for SAB
 N COD,SAB,SRC,OK,SIEN S COD=$G(X),SAB=$$CSYS^LEXU($G(Y)) Q:'$L(COD) 0  Q:+SAB'>0 0
 S SAB=$P(SAB,"^",2) Q:'$L(SAB) 0  Q:'$D(^LEX(757.03,"ASAB",SAB)) 0
 S SRC=$O(^LEX(757.03,"ASAB",SAB,0)) Q:+SRC'>0 0  S OK=0
 S SIEN=0 F  S SIEN=$O(^LEX(757.02,"CODE",(COD_" "),SIEN)) Q:+SIEN'>0  D
 . S:$P($G(^LEX(757.02,+SIEN,0)),"^",3)=SRC OK=1
 S X=OK
 Q X
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
