LEXU ;ISL/KER - Miscellaneous Lexicon Utilities ;12/19/2014
 ;;2.0;LEXICON UTILITY;**2,6,9,15,25,36,73,51,80,86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    $$ICDDX^ICDEX       ICR   5747
 ;    $$ICDOP^ICDEX       ICR   5747
 ;    $$CPT^ICPTCOD       ICR   1995
 ;               
HELP ; API Help
 D EN^LEXUH
 Q
SC(LEX,LEXS,LEXVDT) ; Filter by Semantic Class
 Q $$SC^LEXU6($G(LEX),$G(LEXS),$G(LEXVDT))
SO(LEX,LEXS,LEXVDT) ; Filter by Source
 Q $$SO^LEXU6($G(LEX),$G(LEXS),$G(LEXVDT))
ICDDP(LEX,LEXT,LEXVDT) ; Filter by ICD Diagnosis/Procedure System
 ;
 ; Input
 ;
 ;    LEX      IEN of file 757.01 (required)
 ;    LEXT     ICD Type (optional)
 ;                 1  ICD Diagnosis (default)
 ;                 2  ICD Procedures
 ;    LEXVDT   Date to use for screening by codes
 ;                 Date before Oct 1, 2013, ICD-9 assumed
 ;                 Date after Sep 30, 2013, ICD-10 assumed
 ; Output
 ;
 ;    $$ICDDP  1/0
 ;
 N LEXEI,LEXF,LEXMC,LEXMCE,LEXSRC,LEXSRI,ICD10 S (LEXSRC,LEXSRI)=""
 S LEXEI=+LEX Q:'$D(^LEX(757.01,LEXEI,0)) 0  S ICD10=$$IMPDATE("10D")
 S LEXT=$G(LEXT) S:+LEXT<0!(LEXT>2) LEXT=1 D VDT
 S:LEXT=1&(LEXVDT<ICD10) LEXSRC="ICD",LEXSRI=1
 S:LEXT=1&(LEXVDT'<ICD10) LEXSRC="10D",LEXSRI=30
 S:LEXT=2&(LEXVDT<ICD10) LEXSRC="ICP",LEXSRI=2
 S:LEXT=2&(LEXVDT'<ICD10) LEXSRC="10P",LEXSRI=31
 Q:'$L(LEXSRC) 0  Q:LEXSRI'>0 0
 S LEXF=0,LEXMC=+($P(^LEX(757.01,LEXEI,1),U,1)) Q:LEXMC'>0 0
 S LEXMCE=+(^LEX(757,+($P(^LEX(757.01,LEXEI,1),U,1)),0)) Q:LEXMCE'>0 0
 S LEXF=0 I LEXEI+LEXMCE>0 D
 . N LEXSI S LEXSI=0
 . F  S LEXSI=$O(^LEX(757.02,"AMC",LEXMC,LEXSI)) Q:+LEXSI=0!(LEXF)  D  Q:LEXF
 . . N LEXN0,LEXSAB,LEXSO,LEXSTA
 . . S LEXN0=$G(^LEX(757.02,LEXSI,0)),LEXSAB=+($P(LEXN0,U,3))
 . . Q:LEXSAB'=LEXSRI  Q:"^1^2^30^31^"'[("^"_LEXSAB_"^")
 . . S LEXSO=$P(LEXN0,U,2)
 . . S LEXSTA=$$STATCHK^LEXSRC2(LEXSO,LEXVDT,,LEXSAB)
 . . Q:+LEXSTA'>0  S LEXF=1
 S LEX=$G(LEXF)
 Q LEX
DX(LEX,LEXVDT) ; Filter by Diagnosis System
 ; 
 ; Input
 ; 
 ;    LEX      IEN of file 757.01
 ;    LEXVDT   Date to use for screening by codes
 ;
 ; Output
 ;
 ;    $$DX     1/0
 ;
 N LEXEI,LEXF,LEXMC,LEXMCE,LEXSRC,LEXSRI,ICD10
 S LEXEI=+LEX Q:'$D(^LEX(757.01,LEXEI,0)) 0
 D VDT S LEXSRC="ICD",LEXSRI=1 S ICD10=$$IMPDATE("10D")
 S:+($G(LEXVDT))'<ICD10 LEXSRC="10D",LEXSRI=30
 S LEXF=0,LEXMC=+($P(^LEX(757.01,LEXEI,1),U,1)) Q:LEXMC'>0 0
 S LEXMCE=+(^LEX(757,+($P(^LEX(757.01,LEXEI,1),U,1)),0)) Q:LEXMCE'>0 0
 S LEXF=0 I LEXEI+LEXMCE>0 D
 . N LEXSI S LEXSI=0
 . F  S LEXSI=$O(^LEX(757.02,"AMC",LEXMC,LEXSI)) Q:+LEXSI=0!(LEXF)  D
 . . N LEXN0,LEXSAB,LEXSO,LEXSTA
 . . S LEXN0=$G(^LEX(757.02,LEXSI,0)),LEXSAB=+($P(LEXN0,U,3))
 . . Q:LEXSAB'=LEXSRI  Q:"^1^30^"'[("^"_LEXSAB_"^")
 . . S LEXSO=$P(LEXN0,U,2)
 . . S LEXSTA=$$STATCHK^LEXSRC2(LEXSO,LEXVDT,,LEXSAB)
 . . Q:+LEXSTA'>0  S LEXF=1
 K LEX S LEX=$G(LEXF)
 Q LEX
SRC(LEX,LEXS) ; Filter by Expression Source
 ;    LEX      Expression  IEN of file 757.01
 ;    LEXS     Source      IEN of 757.14
 S LEX=+($G(LEX)),LEXS=+($G(LEXS)) Q:LEX=0 0  Q:LEXS=0 0
 Q:'$D(^LEX(757.01,LEX,0)) 0 Q:'$D(^LEX(757.14,LEXS,0)) 0
 S LEXSR=$P($G(^LEX(757.01,LEX,1)),U,12) Q:LEXSR=LEXS 1
 N LEXSR,LEXMC,LEXMCE S LEXMC=+($G(^LEX(757.01,LEX,1)))
 S LEXMCE=+($G(^LEX(757,+LEXMC,0)))
 S LEXSR=$P($G(^LEX(757.01,LEXMCE,1)),U,12) Q:LEXSR=LEXS 1
 Q 0
DEF(LEX) ; Display expression definition
 ;    LEX      IEN of file 757.01
 I $D(^LEX(757.01,LEX,3,0)) D
 . N LEXLN F LEXLN=1:1:$P(^LEX(757.01,LEX,3,0),U,4) D
 . . I $D(^LEX(757.01,LEX,3,LEXLN,0)) W !,?2,^LEX(757.01,LEX,3,LEXLN,0)
 . K LEX,LEXLN W !
 Q
ID(LEX) ; ICD Diagnosis retained - ICD procedures ignored
 ;    LEX      Code
 Q:'$L($G(LEX)) ""  Q:$L($P(LEX,".",1))<3 ""
 Q:'$D(^LEX(757.02,"AVA",(LEX_" "))) ""
 N LEXO,LEXR S (LEXO,LEXR)=0
 F  S LEXR=$O(^LEX(757.02,"AVA",(LEX_" "),LEXR)) Q:+LEXR=0  D  Q:LEXO=1
 . I $D(^LEX(757.02,"AVA",(LEX_" "),LEXR,"ICD")) S LEXO=1
 Q:'LEXO "" Q LEX
ICDONE(LEX,LEXVDT) ; Get One ICD-9 Diagnosis Code for a Term
 ; 
 ; Input
 ; 
 ;    LEX      IEN of file 757.01
 ;    LEXVDT   Date to use for screening by codes
 ;
 ; Output
 ;
 ;    $$ICDONE ICD-9 Code
 ;
 N LEXICD D VDT S LEXICD=$$ONE($G(LEX),$G(LEXVDT),"ICD")
 Q:'$L($P(LEXICD,"^",1)) ""  S LEX=LEXICD
 Q LEX
D10ONE(LEX,LEXVDT) ; Get One ICD-10 Diagosis Code for a Term
 ; 
 ; Input
 ; 
 ;    LEX      IEN of file 757.01
 ;    LEXVDT   Date to use for screening by codes
 ;
 ; Output
 ;
 ;    $$D10ONE ICD-10-CM Diagnosis Code or Null
 ;
 N LEXICD D VDT S LEXICD=$$ONE($G(LEX),$G(LEXVDT),"10D")
 Q:'$L($P(LEXICD,"^",1)) ""  S LEX=LEXICD
 Q LEX
P10ONE(LEX,LEXVDT) ; Get One ICD-10 Procedure Code for a Term
 ; 
 ; Input
 ; 
 ;    LEX      IEN of file 757.01
 ;    LEXVDT   Date to use for screening by codes
 ;
 ; Output
 ;
 ;    $$P10ONE ICD-10-PCS Procedure Code or Null
 ;
 N LEXICD D VDT S LEXICD=$$ONE($G(LEX),$G(LEXVDT),"10P")
 Q:'$L($P(LEXICD,"^",1)) ""  S LEX=LEXICD
 Q LEX
CPTONE(LEX,LEXVDT) ; Get One CPT Code for a Term
 ; 
 ; Input
 ; 
 ;    LEX      IEN of file 757.01
 ;    LEXVDT   Date to use for screening by codes
 ;
 ; Output
 ;
 ;    $$CPTONE CPT Code or Null
 ;
 N LEXCPT D VDT S LEXCPT=$$ONE($G(LEX),$G(LEXVDT),"CPT")
 Q:'$L($P(LEXCPT,"^",1)) ""  S LEX=LEXCPT
 Q LEX
CPCONE(LEX,LEXVDT) ; Get One HCPCS Code for a Term
 ; 
 ; Input
 ; 
 ;    LEX      IEN of file 757.01
 ;    LEXVDT   Date to use for screening by codes
 ;
 ; Output
 ;
 ;    $$CPCONE HCPCS Code or Null
 ;
 N LEXCPT D VDT S LEXCPT=$$ONE($G(LEX),$G(LEXVDT),"CPC")
 Q:'$L($P(LEXCPT,"^",1)) ""  S LEX=LEXCPT
 Q LEX
DSMONE(LEX,LEXVDT) ; Get One DSM Code for a Term
 ; 
 ; Input
 ; 
 ;    LEX      IEN of file 757.01
 ;    LEXVDT   Date to use for screening by codes
 ;
 ; Output
 ;
 ;    $$DSMONE DSM-IV Code or Null
 ;
 N LEXDSM,LEXCD,LEXDAT D VDT S LEXDSM=$$ONE^LEXSRC($G(LEX),"DS4")
 I LEXDSM'="" D  Q LEX
 . S LEX=LEXDSM N LEXDAT,LEXCD S LEXCD=LEXDSM S:$L(LEXCD)=3 LEXCD=LEXCD_"."
 . S LEXDAT=$$ICDDX^ICDEX(LEXCD,$G(LEXVDT),1,"E")
 . S:$P(LEXDAT,"^",10)'>0 LEX=""
 S LEXDSM=$$ONE^LEXSRC($G(LEX),"DS3") I LEXDSM'="" D  Q LEX
 . S LEX=LEXDSM N LEXDAT,LEXCD S LEXCD=LEXDSM S:$L(LEXCD)=3 LEXCD=LEXCD_"."
 . S LEXDAT=$$ICDDX^ICDEX(LEXCD,$G(LEXVDT),1,"E")
 . S:$P(LEXDAT,"^",10)'>0 LEX=""
 Q ""
 ;
SCT(X,LEXVDT) ;   Filter by SNOMED CT (SCT) (Human only)
 ; 
 ; Input
 ; 
 ;    X        IEN of file 757.01
 ;    LEXVDT   Date to use for screening by codes
 ;
 ; Output
 ;
 ;    $$SCT    Human SNOMED Code or Null
 ;             Excludes Veterinary SNOMED codes
 ;
 N LEXEX,LEXMC,LEXD,LEXC,LEXI,LEXO,LEXPL,LEXVT S LEXEX=+($G(X)),LEXD=$G(LEXVDT) Q:LEXEX'>0 0
 S LEXC=$S(LEXD?7N:$$ONE^LEXU(+LEXEX,LEXD,"SCT"),1:$$ONE^LEXU(+LEXEX,,"SCT"))
 Q:'$L(LEXC) 0  S LEXMC=+($G(^LEX(757.01,+LEXEX,1))) Q:LEXMC'>0 0  Q:'$D(^LEX(757.1,"B",LEXMC)) 0
 S LEXVT=0,LEXI=0 F  S LEXI=$O(^LEX(757.1,"B",LEXMC,LEXI)) Q:+LEXI'>0  D  Q:LEXVT>0
 . N LEXT,LEXN S LEXT=$P($G(^LEX(757.1,LEXI,0)),"^",3),LEXN=$$UP^XLFSTR($P($G(^LEX(757.12,+LEXT,0)),"^",2)) S:LEXN["VETERINARY" LEXVT=1
 S LEXPL=0,LEXI=0 F  S LEXI=$O(^LEX(757.21,"B",LEXEX,LEXI)) Q:+LEXI'>0  D  Q:LEXPL>0
 . N LEXT,LEXN S LEXT=$P($G(^LEX(757.21,LEXI,0)),"^",2),LEXN=$P($G(^LEXT(757.2,+LEXT,0)),"^",2) S:LEXN="PLS" LEXPL=1
 S LEXO=1 S:LEXVT=1 LEXO=0 S:LEXPL'>0 LEXO=0
 S X=LEXO
 Q X
ONE(LEX,LEXVDT,LEXSAB) ; Get One Code for a Term by Source
 ; 
 ; Input
 ;    LEX      IEN of file 757.01
 ;    LEXVDT   Date to use for screening by codes
 ;    LEXSAB   Source Abbreviation
 ;
 ; Output
 ;
 ;    $$ONE    Code or Null
 ;
 N LEXDAT,LEXIEN D VDT S LEXIEN=$G(LEX) Q:+($G(LEXIEN))'>0 ""
 S LEXSAB=$G(LEXSAB) Q:'$L(LEXSAB) ""
 I LEXSAB?1N.N,'$D(^LEX(757.03,"ASAB",LEXSAB)),$D(^LEX(757.03,+LEXSAB,0)) D
 . S LEXSAB=$P($G(^LEX(757.03,+LEXSAB,0)),"^",1)
 S LEXSAB=$E($G(LEXSAB),1,3) Q:$L(LEXSAB)'=3 ""
 S LEX=$$ONE^LEXSRC(LEXIEN,LEXSAB,LEXVDT),LEXDAT=""
 S:LEXSAB="ICD"!(LEXSAB="DS4") LEXDAT=$$ICDDX^ICDEX(LEX,LEXVDT,1,"E")
 S:LEXSAB="10D" LEXDAT=$$ICDDX^ICDEX(LEX,LEXVDT,30,"E")
 S:LEXSAB="ICP" LEXDAT=$$ICDOP^ICDEX(LEX,LEXVDT,2,"E")
 S:LEXSAB="10P" LEXDAT=$$ICDOP^ICDEX(LEX,LEXVDT,31,"E")
 S:LEXSAB="CPT" LEXDAT=$$CPT^ICPTCOD(LEX,LEXVDT)
 S:LEXSAB="CPC" LEXDAT=$$CPT^ICPTCOD(LEX,LEXVDT)
 Q:"^CPT^CPC"[("^"_LEXSAB_"^")&($P(LEXDAT,"^",7)'>0) ""
 Q:"^ICD^ICP^10D^10P^"[("^"_LEXSAB_"^")&($P(LEXDAT,"^",10)'>0) ""
 S LEX="" I +LEXDAT'>0 D
 . N LEXSIEN S LEXSIEN=0
 . F  S LEXSIEN=$O(^LEX(757.02,"B",LEXIEN,LEXSIEN)) Q:+LEXSIEN'>0  D  Q:+LEXDAT>0
 . . Q:'$D(^LEX(757.02,"ASRC",LEXSAB,LEXSIEN))  N LEXEF,LEXHI,LEXST,LEXCD
 . . S LEXEF=$O(^LEX(757.02,LEXSIEN,4,"B",(LEXVDT+.001)),-1) Q:'$L(LEXEF)
 . . S LEXHI=$O(^LEX(757.02,LEXSIEN,4,"B",+LEXEF," "),-1)
 . . S LEXST=$P($G(^LEX(757.02,LEXSIEN,4,+LEXHI,0)),"^",2) Q:LEXST'>0
 . . S LEXCD=$P($G(^LEX(757.02,+LEXSIEN,0)),"^",2)
 . . S:$L(LEXCD)&(+LEXIEN>0) LEXDAT=LEXIEN_"^"_LEXCD
 Q:+LEXDAT'>0 "" S LEX=$P(LEXDAT,"^",2)
 I $G(LEXLKT)["BC" D
 . N LEXNAR S LEXNAR=$$UP^XLFSTR($G(^TMP("LEXSCH",$J,"NAR",0)))
 . I $L($G(LEXNAR)) S:$E(LEX,1,$L($G(LEXNAR)))'=$G(LEXNAR) LEX=""
 Q LEX
ICD(LEX,LEXVDT) ; Get All ICD-9 Diagnosis Codes for a Term
 ; 
 ;   Input  
 ;   
 ;     LEX       IEN of file 757.01
 ;     LEXVDT    Date to use for screening by codes
 ;          
 ;   Output 
 ;   
 ;     $$ICD     <ICD-9 code>;<ICD-9 code>;<etc>
 ; 
 D VDT S LEX=$$ALL^LEXU($G(LEX),$G(LEXVDT),"ICD")
 Q LEX
D10(LEX,LEXVDT) ; Get All ICD-10 Diagnosis Codes for a Term
 ;
 ;   Input  
 ;   
 ;      LEX       IEN of file 757.01
 ;      LEXVDT    Date to use for screening by codes
 ;          
 ;   Output 
 ;   
 ;      $$D10     <ICD-10 code>;<ICD-10 code>;<etc>
 ;          
 D VDT S LEX=$$ALL^LEXU($G(LEX),$G(LEXVDT),"10D")
 Q LEX
 ;
ALL(LEX,LEXVDT,LEXSAB) ; Get All Codes for a Term by Source
 ; 
 ; Input
 ; 
 ;    LEX      IEN of file 757.01
 ;    LEXVDT   Date to use for screening by codes
 ;    LEXSAB   Source Abbreviation
 ;    
 ; Output
 ; 
 ;    $$ALL    A ";" delimited string of codes
 ;             of the specified coding system
 ;             for the term
 ;             
 N LEXDAT,LEXIEN,LEXSRC,LEXI,LEXT,LEXS D VDT
 S LEXIEN=+($G(LEX)) Q:+($G(LEXIEN))'>0 ""
 S LEXSAB=$E($G(LEXSAB),1,3) Q:$L(LEXSAB)'=3 ""
 D ALL^LEXSRC(LEX,LEXSAB,LEXVDT)
 Q:+$G(LEXSRC(0))'>0 ""  S LEXI=0,LEXT=""
 F  S LEXI=$O(LEXSRC(LEXI)) Q:+LEXI=0  D
 . S LEXS=LEXSRC(LEXI)
 . S:LEXSAB="ICD" LEXDAT=$$ICDDX^ICDEX(LEXS,$G(LEXVDT),1,"E")
 . S:LEXSAB="10D" LEXDAT=$$ICDDX^ICDEX(LEXS,$G(LEXVDT),30,"E")
 . S:LEXSAB="10P" LEXDAT=$$ICDOP^ICDEX(LEXS,$G(LEXVDT),31,"E")
 . S:LEXSAB="CPT" LEXDAT=$$CPT^ICPTCOD(LEXS,LEXVDT)
 . S:LEXSAB="CPC" LEXDAT=$$CPT^ICPTCOD(LEXS,LEXVDT)
 . Q:+($G(LEXDAT))'>0
 . Q:"^CPT^CPT"[("^"_LEXSAB_"^")&($P($G(LEXDAT),"^",7)'>0)
 . Q:"^ICD^ICP^10D^10P^"[("^"_LEXSAB_"^")&($P($G(LEXDAT),"^",10)'>0)
 . Q:(LEXT_";")[(";"_LEXS_";")  S LEXT=LEXT_";"_LEXS
 S LEX="" S:$E(LEXT,1)=";" LEXT=$E(LEXT,2,$L(LEXT)) S LEX=LEXT
 Q LEX
HIST(CODE,SYS,ARY) ; Activation History
 Q $$HIST^LEXU4($G(CODE),$G(SYS),.ARY)
PERIOD(CODE,SYS,ARY) ; Return Activation Periods
 Q $$PERIOD^LEXU4($G(CODE),$G(SYS),.ARY)
CSDATA(CODE,CSYS,CDT,ARY) ; Code Data
 N X S X=$$CSDATA^LEXU2($G(CODE),$G(CSYS),$G(CDT),.ARY) Q X
ADR(LEX) ; Mailing Address
 Q $$ADR^LEXU3($G(LEX))
VDT ; Resolve LEXVDT
 D VDT^LEXU3 Q
IMPDATE(CSYS) ; Return the implementation date for a coding system
 Q $$IMPDATE^LEXU5($G(CSYS))
CSYS(SYS) ; Coding System Info
 Q $$CSYS^LEXU5($G(SYS))
FREQ(TXT) ; Frequency of text - ICR 5679
 Q $$FREQ^LEXU3($G(TXT))
MAX(SYS) ; Coding System search Threshold - ICR 5679
 Q $$MAX^LEXU3($G(SYS))
PAR(TXT,ARY) ; Parse Text into Words (for indexing)
 Q $$PAR^LEXU3(TXT,.ARY)
CAT(CODE) ; Get Category of Dx Code - ICR 5679
 Q $$CAT^LEX10DU($G(CODE))
ISCAT(CODE) ; Get Category of Dx Code - ICR 5679
 Q $$ISCAT^LEX10DU($G(CODE))
PFI(FRAG,CDT,ARY) ; ICD-10 Procedure Code Fragment Information - ICR 5679
 Q $$PFI^LEXU4($G(FRAG),$G(CDT),.ARY)
NXSAB(X,Y) ; Next Source Abbreviation
 Q $$NXSAB^LEXU3($G(X),$G(Y))
INC(X) ; Increment Concept Usage for a term (by subscription only)
 D INC^LEXU3($G(X))
 Q
RECENT(X) ; Recently Updated (90 day window)
 Q $$RECENT^LEXU3($G(X))
RUPD(X) ; Recent Update Date
 Q $$RUPD^LEXU3($G(X))
LUPD(X,Y) ; Last Update
 Q $$LUPD^LEXU3($G(X),$G(Y))
REUSE(X,SYS) ; Is a code "re-used" (1/0)
 Q $$REUSE^LEXU4($G(X),$G(SYS))
REVISE(X,SYS) ; Is a code "revised" (1/0)
 Q $$REVISE^LEXU4($G(X),$G(SYS))
LAST(X,SYS,CDT) ; Last Activation ^ Last Inactivation Date
 Q $$LAST^LEXU4($G(X),$G(SYS),$G(CDT))
