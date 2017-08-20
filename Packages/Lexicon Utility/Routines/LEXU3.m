LEXU3 ;ISL/KER - Miscellaneous Lexicon Utilities ;05/23/2017
 ;;2.0;LEXICON UTILITY;**80,86,103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^LEX(757.001)       N/A
 ;    ^TMP("LEXSCH")      SACC 2.3.2.5.1
 ;    ^TMP("LEXTKN")      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$FMDIFF^XLFDT      ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$GET1^DIQ          ICR   2056
 ;    ^DIC                ICR  10006
 ;               
PRF(LEX,LEXVDT,LEXSAB) ;  Get Code for a Preferred Term by Source
 ; 
 ; Input
 ;    LEX      IEN file 757.01
 ;    LEXVDT   Date for screening
 ;    LEXSAB   Source or pointer to 757.03
 ;
 ; Output
 ;
 ;    $$PPR    Null   if the IEN is NOT the preferred term
 ;             CODE   if the IEN is the preferred term
 ;
 N LEXCOD,LEXEF,LEXHI,LEXIEN,LEXND,LEXSIEN,LEXSRC,LEXST D VDT
 S LEXIEN=$G(LEX) Q:+($G(LEXIEN))'>0 ""  S LEXSAB=$G(LEXSAB) Q:'$L(LEXSAB) ""
 S:LEXSAB?1N.N&($D(^LEX(757.03,+LEXSAB,0))) LEXSAB=$P($G(^LEX(757.03,+LEXSAB,0)),"^",1)
 S LEXSAB=$E($G(LEXSAB),1,3) Q:$L(LEXSAB)'=3 ""  S LEXSRC=$O(^LEX(757.03,"ASAB",LEXSAB,0)) Q:+LEXSRC'>0
 S LEXCOD="",LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.02,"B",LEXIEN,LEXSIEN)) Q:+LEXSIEN'>0  D  Q:$L(LEXCOD)
 . N LEXND,LEXEF,LEXHI,LEXST S LEXND=$G(^LEX(757.02,+LEXSIEN,0)) Q:$P(LEXND,"^",5)'>0  Q:$P(LEXND,"^",3)'=LEXSRC
 . S LEXEF=$O(^LEX(757.02,+LEXSIEN,4,"B",(LEXVDT+.001)),-1) Q:LEXEF'?7N
 . S LEXHI=$O(^LEX(757.02,+LEXSIEN,4,"B",+LEXEF," "),-1) Q:+LEXHI'>0
 . S LEXST=$P($G(^LEX(757.02,+LEXSIEN,4,+LEXHI,0)),"^",2) Q:+LEXST'>0
 . S LEXCOD=$P(LEXND,"^",2)
 S LEX=LEXCOD
 Q LEX
ADR(LEX) ; Mailing Address
 N DIC,DTOUT,DUOUT,X,Y S DIC="^DIC(4.2,",DIC(0)="M"
 S (LEX,X)="DOMAIN.EXT" D ^DIC Q:+Y>0 LEX
 S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="ISC-SLC.DOMAIN.EXT"
 D ^DIC Q:+Y>0 LEX
 Q "ISC-SLC.DOMAIN.EXT"
VDT ; Resolve LEXVDT
 N LEXSD I $P($G(LEXVDT),".",1)?7N D  Q
 . S LEXVDT=$P($G(LEXVDT),".",1)
 . S LEXVDT=$$FMADD^XLFDT(LEXVDT,0)
 . S:LEXVDT'>0 LEXVDT=$$DT^XLFDT
 . S:$D(^TMP("LEXSCH",$J)) ^TMP("LEXSCH",$J,"VDT",0)=+($G(LEXVDT))
 . S:$D(^TMP("LEXSCH",$J)) ^TMP("LEXSCH",$J,"VDT",1)="Version Date Check: "_$$FMTE^XLFDT($G(LEXVDT))
 S LEXSD=$P($G(^TMP("LEXSCH",$J,"VDT",0)),".",1)
 I $P($G(LEXVDT),".",1)'?7N,LEXSD?7N D
 . S LEXVDT=$P($G(LEXSD),".",1)
 . S LEXVDT=$$FMADD^XLFDT(LEXVDT,0)
 . S:LEXVDT'>0 LEXVDT=$$DT^XLFDT
 . S:$D(^TMP("LEXSCH",$J)) ^TMP("LEXSCH",$J,"VDT",0)=+($G(LEXVDT))
 . S:$D(^TMP("LEXSCH",$J)) ^TMP("LEXSCH",$J,"VDT",1)="Version Date Check: "_$$FMTE^XLFDT($G(LEXVDT))
 I $P($G(LEXVDT),".",1)'?7N D
 . S LEXVDT=$$DT^XLFDT
 . S:$D(^TMP("LEXSCH",$J)) ^TMP("LEXSCH",$J,"VDT",0)=+($G(LEXVDT))
 . S:$D(^TMP("LEXSCH",$J)) ^TMP("LEXSCH",$J,"VDT",1)="Version Date Check: "_$$FMTE^XLFDT($G(LEXVDT))
 Q
INC(X) ; Increment Concept Usage for a term
 N LEXIEN,LEXMC S LEXIEN=+($G(X)) Q:'$D(^LEX(757.01,+LEXIEN,0))
 S LEXMC=+($G(^LEX(757.01,+LEXIEN,1))) Q:+LEXMC'>0
 Q:'$D(^LEX(757,+LEXMC,0))  Q:+($G(^LEX(757,+LEXMC,0)))'=LEXIEN
 Q:'$D(^LEX(757.001,+LEXMC,0))
 D INC^LEXAR4(LEXMC)
 Q
FREQ(TEXT) ; Get the Frequency of use for a Text String
 ; 
 ; Input   
 ; 
 ;   TEXT     Text String
 ;   
 ; Output
 ; 
 ;   $$FREQ   Frequency of Text
 ;             
 S TEXT=$G(TEXT) Q:'$L(TEXT) 0  N X S X=TEXT K ^TMP("LEXTKN",$J) D PTX^LEXTOKN
 N LEXI,LEXT,LEXF,LEXA S LEXI=0
 F  S LEXI=$O(^TMP("LEXTKN",$J,LEXI)) Q:+LEXI'>0  D
 . S LEXT="" F  S LEXT=$O(^TMP("LEXTKN",$J,LEXI,LEXT)) Q:'$L(LEXT)  D
 . . S LEXF=+($O(^LEX(757.01,"ASL",LEXT,0))) Q:LEXF'>0  S LEXA(LEXF)=LEXT
 S TEXT=+($O(LEXA(0))) K ^TMP("LEXTKN",$J)
 Q TEXT
PAR(TEXT,ARY) ; Parse Text into Words
 ;
 ; Input   
 ; 
 ;   TEXT    Text String
 ;   ARY     Local array
 ; 
 ; Output  
 ; 
 ;   $$PAR   Number of Words
 ;   ARY     Output array
 ;         
 ;           Words Found
 ;              ARY(0)=#
 ;                 
 ;           Words in the order they appear in text
 ;              ARY(1)=WORD1
 ;              ARY(n)=WORDn
 ;                 
 ;           Words alphabetically with the frequency
 ;              ARY("B",WORDA)=# (Frequency of Use)
 ;              ARY("B",WORDB)=#
 ;                 
 ;           Words listed by frequency
 ;              ARY("L",1)=SEARCHWORD1
 ;              ARY("L",n)=SEARCHWORDn
 ; 
 ; Special Variables used by the parsing logic:
 ; 
 ;   LEXIDX    Use indexing logic
 ;             
 ;   LEXLOOK   Use Lookup logic
 ;             
 N LEXTI,LEXTL,X S LEXTI=$D(LEXIDX),LEXTL=$D(LEXLOOK) N LEXIDX,LEXLOOK
 I LEXTI>0 S LEXIDX="",LEXTL=0 K LEXLOOK
 I LEXTL>0 S LEXLOOK="",LEXTI=0 K LEXIDX
 S:'$D(LEXLOOK)&('$D(LEXIDX)) LEXIDX=""
 S (X,TEXT)=$G(TEXT) K ^TMP("LEXTKN",$J) D PTX^LEXTOKN
 N LEXI,LEXT,LEXF,LEXA,LEXC S LEXI=0 K ARY
 F  S LEXI=$O(^TMP("LEXTKN",$J,LEXI)) Q:+LEXI'>0  D
 . S LEXT="" F  S LEXT=$O(^TMP("LEXTKN",$J,LEXI,LEXT)) Q:'$L(LEXT)  D
 . . S LEXF=+($O(^LEX(757.01,"ASL",LEXT,0)))
 . . I '$D(ARY("B",LEXT)) D
 . . . N LEXC S LEXC=$O(ARY(" "),-1)+1
 . . . S ARY(+LEXC)=LEXT,ARY(0)=LEXC
 . . . S:+LEXF>0 ARY("F",+LEXF)=LEXT
 . . . S ARY("B",LEXT)=LEXF
 S LEXI=0 F  S LEXI=$O(ARY("F",LEXI)) Q:+LEXI'>0  D
 . N LEXT,LEXC S LEXT=$G(ARY("F",LEXI))
 . S LEXC=$O(ARY("L"," "),-1)+1
 . S:$L(LEXT) ARY("L",LEXC)=LEXT
 K ARY("F") S X=+($G(ARY(0))) K ^TMP("LEXTKN",$J)
 Q X
 ;
MAX(SYS) ; Get the Maximum Number of Terms to Search
 ; 
 ; Input   
 ; 
 ;   SYS       Coding System Abbreviation (757.03,.01)
 ;             or pointer to file 757.03
 ;  
 ; Output  
 ; 
 ;   $$MAX   Maximum number of term to look at before
 ;           issuing a warning to the user
 ;           
 N LEX S LEX=0,SYS=($G(SYS)) Q:'$L(SYS) 100000  S:SYS?1N.N LEX=+SYS
 S:+LEX'>0&($D(^LEX(757.03,"ASAB",SYS))) LEX=$O(^LEX(757.03,"ASAB",SYS,0))
 S:+LEX'>0&($D(^LEX(757.03,"B",SYS))) LEX=$O(^LEX(757.03,"B",SYS,0))
 S:+LEX'>0&($D(^LEX(757.03,"C",SYS))) LEX=$O(^LEX(757.03,"C",SYS,0))
 N Y S Y=$P($G(^LEX(757.03,+LEX,2)),"^",2) S SYS=$S(+Y>0:+Y,1:100000)
 Q SYS
NXSAB(SYS,REV) ; Get the Next/Previous Source Abbreviation
 ; 
 ; Input   
 ; 
 ;   SYS       Coding System Abbreviation (757.03,.01)
 ;               or pointer to file 757.03
 ;               or null
 ;   REV       Direction flag (optional)
 ;                0 or null finds next in a forward direction
 ;                1 finds next in a reverse direction
 ;                 
 ; Output  
 ; 
 ;   $$NXSAB   Next Source Abbreviation in the file
 ;
 N LEXS,LEXO,LEXR,X S (LEXS,LEXO)=$G(SYS),LEXR=+($G(REV)),X=""
 I LEXS?1N.N S:$D(^LEX(757.03,+LEXS,0)) LEXO=$E($G(^LEX(757.03,+LEXS,0)),1,3)
 S:LEXR>0&(LEXO="") LEXO=" "
 S:LEXR'>0 X=$O(^LEX(757.03,"ASAB",LEXO))
 S:LEXR>0 X=$O(^LEX(757.03,"ASAB",LEXO),-1)
 Q X
RECENT(X) ; Recently Updated (90 day window)
 ;
 ; Input
 ; 
 ;    X        Source Abbr or pointer to file 757.03
 ;    
 ; Output
 ; 
 ;    X        Boolean flag
 ;    
 ;             1  =  Coding system has been recently updated
 ;                     Checks for a quarterly update by
 ;                     Looking 30 days into the future
 ;                     Looking 60 days into the past
 ;                
 ;             0  =  Coding system has NOT been recently updated
 ;         
 ; This API can be used to trigger code set update protocols
 N LEXCD,LEXDF,LEXSRC,LEXTD S LEXSRC=$G(X),LEXCD=$$RUPD(LEXSRC)
 Q:LEXCD'?7N 0  S X=0 S LEXTD=$$DT^XLFDT
 I LEXCD>LEXTD S LEXDF=$$FMDIFF^XLFDT(LEXCD,LEXTD) S:LEXDF<31 X=1 Q X
 I LEXTD>LEXCD S LEXDF=$$FMDIFF^XLFDT(LEXTD,LEXCD) S:LEXDF<61 X=1 Q X
 Q:LEXTD=LEXCD 1
 Q 0
RUPD(SYS) ; Get the Date the Coding System was most Recently Updated
 ;
 ; Input
 ; 
 ;    SYS      Coding System Abbreviation (757.03,.01)
 ;             or pointer to file 757.03
 ;    
 ; Output
 ; 
 ;    $$RUPD   Date of most recent update based on Today+30
 ;         
 ;              or
 ;         
 ;             -1 ^ error message 
 ;    
 N LEXCDT,LEXSRC S LEXCDT=$$FMADD^XLFDT($$DT^XLFDT,30),LEXSRC=$G(SYS)
 S SYS=$$LUPD(LEXSRC,LEXCDT)
 Q SYS
LUPD(SYS,LEXVDT) ; Get the date the Coding System was Last Updated
 ;
 ; Input
 ; 
 ;    SYS      Source Abbr or pointer to 757.03
 ;    LEXVDT   Versioning date (optional)
 ;    
 ; Output
 ; 
 ;    $$LUPD   Date of last update based on date provided
 ;    
 N LEXCDT,LEXSAB,LEXSRC,LEXDT,LEXLUPD,LEXSYS S LEXCDT=$G(LEXVDT),LEXSRC=$G(SYS) Q:'$L(LEXSRC) "-1^Invalid coding system"
 S LEXSAB=$$CSYS^LEXU(LEXSRC) Q:+LEXSAB'>0 "-1^Invalid coding system abbreviation"
 S LEXSYS=$P(LEXSAB,"^",4) Q:'$D(LEXSYS) "-1^Invalid coding system"
 S LEXSAB=$P(LEXSAB,"^",2) Q:$L(LEXSAB)'=3 "-1^Invalid coding system abbreviation length"
 S LEXDT=$O(^LEX(757.02,"AUPD",LEXSAB,9999999),-1)
 S LEXLUPD=$O(^LEX(757.02,"AUPD",LEXSAB,(9999999+.00001)),-1)
 S:LEXCDT?7N LEXDT=$O(^LEX(757.02,"AUPD",LEXSAB,(LEXCDT+.00001)),-1)
 S SYS="-1^Invalid date" I LEXLUPD>LEXCDT D
 . S:LEXCDT?7N SYS="-1^"_LEXSYS_" coding system not implemented on "_$$FMTE^XLFDT(LEXCDT,"5Z")
 . S:LEXCDT'?7N SYS="-1^"_LEXSYS_" coding system not implemented"
 S:LEXDT?7N SYS=LEXDT
 Q SYS
EXP(IEN) ; Get Expression for IEN
 ; 
 ; Input
 ; 
 ;    IEN      IEN of file 757.01
 ;
 ; Output
 ;
 ;    $$EXP    Expression for IEN
 ;             
 Q $G(^LEX(757.01,+($G(IEN)),0))
EXPS(IEN,CDT,ARY) ; Get Expression and Codes for IEN
 ; 
 ; Input
 ; 
 ;    IEN      IEN of file 757.01
 ;    CDT      Versioning Date
 ;    ARY      Output Array passed by reference
 ;
 ; Output
 ;
 ;    ARY      Local Array passed by reference
 ;    
 ;             ARY(IEN)=Expression
 ;             ARY(IEN,#)= 3 piece "^" delimited string
 ;             
 ;               1  Code
 ;               2  Coding System
 ;               3  Pointer to national file
 ;             
 N LEXSA,LEXSOA,LEXEIEN,LEXSR,LEXN,LEXX,LEXEXP S LEXEIEN=+($G(IEN)) Q:+LEXEIEN'>0  Q:'$D(^LEX(757.01,+LEXEIEN,0))
 K ARY S LEXSA="ICD/ICP/10D/10P/CPT/CPC/DS4/SNM/NAN/OMA/NIC/SCC/SCT/BIR",LEXEXP=$G(^LEX(757.01,+LEXEIEN,0)) Q:'$L(LEXEXP)
 S LEXX=$$SOA^LEXASO(LEXEIEN,LEXSA,1,$G(CDT),.LEXSOA) S LEXSR=0 F  S LEXSR=$O(LEXSOA(LEXSR)) Q:+LEXSR'>0  D
 . N LEXT S LEXT=$G(LEXSOA(LEXSR,"P")) I $L(LEXT) S ARY(+LEXEIEN,LEXSR)=LEXT Q
 . S LEXT=$G(LEXSOA(LEXSR,1)) I $L(LEXT) S ARY(+LEXEIEN,LEXSR)=LEXT
 S ARY(+LEXEIEN)=LEXEXP
 Q
PREF(CODE,SAB,CDT) ; Get Preferred Expression for an Active Code
 ;
 ;   Input
 ;
 ;     CODE     Code (Required)
 ;     SAB      Source Abbr or pointer file 757.03 (Required) 
 ;     CDT      Versioning Date
 ;
 ;   Output
 ;
 ;     $$PREF   2 Piece "^" delimited string containing
 ;
 ;                 1  Pointer to file #757.01
 ;                 2  Display Text (Expression)
 ;                 
 ;              or  -1 ^ Error Message
 ;              
 Q $$EXP^LEXCODE($G(CODE),$G(SAB),$G(CDT))
