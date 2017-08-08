LEXU6 ;ISL/KER - Miscellaneous Lexicon Utilities ;05/23/2017
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
SC(LEX,LEXS,LEXVDT) ; Filter by Semantic Class
 ;
 ; Input
 ;
 ;    LEX      IEN of file 757.01
 ;    LEXS     Filter
 ;    LEXVDT   Date to use for screening by codes
 ;
 ; Output
 ;
 ;    $$SC     1/0
 ;
 N LEXINC,LEXEXC,LEXIC,LEXEC,LEXRREC,X D VDT^LEXU
 S LEXRREC=LEX Q:'$D(^LEX(757.01,LEXRREC,0)) 0
 I $L(LEXS,";")=3,$P(LEXS,";",3)'="" D  Q:+LEXINC>0 LEXINC
 . S LEXINC=0 S LEXINC=$$SO(LEXRREC,$P(LEXS,";",3),$G(LEXVDT))
 S LEXRREC=$P(^LEX(757.01,LEXRREC,1),U,1)
 S LEXINC=0 F LEXIC=1:1:$L($P(LEXS,";",1),"/") D
 . N LEXP,LEX1,LEX2 S LEXP=$P($P(LEXS,";",1),"/",LEXIC)
 . S LEX1=$D(^LEX(757.1,"AMCC",LEXRREC,LEXP))
 . S LEX2=$D(^LEX(757.1,"AMCT",LEXRREC,LEXP))
 . I LEX1!(LEX2) D
 . . S LEXINC=1,LEXIC=$L($P(LEXS,";",1),"/")+1
 I LEXINC=0!($P(LEXS,";",2)="") K LEXIC,LEXS,LEXEC Q LEXINC
 S LEXEXC=0 F LEXEC=1:1:$L($P(LEXS,";",2),"/") D
 . N LEXP,LEX1,LEX2 S LEXP=$P($P(LEXS,";",2),"/",LEXEC)
 . S LEX1=$D(^LEX(757.1,"AMCC",LEXRREC,LEXP))
 . S LEX2=$D(^LEX(757.1,"AMCT",LEXRREC,LEXP))
 . I LEX1!(LEX2) D
 . . S LEXEXC=1,LEXEC=$L($P(LEXS,";",2),"/")+1
 I LEXINC,'LEXEXC K LEXIC,LEXS,LEXEC Q 1
 K LEXIC,LEXS,LEXEC
 Q 0
SO(LEX,LEXS,LEXVDT) ; Filter by Source
 ;
 ; Input
 ; 
 ;    LEX      IEN of file 757.01
 ;    LEXS     Filter
 ;    LEXVDT   Date to use for screening by codes
 ;
 ; Output
 ;
 ;    $$SO     1/0
 ;
 N LEXABR,LEXCR,LEXF,LEXMC,LEXMCE,LEXN0,LEXSAB,LEXSO,LEXSR,LEXSTA,LEXTR
 S LEXTR=+LEX,LEXF=0 Q:'$D(^LEX(757.01,LEXTR,0)) LEXF
 Q:'$D(^LEX(757.01,LEXTR)) LEXF
 S LEXMC=$P(^LEX(757.01,LEXTR,1),U,1)
 S LEXMCE=+(^LEX(757,+($P(^LEX(757.01,LEXTR,1),U,1)),0))
 D VDT^LEXU I LEXTR>0,LEXMCE>0,LEXTR=LEXMCE D  G SOQ
 . S LEXF=0 F LEXSR=1:1:$L(LEXS,"/") D  Q:LEXF>0
 . . S LEXABR=$P(LEXS,"/",LEXSR),LEXCR=0
 . . F  S LEXCR=$O(^LEX(757.02,"AMC",LEXMC,LEXCR)) Q:+LEXCR=0  D  Q:LEXF>0
 . . . N LEXN0,LEXSAB,LEXQ S LEXQ=0
 . . . S LEXN0=$G(^LEX(757.02,LEXCR,0))
 . . . S LEXSAB=+($P(LEXN0,U,3)),LEXSO=$P(LEXN0,U,2)
 . . . I $G(LEXLKT)["BC" D  Q:LEXQ
 . . . . N LEXNAR S LEXNAR=$G(^TMP("LEXSCH",$J,"NAR",0))
 . . . . I $L($G(LEXNAR)) S:$E(LEXSO,1,$L($G(LEXNAR)))'=$G(LEXNAR) LEXQ=1
 . . . S LEXSTA=$$STATCHK^LEXSRC2(LEXSO,$G(LEXVDT),,LEXSAB)
 . . . Q:+LEXSTA'>0  Q:$P(LEXSTA,U,2)'=LEXCR
 . . . Q:'$D(^LEX(757.03,LEXSAB,0))
 . . . S LEXSAB=$E(^LEX(757.03,LEXSAB,0),1,3)
 . . . I LEXSAB=LEXABR S LEXF=1
SOQ ; Quit Source Filter
 K LEXCR,LEXMC,LEXMCE,LEXN0,LEXSAB,LEXABR,LEXSO,LEXSR,LEXSTA,LEXTR
 Q LEXF
SOS(X,ARY,SYN) ; Sources for Expression
 ;
 ; Input
 ;          X     Internal Entry Number Expression file #757.01
 ;          .ARY  Local Array Name passed by Reference
 ;          SYN   Include codes mapped via a Synonym
 ;          
 ; Output
 ;          ARY(IEN)    IEN is from file #757.01 (same as X)
 ;          ARY(IEN,0)  Number of Codes Found
 ;          ARY(IEN,#)  # is a sequence number
 ;              
 ;            Equals an 13 Piece "^" delimited string
 ;                        
 ;              1   Code
 ;              2   Coding System Nomenclature
 ;              3   Coding System Source Abbreviation
 ;              4   Code Status
 ;              5   Code Active Date
 ;              6   Code Inactive Date
 ;              7   Expression Status
 ;              8   Expression Active Date
 ;              9   Expression Inactive Date
 ;             10   Expression Variable Pointer
 ;             11   Code Variable Pointer
 ;             12   Coding System Variable Pointer
 ;             13   National File Variable Pointer (if it exist)
 ;              
 ;          Array has two indexes
 ;          
 ;          ARY(IEN,"B",(CODE_" "),#)=Code_"^"_Nomenclature
 ;          ARY(IEN,"C",SOURCE,#)=Code_"^"_Nomenclature
 ;
 N LEXCT,LEXCIEN,LEXEIEN,LEXI,LEXSIEN,LEXSF S LEXCT=0,(LEXCIEN,LEXEIEN)=+($G(X)) Q:+LEXEIEN'>0 0
 Q:'$D(^LEX(757.01,+($G(LEXEIEN)),0)) 0  K ARY(LEXCIEN)
 Q:'$D(^LEX(757.01,+LEXEIEN,0)) 0  Q:'$D(^LEX(757.02,"B",+LEXEIEN)) 0  S LEXSIEN=0,LEXSF=+($G(SYN))
 ;  Codes for an Expression
 I +LEXSF'>0 D
 . S LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.02,"B",+LEXEIEN,LEXSIEN)) Q:+LEXSIEN'>0  D SOSE
 ;  Codes for an Major Concept
 I +LEXSF>0 D
 . N LEXTMIEN S LEXTMIEN=+($G(^LEX(757.01,+LEXEIEN,1))) S LEXSIEN=0
 . F  S LEXSIEN=$O(^LEX(757.02,"AMC",+LEXTMIEN,LEXSIEN)) Q:+LEXSIEN'>0  D
 . . S LEXEIEN=+($G(^LEX(757.02,+LEXSIEN,0))) D SOSE
 S (LEXI,LEXCT)=0 F  S LEXI=$O(ARY(LEXCIEN,LEXI)) Q:+LEXI'>0  S LEXCT=LEXCT+1 S ARY(+LEXCIEN,0)=LEXCT
 K ARY(LEXCIEN,"D") S X=LEXCT S:+LEXCT>0 ARY(+LEXCIEN,0)=LEXCT
 Q X
SOSE ; Build array of Sources for Expression
 N LEXACT,LEXCVP,LEXEVP,LEXEXA,LEXEXI,LEXEXS,LEXINA,LEXNAT,LEXNIEN,LEXNOM,LEXNUM,LEXO,LEXSAB,LEXSO,LEXSRC,LEXSTA,LEXSVP
 S (LEXNAT,LEXEVP,LEXCVP,LEXSVP)="",LEXSO=$G(^LEX(757.02,+LEXSIEN,0)),LEXSRC=$P(LEXSO,"^",3)
 S LEXSAB=$P($G(^LEX(757.03,+LEXSRC,0)),"^",1) Q:'$L(LEXSAB)  S LEXNOM=$P($G(^LEX(757.03,+LEXSRC,0)),"^",2) Q:'$L(LEXNOM)
 S LEXSO=$P(LEXSO,"^",2) Q:$E(LEXSO,1,4)="U000"  S:+($G(LEXEIEN))>0 LEXEVP=+($G(LEXEIEN))_";LEX(757.01,"
 S:+($G(LEXSIEN))>0 LEXCVP=+($G(LEXSIEN))_";LEX(757.02," S:+($G(LEXSRC))>0 LEXSVP=+($G(LEXSRC))_";LEX(757.03,"
 I LEXSRC=1!(LEXSRC=30) S LEXNIEN=$$CODEN^ICDEX(LEXSO,80) S:+LEXNIEN>0 LEXNAT=+LEXNIEN_";ICD9("
 I LEXSRC=2!(LEXSRC=31) S LEXNIEN=$$CODEN^ICDEX(LEXSO,80.1) S:+LEXNIEN>0 LEXNAT=+LEXNIEN_";ICD0("
 I LEXSRC=3!(LEXSRC=4) S LEXNIEN=$$CODEN^ICPTCOD(LEXSO) S:+LEXNIEN>0 LEXNAT=+LEXNIEN_";ICPT("
 S LEXSTA=$$SOAI(LEXSO,LEXSRC),LEXACT=$P(LEXSTA,"^",2),LEXINA=$P(LEXSTA,"^",3),LEXSTA=+$P(LEXSTA,"^",1)
 S LEXEXA=$$EXAI(LEXSIEN),LEXEXS=+($P(LEXEXA,"^",1)),LEXEXI=$P(LEXEXA,"^",3),LEXEXA=$P(LEXEXA,"^",2)
 S LEXO=LEXSO_"^"_LEXNOM_"^"_LEXSAB S:$L($G(LEXSTA)) $P(LEXO,"^",4)=$G(LEXSTA)
 S:$L($G(LEXACT)) $P(LEXO,"^",5)=$G(LEXACT) S:$L($G(LEXINA)) $P(LEXO,"^",6)=$G(LEXINA)
 S:$L($G(LEXEXS)) $P(LEXO,"^",7)=$G(LEXEXS) S:$L($G(LEXEXA)) $P(LEXO,"^",8)=$G(LEXEXA)
 S:$L($G(LEXEXI)) $P(LEXO,"^",9)=$G(LEXEXI) S:$L($G(LEXEVP)) $P(LEXO,"^",10)=$G(LEXEVP)
 S:$L($G(LEXCVP)) $P(LEXO,"^",11)=$G(LEXCVP) S:$L($G(LEXSVP)) $P(LEXO,"^",12)=$G(LEXSVP)
 S:$L($G(LEXNAT)) $P(LEXO,"^",13)=$G(LEXNAT)
 S LEXNUM=$O(ARY(LEXCIEN,"D",LEXSIEN," "),-1)
 S:LEXNUM'>0 LEXNUM=$O(ARY(LEXCIEN,"B",(LEXSO_" "),0))
 S:LEXNUM'>0 LEXNUM=$O(ARY(LEXCIEN," "),-1)+1
 S:'$D(ARY(LEXCIEN,+LEXNUM)) LEXCT=LEXCT+1
 S ARY(LEXCIEN,+LEXNUM)=LEXO,ARY(LEXCIEN,"D",LEXSIEN,LEXNUM)=""
 S ARY(LEXCIEN,"B",(LEXSO_" "),LEXNUM)=LEXSO_"^"_LEXNOM,ARY(LEXCIEN,"C",+LEXSRC,LEXNUM)=LEXSO_"^"_LEXNOM
 Q
SOAI(X,Y) ; Source Status, Activation and Inactivation
 N LEXACT,LEXEF,LEXINA,LEXSIEN,LEXSO,LEXSRC,LEXSTA S LEXSO=$G(X),LEXSRC=+($G(Y))
 Q:'$L(LEXSO) ""  Q:+LEXSRC'>0 ""  Q:'$D(^LEX(757.03,+LEXSRC,0)) ""  S (LEXSTA,LEXACT,LEXINA)=""
 S LEXEF="" F  S LEXEF=$O(^LEX(757.02,"ACT",(LEXSO_" "),3,LEXEF)) Q:'$L(LEXEF)  D
 . N LEXSIEN S LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.02,"ACT",(LEXSO_" "),3,LEXEF,LEXSIEN)) Q:+LEXSIEN'>0  D
 . . Q:$P($G(^LEX(757.02,+LEXSIEN,0)),"^",3)'=+LEXSRC  S:'$L(LEXACT)!(LEXEF<LEXACT) LEXACT=LEXEF
 S LEXEF="" F  S LEXEF=$O(^LEX(757.02,"ACT",(LEXSO_" "),2,LEXEF)) Q:'$L(LEXEF)  D
 . N LEXSIEN S LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.02,"ACT",(LEXSO_" "),2,LEXEF,LEXSIEN)) Q:+LEXSIEN'>0  D
 . . Q:$P($G(^LEX(757.02,+LEXSIEN,0)),"^",3)'=+LEXSRC  S:'$L(LEXINA)!(LEXEF>LEXINA) LEXINA=LEXEF
 S:+($G(LEXACT))'>+($G(LEXINA)) LEXSTA=0 S:+($G(LEXACT))>+($G(LEXINA)) LEXINA="",LEXSTA=1
 S X=LEXSTA_"^"_LEXACT_"^"_LEXINA
 Q X
EXAI(X) ; Expression Activation and Inactivation
 N LEXACT,LEXEF,LEXINA,LEXSIEN,LEXSTA S LEXSIEN=$G(X) Q:+LEXSIEN'>0 ""  S (LEXSTA,LEXACT,LEXINA)=""
 S LEXEF="" F  S LEXEF=$O(^LEX(757.02,+($G(LEXSIEN)),4,"B",LEXEF)) Q:'$L(LEXEF)  D
 . N LEXHIS S LEXHIS=0 F  S LEXHIS=$O(^LEX(757.02,+($G(LEXSIEN)),4,"B",LEXEF,LEXHIS)) Q:+LEXHIS'>0  D
 . . N LEXDT,LEXND,LEXST S LEXND=$G(^LEX(757.02,+($G(LEXSIEN)),4,+LEXHIS,0)),LEXST=$P(LEXND,"^",2),LEXDT=$P(LEXND,"^",1)
 . . S:LEXST=1&(+($G(LEXDT))>+($G(LEXACT))) LEXACT=+($G(LEXDT)) S:LEXST=0&(+($G(LEXDT))>+($G(LEXINA))) LEXINA=+($G(LEXDT))
 S:+($G(LEXACT))'>+($G(LEXINA)) LEXSTA=0 S:+($G(LEXACT))>+($G(LEXINA)) LEXINA="",LEXSTA=1 S X=LEXSTA_"^"_LEXACT_"^"_LEXINA
 Q X
EXM(X,LEX,LEXD,LEXM) ; Exact Match
 ;
 ; Input
 ;
 ;    X         Text to Search for (required)
 ;    LEX       Local Array Passed by Reference (will be killed)
 ;    LEXD      Boolean Flag - Deactivated Terms (optional)
 ;                1  Include deactivated terms
 ;                0  Do not include deactivated terms (default)
 ;    LEXM      Boolean Flag - Major Concepts (optional)
 ;                1  Include Major Concepts ONLY
 ;                0  Include all (default); Major Concepts, Synonyms, 
 ;                     Lexical Variants and Fully Specified Names
 ;               
 ; Output
 ; 
 ;    $$EXM     Number of exact matches found
 ;    LEX       Ouput Local Array Passed by Reference
 ;    
 ;                LEX(0)   2 piece "^" dilimited string
 ;                            1   Total Exact Matches found
 ;                            2   Text Searched for
 ;                            
 ;                LEX(#)   5 piece "^" dilimited string
 ;                            1   IEN of Exact Match Expression
 ;                            2   IEN of Major Concept for Expression
 ;                            3   Type of Exact Match Expression (internal)
 ;                            4   Deactivation Flag (internal)
 ;                            5   Type of Exact Match Expression (external)
 ;                            
 K LEX N LEXCTL,LEXIEN,LEXINC,LEXMCO,LEXORD,LEXORG,LEXTXT,LEXCT
 S LEXORG=$G(X),LEXTXT=$$UP^XLFSTR(LEXORG) Q:$L(LEXTXT)<2 ""  S LEXCTL=$E(LEXTXT,1,62),LEXCT=0
 S LEXINC=+($G(LEXD)),LEXMCO=+($G(LEXM)),LEXORD=$E(LEXCTL,1,($L(LEXCTL)-1))_$C($A($E(LEXCTL,$L(LEXCTL)))-1)_"~"
 F  S LEXORD=$O(^LEX(757.01,"B",LEXORD)) Q:'$L(LEXORD)  Q:$E(LEXORD,1,$L(LEXCTL))'=LEXCTL  D
 . N LEXIEN S LEXIEN=0 F  S LEXIEN=$O(^LEX(757.01,"B",LEXORD,LEXIEN)) Q:+LEXIEN'>0  D
 . . N LEXTY,LEXDF,LEXEXP,LEXMC,LEXTN,LEXI S LEXEXP=$G(^LEX(757.01,+LEXIEN,0)) Q:$$UP^XLFSTR(LEXEXP)'=LEXTXT
 . . S LEXTY=$P($G(^LEX(757.01,+LEXIEN,1)),"^",2),LEXDF=$P($G(^LEX(757.01,+LEXIEN,1)),"^",5)
 . . Q:LEXTY'=1&(+($G(LEXMCO))>0)  Q:LEXDF>0&(+($G(LEXINC))'>0)
 . . S LEXTN=$S(LEXTY=1:"Major Concept",LEXTY=3:"Lexical Variant",LEXTY=8:"Fully Specified Name",1:"Synonym")
 . . S:LEXDF>0 LEXTN="Deactivated "_LEXTN S LEXMC=+($P($G(^LEX(757.01,+LEXIEN,1)),"^",1))
 . . S LEXI=$O(LEX(" "),-1)+1,LEX(LEXI)=LEXIEN_"^"_LEXMC_"^"_LEXTY_"^"_LEXDF_"^"_LEXTN,LEX(0)=LEXI_"^"_LEXORG
 I LEXINC>0 D
 . S LEXINC=+($G(LEXD)),LEXMCO=+($G(LEXM)),LEXORD=$E(LEXCTL,1,($L(LEXCTL)-1))_$C($A($E(LEXCTL,$L(LEXCTL)))-1)_"~"
 . F  S LEXORD=$O(^LEX(757.01,"ADTERM",LEXORD)) Q:'$L(LEXORD)  Q:$E(LEXORD,1,$L(LEXCTL))'=LEXCTL  D
 . . N LEXIEN S LEXIEN=0 F  S LEXIEN=$O(^LEX(757.01,"ADTERM",LEXORD,LEXIEN)) Q:+LEXIEN'>0  D
 . . . N LEXTY,LEXDF,LEXEXP,LEXMC,LEXTN,LEXI S LEXEXP=$G(^LEX(757.01,+LEXIEN,0)) Q:$$UP^XLFSTR(LEXEXP)'=LEXTXT
 . . . S LEXTY=$P($G(^LEX(757.01,+LEXIEN,1)),"^",2),LEXDF=$P($G(^LEX(757.01,+LEXIEN,1)),"^",5)
 . . . Q:LEXTY'=1&(+($G(LEXMCO))>0)  Q:LEXDF>0&(+($G(LEXINC))'>0)
 . . . S LEXTN=$S(LEXTY=1:"Major Concept",LEXTY=3:"Lexical Variant",LEXTY=8:"Fully Specified Name",1:"Synonym")
 . . . S:LEXDF>0 LEXTN="Deactivated "_LEXTN S LEXMC=+($P($G(^LEX(757.01,+LEXIEN,1)),"^",1))
 . . . S LEXI=$O(LEX(" "),-1)+1,LEX(LEXI)=LEXIEN_"^"_LEXMC_"^"_LEXTY_"^"_LEXDF_"^"_LEXTN,LEX(0)=LEXI_"^"_LEXORG
 S X=+($G(LEX(0)))
 Q X
